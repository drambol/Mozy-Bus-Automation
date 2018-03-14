
When /^I change account subscription to (.+) period$/ do |link_text|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['billing_information'])
  @bus_site.admin_console_page.billing_info_section.go_to_change_period_section
  @bus_site.admin_console_page.change_period_section.change_subscription_to(link_text)
  unless @partner.billing_info.billing[:pre_all_subtotal].nil?
    @previous_period_partner = @partner.deep_clone
    @next_period_partner = @partner.deep_clone

    case link_text
      when 'monthly billing'
        @next_period_partner.subscription_period = '1'
      when 'annual billing'
        @next_period_partner.subscription_period = '12'
      when 'biennial billing'
        @next_period_partner.subscription_period = '24'
    end

    case @partner.partner_info.type
      when CONFIGS['bus']['company_type']['mozypro']
        get_mozypro_signup_order(@next_period_partner)
      when CONFIGS['bus']['company_type']['reseller']
        get_reseller_signup_order(@next_period_partner)
    end

    if @partner.subscription_period.to_i < @next_period_partner.subscription_period.to_i
      @partner = @next_period_partner
    end

  end
end

Then /^Change subscription confirmation message should be:$/ do |message|
  @bus_site.admin_console_page.change_period_section.confirmations.join(" ").should == message.to_s.gsub(/\n/," ").gsub(/\r/,"")
end

Then /^Change subscription price table should be:$/ do |price_table|
  price_table.rows.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end
  @bus_site.admin_console_page.change_period_section.price_table_headers.should == price_table.headers
  @bus_site.admin_console_page.change_period_section.price_table_rows.should == price_table.rows
end

Then /^Subscription changed message should be (.+)$/ do |message|
  @bus_site.admin_console_page.change_period_section.messages.should == message
  @bus_site.admin_console_page.billing_info_section.wait_until_bus_section_load
end

Then /^I continue to change account subscription$/ do
  @bus_site.admin_console_page.change_period_section.continue_change_subscription
end

When /^I change account subscription to (.+) period!$/ do |link_text|
  step "I change account subscription to #{link_text} period"
  step "I continue to change account subscription"
end

When /^I go to change billing period section$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['billing_information'])
  @bus_site.admin_console_page.billing_info_section.go_to_change_period_section
end

Then /^change billing period table should be:$/ do |change_billing_table|
  @bus_site.admin_console_page.change_period_section.change_billing_table_rows.should == change_billing_table.raw
end
