When /^I edit account attribute key:$/ do | account_attribute_key_table|
  attributes = account_attribute_key_table.hashes.first
  @bus_site.admin_console_page.account_attribute_key_details_section.edit_account_attribute_key(attributes)
end

And /^I change account attribute key (.+) component to (.+) directly through db$/ do | key, component |
  DBHelper.update_account_attribute_key(key, component)
end

And /^I delete the account attribute key (.+) directly through db$/ do | key |
  DBHelper.delete_account_attribute_key(key)
end