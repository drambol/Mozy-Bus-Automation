#
# Available columns:
# | ID:     | External ID: | Billing code: | Status:        | Available Keys: | Available Quota: | Default quota for new installs:           | Default user group: |
# | 1234567 | (change)     | (change)      | Active(change) | 0               | 0 GB             | 2 GB (Desktop) and 2 GB (Server) (change) |
#
Then /^User group details should be:$/ do |details_table|
  actual = @bus_site.admin_console_page.user_group_details_section.group_details_hash
  expected = details_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'ID:'
        if expected[header].start_with?('@')
          actual[header].length.should == expected[header].length - 1
          actual[header].match(/\d{6}/).nil?.should be_false
        else
          actual[header].should == expected[header]
        end
      else
        actual[header].should == expected[header]
    end
  end
end

Then /^User group users list details should be:$/ do |users_list_table|
  actual = @bus_site.admin_console_page.user_group_details_section.users_list_table_hashes
  expected = users_list_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^I should not see (.+) text on user group details section$/ do |text|
  @bus_site.admin_console_page.user_group_details_section.has_change_name_link?
  @bus_site.admin_console_page.user_group_details_section.has_no_content?(text).should be_true
end

When /^I enable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.enable_stash
end

When /^I disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.disable_stash
  @bus_site.admin_console_page.click_submit
  @bus_site.admin_console_page.user_group_details_section.wait_until_bus_section_load
end

When /^I cancel disable stash for the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.cancel_disable_stash
end

When /^I enable stash for all users$/ do
  @bus_site.admin_console_page.user_group_details_section.add_stash_to_all_user
end

When /^I refresh User Group Details section$/ do
  @bus_site.admin_console_page.user_group_details_section.refresh_bus_section
end

When /^I close the user group detail page$/ do
  @bus_site.admin_console_page.user_group_details_section.close_bus_section
end

When /^I delete the user group$/ do
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
end

When /^I search and delete (.+) user group$/ do |group_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_user_groups'])
  @bus_site.admin_console_page.list_user_groups_section.view_user_group_detail(group_name)
  @bus_site.admin_console_page.user_group_details_section.delete_user_group
  @bus_site.admin_console_page.list_user_groups_section.wait_until_bus_section_load
end


When /^I view user group details by clicking group name: (.+)$/ do |group_name|
  @bus_site.admin_console_page.user_group_list_section.view_user_group(group_name)
end

When /^I open (.+) tab under user group details$/ do |tab_name|
  @bus_site.admin_console_page.user_group_details_section.click_tab(tab_name)
end

And /^I change (server|desktop) client configuration to (.+)$/ do | type, config_value |
    @bus_site.admin_console_page.user_group_details_section.select_client_config(type, config_value)
end

Then /^(.+) client configuration should be (.+)$/ do |type, config_value|
  case type
    when 'Server'
      @bus_site.admin_console_page.user_group_details_section.server_config_value == config_value
    when 'Desktop'
      @bus_site.admin_console_page.user_group_details_section.desktop_config_value == config_value
  end
end

Then /^The key appears( not)? marked as a data shuttle order$/ do |t|
  if t.nil?
    @bus_site.admin_console_page.user_group_details_section.data_shuttle_keys_hashes[0]['Product Key'].should == @order.license_key[0]+ " *"
  else
    @bus_site.admin_console_page.user_group_details_section.data_shuttle_keys_hashes[0]['Product Key'].should == @order.license_key[0]
  end
end

When /^the (.+) table details under user group details should be:$/ do |match, table|
  actual = @bus_site.admin_console_page.user_group_details_section.search_table_details_hash(match)
  expected = table.hashes
  expected.each_index do |index|
    expected[index].each do |k, v|
      v.replace ERB.new(v).result(binding)
      case k
        when 'Product Key'
          (actual[index][k].match(/\w{20}/).size>0).should == true
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
          actual[index][k].should == v
        when 'User'
          if v.length <= 30
            v.downcase
          else
            v.replace ERB.new(v).result(binding).slice(0,27).downcase
            v << '...'
          end
          actual[index][k].should == v
        else
          actual[index][k].should == v
      end
    end
  end
end

Then /I change user group name to (.+)$/ do |new_name|
  @bus_site.admin_console_page.user_group_details_section.change_user_group_name(new_name)
end

Then /I change user group status to (.+)$/ do |status|
  @bus_site.admin_console_page.user_group_details_section.change_user_group_status(status)
end

Then /I change user group default storage to (.+) GB$/ do |storage|
  @bus_site.admin_console_page.user_group_details_section.change_user_group_default_storage(storage)
end

When /^I check total keys under user group details is (.+)$/ do |total|
  @bus_site.admin_console_page.user_group_details_section.get_total_keys.should == total
end

When /^I click the last keys page under user group details$/ do
  @bus_site.admin_console_page.user_group_details_section.click_last_keys_page
end

When /^There are (.+) keys under user group details$/ do |num|
  @bus_site.admin_console_page.user_group_details_section.get_current_page_keys.should == num
end

Then /I change legacy user group (desktop|server) default storage to (.+) GB$/ do |type,storage|
  @bus_site.admin_console_page.user_group_details_section.change_legacy_user_group_default_storage(type,storage)
end

Then /^there (is|is not) data shuttle text in the user group keys section$/ do |type|
  if type == 'is'
    @bus_site.admin_console_page.user_group_details_section.data_shuttle_text_visible?.should == true
  else
    @bus_site.admin_console_page.user_group_details_section.data_shuttle_text_visible?.should == false
  end
end

Then /^I click user (.+) on user group list section's user table$/ do |user_name|
  @bus_site.admin_console_page.user_group_details_section.click_user(user_name)
end
