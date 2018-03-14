module Bus
  # This class provides actions for change payment information section
  class ChangePaymentInfoSection < SiteHelper::Section

    # Private elements
    #
    element(:cc_address_tb, id: "cc_address")
    element(:cc_city_tb, id: "cc_city")
    element(:cc_state_tb, id: "cc_state")
    element(:cc_state_us_select, id: "cc_state_us")
    element(:cc_state_ca_select, id: "cc_state_ca")
    element(:cc_country_select, id: "cc_country")
    element(:cc_zip_tb, id: "cc_zip")
    element(:cc_email_tb, id: "cc_email")
    element(:cc_phone_tb, id: "cc_phone")

    element(:message_div, css: "div#resource-change_credit_card-errors ul")
    element(:cc_error_div, css: "div#ariaErrors ul")
    element(:modify_credit_card_cb, id:"modify_cc")
    element(:cc_name_tb, id: "cc_name")
    element(:cc_no_tb, id: "cc_no")
    element(:cvv_tb, id: "cvv")
    element(:cc_exp_mm_select, id: "cc_exp_mm")
    element(:cc_exp_yyyy_select, id: "cc_exp_yyyy")
    element(:show_cvv_help_link, xpath: "//a[text()='(what is this?)']")
    element(:cvv_help_div, css: "div#cvv2help")
    element(:close_cvv_help_link, xpath: "//a[text()='(click to close)']")
    element(:submit, id: "submit_button")
    element(:payment_info_table, css: "form#change_cc_form table")

    element(:verify_passowrd_input, xpath: "//div[@class='popup-window']//input[@name='password']")
    element(:submit_popup_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Submit']")

    #these elements will pop up when change billing country with inconsistent value
    element(:contact_vat_number, xpath: "//input[@id='vat_num']")
    element(:contact_chg_country_select, xpath: "//select[@id='country_and_vat_contact_country']")

    # Public: Update payment contact information
    #
    #
    #
    def update_payment_contact_info(contact_info, email)
      cc_address_tb.type_text(contact_info.address) unless contact_info.address.nil?
      # Since country and state are close related, you have to change them together
      unless contact_info.country.nil?
        cc_country_select.select(contact_info.country)
        alert_accept if alert_present?
        wait_until_bus_section_load
        case contact_info.country
          when 'United States'
            cc_state_us_select.select(contact_info.state_abbrev)
          when 'Canada'
            cc_state_ca_select.select(contact_info.state_abbrev)
          else
            cc_state_tb.type_text(contact_info.state)
        end
      end
      cc_city_tb.type_text(contact_info.city) unless contact_info.city.nil?
      cc_zip_tb.type_text(contact_info.zip) unless contact_info.zip.nil?
      cc_phone_tb.type_text(contact_info.phone) unless contact_info.phone.nil?
      cc_email_tb.type_text(email) unless email.nil?
    end

    # Public: Update account's credit card information, but not update billing address.
    #
    # Example
    #   change_payment_info_section.update_credit_card_info(credit_card_object)
    #
    # Returns nothing
    def update_credit_card_info(credit_card)
      wait_until_bus_section_load
      wait_until {modify_credit_card_cb.visible?}
      modify_credit_card_cb.check
      cc_name_tb.type_text(credit_card.full_name) unless credit_card.full_name.nil?
      cc_no_tb.type_text(credit_card.number) unless credit_card.number.nil?
      cvv_tb.type_text(credit_card.cvv) unless credit_card.cvv.nil?
      cc_exp_mm_select.select(credit_card.expire_month) unless credit_card.expire_month.nil?
      cc_exp_yyyy_select.select(credit_card.expire_year) unless credit_card.expire_year.nil?
    end

    def submit_contact_cc_changes(password = QA_ENV['bus_password'])
      submit.click
      verify_password(password)
    end

    def verify_password(password)
      wait_until{ verify_passowrd_input.visible? } # wait for load delete password div
      verify_passowrd_input.type_text(password)
      submit_popup_btn.click
    end

    # Public: Messages for change payment information actions
    #
    # Example
    #   change_payment_info_section.messages
    #   # => "Your account is backup-suspended. You will not be able to access your account until your credit card is billed."
    #
    # Returns success or error message text
    def messages
      wait_until_bus_section_load
      wait_until {message_div.visible?}
      message_div.text
    end

    def modify_cc_error_message
      wait_until_bus_section_load
      wait_until {cc_error_div.visible?}
      cc_error_div.text
    end

    # Public: Billing information
    #
    # Example:
    #   change_payment_info_section.billing_information_hash
    #
    # Returns billing information hashes
    def billing_information_hash
      output = {}

      @state = ""
      case
        when cc_state_us_select.visible?
          @state = cc_state_us_select.first_selected_option.text
        when  cc_state_ca_select.visible?
          @state = cc_state_ca_select.first_selected_option.text
        else
          @state = cc_state_select.value
      end
      output["Billing Street Address:"] = cc_address_tb.value
      output["Billing City:"] = cc_city_tb.value
      output["Billing State/Province:"] = @state
      output["Billing Country:"] = cc_country_select.first_selected_option.text
      output["Billing ZIP/Postal Code:"] = cc_zip_tb.value
      output["Billing Email"] = cc_email_tb.value
      output["Billing Phone:"] = cc_phone_tb.value
      output
    end

    # Public: Click 'what is this?' to show cvv help popup dialog
    #
    # Example:
    #   change_payment_info_section.show_cvv_help_popup
    #
    # Returns nothing
    def show_cvv_help_popup
      show_cvv_help_link.click
    end

    # Public: Click 'click to close' to close cvv help popup dialog
    #
    # Example:
    #   change_payment_info_section.close_cvv_help_popup
    #
    # Returns nothing
    def close_cvv_help_popup
      close_cvv_help_link.click
    end

    # Public: Is cvv help popup dialog displayed?
    #
    # Example:
    #   change_payment_info_section.cvv_help_displayed?
    #
    # Returns true or false
    def cvv_help_displayed?
      cvv_help_div.visible?
    end

    def enable_modify_credit_card
      modify_credit_card_cb.check
    end

    def disable_modify_credit_card
      modify_credit_card_cb.uncheck
    end

    def modify_cc_section_enabled?
      cc_name_tb.enabled? && cc_no_tb.enabled? && cvv_tb.enabled? && cc_exp_mm_select.enabled? && cc_exp_yyyy_select.enabled?
    end

    def credit_card_number
      cc_no_tb.value
    end

    # Public: set country in change payment information section
    #
    # Example
    #   @bus_site.admin_console_page.change_payment_info_section.set_country
    #
    # Returns nothing
    def set_country country
      wait_until {contact_chg_country_select.visible?}
      contact_chg_country_select.select country
    end

    # Public: set vat number in change payment information section
    #
    # Example
    #   @bus_site.admin_console_page.change_payment_info_section.set_vat
    #
    # Returns nothing
    def set_vat vat
      wait_until {contact_vat_number.visible?}
      contact_vat_number.type_text vat
    end
  end
end