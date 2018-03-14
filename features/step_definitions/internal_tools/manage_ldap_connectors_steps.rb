Then /^I would like to add a new version:$/ do |table|
  attributes = table.hashes.first
  attributes.each do |header, attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if (attribute == '' && !attributes.has_key?("security") )
  end

  @version = attributes["version"]
  @platform = attributes["platform"]
  @os = attributes["OS Architecture"]
  @status = attributes["status"]
  @installation_file = attributes["file name"]

  @bus_site.admin_console_page.manage_ldap_connectors_section.click_add_new_version_button
  @bus_site.admin_console_page.add_new_version_section.add_new_version(@version, @platform, @os, @status, @installation_file)
end

When /^I edit the client installation file:$/ do |table|
  attributes = table.hashes.first
  attributes.each do |header, attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if (attribute == '' && !attributes.has_key?("security") )
  end

  @installation_file = attributes["file name"]
  @bus_site.admin_console_page.add_new_version_section.edit_client_version_by_installation_file(@version, @installation_file)
end

When /^I edit the client status:$/ do |table|
  attributes = table.hashes.first
  attributes.each do |header, attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if (attribute == '' && !attributes.has_key?("security") )
  end

  @status = attributes["status"]
  @bus_site.admin_console_page.add_new_version_section.edit_client_version_by_status(@version, @status)
end

When /^I should see the new added client version$/ do
  version_convert = @version.gsub('.', '_')
  installation_file = 'LDAPConnector-' + version_convert + '-' + @platform + '_' + @os + '.' + @installation_file.split(".")[1]
  @bus_site.admin_console_page.manage_ldap_connectors_section.wait_until_bus_section_load
  @bus_site.admin_console_page.manage_ldap_connectors_section.get_client_info(@version, 'Installation File').should == installation_file
end

When /^I should see the installation file is updated successfully$/ do
  version_convert = @version.gsub('.', '_')
  installation_file = 'LDAPConnector-' + version_convert + '-' + @platform + '_' + @os + '.' + @installation_file.split(".")[1]
  @bus_site.admin_console_page.manage_ldap_connectors_section.wait_until_bus_section_load
  @bus_site.admin_console_page.manage_ldap_connectors_section.get_client_info(@version, 'Installation File').should == installation_file
end

When /^I should see the new client version status is updated successfully$/ do
  @bus_site.admin_console_page.manage_ldap_connectors_section.wait_until_bus_section_load
  @bus_site.admin_console_page.manage_ldap_connectors_section.get_client_info(@version, 'Status').should == @status
end

When /^I delete the new added LDAP Connector version$/ do
  @bus_site.admin_console_page.manage_ldap_connectors_section.wait_until_bus_section_load
  @bus_site.admin_console_page.manage_ldap_connectors_section.delete_version(@version)
end

When /^the new added version should be removed$/ do
  @bus_site.admin_console_page.manage_ldap_connectors_section.wait_until_bus_section_load
  @bus_site.admin_console_page.manage_ldap_connectors_section.check_version_existence(@version).should == false
end