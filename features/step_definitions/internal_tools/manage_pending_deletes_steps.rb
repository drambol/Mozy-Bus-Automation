When /^I search partners in (pending-delete not available to purge|pending-delete available to purge|who have been purged) by:$/ do |match,search_key_table|
  attributes = search_key_table.hashes.first
  keywords = (attributes['name'] || attributes['email'])
  keywords = keywords.gsub(/@company_name/,@partner.company_info.name).gsub(/@admin_email/,@partner.admin_info.email) unless @partner.nil?
  keywords = keywords.gsub(/@company_name/,@subpartner.company_name).gsub(/@admin_email/,@subpartner.admin_email_address) unless @subpartner.nil?
  full_search = (attributes['full search'] || 'no').eql?('yes')
  @bus_site.admin_console_page.manage_pending_deletes_section.search_partners(match, keywords, full_search)
end

Then /^Partners in (pending-delete not available to purge|pending-delete available to purge|who have been purged) search results should be:$/ do |type, results_table|
  actual = @bus_site.admin_console_page.manage_pending_deletes_section.search_results_hashes(type)
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'ID'
          v.gsub!(/@partner_id/, @partner_id) unless @partner_id.nil?
        when 'Aria ID'
          v.gsub!(/@aria_id/, @aria_id) unless @aria_id.nil?
        when 'Partner'
          v.gsub!(/@company_name/, @partner.company_info.name) unless @partner.nil?
          v.gsub!(/@company_name/, @subpartner.company_name) unless @subpartner.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Request Date'
          v.replace(Chronic.parse(v).strftime('%a %b %d %Y'))
        when 'Date Purged'
          v.replace(Chronic.parse(v).strftime('%a %b %d %Y'))
        when "Root Admin"
          v.gsub!(/@admin_email/, @partner.admin_info.email) unless @partner.nil?
          v.gsub!(/@admin_email/, @subpartner.admin_email_address) unless @subpartner.nil?
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index|
    expected[index].keys.each{ |key|
      if key.eql?('Request Date')|| key.eql?('Date Purged')
        actual[index][key].replace(Chronic.parse(actual[index][key]).strftime('%a %b %d %Y'))
      end
      actual[index][key].should == expected[index][key]
      }
    }
end

Then /^I change to (\d+) days to purge account after delete/ do |days|
  @bus_site.admin_console_page.manage_pending_deletes_section.change_pending_deletes_setting(days)
end

Then /^I verify days to purge account after delete should be (\d+)/ do |days|
  @bus_site.admin_console_page.manage_pending_deletes_section.get_pending_deletes_setting.should == days
end

Then /^I make sure pending deletes setting is (\d+) days/ do |days|
  @bus_site.admin_console_page.manage_pending_deletes_section.change_pending_deletes_setting_to_default(days)
end

Then /^I purge partner by (.+)/ do |company_name|
  @bus_site.admin_console_page.manage_pending_deletes_section.purge_partner(QA_ENV['bus_password'], company_name)
end

Then /^I purge partner for cleanup by (.+)/ do |company_name|
  begin
    step %{I search partners in pending-delete available to purge by:}, table(%{
      | name            |
      | #{company_name} |})
    step %{Partners in pending-delete available to purge search results should be:}, table(%{
      | Partner         |
      | #{company_name} |})
    step %{I purge partner by #{company_name}}
    step %{I search partners in who have been purged by:}, table(%{
      | name            |
      | #{company_name} | })
    step %{Partners in who have been purged search results should be:}, table(%{
      | Partner         |
      | #{company_name} |})
  rescue Exception => ex
    Log.debug ex.to_s
  end
end

Then /^I undelete partner in (pending-delete not available to purge|pending-delete available to purge) by (.+)/ do |where, company_name|
  @bus_site.admin_console_page.manage_pending_deletes_section.undelete_partner(where, company_name)
end

Then /^I advance the partner delete timestamp to (\d+) days/ do |days|
  DBHelper.update_partner_delete_timestamp(@partner_id, days)
  @bus_site.admin_console_page.manage_pending_deletes_section.refresh_bus_section
  @bus_site.admin_console_page.manage_pending_deletes_section.wait_until_bus_section_load
end

Then /^I should see (.+) in (pending-delete not available to purge|pending-delete available to purge) table$/ do |message, table|
  actual = @bus_site.admin_console_page.manage_pending_deletes_section.pending_deletes_table_text(table)
  actual.should include(message)
end

Then /^I verify can not undelete a purged partner$/ do
  @bus_site.admin_console_page.manage_pending_deletes_section.undelete_button_on_purged_table.should == 0
end

When /^I purge multiple partners from csv file$/ do
  # csv file with root admin email of partners
  # column header: Root Admin
  csv_file = File.expand_path(File.dirname(__FILE__) + '../../../internal_tools/pro_partner_available_to_purge.csv')

  Log.debug "Loading partners Root Admin email from #{csv_file}"
  CSV.foreach(csv_file, headers: true) do |row|
    begin
      admin_email = row["Root Admin"]
      Log.debug admin_email
      step %{I search partners in pending-delete available to purge by:}, table(%{
      | email          |
      | #{admin_email} |})
      step %{Partners in pending-delete available to purge search results should be:}, table(%{
      | Root Admin     |
      | #{admin_email} |})
      step %{I purge partner by #{admin_email}}
      step %{I search partners in who have been purged by:}, table(%{
      | email          |
      | #{admin_email} |})
      step %{Partners in who have been purged search results should be:}, table(%{
      | Root Admin     |
      | #{admin_email} |})
    rescue Exception => ex
      Log.debug ex.to_s
    end
  end
end
