
module Bus
  # This class provides actions for bus login page
  class ItemizedLoginPage < SiteHelper::Page

    set_url("#{QA_ENV['bus01']}/login/admin?old_school=1")

    # Private elements
    #
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:login_btn, css: "span.login_button")
    element(:logout_btn, xpath: "//a[text()='LOG OUT']")
    element(:message_div, css: "div#inner-content div ul")

    # Public: Login bus admin console
    #
    # username - Bus admin console login user name
    # password - Bus admin console login password
    #
    # Example
    #   @bus_site.login_page.login('username', 'password')
    #
    # Returns nothing
    def login(username, password)
      username_tb.type_text(username)
      password_tb.type_text(password)
      login_btn.click
    end

    # Public: Partner login bus admin console
    #
    # username - Partner admin console login user name
    # password - Partner admin console login password
    #
    # Example
    #   @bus_site.login_page.login('username', 'password')
    #
    # Returns nothing
    def partner_login(partner)
      username_tb.type_text(partner.admin_info.email)
      password_tb.type_text(CONFIGS['global']['test_pwd'])
      login_btn.click
    end
    # Public: Logout bus admin console
    #
    # Example
    #   @bus_site.login_page.logout
    #
    # Returns nothing
    def logout
      logout_btn.click
    end

    # Public: Messages for login page
    #
    # Example
    #   @bus_site.login_page.messages
    #   # => "New partner created."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Check if the log out link is present (implies user/partner is logged in)
    #
    # @param none
    #
    # Example
    #   @bus_site.login_page.logged_in
    #
    # @return [Boolean]
    def logged_in
      logout_btn.visible?
    end
  end
end

