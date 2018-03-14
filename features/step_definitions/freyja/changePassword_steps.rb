#  change the old password to the new password
And /^I change the old password to the new password$/ do
  @user.password = QA_ENV[@user.partnerType+'_password']
  @user.new_password = "new+" + @user.password
  @freyja_site.options_menu_page.change_password_section.change_password(@user.password, @user.new_password)
  @user.password = @user.new_password
  @user.new_password = QA_ENV[@user.partnerType+'_password']
end

#  change the old password to the new password again
And /^I change the old password to the new password again$/ do
  @freyja_site.options_menu_page.change_password_section.change_password(@user.password, @user.new_password)
end

Then /^Password changed message should be (.+)$/ do |message|
  @freyja_site.options_menu_page.change_password_section.password_changed_messages.should == message
end

# verify password change successfully
And /^I change password successfully$/ do
  @freyja_site.options_menu_page.change_password_section.password_changed_confirm
end