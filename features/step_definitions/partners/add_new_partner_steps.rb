# Public: Create a new partner
#
# MozyPro available columns:
#   Required: period
#   Optional: base plan, server plan, storage add on, coupon, country, vat number, net terms
#
# MozyEnterprise available columns:
#   Required: period
#   Optional: users, server plan, server add on, coupon, country, vat number, net terms
#
# Reseller available columns:
#   Required: period
#   Optional: reseller type, reseller quota, server plan, storage add on, coupon,  country,  vat number, net terms
#
# Shared available columns:
# Optional: address, city, state, state abbrev, zip, country, phone, admin email, admin name, root role
#
# Steps included:
#   click 'Add New Partner' link
#   fill in all fields
#   click next
#   fill in credit card information
#   click create

When /^I add a new (MozyPro|MozyEnterprise|Reseller|MozyEnterprise DPS|OEM) partner:$/ do |type, partner_table|
  @bus_site.log("navigate to the bus/menu/add new partner")
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner']) unless type == "OEM"
  @bus_site.log("parse the partner_table parameter to identify the info for partner creation.")
  attributes = partner_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil  if (attribute == '' && !attributes.has_key?("security") )
  end

  case type
    when CONFIGS['bus']['company_type']['oem']
      step %{I act as partner by:}, table(%{
      | email                                  | including sub-partners |
      | redacted-20631@notarealdomain.mozy.com | yes                    |})
      step %{I act as partner by:}, table(%{
      | email                                  | including sub-partners |
      | redacted-36092@notarealdomain.mozy.com | yes                    |})
      step %{I add a new sub partner:}, table(%{
      |#{partner_table.headers.join('|')}|
      |#{partner_table.rows.first.join('|')}|})
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyPro.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["base plan"].nil?
      @partner.base_plan = attributes["base plan"] || ""
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
      @partner.has_stash_grant_plan = (attributes["stash grant plan"] || "no").eql?("yes")
      @partner.storage_add_on = attributes["storage add on"] || 0
      @partner.storage_add_on_50_gb = attributes["storage add on 50 gb"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozypro']
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @partner = Bus::DataObj::MozyEnterprise.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["users"].nil?
      @partner.num_enterprise_users = attributes["users"] || 0
      @partner.server_plan = attributes["server plan"] || "None"
      @partner.num_server_add_on = attributes["server add on"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozyenterprise']
    when CONFIGS['bus']['company_type']['mozyenterprise_dps']
      @partner = Bus::DataObj::MozyEnterpriseDPS.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes['base plan'].nil?
      @partner.base_plan = attributes["base plan"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['mozyenterprise']
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::Reseller.new
      @partner.partner_info.type = type
      @partner.has_initial_purchase = false if attributes["reseller type"].nil?
      @partner.reseller_type = attributes["reseller type"] || attributes["reseller type"].nil?
      @partner.reseller_quota = attributes["reseller quota"] || 0
      @partner.reseller_add_on_quota = attributes["storage add on"] || 0
      @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")
      @partner.has_stash_grant_plan = (attributes["stash grant plan"] || "no").eql?("yes")
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['reseller']
      @partner.account_detail.sales_channel = 'Reseller'
    else
      raise "Error: Company type #{type} does not exist."
  end

  unless type == "OEM"
    # Company info attributes
    @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
    @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
    @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
    @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
    @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
    @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
    @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
    @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
    @partner.company_info.phone = '' if attributes['phone'] == 'empty'
    @partner.company_info.vat_num = attributes['vat number'] unless attributes["vat number"].nil?
    @partner.company_info.security = attributes['security'] unless attributes["security"].nil?

    # Partner info attributes
    @partner.partner_info.coupon_code = attributes['coupon'] unless attributes['coupon'].nil?
    @partner.partner_info.parent = attributes['create under'] || CONFIGS['bus']['mozy_root_partner']['mozypro']

    # Admin existing email check
    attributes['admin email'] = @existing_user_email if attributes['admin email'] == '@existing_user_email'
    attributes['admin email'] = @existing_admin_email if attributes['admin email'] == '@existing_admin_email'

    # Admin info attributes
    @partner.admin_info.full_name = attributes['admin name'] unless attributes['admin name'].nil?
    @partner.admin_info.email = attributes['admin email'] unless attributes['admin email'].nil?

    # Account Details
    @partner.account_detail.account_type = attributes['account type'] unless attributes['account type'].nil?
    @partner.account_detail.sales_origin = attributes['sales origin'] unless attributes['sales origin'].nil?
    @partner.account_detail.sales_channel = attributes['sales channel'] unless attributes['sales channel'].nil?

    # Billing info attributes
    @partner.use_company_info = attributes['billing country'].nil?
    unless @partner.use_company_info
      @partner.billing_info.country = attributes["billing country"] unless attributes['billing country'].nil?
      @partner.billing_info.state = attributes["billing state"] unless attributes['billing state'].nil?
      @partner.billing_info.state_abbrev = attributes['billing state abbrev'] unless attributes['billing state abbrev'].nil?
      @partner.billing_info.address = attributes['billing address'] unless attributes['billing address'].nil?
      @partner.billing_info.city = attributes['billing city'] unless attributes['billing city'].nil?
      @partner.billing_info.zip = attributes['billing zip'] unless attributes['billing zip'].nil?
      @partner.billing_info.phone = attributes['billing phone'] unless attributes['billing phone'].nil?
      @partner.billing_info.email = attributes["billing email"] unless attributes['billing email'].nil?
    end

    # Credit card info attributes
    @partner.credit_card.first_name = attributes['cc first name'] unless attributes['cc first name'].nil?
    @partner.credit_card.last_name = attributes['cc last name'] unless attributes['cc last name'].nil?
    @partner.credit_card.number = attributes['cc number'] unless attributes['cc number'].nil?
    @partner.credit_card.last_four_digits = @partner.credit_card.number[12..-1]  unless attributes['cc number'].nil?
    @partner.credit_card.expire_month = attributes['expire month'] unless attributes['expire month'].nil?
    @partner.credit_card.expire_year = attributes['expire year'] unless attributes['expire year'].nil?
    @partner.credit_card.cvv = attributes['cvv'] unless attributes['cvv'].nil?

    # Common attributes
    @partner.subscription_period = attributes['period']
    @partner.net_term_payment = (attributes['net terms'] || 'no').eql?('yes')

    Log.debug(@partner.to_s)
    @partner.credit_card.cvv2 = attributes['check cvv2'] unless attributes['check cvv2'].nil?
    @bus_site.log('begin to create partner')
    @bus_site.log(@partner.to_s)
    @bus_site.admin_console_page.add_new_partner_section.add_new_account(@partner)
  end
end

When /^I add a new (MozyPro|MozyEnterprise|Reseller) partner if not exist:$/ do |type, partner_table|
  attributes = partner_table.hashes.first
  company_name =  attributes['company name']
  email = attributes['email']
  search_result = Proc.new do |company_name, email|
    search = email
    compare = company_name
    if company_name && !email
      search = company_name
    end
    @bus_site.admin_console_page.search_list_partner_section.search_partner search
    @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows.first[1] == compare
  end
  unless company_name && search_result.call(company_name, email)
    step %{I add a new #{type} partner:}, table(%{
      |#{partner_table.headers.join('|')}|
      |#{partner_table.rows.first.join('|')}|
    })
    @bus_site.admin_console_page.add_new_partner_section.messages.should == 'New partner created.'
  end
end

Then /^New partner should be created$/ do
  @bus_site.admin_console_page.add_new_partner_section.messages.should == "New partner created."
  @bus_site.log("New partner is created successfully at: #{Time.now}")
end

Then /^Aria payment error message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_partner_section.aria_errors.should == message
end

Then /^Add account error message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_partner_section.add_account_errors.should == message
end

Then /^the billing country alert is (.+)$/ do |alert|
  @partner.billing_info.alert.should == alert
end

Then /^there is no popup alert during partner creation$/ do
  @partner.billing_info.alert.should == ""
end

Then /^Create partner error message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_new_partner_section.messages.should == message
end

Then /^Sub-total before taxes or discounts should be (.+)$/ do |amount|
  @partner.pre_sub_total.should == amount
end

Then /^the sub-total before taxes or discounts should be correct$/ do
  case @partner.partner_info.type
    when CONFIGS['bus']['company_type']['mozypro']
      get_mozypro_signup_order(@partner)
    when CONFIGS['bus']['company_type']['reseller']
      get_reseller_signup_order(@partner)
  end
  @partner.pre_sub_total.should == format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])
  Log.debug(format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal]))
end

Then /^the order summary table should be correct$/ do
  actual = @partner.order_summary
  case @partner.partner_info.type
    when CONFIGS['bus']['company_type']['mozypro']
      expected = get_bus_mozypro_order_summery(@partner)
    when CONFIGS['bus']['company_type']['reseller']
      expected = get_bus_reseller_order_summery(@partner)
  end
  actual.should == expected
  Log.debug(expected)
end

Then /^Order summary table should be:$/ do |order_summary_table|
  actual = @partner.order_summary
  expected = order_summary_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I select company type as (MozyPro|MozyEnterprise|Reseller|MozyEnterprise DPS)$/ do |company_type|
  @bus_site.admin_console_page.add_new_partner_section.select_company_type(company_type)
end

Then /^(MozyPro|MozyEnterprise|Reseller) partner subscription period options should be:$/ do |type, periods_table|
  @bus_site.admin_console_page.add_new_partner_section.available_periods(type).should == periods_table.headers
end

Then /^Security field options on add new partner page should be:$/ do |security_options|
  @bus_site.admin_console_page.add_new_partner_section.available_security_options.should == security_options.headers
end

And /^Security field default value when add partner is blank$/ do
  @bus_site.admin_console_page.add_new_partner_section.get_security_default_value.strip.should == ''
end

And /^HIPPA security tool tip appears next to the security drop-down$/ do
  expected_text = "HIPAA (Health Insurance Portability and Accountabilty Act) rules apply to health care providers, health plans, and health care clearinghouses in the United States of America."
  @bus_site.admin_console_page.add_new_partner_section.get_security_tooltip.should == expected_text
end

And /^I set initial purchase and base plan for specified company type$/ do |table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
  attributes = table.hashes.first
  type = attributes['company type']
  @bus_site.admin_console_page.add_new_partner_section.fill_company_type(type)
  case type
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyPro.new
      @partner.base_plan = attributes["base plan"] || 0
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @partner = Bus::DataObj::MozyEnterprise.new
      @partner.server_plan = attributes["server plan"] || "None"
      @partner.num_enterprise_users = attributes["users"] || 0
      @partner.num_server_add_on = attributes["server add on"] || 0
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::Reseller.new
      @partner.reseller_type = attributes["reseller type"] || attributes["reseller type"].nil?
      @partner.reseller_quota = attributes["reseller quota"] || 0
    else
      raise "Error: Company type #{type} does not exist."
  end
  @partner.partner_info.type = type
  @partner.subscription_period = attributes['period']
  @bus_site.admin_console_page.add_new_partner_section.fill_subscription_period(@partner.subscription_period)
  @bus_site.admin_console_page.add_new_partner_section.fill_initial_purchase(@partner)
end


Then /(MozyPro|MozyEnterprise|Reseller) VMBU tool tip should appear next to the Server Add Ons$/ do |partner_type|
  vmbu_text = 'Server Add On is used for physical and virtual servers.'
  @bus_site.admin_console_page.add_new_partner_section.get_vmbu_tooltip(@partner).should == vmbu_text
end

When /^I add a new sub partner:$/ do |sub_partner_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
  @subpartner = Bus::DataObj::SubPartner.new(friendly_hash(sub_partner_table.hashes.first))
  @bus_site.admin_console_page.add_new_partner_section.add_new_subpartner(@subpartner)
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

Then /^the default billing country is (.+) in add new partner section$/ do |country|
  @bus_site.admin_console_page.add_new_partner_section.billing_country.should == country
end

Then /^Add New Partner error message should be:$/ do |messages|
  @bus_site.admin_console_page.add_new_partner_section.messages.should == messages.to_s
end

When /^I successfully add an itemized (MozyPro|Reseller) partner:$/ do |type, partner_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
  attributes = partner_table.hashes.first
  case type
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyItemized.new
      @partner.partner_info.type = type
      @partner.server_license_discount = attributes["server license discount"] || 0
      @partner.server_quota_discount = attributes["server quota discount"] || 0
      @partner.desktop_license_discount = attributes["desktop license discount"] || 0
      @partner.desktop_quota_discount = attributes["desktop quota discount"] || 0
      @partner.server_licenses = attributes["server licenses"] || 0
      @partner.server_quota = attributes["server quota"] || 0
      @partner.desktop_licenses = attributes["desktop licenses"] || 0
      @partner.desktop_quota = attributes["desktop quota"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['biz_root']
      puts @partner.to_s
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::MozyItemized.new
      @partner.partner_info.type = type
      @partner.server_license_discount = attributes["server license discount"] || 0
      @partner.server_quota_discount = attributes["server quota discount"] || 0
      @partner.desktop_license_discount = attributes["desktop license discount"] || 0
      @partner.desktop_quota_discount = attributes["desktop quota discount"] || 0
      @partner.server_licenses = attributes["server licenses"] || 0
      @partner.server_quota = attributes["server quota"] || 0
      @partner.desktop_licenses = attributes["desktop licenses"] || 0
      @partner.desktop_quota = attributes["desktop quota"] || 0
      @partner.admin_info.root_role = attributes["root role"] || CONFIGS['bus']['root_role']['reseller']
    else
      raise "Error: Company type #{type} does not exist."
  end

  # Company info attributes
  @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
  @partner.company_info.address = attributes['address'] unless attributes['address'].nil?
  @partner.company_info.city = attributes['city'] unless attributes['city'].nil?
  @partner.company_info.state = attributes['state'] unless attributes['state'].nil?
  @partner.company_info.state_abbrev = attributes['state abbrev'] unless attributes['state abbrev'].nil?
  @partner.company_info.country = attributes["country"] unless attributes['country'].nil?
  @partner.company_info.zip = attributes['zip'] unless attributes['zip'].nil?
  @partner.company_info.phone = attributes['phone'] unless attributes['phone'].nil?
  @partner.company_info.vat_num = attributes["vat number"] unless attributes["vat number"].nil?

  # Partner info attributes
  @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?
  @partner.partner_info.parent = attributes["create under"] || CONFIGS['bus']['mozy_root_partner']['mozypro']

  # Admin info attributes
  @partner.admin_info.full_name = attributes["admin name"] unless attributes["admin name"].nil?
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin email"].nil?

  # Billing info attributes
  # Not implemented, always use company info

  # Credit card info attributes
  @partner.credit_card.first_name = attributes["cc first name"] unless attributes["cc first name"].nil?
  @partner.credit_card.last_name = attributes["cc last name"] unless attributes["cc last name"].nil?
  @partner.credit_card.number = attributes["cc number"] unless attributes["cc number"].nil?
  @partner.credit_card.expire_month = attributes["expire month"] unless attributes["expire month"].nil?
  @partner.credit_card.expire_year = attributes["expire year"] unless attributes["expire year"].nil?
  @partner.credit_card.cvv = attributes["cvv"] unless attributes["cvv"].nil?

  # Common attributes
  @partner.subscription_period = attributes["period"]
  case
    when attributes["period"].eql?("1")
      @partner.subscription_period = "m"
    when attributes["period"].eql?("12")
      @partner.subscription_period = "y"
    when attributes["period"].eql?("24")
      @partner.subscription_period = "2"
  end

  Log.debug(@partner.to_s)
  @bus_site.admin_console_page.add_itemized_partner_section.add_new_itemized_partner(@partner)
end

When /^I (Enable|Disable) autogrow$/ do |status|
  case status
    when "Enable"
      @bus_site.admin_console_page.partner_details_section.enable_autogrow
    when "Disable"
      @bus_site.admin_console_page.partner_details_section.disable_autogrow
    else
  end
end

Then /^storage based plan shows while user based plan and server add-on not show$/ do
  array = @bus_site.admin_console_page.add_new_partner_section.check_mozyenterprise_dps_plan
  # user_plan,storage_plan,server_addon_plan
  array[0].should == false
  array[1].should == true
  array[2].should == false
end

Then /^Rate schedule can not be choosen when add partner$/ do
  @bus_site.admin_console_page.add_new_partner_section.rate_schedule_present.should == false
end

When /^I refresh Add New Partner section$/ do
  @bus_site.admin_console_page.add_new_partner_section.refresh_bus_section
end

When /^I navigate to Add New Partner section$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_partner'])
end

When /^I select (.+) as the company type$/ do |company_type|
  @bus_site.admin_console_page.add_new_partner_section.select_company_type(company_type)
end

When /^I verify default country in Add New Partner page should be (.+)/ do |country|
  @bus_site.admin_console_page.add_new_partner_section.verify_default_country.should == country.to_s
end