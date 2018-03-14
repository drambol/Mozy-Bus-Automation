# encoding: utf-8
module CyberSource
  class CyberSourceBillingFillOut < SiteHelper::Page

    # billing
    element(:first_name_tb, id: "bill_to_forename")
    element(:last_name_tb, id: "bill_to_surname")
    element(:address_line1_tb, id: "bill_to_address_line1")
    element(:address_line2_tb, id: "bill_to_address_line2")
    element(:city_tb, id: "bill_to_address_city")
    element(:country_select, id: "bill_to_address_country")
    element(:state_tb, id: "bill_to_address_state")
    element(:state_select, id: "bill_to_address_state_us_ca")
    element(:phone_tb, id: "bill_to_phone")
    element(:zip_tb, id: "bill_to_address_postal_code")
    element(:email_tb, id: "bill_to_email")
    element(:goto_payment_btn, id: "")

    # card type
    element(:visa_radio, id: "card_type_001")
    element(:mastercard_radio, id: "card_type_002")
    element(:amex_radio, id: "card_type_003")
    element(:discover_radio, id: "card_type_004")
    element(:maestro_uk_radio, id: "card_type_024")
    # card info
    element(:cc_number_tb, id: "card_number")
    element(:cc_cvn, id: "card_cvn")
    element(:cc_exp_mm_select, id: "card_expiry_month")
    element(:cc_exp_yy_select, id: "card_expiry_year")

    element(:finish_btn, xpath: "//input[@class='right complete']")


    def fill_billing_info(partner)
      wait_until { !first(:xpath, "//input[@class='right complete']").nil? }
      first_name_tb.type_text(partner.credit_card.first_name)
      last_name_tb.type_text(partner.credit_card.last_name)
      address_line1_tb.type_text(partner.company_info.address)
      city_tb.type_text(partner.company_info.city)


      if partner.use_company_info
        partner.company_info.country == 'United States' ? country_select.select("United States of America") : country_select.select(partner.company_info.country)
        if partner.company_info.country.eql?("United States") || partner.company_info.country.eql?("Canada")
          find('select#bill_to_address_state_us_ca').find("option[value='#{partner.company_info.state_abbrev}']").select_option
        else
          state_tb.type_text(partner.company_info.state)
        end

        zip_tb.type_text(partner.company_info.zip)
        phone_tb.type_text(partner.company_info.phone)

      else
        partner.billing_info.country == 'United States' ? country_select.select("United States of America") : country_select.select(partner.billing_info.country)
        if ["United States","États-Unis","USA","Canada"].include?(partner.billing_info.country)
          find('select#bill_to_address_state_us_ca').find("option[value='#{partner.billing_info.state_abbrev}']").select_option
        else
          state_tb.type_text(partner.billing_info.state)
        end

        zip_tb.type_text(partner.billing_info.zip)
        phone_tb.type_text(partner.billing_info.phone)

      end

      email_tb.type_text(partner.admin_info.email) unless email_tb.value.eql?(partner.admin_info.email)

      case partner.credit_card.type
        when 'MasterCard'
          mastercard_radio.click
        when 'American Express'
          amex_radio.click
        when 'Discover'
          discover_radio.click
        when 'Maestro UK'
          maestro_uk_radio.click
        else
          visa_radio.click
      end

      cc_number_tb.type_text(partner.credit_card.number)
      cc_cvn.type_text(partner.credit_card.cvv)
      cc_exp_mm_select.select(partner.credit_card.expire_month)
      cc_exp_yy_select.select(partner.credit_card.expire_year)



      finish_btn.click

    end



  end
end
