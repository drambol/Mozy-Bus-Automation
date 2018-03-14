
# open Freyja login page
When /^I navigate to freyja (.+) login page$/ do |partnerType|
  @freyja_site = FreyjaSite.new
  @user = Freyja::DataObj::User.new
  @user.partnerType = partnerType
  @user.language = "English"
  @user.username = QA_ENV[@user.partnerType+'_username']
  @user.password = QA_ENV[@user.partnerType+'_password']
  @freyja_site.login_page(@user).load

end


And /^I login as a existing user$/ do
  @freyja_site.login_page(@user).UserLogin(@user)
end

And /^I login as a existing sub-partner user$/ do
  @user.username = QA_ENV['sub_'+@user.partnerType+'_username']
  @user.password = QA_ENV['sub_'+@user.partnerType+'_password']
  partnerType = @user.partnerType
  @user.partnerType = 'sub_' + partnerType
  @freyja_site.login_page(@user).load
  @user.partnerType = partnerType
  @freyja_site.login_page(@user).UserLogin(@user)
end

Then /^freyja page is displayed$/ do
  @freyja_site.login_page(@user).login_verify.should be_true
end

# login Freyja with username and passowrd
Given /^I have login freyja as (home|pro|ent|oem) user$/ do |partnerType|
  @freyja_site = FreyjaSite.new
  @user = Freyja::DataObj::User.new
  @user.partnerType = partnerType
  @user.language = "English"
  @user.username = QA_ENV[@user.partnerType+'_username']
  @user.password = QA_ENV[@user.partnerType+'_password']
  @user.sync_machineID = QA_ENV[@user.partnerType+'_sync_machineID']
  @user.sync_file = QA_ENV[@user.partnerType+'_sync_file']
  @user.sync_folder = QA_ENV[@user.partnerType+'_sync_folder']
  @user.backup_machineID = QA_ENV[@user.partnerType+'_backup_machineID']
  @user.backup_file = QA_ENV[@user.partnerType+'_backup_file']
  @user.backup_folder = QA_ENV[@user.partnerType+'_backup_folder']
  @user.sync_file_versions = QA_ENV[@user.partnerType+'_sync_file_versions']
  @user.backup_file_versions = QA_ENV[@user.partnerType+'_backup_file_versions']

  @freyja_site.login_page(@user).load
  @freyja_site.login_page(@user).UserLogin(@user)
  @freyja_site.login_page(@user).login_verify.should be_true

end

# for private key or ckey users, login Freyja with username and passowrd
Given /^I have login freyja as (home|pro|ent|oem) and (private_key|ckey) user$/ do |partnerType, keyType|
  @freyja_site = FreyjaSite.new
  @user = Freyja::DataObj::User.new
  @user.partnerType = partnerType
  @user.language = "English"
  @user.keyType = keyType
  @user.username = QA_ENV[@user.partnerType+'_username_'+@user.keyType]
  @user.password = QA_ENV[@user.partnerType+'_password_'+@user.keyType]
  @user.sync_machineID = QA_ENV[@user.partnerType+'_sync_machineID_'+@user.keyType]
  @user.sync_file = QA_ENV[@user.partnerType+'_sync_file_'+@user.keyType]
  @user.backup_machineID = QA_ENV[@user.partnerType+'_backup_machineID_'+@user.keyType]
  @user.backup_file = QA_ENV[@user.partnerType+'_backup_file_'+@user.keyType]

  @freyja_site.login_page(@user).load
  @freyja_site.login_page(@user).UserLogin(@user)
  @freyja_site.login_page(@user).login_verify.should be_true
end

And /^I re-login$/ do
  @freyja_site.main_page.select_options_panel
  @freyja_site.options_menu_page.logout
  @freyja_site.login_page(@user).load
  @freyja_site.login_page(@user).UserLogin(@user)
  @freyja_site.login_page(@user).login_verify.should be_true
end

Given /^I have login freyja as (home|pro|ent|oem) user using language (.+)$/ do |partnerType, language|
  @freyja_site = FreyjaSite.new
  @user = Freyja::DataObj::User.new
  @user.partnerType = partnerType
  @user.language = language
  @user.username = QA_ENV[@user.partnerType+'_username']
  @user.password = QA_ENV[@user.partnerType+'_password']
  @user.sync_machineID = QA_ENV[@user.partnerType+'_sync_machineID']
  @user.sync_file = QA_ENV[@user.partnerType+'_sync_file']
  @user.sync_folder = QA_ENV[@user.partnerType+'_sync_folder']
  @user.backup_machineID = QA_ENV[@user.partnerType+'_backup_machineID']
  @user.backup_file = QA_ENV[@user.partnerType+'_backup_file']
  @user.backup_folder = QA_ENV[@user.partnerType+'_backup_folder']
  @user.sync_file_versions = QA_ENV[@user.partnerType+'_sync_file_versions']
  @user.backup_file_versions = QA_ENV[@user.partnerType+'_backup_file_versions']

  @freyja_site.login_page(@user).load
  @freyja_site.login_page(@user).UserLogin_language(@user, @user.language)
  @freyja_site.login_page(@user).verify_localization(@user.language).should be_true
end

Then /^I have login freyja from BUS$/ do
  @freyja_site = FreyjaSite.new
  @user = Freyja::DataObj::User.new
  @user.backup_file = @filename unless @filename.nil?
  @user.backup_machineID = @new_clients.first.machine_id unless @new_clients.nil?
end