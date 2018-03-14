When /^I use (Directory Service|Mozy) as authentication provider(| without saving)$/ do |provider, save_type|
  save = (save_type.strip == 'without saving'? false : true)
  @bus_site.admin_console_page.authentication_policy_section.select_auth(provider, save)
end

When /^I choose (LDAP Pull|LDAP Push|horizon) as Directory Service provider(| without saving)$/ do |provider, save_type|
  save = (save_type.strip == 'without saving'? false : true)
  @bus_site.admin_console_page.authentication_policy_section.select_ds_provider(provider, save)
  @provider = provider
end

When /^I select Horizon Manager with organization name (.*)$/ do |org_name|
  @bus_site.admin_console_page.authentication_policy_section.check_horizon(true)
  case org_name
  when 'nothing'
    @bus_site.admin_console_page.authentication_policy_section.fillin_org_name('')
  else
    @bus_site.admin_console_page.authentication_policy_section.fillin_org_name(org_name)
  end
end

And /^I (check|uncheck) enable sso for admins to log in with their network credentials$/ do |type|
  checked = (type == 'check'? true:false)
  @bus_site.admin_console_page.authentication_policy_section.check_admin_sso(checked)
end

When /^I Test Connection for (Horizon Manager|AD)$/ do |provider|
  case provider
  when "Horizon Manager"
    @bus_site.admin_console_page.authentication_policy_section.test_connection_horizon
  when "AD"
    @bus_site.admin_console_page.authentication_policy_section.test_connection_ad
  end
end

When /^I add a new rule: (.+)$/ do |rule|
  @bus_site.admin_console_page.authentication_policy_section.fill_in_rules(1, rule)
end

Then /^There should be (\d+) items:$/ do |num, table|
  @bus_site.admin_console_page.authentication_policy_section.group_num.should == num.to_i
  @bus_site.admin_console_page.authentication_policy_section.group_names.should == table.headers
end

Then /test connection message should be (.+)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.test_connection_result.should include(message)
end

When /^I clear (SAML Authentication|Connection Settings) information(| exists)$/ do |tab,exists|
  case tab
    when "SAML Authentication"
      @bus_site.admin_console_page.authentication_policy_section.clear_all
    when "Connection Settings"
      #TODO
    else
      #TODO
  end
  if exists.include?('exists')
    step "I save the #{tab} information"
  end
end

When /^I click (SAML Authentication|Connection Settings|Sync Rules|Attribute Mapping) tab$/ do |tab|
  @bus_site.admin_console_page.authentication_policy_section.select_tab(tab)
end

When /^I load attributes$/ do
  @bus_site.admin_console_page.authentication_policy_section.load_attributes
  # Verify all input fields are disabled
  #@bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled?.should be_true
end

Then /^SAML authentication information should include$/ do |table|
  # table is a | mozyqa2.horizonmanager.com/SAAS/API/1.0/GET/federation/request?s=1876 | horizonmanager.com| glbv7YsYBdLHAtbX2Geg==|pending
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
  data = table.hashes
  data.each do |d|
    @bus_site.admin_console_page.authentication_policy_section.auth_URL.should include(d[:URL])
    @bus_site.admin_console_page.authentication_policy_section.client_endpoint.should include(d[:Endpoint])
    @bus_site.admin_console_page.authentication_policy_section.certificate.should include(d[:Certificate])
    @bus_site.admin_console_page.authentication_policy_section.encrypted_saml?.should == (d[:Encrypted] == 'Yes' ? true : false) if d[:Encrypted]
  end
end

When /^I save the (SAML Authentication|Connection Settings) information$/ do |tab|
  step "I click #{tab} tab"
  case tab
  when "SAML Authentication"
    @bus_site.admin_console_page.authentication_policy_section.save_saml_tab
    # remove this checkpoint, most of time, the field will be enabled very soon
    #@bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled?.should be_true
    while @bus_site.admin_console_page.authentication_policy_section.auth_URL_disabled? do
    end
  when "Connection Settings"
    @bus_site.admin_console_page.authentication_policy_section.save_saml_tab
    @bus_site.admin_console_page.authentication_policy_section.server_host_disabled?.should be_true
    while @bus_site.admin_console_page.authentication_policy_section.server_host_disabled? do
    end
  else
  end
end

Then /^Horizon Manager load attribute information should be (Failed to load attributes from Horizon)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.load_attributes_result.should include(message)
end

Then /^I load attributes and I should see an JS alert with message (Oranization name \(Org Name\) is not specified.)$/ do |message|
  @bus_site.admin_console_page.authentication_policy_section.load_attributes_alert_text.should include(message)
end

When /^I de-select Horizon Manager$/ do
  @bus_site.admin_console_page.authentication_policy_section.check_horizon(false)
end

When /^I input server connection settings$/ do |table|
  # | 10.29.99.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
  # or | @server_host | @protocol  |          | @port  | @base_dn | @bind_user      | @bind_password  |
  server = table.hashes.first
  @connection_info = Bus::DataObj::ConnectionInfo.new
  @connection_info.server_host = server['Server Host'] == '@server_host' ? AD_CONNECTION_ENV['server_host'] : server['Server Host']
  @connection_info.ssl_cert = server['SSL Cert']
  protocol_value = server['Protocol'] == '@protocol' ? AD_CONNECTION_ENV['protocol'] : server['Protocol']
  @connection_info.protocol = protocol_value == 'No SSL' ? 'false' : server['Protocol'].downcase
  @connection_info.port = server['Port'] == '@port' ? AD_CONNECTION_ENV['port'] : server['Port']
  @connection_info.base_dn = server['Base DN'] == '@base_dn' ? AD_CONNECTION_ENV['base_dn'] : server['Base DN']
  @connection_info.bind_user = server['Bind Username'] == '@bind_user' ? AD_CONNECTION_ENV['bind_username'] : server['Bind Username']
  @connection_info.bind_password = server['Bind Password'] == '@bind_password' ?  AD_CONNECTION_ENV['bind_password'] : server['Bind Password']
  @bus_site.admin_console_page.authentication_policy_section.fillin_connection_settings(@connection_info)
end

Then /^server connection settings information should include$/ do |table|
  # table is a | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
  data = table.hashes.first
  connection_info = @bus_site.admin_console_page.authentication_policy_section.connection_info
  data['Server Host'].should include(connection_info.server_host)
  data['Protocol'].downcase.should include(connection_info.protocol)
  #data['SSL Cert'].should include(connection_info.ssl_cert)
  data['Port'].should include(connection_info.port)
  data['Base DN'].should include(connection_info.base_dn)
  data['Bind Username'].should include(connection_info.bind_user) if data.has_key? 'Bind Username'
  #data['Bind Password'].should include(connection_info.bind_password)
end

Then /^user mapping tab should be disabled$/ do
  @bus_site.admin_console_page.authentication_policy_section.tabs().should_not include("Sync Rules")
  @bus_site.admin_console_page.authentication_policy_section.tabs().should_not include("Arribute Mapping")
end

When /^I select Protocol as (No SSL|StartTLS|LDAPS)$/ do |p|
  @bus_site.admin_console_page.authentication_policy_section.select_protocol(p == 'No SSL' ? 'false' : p.downcase)
end

Then /^certificate text field is (disabled|enabled)$/ do |p|
  if p == 'disabled'
    @bus_site.admin_console_page.authentication_policy_section.data_ad_connection_cert_displayed?.should be_false
  else
    @bus_site.admin_console_page.authentication_policy_section.data_ad_connection_cert_displayed?.should be_true
  end
end

When /^I input SAML authentication information$/ do |table|
  # table is a |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     | No        |
  auth = table.hashes.first
  @saml_info = Bus::DataObj::SAMLInfo.new
  @saml_info.auth_url = (auth['URL'] == '@url'? AD_CONNECTION_ENV['authentication_url'] : auth['URL'])
  @saml_info.saml_endpoint = (auth['Endpoint'] == '@endpoint'? AD_CONNECTION_ENV['saml_endpoint'] : auth['Endpoint'])
  @saml_info.saml_cert = (auth['Certificate'] == '@certificate'? AD_CONNECTION_ENV['saml_certificated'] : auth['Certificate'])
  @bus_site.admin_console_page.authentication_policy_section.fillin_saml_settings(@saml_info)
end

When /^I click Test Connection button$/ do
  @bus_site.admin_console_page.authentication_policy_section.test_connection
end

Then /^There should be (\d+) (.+) items:$/ do |num, type, table|
  @bus_site.admin_console_page.authentication_policy_section.options_num(type).should == num.to_i
  @bus_site.admin_console_page.authentication_policy_section.options_names(type).should == table.headers
end

Then /^The sync status result should be:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.sync_result.should == table.transpose.rows.first
end

Then /^The layout of attribute should:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.attribute_layout.should == table.raw
end

# If AD user has an unique and dynamic email address, which means the @AD_User_Emails instance variable exists,
# go to the else logic part.
# See "When /^I add a user to the AD$/ do |table|" step code in this .rb file.
When /^I add (\d+) new (.+) rules:$/ do |num, type, table|
  table.hashes.first.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  if @AD_User_Emails.nil?
    @bus_site.log("The AD user has a predefined email address.")
    @bus_site.admin_console_page.authentication_policy_section.add_rules(type, num.to_i, table.transpose.raw[0], table.transpose.raw[1])
  else
    @bus_site.log("The AD user has a dynamic email address.")
    @bus_site.admin_console_page.authentication_policy_section.add_rules(type, num.to_i, table.transpose.raw[0], table.transpose.raw[1], @AD_User_Emails)
  end
end

Then /^The (.+) order icon should be correct$/ do |type, table|
  num = table.raw.length
  (1..num).each { |i| @bus_site.admin_console_page.authentication_policy_section.arrow_status(type, i).should == table.raw[i - 1] }
end

When /^I save the changes$/ do
  @bus_site.admin_console_page.authentication_policy_section.save_changes
  @bus_site.admin_console_page.authentication_policy_section.confirm_change_auth
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
end

When /^I save the changes with password (.+)$/ do |password|
  @bus_site.admin_console_page.authentication_policy_section.save_changes(password)
  @bus_site.admin_console_page.authentication_policy_section.confirm_change_auth(password)
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
end

When /^I save the changes which will need re auth$/ do
  @bus_site.admin_console_page.authentication_policy_section.save_changes('', 'reauth')
end

Then /^Authentication Policy has been updated successfully$/ do
  @bus_site.admin_console_page.authentication_policy_section.result_message.should == 'Authentication Policy has been updated successfully.'
end

And /^I (uncheck|check) enable synchronization safeguards in Sync Rules tab$/ do |action|
  checked = (action == 'check'? true:false)
  @bus_site.admin_console_page.authentication_policy_section.check_uncheck_sync_safeguard(checked)
end

When /^I change the (.+) order by the following rule:$/ do |type, table|
  r = table.raw
  r.each do |row|
    if row[1] != ''
      @bus_site.admin_console_page.authentication_policy_section.change_order(type, row[0], row[1])
    end
  end
end

Then /^The new (.+) rules order should be:$/ do |type, table|
  @bus_site.admin_console_page.authentication_policy_section.rules_order(type).should == table.rows
end

When /^I delete (\d+) (.+) rules$/ do |num, type|
  num.to_i.times do
    @bus_site.admin_console_page.authentication_policy_section.delete_rule(type)
  end
end

When /^I delete all the rules$/ do
  @bus_site.admin_console_page.authentication_policy_section.delete_all_rules
end

Then /^The (.+) rule number is (\d+)$/ do |type, num|
  @bus_site.admin_console_page.authentication_policy_section.rule_num(type).should == num.to_i
end

When /^I move to the connection settings tab when changing from mozy to ad$/ do
  @bus_site.admin_console_page.authentication_policy_section.change_provider_connecting_settings
end

When /^The selected (.+) option is (.+)$/ do |type, option|
  @bus_site.admin_console_page.authentication_policy_section.selected_option(type).should == option
end

When /^The save error message should be:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.result_message.should include "#{table.raw[0][0]}"
  @bus_site.admin_console_page.authentication_policy_section.result_message.should include "#{table.raw[1][0]}"
end

When /^I click the sync now button$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_now
  Log.debug("Time to click sync now: #{Time.now}")
end

Then /^The sync status result should like:$/ do |table|
  @bus_site.admin_console_page.authentication_policy_section.refresh_bus_section
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
  expected = table.transpose.rows.first
  actual = @bus_site.admin_console_page.authentication_policy_section.sync_result
  Log.debug "########Actual is #{actual}"
  time_re = '\d+/\d+/\d+ \d+:\d+ (\+|-)\d+:\d+'
  time_re_sub = '\d+/\d+/\d+ \d+:\d+ (\\\+|-)\d+:\d+'
  last_sync_time = actual[0].match(time_re)[0]
  costed_time = actual[0].match('about (.+) (sec|minute|minutes)')[1].to_f
  Log.debug("last sync time is #{last_sync_time}")
  Log.debug("costed_time is #{costed_time}")

  # verfiy Sync Status
  actual[0].match(expected[0].gsub('%m/%d/%y %H:%M %:z', time_re_sub)).should_not be_nil
  if actual[0].include? "second"
    costed_time.should be < 120
  else
    costed_time.should be <= 2
  end
  expected_next_sync = expected[2]
  # verify Sync Result
  actual[1].include?(expected[1]).should == true
  # verify Next Sync
  unless expected_next_sync.nil?
    if expected_next_sync == 'Not Scheduled(Set)'
      @bus_site.admin_console_page.authentication_policy_section.sync_result[2].should == expected_next_sync
    else
      expected_next_sync = @next_sync_time if expected_next_sync == '@next_sync_time'
      next_time_got = actual[2]
      next_sync_time = Time.strptime(next_time_got, '%m/%d/%y %H:%M %:z')
      t = Time.now
      expected_time = Time.utc(t.year,t.month, t.day, expected_next_sync.to_i, 0, 0).getlocal
      day = t.day
      while t > expected_time
        expected_time = Time.utc(t.year,t.month, day + 1, expected_next_sync.to_i, 0, 0).getlocal
        day = day + 1
      end
      Log.debug("the actual next sync time is #{actual[2]}")
      Log.debug("the expected next sync time is #{expected_time}")
      next_sync_time.should == expected_time
    end
  end
end

When /^I Choose to (.+) users if missing from LDAP for (\d+) days$/ do |method, days|
  @bus_site.admin_console_page.authentication_policy_section.handle_user(method, days.to_i)
end

When /^The chosen rule should be (.+) users if missing from LDAP for (\d+) days$/ do |method, days|
  @bus_site.admin_console_page.authentication_policy_section.check_rules(method, days.to_i)
end

When /^I change the user last sync field in the db to be (\d+) days earlier$/ do |days|
  DBHelper.change_last_sync_at(@user_id, days.to_i)
end

When /^I wait until the sharp time$/ do
  sec = (60 - Time.now.min) * 60
  Log.debug(Time.now)
  Log.debug("wait for #{sec} seconds")
  sleep(sec)
end

When /^I choose to sync daily at the nearest sharp time$/ do
  t = Time.now
  # needs to refine here
  @next_sync_time = (t.getutc.hour + 1) % 24
  Log.debug("The scheduled sync time is #{@next_sync_time} utc")
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at(@next_sync_time)
end

When /^I clear the user sync information$/ do
  @bus_site.admin_console_page.authentication_policy_section.clear_user_sync_info
end

When /^I add a user (.+) to the AD$/ do |username|
  LDAPHelper.add_user(username)
end

# The step also allows you to create a AD user with a dynamic email to meet the scenario or similar scenario like -
#    create AD user -> privision user in Bus Console -> Get 1 welcome email
# You could only provide the user name in "table" hash parameter as:
#     When I add a user to the AD
#        | user name      |
#        | tc131019.user1 |
# an unique email address will be created automatically, which has prefix "mozyautotest" such as "mozyautotest+tc131019.user120170330025334utc@emc.com"
# You could see code below for more details.
When /^I add a user to the AD$/ do |table|
  @bus_site.log("Begin to add a user to AD")
  @AD_User_Emails = Hash.new if @AD_User_Emails.nil?
  table.hashes.first.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  ldap_hash = table.hashes.first
  @bus_site.log("AD user's name:" + ldap_hash['user name'].to_s)
  # if user's mail is empty in table hash parameter, method will help you to create an unique and dynamic email
  ldap_hash['mail'] = "mozyautotest+" + ldap_hash['user name'] + Time.now.utc.to_s.gsub!("-", "").gsub!(" ", "").gsub!(":", "") + "@emc.com" if ldap_hash['mail'].nil?
  ldap_hash['mail'].downcase!
  @AD_User_Emails[ldap_hash['user name'].to_s] = ldap_hash['mail']
  @bus_site.log("AD user's mail:" + ldap_hash['mail'].to_s)
  @bus_site.log("AD user's host:" + ldap_hash['host'].to_s)
  @bus_site.log("AD user's user:" + ldap_hash['user'].to_s)
  @bus_site.log("AD user's password:" + ldap_hash['password'].to_s)
  @bus_site.log("AD user's treebase:" + ldap_hash['treebase'].to_s)
  @bus_site.log("AD user's email_postfix:" + ldap_hash['email_postfix'].to_s)
  @bus_site.log("Call LDAPHelper.add_user method to create AD user")
  LDAPHelper.add_user(ldap_hash['user name'], ldap_hash['mail'], ldap_hash['host'], ldap_hash['user'],ldap_hash['password'], ldap_hash['treebase'], ldap_hash['email_postfix'])
  @bus_site.log("In current thread, AD user emails are: " + @AD_User_Emails.to_s)
end

When /^I delete a user (.+) in the AD$/ do |username|
  username = @admin.name if username == '@admin.name'
  LDAPHelper.delete_user(username)
end

When /^I update a user in the AD:$/ do |table|
  # table is a | dev_test4 | :cn       | dev_test44   |
  data = table.rows.first
  LDAPHelper.update_user(data[0], data[1], data[2])
end
Then /^I get the user (.+) details in the console$/ do |username|
  LDAPHelper.show_user(username)
end

When /^I modify the username from (.+) to (.+) for user (.+) in the AD$/ do |username, new_name, user|
  LDAPHelper.modify_rdn(username, new_name, user)
end

When /^I choose to daily sync at (\d+) GMT$/ do |hour|
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at(hour)
end

When /^I set the (fixed attribute|user name|name) to (.+)$/ do |attr, value|
  case attr
    when 'fixed attribute'
      @bus_site.admin_console_page.authentication_policy_section.set_fixed_attribute(value)
    when 'user name'
      @bus_site.admin_console_page.authentication_policy_section.set_user_name(value)
    when 'name'
      @bus_site.admin_console_page.authentication_policy_section.set_name(value)
  end
end

When /^(Bind Username|Bind Password|Test Connection|Scheduled Sync|Sync Now|Next Sync) should be invisible$/ do |element|
  @bus_site.admin_console_page.authentication_policy_section.is_element_invisible(element).should == true
end

Then /^The daily sync time should be (\d+) GMT$/ do |hour|
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_time.should == hour
end

When /^I clear the daily sync information$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_at('')
end

Then /^The daily sync time should be empty$/ do
  @bus_site.admin_console_page.authentication_policy_section.sync_daily_time.should == ''
end

When /^I clear the (fixed attribute|user name|name)$/ do |attr|
  case attr
    when 'fixed attribute'
      @bus_site.admin_console_page.authentication_policy_section.set_fixed_attribute('')
    when 'user name'
      @bus_site.admin_console_page.authentication_policy_section.set_user_name('')
    when 'name'
      @bus_site.admin_console_page.authentication_policy_section.set_name('')
  end
end

Then /^I change root role to (.+)$/ do | role |
  @bus_site.admin_console_page.partner_details_section.change_root_role(role)
end

Then /^I should see (Mozy|LDAP) auth selected$/ do |provider|
  case provider
  when "Mozy"
    @bus_site.admin_console_page.authentication_policy_section.provider_mozy_checked?.should be_true
    @bus_site.admin_console_page.authentication_policy_section.provider_ldap_checked?.should be_false
  when "LDAP"
    @bus_site.admin_console_page.authentication_policy_section.provider_ldap_checked?.should be_true
    @bus_site.admin_console_page.authentication_policy_section.provider_mozy_checked?.should be_false
  end
end

When /^I see the response code is (\d+)$/ do |code|
  @bus_site.admin_console_page.authentication_policy_section.response_code.should == code
end

When /^I get the full whitelist into (.+)$/ do |file|
  @bus_site.admin_console_page.authentication_policy_section.get_whitelist(file)
end

Then /^(\d+) Server Host and Port are (.+) to the whitelist according to (.+) and (.+)$/ do |num, key, old_file, new_file|
  @bus_site.admin_console_page.authentication_policy_section.host_port_changed_num(new_file, old_file)[key.to_sym].should == num.to_i
end

When /^The new Server Host and Port should be the same as input according to (.+) and (.+)$/ do |old_file, new_file|
  @bus_site.admin_console_page.authentication_policy_section.host_port_changed(old_file, new_file)[0].should == [@connection_info.server_host, @connection_info.port.to_s]
end

When /^I refresh the authentication policy section$/ do
  @bus_site.admin_console_page.authentication_policy_section.refresh_bus_section
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
end

And /^sso for admins to log in with their network credentials is (checked|unchecked)$/ do |type|
  checked = (type == 'checked'? true:false)
  @bus_site.admin_console_page.authentication_policy_section.sso_admin_checked? == checked
end

And /^I (check|uncheck) Send Welcome email to new users checkbox$/ do |action|
  @bus_site.admin_console_page.authentication_policy_section.check_send_welcome_email if action == "check"
  @bus_site.admin_console_page.authentication_policy_section.uncheck_send_welcome_email if action == "uncheck"
end

And /^I delete a user (.+) in the demeter db$/ do |username|
  @bus_site.log("Delete user #{username} in demeter db.")
  DBHelper.delete_users_by_email(username)
end

# Monitor the sync result, restart bds-boot service in case the sync failed.
And /^I monitor the sync result and restart bds-boot service if sync failed$/ do
  # step1 - click Connection Settings tab and wait for the sync result
  step %{I click Connection Settings tab}
  @bus_site.admin_console_page.authentication_policy_section.refresh_bus_section
  @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.authentication_policy_section.sync_result
  @bus_site.log("Get Sync info: #{actual}")
  @bus_site.log("Sync Result is: #{actual[1]}")
  # step2 - check the sync status, if failed, restart bds-botts service on authproxy01.qa12h.mozyops.com
  if actual[1].include?("An unknown error occurred")
    @bus_site.log("Sync failed, no user is provisoned. Restart bds-boots service.")
    SSHHelper.restart_bds_boots_service
    step %{I click Sync Rules tab}
    step %{I click the sync now button}
    step %{I wait for 60 seconds}
    step %{I click Connection Settings tab}
    @bus_site.admin_console_page.authentication_policy_section.refresh_bus_section
    @bus_site.admin_console_page.authentication_policy_section.wait_until_bus_section_load
    actual = @bus_site.admin_console_page.authentication_policy_section.sync_result
    @bus_site.log("Get Sync info: #{actual}")
    @bus_site.log("Sync Result is: #{actual[1]}")
    actual[1].should =~ /0 failed/
    @bus_site.log("Provisioned succeeds after 1st failed.")
  end
end

Then /^sync hourly checkbox is (visible|invisible)$/ do | visibility |
  @bus_site.admin_console_page.authentication_policy_section.sync_hourly_visible.should == true if visibility == 'visible'
  @bus_site.admin_console_page.authentication_policy_section.sync_hourly_visible.should == false if visibility == 'invisible'
end

Then /^sync safeguards checkbox is (visible|invisible)$/ do | visibility |
  @bus_site.admin_console_page.authentication_policy_section.sync_safeguard_visible.should == true if visibility == 'visible'
  @bus_site.admin_console_page.authentication_policy_section.sync_safeguard_visible.should == false if visibility == 'invisible'
end

Then /^help link is (visible|invisible)$/ do |visibility|
  @bus_site.admin_console_page.authentication_policy_section.help_link_visibility.should == true if visibility == 'visible'
  @bus_site.admin_console_page.authentication_policy_section.help_link_visibility.should == false if visibility == 'invisible'
end

Then /^I click help link$/ do
  @bus_site.admin_console_page.authentication_policy_section.click_help_link
end

Then /^I access help page successfully$/ do
  sleep(20)
  @bus_site.helplink_page.access
end

# Monitor the sync result, restart bds-boot service in case the sync failed.
And /^I restart bds-boot service$/ do
  SSHHelper.restart_bds_boots_service
end

Then /^I click Details link to download csv file$/ do
  @bus_site.admin_console_page.authentication_policy_section.click_details_link
end

Then /^the download LDAP_object_list csv file should be like:$/ do |report_table|
  report_table.map_column!('Column B') do |value|
    #p value
    if value.include? "AD_User_Emails"
      /(\[.+\])/ =~ value
      hash_key = $1
      hask_key1 = hash_key.gsub!(/(\[)|(\])|(")/, '')
      email = @AD_User_Emails[hask_key1]
      value.gsub!(/<.*>/, email)
    end
    value
  end

  actual_csv = FileHelper.read_csv_file("LDAP_object_list.csv")
  actual_csv.should == report_table.rows
end

And /^I click Blocked Deprovision link$/ do
  @bus_site.admin_console_page.authentication_policy_section.click_blocked_deprovision_link
end

Then /^I (approve|ignore) rule (.+)$/ do |action, rule|
  @bus_site.admin_console_page.blocked_deprovision.blocked_deprovision_rule_check(rule)
  @bus_site.admin_console_page.blocked_deprovision.blocked_deprovision_rule_action(action)
end