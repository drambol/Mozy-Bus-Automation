
module Bus
  # This class provides actions for authentication page
  class AuthenticationFailedPage < SiteHelper::Page

    # Private elements
    #
    element(:authentication_failed_msg, xpath: "//div[@id='dashboard-e-content']/h3")

    attr_accessor :subdomain, :type

    # type could be ladp, horizon or mozy
    def initialize(subdomain = nil, type = 'mozy')
      @subdomain = subdomain
      @type = type
      self.class.set_url("https://#{@subdomain}.mozypro.com/login/user")
    end

    # Public: get authentication failed text
    #
    # Example
    #   @bus_site.authentication_failed_page.authentication_failed
    #
    # Returns nothing
    def authentication_failed
      authentication_failed_msg.text
    end
  end
end