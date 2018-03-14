
module Bus
  # This class provides actions for bus login page
  class LoginPage < SiteHelper::Page

    set_url("#{QA_ENV['bus_host']}/login/admin?old_school=1")

    # Private elements
    #
    element(:username_tb, id: "username")
    element(:password_tb, id: "password")
    element(:login_btn, css: "span.login_button")
    element(:logout_btn, xpath: "//a[text()='LOG OUT']")
    element(:message_div, xpath: "//div[@id='inner-content']//ul[@class='flash errors']")
    element(:set_dialect_select, id: "set_dialect")
    element(:phoenix_login_error_msg, xpath:"//div[@id='main']//p[@class='error']")
    element(:forget_password_link, xpath:"//a[text()='Forgot your password?']")
    element(:captcha_input, id: "captcha")
    element(:reset_password_continue_btn, xpath: "//input[@value='Continue']")
    element(:reset_password_msg_div, xpath: "//div[@id='main']//p")
    element(:start_using_mozy_btn, id: "start_using_mozy")
    element(:login_error_msg, xpath: "//ul[@class='flash errors']/li")

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
      password = (partner.company_info.security == "HIPAA") ? CONFIGS['global']['test_hipaa_pwd']:CONFIGS['global']['test_pwd']
      password_tb.type_text(password)
      login_btn.click
    end
    # Public: Logout bus admin console
    #
    # Example
    #   @bus_site.login_page.logout
    #
    # Returns nothing
    def logout
      start_using_mozy_btn.click if has_start_using_mozy_btn?
      alert_accept if alert_present?
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

    # return  phoenix log in page error message
    def phoenix_login_error_messages
      phoenix_login_error_msg.text
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

    def choose_english
      #If the elemenet exists then select English
      using_wait_time 3 do
        if page.has_css?('#set_dialect')
          set_dialect_select.select('English')
          sleep 2
        end
      end
    end

    # Public: check whether language select field exists in log in page
    #
    # return boolean value
    def has_language_select?
      has_set_dialect_select?
    end

    # Public: check whether language select field contains specific option
    #
    # return boolean value
    def language_has_option?(dialect)
      set_dialect_select.options_text.include?(dialect)
    end

    def go_to_url(url)
      visit(url)
    end

    def click_forget_password
      forget_password_link.click
    end

    def reset_password(email)
      wait_until{username_tb.visible?}
      username_tb.type_text(email)
      # need to up this later for captcha input
      # captcha_input.type_text("")
      reset_password_continue_btn.click
    end

    def reset_password_enter(password)
      password_tb.type_text(password)
      if all(:id, 'password2').size>0
        find(:id, 'password2').type_text(password)
      else
        find(:id, 'password_confirmation').type_text(password)
      end
      reset_password_continue_btn.click
    end

    def reset_password_msg
      if all(:xpath, "//div[@id='main']//p").size>0
        find(:xpath, "//div[@id='main']//p").text
      else
        find(:xpath, "//ul[@class='flash successes']/li").text
      end
    end

    def get_error_msg
      login_error_msg.text
    end

    def clear_cache
      find(:xpath, '/html').native.send_keys :f9
    end
  end
end

