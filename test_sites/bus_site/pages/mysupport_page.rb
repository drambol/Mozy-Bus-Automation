module Bus
  # This class provides actions for support page
  class MySupportPage < SiteHelper::Page

    # Private elements
    #
    element(:message_link, xpath: "//a[contains(text(),'Welcome')]")
    element(:logout_btn, xpath: "//a[text()='Sign Out']")

    # Public: Check if the log out link is present (implies user/partner is logged in)
    #
    # @param none
    #
    # Example
    #   @bus_site.support_page.logged_in
    #
    # @return [Boolean]
    def logged_in
      message_link.visible?
      logout_btn.visible?
    end

  end
end
