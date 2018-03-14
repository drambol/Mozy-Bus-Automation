module Bus
  # This class provides actions for data retention page section
  class DataRetentionSectionPopup < SiteHelper::Section

    # Constants
    #
    ACC_SETTINGS_DIV_ID = "setting-edit_account_settings-content"

    # Private elements
    #
    element(:submit_adr_policy_btn, xpath: "//input[@value='Submit'][@type='button']")
    element(:cancel_adr_policy_btn, xpath: "//input[@value='Cancel'][@type='button']")
    element(:message_div, xpath: "//div[starts-with(@id,'setting-change_adr_policy-')]/ul/li")
    element(:password_input, xpath: "//input[@name='password']")
    element(:save_adr_policy_btn, xpath: "//input[@value='Save']")
    element(:adr_policy_name_select, xpath: "//select[@id='adr_policy_period_value']")





    #==============================
    # public : return the first policy name which is the default policy
    #
    # example: @bus_site.admin_console_page.data_retention_section.popup_get_default_adr_policy_name
    #==============================
    def popup_get_default_adr_policy_name
      page.find(:xpath, "//body[@id='popup-body']")
      page.find(:xpath, "//select[@id='adr_policy_period_value']""").click
      sleep(3)
      #page.all("option").first.text
      adr_policy_name_select.first_selected_option.text
    end


    #==============================
    # public    : on the adr popup dialog, create a policy but clicking Cancel button
    #
    # @policy   : policy name
    # @password : correct password when creating/updating policy
    #
    # example   : @bus_site.admin_console_page.data_retention_section.create_but_cancel_adr_policy_on_popup(1 Month (daily), QA_ENV['bus_password'])
    #==============================
    def create_but_cancel_adr_policy_on_popup(policy)
      adr_policy_name_select.select(policy)
      cancel_adr_policy_btn.click
    end

    #==============================
    # public    : create a policy on the popup dialog
    # @policy   : policy name
    # @password : correct/incorrect password when creating/updating policy
    #
    # example   : @bus_site.admin_console_page.data_retention_section.create_adr_policy_on_popup(1 Month (daily), QA_ENV['bus_password'])
    #==============================
    def create_adr_policy_on_popup(policy, password)
      adr_policy_name_select.select(policy)
      save_adr_policy_btn.click
      password_input.type_text(password)
      submit_adr_policy_btn.click
      if alert_present?
        alert_accept
        Log.debugger "Input incorrect password and get alert dialog."
      end
    end

  end
end