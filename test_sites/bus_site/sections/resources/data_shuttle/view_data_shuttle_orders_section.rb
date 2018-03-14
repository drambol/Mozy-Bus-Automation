module Bus
  # This class provides actions for view data shuttle orders page section
  class ViewDataShuttleOrdersSection < SiteHelper::Section

    # Private elements
    #
    element(:search_order_tb, id: "seed_device_order_search")
    element(:search_order_btn, css: "div#resource-view_seed_device_orders-content input[value=Submit]")
    element(:order_results_table, css: "div#resource-view_seed_device_orders-content table.table-view")
    elements(:order_view_info_ps, xpath: "//div[contains(@id,'resource-show_data_shuttle_order')]/div[2]/p")
    element(:data_center_p, xpath: "//div[contains(@id,'resource-show_data_shuttle_order')]/div[2]/h3")
    element(:shipping_tracking_table, xpath: "//div[contains(@id,'resource-show_data_shuttle_order')]/table[@class='mini-table']")
    element(:outbound_link, xpath: "//table/tbody/tr/td[2]/a")
    element(:inbound_link, xpath: "//table/tbody/tr/td[3]/a")
    element(:refresh_order_view_img, xpath: "//div[contains(@id,'resource-show_data_shuttle_order')]/h2/a/img[@alt='Refresh']")
    element(:order_view_title_a, xpath: "//div[contains(@id,'resource-show_data_shuttle_order')]/h2/a[contains(@onclick,'toggle_module')]")
    # Public: Search data shuttle order
    #
    # Examples
    #
    #  @bus_admin_console_page.view_data_shuttle_orders_section.search_order("Lego Company")
    #
    # Returns Nothing
    def search_order(company_name)
      search_order_tb.type_text(company_name)
      search_order_btn.click
    end

    # Public: Click to view latest created data shuttle order in list
    #
    # Examples
    #
    #  @bus_admin_console_page.view_data_shuttle_orders_section.view_latest_order
    #
    # Returns Nothing
    def view_latest_order
      wait_until_bus_section_load
      order_results_table.rows.first[0].find("a").click
    end

    def top_seed_id
      wait_until_bus_section_load
      order_results_table.rows.first[0].find("a").text
    end

    def order_results_hashes
      wait_until_bus_section_load
      order_results_table.rows_text.map{ |row| Hash[*order_results_table.headers_text.zip(row).flatten] }
    end

    def order_results_table_rows
      order_results_table.rows_text
    end

    def get_order_info
      wait_until_bus_section_load
      order_info = Hash.new
      wait_until { all(:xpath, "//div[contains(@id,'resource-show_data_shuttle_order')]/div[2]/h3").size > 0 }
      all_info_array = (order_view_info_ps[0].text+"  "+order_view_info_ps[1].text+"  "+data_center_p.text).split("  ")
      all_info_array.each_index do |n|
        order_info[all_info_array[n].split(":")[0]] = all_info_array[n].gsub(" ","").split(":")[1]
      end
      order_info
    end

    def get_shipping_tracking_table_hashes
      shipping_tracking_table.hashes
    end

    def click_outbound_link
      outbound_link.click
    end

    def click_inbound_link
      inbound_link.click
    end

    def refresh_view_data_shuttle_order_section
      refresh_order_view_img.click
      unless order_view_title_a[:class].nil?
        wait_until{ order_view_title_a[:class].match(/loading/).nil? }
      end
    end
    
  end
end