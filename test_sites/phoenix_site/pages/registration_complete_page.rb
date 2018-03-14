#!/bin/env ruby
# encoding: utf-8

module Phoenix
  # This class provides actions for phoenix registration page
  class NewRegistrationComplete < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}/registration")

    # Private elements
    #
    # Main elements within registration complete frame
    #
    element(:reg_comp_center_form, css: "div.center-form-container")
    element(:reg_comp_inner_center_form, css: "div.inner-center-form-box")
    element(:reg_comp_banner, css: "div.center-form-box > h2")
    element(:reg_comp_banner_txt, css: "div.inner-center-form-box > p")
    element(:reg_comp_txt_par_1, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[2]")
    element(:reg_comp_txt_par_2, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[3]")
    # home specific - may be related
    element(:reg_get_started_txt, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/p[2]")
    element(:reg_referral_txt, css: "div.referrer-info > p")
    element(:reg_dl_win_btn, xpath: "//input[@value='Download for Win']")
    element(:reg_dl_mac_btn, xpath: "//input[@value='Download for Mac']")
    element(:reg_dl_mac2_btn, xpath: "(//input[@value='Download for Mac'])[2]")
    element(:logout_btn, xpath: "//a[text()='LOG OUT']")
    element(:start_using_mozy, id: "btn_start_using")

    # Public : reg complete banner visible
    # required: nothing
    #
    # Example
    #   xx('yy')
    #
    # Returns nothing
    def navigate_to_link(link)
      find_link(link).click
    end

    # public method for clicking specific items based on locale
    # method requires the following:
    # @partner - partner specific info, namely country/partner type
    # localize item to click - label localized for language to be specifically selected.
    def localized_click(partner, loc_click)
      Log.debug "#{LANG[partner.partner_info.parent][partner.partner_info.type][loc_click]}"
      navigate_to_link("#{LANG[partner.partner_info.parent][partner.partner_info.type][loc_click]}")
    end

    def logout(partner)
      localized_click(partner, 'logout')
      page.execute_script "window.close();"
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
    end

    # clears pertinent cookies for phoenix
    def clear_phoenix_cookies
      page.driver.browser.manage.delete_cookie("_session_id");
      page.driver.browser.manage.delete_cookie("_phoenix_session_id");
      page.driver.browser.manage.delete_cookie("user_lang_pref");
    end

    def reg_comp_banner_present
      reg_comp_banner.present?
    end

    def reg_comp_text
      reg_comp_banner_txt.present?
    end

    # pro registration complete
    def go_to_account_verify(partner)
      localized_click(partner, 'go_to_acct')
    end

    # home section
    # code here relates
    # to mozyhome related items
    def reg_get_started
      reg_get_started_txt.present?
    end

    def reg_referral_banner
      reg_referral_txt.present?
    end

    # here we check for windows and both mac client download buttons
    def reg_home_dl_buttons
      reg_dl_win_btn.present?
      reg_dl_mac_btn.present?
      reg_dl_mac2_btn.present?
    end

    # check url for home free VS home pay
    # paid acct url ends with: registration/mozy_home_finish
    # free acct url end with: registration/free_finish
    def check_url
      if url.eql?(/https?:\/\/secure.mozy.[\S]\/registration\/mozy_home_finish\/[\S]+/)
        "Home"
        else
          "Free"
      end
    end

    # home registration complete
    def home_success(partner)
      # There is a workaround, only maximize window can make automation continue (Windows machine only)
      page.driver.browser.manage.window.maximize
      wait_until { !first(:css, "div.center-form-box > h2").nil? }
      wait_until { !first(:xpath, "//input[@type='button']").nil? }
      check_url
      reg_comp_banner_present
      reg_comp_text
      reg_get_started
      #reg_referral_banner
      localized_click(partner, 'acct_page_link')
      reg_comp_banner_present
      localized_click(partner, 'resend_verify_email_link')
      localized_click(partner, 'back_2_login_link')
      #logout(partner)
      clear_phoenix_cookies
    end

    # free home registration complete
    def free_home_success(partner)
      reg_comp_banner_present
      reg_comp_text
      reg_get_started
      #reg_referral_banner
      clear_phoenix_cookies
    end

    # free verification success
    def free_home_verified(partner)
      reg_comp_banner_present
      reg_comp_text
      clear_phoenix_cookies
    end

    def upgrade_success(partner)
      reg_comp_banner_present
      reg_comp_text
      reg_get_started
      #find(:xpath, "//a[text()='#{LANG[partner.company_info.country][partner.partner_info.type]['acct_page_link']}']").click
      find(:xpath,"//div[@class='center']//a").click
    end
  end
end