When /^I check that linux client service is available$/ do
  result = SSHLinuxE2E.check_client_status
  Log.debug result
  result.match(/mozybackup start\/running, process (\d)*/).nil?.should be_false
end

And /^I upload change linux client env script to remote machine$/ do
  local_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/scripts/changenetwork.sh"
  local_path.gsub!('/', '\\') if OS.windows?
  SSHLinuxE2E.upload(local_path,CONFIGS['linux']['path'])
  local_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/test_data/upload_file.txt"
  local_path.gsub!('/', '\\') if OS.windows?
  SSHLinuxE2E.upload(local_path,CONFIGS['linux']['path'])
end

And /^I activate linux machine using username (.+) and password (.+)$/ do |username, password|
  company_type = @partner.partner_info.type unless @partner.nil?
  company_type = @subpartner.company_type unless @subpartner.nil?
  Log.debug SSHLinuxE2E.setup_env(TEST_ENV, SSHLinuxE2E.get_codename(company_type))
  @activate_result = SSHLinuxE2E.activate_machine(username, password)
end

Then /^linux machine activation message should be (.+)$/ do |messages|
  Log.debug @activate_result
  @activate_result.include?(messages).should be_true
end

And /^I backup file using linux client for user (.+) password (.+)$/ do |username, password|
  Log.debug SSHLinuxE2E.setup_env(TEST_ENV, SSHLinuxE2E.get_codename(@partner.partner_info.type))
  activate_result = SSHLinuxE2E.activate_machine(username, password)
  Log.debug activate_result
  activate_result.include?('AUTHENTICATED').should be_true
  Log.debug SSHLinuxE2E.add_files
  Log.debug SSHLinuxE2E.start_backup
  @data_center = TEST_ENV.include?('qa6') ? 'qa6' : 'q12a'
end

And /^I backup files again with no new files added$/ do
  Log.debug SSHLinuxE2E.start_backup
end

And /^I cancel backup when I add a large file$/ do
  Log.debug SSHLinuxE2E.add_files('80M', 1, false)
  Log.debug SSHLinuxE2E.start_backup
  Log.debug SSHLinuxE2E.stop_backup
end

And /^I wait for backup finished$/ do
  10.times do
    result = SSHLinuxE2E.get_backup_status
    sleep 10
    break if result.include?('IDLE')
  end
end
