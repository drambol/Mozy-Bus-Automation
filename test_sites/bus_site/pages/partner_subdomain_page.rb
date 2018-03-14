module Bus
  # This class provides actions for partner subdomain page
  class PartnerSubdomainPage < SiteHelper::Page


    # Private elements
    #
    element(:subdomain_input, id: "partner_subdomain_name")
    element(:submit_btn, css: "input.button")
    element(:subdomain_link, css: "ul[class='flash successes'] a")

    def change_subdomain(subdomain)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
        subdomain_input.type_text subdomain
        submit_btn.click
      else
        raise 'You must use selenium'
      end
    end

    def subdomain
      subdomain_link.text
    end

    def close_page
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.execute_script "window.close();"
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      else
        raise 'You must use selenium'
      end
    end

  end
end