And /^activate the user's (Server|Desktop) device without a key and with the default password$/ do  |device_type|
  @new_clients =[]
  @clients =[] if @clients.nil?
  client = KeylessClient.new(@new_users.first.email, CONFIGS['global']['test_pwd'], @partner_id, @partner.company_info.name, device_type, @partner.partner_info.type)
  client.activate_client_devices
  @license_key = client.license_key
  Log.debug @license_key
  @license_key.should_not be_nil
  client.machine_id = DBHelper.get_machine_id_by_license_key(@license_key)
  @new_clients << client
  @clients << client
end

And /^activate the mozyhome user's (Desktop) device with the default password$/ do  |device_type|
  @new_clients =[]
  @clients =[] if @clients.nil?
  client = KeylessClient.new(@partner.admin_info.email, CONFIGS['global']['test_pwd'], @partner_id, @partner.company_info.name, device_type, @partner.partner_info.type)
  client.simple_activate_devices
  @new_clients << client
  @clients << client
end

When /^I use keyless activation to activate devices(| unsuccessful| newly)$/  do | type, table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end

  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  if @current_partner.nil?
    current_partner_id = @partner_id
  else
    @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
    current_partner_id = @current_partner[:id]
  end
  current_partner_id = attr['partner_id'] || current_partner_id
  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?
  region = attr['user_region'] || attr['ug_region'] || attr['partner_region'] || 'qa'
  # company_type = @partner.partner_info.type unless @partner.nil?
  # company_type = @subpartner.company_type unless @subpartner.nil?

  @new_clients =[]
  @clients =[] if @clients.nil?
  # when run cases in a batch, sometimes need to clear the @client array for a new case if need to activate multiple devices and get all the license keys
  @clients = [] if type == ' newly'

  machine_name = attr['machine_name']
  machine_name = "machine#{Time.now.strftime("%m%d%H%M%S")}" if attr['machine_name'] == 'auto_generate'
  @client = KeylessClient.new(user_email, @user_password, current_partner_id, partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, nil, machine_name, region)
  @client.activate_client_devices
  @license_key = @client.license_key
  if type.include?('unsuccessful')
    (@client.response.body.downcase.include?('error')).should == true
  else
    @license_key.should_not be_nil
    @client.machine_id = DBHelper.get_machine_id_by_license_key(@license_key)
  end
  @new_clients << @client
  @clients << @client
end

When /^I use keyless activation to activate devices to get sso auth code$/  do |table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end
  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]

  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?
  region = attr['user_region'] || attr['ug_region'] || attr['partner_region'] || 'qa'

  @new_clients =[]
  @clients =[] if @clients.nil?

  machine_name = attr['machine_name']
  machine_name = "machine#{Time.now.strftime("%m%d%H%M%S")}" if attr['machine_name'] == 'auto_generate'
  @client = KeylessClient.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, nil, machine_name, region)
  @client.get_sso_auth_code
  @clients << @client
end

And /^I update (.+) encryption value to (.+)$/ do |machine_id, encrypt_value|
  machine_id = @new_clients[0].machine_id if machine_id == 'newly created machine'
  @client.set_machine_encryption(encrypt_value, machine_id)
end

And /^I use keyless activation to activate same devices twice$/ do | table |
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end

  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?

  @new_clients =[]
  @clients =[] if @clients.nil?
  client = KeylessClient.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, nil, attr['machine_name'])
  client.activate_client_devices
  @license_key = client.license_key
  @new_clients << client
  @clients << client

  # active the same machine again
  client.client_devices_activate
  @new_clients << client
  @clients << client
end

When /^I use keyless activation to activate devices with (none machine hash|invalid machine hash|blank machine hash|none access token|error access token|wrong codename)$/  do |error_type, table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
    v.gsub!(" ", "_")
  end
  user_email = attr['user_name'].nil? ? @current_user[:email] : attr['user_name']
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id
  @user_password = CONFIGS['global']['test_pwd'] unless !@user_password.nil?

  machine_hash = nil
  if error_type == 'none machine hash'
    machine_hash = ''
  elsif error_type == 'blank machine hash'
    machine_hash = ' '
    #invalid machine hash with length > 40
  elsif error_type == 'invalid machine hash'
    machine_hash = 'invalidmachinehashabdafoier435gsgsgletw34nsgsdfgserttwer'
  end
  client = KeylessClient.new(user_email, @user_password, @current_partner[:id], partner_name, attr['machine_type'], @partner.partner_info.type, nil, nil, machine_hash, attr['machine_name'])
  if error_type == 'none access token'
    access_token = '{"access_token", ""}'
  elsif error_type == 'error access token'
    access_token = '{"access_token", "NzUwNjk0NDI4NGZkYWI1OGMzOTVlMzViNTlmMzNmN2M1YmExMjI3YzpwYXNzd29yZA=="}'
  end
  if error_type == 'wrong codename'
    codename = 'BrandingClient'
  end
  client.activate_client_devices(access_token, codename)
  @new_clients =[]
  @clients =[] if @clients.nil?
  @new_clients << client
  @clients << client
end

Then /^activate machine result should be$/ do |table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  attr = table.hashes.first
  expected_code = attr['code']
  expected_body = attr['body']
  #for negative case, the response could like:  #<Net::HTTPUnauthorized 401 Authorization Required readbody=true>
  begin
    @clients.last.response.code.should == expected_code
  rescue
    (@clients.last.response.to_s).match(/\d+/)[0].should == expected_code
  end


  actual_body = @clients.last.response.body
  if expected_body && expected_body.include?('machine license key')
    ((actual_body.match(/^\{"license_key":"(\w)+"\}$/)).nil?).should == false
  elsif expected_body
    actual_body.should == expected_body
  end
end

Then /^activate machine auth code result should be$/ do |table|
  attr = table.hashes.first.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  attr = table.hashes.first
  @clients.last.auth_code.each do |k,v|
    k.should ==attr['code']
    v.should ==attr['body']
  end
end

When /^I add machines for the user and update its used quota$/ do |table|
  header = table.headers.join('|')
  table.rows.each_with_index do |row, index|
    step %{I use keyless activation to activate devices}, table(%{
      |#{header}|
      |#{row.join('|')}|
    })
    step %{I get the machine_id by license_key}
    step %{I update the newly created machine used quota to #{table.hashes[index]['used_quota']}}
  end
end

When /^I activate the new user's (\d+) (Server|Desktop) device\(s\) and update used quota to (\d+) GB$/ do |times, device_type, quota|
  user_id = DBHelper.get_user_id_by_email @new_users[0].email
  DBHelper.create_machines(user_id, device_type, times, quota.to_i)
end

And /^activate the user's device with a key and with the default password$/ do
  @new_clients =[]
  @clients =[] if @clients.nil?
  client = Client.new(@key, @new_users.first.email, CONFIGS['global']['test_pwd'], @partner.company_info.name, @partner.partner_info.type)
  @new_clients << client
  @clients << client
end

When /^I use key activation to activate devices$/  do |table|
  # table is a | Machine1     | Desktop      |
  attr = table.hashes.first
  user_email = attr['email']||=@current_user[:email]
  partner_name = (@partner && @partner.company_info.name) || @current_partner[:name]
  @current_partner[:id] ||= @bus_site.admin_console_page.partner_id

  @new_clients =[]
  @clients =[] if @clients.nil?
  type = (@partner && @partner.partner_info.type)||@product_name
  client = Client.new(@key, user_email, @user_password, partner_name, type, attr['machine_name'])
  @new_clients << client
  @clients << client
end

When /^Activate key response should be (.+)$/  do |msg|
  @clients[0].resp.should include(msg)
end


#================================================
# Public : The method helps tester to create multiple users X multiple machines at back-end
#            1. If machine_count < devices, then machine_count.
#            2. When there is sub partner invovled, search user requires <partner_filter> filter so that the user could be serached. Otherwise, pass "nil".
#            Scope  : Used in mozyPro now.
# Params : machine_count - number of machines to create at back-end
#          partner_filter - <User Filter> on ui when acting as a partner having sub partners and filtering users
#          user_table - user info with the number of machines
# Example: And I add multiple users and use keyless activation to activate 3 device on each user, meanwhile selecting nil on partner filter:
#            | name                 | user_group            | storage_type | storage_limit | devices | enable_stash |
#            | 90002_PA_UG0_User1 | (default user group) |  Desktop     |  1              |  2       | Yes          |  <-- create 2 machines
#            | 90002_PA_UG1_User1 | 90002_PA_group1       |  Desktop     |  1              |  4       | Yes          |  <-- create 3 machines
# Notice : If the scenario begins at searching partner instead of creating partner, see below example -
#           Given I get the partners name TC.133059 and type MozyPro
#           When I add multiple users and use keyless activation to activate 3 device on each user, meanwhile selecting nil on partner filter:
#              | name                 | user_group            | storage_type | storage_limit | devices | enable_stash |
#              | 90002_PA_UG0_User1 | (default user group) |  Desktop     |  1              |  2        | Yes           |
#================================================
When /^I act as (MozyPro|MozyEnterprise) and create multiple users with (.+) device on each user by selecting (.+) on partner filter:$/ do |p_type, machine_count, partner_filter, user_table|
  Log.debug "======#{p_type}======"
  case p_type
    when "MozyPro" || "MozyEnterprise"
      Log.debug "=========creatring under mozyPro========"
      @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['add_new_user'])
      #======loop hash table to create each user and activate its machines======
      user_table.hashes.each do |hash|
        @new_users =[]
        @users =[]
        Log.debug "======create user " + hash["name"] + "======"
        hash['email'].replace ERB.new(hash['email']).result(binding) unless hash['email'].nil?
        hash['email'] = @existing_user_email if hash['email'] == '@existing_user_email'
        hash['email'] = @existing_admin_email if hash['email'] == '@existing_admin_email'
        user = Bus::DataObj::User.new
        hash_to_object(hash, user)
        @new_users << user
        @users << user
        @bus_site.admin_console_page.add_new_user_section.add_new_users(@new_users)
        #======search the user by the user name======
        @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_users'])
        if partner_filter == "nil"
          @bus_site.admin_console_page.search_list_users_section.search_user(@new_users.first.name)
        else
          @bus_site.admin_console_page.search_list_users_section.search_user(@new_users.first.name, '', partner_filter)
        end
        @bus_site.admin_console_page.search_list_users_section.wait_until_bus_section_load
        @bus_site.admin_console_page.search_list_users_section.view_user_details(@new_users.first.email[0..26])
        @current_user = @bus_site.admin_console_page.user_details_section.user #this is a required instance variable by API calling to activate device.
        #======update user password======
        Log.debug "Update the password with 'P@ssW0rD'"
        @user_password = "P@ssW0rD" #this is a required instances variable by API calling to activate device.
        @bus_site.admin_console_page.user_details_section.edit_password(@user_password)
        #======use keyless activation to activate devices======
        j = 0
        hash['deivces'].to_i < machine_count.to_i ? (j = hash['devices'].to_i) : (j = machine_count.to_i)
        #Log.debug "=============="
        #Log.debug j
        #Log.debug "=============="
        for i in 1..j
          Log.debug "======Start creating user at" + Time.now.getutc.to_s + "======"
          Log.debug "creating machine under #{@new_users.first.name}..."
          step %{I use keyless activation to activate devices newly}, table(%{
          | machine_name                          | machine_type                     | user_name                 |
          | #{@new_users.first.name}_machine_#{i} | #{@new_users.first.storage_type} | #{@new_users.first.email} |
          })
          #======Update <Ecrtyption> option on machine, otherwise, the replace is not allowed between machines======
          machine_id = @new_clients[0].machine_id
          @client.set_machine_encryption("Default", machine_id)
          Log.debug "======End creating user at" + Time.now.getutc.to_s + "======"
        end
        #this step is mandatory to close user detail section, otherwise, duplicated name UI elem make execution failed.
        @bus_site.admin_console_page.user_details_section.close_bus_section
      end #end of type=mozypro
    end

end



#==============================
#Author : Thomas Yu
#Comment: When beginning a scenario from searching partner instead of creating a partner, call this method to create some fake instance variables
#         which are required by the keyless devices activate API.
#Scope  : So far, work on mozyPro.
#==============================
And /^do preparation before using keyless activation to activate (MozyPro|MozyEnterprise|Reseller|MozyEnterprise DPS|OEM) devices$/ do |type|
  #======print the required parameter or objects required by the KeylessClient.new() method======
  Log.debug "current_partner info: #{@current_partner}"
  Log.debug "partner info: #{@partner}" unless @partner.nil?;
  Log.debug "partner.company_info.name info: #{@partner.company_info.name}" unless @partner.nil?;
  Log.debug "password : #{@user_password}"
  Log.debug "type : #{@partner.partner_info.type}" unless @partner.nil?;
  Log.debug "============================before/after============================"
  #==============================================================================================
  @partner = Bus::DataObj::MozyPro.new
  @partner.company_info.name = @current_partner[:name]
  @partner.partner_info.type = type
  #======print the required parameter or objects required by the KeylessClient.new() method======
  Log.debug "current_partner info: #{@current_partner}"
  Log.debug "partner info: #{@partner}"
  Log.debug "partner.company_info.name info: #{@partner.company_info.name}"
  Log.debug "password : #{@user_password}"
  Log.debug "type : #{@partner.partner_info.type}"
  #==============================================================================================
end
