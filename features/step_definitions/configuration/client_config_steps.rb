# for scheduling and preferences enter sample
# | name                | warning days | all settings  | ckey                               | private key             | web_restores |automatic max load|automatic min idle|automatic interval|
# | TC488-client-config | 15:cascade   | check         |http://gradyplayer.com/myckey.ckey  | only private key (/ yes)| all uncheked|10                |10                |7:lock            |
Then /^I (create a new|edit) client config:$/ do |action, table|
  #bus requires a throttle amount greater than zero when default throttle is left checked
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])

  @client_config = Bus::DataObj::ClientConfig.new
  attributes = table.hashes.first
  @client_config.name = attributes['name']
  @client_config.type = attributes['type']
  @client_config.user_group = attributes['user group']

  # preferences
  @config_preferences = Bus::DataObj::ConfigPreferences.new
  @config_preferences.ckey = attributes['ckey'] unless attributes['ckey'].nil?
  @config_preferences.default_key = attributes['default key'] unless attributes['default key'].nil?
  @config_preferences.private_key = attributes['private key'] unless attributes['private key'].nil?
  @config_preferences.enforce_encryption_type = attributes['enforce encryption type'] unless attributes['enforce encryption type'].nil?
  @config_preferences.warning_days = attributes['warning days'] unless attributes['warning days'].nil?
  @config_preferences.net_iftype = attributes['net iftype'] unless attributes['net iftype'].nil?
  @config_preferences.all_settings = attributes['all settings'] unless attributes['all settings'].nil?
  @config_preferences.all_cascades = attributes['all cascades'] unless attributes['all cascades'].nil?
  @config_preferences.web_restores = attributes['web restores'] unless attributes['web restores'].nil?
  @config_preferences.kmip_key = attributes['kmip key'] unless attributes['kmip key'].nil?
  @config_preferences.address = attributes['address'] unless attributes['address'].nil?
  @config_preferences.kmip_service_port = attributes['KMIP service port'] unless attributes['KMIP service port'].nil?
  @config_preferences.trust_ca = attributes['Trust CA'] unless attributes['Trust CA'].nil?
  @config_preferences.nae_xml_service_port = attributes['NAE-XML service port'] unless attributes['NAE-XML service port'].nil?
  @config_preferences.key_group_name = attributes['Key group name'] unless attributes['Key group name'].nil?

  # scheduling
  @config_scheduling = Bus::DataObj::ConfigScheduling.new
  @config_scheduling.automatic_max_load = attributes['automatic max load'] unless attributes['automatic max load'].nil?
  @config_scheduling.automatic_min_idle = attributes['automatic min idle'] unless attributes['automatic min idle'].nil?
  @config_scheduling.automatic_interval = attributes['automatic interval'] unless attributes['automatic interval'].nil?

  # bandwidth throttling
  @client_config.throttle = (attributes['throttle'] || "no").eql?("yes")
  @client_config.throttle_amount = attributes['throttle amount']

  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_edit_client_config(@client_config,action)
  @bus_site.admin_console_page.client_config_section.cc_iframe.edit_preferences_settings(@config_preferences)
  @bus_site.admin_console_page.client_config_section.cc_iframe.edit_scheduling_settings(@config_scheduling)
  @bus_site.admin_console_page.client_config_section.cc_iframe.save_client_configs
end

Then /^client configuration section (message|warning) should be (.+)/ do |type,message|
  @create_new_cc_start_time = Time.now.utc
  if type == 'message'
    @bus_site.admin_console_page.client_config_section.cc_iframe.messages == message
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_warning == message
  end
  @create_new_cc_end_time = Time.now.utc
  @bus_site.log("KPI-Create_New_Client_Config:start_time:#{@create_new_cc_start_time}/end_time:#{@create_new_cc_end_time}")
end

Then /^I edit the new created (config|mobile rule) (.+)$/ do |type,config_or_rule_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.open_link(config_or_rule_name)
end

And /^I cancel update client configuration$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.cancel_edit_client_config
end

Then /^I remove user group: (.+) from the configuration$/ do |user_group_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.remove_group_from_config(user_group_name)
end

Then /^I save the client configuration changes$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.save_client_configs
end

Then /^I should(| not) see client config (.+)$/ do | not_see, config_name |
  found = @bus_site.admin_console_page.client_config_section.cc_iframe.is_existing_client_config(config_name)
  if not_see == ' not'
    found.should == false
  else
    found.should == true
  end
end

And /^I copy client configuration (.+) to create new client configuration (.+)/ do |old_config_name,new_config_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.copy_client_config(old_config_name,new_config_name)
end

Then /^the group of client configuration (.+) should be (.+)$/ do |config_name,group_name|
  if group_name == 'blank'
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_client_config_group(config_name).size.should == 0
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_client_config_group(config_name).should == group_name
  end
end

And /^I click tab (.+)$/ do |tab_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_tab(tab_name)
end

Then /^I should on linux backup sets list page$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_backup_lnk_visible.should be_true
end

##| linux backup set name |name includes|name excludes|type includes|type excludes|exclusionary| search locations 1 |search locations 2        |delete location |
##| 126287_backupset      | test1       | test2       | autotest1   | autotest2   | true       |Include:/home/user/www|Exclude:/home/user1/www| /a/c|
When /^I (create|edit) Linux Backup Set:$/ do |action,backupset_table|
  attributes = backupset_table.hashes.first
  if action == 'create'
    @linux_backup_sets = Bus::DataObj::LinuxBackupSets.new
    @linux_backup_sets.backup_name = attributes['linux backup set name'] unless attributes['linux backup set name'].nil?
    @bus_site.admin_console_page.client_config_section.cc_iframe.set_linux_backup_name(@linux_backup_sets.backup_name)
  end

  # input exclusionary
  exclusionary = attributes['exclusionary'] unless attributes['exclusionary'].nil?
  unless exclusionary.nil?
    @bus_site.admin_console_page.client_config_section.cc_iframe.check_exclusionary(exclusionary)
    @linux_backup_sets.exclusionary = exclusionary
  end

  # get inputted rules and locations
  locations = []
  rules = Hash.new
  attributes.each do |key,value|
    if  key.match(/^search locations \d+$/)
        type_location = value.split(':')
        locations << {'location types' => type_location[0],'folder names' => type_location[1]}
    end
    if key.match(/\w+[in|ex]cludes$/)
      rules[key]=value
    end
  end

  # add/edit locations
  if locations.size > 0
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_locations(locations)
    @linux_backup_sets.search_locations = locations
  end

  #add/edit rules
  if rules.size > 0
    @linux_backup_sets.rules = rules
    @bus_site.admin_console_page.client_config_section.cc_iframe.add_linux_backup_rules(@linux_backup_sets.rules)
  end

  #delete location
  unless attributes['delete location'].nil?
    del_location = []
    del_type_location = attributes['delete location'].split(':')
    @bus_site.admin_console_page.client_config_section.cc_iframe.delete_location(del_type_location[1])
    del_location << {'location types' => del_type_location[0],'folder names' => del_type_location[1]}
    @linux_backup_sets.search_locations = locations - del_location
  end
end

When /^I click edit link of (linux|mac|windows) backup set (.+)$/ do |type,backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_edit_backup_set(backup_name)
end

Then /^edit link of linux backup set (.+) should be disabled$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.edit_linux_backup_exsit(backup_name).size.should == 0
end

When /^I delete linux backup set (.+)$/ do |backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.delete_linux_backup(backup_name)
end

Then /(linux|mac|windows) backup set (.+) should be opened$/ do |type,backup_name|
  @bus_site.admin_console_page.client_config_section.cc_iframe.backup_name_visible(backup_name).should be_true
end

Then /^linux backup set (.+) (should not|should) exist$/ do |backup_name,action|
  if action == 'should not'
    @bus_site.admin_console_page.client_config_section.cc_iframe.backup_set_name_visible(backup_name).should < 1
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.backup_set_name_visible(backup_name).should > 0
  end
end

When /^I (check|uncheck) the (setting|cascade|lock) for linux backup set (.+)/ do |action,type, backup_name|
  index = 0
  case type
    when 'cascade'
      index = 2
    when 'setting'
      index = 1
    when 'lock'
      index = 3
  end
  backup_hash ={'backup name' => backup_name, 'index' => index, 'action' => action}
  @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup(backup_hash)
end

Then /^the (setting|setting and lock|setting and lock and cascade) of linux backup set (.+) should be (disabled|checked|unchecked)/ do |action, backup_name,type|
  backup_array = []
  if action.include?('cascade')
    backup_array << {'backup name' => backup_name, 'index' => 2}
  end
  if action.include?('setting')
    backup_array << {'backup name' => backup_name, 'index' => 1}
  end
  if action.include?('lock')
    backup_array << {'backup name' => backup_name, 'index' => 3}
  end
  backup_array.each_index do |n|
    if type == 'disabled'
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_disabled?(backup_array[n]).should be_true
    elsif type == 'checked'
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_checked?(backup_array[n]).should be_true
    else
      @bus_site.admin_console_page.client_config_section.cc_iframe.lock_cascade_setting_linux_backup_checked?(backup_array[n]).should be_false
    end
  end
end

Then /^the linux backup set should be:$/ do |backupset_table|
  attributes = backupset_table.hashes.first
  expected_rules = Hash.new
  expected_locations = []
  attributes.each do |key,value|
    # get expected rules
    if key.match(/\w+[in|ex]cludes$/)
      expected_rules[key]=value
    end
    # get expected locations
    if key.match(/^search locations \d+$/)
      type_location = value.split(':')
      expected_locations << {'location types' => type_location[0],'folder names' => type_location[1]}
    end
  end
  if expected_rules.size > 0
    actual_rules = @bus_site.admin_console_page.client_config_section.cc_iframe.get_linux_backup_rules
    expected_rules.each_key do |key|
      expected_rules[key].should == actual_rules[key]
      Log.debug("actual #{key} rule is:"+actual_rules[key])
    end
  end
  if expected_locations.size > 0
    actual_locations = @bus_site.admin_console_page.client_config_section.cc_iframe.get_search_locations
    Log.debug("search locations from UI is:"+actual_locations.to_s)
    (expected_locations - actual_locations).size.should == 0
  end
  # check exclusionary
  exclusionary = attributes['exclusionary'] unless attributes['exclusionary'].nil?
  unless exclusionary.nil?
    Log.debug("exclusionary from UI is:"+exclusionary.to_s)
    @bus_site.admin_console_page.client_config_section.cc_iframe.get_exclusionary.to_s.should == exclusionary
  end
end

When /^I get linux backup sets through API$/ do
  username =  @clients.last.username
  password =  @clients.last.password
  machine_hash =  @clients.last.machine_hash
  get_linux_backup_sets_clients(@admin_id, username, password, machine_hash)
end

And /^I click (done to save|cancel to cancel update) linux backup sets$/ do |action|
  case action
    when 'done to save'
      @bus_site.admin_console_page.client_config_section.cc_iframe.click_done
    when 'cancel to cancel update'
      @bus_site.admin_console_page.client_config_section.cc_iframe.cancel_edit_linuxset
  end
  @bus_site.admin_console_page.client_config_section.wait_until_bus_section_load
end

When /^I delete configuration (.+)/ do |client_config|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['client_configuration'])
  @bus_site.admin_console_page.client_config_section.cc_iframe.delete_client_config(client_config)
end

# | exclusionary | search locations 1        | search locations 2         | filenames    |exclude_filenames          | filetypes                     | exclude_filetypes |
# | true         | Include:/home/备份/backup* | Exclude:/home/qiezi/*.exe  | /home/user/ |note  *e* "UNIT TEXT" 文件 | log txt JPG EXE MSI TA*  *LSX | exe rb        |
Then /^the backup sets from API should be:$/ do |sets_table|
  expected_sets_array = sets_table.hashes
  expected_sets_array.each_index do |array_index|
    expected_sets = expected_sets_array[array_index]
    expected_exclusionary = expected_sets['exclusionary'] unless expected_sets['exclusionary'].nil?
    expected_name = expected_sets['linux backup set name'] unless expected_sets['linux backup set name'].nil?
    expected_rules = Hash.new
    expected_locations = []
    expected_sets.each do |key,value|
      #get expected rules
      if key.match(/^*file\w+s$/)
        expected_rules[key]=value
      end
      #get expected locations
      if key.match(/^search locations \d+$/)
        type_location = value.split(':')
        expected_locations << {'location types' => type_location[0],'folder names' => type_location[1]}
      end
    end
    #check backup set name
    @backupsets_from_client[array_index]['name'].to_s.should == expected_name unless expected_name.nil?

    #check exclusionary
    unless expected_exclusionary.nil?
      exclusionary_response = @backupsets_from_client[array_index]['exclusionary']
      Log.debug("exclusionary from API is:"+exclusionary_response.to_s)
      exclusionary_response.to_s.should == expected_exclusionary
    end
    #get and check rules from api
    if expected_rules.size > 0
      rules_response = @backupsets_from_client[array_index]['rules']
      expected_rules.each_key do |key|
        rules_response[key] = rules_response[key].join(' ')
        Log.debug("rules from API is:"+rules_response[key].to_s)
        rules_response[key].to_s.should == expected_rules[key].gsub("\"","")
      end
    end
    #get and check locations from api
    if expected_locations.size >0
      excludes_locations = @backupsets_from_client[array_index]['excludes']
      includes_locations = @backupsets_from_client[array_index]['paths']
      actual_locations = []
      if excludes_locations.size > 0
        excludes_locations.each_index do |n|
          actual_locations << {'location types' => 'Exclude', 'folder names' => excludes_locations[n]}
        end
      end
      if includes_locations.size > 0
        includes_locations.each_index do |n|
          actual_locations << {'location types' => 'Include', 'folder names' => includes_locations[n]}
        end
      end
      #expected_locations && actual_locations =[{'location types' => 'Include',folder names' =>'/a/b/c'},{},......]
      Log.debug("search locations from API is:"+actual_locations.to_s)
      (expected_locations - actual_locations).size.should == 0
    end
  end
end

Then /^the linux backup set (.+) should not exist in Client API$/ do |backup_name|
  @backupsets_from_client.each_index do |n|
    @backupsets_from_client[n]['name'].to_s.should_not == backup_name
  end
end

# |warning days| all settings | warning days editable | ckey                               | private key          | web_restores |
# |15:cascade | unchecked     | all disabled         | http://gradyplayer.com/myckey.ckey | only private key / yes| all uncheked |
Then /^preferences settings should be:$/ do |table|
  attributes = table.hashes.first
  ckey = attributes['ckey'] unless attributes['ckey'].nil?
  private_key = attributes['private key'] unless attributes['private key'].nil?
  default_key = attributes['default key'] unless attributes['default key'].nil?
  enforce_encryption_type = attributes['enforce encryption type'] unless attributes['enforce encryption type'].nil?
  warning_days_settings = attributes['warning days'] unless attributes['warning days'].nil?
  all_settings = attributes['all settings'] unless attributes['all settings'].nil?
  all_cascades = attributes['all cascades'] unless attributes['all cascades'].nil?
  all_locks = attributes['all locks'] unless attributes['all locks'].nil?
  web_restores = attributes['web restores'] unless attributes['web restores'].nil?
  warning_days_settings_editable = attributes['warning days editable'] unless attributes['warning days editable'].nil?
  kmip_key = attributes['kmip key'] unless attributes['kmip key'].nil?
  address = attributes['address'] unless attributes['address'].nil?
  kmip_service_port = attributes['KMIP service port'] unless attributes['KMIP service port'].nil?
  trust_ca = attributes['Trust CA'] unless attributes['Trust CA'].nil?
  nae_xml_service_port = attributes['NAE-XML service port'] unless attributes['NAE-XML service port'].nil?
  key_group_name = attributes['Key group name'] unless attributes['Key group name'].nil?
  # warning days
  actual_warning_days_settings = @bus_site.admin_console_page.client_config_section.cc_iframe.get_warning_days_settings
  if !warning_days_settings.nil?
    expected_days_setting = warning_days_settings.split(":")[0]
    expected_days_lock = false
    expected_days_cascade = false
    if warning_days_settings.include?("lock")
      expected_days_lock = true
    elsif warning_days_settings.include?("cascade")
      expected_days_lock = true
      expected_days_cascade = true
    end
    actual_warning_days_settings['warning days'].should == expected_days_setting
    actual_warning_days_settings['warning days lock'].should == expected_days_lock
    actual_warning_days_settings['warning days cascade'].should == expected_days_cascade unless actual_warning_days_settings['warning days cascade'].nil?
  end

  if !warning_days_settings_editable.nil?
    days_expected_result = ((warning_days_settings_editable == 'all disabled')? true:false)
    actual_warning_days_settings['warning days disabled'].to_s.should == days_expected_result.to_s
    actual_warning_days_settings['warning days lock disabled'].to_s.should == days_expected_result.to_s
    actual_warning_days_settings['warning days cascade disabled'].to_s.should == days_expected_result.to_s unless actual_warning_days_settings['warning days cascade editable'].nil?
  end

  # ckey
  if !ckey.nil?
    actual_ckey = @bus_site.admin_console_page.client_config_section.cc_iframe.get_ckey
    actual_ckey['is ckey'].should be_true
    actual_ckey['ckey url'].should == ckey
  end

  # private key && default key
  actual_non_ckey = @bus_site.admin_console_page.client_config_section.cc_iframe.get_non_ckey unless private_key.nil? & default_key.nil?
  if !private_key.nil?
    actual_non_ckey['is private key'].should be_true
    if private_key == 'only private key'
      actual_non_ckey['is default key'].should be_false
      actual_non_ckey['is random key'].should be_false unless actual_non_ckey['is random key'].nil?
    end
  end

  if !default_key.nil?
    actual_non_ckey['is default key'].should be_true
    if private_key == 'only default key'
      actual_non_ckey['is private key'].should be_false
      actual_non_ckey['is random key'].should be_false unless actual_non_ckey['is random key'].nil?
    end
  end

  # enforce encryption type: Prevent back up if encryption does not match policy..
  if !enforce_encryption_type.nil?
    actual_enforce_encryption_type = @bus_site.admin_console_page.client_config_section.cc_iframe.get_enforce_encryption_type
    expected_type_setting = false
    expected_type_cascade = false
    case enforce_encryption_type
      when 'setting'
        expected_type_setting =true
      when 'cascade'
        expected_type_setting = true
        expected_type_cascade = true
      when  'all unchecked'
        # same as the default
    end
    actual_enforce_encryption_type['setting'].should == expected_type_setting
    actual_enforce_encryption_type['cascade'].should == expected_type_cascade unless actual_enforce_encryption_type['cascade'].nil?
  end

  # web restores: Enable "Access files online" link and "Restore files" button
  if !web_restores.nil?
    actual_web_restores = @bus_site.admin_console_page.client_config_section.cc_iframe.get_web_restores
    expected_web_setting = false
    expected_web_cascade =false
    case web_restores
      when 'setting'
        expected_web_setting = true
      when 'cascade'
        expected_web_setting = true
        expected_web_cascade =true
      when 'all unchecked'
        #same as default value
    end
    actual_web_restores['web restores setting'].should == expected_web_setting
    actual_web_restores['web restores cascade'].should == expected_web_cascade unless actual_web_restores['web restores cascade'].nil?
  end

  if !all_settings.nil?
    presetting_values = @bus_site.admin_console_page.client_config_section.cc_iframe.get_all_presetting_value
    presetting_values.each_index do |n|
      if all_settings == 'checked'
        presetting_values[n].should be_true
      else
        presetting_values[n].should be_false
      end
    end
  end

  if !all_cascades.nil?
    precascade_values = @bus_site.admin_console_page.client_config_section.cc_iframe.get_all_precascade_value(all_cascades)
    precascade_values.each_index do |n|
      if all_cascades == 'checked'
        precascade_values[n].should be_true
      else
        precascade_values[n].should be_false
      end
    end
  end

  if !all_locks.nil?
    prelock_values = @bus_site.admin_console_page.client_config_section.cc_iframe.get_all_prelock_value(all_locks)
    prelock_values.each_index do |n|
      if all_locks == 'checked'
        prelock_values[n].should be_true
      else
        prelock_values[n].should be_false
      end
    end
  end

  # kmip
  if !kmip_key.nil?
    actual_kmip = @bus_site.admin_console_page.client_config_section.cc_iframe.get_kmip
    actual_kmip['is kmip'].should be_true
    actual_kmip['address'].should == address
    actual_kmip['KMIP service port'].should == kmip_service_port
    actual_kmip['Trust CA'].should == trust_ca
    actual_kmip['NAE-XML service port'].should == nae_xml_service_port
    actual_kmip['Key group name'].should == key_group_name
  end
end

# |automatic max load|automatic min idle|automatic interval| automatic max load editable| automatic min idle editable | automatic interval editable |
# | 10:cascade       | 10:cascade               |7:cascade           |  all disabled              |all disabled                  | all disabled|
Then /^scheduling settings should be:$/ do |table|
  attributes = table.hashes.first
  automatic_max_load = attributes['automatic max load'] unless attributes['automatic max load'].nil?
  automatic_max_load_editable = attributes['automatic max load editable'] unless attributes['automatic max load editable'].nil?
  automatic_min_idle = attributes['automatic min idle'] unless attributes['automatic min idle'].nil?
  automatic_min_idle_editable = attributes['automatic min idle editable'] unless attributes['automatic min idle editable'].nil?
  automatic_interval = attributes['automatic interval'] unless attributes['automatic interval'].nil?
  automatic_interval_editable = attributes['automatic interval editable'] unless attributes['automatic interval editable'].nil?
  if !automatic_max_load.nil?
    actual_max_load_values =  @bus_site.admin_console_page.client_config_section.cc_iframe.get_automatic_max_load_values
    expected_max_setting = automatic_max_load.split(":")[0]
    expected_max_lock = false
    expected_max_cascade = false
    if automatic_max_load.include?("lock")
      expected_max_lock = true
    elsif automatic_max_load.include?("cascade")
      expected_max_lock = true
      expected_max_cascade = true
    end
    actual_max_load_values['max setting'].should == expected_max_setting
    actual_max_load_values['max lock'].should == expected_max_lock
    actual_max_load_values['max cascade'].should == expected_max_cascade unless actual_max_load_values['max cascade'].nil?
  end

  if !automatic_max_load_editable.nil?
    max_expected_value = ((automatic_max_load_editable == 'all disabled')? true:false)
    actual_max_load_values['max setting disabled'].to_s.should == max_expected_value.to_s
    actual_max_load_values['max lock disabled'].to_s.should == max_expected_value.to_s
    actual_max_load_values['max cascade disabled'].to_s.should == max_expected_value.to_s unless actual_max_load_values['max cascade disabled'].nil?
  end

  if !automatic_min_idle.nil?
    actual_min_idle_values =  @bus_site.admin_console_page.client_config_section.cc_iframe.get_automatic_min_idle_values
    expected_min_setting = automatic_min_idle.split(":")[0]
    expected_min_lock = false
    expected_min_cascade = false
    if automatic_min_idle.include?("lock")
      expected_min_lock = true
    elsif automatic_min_idle.include?("cascade")
      expected_min_lock = true
      expected_min_cascade = true
    end
    actual_min_idle_values['min setting'].should == expected_min_setting
    actual_min_idle_values['min lock'].should == expected_min_lock
    actual_min_idle_values['min cascade'].should == expected_min_cascade unless actual_min_idle_values['min cascade'].nil?
  end

  if !automatic_min_idle_editable.nil?
    min_expected_result = ((automatic_min_idle_editable == 'all disabled')? true:false)
    actual_min_idle_values['min setting disabled'].to_s.should == min_expected_result.to_s
    actual_min_idle_values['min lock disabled'].to_s.should == min_expected_result.to_s
    actual_min_idle_values['min cascade disabled'].to_s.should == min_expected_result.to_s unless actual_min_idle_values['min cascade disabled'].nil?
  end

  if !automatic_interval.nil?
    actual_interval_values =  @bus_site.admin_console_page.client_config_section.cc_iframe.get_automatic_interval_values
    expected_int_setting = automatic_interval.split(":")[0]
    expected_int_lock = false
    expected_int_cascade = false
    if automatic_interval.include?("lock")
      expected_int_lock = true
    elsif automatic_interval.include?("cascade")
      expected_int_lock = true
      expected_int_cascade = true
    end
    actual_interval_values['interval setting'].should == expected_int_setting
    actual_interval_values['interval lock'].should == expected_int_lock
    actual_interval_values['interval cascade'].should == expected_int_cascade unless actual_interval_values['interval cascade'].nil?
  end

  if !automatic_interval_editable.nil?
    int_expected_result = ((automatic_interval_editable == 'all disabled')? true:false)
    actual_interval_values['interval setting disabled'].to_s.should == int_expected_result.to_s
    actual_interval_values['interval lock disabled'].to_s.should == int_expected_result.to_s
    actual_interval_values['interval cascade disabled'].to_s.should == int_expected_result.to_s unless actual_interval_values['interval cascade disabled'].nil?
  end
end

And /^I create mac backup set$/ do |table|
  mac_hash = table.hashes.first
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_mac_backup(mac_hash)
end

And /^I create mobile rules$/ do |table|
  attributes = table.hashes.first
  @mobile_rules = Bus::DataObj::ConfigMobileRules.new
  @mobile_rules.mobile_rules_name = attributes['mobile rules name'] unless attributes['mobile rules name'].nil?
  @mobile_rules.locking = attributes['mobile locking'] unless attributes['mobile locking'].nil?
  @bus_site.admin_console_page.client_config_section.cc_iframe.create_mobile_rules(@mobile_rules)
end

Then /^mobile rules should be:$/ do |table|
  attributes = table.hashes.first
  locking = attributes['mobile locking'] unless attributes['mobile locking'].nil?
  expected_lock_value = false
  expected_cascade_value = false
  if !locking.nil?
    case locking
      when 'lock'
        expected_lock_value = true
      when 'cascade'
        expected_lock_value = true
        expected_cascade_value = true
      when 'all uncheck'
        # same as default value
    end
    actual_locking = @bus_site.admin_console_page.client_config_section.cc_iframe.get_mobile_rules_locking
    actual_locking["mobile rules lock" ].should == expected_lock_value
    actual_locking["mobile rules cascade" ].should == expected_cascade_value unless actual_locking["mobile rules cascade" ].nil?
  end
end

Then /^cascade option (should not|should) exist for encryption key$/ do |type|
  if type == 'should not'
    @bus_site.admin_console_page.client_config_section.cc_iframe.encryption_key_cascade_visible?.should be_false
  else
    @bus_site.admin_console_page.client_config_section.cc_iframe.encryption_key_cascade_visible?.should be_true
  end
end

Then /^prevent backup with wrong encryption type is enabled$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.enforce_encryption_type_visible?.should be_true
end

Then /^kmip client certificate issuer help icon text is (.+)/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.issuer_help_icon_text == message
end

When /^I click help icon for kmip client certificate issuer$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_issuer_icon
end

Then /^KMIP client certificate issuer help message should be:$/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.issuer_help_messages.strip.should eq(message.strip)
end

Then /^kmip nae service port help icon text is (.+)/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.nae_help_icon_text == message
end

When /^I click help icon for kmip nae service port$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_nae_icon
end

Then /^KMIP nae service port help message should be:$/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.nae_help_messages.strip.should eq(message.strip)
end

Then /^kmip group name help icon text is (.+)/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.group_name_help_icon_text == message
end

When /^I click help icon for kmip group name$/ do
  @bus_site.admin_console_page.client_config_section.cc_iframe.click_group_name_icon
end

Then /^KMIP group name help message should be:$/ do |message|
  @bus_site.admin_console_page.client_config_section.cc_iframe.group_name_help_messages.strip.should eq(message.strip)
end
