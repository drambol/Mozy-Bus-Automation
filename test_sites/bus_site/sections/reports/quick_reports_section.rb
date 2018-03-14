module Bus
  # This class provides actions for quick reports page section
  class QuickReportsSection < SiteHelper::Section

    # Private elements
    #
    element(:link_desc_table, xpath: "//div[@id='jobs-quick_reports-content']/div/table")

    # Public: Quick reports links and description text
    #
    # Example
    #   @bus_admin_console_page.quick_reports_section.link_desc_table_rows
    #
    # Returns links and description text
    def link_desc_table_rows
      link_desc_table.rows_text
    end

    # Public: Click quick reports name to download the reports
    #
    # Example
    #   @bus_admin_console_page.quick_reports_section.download_report("Credit Card Transactions (CSV)")
    #
    # Returns download file to destination folder
    def download_report(report_name)
      find_link(report_name).click
    end

    # Public: Read downloaded quick reports
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.read_quick_report("Users (CSV)")
    #
    # Returns reports csv file rows
    def read_quick_report(report_type)
      partial_file_name = report_type.gsub(" ","_").downcase
      FileHelper.read_csv_file(partial_file_name)
    end
  end
end
