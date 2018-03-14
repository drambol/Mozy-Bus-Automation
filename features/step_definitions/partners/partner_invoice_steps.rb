Then /^Invoice head should include (.+)$/ do |company_name|
  @bus_site.partner_invoice_page.partner_info.include?(company_name).should be_true
end

And /^Billing details of partner invoice should be:$/ do |billing_detail_table|
  actual = @bus_site.partner_invoice_page.billing_detail_table_rows
  actual.should_not == nil
  expected = billing_detail_table.raw
  expected.each { |k|
    k.each_index { |x|
      if k[x] == 'today'
        with_timezone(ARIA_ENV['timezone']) do
          k[x].replace(Chronic.parse(k[x]).strftime("%-m/%-d/%Y"))
        end
      elsif !(k[x].gsub!("yesterday", '').nil?)
        with_timezone(ARIA_ENV['timezone']) do
          k[x].replace((Chronic.parse(k[x]).to_datetime - 1).strftime("%-m/%-d/%Y"))
        end
      else
        k[x].replace ERB.new(k[x]).result(binding)
      end
    }
  }
  actual.flatten.select { |item| item != '' }.should == expected.flatten.select { |item| item != '' }
end

And /^Exchange rate of partner invoice should be:$/ do |exchange_rate_table|
  actual = @bus_site.partner_invoice_page.exchange_rates_table_rows
  actual.should_not == nil
  expected = exchange_rate_table.raw
  actual.should == expected
end

And /^there is no exchange rate table in invoice$/ do
  actual = @bus_site.partner_invoice_page.exchange_rates_table_rows
  actual.should == nil
end
