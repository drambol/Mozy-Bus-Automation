Then /^I expand the add email alert$/ do
  @bus_site.admin_console_page.new_email_alerts_section.expand_add_email_alert
end

Then /^I add a new email alert:$/ do|table|
  @email_alerts = Bus::DataObj::EmailAlerts.new
  email_alerts_hash = table.hashes.first
  email_alerts_hash.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  @email_alerts.subject_line = email_alerts_hash["subject line"] unless email_alerts_hash['subject line'].nil?
  @email_alerts.frequency = email_alerts_hash["frequency"] unless email_alerts_hash['frequency'].nil?
  @email_alerts.report_modules = email_alerts_hash["report modules"].split("\;")
  @email_alerts.scope = email_alerts_hash["scope"] unless email_alerts_hash['scope'].nil?
  @email_alerts.recipients = email_alerts_hash["recipients"].split("\;") unless email_alerts_hash['recipients'].nil?
  @email_alerts.percent_quota_used = email_alerts_hash["Percent quota used"] unless email_alerts_hash['Percent quota used'].nil?
  @bus_site.admin_console_page.new_email_alerts_section.add_new_email_alert(@email_alerts)


end

Then /^email alerts section message should be (.+)/ do |message|
  @bus_site.admin_console_page.new_email_alerts_section.alerts_messages.should include message
end

Then /^I view email alert details by (.+)/ do |email_alert|
  @bus_site.admin_console_page.list_email_alerts_section.view_alert_details(email_alert)
end

Then /^I Send Now the email alert$/ do
  @bus_site.admin_console_page.show_email_alerts_section.send_now
end

Then /^The email alert details should be:/ do |table|
  actual = @bus_site.admin_console_page.show_email_alerts_section.email_alerts_hashes
  expected = table.hashes.first
  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  expected["report modules"] = expected["report modules"].split(";") || expected["report modules"] unless expected['report modules'].nil?
  expected["recipients"] = expected["recipients"].split(";") || expected["recipients"] unless expected['recipients'].nil?
  expected.each_key do |key|
    actual[key].should == expected[key]
  end
end

Then /^I modify email alert to:$/ do|table|
  email_alerts_hash = table.hashes.first
  email_alerts_hash.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  @email_alerts.subject_line = email_alerts_hash["subject line"] unless email_alerts_hash['subject line'].nil?
  @email_alerts.frequency = email_alerts_hash["frequency"] unless email_alerts_hash['frequency'].nil?
  @email_alerts.report_modules = email_alerts_hash["report modules"].split(";") || email_alerts_hash["report modules"] unless email_alerts_hash['report modules'].nil?
  @email_alerts.scope = email_alerts_hash["scope"] unless email_alerts_hash['scope'].nil?
  @email_alerts.recipients = email_alerts_hash["recipients"].split(";") || email_alerts_hash["recipients"] unless email_alerts_hash['recipients'].nil?
  @bus_site.admin_console_page.show_email_alerts_section.modify_email_alert(@email_alerts)
end

Then /^I delete the email alert$/ do
  @bus_site.admin_console_page.show_email_alerts_section.delete_email_alert
end

Then /^The email alert (.+) should be deleted$/ do |email_alert|
  @bus_site.admin_console_page.list_email_alerts_section.find_email_alert(email_alert).should == 0
end

Then /^I get text for user group (.+) from email content$/ do |user_group|
  match = @mail_content.match(/#{user_group}\s*.*\s*.*\s*.*/)
  @verify_email_query = match[0] unless match.nil?
end

Then /^The email content should include (.+)$/ do |content|
  if @verify_email_query.nil?
    @mail_content.should include content
  else
    @verify_email_query.should include content
  end
end

Then /^I close the show email alert section$/ do
  @bus_site.admin_console_page.show_email_alerts_section.close_bus_section
end

Then /^show email alerts section message should be (.+)/ do |message|
  @bus_site.admin_console_page.show_email_alerts_section.updated_messages.should include message
end
