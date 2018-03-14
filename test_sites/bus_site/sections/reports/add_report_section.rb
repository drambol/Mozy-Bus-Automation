module Bus

  class AddReportSection < SiteHelper::Section

    # Private elements
    #
    # Shared Report Settings section
    element(:report_type_select, id: "job_name")
    element(:report_name_tb, id: "job_title")
    element(:frequency_select, id: "job_frequency")

    # Start date section
    element(:year_select, id: "job_start_at_1i")
    element(:month_select, id: "job_start_at_2i")
    element(:day_select, id: "job_start_at_3i")

    element(:backup_overdue_after_tb, id: "job_backup_overdue_after")
    element(:save_btn, xpath: "//div[contains(@id,'jobs')]//input[@value='Save']")
    element(:send_btn, xpath: "//input[value()='Send']")
    #Report Scope Section

    #Email Options Section
    element(:recipients_tb, id: "job_subscribers")
    element(:report_created_txt, xpath: "//div[contains(@id,'jobs')]/ul[@class='flash successes']")

    element(:report_search_result, xpath: "//td[text()='No results found.']")

    # tab
    element(:report_settings_tab, xpath: "//li[text()='Report Settings']")
    element(:email_options_tab, xpath: "//li[text()='Email Options']")

    # resources added
    element(:range_start_checkbox, id: "job_use_account_creation_date")
    element(:range_end_checkbox, id: "job_use_current_date")

    element(:quota_percentage_input, id: "job_machine_quota_percentage")

    # Public: Messages for reports builder actions
    #
    # Example
    #  @bus_admin_console_page.report_builder_section.messages
    #  # => "Created Billing Summary Report."
    #
    # Returns success or error message text
    def messages
      report_created_txt.text
    end

    def set_email_recipients(email, save = false)
      email_options_tab.click  unless email_options_tab[:class]== 'selected'
      wait_until{recipients_tb.visible?}
      recipients_tb.type_text(email)
      save_btn.click if save
    end

    # Public: Build a report
    #
    # Example
    #
    # Returns nothing
    def build_report(report)
      current_date = 'today'
      report_settings_tab.click unless report_settings_tab[:class]== 'selected'
      wait_until{report_name_tb.visible?}
      case report
        when Bus::DataObj::BillingSummaryReport
          report_name_tb.type_text(report.name)
          frequency_select.select(report.frequency)
          set_report_start_date(report.start_date)
          is_active_cb.uncheck unless report.is_active
        when Bus::DataObj::BillingDetailReport
          report_name_tb.type_text(report.name)
          frequency_select.select(report.frequency)
          set_report_start_date(report.start_date)
          is_active_cb.uncheck unless report.is_active
        else
          report_name_tb.type_text(report.name)
          if report.type == 'Resources Added'
            # get current date from range end checkbox for the Date Applied in the report
            str_arr = range_end_checkbox[:onclick].scan(/'\d+'/)
            current_date = 'yesterday' unless str_arr[2].match(/\d+/)[0] == Time.now.day.to_s
            range_start_checkbox.check
            range_end_checkbox.check
          else
            frequency_select.select(report.frequency)
            set_report_start_date(report.start_date) unless report.start_date.nil?
            is_active_cb.uncheck unless report.is_active
          end

          if report.type == "Machine Over Quota"
            quota_percentage_input.type_text(report.threshold) unless report.threshold.nil?
          end
      end
      set_email_recipients(report.recipients) unless report.recipients.nil?
      save_btn.click
      current_date
    end

    private
    def set_report_start_date(date)
      yyyy_mm_dd = date.split
      year_select.select(yyyy_mm_dd[0])
      month_select.select(yyyy_mm_dd[1])
      day_select.select(yyyy_mm_dd[2])
    end

  end

end
