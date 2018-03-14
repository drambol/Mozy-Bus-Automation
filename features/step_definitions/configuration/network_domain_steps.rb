And /^I (add|update) a network domain(| without saving)$/ do |action, save, table|
  domain_hash = table.hashes.first
  if action == 'add'
    @network_domain = Bus::DataObj::NetworkDomain.new
  end
  unless domain_hash['Domain GUID'].nil?
    @network_domain.guid = domain_hash['Domain GUID']
    @network_domain.guid = "#{Time.now.strftime("%m%d%H%M")}-9ABC-DEF0-#{Time.now.strftime("%H%M")}-56789ABCDEF0" if domain_hash['Domain GUID'] == 'auto_generate'
  end
  @network_domain.nd_alias = domain_hash['Alias'] unless domain_hash['Alias'].nil?
  @network_domain.ou = domain_hash['OU'] unless domain_hash['OU'].nil?
  @network_domain.user_group = domain_hash['User Group'] unless domain_hash['User Group'].nil?
  @network_domain.key_type = domain_hash['Key Typ'] unless domain_hash['Key Typ'].nil?
  save = (save == ' without saving'? false: true)
  @ug_search_result = @bus_site.admin_console_page.network_domain_section.add_update_network_domain(@network_domain,save,action)
end

Then /^user groups search result should be$/ do |user_groups|
  ug_hash = user_groups.hashes.first
  expected_ug = ug_hash["user groups"].split("\;")
  expected_ug.map{|value|value.strip}
  (expected_ug - @ug_search_result).size.should == 0
end

And /^I click edit network domain button$/ do
  @bus_site.admin_console_page.network_domain_section.click_edit
end

Then /^(Add|Edit) network domain message will be (.+)$/ do |_, msg|
  @bus_site.admin_console_page.network_domain_section.network_domain_message.should == msg
end

And /^Existing network domain record should be$/ do |table|
  expected = table.hashes
  actual = @bus_site.admin_console_page.network_domain_section.network_domain_record
  expected.each_index{ |index|
    expected[index].keys.each{ |key|
      expected[index][key].replace ERB.new(expected[index][key]).result(binding)
      expected[index][key] = "{#{expected[index][key]}}" if key == 'Domain'
      actual[index][key].should == expected[index][key]
    }
  }
end

And /^I remove the network domain record$/ do
  @bus_site.admin_console_page.network_domain_section.remove_network_domain
end

Then /^I can not find network domain record$/ do
  actual = all(:xpath, "//div[@id='setting-netdomains_list-content']/table")
  actual.size.should == 0
end