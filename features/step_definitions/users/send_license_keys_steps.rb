When /^I click Send Keys button$/ do
  @bus_site.admin_console_page.user_details_section.click_send_user_keys
end

Then /^I can see Send Keys button is disable$/ do
  @bus_site.admin_console_page.user_details_section.send_keys_button_disabled?.should be_true
end

Then /^I can find (\d+) (Unactivated|Activated) (Desktop|Server) license key\(s\) from the mail$/ do |number, status, type|
  email_body = find_email_content(@email_search_query)
  count = count_licenses_from_email(email_body)
  #count = [desktop-unactivated,server-unactivated,desktop-activated,server-activated]
  if (status == 'Unactivated' && type == 'Desktop')
    count[0].should == number.to_i
  elsif (status == 'Unactivated' && type == 'Server')
    count[1].should == number.to_i
  elsif (status == 'Activated' && type == 'Desktop')
    count[2].should == number.to_i
  else #Actived/Server
    count[3].should == number.to_i
  end
end

Then /^I cannot find any (Unactivated|Activated) license key\(s\) from the mail$/ do |status|
  email_body = find_email_content(@email_search_query)
  count = count_licenses_from_email(email_body)
  #count = [desktop-unactivated,server-unactivated,desktop-activated,server-activated]
  if status == 'Unactivated'
    (count[0] + count[1]).should == 0
  else
    (count[2] + count[3]).should == 0
  end
end

Then /^Unactivated keys should show above activated in the mail$/ do
  email_body = find_email_content(@email_search_query)
  unactive = email_body.to_s.index('Unactivated')
  active = email_body.to_s.index('Activated')
  (unactive < active).should == true
end
