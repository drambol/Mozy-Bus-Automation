
Then /^Account details table should be:$/ do |acc_details_table|
  acc_details_table.map_column!('value') do |value|
    value.gsub(/@name/,@partner.admin_info.full_name).gsub(/@email/,@partner.admin_info.email)
  end
  @bus_site.admin_console_page.account_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.account_details_section.acc_details_desc_columns.should == acc_details_table.hashes.map{ |row| row[:description] }
  @bus_site.admin_console_page.account_details_section.acc_details_value_columns.should == acc_details_table.hashes.map{ |row| row[:value] }
end

Then /^I set account Receive Mozy Account Statements option to (Yes|No)$/ do |status|
  step "I navigate to Account Details section from bus admin console page"
  @bus_site.admin_console_page.account_details_section.wait_until_bus_section_load
  @bus_site.admin_console_page.account_details_section.set_receive_statement_status(status)
end

Then /^Account statement preference should be changed$/ do
  @bus_site.admin_console_page.account_details_section.messages.should == "Successfully saved Account Statement preference."
end

Then /^I change the display name to (.+)/ do |display_name|
  @bus_site.admin_console_page.account_details_section.edit_display_name(display_name)
end

Then /^the display name should be (.+)$/ do |display_name|
  @bus_site.admin_console_page.account_details_section.get_display_name.should == display_name
end

Then /^I change receive mozy (pro newsletter|email notifications|account statements) to (Yes|No|different value)/ do |type, value|
  value = ( @current_value == 'Yes'? 'No':'Yes') if value == 'different value'
  if type == 'pro newsletter'
    @bus_site.admin_console_page.account_details_section.edit_newsletter(value)
  elsif type == 'email notifications'
    @bus_site.admin_console_page.account_details_section.edit_email_notification(value)
  else

  end
end

Then /^I change the username to (.+)$/ do  |username|
  if username == 'auto generated email'
    username = create_admin_email(Forgery::Name.first_name,Forgery::Name.last_name)
    @partner.admin_info.email = username
  end
  @bus_site.admin_console_page.account_details_section.edit_username(username)
end

And  /^I change root admin password in Account Details from old password (.+) to (.+)$/ do  |current_password, new_password|
  @bus_site.admin_console_page.account_details_section.reset_password(current_password, new_password)
end

Then /^Account Details error message should be:$/ do |messages|
  @bus_site.admin_console_page.account_details_section.messages.strip.should == messages.strip.to_s
end

Then /^(.+) changed success message should be displayed$/ do |changes|
  actual_msg = @bus_site.admin_console_page.account_details_section.messages
  case changes
    when 'username'
      actual_msg.should == "Email address updated successfully"
    when 'display name'
      actual_msg.should == "Name updated successfully"
    when 'password'
      actual_msg.should == "Password changed"
    when 'newsletter'
      actual_msg.should == "Newsletter setting changed"
    when 'email notification'
      actual_msg.should == "Email notification setting changed"
    when 'account statements'
      actual_msg.should == "Successfully saved Account Statement preference."
  end
end

And /^I get the value of (pro newsletter|email notification)$/ do |type|
  if type == 'pro newsletter'
    @current_value = @bus_site.admin_console_page.account_details_section.get_newsletter_setting
  elsif type == 'email notification'
    @current_value = @bus_site.admin_console_page.account_details_section.get_email_notification_setting
  else
  end
end


