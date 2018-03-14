Then /^SMTP Settings change message should be: (.+)$/ do |msg|
  @bus_site.admin_console_page.smtp_settings_section.smtp_setting_change_message.include?(msg).should be_true
end

When /^I input new SMTP Setting:$/ do |table|
  setting = table.hashes.first
  @bus_site.admin_console_page.smtp_settings_section.input_new_smtp_setting(setting)
end

And /^I click SMTP Setting save changes button$/ do
  @bus_site.admin_console_page.smtp_settings_section.save_smtp_setting
end

Then /^SMTP Setting should be:$/ do |table|
  actual = @bus_site.admin_console_page.smtp_settings_section.get_smtp_setting
  Log.debug actual
  expected = table.hashes.first
  expected.each_key {|key| actual[key].should == expected[key]}
end

And /^I (cleanup|delete) SMTP Setting$/ do |option|
  @bus_site.admin_console_page.smtp_settings_section.delete_smtp_setting(option == 'delete')
end

And /^I refresh SMTP Settings section$/ do
  @bus_site.admin_console_page.smtp_settings_section.refresh_bus_section
end
