module Bus
  # This class provides actions for helplink page
  class HelpLinkPage < SiteHelper::Page

    # Private elements
    #
    element(:message_link, xpath: "//a[text()='My Support']")
    element(:signin_btn, xpath: "//a[text()='Sign In']")

    # Public: Check if the log out link is present (implies user/partner is logged in)
    #
    # @param none
    #
    # Example
    #   @bus_site.support_page.logged_in
    #
    # @return [Boolean]
    def access
      switch_to_newWindow
      message_link.visible?
      signin_btn.visible?
    end

  end
end
