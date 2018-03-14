When /^I add a account attribute key:$/ do |account_attr_key_table|
  attributes = account_attr_key_table.hashes.first
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_account_attribute_key'])
  @bus_site.admin_console_page.add_account_attribute_key_section.add_account_attribute_key(attributes)
end

