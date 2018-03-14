Then /^I update user passwords expires at yesterday$/ do
  DBHelper.update_users_passwords_expires_at_yesterday(@user_id)
end

Then /^I set a new password (.+)$/ do |pwd|
  @phoenix_site.user_account.set_new_password_when_expired(pwd)
end

Then /^password changed message should be (.+)$/ do |message|
  @phoenix_site.user_account.password_changed_message.should == message
end
