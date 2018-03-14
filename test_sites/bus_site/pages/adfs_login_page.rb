module Bus
  # This class provides actions for user account page
  class AdfsLoginPage < SiteHelper::Page

    # Private elements
    #
    element(:sign_mozy_radio, id: 'ctl00_ContentPlaceHolder1_OtherRpRadioButton')
    element(:site_selecter, id: 'ctl00_ContentPlaceHolder1_RelyingPartyDropDownList')
    element(:continue_btn, id: 'ctl00_ContentPlaceHolder1_SignInButton')

    element(:go_btn, id: 'ctl00_ContentPlaceHolder1_GoButton')
    element(:stslabel, id: 'ctl00_STSLabel')


    element(:username_tb, id: "ctl00_ContentPlaceHolder1_UsernameTextBox")
    element(:password_tb, id: "ctl00_ContentPlaceHolder1_PasswordTextBox")
    element(:sign_in_btn, id: "ctl00_ContentPlaceHolder1_SubmitButton")

    element(:ldap_admin_failed_msg, id: "ctl00_ContentPlaceHolder1_ErrorTextLabel")

    element(:ldap_admin_logout_text1, xpath: "//div[@id='dashboard-e-content']/h3")
    element(:ldap_admin_logout_text2, xpath: "//div[@id='dashboard-e-content']/p")
    # Public: get current url
    #
    def choose_mozy_radio
      sign_mozy_radio.click
    end

    def site_select(value='qa8saml')
      site_selecter.select value
    end

    def continue_login
      continue_btn.click
    end

    def go
      go_btn.click
    end

    def log_in(subdomain, site=nil)
      if stslabel.visible?
        Log.debug 'come into login page'
        if page.has_button? 'ctl00_ContentPlaceHolder1_SignInButton'
          choose_mozy_radio
          if site.nil?
            site_select(subdomain)
          else
            site_select(site)
          end
          continue_login
        elsif page.has_button? 'ctl00_ContentPlaceHolder1_GoButton'
          if site.nil?
            site_select(subdomain)
          else
            site_select(site)
          end
          go
        else
          raise 'Cannot log in'
        end
      end
    end

    def sign_in(username, password)
      if page.has_button? 'ctl00_ContentPlaceHolder1_SubmitButton'
        username_tb.type_text(username)
        password_tb.type_text(password)
        sign_in_btn.click
      end
    end

    def ldap_admin_login_failed
      ldap_admin_failed_msg.text
    end

    def get_ldap_logout_url
      URI.parse(current_url)
    end

    def get_ldap_logout_content
      ldap_admin_logout_text1.text + ldap_admin_logout_text2.text
    end

    def start_a_new_browser
      Capybara.session_name = ":session_#{Time.now.to_i}"
    end

  end
end
