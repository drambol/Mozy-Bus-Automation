module Bus
  # This class provides actions for bus login page
  class UserLoginPage < SiteHelper::Page


    # Private elements
    #
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:login_btn, css: "span.login_button")
    element(:logout_btn, xpath: "//a[text()='LOG OUT']")

    attr_accessor :subdomain, :type

    # type could be ladp, horizon or mozy
    def initialize(subdomain = nil, type = 'mozy', account_type = 'user')
      @subdomain = subdomain
      @type = type
      self.class.set_url("https://#{@subdomain}.mozypro.com/login/#{account_type}")
    end

    # Public: login bus admin console
    #
    # Example
    #   @bus_login_page.login(admin_object)
    #
    # Returns nothing
    def login(admin)
      case @type
        when 'mozy'
          username_tb.set(admin[:user_name])
          password_tb.set(admin[:password])
          login_btn.click
      end
    end

    # Public: Logout bus admin console
    #
    # Example
    #   @bus_login_page.logout
    #
    # Returns nothing
    def logout
      logout_btn.click
    end

  end
end