module Aria
  # This class provides actions for notification method page section
  class NotificationMethodSection < SiteHelper::Section

    # Constants
    #
    NOTIFY_METHODS_TXT_LOC = "//table[@class='data-table']/tbody/tr/td[1]"

    # Private elements
    #
    element(:notify_msg_div, {:xpath => "//div[@class='error-box']"})
    element(:change_notify_method_btn, {:xpath => "//input[@value='Change Notify Method']"})
    elements(:notify_methods_td, {:xpath => "#{NOTIFY_METHODS_TXT_LOC}"})
    elements(:notify_methods_rb, {:xpath => "#{NOTIFY_METHODS_TXT_LOC}/input"})
    element(:notify_method_link, :css => "a[title='Notification Method']")

    # Public: List notification methods text
    #
    # Example
    #    @aria_admin_console_page.accounts_page.notification_method_section.notify_methods
    #    # => ["HTML Email", "Printable (no Email)"]
    #
    # Returns notification methods text array
    def notify_methods
      click_notify_method
      notify_methods_td.map{ |cell| cell.text }
    end

    def click_notify_method
      notify_method_link.click
    end

    # Public: List notification methods text
    #
    # Example
    #    @aria_admin_console_page.accounts_page.notification_method_section.change_notify_method
    #    # => ["HTML Email", "Printable (no Email)"]
    #
    # Returns notification methods text array
    def change_notify_method(method)
      index = notify_methods.index(method)
      notify_methods_rb[index].click
      change_notify_method_btn.click
    end

    # Public: Messages for change notification method actions
    #
    # Example
    #  @bus_admin_console_page.accounts_page.notification_method_section.messages
    #  # => "This account is currently notified via method "Printable (no Email)"."
    #
    # Returns success or error message text
    def messages
      notify_msg_div.text
    end
  end
end
