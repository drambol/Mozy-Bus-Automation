module Bus
  # This class provides actions for reports builder page section
  class ReportBuilderSection < SiteHelper::Section

    element(:available_reports_table, xpath: "//div[@id='jobs-report_builder-content']/table")

    # Public: Click reports name and display add reports view
    #
    # Example
    #    navigate_to_add_report_section
    #
    # Returns nothing
    def navigate_to_add_report_section(report_type)
      find_link(report_type).click
    end

    # Public: Available reports and description table rows text (UI)
    #
    # Example
    #    report_builder_section.available_reports_table_rows
    #    # =>  [["Billing Summary", "Gives a summary of resources and usage by partner and user group."]]
    #
    # Returns available reports table rows text
    def available_reports_table_rows
      available_reports_table.rows_text
    end
  end
end
