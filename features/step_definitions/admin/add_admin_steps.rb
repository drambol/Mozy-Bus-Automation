When /^I add a new admin(| newly):$/ do |type, table|
  table.hashes.first.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  @new_admins = []
  @admins = [] if @admins.nil?
  @admins = [] if type.include?('newly')

  admin_hash = table.hashes.first
  # get roles array values
  admin_hash['Roles'] = @role.name if admin_hash['Roles'] =='@role_name'
  if admin_hash['Roles'].nil?
    roles = []
  else
    roles = admin_hash['Roles'].split(',')
  end
  # get email value
  admin_hash['Email'] = @existing_user_email if admin_hash['Email'] == '@existing_user_email'
  admin_hash['Email'] = @existing_admin_email if admin_hash['Email'] == '@existing_admin_email'
  # get user group array values
  if admin_hash['User Group'].nil?
    user_groups = []
  else
    user_groups = admin_hash['User Group'].split(',')
  end

  admin_hash_new = Hash.new
  admin_hash.each do |k,v|
    if k == 'User Group'
      admin_hash_new['user_groups']= user_groups
    elsif k == 'Roles'
      admin_hash_new['roles']= roles
    else
      admin_hash_new[k.downcase]= v
    end
  end
  @admin = Bus::DataObj::Admin.new(admin_hash_new['name'], admin_hash_new['email'], admin_hash_new['parent'], user_groups, roles)
  hash_to_object(admin_hash_new, @admin)
  @new_admins << @admin
  @admins << @admin
  @bus_site.admin_console_page.add_new_admin_section.add_new_admin(@admin)
  @bus_site.admin_console_page.add_new_admin_section.wait_until_bus_section_load
end

When /^I refresh Add New Admin section$/ do
  @bus_site.admin_console_page.add_new_admin_section.refresh_bus_section
end

When /^I refresh Search Admins section$/ do
  @bus_site.admin_console_page.search_admins_section.refresh_bus_section
end

Then /^I should see capabilities in Admin Console panel$/ do |table|
  # table is a | Search / List Partners |pending
  data = table.raw[1..-1]
  data.each do | d |
    @bus_site.admin_console_page.has_navigation?(d[0]).should_not be_nil
  end
end

When /^I search admin by:$/ do |search_key_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_admin'])
  attributes = search_key_table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  attributes['email'] = @existing_user_email if attributes['email'] == '@existing_user_email'
  attributes['email'] = @existing_admin_email if attributes['email'] == '@existing_admin_email'
  attributes['email'] = @admin.email if attributes['email'] == '@admin_email'
  keywords = attributes["name"] || attributes["email"]|| attributes["keywords"]
  @bus_site.admin_console_page.search_admins_section.search_admin(keywords)
end

When /^I act as admin by:$/ do |table|
  # table is a | leongh+atc695@mozy.com |pending
  step %{I search admin by:}, table(%{
    |#{table.headers.join('|')}|
    |#{table.rows.first.join('|')}|
  })

  attributes = table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  attributes["email"] = attributes["email"].slice(0, 27) unless attributes["email"].nil?
  page.find_link(attributes["email"] || attributes["name"]).click
  @current_partner = @bus_site.admin_console_page.admin_details_section.partner
  @bus_site.admin_console_page.admin_details_section.act_as_admin
  wait_until { @bus_site.admin_console_page.has_stop_masquerading_link? }
end

When /^I act as latest created admin$/ do
  step %{I act as admin by:}, table(%{
    | email           |
    | #{@admin.email} |
  })
end

When /^(I|Ldap admin) delete admin by:$/ do |type, table|
  step %{I search admin by:}, table(%{
    |#{table.headers.join('|')}|
    |#{table.rows.first.join('|')}|
  })

  attributes = table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  attributes['email'] = @existing_user_email[0..26] if attributes['email'] == '@existing_user_email'
  attributes['email'] = @existing_admin_email[0..26] if attributes['email'] == '@existing_admin_email'
  attributes['email'] = @admin.email[0..26] if attributes['email'] == '@admin_email'
  password = attributes['password'] || QA_ENV['bus_password']
  page.find_link(attributes["email"].slice(0, 27) || attributes["name"]).click
  if type == 'I'
    @bus_site.admin_console_page.admin_details_section.delete_admin(password)
    step "I navigate to Search Admins section from bus admin console page"
    @bus_site.admin_console_page.search_admins_section.refresh_bus_section
  else
    @bus_site.admin_console_page.admin_details_section.ldap_admin_delete_admin
  end
end

When /^I delete lastest created admin$/ do
  step %{I delete admin by:}, table(%{
    | email           |
    | #{@admin.email} |
  })
end

When /^I list partner details for a partner in partner list$/ do
  # get the 1st partner in the list
  partner_link = @bus_site.admin_console_page.find(:xpath, "//div[@id = 'partner-list-content']/div/table/tbody//a")
  partner_link.click
  @bus_site.admin_console_page.partner_details_section.wait_until_bus_section_load
end

When /^I (can|cannot) change partner name$/ do | c |
  case c
    when "can"
      @bus_site.admin_console_page.has_navigation?("Change Name").should be_true
    when "cannot"
      @bus_site.admin_console_page.has_navigation?("Change Name").should be_false
    else

  end
end

When /^I can delete partner$/ do
  @bus_site.admin_console_page.partner_details_section.find(:xpath, "//a[text() = 'Delete Partner']").should_not be_nil
end

When /^I can change fields:$/ do |table|
  # table is a | External ID |pending
  data = table.raw[1..-1]
  general_info_hash = @bus_site.admin_console_page.partner_details_section.general_info_hash
  data.each do | d |
    general_info_hash[d[0]].should include('change')
  end
end

Then /^I can edit partner details fields:$/ do |table|
  # table is a | Phone  |pending
  # table is a | External ID |pending
  @bus_site.admin_console_page.partner_details_section.expand_contact_info
  data = table.raw[1..-1]
  data.each do | d |
    case d[0]
      when "Phone:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_contact_phone").should_not be_nil
      when "Industry:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_industry").should_not be_nil
      when "# of employees:"
        @bus_site.admin_console_page.partner_details_section.find(:id, "partner_num_employees").should_not be_nil
      else
        # Need to implement the ones you want to check existance
    end
  end
end


When /^I delete partner account with password (.+)$/ do | pw |
  warning_msg = @bus_site.admin_console_page.partner_details_section.delete_partner(pw, false)
  warning_msg.should include("Incorrect password.")
end

Then /^Add New Admin success message should be displayed$/ do
  @bus_site.admin_console_page.add_new_admin_section.messages.should == "New Admin created. Please have the Admin check his or her email to complete the process."
end

When /^Add New Admin error message should be:$/ do |messages|
  @bus_site.admin_console_page.add_new_admin_section.messages.should == messages.to_s
end

When /^I view admin details by:$/ do |table|
    step %{I search admin by:}, table(%{
      |#{table.headers.join('|')}|
      |#{table.rows.first.join('|')}|
    })

  attributes = table.hashes.first
  attributes['name'].replace ERB.new(attributes['name']).result(binding) unless attributes['name'].nil?
  attributes['email'].replace ERB.new(attributes['email']).result(binding) unless attributes['email'].nil?
  if attributes['email'] == '@admin_email'
    attributes['email'] = @admin.email[0..26]
  elsif !attributes['email'].nil?
    attributes['email'] = attributes['email'][0..26]
  end
  page.find_link(attributes["email"] || attributes["name"]).click
end

When /^I save the admin email as existing admin email$/ do
  @existing_admin_email = @admin.email
end

And /^I get the admin id for admin (.+) from admin details$/ do |index|
  @admins[index.to_i].id = @bus_site.admin_console_page.admin_details_section.admin_id
end

And /^I get the action record from db table action_audits$/ do |table|
  attributes = table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  if attributes['effective_admin_id'].nil?
    admin_id = attributes['actual_admin_id']
    type = 'actual'
  else
    admin_id = attributes['effective_admin_id']
    type = 'effective'
  end
  @action_audits_record = DBHelper.get_action_audits(attributes['action name'],admin_id,type)
end

Then /^the record from action_audits table should be$/ do |table|
  attributes = table.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  @action_audits_record[5].should == attributes['effective_admin_type']
  @action_audits_record[4].to_s.should == attributes['actual_admin_id']
  @action_audits_record[3].should == attributes['effective_admin_type']
  #'id' is sequential number
  (@action_audits_record[0].to_s.match(/^\d+$/).nil?).should == false
end

And /^the record from model_audits table should be$/ do |table|
  attributes = table.hashes.first
  attributes['be_changed_admin_email'].replace ERB.new(attributes['be_changed_admin_email']).result(binding)
  model_record = DBHelper.get_model_audits(@action_audits_record[0])
  admin_info = DBHelper.get_info_from_admins(attributes['be_changed_admin_email'])
  # record id
  record_id = admin_info[0]
  password_hash = admin_info[1]
  (model_record[0].to_s.match(/^\d+$/).nil?).should == false
  model_record[2].should == attributes['column_name']
  model_record[3].should == attributes['table_name']
  model_record[4].should == record_id
  model_record[7].should == attributes['action']

  # 'changed_from' is the old 'passwordhash',  'changed_to' is new 'passwordhash'
  model_record[6].should == password_hash
  (model_record[5]== model_record[6]).should == false
  model_record[5].length.should == model_record[6].length
end

And /^There is no model audits record for this action_audits action$/ do
  model_record = DBHelper.get_model_audits(@action_audits_record[0])
  model_record.size.should == 0
end

When /^I search and delete admin (.+)$/ do |admin_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_admin'])
  @bus_site.admin_console_page.search_admins_section.search_admin(admin_name)
  @bus_site.admin_console_page.search_admins_section.view_admin_detail(admin_name)
  @bus_site.admin_console_page.admin_details_section.delete_admin(QA_ENV['bus_password'])
end


