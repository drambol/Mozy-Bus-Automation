Then /^I will see the user account page$/ do
  @bus_site.user_account_page.computer_message.should == 'Computers'
end

Then /^I will see the Authentication Failed page$/ do
  @bus_site.authentication_failed_page.authentication_failed.should == 'Authentication Failed'
end

When /^I login the(| admin) subdomain (.+)$/ do |type, subdomain|
  subdomain.replace ERB.new(subdomain).result(binding)
  if type.include?('admin')
    @bus_site.admin_login_page(subdomain, 'ldap').load
  else
    @bus_site.user_login_page(subdomain, 'ldap').load
  end
  @bus_site.adfs_login_page.log_in(subdomain)
end

And /^I sign in with user name (.+) and password (.+)$/ do |username, password|
  if !(username.match(/^@.+$/).nil?)
    username =  '<%=' + username + '%>'
  end
  username.replace ERB.new(username).result(binding)
  password.replace ERB.new(password).result(binding)
  password = '' if password == 'AD user default password'
  @bus_site.adfs_login_page.sign_in(username, password)
end

When /^I navigate to the admin subdomain (.+)$/ do |subdomain|
  subdomain.replace ERB.new(subdomain).result(binding)
  @bus_site.admin_login_page(subdomain, 'ldap').load
end

When /^I sign in the subdomain (.+)$/ do |subdomain|
  subdomain.replace ERB.new(subdomain).result(binding)
  @bus_site.adfs_login_page.log_in(subdomain)
end

Then /^I will see ldap admin log in error message (.+)$/ do |msg|
  @bus_site.adfs_login_page.ldap_admin_login_failed.should == msg
end

Then /^ldap admin logout url is (.+)$/ do |url|
  url = url.gsub(/CONFIGS\['fedid'\]\['subdomain'\]/,CONFIGS['fedid']['subdomain'])
  @bus_site.adfs_login_page.get_ldap_logout_url.to_s.should == url
end

And /^ldap admin logout text is (.+)$/  do |text|
  @bus_site.adfs_login_page.get_ldap_logout_content.strip.should == text
end


