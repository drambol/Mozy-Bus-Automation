module Bus
  # This class provides actions for scheduled reports page section
  class ScheduledReportsSection < SiteHelper::Section

    # Private elements
    #
    element(:filter_select, id: "job_filter")
    element(:reports_table, xpath: "//div[@id='jobs-table']/div/table")

    # Public: Report filter options
    #
    # Example
    #    @bus_admin_console_page.report_builder_section.report_filters
    #    # =>  ["None", "Billing Summary","Billing Detail","Machine Watchlist","Machine Status" ... ...]
    #
    # Returns reports filter options
    def report_filters
      filter_select.options.map{ |option| option.text}
    end

    # Public: reports table entire text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_table_text
    #   # => "No results found"
    #
    # Returns reports table text
    def reports_table_text
      reports_table.text
    end

    # Public: First 6 columns of reports table body rows text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_table_rows
    #   # => [["Billing Summary Test Report", "Billing Summary", "@email", "Daily", "Run"]]
    #
    # Returns first 6 columns of reports table rows text
    def reports_table_rows
      reports_table.rows_text.map{|row| row[0..4]}
    end

    def reports_table_hashes
      reports_table.hashes
    end

    # Public: Find first matched reports row text by reports name
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.find_report("Billing Summary Test Report")
    #   # => ["Billing Summary Test Report", "Billing Summary", "qa1+ronald+parker+2237@mozy.com", "Daily", "Run", "Wed Aug 01, 2012", "Download", "-"]
    #
    # Returns first matched reports row text
    def find_report(report_name)
      reports_table.rows.select{ |row| row[0].text == report_name}.first
    end

    # Public: Download latest reports to download folder
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.download_report("Billing Summary Test Report")
    #
    # Returns nothing
    def download_report(report_name)
      wait_until do
        !find(:xpath, "//a[text()='#{report_name}']/../../*[7]").text.match(/.*Download.*/).nil?
      end
      report_row = find_report(report_name)
      report_row[6].find(:css, "a:contains('Download')").click
    end

    def click_report(report_name)
      report_row = find_report(report_name)
      report_row[0].find(:css, "a:contains('#{report_name}')").click
    end

    def run_report(report_name)
      report_row = find_report(report_name)
      report_row[4].find(:css, "a:contains('Run')").click
      wait_until{!find(:xpath, "//a[text()='#{report_name}']/../../*[7]").text.match(/.*Progress.*/).nil?}
      wait_until{!find(:xpath, "//a[text()='#{report_name}']/../../*[7]").text.match(/.*Download.*/).nil?}
    end

    def get_next_run(report_name)
      report_row = find_report(report_name)
      report_row[5].text
    end

    def get_history(report_name)
      report_row = find_report(report_name)
      report_row[7].text
    end

    # Public: Read downloaded scheduled reports
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.read_scheduled_report("Billing Summary Test Report")
    #
    # Returns reports csv file rows
    def read_scheduled_report(report_type)
      partial_file_name = "#{report_type.gsub(" ","-").downcase}.*"
      FileHelper.read_csv_file(partial_file_name)
    end
  end
end
