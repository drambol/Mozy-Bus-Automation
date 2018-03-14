module Bus
  # This class provides actions for admin details page section
  class AdminDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:act_as_link, css: "a:contains('Act as')")
    element(:activate_admin_link, xpath: "//a[text()='Activate Admin']")
    element(:new_pwd_txt, id: "new_password")
    element(:pwd_confirm_txt, id: "new_password_confirmation")
    element(:submit, xpath: "//div[starts-with(@id, 'admin-pass-change-')]/form//input[@value='Save Changes']")
    element(:delete_admin_btn, xpath: "//a[text() = 'Delete Admin']")
    element(:pw_tb, xpath: "//input[@name='password']")
    element(:submit_btn, xpath: "//div[@class='popup-window-footer']//input[@value='Submit']")
    element(:admin_name_tb, id: "target_admin_display_name")
    element(:admin_email_tb, id: "target_admin_username")
    element(:admin_parent_select, xpath: "//select[@name='target_admin[parent_admin_id]']")
    element(:admin_info_submit_btn, xpath: "//div[contains(@id, 'admininfobox')]//input[@value='Save Changes']")
    element(:admin_info_message_txt, xpath: "//div[contains(@id, 'admininfobox')]//ul/li")
    element(:admin_id_txt, xpath: "//div[contains(@id,'admin-show')]//dt[text()='ID:']/../dd")
    element(:admin_name_txt, xpath: "//div[contains(@id,'admin-show')]//a[@class='title']")

    # change external id
    element(:change_admin_external_id_link, xpath: "//dt[text()='External ID:']/following-sibling::dd[1]//a[text()='(change)']")
    element(:admin_external_id_tb, id: "external_id")
    element(:submit_admin_external_id_btn, xpath: "//dt[text()='External ID:']/following-sibling::dd[1]//input[@value='Submit']")

     # change admin password
    element(:change_admin_password_link, xpath: "//div[contains(@id,'admin-show')]//li//a[text()='Change Password']")
    element(:new_password_tb, xpath: "//input[@id='new_password']")
    element(:new_password_confirm_tb, xpath: "//input[@id='new_password_confirmation']")
    element(:new_password_change_btn, xpath: "//div[contains(@id,'admin-pass-change')]//input[@value='Save Changes']")
    element(:change_admin_pwd_msg_txt, xpath: "//div[contains(@id,'admin-show')]/ul/li")

    # add remove admin group
    element(:add_remove_ug_link, xpath: "//div[@id='user_groups']/div/a[text()='Add/remove user groups']")
    element(:save_add_remove_admin_ug_msg_text, xpath:"//div[contains(@id,'admin-set_admin_user_groups')]/ul/li")
    element(:save_admin_groups, xpath:"//div[@id='user_groups']/div/input[@value='Save']")
    elements(:admin_user_groups,xpath: "//div[contains(@id,'admin-show')]//div[@id='user_groups']/ul/li/label")

    # click here link
    element(:click_here_link, xpath: "//a[text()='click here']")
    # ldap admin delete admin will need to confirm
    element(:ldap_delete_confirm_btn, xpath: "//input[@value='Confirm']")

    #
    # new_pwd - a password for account
    # pwd_confirm - password confirmation
    #
    # Examples
    #
    #   activate_admin("test1234","test1234")
    #
    # Returns nothing

    def activate_admin(new_pwd,pwd_confirm)
      activate_admin_link.click
      new_pwd_txt.type_text(new_pwd)
      pwd_confirm_txt.type_text(pwd_confirm)
      submit.click
      sleep 10 # Wait for admin to be activated
    end

    def has_activate_admin_link?
      all(:xpath, "//a[text()='Activate Admin']").size > 0
    end

    # Public: As as admin
    #
    # Returns nothing
    def act_as_admin
      act_as_link.click
      alert_accept if alert_present?
    end

    def partner
      partners = all(:xpath, "//div[@class='show-details']/dl[dt='Partner:']/dd")
      { :name => partners.first.text } if partners.size > 0
    end

    def delete_admin(admin_password)
      delete_admin_btn.click
      alert_accept
      pw_tb.set(admin_password)
      submit_btn.click
      text = ""
      # for chrome, need to wait for alert present
      begin
        wait = Selenium::WebDriver::Wait.new ignore: Selenium::WebDriver::Error::NoAlertPresentError
        wait.until { page.driver.browser.switch_to.alert }
        text = alert_text
        alert_accept
      rescue
      end
      text
    end

    def ldap_admin_delete_admin
      delete_admin_btn.click
      alert_accept
      ldap_delete_confirm_btn.click
    end

    def delete_admin_cancel
      delete_admin_btn.click
      confirm_txt = alert_text
      alert_dismiss
      return confirm_txt
    end


    def set_admin_email(email)
      admin_email_tb.type_text email
    end

    def set_admin_name(name)
      admin_name_tb.type_text name
    end

    def set_admin_parent(parent)
      admin_parent_select.select parent
    end

    def save_admin_info_changes
      admin_info_submit_btn.click
    end

    def admin_info_box_message
      admin_info_message_txt.text
    end

    def admin_id
      admin_id_txt.text
    end

    def admin_name
      admin_name_tb.value
    end

    def change_admin_pwd(password)
      change_admin_password_link.click
      wait_until_bus_section_load
      new_password_tb.type_text(password)
      new_password_confirm_tb.type_text(password)
      new_password_change_btn.click
      wait_until_bus_section_load
    end

    def change_admin_pwd_msg
      change_admin_pwd_msg_txt.text
    end

    def get_admin_groups
      wait_until{add_remove_ug_link.visible?}
      ug_array = admin_user_groups.map{|label|label.text.strip}
      ug_array.select{|ug| ug.length > 0}
    end

    def add_remove_admin_groups(add_ug_array, remove_ug_array)
      add_remove_ug_link.click
      xpath_str = "//div[contains(@id,'admin-show')]//div[@id='user_groups']/ul/li/label"
      add_ug_array.each do |add_ug|
        find(:xpath, xpath_str + "[text() = ' #{add_ug}']/input").check
      end
      remove_ug_array.each do |remove_ug|
        find(:xpath, xpath_str + "[text() = ' #{remove_ug}']/input").uncheck
      end
      save_admin_groups.click
    end

    def add_remove_admin_groups_save_msg
      save_add_remove_admin_ug_msg_text.text
    end

    def click_here
      click_here_link.click
    end

    def change_admin_external_id(admin_external_id)
      change_admin_external_id_link.click
      admin_external_id_tb.type_text(admin_external_id)
      submit_admin_external_id_btn.click
      wait_until_bus_section_load
    end
  end
end
