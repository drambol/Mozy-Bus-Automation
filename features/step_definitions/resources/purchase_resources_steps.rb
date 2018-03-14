When /^I purchase resources:$/ do |resources_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['purchase_resources'])
  cells = resources_table.hashes.first
  puts "=============="
  puts cells
  user_group = cells["user group"]
  d_license = cells["desktop license"]
  d_quota = cells["desktop quota"]
  s_license = cells["server license"]
  s_quota = cells["server quota"]
  g_quota = cells["generic quota"]
  @bus_site.admin_console_page.purchase_resources_section.purchase(user_group, d_license, d_quota, s_license, s_quota, g_quota)
end

Then /^Resources should be purchased$/ do
  @bus_site.admin_console_page.purchase_resources_section.messages.should == "Resources have been added to your account."
end

When /^I refresh purchase resource section$/ do
  @bus_site.admin_console_page.purchase_resources_section.refresh_bus_section
end

When /^I save current purchased resources$/ do
  @current_purchased_resources = @bus_site.admin_console_page.purchase_resources_section.current_purchased_resources
end

Then /^Current purchased resources should (increase|be):$/ do |how, resources_table|
  @new_purchased_resources = @bus_site.admin_console_page.purchase_resources_section.current_purchased_resources
  cells = resources_table.hashes.first
  s_license = (cells["server license"] || 0).to_i
  s_quota = (cells["server quota"] || 0).to_i
  d_license = (cells["desktop license"] || 0).to_i
  d_quota = (cells["desktop quota"] || 0).to_i

  case how
    when 'increase'
      (@new_purchased_resources[:server_license] - @current_purchased_resources[:server_license]).should == s_license
      (@new_purchased_resources[:server_quota] - @current_purchased_resources[:server_quota]).should == s_quota
      (@new_purchased_resources[:desktop_license] - @current_purchased_resources[:desktop_license]).should == d_license
      (@new_purchased_resources[:desktop_quota] - @current_purchased_resources[:desktop_quota]).should == d_quota
    when 'be'
      @new_purchased_resources[:server_license].should == s_license
      @new_purchased_resources[:server_quota].should == s_quota
      @new_purchased_resources[:desktop_license].should == d_license
      @new_purchased_resources[:desktop_quota].should == d_quota
    else
      raise 'unknown error'
  end
end

Then /^the storage error message of purchase resource section should be: (.+)$/ do |message|
  @bus_site.admin_console_page.purchase_resources_section.error_message.should == message
end

Then /^the pay error message of purchase resource section should be: (.+)$/ do |message|
  @bus_site.admin_console_page.purchase_resources_section.pay_error_msg.should == message
end