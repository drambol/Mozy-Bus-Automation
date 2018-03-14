
Then /^Data shuttle device status summary table header should be:$/ do |device_status_table|
  @bus_site.admin_console_page.data_shuttle_status_section.device_status_table_headers.should == device_status_table.raw.first
end

Then /^Data shuttle device stuck summary table header should be:$/ do |stuck_table|
  @bus_site.admin_console_page.data_shuttle_status_section.device_stuck_table_headers.should == stuck_table.raw.first
end

Then /^Data shuttle inventory status summary table header should be:$/ do |inventory_table|
  @bus_site.admin_console_page.data_shuttle_status_section.inventory_status_table_headers.should == inventory_table.raw.first
end

When /^Data shuttle device (seeding|seed complete|seed error|loading|load complete|load error|cancelled) status table header should be:$/ do |status, status_table|
  @bus_site.admin_console_page.device_status_section.status_table_headers.should == status_table.raw.first
end

When /^Data shuttle device stuck over (\d+) days table header should be:$/ do |days, stuck_table|
  case days.to_i
    when 7
      @bus_site.admin_console_page.data_shuttle_status_section.view_over_7_days_stuck_device
    when 14
      @bus_site.admin_console_page.data_shuttle_status_section.view_over_14_days_stuck_device
    when 30
      @bus_site.admin_console_page.data_shuttle_status_section.view_over_30_days_stuck_device
    else
      raise 'unknown days'
  end

  @bus_site.admin_console_page.device_stuck_section.stuck_table_headers.should == stuck_table.raw.first
end

When /^Data shuttle inventory (.+) status table header should be:$/ do |type, inventory_table|
  case type
    when 'active drivers'
      @bus_site.admin_console_page.data_shuttle_status_section.view_active_drivers
    when 'drivers at 80% life'
      @bus_site.admin_console_page.data_shuttle_status_section.view_drivers_at_80_life
    when 'dead drivers'
      @bus_site.admin_console_page.data_shuttle_status_section.view_dead_drivers
    else
      raise 'unknown types'
  end

  @bus_site.admin_console_page.inventory_status_section.inventory_table_headers.should == inventory_table.raw.first
end

When /^I view data shuttle (seeding|seed complete|seed error|loading|load complete|load error|cancelled) status table$/ do |status|
  case status
    when 'seeding'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_seeding_status
    when 'seed complete'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_seed_complete_status
    when 'seed error'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_seed_error_status
    when 'loading'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_loading_status
    when 'load complete'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_load_complete_status
    when 'load error'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_load_error_status
    when 'cancelled'
      @bus_site.admin_console_page.data_shuttle_status_section.view_device_cancelled_status
    else
      raise 'unknown status type'
  end
end

Then /^I should see data shuttle order (.+) in the cancelled status table$/ do |order_id|
  order_id = @seed_id if order_id == "@seed_id"
  @bus_site.admin_console_page.data_shuttle_status_section.cancelled_table_rows[0][0].text.should == order_id
end