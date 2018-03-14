And /^I add a new client version:$/ do |table|
  version_info = table.hashes.first
  @bus_site.admin_console_page.create_new_version_section.add_new_version(version_info)
end

Then /^the client version should be created successfully$/ do
  @bus_site.admin_console_page.create_new_version_section.version_saved_success_message == 'Version added successfully'
end