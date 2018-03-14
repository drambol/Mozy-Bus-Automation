# If you are create one user: You can specify user name and email
# If you are create more than on users: User names and emails are random
#
# available columns:
# name, email, user_group, storage_type, storage_max, devices, enable_stash, send_email

When /^I add new user\(s\):$/ do |user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @new_users =[]
  @users =[] if @users.nil?
  user_table.hashes.each do |hash|
    hash['email'].replace ERB.new(hash['email']).result(binding) unless hash['email'].nil?
    hash['email'] = @existing_user_email if hash['email'] == '@existing_user_email'
    hash['email'] = @existing_admin_email if hash['email'] == '@existing_admin_email'
    user = Bus::DataObj::User.new
    hash_to_object(hash, user)
    @new_users << user
    @users << user
  end
  @bus_site.admin_console_page.add_new_user_section.add_new_users(@new_users)
end

When /^I add multiple users:$/ do |table|
  100.times do
  step %{I add new user\(s\):}, table(%{
    |#{table.headers.join('|')}|
    |#{table.rows.first.join('|')}|
  })
  step %{1 new user should be created}
  step %{I search user by:}, table(%{
    | keywords   |
    | <%=@new_users[0].email%> |
  })
  step %{I view user details by newly created user email}
  step %{I update the user password to default password}
  step %{I close user details section}
  end
end

When /^I add new user with error message (.+) unsuccessfully:$/ do |message, user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @new_users =[]
  @users =[] if @users.nil?
  user_table.hashes.each do |hash|
    hash['email'] = @existing_user_email if hash['email'] == '@existing_user_email'
    hash['email'] = @existing_admin_email if hash['email'] == '@existing_admin_email'
    user = Bus::DataObj::User.new
    hash_to_object(hash, user)
    @new_users << user
    @users << user
  end
  msg = @bus_site.admin_console_page.add_new_user_section.add_new_users_unsuccessfully(@new_users)
    msg.should == message
end

# If you are create one user: You can specify user name and email
# If you are create more than on users: User names and emails are random
#
# available columns:
# name, email, user_group, storage_type, storage_max, devices, enable_stash, send_email
When /^I add new itemized user\(s\):$/ do |itemized_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @new_users =[]
  itemized_table.hashes.each do |hash|
    user = Bus::DataObj::ItemizedUser.new
    hash_to_object(hash, user)
    @new_users << user
  end
  @bus_site.admin_console_page.add_new_itemized_user_section.add_new_itemized_users(@new_users)
end

Then /^(\d+) new user should be created$/ do |num|
  @bus_site.admin_console_page.add_new_user_section.success_messages.should == "Successfully created #{num} user(s)"
end

Then /^new itemized user should be created$/ do
  @bus_site.admin_console_page.add_new_itemized_user_section.new_user_creation_success(@new_users)
end

Then /^(Add new|Edit) user error message should be:$/ do |_,messages|
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
  @bus_site.admin_console_page.add_new_user_section.error_messages.should == messages.to_s
end

Then /^User group storage details table should be:$/ do |ug_table|
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
  @bus_site.admin_console_page.add_new_user_section.ug_resource_details_table_rows.should == ug_table.raw
end

When /^I refresh Add New User section$/ do
  @bus_site.admin_console_page.add_new_user_section.refresh_bus_section
end

Then /^I should not see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_stash_option?.should be_false
end

Then /^I should see stash options$/ do
  @bus_site.admin_console_page.add_new_user_section.has_stash_option?.should be_true
end

Then /^desktop and server devices should not be displayed in Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.has_desktop_device_lbl?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_server_device_lbl?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Desktop Devices').should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Server Devices').should be_false
end

Then /^desktop and server devices should be displayed in Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.has_desktop_device_lbl?.should be_true
  @bus_site.admin_console_page.add_new_user_section.has_server_device_lbl?.should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Desktop Devices').should be_true
  @bus_site.admin_console_page.add_new_user_section.has_content?('Server Devices').should be_true
end

When /^I note the desktop and server amounts in Add New User module for user group (.+)$/ do |user_group|
  @bus_site.admin_console_page.add_new_user_section.select_user_group(user_group)
  @bus_site.admin_console_page.add_new_user_section.wait_until_bus_section_load
   if @user_group.nil?
     @user_group = Bus::DataObj::ItemizedUserGroup.new
     @user_group.name = user_group
     @user_group.desktop_devices = @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i
     @user_group.server_devices = @bus_site.admin_console_page.add_new_user_section.server_device.to_i
   else
     # "Available:" device and storage calculations happen after frame load
     @user_group.desktop_devices.should == @bus_site.admin_console_page.add_new_user_section.desktop_device.to_i
     @user_group.server_devices.should == @bus_site.admin_console_page.add_new_user_section.server_device.to_i
   end
end

Then /^the user groups should not be visible in the Add New User module$/ do
  @bus_site.admin_console_page.add_new_user_section.user_group_search_select_visible?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_add_group_link?.should be_false
  @bus_site.admin_console_page.add_new_user_section.has_content?('Choose a Group:').should be_false
end

When /^I choose (.+) from Choose a Group$/ do |user_group|
  @bus_site.admin_console_page.add_new_user_section.select_user_group(user_group)
end

Then /^the Buy More link should be visible$/ do
  @bus_site.admin_console_page.add_new_user_section.has_buy_more_link?.should be_true
end

Then /^the Buy More link should open the Change Plan module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_buy_more_link
  @bus_site.admin_console_page.change_plan_section.section_visible?
  @bus_site.admin_console_page.change_plan_section.wait_until_bus_section_load
end

Then /^the Add More link should be visible$/ do
  @bus_site.admin_console_page.add_new_user_section.has_add_more_link?.should be_true
end

Then /^the Add More link should open the Manage Resources module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_add_more_link
  @bus_site.admin_console_page.manage_resources_section.section_visible?
end

Then /^the Add More link should open the Change Plan module$/ do
  @bus_site.admin_console_page.add_new_user_section.click_add_more_link
  @bus_site.admin_console_page.change_plan_section.section_visible?
end

When /^I view latest created user details$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  @bus_site.admin_console_page.search_list_users_section.view_user_details((@new_users.last.email).slice(0,27))
end

And /^I add a new user and activate a machine for him$/ do |table|
#  step %{And I add new user(s):}, table(%{
#    | name          | user_group           | storage_type | storage_limit | devices |
#    | TC.16266.User | (default user group) | Desktop      | 50            | 3       |
#  })
  header = table.headers[0..-2].join('|')
  row = table.rows.first[0..-2].join('|')
  step %{I add new user\(s\):}, table(%{
    |#{header}|
    |#{row}|
  })
  step %{1 new user should be created}
  step %{I search user by:}, table(%{
    | keywords   |
    | @user_name |
  })
  step %{I view user details by newly created user email}
  step %{I update the user password to default password}
  machine_type = table.hashes.first['storage_type']
  machine_name = table.hashes.first['machine_name']
  step %{I use keyless activation to activate devices}, table(%{
    | user_email  | machine_name    | machine_type    | partner_name  |
    | @user_email | #{machine_name} | #{machine_type} | @partner_name |
  })
  step %{I close the user detail page}
end

And /^I add some new users and activate one machine for each$/ do |table|
  header = table.headers.join('|')
  table.rows.each do |row|
    step %{I add a new user and activate a machine for him}, table(%{
      |#{header}|
      |#{row.join('|')}|
    })
  end
end

Then /^I check user group (.+) with (.+) storage limit tooltips is (.+)$/ do |group,type,tooltips|
  @bus_site.admin_console_page.add_new_user_section.get_tooltips(group,type).should ==tooltips
end

Then /^I check (.+) help message under add new user section should be:$/ do |type,msg|
  @bus_site.admin_console_page.add_new_user_section.get_help_msg(type).gsub("\n", " ").should == msg
end


Then /^The error message beside email should be (.+)$/ do |msg|
  @bus_site.admin_console_page.add_new_user_section.get_beside_email_message.should == msg
end

Then /^created new itemized user message should be (.+)$/ do |msg|
  @bus_site.admin_console_page.add_new_itemized_user_section.error_messages.gsub("\n"," ").should == msg
end

Then /^User group (storage|resource) details warning message should be (.+)$/ do |type, message|
  @bus_site.admin_console_page.add_new_user_section.get_user_group_storage_warning_message(type).should == message
end

Then /^I get mail domain from dea_services$/ do
  @domain_name = DBHelper.get_mail_domain_form_dea_services
end


#================================================
#Author : Thomas Yu
#Comment: 1. If machine_count < devices, then machine_count.
#         2. When there is sub partner invovled, search user requires <partner_filter> filter so that the user could be serached. Otherwise, pass "nil".
#Scope  : Used in mozyPro now.
#Example: And I add multiple users and use keyless activation to activate 3 device on each user and select nil on partner filter:
#            | name                 | user_group            | storage_type | storage_limit | devices | enable_stash |
#            | 90002_PA_UG0_User1 | (default user group) |  Desktop     |  1              |  2       | Yes          |  <-- create 2 machines
#            | 90002_PA_UG1_User1 | 90002_PA_group1       |  Desktop     |  1              |  4       | Yes          |  <-- create 3 machines
#Notice : If the scenario begins at searching partner instead of creating partner, see below example -
#           When do preparation before using keyless activation to activate MozyPro devices
#           And I add multiple users and use keyless activation to activate 3 device on each user and select nil on partner filter:
#              | name                 | user_group            | storage_type | storage_limit | devices | enable_stash |
#              | 90002_PA_UG0_User1 | (default user group) |  Desktop     |  1              |  2       | Yes          |
#================================================
When /^I add multiple users and use keyless activation to activate (.+) device on each user and select (.+) on partner filter:$/ do |machine_count, partner_filter, user_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  #======loop table to create each user and activate its machine======
  user_table.hashes.each do |hash|
    @new_users =[]
    @users =[]
    Log.debug "======create user " + hash["name"] + "======"
    hash['email'].replace ERB.new(hash['email']).result(binding) unless hash['email'].nil?
    hash['email'] = @existing_user_email if hash['email'] == '@existing_user_email'
    hash['email'] = @existing_admin_email if hash['email'] == '@existing_admin_email'
    user = Bus::DataObj::User.new
    hash_to_object(hash, user)
    @new_users << user
    @users << user
    @bus_site.admin_console_page.add_new_user_section.add_new_users(@new_users)

    #======search the user by the user name======
    @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
    if partner_filter == "nil"
      @bus_site.admin_console_page.search_list_users_section.search_user(@new_users.first.name)
    else
      @bus_site.admin_console_page.search_list_users_section.search_user(@new_users.first.name, '', partner_filter)
    end
    @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
    @bus_site.admin_console_page.search_list_users_section.view_user_details(@new_users.first.email[0..26])
    @current_user = @bus_site.admin_console_page.user_details_section.user #this is a required instance variable by API calling to activate device.

    #======update user password======
    Log.debug "Update the password with 'P@ssW0rD'"
    @user_password = "P@ssW0rD" #this is a required instances variable by API calling to activate device.
    @bus_site.admin_console_page.user_details_section.edit_password(@user_password)

    #======use keyless activation to activate devices======
    j = 0
    hash['deivces'].to_i < machine_count.to_i ? (j = hash['devices'].to_i) : (j = machine_count.to_i)
    Log.debug "=============="
    Log.debug j
    Log.debug "=============="
    for i in 1..j
      Log.debug "creating machine under #{@new_users.first.name}..."
      step %{I use keyless activation to activate devices}, table(%{
      | machine_name    | machine_type    | user_name  |
      | #{@new_users.first.name}_machine_#{i} | #{@new_users.first.storage_type} | #{@new_users.first.email} |
      })
      #======Update <Ecrtyption> option on machine, otherwise, the replace is not allowed between machines======
      machine_id = @new_clients[0].machine_id
      @client.set_machine_encryption("Default", machine_id)
    end
    #this step is required to close the user detail section, otherwise, duplicated name UI elem make execution failed.
    @bus_site.admin_console_page.user_details_section.close_bus_section
  end
end

And /^the new (MozyPro|MozyEnterPrise) user's default values should be:$/ do |type, default_value_tables|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  expected = default_value_tables.hashes.first
  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.add_new_user_section.get_new_user_default_values(type, expected["user_group"])
  expected.keys.each{ |key| actual[key].to_s.should == expected[key].to_s if key != "user_group" }
end

Then /^sync checkbox should be (visible|invisible) when creating a new itemized user$/ do |visible|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
  @bus_site.admin_console_page.add_new_itemized_user_section.sync_checkbox_visible == true if visible == "visible"
  @bus_site.admin_console_page.add_new_itemized_user_section.sync_checkbox_visible == false if visible == "invisible"
end