When /^I download the invoice content$/ do
  @invoice_download_path =  "#{default_download_path}/mozy_home_invoice"
  f = File.open(@invoice_download_path, 'w')
  f.write(@found_emails[0].body)
  f.close()
  File.exist?(@invoice_download_path).should be_true
end

And /^I open invoice page$/ do
  @phoenix_site = PhoenixSite.new
  @phoenix_site.invoice_page.invoice_page(@invoice_download_path).should_not be_nil
end

And /^Billing details of home invoice should be:$/ do |billing_detail_table|
  actual = @phoenix_site.invoice_page.billing_detail_table_rows
  expected = billing_detail_table.raw
  expected[2...-3].each_index { |i|
    expected[i+2][0].replace(Chronic.parse(expected[i+2][0]).strftime('%m/%d/%Y'))
    expected[i+2][1].replace(Chronic.parse(expected[i+2][1]).strftime('%m/%d/%Y'))
  }
  expected[-2][0].replace(Chronic.parse(expected[-2][0]).strftime('%Y-%m-%d'))
  (actual.flatten.select { |item| item != '' }).should == expected.flatten.select { |item| item != '' }
end

And /^Exchange rate table should be:$/ do |exchange_rate_table|
  actual = @phoenix_site.invoice_page.exchange_rate_table_rows
  expected =  exchange_rate_table.raw
  actual[1][2].to_i.should > 0
  expected[1][2] = actual[1][2] if expected[1][2] == "@exchange_rate"
  actual.flatten.should == expected.flatten
end

And /^there is no Exchange rate table$/ do
  @phoenix_site.invoice_page.exchange_rate_table_rows.should be_nil
end

And /^vat charged is (.+)$/ do |amount|
  @phoenix_site.invoice_page.vat_charged.should == amount
end

And /^invoice country is (.+)$/ do |country|
  (@phoenix_site.invoice_page.user_info.include?(@partner.company_info.country) || @phoenix_site.invoice_page.user_info.include?(country)).should be_true
end

