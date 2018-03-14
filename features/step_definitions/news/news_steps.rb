When /^I check the new window title is (.+)$/ do |match|
  @bus_site.admin_console_page.get_new_window_page_title.should include (match)
end


Then /^I check the feature (.+) is existed$/ do |id|
  @bus_site.admin_console_page.news_section.find_div_is_visiable(id)
end
