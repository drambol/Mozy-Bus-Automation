When /^I search account attribute key (.+)$/ do | account_attribute_key_name |
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_account_attribute_keys'])
  @bus_site.admin_console_page.list_account_attribute_keys_section.search_account_attribute_key(account_attribute_key_name)
end

And /^I get account attribute key (.+) info(| from edit account attribute key section):$/ do | account_attribute_key_name, from_edit, account_attribute_key_details|
  attributes = account_attribute_key_details.hashes.first
  if from_edit == ''
    @bus_site.admin_console_page.list_account_attribute_keys_section.get_account_attribute_key_info(account_attribute_key_name).should == attributes
  else
    @bus_site.admin_console_page.account_attribute_key_details_section.get_account_attribute_key_info_from_edit_section(account_attribute_key_name).should == attributes
  end
end

And /^I delete account attribute key (.+)$/ do | account_attribute_key_name |
  @bus_site.admin_console_page.list_account_attribute_keys_section.delete_account_attribute_key(account_attribute_key_name)
end

And /^I should(| not) find account attribute key (.+)$/ do |should, account_attribute_key_name |
  if should == ''
    @bus_site.admin_console_page.list_account_attribute_keys_section.find_account_attribute_key(account_attribute_key_name).size.should > 0
  else
    @bus_site.admin_console_page.list_account_attribute_keys_section.find_account_attribute_key(account_attribute_key_name).size.should == 0
  end
end