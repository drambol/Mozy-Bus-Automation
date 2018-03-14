When /^I click (copy all of your inherited dialects|start with the default) link in List Dialects section$/ do |link|
  @bus_site.admin_console_page.dialect_section.click_add_dialect_link(link)
  @bus_site.admin_console_page.dialect_section.wait_until_bus_section_load
end

Then /^dialects table should be:$/ do |table|
  actual = @bus_site.admin_console_page.dialect_section.dialect_list_table_hashes
  Log.debug actual
  expected = table.hashes
  expected.each{ |key| (actual.include?(key)).should be_true}
end

When /^I add a dialect:$/ do |table|
  dialect_info = table.hashes.first
  dialect_info.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  @bus_site.admin_console_page.dialect_section.add_dialect(dialect_info)
  @bus_site.admin_console_page.dialect_section.wait_until_bus_section_load
end

And /^I delete dialect of (.+)$/ do |dialect|
  @bus_site.admin_console_page.dialect_section.delete_dialect(dialect)
  @bus_site.admin_console_page.dialect_section.wait_until_bus_section_load
end