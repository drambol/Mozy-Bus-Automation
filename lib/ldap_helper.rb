require 'net-ldap'
module LDAPHelper
  USER = AD_CONNECTION_ENV['bind_username']
  PASSWORD = AD_CONNECTION_ENV['bind_password']
  HOST = AD_CONNECTION_ENV['server_host']
  PORT = AD_CONNECTION_ENV['port']
  TREEBASE = AD_CONNECTION_ENV['base_dn']
  EMAIL_POSTFIX = '@test.com'
  @ldap_user_mail = ''

  # Public: Add user to the AD server with username (cn) and email
  #
  def add_user(user_name, mail = nil, host=nil, user=nil, password=nil, treebase=nil, email_postfix=nil)
    user_name = check_for_random(user_name)
    @ldap_user_mail = check_for_random_mail(mail, user_name, email_postfix)
    dn = "CN=#{user_name}, #{treebase || TREEBASE}"
    attr = {
        :cn => "#{user_name}",
        :objectclass => ['top', 'person', 'user', 'organizationalPerson'],
        :sn => "#{user_name}",
        :name => "#{user_name}",
        :givenname => "#{user_name}",
        :displayname => "#{user_name}",
        :mail => @ldap_user_mail || "#{user_name}#{email_postfix || EMAIL_POSTFIX}",
       # :uid => '335',
        :userprincipalname =>@ldap_user_mail || "#{user_name}#{email_postfix || EMAIL_POSTFIX}",
        :useraccountcontrol => '66080',
        :samaccountname => "#{user_name}",
    }
    attr[:uid] = "123_#{Time.now.strftime("%Y%m%d%H%M")}"
    ldap = Net::LDAP.new :host => host || HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => user || USER,
                             :password => password || PASSWORD
                         }

    ldap.open do |ldap|
      ldapLog("Begin to create AD user")
      ldapLog("dn is:" + dn.to_s)
      ldapLog("attributes are:" + attr.to_s)
      ldap.add(:dn => dn, :attributes => attr)
      ldapLog("LDAP User creation result is:" + ldap.get_operation_result.to_s)
      #Log.debug ldap.get_operation_result)
    end
    #Log.debug("add a user #{user_name} to AD")
    ldapLog("add a user #{user_name} to AD")
  end

  # Public: delete a user in AD by username
  #
  def delete_user(user_name)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldapLog("Begin to delete AD user")
      ldapLog("dn is:" + dn.to_s)
      ldap.delete :dn => dn
      Log.debug ldap.get_operation_result
    end
    Log.debug("delete a user #{user_name} to AD")
  end

  # Public: Update a user's attribute
  #
  # Example
  #   LDAPHelper.update_user('dev_test1', 'mail', 'gsmith@qa5.mozyops.net')
  def update_user(user_name, attribute, value)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.replace_attribute(dn, attribute, value)
    end
    Log.debug("update a user #{user_name} to AD: #{user_name}, #{attribute}, #{value}")
  end

  # Public: show a user's detail
  # Return: return nil if no user found; return the user entry array if found user match the user_name if ADFS server
  #
  def show_user(user_name)
    dn = "cn=#{user_name}, #{TREEBASE}"
    user_entry = []
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
      ldap.search(:base => TREEBASE, :filter => Net::LDAP::Filter.eq('cn', "#{user_name}")) do |entry|
        puts "DN: #{entry.dn}"
        user_entry << entry
        entry.each do |attribute, values|
          puts "   #{attribute}:"
          values.each do |value|
            puts "      --->#{value}"
          end
        end
      end
    end
    Log.debug("show a user #{user_name} in AD")
    (user_entry.empty?)? nil : user_entry
  end

  # Public: modify a rdn
  #
  # can not use the rename functions, sucks, So I have to use another way, delete it and then add it
  def modify_rdn(user_name, new_name, user)
    dn = "cn=#{user_name}, #{TREEBASE}"
    ldap = Net::LDAP.new :host => HOST,
                         :port => PORT,
                         :auth => {
                             :method => :simple,
                             :username => USER,
                             :password => PASSWORD
                         }
    ldap.open do |ldap|
 #     p ldap.rename(:olddn => dn, :newrdn => "cn=#{new_name}")
      delete_user(user_name)
      add_user(new_name, "#{user}")
    end
    Log.debug("rename user #{user} from #{user_name} to #{new_name} in AD")
  end

  def check_for_random(username)
    if username.match("First Last")
      username = "#{Forgery::Name.first_name} #{Forgery(:basic).password(:at_least => 9, :at_most => 12)}"
      return username
    end
    return username
  end

  def check_for_random_mail(mail, username, emailpostfix)
    unless mail.nil?
      if mail.match("email@mozy.com")
        mail = "#{username.gsub(/\s+/, "")}#{emailpostfix}"
      end
      return mail
    end
  end

  def ldap_user_mail
    @ldap_user_mail
  end

  def ldapLog(text)
    $logFile.puts("======[LDAP Log] " + text.to_s + "======\n") if $logFile
  end

end
