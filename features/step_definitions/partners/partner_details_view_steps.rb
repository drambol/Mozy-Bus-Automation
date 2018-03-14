When /^I act as newly created (sub)*partner( account)?$/ do |type, account|
  if type.nil?
    @current_partner = @bus_site.admin_console_page.partner_details_section.partner
    @bus_site.admin_console_page.partner_details_section.act_as_partner
    wait_until { @bus_site.admin_console_page.has_stop_masquerading_link? }
  else
    @current_partner = @bus_site.admin_console_page.partner_details_section.subpartner.partner
    @bus_site.admin_console_page.partner_details_section.subpartner.act_as_partner
    @bus_site.admin_console_page.has_content?(@subpartner.company_name)
  end
  @partner_id = @bus_site.admin_console_page.current_partner_id
end

When /^I act as newly created (sub)*partner( account)? with welcome page poped up$/ do |type, account|
  if type.nil?
    @current_partner = @bus_site.admin_console_page.partner_details_section.partner
    @bus_site.admin_console_page.partner_details_section.act_as_partner_with_alert
  else
    @current_partner = @bus_site.admin_console_page.partner_details_section.subpartner.partner
    @bus_site.admin_console_page.partner_details_section.subpartner.act_as_partner_with_alert
  end
  @partner_id = @bus_site.admin_console_page.current_partner_id
end

And /^I check welcome page for (.+) link$/ do |type|
  @bus_site.admin_console_page.check_specific_element(type)
end

And /^I click start using mozy button$/ do
  @bus_site.admin_console_page.click_start_using_mozy
end

And /^I check show welcome checkbox$/ do
  @bus_site.admin_console_page.check_show_welcome_chkbox
end

Then /^No welcome page poped up$/ do
  @bus_site.admin_console_page.poped_up_window.should be_false
end

When /^I add partner settings$/ do |table|
  #    | Name                    | Value | Locked |
  #    | allow_ad_authentication | t     | yes    |
  @bus_site.admin_console_page.partner_details_section.add_settings(table.hashes)
  @bus_site.admin_console_page.partner_details_section.close_settings
end

# When /^I edit partner settings$/ do |table|
#   @bus_site.admin_console_page.partner_details_section.edit_setting(table.hashes)
# end

When /^I delete partner settings(.*)$/ do |exist, table|
  # | Name | Value |
  exist = (exist==(' if exist')? false : true)
  @bus_site.admin_console_page.partner_details_section.delete_settings(table.hashes, exist)
  @bus_site.admin_console_page.partner_details_section.close_settings
end

When /^I verify partner settings$/ do |table|
  @bus_site.admin_console_page.partner_details_section.verify_settings(table.hashes)
  @bus_site.admin_console_page.partner_details_section.close_settings
end

Then /^I should not see partner setting (.+)$/ do |setting|
  @bus_site.admin_console_page.partner_details_section.show_partner_settings
  @bus_site.admin_console_page.partner_details_section.has_setting_name?(setting).should == false
  @bus_site.admin_console_page.partner_details_section.close_settings
end

When /^I search and delete partner account by (.+)/ do |account_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(account_name)

  rows = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  unless rows.to_s.include?('No results found.')
    @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(account_name)
    @bus_site.admin_console_page.partner_details_section.delete_partner(QA_ENV['bus_password'])
  else
    raise "Cannot find newly created partner #{account_name}."
  end
end

And /^LDAP admin delete partner$/ do
  @bus_site.admin_console_page.partner_details_section.ldap_admin_delete_partner
end

When /^I search and delete partner account if it exists by (.+)/ do |account_name|
  begin
    step %{I search and delete partner account by #{account_name}}
  rescue Exception => ex
    Log.debug ex.to_s
  end
end

# When you are on partner details section, you are able to execute this steps
When /^I delete (partner|subpartner) account(|default password|Hipaa password)$/ do |status, password|
  password = QA_ENV['bus_password'] if password == ''
  case status
    when "partner"
      @bus_site.admin_console_page.partner_details_section.delete_partner(password)
    when "subpartner"
      @bus_site.admin_console_page.partner_details_section.subpartner.delete_partner(password)
    else
  end
end

When /^I get the (partner_id|subpartner_id)$/ do |type|
  if type =='partner_id'
    @partner_id = @bus_site.admin_console_page.partner_details_section.partner_id()
  else
    @partner_id = @bus_site.admin_console_page.partner_details_section.subpartner.partner_id()
  end
  Log.debug("partner id is #{@partner_id}")
  @bus_site.log("partner id is #{@partner_id}")
end

When /^I get partner aria id$/ do
  @aria_id = @bus_site.admin_console_page.partner_details_section.general_info_hash['Aria ID:']
  Log.debug @aria_id
  @bus_site.log("aria id is #{@aria_id}")
end

And /^Partner details (shouldn't|should) have (.+)/ do |type,field|
  unless type == "should"
    @bus_site.admin_console_page.partner_details_section.general_info_hash[field + ":"].nil?.should == true
  else
    @bus_site.admin_console_page.partner_details_section.general_info_hash[field + ":"].nil?.should == false
  end
end

Then /^(Partner|SubPartner) general information should be:$/ do |status,details_table|
  case status
    when "Partner"
      actual = @bus_site.admin_console_page.partner_details_section.general_info_hash
    when "SubPartner"
      actual = @bus_site.admin_console_page.partner_details_section.subpartner.general_info_hash
    else
  end
  expected = details_table.hashes.first

  expected.each do |k,v|
    # Using erb instead of place holder such as @external_id
    case k
      when 'External ID:'
        v.gsub!(/@external_id/, @new_p_external_id) unless @new_p_external_id.nil?
      when 'Root Admin:'
        v.gsub!(/@root_admin/, @partner.admin_info.full_name) unless @partner.nil?
        v.gsub!(/@root_admin/, @subpartner.admin_name) unless @subpartner.nil?
      when 'Marketing Referrals:'
        v.gsub!(/@login_admin_email/,@admin_username)
        v.gsub!(/@bus01_admin/, QA_ENV['bus01_admin'])
      when 'Approved:'
        v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
      when 'Pending'
        v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
      when 'Deleted:'
        v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
      else
        # do nothing
    end
    v.replace ERB.new(v).result(binding)
  end
  #(BDS Online Backup) in parent string for some env but not others
  expected.keys.each{ |key| actual[key].should include(expected[key]) }
end

And /^I enabled server in partner account details$/ do
  @bus_site.admin_console_page.partner_details_section.account_details_enable_server
end

Then /^partner account details should be:$/ do |account_details_table|
  actual = @bus_site.admin_console_page.partner_details_section.account_details_hash
  expected = account_details_table.hashes.first
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

# Any of following columns can be verified:
# | Company Type: | Users: | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
# | Contact Country: | Phone: | Industry: | # of employees: | Contact Email: | Vat Number: |
Then /^Partner contact information should be:$/ do |contact_table|
  actual = @bus_site.admin_console_page.partner_details_section.contact_info_hash
  expected = contact_table.hashes.first

  expected.each do |_,v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each{ |key| actual[key].should == expected[key] }
end

When /^I Create an API key for current partner$/ do
  @bus_site.admin_console_page.partner_details_section.create_api_key
  @api_key = @bus_site.admin_console_page.partner_details_section.api_key
end

Then /^Partner API key should be (.+)$/ do |api_key|
  api_key = '' if api_key.eql?('empty')
  @bus_site.admin_console_page.partner_details_section.api_key.should == api_key
end

When /^I add a new ip whitelist (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.add_ip_whitelist(ip)
end

When /^I add a none-api ip whitelist (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.add_ip_whitelist_none_api(ip)
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

When /^I remove a none-api ip whitelist (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.remove_ip_whitelist_none_api(ip)
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

Then /^Partner ip whitelist should be (.+)$/ do |ip|
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.partner_details_section.ip_whitelist.should == ip
end

Then /^Partner account attributes should be:$/ do |attributes_table|
  actual = @bus_site.admin_console_page.partner_details_section.account_attributes_hashes
  expected = attributes_table.rows_hash
  expected.keys.each{ |key| actual[key].should == expected[key] }
end

Then /^Partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.generic_resources_table_rows.should == resources_table.rows
end

Then /^Itemized partner resources should be:$/ do |resources_table|
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == resources_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == resources_table.rows
end

Then /^Partner pooled storage information should be:$/ do |resources_table|
  resources_table.raw[1..-1].each do |row|
    range = row.first.match(/(Desktop|Server)/) ? 1..3 : 0..2
    row[range].each do |v|
      unless v.match(/\d+ .B/)
        v.replace(number_to_human_size(v.match(/\d+/)[0].to_i))
      end
    end
  end
  @bus_site.admin_console_page.partner_details_section.pooled_resource_table_rows.should == resources_table.raw
end

Then /^Partner license types should be:$/ do |license_types_table|
  @bus_site.admin_console_page.partner_details_section.license_types_table_headers.should == license_types_table.headers
  @bus_site.admin_console_page.partner_details_section.license_types_table_rows.should == license_types_table.rows
end

Then /^(Partner|SubPartner) stash info should be:$/ do |status,stash_info_table|
  case status
    when "Partner"
      @bus_site.admin_console_page.partner_details_section.stash_info_table_rows.should == stash_info_table.raw
    when "SubPartner"
      @bus_site.admin_console_page.partner_details_section.subpartner.stash_info_table_rows.should == stash_info_table.raw
    else
  end
end

Then /^Partner internal billing should be:$/ do |internal_billing_table|
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw
  with_timezone(ARIA_ENV['timezone']) do
    expected[2][1].replace(Chronic.parse(expected[2][1]).strftime('%m/%d/%y'))
    expected[3][1].replace(Chronic.parse(expected[3][1]).strftime('%m/%d/%y'))
  end
  actual.flatten.should == expected.flatten.select { |item| item != '' }
end

Then /^New Partner internal billing should be:$/ do |internal_billing_table|
  actual = @bus_site.admin_console_page.partner_details_section.internal_billing_table_rows
  expected = internal_billing_table.raw
  expected[1][1].replace ERB.new(expected[1][1]).result(binding)
  case ERB.new(expected[0][3]).result(binding)
    when "1"
      expected[0][3].replace "Monthly"
      expected[2][1].replace "after 1 month"
      expected[3][1].replace "after 1 month"
    when "12"
      expected[0][3].replace "Yearly"
      expected[2][1].replace "after 1 year"
      expected[3][1].replace "after 1 year"
    when "24"
      expected[0][3].replace "Biennial"
      expected[2][1].replace "after 2 years"
      expected[3][1].replace "after 2 years"
  end

  with_timezone(ARIA_ENV['timezone']) do
    expected[2][1].replace(Chronic.parse(expected[2][1]).strftime('%m/%d/%y')) unless expected[2][1].size == 0
    expected[3][1].replace(Chronic.parse(expected[3][1]).strftime('%m/%d/%y')) unless expected.size < 4
  end

  # actual.flatten.should == expected.flatten.select { |item| item != '' }
  (actual.flatten.select { |item| item != '' }).should == expected.flatten.select { |item| item != '' }

  Log.debug(expected)
end


Then /^Partner sub admins should be empty$/ do
  @bus_site.admin_console_page.partner_details_section.sub_admins_text.should include("No sub-admins.")
end

Then /^Partner sub admins should be:$/ do |sub_admins_table|
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_headers.should == sub_admins_table.headers
  @bus_site.admin_console_page.partner_details_section.sub_admins_table_rows.should == sub_admins_table.rows
end

Then /^Partner billing history should be:$/ do |billing_history_table|
  actual = @bus_site.admin_console_page.partner_details_section.billing_history_hashes
  expected = billing_history_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when "Date"
          with_timezone(ARIA_ENV['timezone']) do
            v.replace(Chronic.parse(v).strftime("%m/%d/%y"))
            Log.debug "Aria time is #{Chronic.now}"
          end
        else
          v.replace ERB.new(v).result(binding)
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I enable stash for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.enable_stash
end

When /^I enable stash for the partner with (default|\d+ GB) stash storage$/ do |quota|
  if quota == 'default'
    @bus_site.admin_console_page.partner_details_section.enable_stash(2)
  else
    @bus_site.admin_console_page.partner_details_section.enable_stash(quota)
  end
end

When /^I disable stash for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.disable_stash
  @bus_site.admin_console_page.click_submit
end

When /^I (enable|disable) co-branding for the partner$/ do |option|
  if option == 'enable'
    @bus_site.admin_console_page.partner_details_section.enable_cobranding
  else
    @bus_site.admin_console_page.partner_details_section.disable_cobranding
  end
end

When /^I (enable|disable) require ingredient for the partner$/ do |option|
  if option == 'enable'
    @bus_site.admin_console_page.partner_details_section.enable_require_ingredient
  else
    @bus_site.admin_console_page.partner_details_section.disable_require_ingredient
  end
end

When /^I add stash to all users for the partner$/ do
  step 'I try to add stash to all users for the partner'
  @bus_site.admin_console_page.click_yes
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

When /^I try to add stash to all users for the partner$/ do
  @bus_site.admin_console_page.partner_details_section.add_stash_to_all_users
end

# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I suspend the partner$/ do
  @bus_site.admin_console_page.partner_details_section.suspend_partner
end

# From partner details view, click Status: Active (change) link
# Select Suspended
# Click Submit
When /^I activate the partner$/ do
  @bus_site.admin_console_page.partner_details_section.activate_partner
end

When /^I change partner external id to (.+)$/ do |external_id|
  @bus_site.admin_console_page.partner_details_section.change_external_id(external_id)
end

And /^I change partner name to (.+)$/ do |new_name|
  @bus_site.admin_console_page.partner_details_section.change_partner_name(new_name)
end

When /^I add a new partner external id$/ do
  @new_p_external_id = "#{Time.now.strftime('%m%d-%H%M-%S')}"
  @bus_site.admin_console_page.partner_details_section.change_external_id(@new_p_external_id)
end

When /^I set product name for the partner$/ do
  @product_name = 'productname-'+(0...8).map{(97+Random.new.rand(26)).chr}.join
  @bus_site.admin_console_page.partner_details_section.set_product_name
  @bus_site.partner_product_name_page.set_product_name @product_name
end

Then /^The partner product name set up successfully$/ do
  @bus_site.partner_product_name_page.product_name_set_message.should == "Product name set successfully. Your new build should be available in a few minutes."
  @bus_site.partner_product_name_page.close_page
end

When /^I change the subdomain to @subdomain$/ do
  @subdomain = (0...8).map{(97+Random.new.rand(26)).chr}.join
  @bus_site.admin_console_page.partner_details_section.change_subdomain
  @bus_site.partner_subdomain_page.change_subdomain @subdomain
end

When /^I change the partner subdomain to (.+)$/ do |subdomain|
  @bus_site.admin_console_page.partner_details_section.change_subdomain
  @bus_site.partner_subdomain_page.change_subdomain subdomain
end

Then /^The subdomain is created with name https:\/\/@subdomain.mozypro.com\/$/ do
  @bus_site.partner_subdomain_page.subdomain.should == "https:\/\/#{@subdomain}.mozypro.com\/"
  @bus_site.partner_subdomain_page.close_page
end

Then /^The partner subdomain is created with name https:\/\/(.+).mozypro.com\/$/ do | subdomain_name |
  @bus_site.partner_subdomain_page.subdomain.should == "https:\/\/" + subdomain_name + ".mozypro.com\/"
  @bus_site.partner_subdomain_page.close_page
end

When /^The subdomain in BUS will be @subdomain$/ do
  @bus_site.admin_console_page.partner_details_section.refresh_bus_section
  #something here
  @bus_site.admin_console_page.partner_details_section.subdomain.should == @subdomain
end

When /^I change (account type|sales channel) to (.+)$/ do | input,type |
  if input == 'account type'
    @bus_site.admin_console_page.partner_details_section.set_account_type(type)
  else
    @bus_site.admin_console_page.partner_details_section.set_sales_channel(type)
  end
end

Then /^(account type|sales channel) should be changed to (.+) successfully$/ do |input,type|
  if input == 'account type'
    @bus_site.admin_console_page.partner_details_section.account_type.should include(type)
  else
    @bus_site.admin_console_page.partner_details_section.get_sales_channel.should include(type)
  end
end

When /^I change the partner contact information (to:|default password)$/ do |password, info_table|
  # table is a | address          | city          | state          | zip_code                 | country          |
  new_info = info_table.hashes.first
  @bus_site.admin_console_page.partner_details_section.set_contact_email(new_info["Contact Email:"]) unless new_info["Contact Email:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_address(new_info["Contact Address:"]) unless new_info["Contact Address:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_city(new_info["Contact City:"]) unless new_info["Contact City:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_country(new_info["Contact Country:"]) unless new_info["Contact Country:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_state(new_info["Contact State:"]) unless new_info["Contact State:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_zip(new_info["Contact ZIP/Postal Code:"]) unless new_info["Contact ZIP/Postal Code:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_phone(new_info["Phone:"]) unless new_info["Phone:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_vat_number(new_info["VAT Number:"]) unless new_info["VAT Number:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_industry(new_info["Industry:"]) unless new_info["Industry:"].nil?
  @bus_site.admin_console_page.partner_details_section.set_contact_of_employees(new_info["# of employees:"]) unless new_info["# of employees:"].nil?
  
  password = QA_ENV['bus_password'] if password == 'to:'
  @bus_site.admin_console_page.partner_details_section.save_changes(password)
end

When /^I clear VAT number for the partner contact information$/ do
  @bus_site.admin_console_page.partner_details_section.clear_vat_number
  @bus_site.admin_console_page.partner_details_section.save_changes(QA_ENV['bus_password'])
end

Then /^Partner contact information is changed$/ do
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

Then /^partner details message should be$/ do |message|
  @bus_site.admin_console_page.partner_details_section.success_messages == message
end

When /^I (Enable|Disable) partner details autogrow$/ do |status|
  case status
    when "Enable"
      @bus_site.admin_console_page.partner_details_section.enable_autogrow
    when "Disable"
      @bus_site.admin_console_page.partner_details_section.disable_autogrow
    else
  end
end

Then /^the pooled resource section of subpartner should have edit link$/ do
  @bus_site.admin_console_page.partner_details_section.subpartner.pooled_resource_edit_link_visible?.should == true
end

Then /^the (Server|Desktop|Generic|Server and Desktop) pooled resource should be editable for the subpartner$/ do |type|
  @bus_site.admin_console_page.partner_details_section.subpartner.edit_pooled_resource
  items_visible = @bus_site.admin_console_page.partner_details_section.subpartner.pooled_resurce_inputs_visible?(type)
  if type.include? "Server"
    items_visible["server_quota_input"].should == true
    items_visible["server_licenses_input"].should == true
  end
  if type.include? "Desktop"
    items_visible["desktop_quota_input"].should == true
    items_visible["desktop_licenses_input"].should == true
  end
  if type.include? "Generic"
    items_visible["generic_quota_input"].should == true
  end
end

When /^I change pooled resource for the subpartner:$/ do |table|
  @bus_site.admin_console_page.partner_details_section.subpartner.change_pooled_resource(friendly_hash(table.hashes.first))
end

When /^I refresh the partner details section$/ do
  @bus_site.admin_console_page.partner_details_section.refresh_bus_section
end

Then /^I delete partner and verify pending delete$/ do
  step "I search and delete partner account by newly created partner company name"
  step %{I search partner by:}, table(%{
    | name          | filter         |
    | @company_name | Pending Delete |
  })
  step %{Partner search results should be:}, table(%{
    | Partner       |
    | @company_name |
  })
end

Then /^I open partner details by (sub)*partner name in header$/ do |sub|
  if sub
    @bus_site.admin_console_page.open_partner_details_from_header(@subpartner)
  else
    @bus_site.admin_console_page.open_partner_details_from_header(@partner)
    @bus_site.admin_console_page.partner_details_section.expand_contact_info
  end
end

Then /^I click Billing Info link to show the details$/ do
  @bus_site.admin_console_page.partner_details_section.click_bill_info_link
end

Then /(contact info|pooled resource) shouldn't be changed and the error message should be:$/ do  |section,message|
  @bus_site.admin_console_page.partner_details_section.error_message.should eq(message)
end

And /^I change contact country and VAT number (to:|default password)$/ do |password, country_vat_table|
  attributes = country_vat_table.hashes.first
  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  vat = attributes['VAT Number']
  country = attributes['Country']
  @bus_site.admin_console_page.partner_details_section.click_change_country_lnk
  @bus_site.admin_console_page.partner_details_section.set_country_for_partner_admin(country)
  if(vat == "@blank_space")
    @bus_site.admin_console_page.partner_details_section.set_vat_for_partner_admin("")
  else
    @bus_site.admin_console_page.partner_details_section.set_vat_for_partner_admin(vat) unless vat.nil?
  end
  password = QA_ENV['bus_password'] if password == 'to:'
  @bus_site.admin_console_page.partner_details_section.submit_change(password)
end

Then /^I am (.+) and I change contact country to (.+)$/ do |admin_type, country_type|
  @bus_site.admin_console_page.partner_details_section.click_change_country_lnk if admin_type == "partner admin"
  country = ""
  case country_type
    when "EU country"
      country = "France"
    else
      country = "United States"
  end
  if admin_type == "partner admin"
    @bus_site.admin_console_page.partner_details_section.set_country_for_partner_admin(country)
  else
    @bus_site.admin_console_page.partner_details_section.expand_contact_info
    @bus_site.admin_console_page.partner_details_section.set_contact_country(country)
  end
end

Then /^VAT number field of Change Contact Country section should (.+)$/ do |behavior|
  case behavior
    when "appear"
      @bus_site.admin_console_page.partner_details_section.vat_of_chg_contact_country_visible?.should be_true
    else
      @bus_site.admin_console_page.partner_details_section.vat_of_chg_contact_country_visible?.should be_false
  end
end

Then /^Change contact country and VAT number (.+) succeed and the message should be:$/ do |status,message|
  case status
    when 'should'
      @bus_site.admin_console_page.partner_details_section.success_messages.should eq(message)
    else
      @bus_site.admin_console_page.partner_details_section.error_message.should eq(message)
  end
end


Then /^VAT number field of Partner Details section should (.+)$/ do |behavior|
  case behavior
    when "appear"
      @bus_site.admin_console_page.partner_details_section.vat_number_visible?.should be_true
    else
      @bus_site.admin_console_page.partner_details_section.vat_number_visible?.should be_false
  end
end

Then /^I expand contact info from partner details section$/ do
  @bus_site.admin_console_page.partner_details_section.expand_contact_info
end

#this is only used for TC.14115
When /^I get the partners name (.+) and type (.+)$/ do |name, type|
  @partner = Bus::DataObj::MozyPro.new
  @partner.company_info.name = name
  @partner.partner_info.type = type
end

Then /^The security filed value is (HIPAA|Standard)$/ do |security|
  @bus_site.admin_console_page.partner_details_section.get_security_value.should == security
end

Then /^I (should|should not) see (.+) part in partner details$/ do |type,section_name|
  if type == 'should not'
    type_value = false
  else
    type_value = true
  end
  @bus_site.admin_console_page.partner_details_section.has_section?(section_name).should == type_value
end

Then /(account details|billing information) should be (expanded|collapsed)$/ do |section_name,status|
  if status == 'collapsed'
    @bus_site.admin_console_page.partner_details_section.element_collapsed?(section_name).should be_true
  else
    @bus_site.admin_console_page.partner_details_section.element_collapsed?(section_name).should be_false
  end
end

And /^I (expand|collapse) the (account details|billing information) section$/ do |action,section_name|
  if action == 'collapse'
    @bus_site.admin_console_page.partner_details_section.collapse_element(section_name)
  else
    @bus_site.admin_console_page.partner_details_section.expand_element(section_name)
  end
end

And /^I click show link of billing history section$/ do
  @bus_site.admin_console_page.partner_details_section.show_billing_history
end

When /I click the latest date link to view the invoice$/ do
  @bus_site.admin_console_page.partner_details_section.click_invoice_link
end

And /^I click admin name (.+) in partner details section$/ do |admin_name|
  admin_name.gsub!(/@partner.admin_info.full_name/,@partner.admin_info.full_name) if @partner
  admin_name.gsub!(/@subpartner.admin_name/,@subpartner.admin_name) if @subpartner
  @bus_site.admin_console_page.partner_details_section.click_admin_name(admin_name)
end

Then /^I will (not )?see fields (.+)$/ do |visible, fields|
  array = fields.split("\,").map{|str|str.strip}
  result = @bus_site.admin_console_page.partner_details_section.check_fields_visible(array)
  result.each{|t| t.should == visible.nil?}
end

And /^field (Account Type|Sales Channel) can (not )?be changed/ do |_, editable|
  @bus_site.admin_console_page.partner_details_section.check_account_type_change.should == editable.nil?
  @bus_site.admin_console_page.partner_details_section.check_sales_channel_change.should == editable.nil?
end

And /^I click view in aria link of billing history section$/ do
  @bus_site.admin_console_page.partner_details_section.view_in_aria
end

Then /^billing history section should (not )?visible$/ do |visible|
  if visible.nil?
    @bus_site.admin_console_page.partner_details_section.billing_history_visible?.should == true
  else
    @bus_site.admin_console_page.partner_details_section.billing_history_visible?.should == false
  end
end

Then /^view in aria link should (not )?be visible$/ do |visible|
  if visible.nil?
    @bus_site.admin_console_page.partner_details_section.find_view_in_aria_link.should == true
  else
    @bus_site.admin_console_page.partner_details_section.find_view_in_aria_link.should == false
  end
end

And /^partner's root role should be (.+)$/ do |role|
  @bus_site.admin_console_page.partner_details_section.get_root_role.should == role
end