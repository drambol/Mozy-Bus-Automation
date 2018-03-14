Then /^I should not see any (storage|device) error in resource summary$/ do |type|
  @bus_site.admin_console_page.resource_summary_section.send("has_#{type}_errors_div?").should be_false
end

Then /^I should see (Desktop|Server) (Storage|Device) error in resource summary$/ do |license, type|
  @bus_site.admin_console_page.resource_summary_section.send("#{type.downcase}_errors_div").text.should == "No #{license} #{type} Available"
end

Then /^I should see (Storage|Device) error in resource summary$/ do |type|
  @bus_site.admin_console_page.resource_summary_section.send("#{type.downcase}_errors_div").text.should == "No #{type} Available"
end
