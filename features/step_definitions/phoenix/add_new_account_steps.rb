#
# This will add a phoenix account, either home or pro.
#
#
# encoding: utf-8


When /^I (.+) a phoenix (Home|Pro|Direct|Free) (partner|user):$/ do |string,type, partner_or_user ,partner_table|
  # There were two Home signups, (When I add ...)(When I sign up...) The string combines them
  #(partner | user) is keep all tests cases working from when Home and Pro where separate
  attributes = partner_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end

  # initial object instantiation
  @partner = ((type == "Pro" || type == "Direct") ? Bus::DataObj::MozyPro.new : Bus::DataObj::MozyHome.new )

  # account type and relevant items
  @partner.partner_info.type = ((type == "Pro" || type == "Direct") ? "MozyPro" : "MozyHome")
  @partner.base_plan = attributes["base plan"] || ""
  @partner.has_server_plan = (attributes["server plan"] || "no").eql?("yes")

  if (type == "Home" || type == "Free")
    @partner.has_stash = (attributes["has stash"] || "no").eql?("yes")
    @partner.additional_computers = attributes['addl computers'] unless attributes['addl computers'].nil?
    @partner.additional_storage = attributes['addl storage'] unless attributes['addl storage'].nil?
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
  @partner.company_info.security = attributes["security"].nil? ? "Standard" : attributes['security']
  
  # Partner info attributes
  @partner.partner_info.coupon_code = attributes["coupon"] unless attributes["coupon"].nil?

  # Partners added through phoenix do not get to select their parent.
  # It is assigned based on their 'dom' and product selection
  if type == "Pro" || type == "Direct"
    #parent is MozyPro
    @partner.partner_info.parent = case @partner.company_info.country
                                     when "Ireland"
                                       #parent is
                                       'MozyPro Ireland'
                                     when "United Kingdom"
                                       #parent is
                                       'MozyPro UK'
                                     when "Germany"
                                       #parent is
                                       'MozyPro Germany'
                                     when "France"
                                       #parent is
                                       'MozyPro France'
                                     when "United States"
                                       #parent is
                                       'MozyPro'
                                   end
  elsif type == "Home" || type == "Free"
    #parent is MozyHome
    @partner.partner_info.parent = case @partner.company_info.country
                                     when "Ireland"
                                       #parent is
                                       'MozyHome Ireland'
                                     when "United Kingdom"
                                       #parent is
                                       'MozyHome UK'
                                     when "Germany"
                                       #parent is
                                       'MozyHome Germany'
                                     when "France"
                                       #parent is
                                       'MozyHome France'
                                     when "United States"
                                       #parent is
                                       'MozyHome'
                                   end
  else
    raise "unsupported user type"
  end

  # Admin existing email check
  attributes['admin email'] = @existing_user_email if attributes['admin email'] == '@existing_user_email'
  attributes['admin email'] = @existing_admin_email if attributes['admin email'] == '@existing_admin_email'


  # Admin info attributes
  @partner.admin_info.full_name = attributes["admin name"] unless attributes["admin name"].nil?
  @partner.admin_info.email = attributes["admin email"] unless attributes["admin email"].nil?
  Log.debug "Home user email: #{@partner.admin_info.email}"

  # Account Details
  @partner.account_detail.account_type = "Live"
  @partner.account_detail.sales_origin = "Web"

  # Credit card info attributes
  @partner.credit_card.first_name = attributes["cc first name"] unless attributes["cc first name"].nil?
  @partner.credit_card.last_name = attributes["cc last name"] unless attributes["cc last name"].nil?
  @partner.credit_card.number = attributes["cc number"] unless attributes["cc number"].nil?
  @partner.credit_card.expire_month = attributes["expire month"] unless attributes["expire month"].nil?
  @partner.credit_card.expire_year = attributes["expire year"] unless attributes["expire year"].nil?
  @partner.credit_card.cvv = attributes["cvv"] unless attributes["cvv"].nil?
  @partner.credit_card.type = attributes["type"] unless attributes["type"].nil?

  # Billing info attributes
  @partner.use_company_info = attributes['billing country'].nil?
  unless @partner.use_company_info
    @partner.billing_info.country = attributes["billing country"] unless attributes['billing country'].nil?
    @partner.billing_info.state = attributes["billing state"] unless attributes['billing state'].nil?
    @partner.billing_info.state_abbrev = attributes['billing state abbrev'] unless attributes['billing state abbrev'].nil?
    @partner.billing_info.company_name = attributes["billing company name"] unless attributes['billing company name'].nil?
    @partner.billing_info.address = attributes['billing address'] unless attributes['billing address'].nil?
    @partner.billing_info.city = attributes['billing city'] unless attributes['billing city'].nil?
    @partner.billing_info.zip = attributes['billing zip'] unless attributes['billing zip'].nil?
    @partner.billing_info.phone = attributes['billing phone'] unless attributes['billing phone'].nil?
  end

  # Common attributes
  @partner.subscription_period = attributes["period"]

  #Maybe change the
  if (type == "Home" || type == "Free")
    case
      when attributes["period"].eql?("1")
        @partner.subscription_period = "M"
      when attributes["period"].eql?("12")
        @partner.subscription_period = "Y"
      when attributes["period"].eql?("24")
        @partner.subscription_period = "2"
    end
  end

  Log.debug(@partner)

  case type
    when "Direct"
      @phoenix_site.phoenix_acct_fill_out.go_to_pro_direct_page
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.direct_fill_out(@partner)
    when "Free"
      @phoenix_site.phoenix_acct_fill_out.go_to_home_free
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.free_user_info_input(@partner)
    when "Pro"
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
    when "Home"
      @phoenix_site.select_dom.select_country(@partner)
      @phoenix_site.phoenix_acct_fill_out.admin_info_fill_out(@partner)
  end

  #If catches an error of already used email

  unless @phoenix_site.phoenix_acct_fill_out.stuck_on_sign_up? || type == "Free"
    @phoenix_site.licensing_fill_out.licensing_billing_fillout(@partner)
    unless @phoenix_site.licensing_fill_out.stuck_on_mozy_plan?
      @phoenix_site.billing_fill_out.billing_info_fill_out(@partner)
    end
  end

end

#AMMENDED: For some reason this works intermittently.  Original is unchange, commented out '# unless portion'.
Then /^the (order|billing) summary looks like:$/ do |type, billing_table|
  actual = @partner.order_summary
  expected = billing_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key] unless actual[index][key].nil?} }
end

## Changed to more useful or the different account types
And /^the (partner|user) is successfully added(.|)$/ do  |_,_|
  if @partner.partner_info.type == "MozyPro"
    @phoenix_site.reg_complete_pg.go_to_account_verify(@partner)
    @bus_site = BusSite.new unless !@bus_site.nil?
    @bus_site.admin_console_page.partner_created(@partner)
    #TODO: localized logic is tied to phoenix even if this is verified in BUS(@phoenix_site is misleading)
    @phoenix_site.reg_complete_pg.logout(@partner)
  else
    # if not a pro acct - its a home acct, but need to determine type still
    if @partner.base_plan == "free" #reg_complete_pg.check_url == "Home"
                                    # free acct url end with: registration/free_finish
      @phoenix_site.reg_complete_pg.free_home_success(@partner)
      sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
    else
      # paid accts url ends with: registration/mozy_home_finish
      @phoenix_site.reg_complete_pg.home_success(@partner)
      sleep 2 # time for systems to catch up, this may be a symptom of a race condition w/ the mail systems
    end
  end
end

Then /^the default country is (.+) in the pro billing page$/ do |country|
  @phoenix_site.billing_fill_out.pro_billing_country.should == country
end

And /^they have logged in and verified their account.$/ do
  @phoenix_site.reg_complete_pg.clear_phoenix_cookies
  @bus_site = BusSite.new unless !@bus_site.nil?
  @bus_site.login_page.load
  @bus_site.login_page.partner_login(@partner)
  @bus_site.admin_console_page.open_partner_details_from_header(@partner)
  @bus_site.admin_console_page.partner_details_section.partner_info_verify(@partner)
  #TODO: localized logic is tied to phoenix even if this is verified in BUS(@phoenix_site is misleading)
  @phoenix_site.reg_complete_pg.logout(@partner)
end

Then /^the default country is (.+) in the home billing page$/ do |country|
  Log.debug @phoenix_site.billing_fill_out.home_billing_country
  @phoenix_site.billing_fill_out.home_billing_country.should == country
end

# changed to add in locale and different verbage for home
When /^verify email address link should show success message$/ do
  @phoenix_site.verify_email_address.visit(@verify_email_query)
  if @partner.base_plan.eql?("free")
    @phoenix_site.reg_complete_pg.free_home_verified(@partner)
    # free users are taken to acct created screen, not mail verification page
  else
    @phoenix_site.verify_email_address.form_title_txt.should == "#{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_banner']}"
    @phoenix_site.verify_email_address.form_message_txt.should == " #{LANG[@partner.company_info.country][@partner.partner_info.type]['verify_mail_success']}"
  end
end

Then /^sign up page error message should be:$/ do |message|
  @phoenix_site.phoenix_acct_fill_out.rp_error_messages.should eq(message)
end

Then /^sign up page error message to (.+) should be displayed$/ do |username|
  @phoenix_site.phoenix_acct_fill_out.rp_error_messages.should eq(" An account with email address \"#{username}\" already exists")
end

# this piece may be combinable with the bus admin login step
When /^I login (as the user|under changed password) on the account.$/ do |login_condition|
  @phoenix_site = PhoenixSite.new
  @phoenix_site.user_account.load
  case login_condition
    when "as the user"
      @phoenix_site.user_account.user_login(@partner)
    when "under changed password"
      @phoenix_site.user_account.user_login_changed_pw(@partner)
      step %{I verify the user account:}
  end
end

When /^I log into phoenix with username (.+) and password (.+)$/ do |username,password|
  if username == '@new_admin_email'
    username = @partner.admin_info.email
  elsif !(username.match(/^@.+$/).nil?)
    username =  '<%=' + username + '%>'
    username.replace ERB.new(username).result(binding)
  else
    #
  end
  @bus_site ||= BusSite.new #In case you log into bus through the phoenix page
  @phoenix_site ||= PhoenixSite.new
  @phoenix_site.user_account.load
  @phoenix_site.user_account.phoenix_login(username, password)
end

When /^I log in with username (.+) and password (.+) from phoenix login page$/ do |username,password|
  if username == '@new_admin_email'
    username = @partner.admin_info.email
  elsif !(username.match(/^@.+$/).nil?)
    username =  '<%=' + username + '%>'
    username.replace ERB.new(username).result(binding)
  else
    #
  end
  @bus_site ||= BusSite.new #In case you log into bus through the phoenix page
  @phoenix_site ||= PhoenixSite.new
  @phoenix_site.user_account.phoenix_login(username, password)
end

Given /^I log into phoenix with capitalized username$/ do
  username = QA_ENV['bus_username'].upcase
  password = QA_ENV['bus_password']
  step %{I log into phoenix with username #{username} and password #{password}}
end

Given /^I log into phoenix with mixed case username$/ do
  username = QA_ENV['bus_username']
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)>0 ? x.downcase : x.upcase end
  end
  password = QA_ENV['bus_password']
  step %{I log into phoenix with username #{username} and password #{password}}
end

# this piece may be combinable with the verification of account step
When /^I verify the user account.$/ do
  @phoenix_site.user_account.login_verify(@partner)
end

# this relates to admin console account details
When /^(.+) account information should be:$/ do  |home_user_table|
  # table is a Cucumber::Ast::Table
  account_data = home_user_table.hashes.first

  @phoenix_site.user_account.account_detail_section.load_acct_home_section(@partner)
  @phoenix_site.user_account.account_detail_section.plan_details_headers.should == account_data.headers
  @phoenix_site.user_account.account_detail_section.plan_details_rows.should == account_data.rows
end

# added "( |partner)" for future flexibility
Then /^the (user|partner) has activated their account$/ do |_|
  if @partner.base_plan.eql?("free")
    subject = "free_mail_subject"
  else
    subject = "verify_mail_subject"
  end
  if (@partner.company_info.country.eql?("France")||@partner.company_info.country.eql?("Germany"))
    step %{I retrieve email content by keywords:}, table(%{
      | to |
      | @new_admin_email |
      })
  else
    dialect_country = LANG[@partner.company_info.country].nil?? 'United States' : @partner.company_info.country
    step %{I retrieve email content by keywords:}, table(%{
        | to | subject |
        | @new_admin_email | #{LANG[dialect_country][@partner.partner_info.type]["#{subject}"]} |
        })
  end
  step %{I get verify email address from email content}
  step %{verify email address link should show success message}
end

Then /^mozy plan page error message should be:$/ do |message|
  @phoenix_site.licensing_fill_out.pc_error_messages.should eq(message)
end

Then /^vat error message should be:$/ do |message|
  @phoenix_site.licensing_fill_out.vat_error_messages.should eq(message)
end

Then /^billing details page error message should be:$/ do |message|
  @phoenix_site.billing_fill_out.home_error_messages.strip.should eq(message.strip)
end

Then /^payment information page error message should be:$/ do |message|
  @phoenix_site.billing_fill_out.pro_error_messages.should eq(message)
end

Then /^the quota in account home page looks like:$/ do |quota_info|
  @phoenix_site.user_account.get_quota_account_page(@partner).should eq(quota_info)
end

Then /^the plan details in account home page looks like:$/ do |plan_table|
  actual = @phoenix_site.user_account.get_plan_details_account_page
  expected = plan_table.raw
  actual.each_with_index{ |item, index|
    # for the last 2 lines, Last charge, Next charge, there are contains date information, will not check date here
    item[0].strip.should==expected[index][0]
      if index >= actual.size - 2
         item[1].strip.should include expected[index][1]
      else
         item[1].strip.should==expected[index][1]
      end
  }
end

Then /^the user activate account by update db$/ do
  DBHelper.change_email_verified_at(@partner.admin_info.email)
end

And /^I save the partner info$/ do
  Bus::DataObj::PreviousPartner.new(@partner)
end

And /^I get previous partner info$/ do
  @partner=Bus::DataObj::PreviousPartner.new(nil).get_partner_info
  Log.debug(@partner)
end

When /^user log in failed, error message is:$/ do  |message|
  @phoenix_site.user_account.login_error_message.should == message.to_s
end

When /^user log in phoenix failed$/ do
  @phoenix_site.user_account.check_logout_link.should == false
end

When /^I select to add a phoenix (MozyPro|MozyHome) partner:/ do |type|
  @phoenix_site.select_dom.register_partner(type)
end

When /^I verify that the default country is (.+)$/ do |country|
  @phoenix_site.select_dom.get_selected_country.should == country.to_s
end