module Bus
  # This class provides actions for the verify email page
  class VerifyEmailPage < SiteHelper::Page

    # Private elements
    #
    element(:computer_msg, xpath: "//div[@id='account-index-content']/h3[1]")
    element(:resend_email_link, xpath: "//a[text()='Resend Email']")
    element(:change_email_link, xpath: "//a[text()='Change Email Address']")
    element(:back_to_login_page_link, xpath: "//a[text()='Back to Login Page']")

    # Public: Return current url
    #
    # @param none
    #
    # Example
    #   @bus_site.verify_email_page.current_url
    #
    # @return [String]
    def current_url
      page.current_url
    end

    # Public: Return error message
    #
    # @param none
    #
    # Example
    #   @bus_site.verify_email_page.computer_message
    #
    # @return [String]
    def computer_message
      computer_msg.text
    end

    # Public: Checks for links and returns true if present, false if not
    #
    # @param none
    #
    # Example
    #   @bus_site.verify_email_page.links_present
    #
    # @return [Boolean]
    def links_present
      resend_email_link.visible?
      change_email_link.visible?
      back_to_login_page_link.visible?
    end
  end
end