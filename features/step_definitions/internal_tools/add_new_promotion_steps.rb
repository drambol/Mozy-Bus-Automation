When /^I add a new promotion:$/ do |promotion_table|
  attributes = promotion_table.hashes.first
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_promotion'])
  @bus_site.admin_console_page.add_new_promotion_section.new_promotion(attributes)
end

Then /^new promotion is created$/ do
  @bus_site.admin_console_page.add_new_promotion_section.get_creation_success_message.should == "New promotion created"
end

