module Phoenix
  class MyProfileSection < SiteHelper::Page

  # editing profile section
  # items relating to editing a user's profile
  element(:message_text, css: "p.notice")

  # change password section
  element(:old_pw, id: "old_password")
  element(:new_pw, id: "new_password")
  element(:new_pw2, id: "new_password2")
  element(:change_pw_btn, css: "form[value^='Change Password']")
  # change cc info
  element(:change_cc_type_select, id: "card_cardType")
  element(:change_cc_number_tb, id: "card_accountNumber")
  element(:change_card_cvv_tb, id: "card_cvNumber")
  element(:change_exp_mm_select, id: "card_expirationMonth")
  element(:change_exp_yy_select, id: "card_expirationYear")
  # cc addressing info
  element(:change_billing_country_select, id: "billTo_country")
  element(:change_bill_fname_tb, id: "billTo_firstName")
  element(:change_bill_lname_tb, id: "billTo_lastName")
  element(:change_bill_co_tb, id: "billTo_company")
  element(:change_bill_addr1_tb, id: "billTo_street1")
  element(:change_bill_addr2_tb, id: "billTo_street2")
  element(:change_bill_city_tb, id: "billTo_city")
  element(:change_bill_state_tb, id: "billTo_state")
  element(:change_bill_state_select, id: "billTo_state_us")
  element(:change_bill_zip_tb, id: "billTo_postalCode")
  element(:change_submit_btn, id: "submit_button")

  #--change credit card information section--
  # calls the whole process
  def change_cc(partner)
    change_cc_link
    change_cc_entry(partner)
  end

  # change cc link click
  def change_cc_link
    #find(:xpath, "//a[contains(@href,'/account/change_credit_card')]").click
    find(:xpath, "//a[contains(text(),'change')][3]").click
  end

  # change cc info script
  def change_cc_entry(partner)
    # card info entry
    change_cc_type_select.select(partner.credit_card.type)
    change_cc_number_tb.type_text(partner.credit_card.number)
    change_card_cvv_tb.type_text(partner.credit_card.cvv)
    change_exp_mm_select.select(partner.credit_card.expire_month)
    change_exp_yy_select.select(partner.credit_card.expire_year)

    # biller info entry
    change_billing_country_select.select(partner.company_info.country)
    change_bill_fname_tb.type_text(partner.admin_info.first_name)
    change_bill_lname_tb.type_text(partner.admin_info.last_name)
    change_bill_addr1_tb.type_text(partner.company_info.address)
    change_bill_city_tb.type_text(partner.company_info.city)
    state_entry(partner)
    change_bill_zip_tb.type_text(partner.company_info.zip)

    # submission
    change_submit_btn.click
    message_text.eql?("Your card has been successfully filed. All future payments will be charged to your #{partner.credit_card.type} ending in #{partner.credit_card.last_four_digits}.")
  end

  def state_entry(partner)
    if partner.company_info.country == "United States"
      change_bill_state_select.type_text(partner.company_info.state_abbrev)
    else
      change_bill_state_tb.type_text(partner.company_info.state)
    end
  end



  #--change password section--
  # calls the whole process
  def change_password(new_pwd)
    change_pw_link
    change_pw_entry(new_pwd)
  end

  # change password link click
  def change_pw_link
    find(:xpath, "//a[contains(text(),'change')][2]").click
  end

  # change password script
  def change_pw_entry(new_pwd)
    old_pw.text_entry(CONFIGS['global']['test_pwd'])
    new_pw.text_entry(new_pwd)
    new_pw2.text_entry(new_pwd)
    change_pw_btn.click
    message_text.eql?("Your password was changed.")
  end


  end
end