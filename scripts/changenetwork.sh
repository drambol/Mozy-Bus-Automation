#!/bin/bash
# Script to change network for sync client
# See help output below for details

showhelp() {
    cat <<EOF
changenetwork.sh [-x] [-n NETWORKNAME] [-t] [-e]

Script to configure sync client to point to a Mozy network
Use -n to specify the network, e.g. production, staging, st2, qa5
Use -t to configure MozyNext client instead of Mozy Sync. Ignored on Linux.
Use -e to set the network via environmental variables
Use -c to specify a codename, e.g. bds
Use -x to execute the network change.  Otherwise the output shows the
commands needed to do the change but they are not actually executed

Use -p to enable a local port to respond to commands.  default is 4883
EOF
}

NETWORK=DEFAULT
MOZYNEXT=0

#Also  enable a listening port for sending commands from mozytutil
#This is not related to network but useful for internal usage, e.g.
#when running automation.  0 means no listening port
CLIENTPORT=4883

#Seperate port for MozyNext builds so that they can be installed side by side
CLIENTPORT_NEXT=4884

if [ $(uname) = 'Darwin' ]; then
    CONFIG_MECHANISM=DEFAULTS
elif [ $(uname) = 'Linux' ]; then
    CONFIG_MECHANISM=CONFIG
else
    CONFIG_MECHANISM=REGISTRY
fi

while getopts "en:txhp:c:" opt; do
    case "$opt" in
        n) NETWORK=$OPTARG
            ;;
        p) CLIENTPORT=$OPTARG
            ;;
        t) MOZYNEXT=1
            ;;
        x) #By default just print out the commands
            EXECUTE=1
            ;;
        e) #Force the output of the environmental variables
            CONFIG_MECHANISM=ENV
            ;;
        c) CODENAME=$OPTARG
            ;;
        h | *) showhelp
            exit 1;
            ;;
    esac
done

shift $((OPTIND-1))


# We have two different clients on Mac and Windows.
# Either of them can connect to any network, but they default to
# production and staging.  If no network specified
# then show how to return to the default.
if [ "$NETWORK" = "DEFAULT" ] ; then
    if [ "$MOZYNEXT" = "1" ] ; then
        NETWORK=staging
    else
        NETWORK=production
    fi
fi

if [ "$MOZYNEXT" = "1" ] ; then
    DOMAIN=mozynextsync
    CLIENTPORT=$CLIENTPORT_NEXT

    #By default MozyNext builds use MozyNext codename
    #which doesn't work when connecting to other networks
    if [ "$CODENAME" = "" ] ; then
        if [ "$NETWORK" = "staging" ] ; then
            CODENAME=MozyNext
        else
            CODENAME=bds
        fi
    fi
else
    DOMAIN=mozysync
fi


# This is the core of the script - where we encode all the network info
# Please update it with info about other functional QA networks and
# keep this info in sync with https://redmine.mozycorp.com/projects/stash/wiki/QA_Networks

case $(echo $NETWORK | tr [:upper:] [:lower:]) in
    "production" | "prod" )
        AUTH=auth2.mozy.com
        BUS=client.mozy.com
        TRITON=triton.mozy.com
        VERIFY_SSL=1
        ;;
    "staging" | "std1" )
        AUTH=auth.test.mozy.com
        BUS=bus.test.mozypro.com
        TRITON=std1.triton.mozy.com
        VERIFY_SSL=1
        ;;
    "st2" | "pantheon" )
        AUTH=auth.st2.mozy.com
        BUS=client.st2.mozy.com
        TRITON=triton.st2.mozy.com
        VERIFY_SSL=1
        ;; 
    "qa5" )
        AUTH=auth01.qa5.mozyops.com
        TRITON=tds02.qa5.mozyops.com
        BUS=web04.qa5.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa9" )
        AUTH=auth01.qa9.mozyops.com
        TRITON=tds03.qa9.mozyops.com
        BUS=10.29.73.74
        VERIFY_SSL=0
        ;;
    "qa6_busclient04" )
        AUTH=auth01.qa6.mozyops.com
        TRITON=tds01.qa6.mozyops.com
        BUS=busclient04.qa6.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa6_busclient06" )
        AUTH=auth01.qa6.mozyops.com
        TRITON=tds01.qa6.mozyops.com
        BUS=busclient06.qa6.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa6_busclient01" )
        AUTH=auth01.qa6.mozyops.com
        TRITON=tds01.qa6.mozyops.com
        BUS=busclient01.qa6.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa12h" )
        AUTH=auth01.qa12h.mozyops.com
        TRITON=tds01.q12a.mozyops.com
        BUS=busclient02.qa12h.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa12h_busclient01" )
        AUTH=auth01.qa12h.mozyops.com
        TRITON=tds01.q12a.mozyops.com
        BUS=busclient01.qa12h.mozyops.com
        VERIFY_SSL=0
        ;;
    "qa13" )
        AUTH=auth01.qa13.mozyops.com
        TRITON=tds04.qa13.mozyops.com
        BUS=bus.qa13.mozyops.com
        VERIFY_SSL=0
        ;;
    *)
        echo Unsupported network.  Supported options include production, staging, qa5 etc
        exit 1
        ;;
esac

# Now apply the changes

if [ "$CONFIG_MECHANISM" = "REGISTRY" ] ; then
    CONFIG_REG=HKCU\\Software\\${DOMAIN}\\config

    if [ $EXECUTE ] ; then
        REG ADD $CONFIG_REG -f -v mozy.authhost -t REG_SZ -d $AUTH
        REG ADD $CONFIG_REG -f -v mozy.bushost -t REG_SZ -d $BUS
        REG ADD $CONFIG_REG -f -v mozy.tritonhost -t REG_SZ -d $TRITON

        REG ADD $CONFIG_REG -f -v msync.clientport -t REG_DWORD -d $CLIENTPORT
        REG ADD $CONFIG_REG -f -v ssl.verifyhostname -t REG_DWORD -d $VERIFY_SSL
        REG ADD $CONFIG_REG -f -v ssl.verifypeercertificate -t REG_DWORD -d $VERIFY_SSL

        if [ "$CODENAME" != "" ] ; then
            REG ADD $CONFIG_REG -f -v mozy.codename -t REG_SZ -d $CODENAME
        fi

        echo Results after change
        REG QUERY $CONFIG_REG
    else
        #Generate commands that would work from windows command prompt or in a .bat file.
        #Warning - you can't run the commands we output in the windows bash shell
        #because of the escaping.  All instances of "\" have to be replaced by "\\"
        echo -e "\nREM Run these commands in Windows command prompt to change $DOMAIN network to $NETWORK"
        echo REG ADD $CONFIG_REG -f -v mozy.authhost -t REG_SZ -d $AUTH
        echo REG ADD $CONFIG_REG -f -v mozy.bushost -t REG_SZ -d $BUS
        echo REG ADD $CONFIG_REG -f -v mozy.tritonhost -t REG_SZ -d $TRITON

        echo REG ADD $CONFIG_REG -f -v msync.clientport -t REG_DWORD -d $CLIENTPORT
        echo REG ADD $CONFIG_REG -f -v ssl.verifyhostname -t REG_DWORD -d $VERIFY_SSL
        echo REG ADD $CONFIG_REG -f -v ssl.verifypeercertificate -t REG_DWORD -d $VERIFY_SSL

        if [ "$CODENAME" != "" ] ; then
            echo REG ADD $CONFIG_REG -f -v mozy.codename -t REG_SZ -d $CODENAME
        fi
    fi
elif [ "$CONFIG_MECHANISM" = "DEFAULTS" ] ; then
    if [ $EXECUTE ] ; then
        defaults write com.mozy.$DOMAIN configvars -dict-add mozy.authhost $AUTH
        defaults write com.mozy.$DOMAIN configvars -dict-add mozy.bushost $BUS
        defaults write com.mozy.$DOMAIN configvars -dict-add mozy.tritonhost $TRITON

        defaults write com.mozy.$DOMAIN configvars -dict-add msync.clientport $CLIENTPORT
        defaults write com.mozy.$DOMAIN configvars -dict-add ssl.verifyhostname $VERIFY_SSL
        defaults write com.mozy.$DOMAIN configvars -dict-add ssl.verifypeercertificate $VERIFY_SSL

        if [ "$CODENAME" != "" ] ; then
            defaults write com.mozy.$DOMAIN configvars -dict-add mozy.codename $CODENAME
        fi

        echo Results after change
        defaults read com.mozy.$DOMAIN configvars
    else
        echo -e "\n#Execute the following commands to change $DOMAIN network to $NETWORK"
        echo defaults write com.mozy.$DOMAIN configvars -dict-add mozy.authhost $AUTH
        echo defaults write com.mozy.$DOMAIN configvars -dict-add mozy.bushost $BUS
        echo defaults write com.mozy.$DOMAIN configvars -dict-add mozy.tritonhost $TRITON

        echo defaults write com.mozy.$DOMAIN configvars -dict-add msync.clientport $CLIENTPORT
        echo defaults write com.mozy.$DOMAIN configvars -dict-add ssl.verifyhostname $VERIFY_SSL
        echo defaults write com.mozy.$DOMAIN configvars -dict-add ssl.verifypeercertificate $VERIFY_SSL
        if [ "$CODENAME" != "" ] ; then
            echo defaults write com.mozy.$DOMAIN configvars -dict-add mozy.codename $CODENAME
        fi
    fi
elif [ "$CONFIG_MECHANISM" = "ENV" ] ; then
    # For linux backup the configuration file is the best way to set these permanently.
    # but environmental variables can be used as long as these commands are run in the shell before
    # invoking the backup daemon.
    if [ $EXECUTE ] ; then
        # We execute the provided program in a shell that contains the network environmental variables
        # Example usage:
        # changenetwork.sh -x -e -n QA13 -- echo $MOZY_TRITONHOST
        export MOZY_AUTHHOST=$AUTH
        export MOZY_BUSHOST=$BUS
        export MOZY_TRITONHOST=$TRITON

        #Note: in normal compilation, the linux backup client does not
        #use this variable. It uses the file referenced by mozybackup.clientsock instead
        export MSYNC_CLIENTPORT=$CLIENTPORT

        export SSL_VERIFYHOSTNAME=$VERIFY_SSL
        export SSL_VERIFYPEERCERTIFICATE=$VERIFY_SSL

        if [ "$CODENAME" != "" ] ; then
            export MOZY_CODENAME=$CODENAME
        fi

        PROGRAM="$1"
        shift
        exec "$PROGRAM" $@
    else
        echo -e "\n#Execute the following commands to set env variables pointing to $NETWORK"
        echo export MOZY_AUTHHOST=$AUTH
        echo export MOZY_BUSHOST=$BUS
        echo export MOZY_TRITONHOST=$TRITON
        echo export MSYNC_CLIENTPORT=$CLIENTPORT
        echo export SSL_VERIFYHOSTNAME=$VERIFY_SSL
        echo export SSL_VERIFYPEERCERTIFICATE=$VERIFY_SSL
        if [ "$CODENAME" != "" ] ; then
            echo export MOZY_CODENAME=$CODENAME
        fi
    fi
elif [ "$CONFIG_MECHANISM" = "CONFIG" ] ; then

    #starting with 1.0.8 we can leave the /etc/mozybackup.conf file alone and create simple override file
    CONF_PATH="/etc/mozybackup.conf.d/network.conf"

    if [ "$MOZYNEXT" = "1" ] ; then
        echo Warning: On Linux MozyNext build uses same config files as
        echo other builds so the -t argument is not meaningful.
    fi
    #Not setting msync.clientport because linux backup uses udsport instead

    if [ $EXECUTE ] ; then
        echo Writing config to $CONF_PATH

        cat > $CONF_PATH <<- _EOF_
        #Generated by changenetwork.sh
        mozy.authhost=$AUTH
        mozy.bushost=$BUS
        mozy.tritonhost=$TRITON
        ssl.verifyhostname=$VERIFY_SSL
        ssl.verifypeercertificate=$VERIFY_SSL
_EOF_
        if [ "$CODENAME" != "" ] ; then
            echo mozy.codename=$CODENAME >> $CONF_PATH
        fi
    else
        echo "#Add the following lines to $CONF_PATH or /etc/mozybackup.conf"
        echo mozy.authhost=$AUTH
        echo mozy.bushost=$BUS
        echo mozy.tritonhost=$TRITON
        echo ssl.verifyhostname=$VERIFY_SSL
        echo ssl.verifypeercertificate=$VERIFY_SSL
        if [ "$CODENAME" != "" ] ; then
            echo mozy.codename=$CODENAME
        fi
    fi
fi
