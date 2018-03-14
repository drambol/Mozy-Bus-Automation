When /^I click (CSS|Images\/Icons|Footer|Text|Error Pages|Static Content) tab in Admin Console Branding section$/ do |tab|
  @bus_site.admin_console_page.branding_section.console_iframe.select_tab(tab)
end

And /^I open admin console text setting for header$/ do
  @bus_site.admin_console_page.branding_section.console_iframe.open_header_text
end

And /^I set Dashboard Link Text to (.+)/ do |text|
  @bus_site.admin_console_page.branding_section.console_iframe.input_dashboard_link_text(text)
end

And /^I clear text area of Dashboard Link Text$/ do
  @bus_site.admin_console_page.branding_section.console_iframe.input_dashboard_link_text()
end

When /^I click dashboard link in global nav links on right top side$/ do
  @bus_site.admin_console_page.click_dashboad_link
end

Then /^dashboard link text in global nav area should be (.+)/ do |text|
  @bus_site.admin_console_page.get_dashboard_link_text.should == text
end