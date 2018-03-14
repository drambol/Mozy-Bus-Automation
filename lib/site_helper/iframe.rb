module SiteHelper
  class Iframe
    include Capybara::DSL
    extend Components

    def initialize(iframe_element)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.frame(iframe_element.base.native)
      else
        raise('Error: Selenium WebDriver Required.')
      end
    end

    # Public: alert_accept
    #
    # Returns nothing
    def alert_accept
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.accept
      else
        raise("alert_accept method only works for Selenium Driver")
      end
    end

    # Public: alert_text
    #
    # Returns nothing
    def alert_text
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.text
      else
        raise("alert_text method only works for Selenium Driver")
      end
    end

    def alert_present?
      begin
        page.driver.browser.switch_to.alert
        $alert_text = alert_text
        #puts $alert_text
        #puts "Alert present!"
        return true
      rescue
        #puts "No alert present."
        return false
      end
    end

  end
end