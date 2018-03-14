module Bus

  class EditReportSection < SiteHelper::Section
    element(:is_active_cb, id: "job_active")
    element(:save_btn, xpath: "//div[contains(@id,'jobs')]//input[@value='Save']")
    element(:report_updated_txt, xpath: "//div[contains(@id,'jobs')]/ul[@class='flash successes']")
    element(:reports_table, xpath: "//div[@id='jobs-table']/div/table")
    element(:delete_btn, xpath: "//a[text()='Delete']")
    element(:email_options_tab, xpath: "//li[text()='Email Options']")
    element(:recipients_tb, id: "job_subscribers")

    def inactive_report
      is_active_cb.uncheck
      save_btn.click
    end

    def messages
      report_updated_txt.text
    end

    def set_email_recipients(email, save = false)
      email_options_tab.click  unless email_options_tab[:class]== 'selected'
      wait_until{recipients_tb.visible?}
      recipients_tb.type_text(email)
      save_btn.click if save
    end

    # Public: Find and delete a scheduled reports
    #
    # Example
    #
    #  @bus_admin_console_page.report_builder_section.delete_report("Billing Summary Test Report")
    #
    # Returns nothing
    def delete_report(report_name)
      wait_until{delete_btn.visible?}
      delete_btn.click
      wait_until{alert_present?}
      alert_accept
    end

  end

end
