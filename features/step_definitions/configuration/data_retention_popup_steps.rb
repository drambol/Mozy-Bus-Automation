Then /^default adr policy name on popup dialog should be (.+)$/ do |adr_policy_name|
  @bus_site.admin_console_page.data_retention_section_popup.popup_get_default_adr_policy_name.should == adr_policy_name
end

And /^I select adr policy on popup dialog to (.+) but click cancel button$/ do |adr_policy_name|
  @bus_site.admin_console_page.data_retention_section_popup.create_but_cancel_adr_policy_on_popup(adr_policy_name)
end

And /^I select adr policy on popup dialog to (.+) but input invalid password (.+)$/ do |adr_policy_name, password|
  @bus_site.admin_console_page.data_retention_section_popup.create_adr_policy_on_popup(adr_policy_name, password)
end

And /^I set adr policy on popup dialog to (.+)$/ do |adr_policy_name|
  @bus_site.admin_console_page.data_retention_section_popup.create_adr_policy_on_popup(adr_policy_name, QA_ENV['bus_password'])
end