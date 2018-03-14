#encoding:utf-8
module Freyja

  class CybersourceManinPage < SiteHelper::Page
    # To change this template use File | Settings | File Templates.
    element(:next_btn, xpath: "//*[@id='wizard_buttons']//*[@id='button-next']")
    element(:close_btn, xpath: "//*[@id='restore_complete_buttons']//*[@id='button-close']")
    element(:upper_close_btn, xpath: "//div[@aria-labelledby='ui-dialog-title-restore_wizard_dialog']/span")
    #Billing info
    element(:first_name, xpath: "//*[@id='bill_to_forename']")
    element(:last_name, xpath: "//*[@id='bill_to_surname']")
    element(:address_line1, xpath: "//*[@id='bill_to_address_line1']")
    element(:address_line2, xpath: "//*[@id='bill_to_address_line2']")
    element(:address_city, xpath: "//*[@id='bill_to_address_city']")
    element(:address_country, xpath: "//*[@id='bill_to_address_country']")
    element(:address_state, xpath: "//*[@id='bill_to_address_state']")
    element(:address_postal_code, xpath: "//*[@id='bill_to_address_postal_code']")
    # Media restore credit card info
    element(:visa_card_type, xpath: "//*[@id='card_type_001']")
    element(:card_number, xpath: "//*[@id='card_number']")
    element(:card_cvn, xpath: "//*[@id='card_cvn']")
    element(:card_expiry_month, xpath: "//*[@id='card_expiry_month']")
    element(:card_expiry_year, xpath: "//*[@id='card_expiry_year']")

    element(:finish_button, xpath: "//*[@id='payment_details']/input[2]")

    def fill_media_billing_info(restore, language = "English")
      credit_card = restore.credit_card
      address_info = restore.address_info
      switch_to_newWindow
      first_name.type_text(credit_card.first_name)
      last_name.type_text(credit_card.last_name)
      address_line1.type_text(address_info.address)
      address_city.type_text(address_info.city)
      case language
        when "Deutsch"
          address_info.country = "Afghanistan"
        when "Español (castellano)"
          address_info.country = "Australia"
        when "Français"
          address_info.country = "France"
        when "Italiano"
          address_info.country = "Guyana"
        when "日本語"
          address_info.country = "Japan"
        when "Nederlands"
          address_info.country = "Netherlands"
        when "Português (Brasil)"
          address_info.country = "Brazil"
      end
      address_country.select(address_info.country)
      address_state.type_text(address_info.state)
      address_postal_code.type_text(address_info.zip)
      visa_card_type.click
      card_number.type_text("4111 1111 1111 1111")
      card_cvn.type_text(credit_card.cvv)
      card_expiry_month.select(credit_card.expire_month)
      card_expiry_year.select(credit_card.expire_year)
      finish_button.click
      if page.driver.browser.window_handles.size == 2
        switch_to_lastWindow
      else  # when click restore file from BUS, then there will be 3 windows
        main = page.driver.browser.window_handles[1]
        page.driver.browser.switch_to.window(main)
      end
      upper_close_btn.click
    end

  end

end
