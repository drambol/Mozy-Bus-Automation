module Aria
  # This class provides actions for aira login page
  class LoginPage < SiteHelper::Page

    set_url(ARIA_ENV['host'])

    # Private elements
    #
    element(:username_tb, id: 'username')
    element(:password_tb, id: 'password')
    element(:login_btn, css: "input[value='Login']")
    element(:error_message_div, xpath: "//div[@class='error']")

    # Public: Login aria admin console
    #
    # username - Aria admin console login user name
    # password - Aria admin console login password
    #
    # Example
    #   login('username', 'password')
    #
    # Returns nothing
    def login(username, password)
      wait_until { login_btn.visible? }
      username_tb.type_text(username)
      password_tb.type_text(password)
      login_btn.click
    end

    def error_message
      error_message_div.text
    end

    def login_btn_visible?
       wait_until { login_btn.visible? }
      size = all(:xpath, "//input[@value='Login']").size
      (size>0)? true:false
    end

    def account_overview_visible? (aria_id)
      wait_until { find(:xpath, "//ul/li[text()='Account #{aria_id}']").visible? }
      all(:xpath, "//ul/li[text()='Account #{aria_id}']").size > 0
    end

  end
end

