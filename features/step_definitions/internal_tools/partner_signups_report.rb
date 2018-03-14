Then /^Partner Signups Report table header should be:$/ do |partner_signups_report_table_headers|
  @bus_site.admin_console_page.partner_signups_report_section.partner_signups_report_headers.should == partner_signups_report_table_headers.raw.first
end

When /^I export partner signups report$/ do
  @bus_site.admin_console_page.partner_signups_report_section.click_export_to_excel
end

Then /^I search partner on partner signups report by:$/ do |search_key_table|
  attributes = search_key_table.hashes.first
  keywords = attributes["name"]
  keywords.replace ERB.new(keywords).result(binding)
  @bus_site.admin_console_page.partner_signups_report_section.search_partner_on_partner_signups_report(keywords)
end

Then /^I view parter details on signup partner report by (.+)$/ do | partner_name |
  @bus_site.admin_console_page.partner_signups_report_section.view_partner_details(partner_name)
end

And /^I click clear search$/ do
  @bus_site.admin_console_page.partner_signups_report_section.click_clear_search
end

And /^I find the partner (.+) in downloaded csv$/ do | partner |
  @bus_site.admin_console_page.partner_signups_report_section.search_partner_in_csv(partner).should == true
end