# MozyPro available columns:
# Optional: base plan, server plan, storage add-on, coupon
#
# MozyEnterprise available columns:
# Optional: users, server plan, storage add-on, coupon
#
# Reseller available columns:
# Optional: server plan, storage add-on
#
When /^I change (MozyPro|MozyEnterprise|Reseller|Itemized|MozyEnterprise DPS) account plan to:$/ do |type, plan_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['change_plan'])

  cells = plan_table.hashes.first
  base_plan = cells['base plan'] # MozyPro
  users = cells['users'] # MozyEnterprise
  server_plan = cells['server plan']
  storage_add_on = cells['storage add-on']
  coupon = cells['coupon']
  desktop_licenses = cells['desktop licenses'] #Itemized
  server_licenses = cells['server licenses'] #Itemized

  case type
    when 'MozyEnterprise'
      @change_plan_info = @bus_site.admin_console_page.change_plan_section.change_mozyenterprise_plan(users, server_plan, storage_add_on, coupon)
    when 'Reseller'
      @change_plan_info = @bus_site.admin_console_page.change_plan_section.change_reseller_plan(server_plan, storage_add_on)
    when 'MozyPro'
      @change_plan_info = @bus_site.admin_console_page.change_plan_section.change_mozypro_plan(base_plan, server_plan, storage_add_on, coupon)
    when "Itemized"
      @change_plan_info = @bus_site.admin_console_page.change_plan_section.change_itemized_plan(server_licenses, desktop_licenses)
    when 'MozyEnterprise DPS'
      @change_plan_info = @bus_site.admin_console_page.change_plan_section.change_mozyenterprise_dps_plan(base_plan)
    else
      raise "#{type} Company type not exist"
  end
end

When /^I cancel (MozyPro|MozyEnterprise|Reseller|Itemized|MozyEnterprise DPS) account plan to:$/ do |type, plan_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['change_plan'])

  cells = plan_table.hashes.first
  base_plan = cells['base plan'] # MozyPro

  case type
    when 'MozyEnterprise DPS'
      @bus_site.admin_console_page.change_plan_section.cancel_mozyenterprise_dps_plan(base_plan)
    else
      raise "#{type} Company type not exist"
  end
end

When /^I increase Itemized account plan by:$/ do |resources_table|
  cells = resources_table.hashes.first
  @current_itemized_resources = @bus_site.admin_console_page.change_plan_section.current_itemized_resources

  s_license = (cells["server license"] || 0).to_i
  s_quota = (cells["server quota"] || 0).to_i
  d_license = (cells["desktop license"] || 0).to_i
  d_quota = (cells["desktop quota"] || 0).to_i

  new_server_license = @current_itemized_resources[:server_license] + s_license
  new_server_quota = @current_itemized_resources[:server_quota] + s_quota
  new_desktop_license = @current_itemized_resources[:desktop_license] + d_license
  new_desktop_quota = @current_itemized_resources[:desktop_quota] + d_quota
  @bus_site.admin_console_page.change_plan_section.change_itemized_partner_plan(new_server_license, new_server_quota, new_desktop_license, new_desktop_quota)
end

Then /^Current itemized resources should (be|increase):$/ do |how, resources_table|
  @new_itemized_resources = @bus_site.admin_console_page.change_plan_section.current_itemized_resources
  cells = resources_table.hashes.first

  s_license = (cells["server license"] || 0).to_i
  s_quota = (cells["server quota"] || 0).to_i
  d_license = (cells["desktop license"] || 0).to_i
  d_quota = (cells["desktop quota"] || 0).to_i

  case how
    when 'increase'
      (@new_itemized_resources[:server_license] - @current_itemized_resources[:server_license]).should == s_license
      (@new_itemized_resources[:server_quota] - @current_itemized_resources[:server_quota]).should == s_quota
      (@new_itemized_resources[:desktop_license] - @current_itemized_resources[:desktop_license]).should == d_license
      (@new_itemized_resources[:desktop_quota] - @current_itemized_resources[:desktop_quota]).should == d_quota
    when 'be'
      @new_itemized_resources[:server_license].should == s_license
      @new_itemized_resources[:server_quota].should == s_quota
      @new_itemized_resources[:desktop_license].should == d_license
      @new_itemized_resources[:desktop_quota].should == d_quota
    else
      raise 'unknown error'
  end
end

# Success message depends on Manage Resources vs. Assigned Keys
# which is determined by the company type of the account
Then /^the (MozyPro|MozyEnterprise|Reseller|Itemized|MozyEnterprise DPS) account plan should be changed$/ do |type|
  case type
    when 'MozyEnterprise', 'Itemized', 'MozyPro', 'Reseller', 'MozyEnterprise DPS'
      @bus_site.admin_console_page.change_plan_section.messages.should =~ /Successfully changed plan\./
    else
      raise "#{type} Company type not exist"
  end
end

Then /^Current plan table should be:$/ do |resource_table|
  expected = resource_table.hashes
  actual = @bus_site.admin_console_page.change_plan_section.current_plan_table_hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^(MozyPro|MozyEnterprise|Reseller|Itemized) new plan should be:$/ do |type, new_plan_table|
  expected = new_plan_table.hashes.first
  base_plan = expected["base plan"]
  users = expected["users"]
  server_plan = expected["server plan"]
  add_on = expected["storage add-on"]
  reseller_quota = expected["reseller quota"]

  case type
    when 'MozyPro'
      @bus_site.admin_console_page.change_plan_section.mozypro_base_plan.should include base_plan unless base_plan.nil?
      @bus_site.admin_console_page.change_plan_section.server_plan_status.should == server_plan.capitalize unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?

    when 'MozyEnterprise'
      @bus_site.admin_console_page.change_plan_section.mozyenterprise_users.should == users unless users.nil?
      @bus_site.admin_console_page.change_plan_section.mozyenterprise_server_plan.should include server_plan unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?

    when 'Reseller'
      @bus_site.admin_console_page.change_plan_section.reseller_quota.should == reseller_quota unless reseller_quota.nil?
      @bus_site.admin_console_page.change_plan_section.server_plan_status.should == server_plan.capitalize unless server_plan.nil?
      @bus_site.admin_console_page.change_plan_section.storage_add_on.should == add_on unless add_on.nil?

    when 'Itemized'
      actual = @bus_site.admin_console_page.change_plan_section.itemized_current_plan_hash
      expected.keys.each do |key|
        actual[key].should == expected[key]
      end
    else
      raise "#{type} Company type not exist"
  end
end

Then /^Change plan charge summary should be:$/ do |charge_table|
  @change_plan_info.at(1).should == charge_table.headers
  @change_plan_info.at(2).should == charge_table.rows
end

And /^MozyEnterpriseDPS new plan should be (.+)$/ do |text|
  @bus_site.admin_console_page.change_plan_section.enterprise_dps_baseplan.should == text
end

Then /^Change plan charge message should be:$/ do |message|
  @change_plan_info.at(0).strip.should eq(message.strip)
end

Then /^MozyPro available base plans should be:$/ do |plans_table|
  @bus_site.admin_console_page.change_plan_section.mozypro_available_base_plans.should == plans_table.rows.flatten
end

Then /^MozyPro available base plans and price should be:$/ do |plans_table|
  @bus_site.admin_console_page.change_plan_section.mozypro_available_base_plans_price.should == plans_table.rows.flatten
end

And /^Add-ons price should be (.+)$/ do |text|
  @bus_site.admin_console_page.change_plan_section.mozypro_server_plan_price.should == text
end

Then /^Change Plan section should be visible$/ do
  @bus_site.admin_console_page.change_plan_section.section_visible?.should be_true
end

When /^I refresh Change Plan section$/ do
  @bus_site.admin_console_page.change_plan_section.refresh_bus_section
end

Then /^Reseller supplemental plans should be:$/ do |plans_table|
  actual = @bus_site.admin_console_page.change_plan_section.reseller_supp_plans_hash
  expected = plans_table.hashes.first
  expected.keys.each do |header|
    actual[header].should == expected[header]
  end
end

Then /^Change Plan error message should be (.+)$/ do |expected|
  actual = @bus_site.admin_console_page.change_plan_section.messages
  actual.should == expected
end

Then /^Rate schedule can not be choosen when change plan$/ do
  @bus_site.admin_console_page.change_plan_section.rate_schedule_present.should == false
end

Then /^the storage error message of change plan section should be:$/ do  |message|
  @bus_site.admin_console_page.change_plan_section.get_error_input_message.should == message
end

Then /^change plan section shouldn't have any storage errors$/ do
  @bus_site.admin_console_page.change_plan_section.error_input_visible?.should == false
end
