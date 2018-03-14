require File.expand_path('../../test_sites/configs/configs_helper', __FILE__)
require File.expand_path('../../lib/ldap_helper', __FILE__)
include LDAPHelper
require 'logger'
require 'forgery'

Log = Logger.new(STDOUT)
Log.level = Logger::DEBUG

p "default password: #{PASSWORD}, default email postfix: #{EMAIL_POSTFIX}"


# add user in prod ldap server for @TC.125983 for std and prod if not existed
# run this in public network instead of EMC internal network as EMC network cannot connect to external server by port 389, e.g. connect your mobile phone shared network to run this script
 1.upto(3) {|x| add_user(user_name = "pullpostqa#{x.to_s}" , mail = "pullpostqa#{x.to_s}+#{Time.now.strftime("%Y%m%d%H%M")}@test.com") unless show_user("pullpostqa#{x.to_s}")}
 add_user(user_name = "pullpostqa4", mail="pullpostqa4@adfs.mozy.com") unless show_user("pullpostqa4")


# example for add a user with random username and email prefix, fixed email postfix
#add_user(user_name = 'First Last' , mail = 'email@mozy.com', nil,nil,nil,nil,email_postfix = '@testemail.com')

# example for add a user with default email and email postfix
#add_user(user_name = 'HarryPotter')

# example for add a user with emc email address to test email receiving
#1.upto(3) {|x| add_user(user_name = "Harry Potter #{x.to_s}" , mail = "harry.potter#{x.to_s}+#{Time.now.strftime("%Y%m%d%H%M")}@emc.com")}

# example for add a user with uid to test fixed attribute
#add_user(user_name = 'LdapTest',nil,nil,nil,nil,nil,nil, uid = '334')
#show_user(user_name = 'LdapTest')