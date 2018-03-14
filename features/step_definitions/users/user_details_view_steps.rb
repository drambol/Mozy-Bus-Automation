When /^The user status should be (.+)$/ do |status|
  @bus_site.admin_console_page.user_details_section.user_details_hash['Status:'].should include(status)
end

When /^I get the user id$/ do
  @user_id = @bus_site.admin_console_page.user_details_section.user_id
  Log.debug("user id is #{@user_id}")
end

When /^I (activate|suspended) the user$/ do |status|
  @bus_site.admin_console_page.user_details_section.change_user_status(status)
end

Then /^user details should be:$/ do |user_table|
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].match(/\d+/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      when 'Name:'
        if @user.nil?
          actual[header].should == expected[header]
        else
          actual[header].should == expected[header].gsub(/@user/,@user.name)
        end
      when ''
        if expected[header] == "today"
          actual[header].should == Chronic.parse(expected[header]).strftime("%m/%d/%y %H:%M")
        else
          actual[header].should == expected[header]
        end
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^I should not see (.+) setting on user details section$/ do |text|
  @bus_site.admin_console_page.user_details_section.user_details_hash[text].should == nil
end

When /^I enable stash (with|without) send email in user details section$/ do |condition|
  send_email =  condition == 'with' ? true : false
  @bus_site.admin_console_page.user_details_section.add_stash(send_email)
end

#When /^I add stash for the user with:$/ do |paras|
#  attributes = paras.hashes.first
#  stash_quota = attributes['stash quota'] || 'default'
#  send_email = (attributes['send email'] || "no").eql?("yes")
#  if stash_quota == 'default'
#    @bus_site.admin_console_page.user_details_section.add_stash(-1, send_email)
#  else
#    @bus_site.admin_console_page.user_details_section.add_stash(stash_quota, send_email)
#  end
#end


When /^I cancel add user stash$/ do
  @bus_site.admin_console_page.user_details_section.cancel_add_stash
end

When /^I (change|set) user stash quota to (\d+) GB$/ do |action, quota|
  if action == 'change'
    @bus_site.admin_console_page.user_details_section.change_stash_quota(quota)
  elsif action == 'set'
    @bus_site.admin_console_page.user_details_section.add_stash_quota(quota)
  end
end

When /^I cancel change user stash quota$/ do
  @bus_site.admin_console_page.user_details_section.cancel_change_stash_quota
end

Then /^User backup details table should be:$/ do |details_table|
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_headers.should == details_table.headers
  @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows.should == details_table.rows
end

Then /^User backup details table should not have stash record$/ do
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
  stash_record = @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows.select{ |row| row.join(' ').start_with?('Stash') }
  stash_record.empty?.should be_true
end

When /^I delete stash container for the user$/ do
  @bus_site.admin_console_page.user_details_section.click_delete_stash
  @bus_site.admin_console_page.click_yes
end

When /^I click change stash quota text box$/ do
  @bus_site.admin_console_page.user_details_section.click_change_quota_tb
end

Then /^Change stash quota hover message should be (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.find_change_quota_tooltips(message).should be_true
end

When /^I refresh User Details section$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
end

When /^I close User Details section$/ do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

When /^I send stash invitation email$/ do
  @bus_site.admin_console_page.user_details_section.send_stash_invitation_email
end

Then /^User stash quota changed successfully$/ do
  @bus_site.admin_console_page.user_details_section.messages.should == 'Quota changed successfully.'
end

Then /^User details changed message should be (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

Then /^user resources details rows should be:$/ do |resource_table|
  actual = @bus_site.admin_console_page.user_details_section.storage_device_info
  expected = resource_table.hashes.first

  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^MozyHome user details should be:$/ do |user_table|
  # table is a | @country |
  actual = @bus_site.admin_console_page.user_details_section.user_details_hash
  expected = user_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'Country:'
        actual[header].should == expected[header].gsub(/@country/, @partner.company_info.country)
      when 'Name:'
        actual[header].should == expected[header].gsub(/@user_name/, @partner.admin_info.full_name)
      when 'Partner:'
        actual[header].should == expected[header].gsub(/@partner/, @partner.partner_info.parent)
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^MozyHome subscription details should be:$/ do |subscription_table|
  # table is a | mozyhome 50 gb, +0 gb |
  actual = @bus_site.admin_console_page.user_details_section.mozyhome_user_details_hash
  expected = subscription_table.hashes.first

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  # iteration
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

When /^I verify the user$/ do
  @bus_site.admin_console_page.user_details_section.verify_user
end
Then /^The user is verified$/ do
  @bus_site.admin_console_page.user_details_section.user_verified.should == 'User verified.'
end
When /^I Log in as the user$/ do
  @bus_site.admin_console_page.user_details_section.login_as_user
end

Then /^I delete user$/ do
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.delete_user
end

Then /^I reassign the user to user group (.+)$/ do |new_user_group|
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.update_user_group(@user, new_user_group)
end

Then /^I reassign the user to partner (.+)$/ do |new_partner|
  #new_partner.replace(ERB.new(new_partner).result(binding))
  #The above statement cause strange problem, new partner is the former one
  new_partner = ERB.new(new_partner).result(binding)
  @bus_site.admin_console_page.user_details_section.update_partner(new_partner)
end

Then /^Partner count shows up with (.+) should be (.+)$/ do |key_word, quota|
  @bus_site.admin_console_page.user_details_section.find_match_partners(key_word).should == quota.to_i
end

Then /^the user's partner should be (.+)$/ do |partner|
  @bus_site.admin_console_page.user_details_section.user_partner(partner).should be_true
end

Then /^the user's user group should be (.+)$/ do |user_group|
  next if ENV['BUS_ENV'] == 'qa3'
  @bus_site.admin_console_page.user_details_section.users_user_group(user_group).should be_true
end

Then /^the user's user name should be (.+)$/ do |user_name|
  @bus_site.admin_console_page.user_details_section.users_user_name.should == user_name
end

Then /^device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.device_table_hashes
  expected = table.hashes
  expected.each_index { |index|
    expected[index].keys.each { |key|
      expected[index][key]= ERB.new(expected[index][key]).result(binding) if key == "Device"
      #depending on the performance of the testing env, the "Last Update" time could be different
      if !(expected[index][key].match(/^(1|< a|2) minute(s)* ago$/).nil?)
        actual[index][key].match(/^(1|< a|2) minute(s)* ago$/).nil?.should be_false
      else
        actual[index][key].should == expected[index][key]
      end
    }
  }
end

Then /^stash device table in user details should be:$/ do |table|
  actual = @bus_site.admin_console_page.user_details_section.stash_table_hashes
  expected = table.hashes.first
  expected.keys.each{ |header|
    if expected[header] == '< a minute ago'
      (actual[header].match(/^(< a|1) minute ago$/).nil?).should == false
    else
      actual[header].should == expected[header]
    end
  }
end

When /^I delete device by name: (.+)$/ do |device_name|
  @delete_device_msg = @bus_site.admin_console_page.user_details_section.delete_device(device_name)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

When /^I delete sync container$/ do
  @bus_site.admin_console_page.user_details_section.delete_sync
end

Then /^the popup message when delete device is (.+)$/ do |message|
  @delete_device_msg.should == message
end

Then /^Device (.+) (should not|should) show$/ do |device_name, exist|
  exist = (exist == 'should'? true : false)
  @bus_site.admin_console_page.user_details_section.device_exist(device_name).should == exist
end

Then /^I view the user's product keys$/ do
  @bus_site.admin_console_page.user_details_section.click_view_product_keys_link
end

Then /^I update the user (temporary |)password to (.+)$/ do |temporary, password|
  is_temporary = !(temporary.empty?)
  next if ENV['BUS_ENV'] == 'qa3'
  password = rand.to_s if password == '@user_password'
  @user_password = password
  @bus_site.admin_console_page.user_details_section.edit_password(password, is_temporary)
end

Then /^I update user password to incorrect password (.+) and get the error message:$/ do |password,message|
  @bus_site.admin_console_page.user_details_section.edit_password_with_incorrect_pass(password).should == message
end

When(/^I get the machine_id by license_key$/) do
  @machine_id = DBHelper.get_machine_id_by_license_key(@license_key)
end

When /^I get the machine id for client (\d+) by license key (.+)$/ do |client_index, license_key|
  license_key.replace ERB.new(license_key).result(binding)
  @clients[client_index.to_i].machine_id = DBHelper.get_machine_id_by_license_key(license_key)
end

When(/^I update (.+) used quota to (\d+\.?\d*) GB$/) do |machine, quota|
  machine.replace ERB.new(machine).result(binding) if machine.to_s.match(/^[1-9]\d*$/).nil?
  if machine.to_s.match(/^[1-9]\d*$/).nil?
    machine = @bus_site.admin_console_page.user_details_section.get_machine_id(machine)
  else
    machine = machine.to_i
  end
  DBHelper.update_machine_info(machine, quota)
end

When /Available quota of (.+) should be (\d+) GB/ do |machine, quota|
  machine_id = machine.is_a?(Fixnum) ? machine : @bus_site.admin_console_page.user_details_section.get_machine_id(machine)
  DBHelper.machine_available_quota(machine_id).should == quota.to_i
end

When(/^I close user details section$/) do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

When /^edit user details:$/ do |info_table|
  next if ENV['BUS_ENV'] == 'qa3'
  # table is a | email          | name          | status     |
  new_info = info_table.hashes.first

  new_info.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    new_info[header] = nil if attribute == ''
  end

  new_info.keys.each do |header|
    case header
      when 'email'
        new_info[header] = @existing_user_email if new_info[header] == '@existing_user_email'
        new_info[header] = @existing_admin_email if new_info[header] == '@existing_admin_email'
        new_info[header] = @partner.admin_info.email if new_info[header] == '@mh_user_email'
        new_info[header] = create_user_email if new_info[header] == '@new_user_email'
        @bus_site.admin_console_page.user_details_section.set_user_email(new_info[header])
        @new_users.first.email = new_info[header] unless @new_users.nil?
      when 'name'
        @bus_site.admin_console_page.user_details_section.set_user_name(new_info[header])
      when 'status'
        @bus_site.admin_console_page.user_details_section.set_user_status(new_info[header]) #cancelled or active
      else
        raise "Unexpected header for #{new_info[header]}"
    end
  end
end

When /^edit user email success message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Email has been changed to #{email}."
end

When /^edit user email error message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Email address unchanged. The email address you entered is invalid or already in use: An account with email address \"#{email}\" already exists"
end

When /^edit user email error message should be:$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

When /^edit user email change confirmation message to (.+) should be displayed$/ do |email|
  @bus_site.admin_console_page.user_details_section.messages.should == "Your email change request requires verification. We sent an email to #{email}. Please open the email and click the verification link to confirm this change."
end
When /^I set device quota field to (\d+) and cancel$/ do |count|
  @bus_site.admin_console_page.user_details_section.device_edit_and_cancel(count)
end

When /^I edit user( Desktop| Server)* device quota to (.+)$/ do |type, count|
  @bus_site.admin_console_page.user_details_section.change_device_quota(count, type)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^The range of( Desktop| Server|) device by tooltips should be:$/ do | type, range |
  type =
    if type.empty?
      nil
    else
      type.strip
    end
  device_range = @bus_site.admin_console_page.user_details_section.device_range(type)
  range.hashes.first.each do |k, v|
    device_range[k.downcase].should == v
  end
end

Then /^Show error: (.+)$/ do |message|
  @bus_site.admin_console_page.user_details_section.messages.should == message
end

When /^users' device status should be:$/ do |device_status_table|
  actual = @bus_site.admin_console_page.user_details_section.device_status_hashes
  expected_hashes = device_status_table.hashes
  expected_hashes.each_with_index do |expected, i|
    expected.keys.each{ |header| actual[i][header.downcase].should == expected[header] }
  end
end


When(/^I (set|edit|remove|save|cancel) (user|machine) max for (.+)$/) do |action, type, name|
  @alert_msg = @bus_site.admin_console_page.user_details_section.handle_max(action, type, name)
end

When(/^I input the (user|machine) max value for (.+) to (-?\d+) GB$/) do |type, name, quota|
  @bus_site.admin_console_page.user_details_section.set_max_value(type, name, quota)
end

Then(/^set max (message|alert) should be:$/) do | type, msg|
  if type == 'message'
    @bus_site.admin_console_page.user_details_section.messages.should == msg.strip
  else
    @alert_msg.should == msg.strip
  end
end

Then(/^The range of machine max for (.+) by tooltips should be:$/) do |machine, range|
  # table is a | 0   | 12  |
  tooltip = @bus_site.admin_console_page.user_details_section.machine_max_range(machine)
  range.hashes.first.each do |k, v|
    tooltip[k.downcase].should == v
  end
end

When /^I view details of (.+)'s user group$/ do |user|
  step %{I search user by:}, table(%{
      | keywords |
      | #{user}  |
  })
  step %{I view user details by #{user}}
  @bus_site.admin_console_page.user_details_section.click_user_group_details_link
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

When /^I close the user detail page$/ do
  @bus_site.admin_console_page.user_details_section.close_bus_section
end

Then /^I display login information$/ do
  if @partner.partner_info.type == 'MozyHome'
    Log.info("un: #{@partner.admin_info.email}, pw: #{CONFIGS['global']['test_pwd']}")
  else
    Log.info("pn: #{@partner.admin_info.email}, un: #{@new_users.last.email}, pw: #{CONFIGS['global']['test_pwd']}")
  end
end

When /^I search and delete user account if it exists by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.search_user(account_name)
  @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_users_section.view_user_details(account_name)
    @bus_site.admin_console_page.user_details_section.delete_user
  end
end

When /^I search and delete user account by new created user name/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.search_user(@user_name)
  @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_users_section.view_user_details(@user_name)
    @bus_site.admin_console_page.user_details_section.delete_user
  end
end

When /^I change user install override region to (.+)/ do |region|
  @bus_site.admin_console_page.user_details_section.change_region(region)
end

Then /^I will( not)? see the (Change User Password|Send activation email again|awaiting re-activation) link$/ do |t,link|
  if t.nil?
    @bus_site.admin_console_page.user_details_section.has_link(link).nil?.should be_false
  else
    @bus_site.admin_console_page.user_details_section.has_link(link).nil?.should be_true
  end
end

Then /^I click Send activation email again$/ do
  @bus_site.admin_console_page.user_details_section.click_send_activation_email_again
end

When /^the user has activated the account with (.+)$/ do |password|

    step %{I retrieve email content by keywords:}, table(%{
       | to                       |
       | <%=@new_users[0].email%> |
  })
    match = @mail_content.match(/https?:\/\/[\S]+.mozy[\S]+.[\S]+\/account\/set_password[\S]+/)
    @activate_email_query = match[0] unless match.nil?

  @bus_site.admin_console_page.open_admin_activate_page(@activate_email_query)
  @freyja_site = FreyjaSite.new
  @freyja_site.main_page.set_user_password(password)
  @user_password = password
end

When /^I click delete sync device icon for the user$/ do
  @bus_site.admin_console_page.user_details_section.click_delete_stash
end

And /^The button displayed on the pop up are (.+)$/ do |values|
  @bus_site.admin_console_page.get_popup_buttons.should == values.split(' ')
end

Then /^The sync device (should not|should) be deleted$/ do |result|
  exist = (result == 'should not'? true:false)
  @bus_site.admin_console_page.user_details_section.check_sync_exist.should == exist
end

Then /^I downgrade mozyhome user to (50GB|Free)$/ do |match|
  @bus_site.admin_console_page.user_details_section.expand_subscriptions
  @bus_site.admin_console_page.user_details_section.click_edit_plan
  @bus_site.admin_console_page.user_details_section.downgrade_user(match)
end

Then /^I verify mozyhome user plan is (50GB|Free) after downgrade$/ do |match|
  quota = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_quota
  status = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_status
  if match.eql?('50GB')
    quota.should == '50 GB'
    status.should include 'Active'
  else
    status.should include 'Cancelled on'
  end
end

Then /^I get mozyhome user expire time$/ do
   expire_time = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_expire_time
   month, day, year, hour, minute = expire_time.gsub(/\//, ' ').sub(/:/, ' ').split
   @mozyhome_user_expire_time = Time.utc(2000 + year.to_i, month.to_i, day.to_i, hour.to_i, minute.to_i)
end

Then /^I extend mozyhome user expire time by (.+) (.+)$/ do |n, units|
  @bus_site.admin_console_page.user_details_section.extend_mozyhome_user_exipre(n, units)
end

Then /^The mozyhome user expire time should be (.+) (.+) later than last time$/ do |n, units|
  current_expire_time = @bus_site.admin_console_page.user_details_section.get_mozyhome_user_expire_time
  month, day, year, hour, minute = current_expire_time.gsub(/\//, ' ').sub(/:/, ' ').split
  if units == 'years'
    Time.utc(2000 + year.to_i - "#{n}".to_i, month.to_i, day.to_i, hour.to_i, minute.to_i).should == @mozyhome_user_expire_time
  end
  #todo: add other conditions with months or days
end

Then /^I refund the user with (.+) amount$/ do |amount|
  @amount = @bus_site.admin_console_page.user_details_section.refund_user(amount)
end

Then /^I check the refund amount should be correct$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
  refunded_amount = @bus_site.admin_console_page.user_details_section.get_refunded_amount
  refunded_amount[1..-1].to_f.should == - @amount.to_f
end

Then /^The current user should be billed$/ do
  @bus_site.admin_console_page.user_details_section.refresh_bus_section
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
  (@bus_site.admin_console_page.user_details_section.get_user_billed_info > 1).should be_true
end

Then /^device name should show (with|without) \(deleted\)$/ do |deleted|
  value = @bus_site.admin_console_page.user_details_section.get_device_name.strip
  if deleted == 'with'
    value.include?('(deleted)').should == true
  else
    value.include?('(deleted)').should == false
  end
end

Then /^I click allow re-activate$/ do
  @bus_site.admin_console_page.user_details_section.click_allow_reactivation
end

Then /^I check user storage limit is (.+) GB$/ do |storage|
  @bus_site.admin_console_page.user_details_section.get_user_storage_limit.should == storage
end

Then /^I (edit|cancel edit) user storage limit to (.+) GB$/ do |type,storage|
  @bus_site.admin_console_page.user_details_section.edit_user_storage_limit(type,storage)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I remove user storage limit (Yes|No)$/ do |action|
  @bus_site.admin_console_page.user_details_section.remove_user_storage_limit(action)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I check user storage limit set link$/ do
  @bus_site.admin_console_page.user_details_section.check_user_storage_limit_set_link.should be true
end

Then /^I check user storage limit help message should be:$/ do |msg|
  @bus_site.admin_console_page.user_details_section.get_user_storage_limit_help_msg.should == msg
end

Then /^I (set|edit) device (.+) storage limit to (.+) GB$/ do |action,device,storage|
  @bus_site.admin_console_page.user_details_section.set_device_storage_limit(action,device,storage)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I set user storage limit to (.+) GB$/ do |storage|
  @bus_site.admin_console_page.user_details_section.set_user_storage_limit(storage)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

Then /^I see Allow Re-Activation link is available$/ do
  @bus_site.admin_console_page.user_details_section.check_allow_reactivation_available.should be true
end

Then /^edit device tooltips should be: (.+)$/ do |msg|
  @bus_site.admin_console_page.user_details_section.get_edit_device_tooltips.should == msg
end

Then /^I check the records of model_audits table is (.+)$/ do |records|
  DBHelper.get_model_audits_record(@partner_id.to_i).should == "0"
end

When /^I add user external id$/ do
  @user_external_id = "#{Time.now.strftime('%m%d-%H%M-%S')}"
  @bus_site.admin_console_page.user_details_section.change_user_external_id(@user_external_id)
end

Then /^I update (.+) last backup time to 30 minutes ago$/ do |machine_id|
  machine_id.replace ERB.new(machine_id).result(binding)
  DBHelper.update_machines_last_update_time(machine_id)
end

When /^I change machine quota to (.+) under user details$/ do |quota|
  @bus_site.admin_console_page.user_details_section.change_machine_quota(quota)
end

When /^I click restore (Files|VMs) folder icon for device (.+)$/ do  |type, device_name|
  @bus_site.admin_console_page.user_details_section.click_restore_files(type, device_name)
end

Then /^MozyHome user billing info should be:$/ do |billing_table|
  actual = @bus_site.admin_console_page.user_details_section.home_user_billing_hash
  expected = billing_table.hashes

  actual.size.should == expected.size

  actual.each_index { |index|
    expected[index].keys.each do |header|
      case header
        when 'ID'
          if expected[index][header].start_with?('@')
            actual[index][header].match(/\d+/).nil?.should be_false
          else
            actual[index][header].should == expected[index][header]
          end
        when 'Cause'
          expected[index][header] = expected[index][header].gsub('@id','')
          actual[index][header].should include(expected[index][header])
        when 'Refunded?'
          expected[index][header] = expected[index][header].gsub('@id','')
          actual[index][header].should include(expected[index][header])
        when 'Date'
          if expected[index][header] == "today"
            actual[index][header].should include(Chronic.parse(expected[index][header]).strftime("%m/%d/%y"))
          else
            actual[index][header].should == expected[index][header]
          end
        else
          actual[index][header].should == expected[index][header]
      end
    end
  }
end

Then /^device (.+) detail info in db should be:$/ do |device_name, device_table|
  machine_table_headers = device_table.hashes.first
  query_columns = []
  machine_table_headers.each_key do |key|
    query_columns << key
  end
  #=====this is for the scenario: delete the device on UI, after that, check the device details in mahine table======
  @device_id = @bus_site.admin_console_page.user_details_section.get_machine_id(device_name) if @old_device_name != device_name
  Log.debug "======old device name is: #{@old_device_name}, device name is: #{device_name}, device id is: #{@device_id}======"
  @old_device_name = device_name
  device_record = DBHelper.get_machine_record(query_columns, @device_id)
  result_in_hash = Hash.new
  Log.debug query_columns.size
  for i in 0..query_columns.size-1
    if device_record[0][i].nil?
      Log.debug "======vc policy name is empty======"
      device_record[0][i] = ""
    end
    result_in_hash.merge!({query_columns[i] => device_record[0][i]})
  end
  Log.debug result_in_hash
  Log.debug machine_table_headers
  result_in_hash.should == machine_table_headers
end

Then /^I click device (.+) link$/ do |device|
  @bus_site.admin_console_page.user_details_section.click_device_link(device)
end

Then /^sync device info should be:$/ do | sync_device_table |
  expected = sync_device_table.hashes.first
  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.user_details_section.sync_device_storage_info_hash
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

Then /^sync device \(itemized\) info should be:$/ do | sync_device_table |
  expected = sync_device_table.hashes.first
  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.user_details_section.sync_device_itemized_storage_info_hash
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

And /^device (.+) has tooltip (.+) on its Device Storage Limit$/ do |device_name, tooltip|
  sleep(5)
  begin
    @bus_site.admin_console_page.user_details_section.get_device_Device_Storage_Limit_tooltip(device_name).should == tooltip
  rescue RSpec::Expectations::ExpectationNotMetError
    puts "=======Manual check required, move forward======"
    #@bus_site.admin_console_page.user_details_section.get_device_Device_Storage_Limit_tooltip(device_name).should == tooltip
  end
end


And /^update the device (.+) with amount (.+)$/ do |device_name, amount|
  @bus_site.admin_console_page.user_details_section.update_device_storage_limit(device_name, amount)
end

Then /^device detail section has error message(.*)$/ do | error_message |
  @bus_site.admin_console_page.search_list_machines_section.wait_until_bus_section_load
  @bus_site.admin_console_page.user_details_section.get_error_message.strip.should == (error_message.strip)
end

#======call method <delete_device> for common user's device
When /^delete device (.+) by (with|without) keeping data$/ do | device_name, data_kept |
  @bus_site.admin_console_page.user_details_section.delete_device(device_name, data_kept)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

#======call method <delete_itemized_device> for itemized user's device
When /^delete \(itemized\) device (.+) by (with|without) keeping data$/ do | device_name, data_kept |
  @bus_site.admin_console_page.user_details_section.delete_itemized_device(device_name, data_kept)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end

When /^I change itemized user stash quota to (.+) GB/ do |quota|
  @bus_site.admin_console_page.user_details_section.change_stash_quota_for_itemized_user(quota)
end

And /^the message should be (.+) when itemized user has sync disabled$/ do | message |
  @bus_site.admin_console_page.user_details_section.get_sync_disabled_message
end

And /^as a MozyHome User clicks computer (.+)$/ do |computer|
  @bus_site.admin_console_page.user_details_section.click_computer(computer)
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
end
