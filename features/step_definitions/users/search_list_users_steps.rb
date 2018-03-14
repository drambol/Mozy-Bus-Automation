# Public: Search user
#
# Required column: keywords
# Optional column: filter
#
When /^I search user by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
  attributes = search_key_table.hashes.first

  attributes['keywords'] = @partner.admin_info.email if attributes['keywords'] == '@mh_user_email'
  attributes['keywords'] = @new_users[0].name if attributes['keywords'] == '@user_name'
  attributes['keywords'] = @new_users[0].email if attributes['keywords'] == '@user_email'
  attributes['keywords'] = @existing_user_email if attributes['keywords'] == '@existing_user_email'
  attributes['keywords'] = @existing_admin_email if attributes['keywords'] == '@existing_admin_email'

  keywords = attributes["keywords"] || ""
  filter = attributes["filter"] || "None"
  partner_filter = attributes["user type"] || ""
  attributes.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  @bus_site.admin_console_page.search_list_users_section.search_user(keywords, filter, partner_filter)
  @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
end

When /^I sort user search results by (User|Name|User Group|Stash|Machines|Storage|Storage Used|Created|Backed Up)(| desc)$/ do |column_name, order|
  @bus_site.admin_console_page.search_list_users_section.sort_users_by(column_name)
  @bus_site.admin_console_page.search_list_users_section.sort_users_by(column_name) if order == ' desc'
end

Then /^User search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_users_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Name'
          v.gsub!(/@user_name/, @new_users.first.name) unless @new_users.nil?
        when 'User'
          v.gsub!(/@user_email/, @new_users.first.email) unless @new_users.nil?
        else
          # do nothing
      end

      v.replace ERB.new(v).result(binding)

      if k == 'User'
        if v.length <= 30
          v.replace ERB.new(v).result(binding).downcase
        else
          v.replace ERB.new(v).result(binding).slice(0,27).downcase
          v << '...'
        end
      end

    end
  end
  expected.each_index { |index|
    expected[index].keys.each { |key|
      #depending on the performance of the testing env, the "Backed Up" time could be different
      if !(expected[index][key].match(/^(1|< a|2|\d) minute(s)* ago$/).nil?)
        actual[index][key].match(/^(1|< a|2|\d) minute(s)* ago$/).nil?.should be_false
      else
        actual[index][key].should == expected[index][key]
      end
    }
  }
end

Then /^Itemized user search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_itemized_users_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Name'
          v.gsub!(/@user_name/, @new_users.first.name.slice(0,27)) unless @new_users.nil?
        when 'User'
          v.gsub!(/@user_email/, @new_users.first.email.slice(0,27)) unless @new_users.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^The users table should( not)? be empty$/ do |t|
  rows = @bus_site.admin_console_page.search_list_users_section.search_results_table_rows
  #rows.to_s.include?('No results found.').should be_true
  if t.nil?
    (rows.empty? || rows.to_s.include?('No results found.')).should be_true
  else
    (!rows.empty? && rows[0].size > 1).should be_true
  end
end

When /^I view user details by (.+)$/ do |user|
  user.replace ERB.new(user).result(binding)

  if @users.nil?
    @bus_site.admin_console_page.search_list_users_section.view_user_details(user[0..26])
  else
    @bus_site.admin_console_page.search_list_users_section.view_user_details(user.gsub(/@user_email/,@new_users.first.email).slice!(0..26))
  end
  view_user_start_time = Time.now.utc
  @bus_site.admin_console_page.user_details_section.wait_until_bus_section_load
  view_user_end_time = Time.now.utc
  @bus_site.log("KPI-View_User_Details:start_time:#{view_user_start_time}/end_time:#{view_user_end_time}")
  @current_user = @bus_site.admin_console_page.user_details_section.user
  @user_id = @bus_site.admin_console_page.user_details_section.user_id
  Log.debug("user id is #{@user_id}")
end

When /^I view MozyHome user details by (.+)$/ do |user|
  @bus_site.admin_console_page.search_list_users_section.view_user_details(user.gsub(/@user_name/,@partner.admin_info.email[0..26]).slice!(0..26))
end

When /^I refresh Search List User section$/ do
  @bus_site.admin_console_page.search_list_users_section.refresh_bus_section
end

When /^I export the users csv$/ do
  @bus_site.admin_console_page.search_list_users_section.export_csv
end

When /^I clear user search results$/ do
  @bus_site.admin_console_page.search_list_users_section.clear_search
end

Then /^The exported users csv file should be like$/ do |report_table|
  report_table.map_column!('Column B') do |value|
    value.replace ERB.new(value).result(binding)
  end

  report_table.map_column!('Column I') do |value|
    value.gsub!(/@today/,DateTime.now.strftime("%m/%d/%y"))
    value
  end

  actual_csv = FileHelper.read_csv_file("users")
  actual_csv.should == report_table.rows
end

#============================================================
#call the method <search_results_hashes> from search_list_users_section.rb
#============================================================
And /^Search \/ List Users table should be:$/ do | user_table |
  expected = user_table.hashes
  actual = @bus_site.admin_console_page.search_list_users_section.search_results_hashes
  #======Construct a new array based on existing "actual" array, so that both new_actual and expected have the same keys======
  expected_keys = expected[0].keys
  new_actual = []
  for i in 0..actual.size - 1
    new_actual_array = {}
    for j in 0..expected_keys.size - 1
      new_actual_array[expected_keys[j]] = actual[i][expected_keys[j]]
    end
    new_actual << new_actual_array
  end
  puts "========expected table array======"
  puts expected
  puts "========actual table array======"
  puts new_actual
  #======two arrays should be exactly identical======
  (new_actual - expected).should == []
end

#============================================================
#call the method <search_results_hashes> from search_list_itemized_users_section.rb
#============================================================
And /^Search \/ List Users \(itemized\) table should be:$/ do | user_table |
  expected = user_table.hashes
  actual = @bus_site.admin_console_page.search_list_itemized_users_section.search_results_hashes
  #======Construct a new array based on existing "actual" array, so that both new_actual and expected have the same keys======
  expected_keys = expected[0].keys
  new_actual = []
  for i in 0..actual.size - 1
    new_actual_array = {}
    for j in 0..expected_keys.size - 1
      new_actual_array[expected_keys[j]] = actual[i][expected_keys[j]]
    end
    new_actual << new_actual_array
  end
  puts "========expected table array======"
  puts expected
  puts "========actual table array======"
  puts new_actual
  #======two arrays should be exactly identical======
  (new_actual - expected).should == []
end


#============================================================
#call the method <search_results_table_headers> from search_list_itemized_users_section.rb
#============================================================
Then /^Search \/ List Users \(itemized\) table header should be:$/ do |search_list_user_table|
  @bus_site.admin_console_page.search_list_itemized_users_section.search_results_table_headers.should == search_list_user_table.raw.first
end