# encoding: UTF-8

Then /^Autogrow details should be:$/ do |autogrow_table|
  actual = @bus_site.admin_console_page.billing_info_section.autogrow_hashes
  expected = autogrow_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Next renewal supplemental plan details should be:$/ do |plan_table|
  actual = @bus_site.admin_console_page.billing_info_section.supp_plan_hashes
  expected = plan_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Next renewal supplemental plan server plan details should be:$/ do |plan_table|
  actual = @bus_site.admin_console_page.billing_info_section.supp_plan_hashes(3)
  expected = plan_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^purchased plan details should be:$/ do |quota_table|
  actual = @bus_site.admin_console_page.billing_info_section.quota_info_hashes
  expected = quota_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^VAT info should be:$/ do |vat_table|
  actual = @bus_site.admin_console_page.billing_info_section.vat_hashes
  expected = vat_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^Next renewal info table should be:$/ do |next_renewal_table|
  actual = @bus_site.admin_console_page.billing_info_section.next_renewal_hashes
  expected = next_renewal_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Date'
          with_timezone(ARIA_ENV['timezone']) { v.replace(Chronic.parse(v).strftime('%b %d, %Y')) }
        when 'Payment Type'
          v.gsub!(/@XXXX/,@partner.credit_card.last_four_digits) unless @partner.nil?
        else
          v.replace ERB.new(v).result(binding)
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

When /^I (Enable|Disable) billing info autogrow$/ do |status|
  case status
    when "Enable"
      @bus_site.admin_console_page.billing_info_section.enable_autogrow
    when "Disable"
      @bus_site.admin_console_page.billing_info_section.disable_autogrow
    else
  end
end

Then /^VAT table (.+) display$/ do |type|
  case type
    when "should"
      @bus_site.admin_console_page.billing_info_section.vat_table_visible?.should be_true
    else
      @bus_site.admin_console_page.billing_info_section.vat_table_visible?.should be_false
  end
end

Then /^I change VAT number to:$/ do |vat_table|
  attributes = vat_table.hashes.first
  vat_number = attributes["VAT number"]
  vat_number = " " if vat_number == "@blank_value"
  @bus_site.admin_console_page.billing_info_section.change_vat_number(vat_number)
end

Then /^I delete VAT number$/ do
  @bus_site.admin_console_page.billing_info_section.delete_vat_number
end

Then /^VAT number was saved successfully:$/ do |vat_table|
  attributes = vat_table.hashes.first
  vat_number = attributes["VAT number"]
  @bus_site.admin_console_page.billing_info_section.vat_message.should == "VAT info has been successfully updated."
  @bus_site.admin_console_page.billing_info_section.refresh_bus_section
  @bus_site.admin_console_page.billing_info_section.wait_until_bus_section_load
  vat_number = "—" if vat_number == "@blank_value"
  @bus_site.admin_console_page.billing_info_section.current_vat_number.should == vat_number
end

Then /^VAT number was deleted successfully$/ do
  @bus_site.admin_console_page.billing_info_section.refresh_bus_section
  @bus_site.admin_console_page.billing_info_section.wait_until_bus_section_load
  @bus_site.admin_console_page.billing_info_section.current_vat_number.should == "—"
end


Then /^Fail to change VAT number:$/ do |message|
  @bus_site.admin_console_page.billing_info_section.vat_message.should eq(message)
end

Then /^Account Status table should be:$/ do |account_status_table|
  actual = @bus_site.admin_console_page.billing_info_section.account_status_hashes
  expected = account_status_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end
