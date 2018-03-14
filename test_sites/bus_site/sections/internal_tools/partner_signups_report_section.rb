module Bus
  # This class provides actions for managing on Partner Signups Report section
  class PartnerSignupsReportSection < SiteHelper::Section

    element(:partner_signups_report_table, xpath: "//div[@id='internal-partner_signups']//table[@class='table-view']")
    element(:export_to_excel_btn, xpath: "//a[text()='Export to Excel (CSV)']")
    element(:range_start_text, id: "start")
    element(:range_end_text, id: "end")
    element(:clear_search_underline_btn, xpath: "//a[text()='Clear search']")
    element(:pro_partner_search_input, xpath: "//input[@id='pro_partner_search']")
    element(:pro_partner_filter, xpath: "//select[@id='pro_partner_filter']")
    element(:update_btn, xpath: "//input[@class='button' and @value='Update']")
    element(:submit_btn, xpath: "//input[@class='button' and @value='Submit']")


    # Public: Partner Signups report table header row text
    #
    # Example
    #   @bus_admin_console_page.partner_signups_report_section.partner_signups_report_headers
    #
    # Return: search results table rows text array
    def partner_signups_report_headers
      partner_signups_report_table.headers_text
    end

    # Public: click Export to Excel(CSV) on Partner Signups Report section
    #
    # Example
    #   @bus_admin_console_page.partner_signups_report_section.click_export_to_excel
    #
    # Return: None
    def click_export_to_excel
      wait_until_bus_section_load
      export_to_excel_btn.click
    end

    # Public : search partner on Partner Signups report table
    # Return : None
    def search_partner_on_partner_signups_report(pro_partner_search)
      #input partner name
      pro_partner_search_input.type_text(pro_partner_search)
      #click Submit button
      submit_btn.click
    end

    # Public : click the partner on partner signups report
    # Return : None
    def view_partner_details(search_key)
      find_link(search_key).click
    end

    # Public : click clear search underline button
    # Return : None
    def click_clear_search
      clear_search_underline_btn.click
      wait_until_bus_section_load
    end

    #
    def search_partner_in_csv(partner)
      actual_csv = FileHelper.read_csv_file("pro_partners")
      #puts actual_csv
      #puts "========================="
      #puts actual_csv.size()
      ##puts actual_csv[31][2]
      puts "========================="
      puts partner
      return actual_csv.flatten.include?(partner)
    end








  end
end