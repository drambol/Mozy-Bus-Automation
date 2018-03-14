module Bus
  # This class provides actions for order data shuttle page section
  class OrderDataShuttleSection < SiteHelper::Section

    # Private elements
    #
    # Search section elements
    element(:search_partner_tb, id: 'pro_partner_search')
    element(:search_partner_btn, css: 'div#resource-choose_pro_partner_for_new_seed-content input[value=Submit]')
    element(:search_results_table, css: 'div#resource-choose_pro_partner_for_new_seed-content table.table-view')
    element(:clear_search_link, xpath: "//a[text()='Clear search']")

    # Public: Search results hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #
    # Returns hash array
    def search_results_hashes
      wait_until_bus_section_load
      search_results_table.rows_text.map{ |row| Hash[*search_results_table.headers_text.zip(row).flatten] }
    end

    def search_results_table_rows
      search_results_table.rows_text
    end


    def search_results_table_present?
      search_results_table.visible?
    end
    # Public: Search partner by search text
    #
    # Examples
    #
    #  search_partner("qa1+test@mozy.com")
    #
    # Returns Nothing
    def search_partner(search_key)
      search_partner_tb.type_text(search_key)
      search_partner_btn.click
      wait_until_bus_section_load
    end

    # Public: View partner detail by click partner's company name or email when order data shuttle
    #
    # Examples
    #
    #  view_order_detail("Lego Company")
    #
    # Returns Nothing
    def view_order_detail(name)
      xpath_string = "//table//td/a[text()='#{name}']"
      xpath_string = "//table//td[text()='#{name}']/../td/a" if locate(:xpath, xpath_string).nil?
      find(:xpath, xpath_string).click
      wait_until_bus_section_load
    end

    def clear_search
      clear_search_link.click
      wait_until_bus_section_load
    end
  end
end
