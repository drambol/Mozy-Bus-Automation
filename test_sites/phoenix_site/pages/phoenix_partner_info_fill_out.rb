module Phoenix
  # This class provides actions for phoenix registration page
  class PhoenixCreation < SiteHelper::Page

    set_url("https://#{QA_ENV['phoenix_host']}/registration")

    ##normal creation: mozy.com/registration create
    ##	elements section
    ##	contained here are elements related to phoenix flows for home/pro/free

    # admin info entry
    element(:new_admin_display_name_tb, id: "person_display_name")
    element(:new_admin_username_tb, id: "person_username")
    element(:new_admin_zip_tb, id: "person_zip")
    element(:new_admin_country_select, id: "person_country")
    element(:password_tb, id: "person_password")
    element(:reenter_password_tb, id: "person_password_confirmation")
    element(:mozypro_radio, id: "product_mozypro")
    element(:mozyhome_radio, id: "product_mozyhome")
    element(:security_select, id: "security_requirement")

    # key elements
    element(:captcha, id: "captcha")
    element(:next_btn, id: "next-button")
    element(:continue_btn, css: "input.img-button")
    element(:back_btn, id: "back_button")
    element(:submit_btn, id: "submit_button")
    element(:error_message, xpath: "//div[@class='inner-center-form-box']//form//p[@class='error']")

    # elements for verification
    element(:su_form_lbl, css: "div.center-form-box.vertical-align > h2")
    element(:name_lbl, css: "dt.input_label")
    element(:email_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[2]")
    element(:password_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[3]")
    element(:password_info_lbl, css: "span.field-info")
    element(:password_again_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[4]")
    element(:country_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[5]")
    element(:zip_post_code_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/div/div/form/dl/dt[6]")
    element(:plan_note_lbl, css: "div.inner-center-form-box > form > p")
    element(:plan_choice_lbl, css: "dl.clear > dt")
    element(:home_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[2]")
    element(:pro_supports_lbl, xpath: "//div[@id='main']/div/div/div/div/div[2]/p[3]")

    # pro-partner info/questionaire
    element(:new_partner_name_tb, id: "partner_name")
    element(:contact_address_tb, id: "contact_address")
    element(:contact_city_tb, id: "contact_city")
    element(:contact_country_select, id: "contact_country")
    element(:contact_state_tb, id: "contact_state")
    element(:contact_state_us_select, id: "contact_state_us")
    element(:contact_zip_tb, id: "contact_zip")
    element(:contact_phone_tb, id: "contact_phone")
    element(:contact_partner_industry_select, id: "partner_industry")
    element(:contact_number_employees_select, id: "partner_num_employees")
    element(:contact_response_select, id: "responses")
    element(:reseller_link, id: "Sign up here.")

    ##direct pro elements: mozy.com/registration/business
    element(:direct_admin_display_name, id: "admin_display_name")
    element(:direct_admin_username, id: "admin_username")
    element(:direct_password, id: "admin_password")
    element(:direct_reenter_password, id: "admin_password_confirmation")
    # rest are the same as pro

    # home/free related elements: registrstion/choose_location/free
    element(:country_select, id: "person_country")
    #
    # user email/pass elements
    element(:email_entry_tb, id: "user_username")
    element(:free_password_tb, id: "user_password")
    element(:free_password_again_tb, id: "user_password_confirmation")
    element(:continue_btn, css: "input.img-button")
    #
    # name/gender/questionaire elements
    element(:name_tb, id: "user_name")
    element(:gender_select, id: "user_gender")
    element(:birth_year_tb, id: "user_birth_year")
    element(:user_country_select, id: "user_country")
    element(:zip_tb, id: "user_zip")
    element(:job_category_select, id: "user_job_category")
    element(:job_primary_role_select, id: "user_primary_role")
    element(:job_industry_select, id: "user_industry")
    element(:job_population_select, id: "user_company_size")

    element(:page_banner, css: "div.center-form-box > h2")
    ##methods section
    ##	contained here are the methods for user/admin/partner entry for home/pro/free accts

    def verify_registration_page_elements
      su_form_lbl.visible?
      name_lbl.visible?
      new_admin_display_name_tb.visible?
      email_lbl.visible?
      new_admin_username_tb.visible?
      password_lbl.visible?
      password_tb.visible?
      password_info_lbl.visible?
      password_again_lbl.visible?
      reenter_password_tb.visible?
      country_lbl.visible?
      new_admin_country_select.visible?
      zip_post_code_lbl.visible?
      new_admin_zip_tb.visible?
      plan_choice_lbl.visible?
      mozypro_radio.visible?
      mozyhome_radio.visible?
      plan_note_lbl.visible?
      home_supports_lbl.visible?
      pro_supports_lbl.visible?
      continue_btn.visible?
    end

    # go to phoenix flow
    def go_to_phoenix
      find(:xpath, "//a[contains(@href,'/registration')]").click
    end
    # go to pro-direct flow
    def go_to_pro_direct_page
      url = 'https://secure.mozy.com/registration/business'
      visit(url)
    end

    def direct_fill_out(partner)
      direct_admin_display_name.type_text(partner.admin_info.full_name)
      direct_admin_username.type_text(partner.admin_info.email)
      security_select.select(partner.company_info.security)
      direct_password.type_text(CONFIGS['global']['test_pwd'])
      direct_reenter_password.type_text(CONFIGS['global']['test_pwd'])
      fill_in_pro_elements(partner)
    end

    # go to home-free flow
    def go_to_home_free
      url = 'https://secure.mozy.com/registration/free'
      visit(url)
    end

    def free_user_info_input(partner)
      free_user_idpass_fill_out(partner)
      #remaining_info_entry(partner)
    end

    # pro flow info entry
    def admin_info_fill_out(partner)
      verify_registration_page_elements
      # pro/home selection
      partner.partner_info.type.eql?("MozyHome") ? mozyhome_radio.click : mozypro_radio.click
      # admin info fill out
      acct_admin_info_fill_out(partner)
      continue_btn.click

      fill_in_pro_elements(partner) if partner.partner_info.type.eql?("MozyPro")
    end

    ## info entry section
    #	methods contained here are for direct entry of user/partner related info

      def acct_admin_info_fill_out(partner)
        new_admin_display_name_tb.type_text(partner.admin_info.full_name)
        new_admin_username_tb.type_text(partner.admin_info.email)
	      security_select.select(partner.company_info.security) if (partner.partner_info.type == "MozyPro")
        password = (partner.company_info.security == "HIPAA") ? CONFIGS['global']['test_hipaa_pwd']:CONFIGS['global']['test_pwd']
        password_tb.type_text(password)
        reenter_password_tb.type_text(password)       
        # changed to new localized_country method, comment as no change of the country and failed for localized country
        # localized_country(new_admin_country_select, partner)
        # this can be removed
        # new_admin_country_select.select(partner.company_info.country)
        new_admin_zip_tb.type_text(partner.company_info.zip)
      end

      def fill_in_pro_elements(partner)
        new_partner_name_tb.type_text(partner.company_info.name)
        contact_address_tb.type_text(partner.company_info.address)
        contact_city_tb.type_text(partner.company_info.city)
        if partner.company_info.country.eql?("United States")
          contact_state_us_select.select(partner.company_info.state_abbrev)
        else
          contact_state_tb.type_text(partner.company_info.state)
        end
        # changed to new localized_country method, comment as no change of the country and failed for localized country
        # localized_country(contact_country_select, partner)
        # this can be removed
        # contact_country_select.select(partner.company_info.country)
        contact_zip_tb.type_text(partner.company_info.zip)
        contact_phone_tb.type_text(partner.company_info.phone)
        #questionaire info
        #case statement keying on country, based on that selecting specific values from the survey drop down
        survey_industry(partner)
        survey_employees(partner)
        survey_contact_response(partner)

        continue_btn.click
      end

    #
    # free-acct: step 1 - enter mail ...

      def free_user_idpass_fill_out(partner)
        email_entry_tb.type_text(partner.admin_info.email)
        free_password_tb.type_text(CONFIGS['global']['test_pwd'])
        free_password_again_tb.type_text(CONFIGS['global']['test_pwd'])
        captcha.type_text(CONFIGS['phoenix']['captcha'])
        continue_btn.click
      end
      #
      # free-acct: step 2 - name - gender - questionaire ....
      def remaining_info_entry(partner)
        name_tb.type_text(partner.admin_info.full_name)
        gender_selection(partner)
        birth_year_tb.type_text("#{LANG[partner.company_info.country][partner.partner_info.type]['birth_year']}")
        # changed to new localized_country method
        localized_country(user_country_select, partner)
        zip_tb.type_text(partner.company_info.zip)
        survey_job_category(partner)
        survey_job_role(partner)
        survey_job_industry(partner)
        survey_num_coworkers(partner)
        continue_btn.click
      end

    def rp_error_messages
      error_message.text
    end

    def stuck_on_sign_up?
      #This is for cases when sign up errors
      msg1 = "Sign Up"
      msg2 = "MozyFree: Register for an Account"
      msg3 = "Sign up for MozyPro (Business Account)"
      msg4 = "Registrieren"
      msg5 = "Abonnement"
      page_banner.text == msg1 || page_banner.text == msg2 || page_banner.text == msg3 || page_banner.text == msg4 || page_banner.text == msg5
    end

    #localized selection/clicking of items
    def localized_select(loc_item, partner, loc_select)
      loc_item.select("#{LANG[partner.partner_info.parent][partner.partner_info.type][loc_select]}"); end
    def localized_click(partner, loc_click)
      navigate_to_link("#{LANG[partner.partner_info.parent][partner.partner_info.type][loc_click]}"); end

    #questionaire for pro accts
    def survey_industry(partner)
      localized_select(contact_partner_industry_select, partner, 'survey_industry') ;end
    def survey_employees(partner)
      localized_select(contact_number_employees_select, partner, 'survey_num_employees') ;end
    def survey_contact_response(partner)
      localized_select(contact_response_select, partner, 'survey_contact_res') ;end

    #questionaire for free-home accts
    def gender_selection(partner)
      localized_select(gender_select, partner, 'gender')	;end
    def survey_job_category(partner)
      localized_select(job_category_select, partner, 'job_cat')	;end
    def survey_job_role(partner)
      localized_select(job_primary_role_select, partner, 'job_role')	;end
    def survey_job_industry(partner)
      localized_select(job_industry_select, partner, 'job_industry')	;end
    def survey_num_coworkers(partner)
      localized_select(job_population_select, partner, 'survey_num_coworkers')	;end

    #
    # in the case for germany, we need to select 'deutschland', BEFORE we hit click - else it will fail
    # we need to retain the original country value in the partner variable for verification purposes
    # so not permanent change, this also gives flexibility down the road for non-standard domain specific
    # selections (ie protectorates), for this just small changes to script required
    def localized_country(loc_select, partner)
      # jason: we may just be able to render the old case statement like this,
      # ((partner.company_info.country == "Germany") ? loc_select.select("Deutschland") : loc_select.select(partner.company_info.country))
      case partner.company_info.country
        when 'Germany'
          loc_select.select("Deutschland")
        else
          loc_select.select(partner.company_info.country)
      end
    end
    # or change this method to provide the flexibility beyond just 'deutschland'
    # this will allow for more than user/admin counry or parnter country == billing country
    # for germany/deutschland case, localized_country(ex: new_admin_country_select, partner, 'Germany', 'Deutschland')
    # for FR-dom, US-biller ('etas-unis'==us name in FR) case, localized_country(ex: country_select, partner, 'France', 'Etas-Unis')
    #def localized_country(loc_select, partner, other_country, other_country_selection)
    # case partner.company_info.country
    #  when other_country.!nil?
        #   loc_select.select(other_country_selection)
        #  else
        #   loc_select.select(partner.company_info.country)
    #  end
    #end

  end
end
