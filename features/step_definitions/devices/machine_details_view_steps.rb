Then /^the data shuttle machine details should be:$/ do |ds_table|
  actual = @bus_site.admin_console_page.machine_details_section.dso_hashes
  expected = ds_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'Order Date'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        when 'Start'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y')) unless v == ''
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
    end
  end
  expected.each_index{ |index|
    expected[index].keys.each{ |key|
      if key == 'Elapsed' && expected[index][key].include?('minute')
        (actual[index][key].match(/^(less than a|1|2|3) minute(s)?/)[0].nil?).should == false
      else
        actual[index][key].should == expected[index][key]
      end
    }
  }
end

When(/^I close machine details section$/) do
  @bus_site.admin_console_page.machine_details_section.close_bus_section
end

And /^I refresh Machines Details section$/ do
  @bus_site.admin_console_page.machine_details_section.refresh_bus_section
end

Then /^machine details should be:$/ do |md_table|
  actual = @bus_site.admin_console_page.machine_details_section.machine_info_hash
  expected = md_table.hashes[0]
  expected.each do |k,v|
      case k
        when 'Owner:'
          v.gsub!(/@user_email/, @new_users.first.email) unless @new_users.nil?
        when 'Product Key:'
          v.gsub!(/@client.license_key/, @client.license_key) unless @client.nil?
        when 'Client Version:'
          v.gsub!(/@version_name/, @version_name) unless @version_name.nil?
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
  end
  expected.keys.each{|key| actual[key].should == expected[key] }
end

And /^I get machine details info$/ do
  @machine_info = @bus_site.admin_console_page.machine_details_section.machine_info_hash
  Log.debug @machine_info
end

And /^I view machine (.+) details from user details section$/ do  |device_name|
  @bus_site.admin_console_page.user_details_section.view_device_details(device_name)
end

And /^I view deleted machine details from user details section$/ do
  @bus_site.admin_console_page.user_details_section.view_device_details(@client.machine_alias, deleted = true)
end

And /^I click manifest view link$/ do
  @bus_site.admin_console_page.machine_details_section.click_view_manifest
end

And /^view manifest window of machine (.+) is opened$/ do |device_name|
  @bus_site.manifest_view_page.view_manifest_window_visible(device_name).should > 0
end

Then /^the manifest window title should be (.+)$/ do |title|
  @bus_site.admin_console_page.get_new_window_page_title.should == title
end

Then /^the manifest window title should include (.+)$/ do |title|
  @bus_site.admin_console_page.get_new_window_page_title.include?(title).should == true
end

And /^I click manifest raw link to download the manifest file$/ do
  @bus_site.admin_console_page.machine_details_section.click_raw_manifest
end

Then /^the (manifest|Logfile) file is downloaded$/ do  |_, file_table|
  attributes = file_table.hashes.first
  attributes.each do |header,attribute|
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end
  @file_name = attributes["file name"]
  wait_until { FileHelper.file_exists?(@file_name) }
  FileHelper.file_exists?(@file_name).should be_true
end

And /^File size should be greater than 0$/ do
  wait_until{FileHelper.get_file_size(@file_name) > 0}
  (FileHelper.get_file_size(@file_name) > 0).should be_true
end

Then /^I delete the newly downloaded file$/ do
  FileHelper.delete_file(@file_name)
end

And /^I delete file (.+) if exist$/ do |file_name|
  FileHelper.delete_file(file_name)
end

And /^I delete the manifest file belongs to (.+)$/ do |machine_name|
  @manifest_file_name = "manifest-" + @new_users.first.email.to_s + "-" + machine_name + ".txt"
  @manifest_file_name = @manifest_file_name.gsub("+", "")
  FileHelper.delete_file(@manifest_file_name)
end

And /^I delete the client log belongs to (.+)$/ do |machine_name|
  @log_file_name = "client-" + @new_users.first.email.to_s + "-" + machine_name + ".log"
  @log_file_name = @log_file_name.gsub("+", "")
  FileHelper.delete_file(@log_file_name)
end

Then /^I (delete|undelete) the machine$/ do |action|
  @bus_site.admin_console_page.machine_details_section.delete_undelete_machine(action)
end

And /^I click on the replace machine link$/ do
  @bus_site.admin_console_page.machine_details_section.click_replace_machine
end

And /^I select (.+) to be replaced$/ do |machine|
  if !(machine.match(/^@.+$/).nil?)
    machine =  '<%=' + machine + '%>'
  end
  machine.replace ERB.new(machine).result(binding)
  @bus_site.admin_console_page.replace_machine_section.replace_machine(machine)
end

Then /^The machines listed for replacement should be$/ do |machines_table|
  attributes = machines_table.raw
  actual = @bus_site.admin_console_page.replace_machine_section.get_replace_machine_list
  expected = attributes.map{ |attr|
    attr[0].replace ERB.new(attr[0]).result(binding)
  }
  actual.sort.should == expected.sort
end

And /^I close Sync section$/ do
  @bus_site.admin_console_page.machine_details_section.close_bus_section
end

When /^I set (.+) sync client region as (.+) and country as (.+)$/ do |user, region, country|
  user_email = @current_user[:email] if user == 'newly created user'
  user_password = CONFIGS['global']['test_pwd']
  machine_hash = "user_#{@user_id}_sync"
  country = 'US' if country == 'default'
  body = get_machine_info(@admin_id, user_email, user_password, machine_hash, 'sync', region, country)
  (body.downcase.include?('error')).should == false
end

And /^I refresh sync details section$/ do
  @bus_site.admin_console_page.machine_details_section.refresh_bus_section
end

Then /^I (should|should not) see data shuttle table in machine details section$/ do |type|
  if type.include? "not"
    @bus_site.admin_console_page.machine_details_section.data_shuttle_table_visible?.should be_false
  else
    @bus_site.admin_console_page.machine_details_section.data_shuttle_table_visible?.should be_true
  end
end

And /^I refresh Machine Details section$/ do
  @bus_site.admin_console_page.machine_details_section.refresh_bus_section
end

When /^I update the deleted at time to today minus (\S+) days$/ do |days|
  global_undelete_value = DBHelper.get_global_setting_value("machine_undelete_window_length").to_i
  if days == 'global_undelete_value'
    days = global_undelete_value
  elsif !(days.match(/global_undelete_value(\+|-)(\d+)/).nil?)
    array = days.match(/global_undelete_value(\+|-)(\d+)/)
    if array[1] == "+"
      days = global_undelete_value + array[2].to_i
    else
      days = global_undelete_value - array[2].to_i
    end
  end
  DBHelper.update_machine_deleted_at(@client.machine_id, days.to_i)
end

Then /^I (shouldnot|should) see Undelete Machine link$/ do |exist|
  actual_result = @bus_site.admin_console_page.machine_details_section.undelete_machine_link_exist
  expected = (exist == 'should'? true : false)
  actual_result.should == expected
end

Then /^retention period should be (\d+) days$/ do |days|
  @get_client_config_response["X-Data-Retention"].should == days
end

Then /^Machine action bar links should be$/ do |table|
   expected_links = table.rows.flatten
   @bus_site.admin_console_page.machine_details_section.get_machine_bar_actions.should == expected_links
end

And /^Backups section without backup history will show (.+)$/ do |text|
  @bus_site.admin_console_page.machine_details_section.get_backup_section_text.should == text
end

And /^Restores section without finished restores will show (.+)$/ do |text|
  @bus_site.admin_console_page.machine_details_section.get_restores_section_text.should == text
end

And /Backups table will display with text No results found.$/ do
  @bus_site.admin_console_page.machine_details_section.backup_table_empty.should == true
end

Then /^I click (.+) from machines details section$/ do |link_name|
  @bus_site.admin_console_page.machine_details_section.click_machine_link(link_name)
end

And /^(Backups|Restores|Virtual Machines) table will display as:$/ do |type, table|
  actual = @bus_site.admin_console_page.machine_details_section.get_backup_restore_table_hashes(type)
  expected = table.hashes
  expected.each_with_index do |record_hash, line|
    record_hash.each do |k,v|
      v.replace ERB.new(v).result(binding)
      case k
        when 'Start Time'
          if v == 'today'
            v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
            actual[line][k].should include(v)
            v.replace actual[line][k]
          end
        else
          if v == 'any'
            v.replace actual[line][k]
          end
      end
    end
  end

  Log.debug "expected: #{expected}"
  Log.debug "actual: #{actual}"
  expected.each{ |key| (actual.include?(key)).should be_true}

end

And /^(Backups|Restores|Virtual Machines) table first record will display as:$/ do |type, table|
  actual = @bus_site.admin_console_page.machine_details_section.get_backup_restore_table_hashes(type)[0]
  expected = table.hashes[0]
  expected.each do |k,v|
    v.replace ERB.new(v).result(binding)
    case k
      when 'Date/Time Requested'
        v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        actual[k].should include(v)
      when 'Date/Time Finished'
        if v == 'today'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
          actual[k].should include(v)
        else
          actual[k].should == v
        end
      when 'Status / Downloads'
        if v.include? ('today')
          v.gsub!(/today/, Chronic.parse(v).strftime('%m/%d/%y'))
          actual[k].should include(v)
        else
          actual[k].should == v
        end
      else
        actual[k].should == v
    end
  end
end

And /^action links in the manifest will be$/ do |table|
  @bus_site.manifest_view_page.get_action_links.should == table.raw[0]
end

And /^manifest content will include$/ do |text|
  @bus_site.manifest_view_page.get_manifest_content.include?(text.strip).should == true
end

And /^manifest (.+) txt file should include:$/ do |file, text|
 FileHelper.read_file(file, "txt").include?(text).should == true
end

And /^manifest file should have valid manifest$/ do
  file_prefix = @manifest_file_name.split(".txt")[0]
  FileHelper.read_file(file_prefix, "txt").split("_hash|")[1].split("\n")[0].length.should == 40
end

And /^the machine (.+) available quota should be (.+)$/ do |machine_id,quota|
  machine_id.replace ERB.new(machine_id).result(binding)
  DBHelper.get_machine_available_quota(machine_id.to_i).should == quota
end

And /^I add machine external id$/ do
  @machine_external_id = "#{Time.now.strftime('%m%d-%H%M-%S')}"
  @bus_site.admin_console_page.machine_details_section.change_machine_external_id(@machine_external_id)
end

Then /^I will see (.+) in machine details$/ do |text|
  text.gsub!(/today/,Chronic.parse('today').strftime('%m/%d/%y'))
  @bus_site.admin_console_page.machine_details_section.get_replace_machine_text.should include(text)
end

And /^Error message for replace machine should be (.+)$/ do |message|
  @bus_site.admin_console_page.replace_machine_section.get_replace_machine_error_msg.should == message
end

Then /^click item (Download Restore|others) to download restore file$/ do |downloadItem|
  @bus_site.admin_console_page.machine_details_section.click_machine_download_item(downloadItem)
end
