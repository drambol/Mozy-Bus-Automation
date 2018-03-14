And /^I login my support successfully$/ do
  sleep 30
  @bus_site.mysupport_page.logged_in
end

Then /^I click (.+) on contact section$/ do |link|
  @bus_site.admin_console_page.contact_section.click_link_in_contact_section(link)
end

Then /^I check link (.+) is exists$/ do |link|
  @bus_site.admin_console_page.contact_section.check_link(link)
end

Then /^I search with subject (.+)$/ do |subject|
  @bus_site.admin_console_page.contact_section.search_subject(subject)
end

Then /^The search results title should include (.+)$/ do |subject|
  sleep 20
  @bus_site.admin_console_page.contact_section.get_search_results_title.should include("search results for \"#{subject}\"")
end

