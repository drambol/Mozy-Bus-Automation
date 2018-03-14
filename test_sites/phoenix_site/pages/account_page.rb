module Phoenix
  class Account < SiteHelper::Page
    #section(:my_profile_section, MyProfileSection, id: "maincontent")

    element(:account_pages_tb, xpath: "//div[@id='mainleftnav']/h1[1]")
    element(:my_profile_link, css: "a[href='/account/profile']")
    element(:name_tb, id: 'user_name')
    element(:address_tb, id: 'user_address')
    element(:city_tb, id: 'user_city')
    element(:state_tb, id: 'user_state')
    element(:zip_tb, id: 'user_zip')
    element(:country_select, xpath: "//table//tr[6]//select")
    element(:submit_btn, css: 'input.ui-button')
    element(:profile_saved_tb, css: 'p.flash')
    element(:change_credit_card_link, css: "a[href='/account/change_credit_card']")
    element(:message_text, css: "p.notice")
    element(:confirm_btn, id: "submit_button")
    element(:log_out, xpath: "//*[@id='header']/ul/li[3]/a")
    def account_pages
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
        account_pages_tb.text
      else
        raise 'You must use Selenium Driver'
      end
    end

    def navigate_to_my_file
      my_profile_link.click
    end

    def set_name value
      name_tb.type_text value
    end

    def set_address value
      address_tb.type_text value
    end

    def set_city value
      city_tb.type_text value
    end

    def set_state value
      state_tb.type_text value
    end

    def set_zip value
      zip_tb.type_text value
    end

    def set_country value
      country_select.select value
    end

    def submit
      submit_btn.click
    end

    def profile_saved
      profile_saved_tb.text
    end

    def close_page
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.execute_script "window.close();"
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      else
        raise 'You must use Selenium Driver'
      end
    end

    def navigate_to_change_credit_card
      change_credit_card_link.click
    end

    def profile_hashes
      output = {}
      output['Name:'] = name_tb.value
      output['Street Address:'] = address_tb.value
      output['City:'] = city_tb.value
      output['State/Province:'] = state_tb.value
      output['Zip/Postal Code:'] = zip_tb.value
      output['Country:'] = country_select.first_selected_option.text
      output
    end

    def credit_card_updated
      puts message_text.text
      message_text.text
    end

    def confirm
      confirm_btn.click
    end

    def check_account
      log_out.click
    end
  end
end
