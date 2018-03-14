# Steps included:
#   click 'Search / List Partners' link
#   fill in newly created admin email and click search
#   click newly created  admin email to get admin detail view
#   click 'Act Admin' link
#   fill in password with default password (in bus config file)
#   fill in confirm password with default password
#   click 'Save Changes'
#
When /^I activate new partner admin with (default password|Hipaa password)$/ do |password|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  @bus_site.admin_console_page.admin_details_section.activate_admin(password, password)
end

When /^I view the newly created (sub)*partner admin details$/ do |sub|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  if sub
    @bus_site.admin_console_page.search_list_partner_section.search_partner(@subpartner.admin_email_address)
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@subpartner.admin_email_address)
  else
    @bus_site.admin_console_page.search_list_partner_section.search_partner(@partner.admin_info.email)
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(@partner.admin_info.email)
  end
  @bus_site.admin_console_page.admin_details_section.wait_until_bus_section_load
end

#Then /^I should see the (.+) link$/ do |link_name|
#  @bus_site.admin_console_page.admin_details_section.links.should inlcude(link_name);
#end

Then /^I will( not)? see the activate admin link$/ do |t|
  if t.nil?
    @bus_site.admin_console_page.admin_details_section.has_activate_admin_link?.should be_true
  else
    @bus_site.admin_console_page.admin_details_section.has_activate_admin_link?.should be_false
  end
end

When /^I view the admin details of (.+)$/ do |admin|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_admins'])
  @bus_site.admin_console_page.list_admins_section.refresh_bus_section
  @bus_site.admin_console_page.list_admins_section.wait_until_bus_section_load
  @bus_site.admin_console_page.list_admins_section.view_admin(admin)
  @bus_site.admin_console_page.list_admins_section.wait_until_bus_section_load
end

When /^I get the (admin|subadmin) id from (partner|admin) details$/ do |type, section|
  if section == 'partner'
    if type == 'admin'
      @bus_site.admin_console_page.partner_details_section.find_link(@partner.admin_info.full_name).click
    else
      @bus_site.admin_console_page.partner_details_section.subpartner.find_link(@subpartner.admin_name).click
    end
  end
  @admin_id = @bus_site.admin_console_page.admin_details_section.admin_id
  Log.debug("admin id is #{@admin_id}")
end

When /^edit admin details:$/ do |info_table|
  # table is a | email          | name          | parent admin     |
  new_info = info_table.hashes.first
  new_info.keys.each do |header|
    case header
      when 'Email:'
        new_info[header] = @existing_user_email if new_info[header] == '@existing_user_email'
        new_info[header] = @existing_admin_email if new_info[header] == '@existing_admin_email'
        @bus_site.admin_console_page.admin_details_section.set_admin_email(new_info[header])
      when 'Name:'
        @bus_site.admin_console_page.admin_details_section.set_admin_name(new_info[header])
      when 'Parent Admin:'
        @bus_site.admin_console_page.admin_details_section.set_admin_parent(new_info[header])
      else
        raise "Unexpected header for #{new_info[header]}"
    end
  end
  @bus_site.admin_console_page.admin_details_section.save_admin_info_changes
end

Then /^admin name in admin details should be (.+)$/ do |admin_name|
  @bus_site.admin_console_page.admin_details_section.admin_name.should == admin_name
end

When /^edit sub admin personal information success message should display$/ do
  @bus_site.admin_console_page.admin_details_section.admin_info_box_message.should == "Changes saved successfully."
end

When /^edit sub admin personal information error message\(s\) should be:$/ do |message|
  @bus_site.admin_console_page.admin_details_section.admin_info_box_message.should == message.to_s
end

When /^I close the admin details section$/ do
  @bus_site.admin_console_page.admin_details_section.close_bus_section
end

Then /^Admin information in List Admins section should be correct$/ do |admin_info|
  attributes = admin_info.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.list_admins_section.list_admins_table_hashes
  expected = admin_info.rows
  actual.should == expected
end

When /^I delete admin with (default password|Hipaa password|reset password|Standard password|bus admin password)$/ do |pwd|
  pwd = QA_ENV['bus_password'] if pwd == 'bus admin password'
  @alert_text = @bus_site.admin_console_page.admin_details_section.delete_admin(pwd)
end

When /^I delete admin then cancel, the confirm message on the popup will be$/ do |msg|
  @bus_site.admin_console_page.admin_details_section.delete_admin_cancel.strip.should == msg.strip
end

Then /^error message when delete admin will be$/ do |msg|
  @alert_text.strip.should == msg.strip
end

Then /^I should (not|can) search out admin record$/ do |type|
  if type == 'not'
    expected = true
  else
    expected = false
  end
  @bus_site.admin_console_page.search_admins_section.search_admin_table_empty.should == expected
end

When /^I change admin password to (.+)$/ do |password|
  @bus_site.admin_console_page.admin_details_section.change_admin_pwd(password)
end

Then /^I can change (.+) password successfully$/ do |admin|
  admin = @admin.name if admin == 'admin'
  string = "The password for " + admin + " has been changed."
  @bus_site.admin_console_page.admin_details_section.change_admin_pwd_msg.strip.should == string
end

When /^I active admin in admin details (.+)$/ do |password|
  @bus_site.admin_console_page.admin_details_section.activate_admin(password, password)
end

When /^(Fail|Succeed) to update admin password and the message should be (.+)$/ do |type, message|
  @bus_site.admin_console_page.admin_details_section.change_admin_pwd_msg.strip.should == message.strip
end

Then /^I will see this admin has access to these user groups$/ do |user_groups|
  attributes = user_groups.hashes.first
  ug_array = attributes['user_groups'].split(',')
  actual_groups = @bus_site.admin_console_page.admin_details_section.get_admin_groups
  actual_groups.should == ug_array
end

And /^I add or remove user groups$/ do |user_groups|
  add_ug_array = []
  remove_ug_array = []
  attributes = user_groups.hashes.first
  add_ug_array = attributes['add'].split(',') unless attributes['add'].nil?
  remove_ug_array = attributes['remove'].split(',') unless attributes['remove'].nil?
  @bus_site.admin_console_page.admin_details_section.add_remove_admin_groups(add_ug_array, remove_ug_array)
end

Then /^I can save admin groups successfully$/ do
  @bus_site.admin_console_page.admin_details_section.add_remove_admin_groups_save_msg.should == 'User group updated successfully.'
end

Then /^I click here to re-send activation email in admin details section$/ do
  @bus_site.admin_console_page.admin_details_section.click_here
end

And /^I add admin external id$/ do
  @admin_external_id = "#{Time.now.strftime('%m%d-%H%M-%S')}"
  @bus_site.admin_console_page.admin_details_section.change_admin_external_id(@admin_external_id)
end
