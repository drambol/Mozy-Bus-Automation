When /^I select options menu$/ do
  @freyja_site = FreyjaSite.new if @freyja_site.nil?
  @freyja_site.main_page.select_options_panel
end

# launch change password wizard
And /^I click Change password in freyja$/ do
  section_id = "//li[@id='panel-action-change-password']"
  @freyja_site.options_menu_page.change_password_wizard(section_id)
end

And /^I logout freyja$/ do
  @freyja_site.options_menu_page.logout
end

#  change the old password to the new password
And /^I change password from (.+) to (.+) in freyja$/ do |old_password,new_password|
  @freyja_site.options_menu_page.change_password_section.change_password(old_password, new_password)
end

Then /^Password changed message should be (.+)$/ do |message|
  @freyja_site.options_menu_page.change_password_section.password_changed_messages.should == message
end

Then /^Password changed message should include (.+)$/ do |message|
  @freyja_site.options_menu_page.change_password_section.password_changed_messages.should include(message)
end

# verify password change successfully
And /^I change password successfully$/ do
  @freyja_site.options_menu_page.change_password_section.password_changed_confirm
end

