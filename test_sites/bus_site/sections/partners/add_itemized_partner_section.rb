module Bus
  # This class provides actions for add new partner page section
  class AddItemizedPartnerSection < SiteHelper::Section

    # Private elements
    #
    # Company Info
    #
    element(:new_partner_name_tb, id: 'new_partner_name')
    element(:contact_country_select, id: 'partner_new_contact_country')
    element(:contact_state_tb, id: 'contact_state')
    element(:contact_city_tb, id: 'contact_city')
    element(:contact_address_tb, id: 'contact_address')
    element(:contact_zip_tb, id: 'contact_zip')
    element(:contact_phone_tb, id: 'contact_phone')
    element(:vat_number_tb, id: 'vat_info_vat_number')

    # Admin info
    #
    element(:new_admin_display_name_tb, id: 'new_admin_display_name')
    element(:new_admin_username_tb, id: 'new_admin_username')
    element(:root_role_select, name: 'root_role_id')

    # Partner Info
    element(:parent_partner_select, id: 'parent_partner_id')
    element(:company_type_options, id: 'company-type-options')
    element(:pricing_plan_select, id: 'pro_plan_id')

    # plan info
    element(:lic_disc_svr_tb, id: 'license_discounts_Server')
    element(:qta_disc_svr_tb, id: 'quota_discounts_Server')
    element(:lic_disc_dsk_tb, id: 'license_discounts_Desktop')
    element(:qta_disc_dsk_tb, id: 'quota_discounts_Desktop')
    element(:one_time_dsc_cb, id: 'new_partner_one_time_discount')
    element(:lic_svr_tb, id: 'licenses_Server')
    element(:qta_svr_tb, id: 'quota_Server')
    element(:lic_dsk_tb, id: 'licenses_Desktop')
    element(:qta_dsk_tb, id: 'quota_Desktop')

    # Billing Info
    element(:bill_to_fname_tb, id: 'billTo_firstName')
    element(:bill_to_lname_tb, id: 'billTo_lastName')
    element(:bill_to_company_tb, id: 'billTo_company')
    element(:cc_address_tb, id: 'billTo_street1')
    element(:cc_address2_tb, id: 'billTo_street2')
    element(:cc_city_tb, id: 'billTo_city')
    element(:cc_state_tb, id: 'billTo_state')
    element(:cc_country_select, id: 'billTo_country')
    element(:cc_zip_tb, id: 'billTo_postalCode')
    element(:cc_phone_tb, id: 'billTo_phoneNumber')

    # Order summary
    element(:order_summary_table, css: 'div#order-summary table')

    # Credit Card Info
    #
    element(:cc_name_select, id: 'card_cardType')
    element(:cc_no_tb, id: 'card_accountNumber')
    element(:cvv_tb, id: 'card_cvNumber')
    element(:cc_exp_mm_select, id: 'card_expirationMonth')
    element(:cc_exp_yyyy_select, id: 'card_expirationYear')

    element(:cc_payment_input, id: 'formOfPaymentCC')
    element(:net_term_payment_input, id: 'formOfPaymentNT')

    element(:message_div, css: 'div#partner-new-errors ul')
    element(:create_partner_btn, id: 'btn-partner_new_submit')
    element(:back_btn, id: 'back_button')

    # sub partner
    element(:create_sub_partner_btn, css: 'input#submit_button')

    # Public: Add a new partner account
    #
    # Example
    #   add_new_partner_section.add_new_account(partner_object)
    #
    # Returns nothing
    def add_new_itemized_partner(partner)
      # basic partner info
      fill_company_info(partner)
      # admin & company type info
      fill_partner_admin_info(partner)
      fill_partner_specific_info(partner)
      # itemized partner specific info
      fill_itemized_discounts(partner)
      fill_subscription_period(partner.subscription_period)
      fill_itemized_info(partner)
      # billing info
      fill_billing_info(partner)
      # submission
      create_partner_btn.click
      partner_created
    end

    # Public: Messages for change account details actions
    #
    # Example
    #   add_new_partner_section.messages
    #   # => "New partner created."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    def partner_created
      messages.should == "New partner created."
    end

    def fill_company_info(partner)
      new_partner_name_tb.type_text(partner.company_info.name)

      if partner.company_info.country.eql?('United States')
        contact_state_tb.type_text(partner.company_info.state_abbrev)
      else
        contact_country_select.select(partner.company_info.country)
        contact_state_tb.type_text(partner.company_info.state_abbrev)
        vat_number_tb.type_text(partner.company_info.vat_num)
      end
      contact_address_tb.type_text(partner.company_info.address)
      contact_city_tb.type_text(partner.company_info.city)
      contact_zip_tb.type_text(partner.company_info.zip)
      contact_phone_tb.type_text(partner.company_info.phone)
    end

    def fill_partner_admin_info(partner)
      new_admin_display_name_tb.type_text(partner.admin_info.full_name)
      new_admin_username_tb.type_text(partner.admin_info.email)
      #root_role_select.select(partner.admin_info.root_role)
    end

    def fill_partner_specific_info(partner)
      parent_partner_select.select(partner.partner_info.parent)
      if partner.partner_info.type.eql?("MozyPro")
        pricing_plan_select.select("Business")
        else
        pricing_plan_select.select(partner.partner_info.type)
      end
    end

    def fill_billing_info(partner)
      fill_cc_info(partner.credit_card)
      #cc_address2_tb.type_text()
      cc_address_tb.type_text(partner.company_info.address)
      cc_city_tb.type_text(partner.company_info.city)
      cc_state_tb.type_text(partner.company_info.state_abbrev)
      cc_country_select.select(partner.company_info.country)
      cc_zip_tb.type_text(partner.company_info.zip)
      cc_phone_tb.type_text(partner.company_info.phone)
    end

    def fill_cc_info(credit_card)
      bill_to_fname_tb.type_text(credit_card.first_name)
      bill_to_lname_tb.type_text(credit_card.last_name)
      cc_name_select.select(credit_card.type)
      cc_no_tb.type_text(credit_card.number)
      cvv_tb.type_text(credit_card.cvv)
      cc_exp_mm_select.select(credit_card.expire_month)
      cc_exp_yyyy_select.select(credit_card.expire_year)
    end

    def fill_subscription_period(period)
      find_with_highlight(:id, "new_partner_billing_period_#{period}").click
    end

    def fill_itemized_discounts(partner)
      lic_disc_svr_tb.type_text(partner.server_license_discount)
      qta_disc_svr_tb.type_text(partner.server_quota_discount)
      lic_disc_dsk_tb.type_text(partner.desktop_license_discount)
      qta_disc_dsk_tb.type_text(partner.desktop_quota_discount)
    end

    def fill_itemized_info(partner)
      lic_svr_tb.type_text(partner.server_licenses)
      qta_svr_tb.type_text(partner.server_quota)
      lic_dsk_tb.type_text(partner.desktop_licenses)
      qta_dsk_tb.type_text(partner.desktop_quota)
    end
  end
end

