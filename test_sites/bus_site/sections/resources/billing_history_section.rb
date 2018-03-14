module Bus
  # This class provides actions for billing history section
  class BillingHistorySection < SiteHelper::Section

    # Private elements
    #
    element(:billing_history_table, css: 'div#resource-all_charges-content table.table-view')

    # Public: Billing history hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.billing_history_section.billing_history_hashes
    #
    # Returns hash array
    def billing_history_hashes
      billing_history_table.rows_text.map{ |row| Hash[*billing_history_table.headers_text.zip(row).flatten] }
    end

    def recent_billing_visible?
      !locate(:xpath, "//div[@id='resource-all_charges-content']/h5").nil?
    end

    def click_invoice_link
      (billing_history_table.rows.first[0].find("a")).click
    end
  end
end