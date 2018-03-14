Then /^Transaction Summary table main header should be:$/ do |transaction_sumary_table_main_headers|
  @bus_site.admin_console_page.transaction_summary_section.transaction_summary_table_main_headers.should == transaction_sumary_table_main_headers.raw.first
end

And /^Transaction Summary table sub header should be:$/ do |transaction_sumary_table_sub_headers|
  @bus_site.admin_console_page.transaction_summary_section.transaction_summary_table_sub_headers.should == transaction_sumary_table_sub_headers.raw.first
end

When /^I download revenue report$/ do
  @bus_site.admin_console_page.transaction_summary_section.click_download_as_csv_button
end