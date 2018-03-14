
# Create a new bundled user group
#
# Bundled step available column names:
# | name      | storage_type | assigned | max      | server_support | enable_stash |
# Itemized step available column names:
# | name      | desktop_storage_type | desktop_assigned | desktop_max | desktop_devices | enable_stash |
# | server_storage_type | server_assigned | server_max | server_devices |
#
When /^I (add|edit) (.+) (Bundled|Itemized) user group:$/ do |action, group_name, type, ug_table|
  cells = ug_table.hashes.first

  #Instance variable created to record the ug creation time
  #  - start time: in 'When /^I (add|edit) (.+) (Bundled|Itemized) user group:$/ do |action, group_name, type, ug_table|'
  #  - end time: in 'Then /^(.+) user group should be (created|updated|deleted)$/ do |ug, action|'
  @create_ug_start_time = 0

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['user_group_list'])

  case action
    when 'add'
      @bus_site.admin_console_page.user_group_list_section.view_add_group_section
    when 'edit'
      @bus_site.admin_console_page.user_group_list_section.edit_user_group(group_name)
    else
      # Skipped
  end

  case type
    when 'Bundled'
      @new_bundled_ug = Bus::DataObj::BundledUserGroup.new
      hash_to_object(cells, @new_bundled_ug)
      case action
        when 'add'
          @create_ug_start_time = Time.now.utc
          @bus_site.admin_console_page.add_new_user_group_section.add_edit_bundled_user_group(@new_bundled_ug)
        when 'edit'
          @bus_site.admin_console_page.edit_user_group_section.add_edit_bundled_user_group(@new_bundled_ug)
        else
          # Skipped
      end
    when 'Itemized'
      @new_itemized_ug = Bus::DataObj::ItemizedUserGroup.new
      hash_to_object(cells, @new_itemized_ug)
      case action
        when 'add'
          @create_ug_start_time = Time.now.utc
          @bus_site.admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(@new_itemized_ug)
        when 'edit'
          @bus_site.admin_console_page.edit_user_group_section.add_edit_itemized_user_group(@new_itemized_ug)
        else
          # Skipped
      end
    else
      # Skipped
  end
end

# Create a user group for an itemized partner
#
# Itemized step available column names:
# | name      | desktop_storage_assigned | server_storage_assigned | server_devices |
#
When /^I (add|edit) a new user group for an itemized partner:$/ do |action, ug_table|
  cells = ug_table.hashes.first

  case action
    when 'add'
      @new_itemized_ug = Bus::DataObj::ItemizedUserGroup.new
      hash_to_object(cells, @new_itemized_ug)
      @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user_group'])
      @bus_site.admin_console_page.add_new_itemized_user_group_section.add_itemized_partner_ug(@new_itemized_ug)

    when 'edit'
      @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
      @bus_site.admin_console_page.add_new_itemized_user_group_section.edit_itemized_partner_ug(@new_itemized_ug)
    else
      # Skipped
  end
end

Then /^(.+) user group should be (created|updated|deleted)$/ do |ug, action|

  #Instance variable created to record the ug creation time
  #  - start time: in 'When /^I (add|edit) (.+) (Bundled|Itemized) user group:$/ do |action, group_name, type, ug_table|'
  #  - end time: in 'Then /^(.+) user group should be (created|updated|deleted)$/ do |ug, action|'
  #@create_ug_start_time = 0
  @create_ug_end_time = 0
  d = 0
  case ug
    when 'Bundled'
      group_name = @new_bundled_ug.name
    when 'Itemized'
      group_name = @new_itemized_ug.name
    else
      group_name = ug
  end

  case action
    when 'created'
      @bus_site.admin_console_page.add_new_user_group_section.success_messages.should == "User Group #{group_name.strip} has been successfully created."
      @create_ug_end_time = Time.now.utc
      @bus_site.log("KPI-Create_User_Group:start_time:#{@create_ug_start_time}/end_time:#{@create_ug_end_time}")
      # Clear previous message
      @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
    when 'updated'
      @bus_site.admin_console_page.edit_user_group_section.success_messages.should == "User Group #{group_name.strip} has been successfully updated."
      # Clear previous message
      @bus_site.admin_console_page.edit_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.edit_user_group_section.wait_until_bus_section_load
    when 'deleted'
      @bus_site.admin_console_page.user_group_list_section.success_messages.should == "Successfully removed #{group_name}."
      # Clear previous message
      @bus_site.admin_console_page.user_group_list_section.refresh_bus_section
      @bus_site.admin_console_page.user_group_list_section.wait_until_bus_section_load
    else
      # Skipped
  end

end

Then /^Itemized partner user group (.+) should be (created|updated|deleted)$/ do |ug, action|
  case ug
    when 'Bundled'
      group_name = @new_bundled_ug.name
    when 'Itemized'
      group_name = @new_itemized_ug.name
    else
      group_name = ug
  end

  case action
    when 'created'
      @bus_site.admin_console_page.add_new_user_group_section.success_messages.should == "Created new user group #{group_name}"
      # Clear previous message
      @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
    when 'updated'
      @bus_site.admin_console_page.edit_user_group_section.success_messages.should == "Updated user group #{group_name}"
      # Clear previous message
      @bus_site.admin_console_page.edit_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.edit_user_group_section.wait_until_bus_section_load
    when 'deleted'
      @bus_site.admin_console_page.user_group_list_section.success_messages.should == "Successfully removed #{group_name}."
      # Clear previous message
      @bus_site.admin_console_page.user_group_list_section.refresh_bus_section
      @bus_site.admin_console_page.user_group_list_section.wait_until_bus_section_load
    else
      # Skipped
  end

end

Then /^(Add|Edit|Delete) user group error messages should be:$/ do |action, messages|
  case action
    when 'Add'
      @bus_site.admin_console_page.add_new_user_group_section.error_messages.split("\n").sort.should == messages.to_s.split("\n").sort
      # Clear previous message
      @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
    when 'Edit'
      @bus_site.admin_console_page.edit_user_group_section.error_messages.should == messages.to_s
      # Clear previous message
      @bus_site.admin_console_page.edit_user_group_section.refresh_bus_section
      @bus_site.admin_console_page.edit_user_group_section.wait_until_bus_section_load
    when 'Delete'
      @bus_site.admin_console_page.user_group_list_section.error_messages.should == messages.to_s
      # Clear previous message
      @bus_site.admin_console_page.user_group_list_section.refresh_bus_section
      @bus_site.admin_console_page.user_group_list_section.wait_until_bus_section_load
    else
      # Skipped
  end
end

Then /^I should see correct UI for (Bundled|Itemized) user group with:$/ do |type, ug_table|
  # Force to refresh add new user group section in case server enabled or stash enabled
  @bus_site.admin_console_page.add_new_user_group_section.refresh_bus_section
  @bus_site.admin_console_page.add_new_user_group_section.wait_until_bus_section_load
  cells = ug_table.hashes.first
  storage_type = cells['storage_type']
  enable_stash = cells['enable_stash'].downcase.eql?('yes')
  server_support = cells['server_support'].downcase.eql?('yes')
  case type
    when 'Bundled'
      @bus_site.admin_console_page.add_new_user_group_section.verify_add_bundled_user_group_ui(storage_type,enable_stash,server_support).should be_true
    when 'Itemized'
      @bus_site.admin_console_page.add_new_user_group_section.verify_add_itemized_user_group_ui(storage_type,enable_stash,server_support).should be_true
    else
      # Skipped
  end
end

Then /^I close edit user group section$/ do
  @bus_site.admin_console_page.edit_user_group_section.close_bus_section
end

