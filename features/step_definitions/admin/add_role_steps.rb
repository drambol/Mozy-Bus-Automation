When /^I add a new role(| without saving):$/ do |type, table|
  # table is a | ATC695 |pending
  role_hash = table.hashes.first
  role_hash.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  @role = Bus::DataObj::Role.new(role_hash['Type'], role_hash['Name'], role_hash['Parent'], role_hash['User Group'])
  save = true
  save = false if type == ' without saving'
  @ug_search_result = @bus_site.admin_console_page.add_new_role_section.add_new_role(@role, save)
end

And /^I save the role$/ do
  @bus_site.admin_console_page.add_new_role_section.click_save_changes_button
end

When /^I add a new role$/ do
  @role = Bus::DataObj::Role.new
  @bus_site.admin_console_page.add_new_role_section.add_new_role(@role)
end


Then /^(Add|Edit) admin role message will be (.+)$/ do |type,msg|
  if type == 'Add'
    actual_msg = @bus_site.admin_console_page.add_new_role_section.messages
  else
    actual_msg = @bus_site.admin_console_page.edit_role_section.messages_edit
  end
  actual_msg.strip.should == msg
end

When /^I add capabilities for the new role:$/ do |table|
  # table is a | Partners: add |pending
  capability_table = table.raw
  @bus_site.admin_console_page.add_new_role_section.add_capabilities(capability_table[1..-1])
end

When /^I (check|uncheck) all the capabilities for the new role$/ do | check |
  if check == 'check'
    @bus_site.admin_console_page.role_details_section.add_all_available_capabilities
  elsif check == 'uncheck'
    @bus_site.admin_console_page.role_details_section.uncheck_all_capabilities
  end
end

When /^I delete role (.+)$/ do | role_name |
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_roles'])
  role_name = @role.name if role_name == '@role_name'
  @bus_site.admin_console_page.list_roles_section.list_role(role_name)
  @bus_site.admin_console_page.role_details_section.delete_role(role_name)
end

When /^I clean all roles with name which started with "([^"]+)"$/ do |prefix|
  @bus_site.admin_console_page.list_roles_section.wait_until_bus_section_load
  names = @bus_site.admin_console_page.list_roles_section.all_role_name_started_with(prefix).map(&:text)
  Log.debug "to clear #{names.inspect}"
  names.each do |name|
    step %{I delete role #{name}}
  end
end

When /^I refresh the add new role section$/ do
  @bus_site.admin_console_page.add_new_role_section.refresh_bus_section
  @bus_site.admin_console_page.add_new_role_section.wait_until_bus_section_load
end

When /^I close the role details section$/ do
  @bus_site.admin_console_page.role_details_section.close_bus_section
end

Then /^I (can|can not) find role (.+) in list roles section$/ do |can, role|
  if can == 'can'
    @bus_site.admin_console_page.list_roles_section.find_role(role).should == true
  elsif can == 'can not'
    @bus_site.admin_console_page.list_roles_section.find_role(role).should == false
  end
end

And /^I click role (.+) in list roles section to view details$/ do |role_name|
  @bus_site.admin_console_page.list_roles_section.list_role(role_name)
end

Then /^Edit admin role save message will be (.+)$/ do |msg|
  @bus_site.admin_console_page.role_details_section.save_cap_msg.strip.should == msg
end

And /^I add admins to an admin role$/ do |table|
  admins_table = table.raw
  @bus_site.admin_console_page.role_details_section.open_role_sub_tab('Members')
  @bus_site.admin_console_page.role_details_section.add_remove_admins('add', admins_table[1..-1])
end

And /^I remove admins from an admin role$/ do |table|
  admins_table = table.raw
  @bus_site.admin_console_page.role_details_section.open_role_sub_tab('Members')
  @bus_site.admin_console_page.role_details_section.add_remove_admins('remove', admins_table[1..-1])
end

And /^Admins listed in the tab of members of admin role will be$/ do |admins_table|
  admins_table = admins_table.raw
  actual_admins = @bus_site.admin_console_page.role_details_section.get_admins_of_role
  expected_admins = admins_table[1..-1]
  if expected_admins[0][0] == ''
    actual_admins.size.should == 0
  else
    actual_admins.each_with_index do |value, index|
      value.should == expected_admins[index][0]
    end
  end
end

And /^I click export admin roles to excel button and download the report$/ do
  FileHelper.delete_csv('roles')
  @bus_site.admin_console_page.list_roles_section.click_export_button
  @bus_site.admin_console_page.list_roles_section.export_roles_csv
end

Then /^The exported admin roles csv file should be like$/ do |report_table|
  report_table.map_column!('column 2') do |value|
    value.gsub(/@company.name/,@partner.company_info.name)
  end
  actual_csv = @bus_site.admin_console_page.list_roles_section.read_roles_csv
  actual_csv.should eql report_table.rows
end

And /^The user group value is (.+)$/ do |group_value|
  @bus_site.admin_console_page.edit_role_section.get_user_group_value.should == group_value
end

And /^I edit a role(| without saving)$/ do |action, table|
  role_hash = table.hashes.first
  user_group = role_hash['User Group']
  role_name = role_hash['Name']
  save = true
  save =false if action == ' without saving'
  @ug_search_result = @bus_site.admin_console_page.edit_role_section.edit_role(role_name, user_group, save)
end

Then /^config groups search result should be$/ do |user_groups|
  ug_hash = user_groups.hashes.first
  expected_ug = ug_hash["user groups"].split("\;")
  expected_ug.map{|value|value.strip}
  (expected_ug - @ug_search_result).size.should == 0
end

Then /^config group field should not be editable and can not do search$/ do
  @bus_site.admin_console_page.add_new_role_section.check_editable_ug_field.should == false
end

