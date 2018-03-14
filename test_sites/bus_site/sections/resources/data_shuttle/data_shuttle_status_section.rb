module Bus
  # This class provides actions for order data shuttle page section
  class DataShuttleStatusSection < SiteHelper::Section

    # Private elements
    #
    element(:device_status_table, xpath: "//table[@class='mini-table']/thead[1]")
    element(:device_stuck_table, xpath: "//table[@class='mini-table'][2]")
    element(:inventory_status_table, css: 'table.mini-table:last-child')

    # Device status tables
    element(:seeding_link, css: "a[href='/resource/show_data_shuttle_device_status/seeding']")
    element(:seed_complete_link, css: "a[href='/resource/show_data_shuttle_device_status/seed_complete']")
    element(:seed_error_link, css: "a[href='/resource/show_data_shuttle_device_status/seed_error']")
    element(:loading_link, css: "a[href='/resource/show_data_shuttle_device_status/loading']")
    element(:load_complete_link, css: "a[href='/resource/show_data_shuttle_device_status/load_complete']")
    element(:load_error_link, css: "a[href='/resource/show_data_shuttle_device_status/load_error']")
    element(:cancelled_link, css: "a[href='/resource/show_data_shuttle_device_status/cancelled']")

    # Device stuck tables
    element(:over_7_days_link, css: "a[href='/resource/show_data_shuttle_device_status/7']")
    element(:over_14_days_link, css: "a[href='/resource/show_data_shuttle_device_status/14']")
    element(:over_30_days_link, css: "a[href='/resource/show_data_shuttle_device_status/30']")

    # Inventory status tables
    element(:active_drivers_link, css: "a[href='/resource/show_drive_inventory_status/active']")
    element(:drivers_at_80_link, css: "a[href='/resource/show_drive_inventory_status/80percent']")
    element(:dead_drivers_link, css: "a[href='/resource/show_drive_inventory_status/dead']")

    # cancelled status table
    element(:status_cancelled_table, xpath: "//div[contains(@id,'status-cancelled-content')]/div/table")
    #

    def device_status_table_headers
      device_status_table.headers_text
    end

    def device_stuck_table_headers
      device_stuck_table.headers_text
    end

    def inventory_status_table_headers
      inventory_status_table.headers_text
    end

    def view_device_seeding_status
      seeding_link.click
    end

    def view_device_seed_complete_status
      seed_complete_link.click
    end

    def view_device_seed_error_status
      seed_error_link.click
    end

    def view_device_loading_status
      loading_link.click
    end

    def view_device_load_complete_status
      load_complete_link.click
    end

    def view_device_load_error_status
      load_error_link.click
    end

    def view_device_cancelled_status
      cancelled_link.click
    end

    def view_over_7_days_stuck_device
      over_7_days_link.click
    end

    def view_over_14_days_stuck_device
      over_14_days_link.click
    end

    def view_over_30_days_stuck_device
      over_30_days_link.click
    end

    def view_active_drivers
      active_drivers_link.click
    end

    def view_drivers_at_80_life
      drivers_at_80_link.click
    end

    def view_dead_drivers
      dead_drivers_link.click
    end

    def cancelled_table_rows
      status_cancelled_table.rows
    end

  end
end
