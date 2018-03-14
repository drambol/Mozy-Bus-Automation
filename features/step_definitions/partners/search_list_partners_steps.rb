# Public: Search partner
#
# Required column: name or email
# Optional column: filter, including sub-partners
#
When /^I search partner by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  attributes = search_key_table.hashes.first
  keywords = (attributes['name'] || attributes['email'])
  keywords.replace ERB.new(keywords).result(binding)
  keywords = keywords.gsub(/@company_name/,@partner.company_info.name).gsub(/@admin_email/,@partner.admin_info.email) unless @partner.nil?
  keywords = keywords.gsub(/@company_name/,@subpartner.company_name) unless @subpartner.nil?
  filter = attributes['filter'] || 'None'
  including_sub_partners = (attributes['including sub-partners'] || 'yes').eql?('yes')
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords, filter, including_sub_partners)
end

When /^I search partner by (.+)$/ do |keywords|
  keywords.replace ERB.new(keywords).result(binding)
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_partner'])
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords, 'None', true, true)
end

When /^I full search partner by (.+)$/ do |keywords|
  #keywords string would like : @new_p_external_id;last four digits;contact zip
  keywords.gsub!(/@new_p_external_id/,@new_p_external_id).gsub!(/last four digits/,@partner.admin_info.email[@partner.admin_info.email.index('@')-4,4])
  keywords.gsub!(/zip code/,@partner.company_info.zip)
  keywords.gsub!("\;"," ")
  @bus_site.admin_console_page.search_list_partner_section.search_partner(keywords, 'None', true, true)
end

When /^I act as partner by:$/ do |search_key_table|
  attributes = search_key_table.hashes.first
  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
  end

  act_as_partner_start_time = 0
  act_as_partner_end_time = 0
  act_as_admin_start_time = 0
  act_as_admin_end_time = 0

  step %{I search partner by:}, table(%{
      |#{search_key_table.headers.join('|')}|
      |#{search_key_table.rows.first.join('|')}|
    })
  keywords = (attributes['name'] || attributes['email'])
  keywords = keywords.gsub(/@company_name/,@partner.company_info.name).gsub(/@admin_email/,@partner.admin_info.email) unless @partner.nil?
  if attributes['name'].nil? == false
    find(:xpath, "//a[text()='#{keywords}']").click
    @current_partner = @bus_site.admin_console_page.partner_details_section.partner
    act_as_partner_start_time = Time.now.utc
    @bus_site.admin_console_page.partner_details_section.act_as_partner
  elsif attributes['email'].nil? == false
    find(:xpath, "//a[text()='#{keywords}']").click
    @current_partner = @bus_site.admin_console_page.admin_details_section.partner
    act_as_admin_start_time = Time.now.utc
    @bus_site.admin_console_page.admin_details_section.act_as_admin
  else
    raise 'Please act as partner by name or email'
  end
  wait_until { @bus_site.admin_console_page.has_stop_masquerading_link? }
  act_as_partner_end_time = Time.now.utc if act_as_partner_start_time != 0
  act_as_admin_end_time = Time.now.utc if act_as_admin_start_time != 0
  @bus_site.log("KPI-Act_As_Partner:start_time:#{act_as_partner_start_time}/end_time:#{act_as_partner_end_time}") if act_as_partner_end_time != 0
  @bus_site.log("KPI-Act_As_Admin:start_time:#{act_as_admin_start_time}/end_time:#{act_as_admin_end_time}") if act_as_admin_end_time != 0
  @partner_id = @bus_site.admin_console_page.current_partner_id
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id if @current_partner
end

# Public: View partner details by click name in search partner results
# Required: search list partner section must be visible
When /^I view partner details by (.+)$/ do |search_key|
  search_key.replace ERB.new(search_key).result(binding)
  @bus_site.admin_console_page.search_list_partner_section.view_partner_detail(search_key)
  view_partner_details_start_time = Time.now.utc
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
  view_partner_details_end_time = Time.now.utc
  @bus_site.log("KPI-View_Partner_Details:start_time:#{view_partner_details_start_time}/end_time:#{view_partner_details_end_time}")
end

When /^Rollback to pooled storage link should (|not )be there$/ do |boolean|
  if (boolean.to_s == '')
    @bus_site.admin_console_page.partner_details_section.find_rollback_link.should be_true
  else
    @bus_site.admin_console_page.partner_details_section.find_rollback_link.should be_false
  end
end

# Public: View admin details by click email in search partner results
# Required: search list partner section must be visible
When /^I view admin details by (.+)$/ do |partner_email|
  partner_email = @subpartner.admin_email_address if partner_email == '@subpartner.admin_email_address'
  @bus_site.admin_console_page.search_list_partner_section.view_root_admin_detail(partner_email)
end

Then /^Partner search results (should|should not) be:$/ do |match, results_table|
  actual = @bus_site.admin_console_page.search_list_partner_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'External ID'
          v.gsub!(/@external_id/, @new_p_external_id) unless @new_p_external_id.nil?
        when 'Partner'
          v.gsub!(/@company_name/, @partner.company_info.name) unless @partner.nil?
          v.gsub!(/@company_name/, @subpartner.company_name) unless @subpartner.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when "Root Admin"
          v.gsub!(/@admin_email/, @partner.admin_info.email) unless @partner.nil?
        else
          # do nothing
      end
    end
  end
  if match.eql?('should')
    expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
  else
    expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should_not == expected[index][key]} }
  end
end

Then /^Partner search results should be empty$/ do
  rows = @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows
  rows.to_s.include?('No results found.').should be_true
end

When /^I refresh Search List Partners section$/ do
  @bus_site.admin_console_page.search_list_partner_section.refresh_bus_section
end

When /^I clear partner search results$/ do
  @bus_site.admin_console_page.search_list_partner_section.clear_search
  @bus_site.admin_console_page.search_list_partner_section.wait_until_bus_section_load
end

Then /^I will see (.+) in the search partner input box$/ do |search|
  @bus_site.admin_console_page.search_list_partner_section.search_input_text.should == search
end

Then /^I get current partner name$/ do
  @current_partner_name = @bus_site.admin_console_page.search_list_partner_section.get_partner_name if @current_partner.nil?
end

When /^I use a existing partner:$/ do |partner_table|
  attributes = partner_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil  if (attribute == '' && !attributes.has_key?("security") )
  end

  case attributes['partner type']
    when CONFIGS['bus']['company_type']['oem']
      @partner = Bus::DataObj::MozyPro.new # use mozypro construction here as class sub_partner do not have necessary attributes
    when CONFIGS['bus']['company_type']['mozypro']
      @partner = Bus::DataObj::MozyPro.new
    when CONFIGS['bus']['company_type']['mozyenterprise']
      @partner = Bus::DataObj::MozyEnterprise.new
    when CONFIGS['bus']['company_type']['mozyenterprise_dps']
      @partner = Bus::DataObj::MozyEnterpriseDPS.new
    when CONFIGS['bus']['company_type']['reseller']
      @partner = Bus::DataObj::Reseller.new
    when CONFIGS['phoenix']['company_type']['mozyhome']
      @partner = Bus::DataObj::MozyHome.new
    else
      raise "Error: Company type #{type} does not exist."
  end
  @partner.partner_info.type = attributes['partner type']
  @partner.company_info.name = attributes['company name'] unless attributes['company name'].nil?
  @partner.company_info.country = attributes['country'] unless attributes['country'].nil?
  @partner.partner_info.parent = attributes['create under'] || CONFIGS['bus']['mozy_root_partner']['mozypro'] # to be changed according to partner type
  @partner.admin_info.email = attributes['admin email'] unless attributes['admin email'].nil?
  @partner.admin_info.full_name = attributes['admin name'] unless attributes['admin name'].nil?
  @partner_id = attributes['partner id'] unless attributes['partner id'].nil?
end

Then /^I get current partner type/ do
  @partner = Bus::DataObj::MozyPro.new if @current_partner.nil?
  @partner.partner_info.type = @bus_site.admin_console_page.search_list_partner_section.get_partner_type
end

