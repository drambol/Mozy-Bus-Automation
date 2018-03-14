When /^I list versions for:$/ do |table|
  @list_version_condition = table.hashes.first
  @bus_site.admin_console_page.list_versions_section.list_version(@list_version_condition)
end

Then /^I can find the version info in versions list:$/ do |table|
  actual = @bus_site.admin_console_page.list_versions_section.version_list_table_hash
  expected = table.hashes
  expected.each{ |key| (actual.include?(key)).should be_true}
end

When /^I view version details for (.+)$/ do |version_number|
  @bus_site.admin_console_page.list_versions_section.view_version(version_number)
end

And /^I delete version (.+) if it exists$/ do |version_number|
  if @bus_site.admin_console_page.list_versions_section.version_listed?(version_number)
    @bus_site.admin_console_page.list_versions_section.view_version(version_number)
    @bus_site.admin_console_page.version_show_section.delete_version
    time_begin_delete = Time.now
    100.times do
      Log.debug "version delete begins at #{time_begin_delete}, now is #{Time.now}"
      @bus_site.admin_console_page.list_versions_section.list_version(@list_version_condition)
      break unless @bus_site.admin_console_page.list_versions_section.version_listed?(version_number)
      sleep(30)
    end
  end
end

Then /^I should not see version (.+) in version list$/ do |version_number|
  @bus_site.admin_console_page.list_versions_section.version_listed?(version_number).should be_false
end

And /^I get (1|2) enabled (win-sync|mac-sync|linux) version(| for (.+)?)$/ do |number, _,__, arch|
  version_info = @bus_site.admin_console_page.list_versions_section.version_list_table_hash
  if arch
    arch_version = []
    version_info.each do |version|
      arch_version << version if version['Name'].include?(arch)
    end
  else
    arch_version = version_info
  end
  @version_name = arch_version[0]['Name']
  @version = arch_version[0]['Version']
  Log.debug @version_name
  if number == '2'
    @version_name2 = arch_version[1]['Name']
    @version2 = arch_version[1]['Version']
    Log.debug @version_name2
  end
end