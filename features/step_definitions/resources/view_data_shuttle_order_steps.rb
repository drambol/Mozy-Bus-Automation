Then /^I get the data shuttle seed id for (.+)$/ do |partner_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(partner_name)

  @seed_id = @bus_site.admin_console_page.view_data_shuttle_orders_section.top_seed_id
  Log.debug("seed id is #{@seed_id}")
end

Then /^I get the data shuttle seed id by partner (.+)$/ do |partner_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(partner_name)

  @seed_id = @bus_site.admin_console_page.view_data_shuttle_orders_section.top_seed_id
  Log.debug("seed id is #{@seed_id}")
end

Then /^I search order in view data shuttle orders section by (.+)$/ do |keywords|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['view_data_shuttle_orders'])
  @bus_site.admin_console_page.view_data_shuttle_orders_section.search_order(keywords)
  @order_search_table = @bus_site.admin_console_page.view_data_shuttle_orders_section.order_results_hashes[0]
end

Then /^order search results in data shuttle orders section should be:$/ do |orders_table|
  actual = @order_search_table
  expected = orders_table.hashes[0]
  expected.keys.each{|key|
    expected[key].replace ERB.new(expected[key]).result(binding) if key == 'Pro Partner Name'
    actual[key].should == expected[key]
  }
end

Then /^data shuttle order details info should be$/ do |orders_table|
  actual = @bus_site.admin_console_page.order_details_section.order_details_hash
  expected = orders_table.hashes[0]
  expected.keys.each{|key|
    expected[key].replace ERB.new(expected[key]).result(binding) if key == 'License Key'
    if key == 'Created'
      expected[key] = expected[key].replace(Chronic.parse(expected[key]).strftime('%m/%d/%y'))
      actual[0][key].to_s.should include (expected[key].to_s)
    else
      actual[0][key].to_s.should == expected[key].to_s
    end
  }
end


Then /^the data shuttle order details should contain valid inbound number$/ do
  @bus_site.admin_console_page.view_data_shuttle_orders_section.view_latest_order
  @ship_table = @bus_site.admin_console_page.order_details_section.shipping_tracking_table_rows[0]
  @status = @ship_table[3]
  @inbound_number = @ship_table[2]
  @status.should == 'Shipped'
  @inbound_number.should_not be_nil
  @bus_site.admin_console_page.order_details_section.has_inbound_link?(@inbound_number).should == true
  Log.debug("ship status is #{@status}, inbound number is #{@inbound_number}")
end

When /^I view data shuttle order details$/ do
  @bus_site.admin_console_page.view_data_shuttle_orders_section.view_latest_order
end

When /^I add drive to data shuttle order$/ do
  @bus_site.admin_console_page.order_details_section.add_drive_to_order
end

Then /^Add drive to data shuttle order message should include (.+)$/ do |messages|
  @bus_site.admin_console_page.order_details_section.messages.include?(messages).should be_true
end

And /^I should not query resources orders record from DB for the data shuttle order$/ do
  DBHelper.get_count_seed_device_id(@seed_id.to_i).should == "0"
end

Then /^data shuttle order info should be$/ do |table|
  actual = @bus_site.admin_console_page.view_data_shuttle_orders_section.get_order_info
  expected = table.hashes[0]
  expected.keys { |key|
    expected[key].replace ERB.new(expected[key]).result(binding)
    actual[key].should == expected[key]
  }
end

Then /^the shipping tracking table of data shuttle order should be$/ do |table|
  actual = @bus_site.admin_console_page.view_data_shuttle_orders_section.get_shipping_tracking_table_hashes
  expected = table.hashes
  expected.each_index { |index|
    expected[index].keys.each { |key|
      actual[index][key].should == expected[index][key]
    }
  }
end

And /^I click (outbound|inbound) link of shipping tracking table$/ do |type|
  if type == 'outbound'
    @bus_site.admin_console_page.view_data_shuttle_orders_section.click_outbound_link
  else
    @bus_site.admin_console_page.view_data_shuttle_orders_section.click_inbound_link
  end
end

Then /^the new url should contains (.+)$/ do |content|
  @bus_site.fedex_page.current_url.should include(content)
end

Then /^the status of shipping tracking table should have Submitted and Processing and Burned$/ do
  arr_status = ['Submitted','Processing','Burned']
  flag = true
  index = -1
  index1 = -1
  times = 0
  actual_status = 'Submitted'
  while flag == true && index < 2
    if index == -1
      actual_status1 = @bus_site.admin_console_page.view_data_shuttle_orders_section.get_shipping_tracking_table_hashes.first['Status']
    else index > -1
      while index == index1 && times < 10
        @bus_site.admin_console_page.view_data_shuttle_orders_section.refresh_view_data_shuttle_order_section
        actual_status1 = @bus_site.admin_console_page.view_data_shuttle_orders_section.get_shipping_tracking_table_hashes.first['Status']
        break if actual_status1 != actual_status
        times = times + 1
      end
    end
    index1 = arr_status.index(actual_status1)
    flag =false if index1.nil? || index1 <= index
    index = index1
    actual_status = actual_status1
  end
  flag.should == true
end

And /^I refresh view data shuttle order section$/ do
  @bus_site.admin_console_page.view_data_shuttle_orders_section.refresh_view_data_shuttle_order_section
end

