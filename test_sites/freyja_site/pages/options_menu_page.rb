module Freyja

  class OptionsMenuPage < SiteHelper::Page

    element(:event_history, xpath: "//li[@id='panel-action-event-history']")
    element(:preference, css: "#panel-action-preferences")
    element(:notification, css: "#notifications-count")
    element(:product_download, css: "div[title='Product Downloads'] > a")
    element(:manage_account_option, xpath: "//*[@id='panel-action-account-summary']")
    element(:log_out_action, xpath: "//li[@id='panel-action-sign-out']")
    element(:log_out_yes_btn, xpath: "//div[@id='logout_confirm_dialog']/div[3]/div/a[2]/span")
    section(:change_password_section, ChangePasswordSection, xpath: "//li[@id='panel-action-change-password']")


    # Public: launch change password wizard
    #
    # Example
    #   @freyja_site.options_menu_page.change_password_wizard
    #
    # Returns nothing
    def change_password_wizard(section_id, use_quick_link = false)
      # Looking for link in navigation menu
      find(:xpath, section_id)
      # calling all method does not require to wait
      sections = all(:xpath, section_id)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
      end
    end

    def open_event_history
      event_history.click
    end

    def open_preference
      preference.click
    end

    def open_notifications
      notification.click
      sleep 5
    end

    def notifications_detail_slide_in
      page.has_content?("Restore ID")
    end

    def open_product_downloads
      product_download.click
    end

    def manage_account
      manage_account_option.click
    end

    def logout
      log_out_action.click
      log_out_yes_btn.click
    end

  end
end