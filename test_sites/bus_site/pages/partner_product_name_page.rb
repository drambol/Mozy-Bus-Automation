module Bus
  # This class provides actions for partner product name page
  class PartnerProductNamePage < SiteHelper::Page


    # Private elements
    #
    element(:product_name_input, id: "product_name")
    element(:submit_btn, css: "input.button")
    element(:set_up_message, css: "ul.flash")

    def set_product_name(product_name)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
        product_name_input.type_text product_name
        submit_btn.click
      else
        raise 'You must use selenium'
      end
    end

    def close_page
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.execute_script "window.close();"
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      else
        raise 'You must use selenium'
      end
    end

    def product_name_set_message
      set_up_message.text
    end

  end
end