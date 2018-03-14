When /^I update an existing promotion:$/ do |promo_table|
  attributes = promo_table.hashes.first
  @bus_site.admin_console_page.promotion_details_view_section.update_promotion(attributes)
end

Then /^promotion is updated/ do
  @bus_site.admin_console_page.promotion_details_view_section.get_update_success_message.should == "Changes saved successfully"
end

Then /^I delete promotion$/ do
  @bus_site.admin_console_page.promotion_details_view_section.delete_promotion
end