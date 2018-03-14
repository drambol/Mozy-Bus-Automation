module Bus
  # This class provides actions for account details page section
  class AccountDetailsSection < SiteHelper::Section

    # Constants
    #
    ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

    # Private elements
    #
    elements(:acc_setting_links_dd, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd//a")
    element(:receives_statement_input, id: "receives_aria_stmt_via_email")
    element(:submit_receives_statement_btn, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']//dl/span[6]/dd/form/span[@class='edit']/input")
    element(:setting_saved_div, xpath: "//div[@id='setting-edit_account_settings-errors']/ul")
    element(:change_name_link, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div[2]/dl/span[1]//span[1]/a")
    element(:display_name_tb, id: "display_name")
    element(:submit_edit_name_btn, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']//span[1]//input[@value='Submit']")
    element(:change_username_link, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div[2]/dl/span[2]/dd/form/span/a")
    element(:username_tb, id: "username")
    element(:submit_edit_username_btn, xpath: "//div[@id='#{ACC_SETTINGS_DIV_ID}']//div[2]/dl/span[2]/dd/form/span[2]/input[2]")
    element(:change_password_link, xpath: "(//a[contains(text(),'change')])[3]")
    element(:current_password_text, id: 'current_password')
    element(:new_password_text, id: 'new_password')
    element(:confirm_password_text, id: 'confirm_password')
    element(:reset_password_btn, xpath: "(//input[@name='commit'])[3]")

    # newsletter, email notification, statements fields
    # change link
    element(:change_newsletter_link, xpath: "//dt[contains(text(),'Newsletter')]/../dd//a[text()='change']")
    element(:change_email_notification_link, xpath: "//dt[contains(text(),'Notifications')]/../dd//a[text()='change']")
    element(:change_statement_link, xpath: "//dt[contains(text(),'Statements')]/../dd//a[text()='change']")
    # select
    element(:change_newsletter_select, xpath: "//select[@id='receives_newsletter']")
    element(:change_email_notification_select, xpath: "//select[@id='receives_email_notifications']")
    element(:change_statement_select, xpath: "//select[@id='receives_aria_stmt_via_email']")
    # submit button
    element(:change_newsletter_submit_btn, xpath: "//select[@id='receives_newsletter']/../input")
    element(:change_email_submit_btn, xpath: "//select[@id='receives_email_notifications']/../input")
    element(:change_statement_submit_btn, xpath: "//select[@id='receives_aria_stmt_via_email']/../input")
    # view selected value
    element(:newsletter_value_text, xpath: "//dt[contains(text(),'Newsletter')]/../dd//span[1]")
    element(:email_notification_value_text, xpath: "//dt[contains(text(),'Notifications')]/../dd//span[1]")
    element(:statement_value_text, xpath: "//dt[contains(text(),'Statements')]/../dd//span[1]")

    # verify password pop up
    element(:verify_passowrd_input, xpath: "//div[@class='popup-window']//input[@name='password']")
    element(:submit_popup_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Submit']")

    # Public: account details table description column
    #
    # Example
    #   account_details_section.acc_details_desc_columns
    #   # => ["Name:","Username/Email:","Password:","Receive Mozy Pro Newsletter?","Receive Mozy Email Notifications?","Receive Mozy Account Statements?"]
    #
    # Returns account details description column text array
    def acc_details_desc_columns
      all(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dt").map{ |span| span.text}
    end

    # Public: account details table values column
    #
    # Example
    #   account_details_section.acc_details_value_columns
    #   # => ["Kevin Jones (change)","qa1+kevin+jones+1529@mozy.com (change)","(hidden) (change)","No (change)","No (change)","Yes (change)"]
    #
    # Return account details values column text array
    def acc_details_value_columns
      all(:xpath, "//div[@id='#{ACC_SETTINGS_DIV_ID}']/div/dl/span/dd/form/span[@class='view']").map{ |span| span.text}
    end

    # Pubic: Change account's receive statement status
    #
    # Example
    #  @bus_admin_console_page.account_details_section.set_receive_statement_status("No")
    #
    # Returns nothing
    def set_receive_statement_status(status)
      wait_until{ change_receive_statement_link.visible? }
      change_receive_statement_link.click
      receives_statement_input.select(status)
      submit_receives_statement_btn.click
    end

    # Public: Messages for change account details actions
    #
    # Example
    #  @bus_admin_console_page.account_details_section.messages
    #  # => "Successfully saved Account Statement preference."
    #
    # Returns success or error message text
    def messages
      setting_saved_div.text
    end

    # Public: Edit admin username
    #
    # @param [String] users
    #
    # Example
    #  @bus_admin_console_page.account_details_section.edit_username("qa1+93707.1.partner.a@mozy.com")
    #
    # @return [] nothing
    def edit_username(username)
      wait_until{ change_username_link.visible? }
      change_username_link.click
      username_tb.type_text username
      submit_edit_username_btn.click
      verify_password(QA_ENV['bus_password'])
      alert_accept
       wait_until{ !submit_edit_username_btn.visible? }
    end

    def verify_password(password)
      wait_until{ verify_passowrd_input.visible? } # wait for load delete password div
      verify_passowrd_input.type_text(password)
      submit_popup_btn.click
    end

    def edit_display_name(displayname)
      wait_until{ change_name_link.visible? }
      change_name_link.click
      display_name_tb.type_text displayname
      submit_edit_name_btn.click
    end

    def get_display_name
      wait_until{ change_name_link.visible? }
      display_name_tb.value
    end

    def edit_newsletter(value)
      wait_until{ change_newsletter_link.visible? }
      change_newsletter_link.click
      change_newsletter_select.select(value)
      change_newsletter_submit_btn.click
    end

    def edit_email_notification(value)
      wait_until{ change_email_notification_link.visible? }
      change_email_notification_link.click
      change_email_notification_select.select(value)
      change_email_submit_btn.click
    end

    def get_newsletter_setting
      wait_until{ newsletter_value_text.visible? }
      value = newsletter_value_text.text
      (value.include?('No'))? 'No':'Yes'
    end

    def get_email_notification_setting
      wait_until{ email_notification_value_text.visible? }
      value = email_notification_value_text.text
      (value.include?('No'))? 'No':'Yes'
    end

    def reset_password (current_password, new_password)
      wait_until{ change_password_link.visible? }
      change_password_link.click
      current_password_text.type_text(current_password)
      new_password_text.type_text(new_password)
      confirm_password_text.type_text(new_password)
      reset_password_btn.click
    end

    private

    def change_receive_newsletter_link
      acc_setting_links_dd[6]
    end

    def change_receive_email_link
      acc_setting_links_dd[8]
    end

    def change_receive_statement_link
      acc_setting_links_dd[10]
    end
  end
end