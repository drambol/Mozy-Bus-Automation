
# select event history panel
And /^I select event history$/ do
  @freyja_site.options_menu_page.open_event_history
end

# launch change password wizard
And /^I click Change password$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//li[@id='panel-action-change-password']"
  @freyja_site.options_menu_page.change_password_wizard(section_id)
end

# select preference panel
And /^I select Preferences$/ do
  @freyja_site.options_menu_page.open_preference
end

And /^I logout$/ do
  @freyja_site.options_menu_page.logout
end

And /^I click manage account$/ do

  @freyja_site.options_menu_page.manage_account
end

Then /^Phoenix account page login successfully$/ do
  @phoenix_site = PhoenixSite.new
  #@phoenix_site.account_page.load
  @phoenix_site.account_page.check_account
end

# select notification panel
And /^I click notification$/ do
  @freyja_site.options_menu_page.open_notifications
end

Then /^notification detail slide in$/ do
  @freyja_site.options_menu_page.notifications_detail_slide_in.should be_true
end

# select Product Downloads panel
And /^I select Product Downloads$/ do
  @freyja_site.options_menu_page.open_product_downloads
end


