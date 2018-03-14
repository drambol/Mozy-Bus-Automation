And /^I record the (MozyPro|MozyEnterprise|Reseller|OEM) partner name (.+) and admin name (.+)$/ do |type,partner_name, admin_name|
  case type
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyPro.new
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @partner = Bus::DataObj::MozyEnterprise.new
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::Reseller.new
    else
  end
  @partner.partner_info.type = type
  @partner.admin_info.full_name = admin_name
  @partner.company_info.name = partner_name
end

When /^I got client config for the user machine:$/ do |table|
  machine_table = table.hashes.first
  machine_table.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  machine_table['root_admin_id'] = @admin_id
  #for sync machine
  machine_table['machine'] = "user_#{@user_id}_sync" if machine_table['machine'] == '@user_id'
  user_hash = Digest::SHA1.hexdigest(machine_table['root_admin_id'].to_s + " " + machine_table['user_name'].to_s)
  user_password = machine_table.has_key?('user_password')? machine_table['user_password'] : CONFIGS['global']['test_pwd']
  @get_client_config_response = get_client_config_info(user_hash, user_password, machine_table['machine'],
                                                       machine_table['codename'], machine_table['platform'], machine_table['arch'], machine_table['version'])
end

Then /^client config (should|should not) contains:$/ do |option, table|
  actual = @get_client_config_response
  expected = table.hashes.first
  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  unless actual['update-url'].nil?
    billing_ver = actual['update-url'][/(\d)+\./]
    actual['update-url'] = actual['update-url'].gsub(billing_ver, 'XXXXX.')
  end
  unless actual['update-manual-url'].nil?
    billing_ver = actual['update-manual-url'][/(\d)+\./]
    actual['update-manual-url'] = actual['update-manual-url'].gsub(billing_ver, 'XXXXX.')
  end

  if option == 'should'
    expected.keys.each{ |key| actual[key].should == expected[key] }
  elsif option == 'should not'
    expected.keys.each{ |key| actual[key].should == nil }
  end
end

Then /^there is no field for (.+) in edit client version section$/ do |text|
  section_text = @bus_site.admin_console_page.edit_client_version_section.text
  section_text.include?(text).should be_false
  section_text.include?(text.downcase).should be_false
end

# steps for partner without edit user group capability

Then /^there is no (.+) rule in client rule fieldset$/ do |version|
  @bus_site.admin_console_page.edit_client_version_section.fieldset_contain_rule?(version).should be_false
end

Then /^upgrade rule should contains:$/ do |table|
  actual = @bus_site.admin_console_page.edit_client_version_section.upgrade_rules_hash
  expected = table.hashes.first
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

Then /^the set default client version note should be:$/ do |messages|
  @bus_site.admin_console_page.edit_client_version_section.set_default_message.should == messages.to_s
end

Then /^I (can see|select) version (.+) in option list for rule (win|mac|win-sync|mac-sync|linux:deb-32|linux:deb-64|linux:rpm-32|linux:rpm-64)$/ do |action, version, arch|
  case action
    when "can see"
      @bus_site.admin_console_page.edit_client_version_section.rule_has_option?(version, arch).should be_true
    when "select"
      @bus_site.admin_console_page.edit_client_version_section.update_rule(version, arch)
      @bus_site.admin_console_page.edit_client_version_section.wait_until_bus_section_load
    else
  end
end

And /^client rule updated message should be (.+)/ do |message|
  @bus_site.admin_console_page.edit_client_version_section.rule_updated_message.should == message
end

# steps for partner with edit user group capability

Then /^there is( no)? rule for (.+) in Client Version Rules$/ do |has_rule, version|
  if has_rule == ' no'
    @bus_site.admin_console_page.edit_client_version_section.rules_contain_version?(version).should be_false
  else
    @bus_site.admin_console_page.edit_client_version_section.rules_contain_version?(version).should be_true
  end
end

Then /^there is( no)? version (.+) in Update to list$/ do |has_version, version|
  if has_version == ' no'
    @bus_site.admin_console_page.edit_client_version_section.upgrade_to_contain_version?(version).should be_false
  else
    @bus_site.admin_console_page.edit_client_version_section.upgrade_to_contain_version?(version).should be_true
  end
end

When /^I add a new rule in Edit Client Version:$/ do |table|
  upgrade_rule = table.hashes.first
  @bus_site.admin_console_page.edit_client_version_section.add_new_rule(upgrade_rule)
  @bus_site.admin_console_page.edit_client_version_section.wait_until_bus_section_load
end

Then /^Client Version Rules (should|should not) include rule:$/ do |type, table|
  actual = @bus_site.admin_console_page.edit_client_version_section.client_version_rules_hash
  expected = table.hashes
  Log.debug actual
  if type == 'should'
    expected.each{ |key| (actual.include?(key)).should be_true}
  else
    expected.each{ |key| (actual.include?(key)).should be_false}
  end
end

And /^I delete client version rule for (.+) if it exists$/ do |version|
  @bus_site.admin_console_page.edit_client_version_section.delete_rule(version)
  @bus_site.admin_console_page.edit_client_version_section.wait_until_bus_section_load
end

When /^I select version (.+) in Update To list$/ do |version|
  @bus_site.admin_console_page.edit_client_version_section.select_version(version)
end

Then /^Operating System should include OS:$/ do |table|
  expected = table.headers
  actual = @bus_site.admin_console_page.edit_client_version_section.os_options('min')
  expected.each{ |key| (actual.include?(key)).should be_true}
  actual = @bus_site.admin_console_page.edit_client_version_section.os_options('max')
  expected.each{ |key| (actual.include?(key)).should be_true}
end

Then /^User Group selector should include:$/ do |table|
  actual = @bus_site.admin_console_page.edit_client_version_section.user_group_options
  expected = table.headers
  expected.each{ |key| (actual.include?(key)).should be_true}
end

And /^I refresh Edit Client Version section$/ do
  @bus_site.admin_console_page.edit_client_version_section.refresh_bus_section
end
