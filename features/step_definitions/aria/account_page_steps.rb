When /^I navigate to (.+) view from side menu$/ do |link_name|
  #@aria_site.admin_tools_page.switch_to_work_frame
  @aria_site.accounts_page.outer_if.main_if.work_if.side_menu_section.navigate_to_link(link_name)
end

# Taxpayer information steps
#
# Available columns: id, status
#
Then /^(.+) account taxpayer information should be:$/ do |user_name, info_table|
  step "I search aria account by #{user_name}"
  step "I navigate to Taxpayer Information view from side menu"
  attributes = info_table.hashes.first
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.taxpayer_section.vat_number.should == attributes["id"] unless attributes["id"].nil?
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.taxpayer_section.tax_exempt_status.should == attributes["status"] unless attributes["status"].nil?
end

# Available columns names:
# | id | exempt state | exempt federal|
#
When /^I set (.+) account taxpayer information to:$/ do |user_name, info_table|
  step "I search aria account by #{user_name}"
  step "I navigate to Taxpayer Information view from side menu"
  attributes = info_table.hashes.first
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.taxpayer_section.set_state_exempt_taxes(attributes["exempt state"].eql?("yes")) unless attributes["exempt state"].nil?
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.taxpayer_section.set_federal_exempt_taxes(attributes["exempt federal"].eql?("yes")) unless attributes["exempt federal"].nil?

end

# Account status steps
#
When /^I change (.+) account status to (.+)$/ do |user_name, status_code|
  step "I search aria account by #{user_name}"
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_overview_section.navigate_to_link("Status")
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_status_section.change_account_status(status_code)
end

Then /^Account status should be changed$/ do
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_status_section.messages.should == "Account status changed"
end

Then /^(.+) account status should be (.+)$/ do |user_name, status|
  step "I search aria account by #{user_name}"
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_overview_section.account_status.should == status
end

# Account groups steps
When /I change (.+) account CAG to (.+)$/ do |user_name, account_group|
  step "I search aria account by #{user_name}"
  step "I navigate to Account Groups view from side menu"
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_groups_section.change_cag(account_group)
end

Then /^CAG message should be (.+)$/ do |message|
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_groups_section.messages == message
end

Then /^Collections account groups should be changed$/ do
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_groups_section.messages == "Account group changes saved."
end

# Notification methods steps

Then /^(.+) account notification methods should be:$/ do |user_name, notify_table|
  step "I search aria account by #{user_name}"
  step "I navigate to Notification Method view from side menu"
  methods = @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.notify_methods
  notify_table.rows.map(&:first).each { |method| methods.should include method }
end

Then /^(.+) account current notification method is set to (.+)$/ do |user_name, method|
  step "I search aria account by #{user_name}"
  step "I navigate to Notification Method view from side menu"
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.click_notify_method
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.messages.should == "This account is currently notified via method \"#{method}\"."
end

When /^I set (.+) account notification method to (.+)$/ do |user_name, notification_method|
  step "I search aria account by #{user_name}"
  step "I navigate to Notification Method view from side menu"
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.change_notify_method(notification_method)
end

Then /^Notification message should be (.+)$/ do |message|
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.messages.should == message
end

When /^I set notification method to (.+)$/ do |notification_method|
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.notification_method_section.change_notify_method(notification_method)
end

# Billing contact steps
Then /^Aria account billing contact should include:$/ do |contact_table|
  actual = @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_overview_section.billing_contact

  expected = contact_table.hashes.first
  expected.keys.each do |header|
    actual.should include(expected[header])
  end
end

# Form of Payment steps
Then /^Aria account credit card information should be:$/ do |cc_table|
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_overview_section.navigate_to_link('Form of Payment')
  actual = @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.form_of_payment_section.credit_card_info_hash

  expected = cc_table.hashes.first
  expected.keys.each do |header|
    actual[header].should  == expected[header]
  end
end
