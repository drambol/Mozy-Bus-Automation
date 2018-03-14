And /^I view machine details for (.+)$/ do |machine_or_user|
  if !(machine_or_user.match(/^@.+$/).nil?)
    machine_or_user =  '<%=' + machine_or_user + '%>'
  end
  machine_or_user.replace ERB.new(machine_or_user).result(binding)
  @bus_site.admin_console_page.search_list_machines_section.view_machine_details(machine_or_user)
  @bus_site.admin_console_page.search_list_machines_section.wait_until_bus_section_load
end

And /^I view Sync details$/ do
  @bus_site.admin_console_page.user_details_section.view_sync_details
end

And /^I refresh Search List Machines section$/ do
  @bus_site.admin_console_page.search_list_machines_section.refresh_bus_section
end

And /^I search machine by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_machines'])
  attributes = search_key_table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  keywords = attributes["machine_name"] || attributes["user_email"] || attributes["keywords"]
  @bus_site.admin_console_page.search_list_machines_section.search_machine(keywords)
end

Then /^I should (not|can) search out machine record$/ do |type|
  if type == 'not'
    expected = true
  else
    expected = false
  end
  @bus_site.admin_console_page.search_list_machines_section.search_machine_empty.should == expected
end

Then /^replace machine message should be (.+)$/ do |msg|
  @bus_site.admin_console_page.search_list_machines_section.get_replace_machine_message.strip.should == msg
end

Then /^I clear machine search results$/ do
  @bus_site.admin_console_page.search_list_machines_section.click_clear_search
end

