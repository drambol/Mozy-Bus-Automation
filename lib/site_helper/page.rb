module SiteHelper
  class Page
    include Capybara::DSL
    include Actions
    extend Components

    def initialize
      if page.driver.is_a?(Capybara::Selenium::Driver)
        #log('browser, switch to the first frame on the page')
        page.driver.browser.switch_to.default_content
        #log('maximize the browser')
        page.driver.browser.manage.window.maximize
      else
        raise('Error: Selenium WebDriver Required.')
      end
    end

    def self.url
      @url
    end

    def url
      self.class.url
    end

    def self.set_url(page_url)
      @url = page_url
    end

    def load
      Log.debug "load page and visit #{url.to_s}"
      log("load page and visit #{url.to_s}")
      raise "NoUrlForPage" if url.nil?
      page.reset_session!

      #workaround for the timeout error caused by concurrent visit to bus
      #sleep random time to avoid concurrent visit
      if QA_ENV['is_first_launch']
        sleep(rand(0..10))
        QA_ENV['is_first_launch'] = false
      end

      visit(url)
    end

    def refresh
      visit(page.driver.current_url)
    end

    def switch_to_newWindow
      #Get the popup window handle
      popup = page.driver.browser.window_handles.last
      #Then switch control between the windows
      page.driver.browser.switch_to.window(popup)
    end

    def switch_to_lastWindow
      #Get the main window handle
      main = page.driver.browser.window_handles.first
      #Then switch control between the windows
      page.driver.browser.switch_to.window(main)
    end
    # Public: Get all cookies from current page
    #
    # Example:
    #   @bus_site.login_page.cookies
    #   # => Array<Hash>
    #
    # Returns Array<Hash> - list of cookies
    def cookies
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.manage.all_cookies
      else
        raise("cookies method only works for Selenium Driver")
      end
    end
  end
end
