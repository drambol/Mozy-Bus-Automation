module Bus
  # This class provides actions for order details page section
  class OrderDetailsSection < SiteHelper::Section

    # Private elements
    #
    elements(:cancel_order_links, xpath: "//a[text()='cancel']")
    element(:order_detail_table, css: "div[id^=resource-show_data_shuttle_order-] table.table-view")
    element(:shipping_tracking_table, css: "div[id^=resource-show_data_shuttle_order-] table.mini-table")
    element(:add_drive_to_order_links, xpath: "//a[text()='Add Drive To Order']")
    element(:add_drive_btn, xpath: "//input[@type='submit' and @value='Add Drive']")
    element(:message_div, xpath: "//div[contains(@id,'resource-add_drive_to_seed_device_order')]/ul[@class='flash successes' or @class='flash errors']/li")

    # Public: Click cancel button of first order in list
    #
    # Example
    #   @bus_admin_console_page.order_details_section.cancel_latest_order
    #
    # Returns nothing
    def cancel_latest_order
      wait_until_bus_section_load
      cancel_order_links.first.click
    end

    # Public: Shipping tracking table rows text
    #
    # Example
    #   @bus_admin_console_page.order_details_section.shipping_tracking_table_rows
    #   # => [["1","","","Error"]]
    #
    # Returns Shipping tracking table rows text
    def shipping_tracking_table_rows
      shipping_tracking_table.rows_text
    end

    # Public: Last created order status
    #
    # Example
    #   @bus_admin_console_page.order_details_section.latest_order_status
    #   # => "Ordered"
    #
    # Returns status text
    def latest_order_status
      order_detail_table.rows.first[1].text
    end

    def has_inbound_link?(inbound)
      find_link(inbound).present?
    end

    def order_details_hash
      order_detail_table.hashes
    end

    # Public: Click Add Drive To Order to add drive to data shuttle order
    #
    # Example
    #   @bus_admin_console_page.order_details_section.add_drive_to_order
    #
    # Returns nothing
    def add_drive_to_order
      wait_until { find_link("Add Drive To Order").visible? }
      add_drive_to_order_links.click
      add_drive_btn.click
      wait_until { find(:xpath, "//div[contains(@id, 'resource-add_drive_to_seed_device_order-')]/ul/li").visible? }
    end

    # Public: Messages for add drive to order
    #
    # Example
    #  @bus_admin_console_page.order_details_section.messages
    #  # => "Successfully added drive to order 5277"
    #
    # Returns success or error message text
    def messages
      message_div.text
    end
  end
end
