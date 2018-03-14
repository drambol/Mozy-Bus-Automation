#| server licences | server quota GB | desktop licences | desktop quota GB |
#| 10              | 50              | 5                | 25               |
When /^I transfer resources from user group (.+) to partner (.+) and user group (.+) with:$/ do |source_group, target_partner, target_group, resources_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['transfer_resources'])
  @source_group = source_group
  @target_group = target_group
  @target_partner = target_partner
  cells = resources_table.hashes.first
  @bus_site.admin_console_page.transfer_resources_section.transfer_resources(@source_group, @target_partner, @target_group, cells['server_licenses'], cells['server_storage'], cells['desktop_licenses'], cells['desktop_storage'])
end

Then /^Resources should be transferred$/ do
  if @target_partner == 'the same partner'
    @bus_site.admin_console_page.transfer_resources_section.messages.should == "Resources transferred from the #{@source_group} user group to the #{@target_group} user group."
  else
    @bus_site.admin_console_page.transfer_resources_section.messages.should == "Resources transferred from the #{@source_group} user group to the #{@target_group} user group under #{@target_partner}."
  end
end

When /^go to transfer resources and change the number of devices:$/ do |resource_table|
  attributes = resource_table.hashes.first
  source = attributes["source_group"] || "(default user group)"
  target = attributes["target_group"] || "(default user group)"
  server_device = attributes["server_device"] || 0
  desktop_device = attributes["desktop_device"] || 0

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['transfer_resources'])
  @bus_site.admin_console_page.transfer_resources_section.transfer_resources(source, target, server_device, 0, desktop_device, 0)

  @bus_site.admin_console_page.transfer_resources_section.messages.should == "Resources transferred from the #{source} user group to the #{target} user group."

  #Update resources of user_group instance (user centric)
  unless @user_group.nil?
    if @user_group.name == target
      @user_group.desktop_device += server_device.to_i
      @user_group.server_device += desktop_device.to_i
    end
  end
end

Then /^available key and storage (of group|of partner) (.+) from (source user group|target user group|target partner) should be (.+)/ do |input,name,type,value|
  if type == 'source user group'
    @bus_site.admin_console_page.transfer_resources_section.get_source_key_and_storage(name).should include(value)
  elsif type == 'target user group'
    @bus_site.admin_console_page.transfer_resources_section.get_target_key_and_storage(name).should include(value)
  else
    @bus_site.admin_console_page.transfer_resources_section.get_target_partner_key_and_storage(name).should include(value)
  end
end

And /^I select (.+) as target partner$/ do |name|
  @bus_site.admin_console_page.transfer_resources_section.select_target_partner(name)
end
