module Bus
  # This class provides actions for data retention page section
  class DataRetentionSection < SiteHelper::Section

    # Constants
    #
    ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

    # Private elements
    #
    element(:partner_adr_policy_link, xpath: "//div[@id='setting-adr_status-content']/div/h5/a")
    element(:user_group_adr_policy_table, xpath: "//div[@id='setting-adr_status-content']/div[3]//table")
    element(:sub_partner_adr_policy_table, xpath: "//div[@id='setting-adr_status-content']/div[5]//table[@class='table-view']")
    element(:adr_policy_name_select, xpath: "//select[@id='adr_policy_period_value']")
    element(:save_adr_policy_btn, xpath: "//input[@value='Save']")
    element(:password_input, xpath: "//input[@name='password']")
    element(:submit_adr_policy_btn, xpath: "//input[@value='Submit'][@type='button']")
    element(:message_div, xpath: "//div[starts-with(@id,'setting-change_adr_policy-')]/ul/li")
    element(:cancel_adr_policy_btn, xpath: "//div[contains(@class, 'popup-window-footer')]/input[@value='Cancel'][@type='button']")
    element(:data_retention_close_btn, xpath: "//a[contains(@onclick, 'delete_module')]")
    element(:popup_adr_policy_btn, xpath: "//a[contains(@onclick, 'popup_module')]")

    # element(:user_group_adr_policy_link, xpath: "//div[@id='setting-adr_status-content']/div[3]//table/tbody/tr[1]/td[2]/a")


    # Pubic: get adr policy of the partner, user group, sub partner
    #
    # Example
    #  @bus_admin_console_page.account_details_section.data_retention_section.get_adr_policy
    #
    # Returns adr_policy
    def get_adr_policy
      adr_policy = Bus::DataObj::ADRPolicy.new
      adr_policy.partner_adr = data_ad_connection_host.value
      adr_policy.default_user_group_adr = data_ad_connection_host.value
      adr_policy.sub_partner_adr = data_ad_connection_host.value
      adr_policy
    end

    def get_partner_adr_policy
      partner_adr_policy_link.text
    end

    def user_group_adr_policy_table_hashes
      user_group_adr_policy_table.rows_text
    end

    def sub_partner_adr_policy_table_hashes
      sub_partner_adr_policy_table.rows_text
    end

    # Public: reports table entire text
    #
    # Example
    #   @bus_admin_console_page.scheduled_reports_section.reports_table_text
    #   # => "No results found"
    #
    # Returns reports table text
    def sub_partner_adr_policy_table_text
      sub_partner_adr_policy_table.text
    end

    def click_partner_adr_policy
      partner_adr_policy_link.click
    end

    #==============================
    # public    : create adr policy with password
    #
    # @policy   : policy name
    # @password : password (corret or incorrect password are both acceptable)
    #
    # example   : @bus_site.admin_console_page.data_retention_section.create_adr_policy(1 Month (daily), QA_ENV['bus_password'])
    #==============================
    def create_adr_policy(policy, password)
      adr_policy_name_select.select(policy)
      save_adr_policy_btn.click
      password_input.type_text(password)
      submit_adr_policy_btn.click
      if alert_present?
        alert_accept
        Log.debugger "Input incorrect password and get alert dialog"
      end
    end

    def messages
      message_div.text
    end

    def click_user_group_adr_policy(user_group)
      find(:xpath, "//td[text()='#{user_group}']/../td[2]/a").click
    end

    def get_adr_policy_name
      adr_policy_name_select.first_selected_option.text
    end

    # Public:
    #
    # Example
    #  @bus_site.admin_console_page.data_retention_section.available_policy_name
    #  # => ["7 Days", "14 Days", "1 Month (daily)", "2 Months (weekly)", "2 Months (weekly)", "6 Months (monthly)", "1 Year (monthly)", "2 Years (quarterly)", "3 Years (quarterly)", "4 Years (quarterly)", "5 Years (quarterly)", "6 Years (quarterly)", "7 Years (quarterly)"]
    #
    #  Return an array of policy names
    def available_policy_names
      adr_policy_name_select.options_text
    end

    def available_policy_values
      adr_policy_name_select.options_values
    end

    #==============================
    # public    : create a policy but clicking Cancel button
    # @policy   : policy name
    # @password : correct password when creating/updating policy
    #
    # example   : @bus_site.admin_console_page.data_retention_section.create_but_cancel_adr_policy(1 Month (daily), QA_ENV['bus_password'])
    #==============================
    def create_but_cancel_adr_policy(policy, password)
      adr_policy_name_select.select(policy)
      save_adr_policy_btn.click
      password_input.type_text(password)
      cancel_adr_policy_btn.click
    end

    #==============================
    # public : close the opened data retention section
    #
    # example: @bus_site.admin_console_page.data_retention_section.close_data_retention_section
    #==============================
    def close_data_retention_section
      data_retention_close_btn.click
    end

    #==============================
    # public : click popup button to invoke popup dialog
    #
    # example: @bus_site.admin_console_page.data_retention_section.click_adr_policy_popup_button
    #==============================
    def click_adr_policy_popup_button
      popup_adr_policy_btn.click
      sleep(5)
      #page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
    end

    #==============================
    # public  : click adr policy link beside the given sub partner
    #
    # example : @bus_site.admin_console_page.data_retention_section.click_sub_partner_adr_policy("subpartner001")
    #==============================
    def click_sub_partner_adr_policy(sub_partner)
      find(:xpath, "//td[text()='#{sub_partner}']/../td[2]/a").click
    end



  end
end
