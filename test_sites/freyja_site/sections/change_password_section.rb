module Freyja
  # This class provides actions for add new admin section
  class ChangePasswordSection < SiteHelper::Section
    element(:change_pw_action, id: "panel-action-change-password")
    element(:old_password_tb, xpath: "//input[@id='old-pw']")
    element(:new_password_tb, xpath: "//input[@id='new-pw']")
    element(:password_confirm_tb, xpath: "//input[@id='pw-confirm']")
    element(:change_pw_btn, xpath: "//span[text()='Change password']")
    element(:pw_change_message, xpath: "//div[@id='noid']//span")
    element(:pw_change_confirm, xpath: "//div[@id='flash']//span[text()='OK']")
    #log out
    element(:log_out_action, xpath: "//li[@id='panel-action-sign-out']")
    element(:log_out_yes_btn, xpath: "//div[@id='logout_confirm_dialog']//span[text()='Yes']")
    #event history
    element(:event_history_action, xpath: "//li[@id='panel-action-event-history']")


    # Public: Change user login password
    #
    # old_password - Freyja old password
    # new_password - Freyja new password
    #
    # Example
    #   @freyja_site.freyja_page.change_password_section.change_password(old_password, new_password)
    #
    # Returns nothing
    def change_password(old_password, new_password)
       old_password_tb.type_text(old_password)
       new_password_tb.type_text(new_password)
       password_confirm_tb.type_text(new_password)
       change_pw_btn.click
    end

    # Public: Messages for change password
    #
    # Example
    #  @freyja_site.freyja_page.change_password_section.password_changed_messages
    #  # => "Your password has been changed."
    #
    # Returns message text
    def password_changed_messages
      pw_change_message.text
    end

    # Public: confirm password is changed
    #
    # Example
    #  @freyja_site.freyja_page.change_password_section.password_changed_confirm
    #
    # Returns  nothing
    def password_changed_confirm
      pw_change_confirm.click
    end

  end
end