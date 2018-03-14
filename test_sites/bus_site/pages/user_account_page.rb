module Bus
  # This class provides actions for user account page
  class UserAccountPage < SiteHelper::Page

    # Private elements
    #
    element(:computer_msg, xpath: "//div[@id='account-index-content']/h3[1]")
    element(:logout_link, css: "a[href='/login/logout']")

    attr_accessor :subdomain, :type

    # type could be ladp, horizon or mozy
    def initialize(subdomain = nil, type = 'mozy')
      @subdomain = subdomain
      @type = type
      self.class.set_url("https://#{@subdomain}.mozypro.com/login/user")
    end

    # Public: get current url
    #
    def current_url
      page.current_url
    end

    # Public: get a computer message
    #
    def computer_message
      computer_msg.text
    end

    def logout
      logout_link.click
    end
  end
end