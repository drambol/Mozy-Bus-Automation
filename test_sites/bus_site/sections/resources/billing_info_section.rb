module Bus
  # This class provides actions for billing information section
  class BillingInfoSection < SiteHelper::Section

    # Private elements
    #
    element(:change_subscription_link, css: "a[href='/resource/change_billing_period']")
    element(:vat_info_table, css: 'div[id^=partner-billing-info-vat-] table')
    element(:enable_autogrow_link, xpath: "//a[text()='(more info)']")
    element(:commit_autogrow_btn, xpath: "//div[@id='overdraft']/form/input[@name='commit']")
    element(:disable_autogrow_link, xpath: "//a[text()='(disable)']")

    # vat table elements
    element(:change_vat_link, xpath: "//div[contains(@id,'partner-billing-info-vat')]//td/a[text()='(change)']")
    element(:delete_vat_link, xpath: "//div[contains(@id,'partner-billing-info-vat')]//td/a[text()='(delete)']")
    element(:vat_num_input, xpath: "//input[@id='vat_info_vat_number']")
    element(:vat_submit_input, xpath: "//input[@value='Submit']")

    # All tables in Billing Information section, including Next Renewal, Supplemental Plan, Autogrow
    elements(:tables, css: 'div#resource-billing-content table')
    elements(:tables_alias, css: "div[id^=resource-billing] table")

    #vat_message
    element(:vat_message_div, xpath: "//div[contains(@id,'partner-billing-info-vat-msg')]")

    # Public: Click change link
    #
    # Returns nothing
    def go_to_change_period_section
      change_subscription_link.click
    end

    # Public: Next renewal table rows text
    #
    # Example
    #  @bus_admin_console_page.billing_info_section.next_renewal_table_rows
    #  # => [["monthly (change)", "Jul 30, 2013", "$39.99 (Without taxes or discounts)", "Visa ending in 7014 (change)"]]
    #
    # Returns transposed next renewal table rows array
    def next_renewal_table_rows
      wait_until_bus_section_load
      tables[1].rows_text
    end

    # Public: Next renewal hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.next_renewal_hashes
    #
    # Returns hash array
    def next_renewal_hashes
      wait_until_bus_section_load
      tables[1].hashes
    end

    # Public: Supplemental plan table rows text
    # *This method requires refactor
    #
    # There's no identification for supplemental plan table, therefore, when a partner has VAT info, tables[1] will return wrong information.
    # Also each supplemental plan displays in its own table, this is difficult to locate all supplemental plans
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.supp_plan_table_rows
    #  # => [["100", "$0.42", "$42.00"]]
    #
    # Returns transposed supplemental table rows array of first supplemental plan
    def supp_plan_table_rows
      wait_until_bus_section_load
      tables[2].rows_text
    end

    # Public: Supplemental plan hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.supp_plan_hashes
    #
    # Returns hash array
    def supp_plan_hashes(index = 2)
      wait_until_bus_section_load
      tables[index].hashes
    end

    def quota_info_hashes
      wait_until{!locate(:css,"div[id^=resource-billing] table.info-table.shade-table").nil?}
      tables_alias.last.hashes
    end

    # Public: VAT info hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.vat_hashes
    #
    # Returns hash array
    def vat_hashes
      wait_until_bus_section_load
      [{ vat_info_table.raw[0][0].text => vat_info_table.raw[0][1].text }]
    end

    def vat_table_visible?
      wait_until_bus_section_load
      all(:xpath, "//div[contains(@id,'partner-billing-info-vat-')]/table").size > 0
    end

    def change_vat_number (vat_number)
      wait_until_bus_section_load
      change_vat_link.click
      wait_until{ vat_num_input.visible? }
      vat_num_input.type_text(vat_number)
      vat_submit_input.click
      wait_until_bus_section_load
    end

    def delete_vat_number
      delete_vat_link.click
      wait_until_bus_section_load
    end

    def vat_message
      vat_message_div.text
    end

    def current_vat_number
      vat_info_table.raw[0][1].text
    end

    # Public: Autogrow table rows
    #
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.autogrow_table_rows
    #  # => [["Autogrow"],
    #        [""Disabled (more info)""]]
    #
    # Returns the auto grow status text
    def autogrow_table_rows
      wait_until_bus_section_load
      tables.last.rows_text
    end

    # Public: Autogrow hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.autogrow_hashes
    #
    # Returns hash array
    def autogrow_hashes
      wait_until_bus_section_load
      tables.last.hashes
    end

    def enable_autogrow
      wait_until_bus_section_load
      enable_autogrow_link.click
      commit_autogrow_btn.click
      wait_until{ !commit_autogrow_btn.visible? }
    end

    def disable_autogrow
      disable_autogrow_link.click
      commit_autogrow_btn.click
      wait_until{ !commit_autogrow_btn.visible? }
    end

    # Public: Account Status hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #
    #  @bus_admin_console_page.billing_info_section.account_status_hashes
    #
    # Returns hash array
    def account_status_hashes
      wait_until {!locate(:css,"div[id^=resource-billing] table").nil?}
      tables_alias[0].hashes
    end
  end
end
