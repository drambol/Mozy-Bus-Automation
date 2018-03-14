
Then /^Billing history table should be:$/ do |billing_table|
  actual = @bus_site.admin_console_page.billing_history_section.billing_history_hashes
  expected = billing_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when "Date"
          with_timezone(ARIA_ENV['timezone']) { v.replace(Chronic.parse(v).strftime('%m/%d/%y')) }
        else
          # do nothing
      end
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

Then /^there no recent billing history content in billing history section$/ do
  @bus_site.admin_console_page.billing_history_section.recent_billing_visible?.should == false
end

Then /^I click the latest date link to view the invoice from billing history section$/ do
  @bus_site.admin_console_page.billing_history_section.click_invoice_link
end
