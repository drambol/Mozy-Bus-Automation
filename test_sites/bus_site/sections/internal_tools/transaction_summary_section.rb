module Bus
  # This class provides actions for managing on Transaction Summary section
  class TransactionSummarySection < SiteHelper::Section

    element(:transaction_summary_table, xpath: "//div[@id='internal-revenue-content']/div[@class='show-details']/table")
    elements(:transaction_summary_table_sub_header, xpath: "//div[@id='internal-revenue-content']/div[@class='show-details']/table//tr[@style='border-bottom: 1px solid black;']/th")
    element(:download_as_csv_btn, xpath: "//a[text()='Download as CSV']")

    # Public: Transaction Summary table main header row text
    #
    # Example
    #   @bus_admin_console_page.transaction_summary_section.search_results_table_headers
    #
    # Returns search results table rows text array
    def transaction_summary_table_main_headers
      transaction_summary_table.headers_text
    end

    # Public: Transaction Summary table sub header row text
    #
    # Example
    #   @bus_admin_console_page.transaction_summary_section.transaction_summary_table_sub_header
    #
    # Returns search results table rows text array
    def transaction_summary_table_sub_headers
      _array = Array.new(0)
      transaction_summary_table_sub_header.each do |_th|
        Log.debug "QALog: ============sub column name is - " + _th.text() + "============"
        _array.push(_th.text())
      end
      return _array
    end


    # Public: click Download as CSV button on Transaction Summary section
    #
    # Example
    #   @bus_admin_console_page.transaction_summary_section.click_download_as_csv_button
    #
    # Returns None
    def click_download_as_csv_button
      wait_until_bus_section_load
      download_as_csv_btn.click
    end

  end
end