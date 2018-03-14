
module Bus
  # This class provides actions for bus login page
  class UserLoginBusPage < SiteHelper::Page


    # Private elements
    #
    element(:access_freyja_btn, xpath: "//a[@title='Restore Files']/i")
    element(:access_freyja_vms_btn, xpath: "//a[@title='Restore VMs']/i")
    # Change User Password
    element(:change_user_password_link, xpath: "//a[text()='Change Password']")
    element(:current_password_tb, id: 'password')
    element(:new_password_tb, id: 'new_password')
    element(:new_password_confirm_tb, id: 'new_password_confirmation')
    element(:new_password_change_btn, xpath: "//input[@value='Save Changes']")
    element(:change_passsword_message, xpath: "//div[starts-with(@id,'user-pass-change')]//li")
    element(:log_out_a, xpath: "//a[text()='LOG OUT']")

    #Restores
    element(:download_restore, xpath: "//table[@class='table-view']//a[text()='Download Restore']")


    def access_freyja_user_login_bus(vms)
      if vms.nil?
        wait_until{access_freyja_btn.visible?}
        access_freyja_btn.click
      else
        wait_until{access_freyja_vms_btn.visible?}
        access_freyja_vms_btn.click
      end
    end

    def change_password_user_login_bus(password,confirm_password)
      change_user_password_link.click
      current_password_tb.type_text(password)
      new_password_tb.type_text(confirm_password)
      new_password_confirm_tb.type_text(confirm_password)
      new_password_change_btn.click
      alert_accept if alert_present?
    end

    def change_password_message
      wait_until{ change_passsword_message.visible?}
      change_passsword_message.text
    end

    def user_log_out_bus
      log_out_a.click
    end

    def get_restore_vms_hints(type)
      all(:xpath, "//a[@title='#{type}']").size
    end

    def click_computer(computer)
      find(:xpath, "//table[@class='mini-table']//a[text()='#{computer}']").click
    end

    def click_machine_download_item(item)
      case item
        when "Download Restore"
          download_restore.click
      end
    end

  end
end

