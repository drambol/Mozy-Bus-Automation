Then /^Change payment information message should be (.+)$/ do |message|
  @bus_site.admin_console_page.change_payment_info_section.messages.should match(message)
end

When /^I update payment contact information to:$/ do |contact_info|
  attributes = contact_info.hashes.first
  new_contact = Bus::DataObj::CompanyInfo.new
  new_contact.name = attributes['name']
  new_contact.address = attributes['address']
  new_contact.city = attributes['city']
  new_contact.state = attributes['state']
  new_contact.state_abbrev = attributes['state abbrev']
  new_contact.country = attributes["country"]
  new_contact.zip = attributes['zip']
  new_contact.phone = attributes['phone']

  @bus_site.admin_console_page.change_payment_info_section.update_payment_contact_info(new_contact, attributes['email'])
end

When /^I update credit card information to:$/ do |credit_card_info|
  attributes = credit_card_info.hashes.first
  new_cc_info = Bus::DataObj::CreditCard.new
  new_cc_info.full_name = attributes["cc name"]
  new_cc_info.number = attributes["cc number"]
  new_cc_info.expire_month = attributes["expire month"]
  new_cc_info.expire_year = attributes["expire year"]
  new_cc_info.cvv = attributes["cvv"]

  @bus_site.admin_console_page.change_payment_info_section.update_credit_card_info(new_cc_info)
end

When /^I save payment information changes$/ do
  @bus_site.admin_console_page.change_payment_info_section.submit_contact_cc_changes
end

When /^I save payment information changes with (default password|Standard password)$/ do |password|
  @bus_site.admin_console_page.change_payment_info_section.submit_contact_cc_changes(password)
end

Then /^Payment information should be updated$/ do
  @bus_site.admin_console_page.change_payment_info_section.messages.should include("Your billing information has been successfully updated.")
end

Then /^Payment billing information should be:$/ do |billing_contact_table|
  actual = @bus_site.admin_console_page.change_payment_info_section.billing_information_hash
  expected = billing_contact_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'Billing Email'
        actual[header].should == expected[header].gsub(/@new_admin_email/,@partner.admin_info.email)
      else
        actual[header].should == expected[header]
    end
  end

end

Then /^I should able to modify credit card information$/ do
  @bus_site.admin_console_page.change_payment_info_section.enable_modify_credit_card
  @bus_site.admin_console_page.change_payment_info_section.modify_cc_section_enabled?.should be_true
end

Then /^I should able to view cvv help popup dialog$/ do
  @bus_site.admin_console_page.change_payment_info_section.show_cvv_help_popup
  @bus_site.admin_console_page.change_payment_info_section.cvv_help_displayed?.should be_true
end

Then /^I should able to close cvv help popup dialog$/ do
  @bus_site.admin_console_page.change_payment_info_section.close_cvv_help_popup
  @bus_site.admin_console_page.change_payment_info_section.cvv_help_displayed?.should be_false
end

Then /^Modify credit card error messages should be (.+)$/ do |err_msg|
  @bus_site.admin_console_page.change_payment_info_section.modify_cc_error_message.should == err_msg
end

Then /^I should not see modify credit card section$/ do
  @bus_site.admin_console_page.change_payment_info_section.has_modify_credit_card_cb?.should be_false
end

Then /^Credit card number should be (.+)$/ do |cc_num|
  @bus_site.admin_console_page.change_payment_info_section.credit_card_number.should == cc_num
end

Then /^I change VAT number from change payment information section:$/ do |vat_table|
  attributes = vat_table.hashes.first
  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  vat = attributes['VAT Number']
  if(vat == "@blank_space")
    @bus_site.admin_console_page.change_payment_info_section.set_vat("")
  else
    @bus_site.admin_console_page.change_payment_info_section.set_vat(vat) unless vat.nil?
  end
end

Then /^Contact country and billing information (.+) be updated:$/ do |type,message|
  case type
    when "should"
      @bus_site.admin_console_page.change_payment_info_section.messages.should eq(message)
    else
      @bus_site.admin_console_page.change_payment_info_section.modify_cc_error_message.should eq(message)
  end
end