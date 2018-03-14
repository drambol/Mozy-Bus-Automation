And /^I access freyja (from restore vms )?from bus admin/ do |vms|
  @bus_site.user_login_bus_page.access_freyja_user_login_bus(vms)
end

And /^I change password from (.+) to (.+) in user login bus page$/ do |pwd, new_pwd|
  @bus_site.user_login_bus_page.change_password_user_login_bus(pwd, new_pwd)
end

Then /^Change password should be successfully$/ do
  @bus_site.user_login_bus_page.change_password_message.should include ('has been changed')
end

Then /^the user log out bus$/ do
  @bus_site.user_login_bus_page.user_log_out_bus
end

Then /^I check restore icon with hints message (.+) under (user details|user login bus)$/ do |message,match|
  case match
    when 'user login bus'
      (@bus_site.user_login_bus_page.get_restore_vms_hints(message)>0).should == true
    when 'user details'
      (@bus_site.admin_console_page.user_details_section.get_restore_vms_hints(message).nil?).should == false
  end

end

And /^after acting as user then clicks computer (.+)$/ do |computer|
  @bus_site.user_login_bus_page.click_computer(computer)
end

Then /^after acting as user then click item (Download Restore|others) to download restore file$/ do |downloadItem|
  @bus_site.user_login_bus_page.click_machine_download_item(downloadItem)
end