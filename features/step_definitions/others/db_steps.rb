When /^I get a user email from the database$/ do
  @existing_user_email = DBHelper.get_user_email
  Log.debug("user email from database = #{@existing_user_email}")
end

When /^I get a (MH|MP|ME|MEO|MC) user username (|(.+) )from the database$/ do |parent,_,prefix|
  @existing_user_email = DBHelper.get_user_username(parent, prefix)
end

When /^I get an admin email from the database$/ do
  @existing_admin_email = DBHelper.get_admin_email
  Log.debug("admin email from database = #{@existing_admin_email}")
end

When /^I get a Mozy Home user email from the database$/ do
  @existing_user_email = DBHelper.get_mh_user_email
  Log.debug("Mozy Home user email from database = #{@existing_user_email}")
end

When /^I get the current user id from the database$/ do
  @user_name = @partner.admin_info.email    #need to determine other var that can use email
  @user_id = DBHelper.get_user_id_by_email @user_name
end

When /^I get the current admin id from the database$/ do
  @user_name = @partner.admin_info.email
  @user_id = DBHelper.get_admin_id_by_email @user_name
end

When /^I get user cybersource id from database$/ do
  @cybersource_id = DBHelper.get_mh_cybersource_id(@user_id)
  Log.debug("Currently the cybersource id of the user is = #{@cybersource_id}")
end

When /^I get a suspended user email from the database$/ do
  @existing_user_email = DBHelper.get_suspended_user_email
  Log.debug("Mozy Home suspended user email from database = #{@existing_user_email}")
end

When /^I get a deleted user email from the database$/ do
  @existing_user_email = DBHelper.get_deleted_user_email
  Log.debug("Mozy Home deleted user email from database = #{@existing_user_email}")
end

When /^The( subpartner)? (user|admin|user and admin) password policy from (database|rails console) will be$/ do |sub, type, db, table|
  Log.debug "partner id is #{@partner_id}"
  type = 'all' if type == 'user and admin'
  if db == 'database'
    raise 'You cannot get password policy from database' unless sub.nil?
    password_policy = DBHelper.get_db_password_config(@partner_id, type)
  else
    password_policy = SSHHelper.get_ssh_password_config(@partner_id, type)
  end
  @password_policy_id = password_policy['id'].to_i
  table.hashes.first.each do |k, v|
    password_policy[k].should == v
  end
end

Then /^The (user|admin) should use default password policy$/ do |type|
  DBHelper.get_db_password_config(@partner_id, type).nil?.should be_true
  DBHelper.get_db_password_config(@partner_id, 'all').nil?.should be_true
end

Then /^The (user|admin|user and admin) password will contains at least (\d+) of the following types of charactors$/ do |type, num, table|
  character_classes = DBHelper.get_password_character_classes(@password_policy_id)
  (character_classes.size >= num.to_i).should be_true
  character_classes.each do |character|
    table.headers.include?(character).should be_true
  end
end

Then /^I get customcd order id from database for data shuttle order$/ do
  @customcd_order_id = DBHelper.get_customcd_order_id(@seed_id)
  Log.debug("Customcd Order Id of Data Shuttle Order #{@seed_id} is #{@customcd_order_id}")
end

And /^I set customcd order id to (.+) for just created data shuttle order$/ do |change_to_id|
  DBHelper.update_customcd_order_id(@seed_id,change_to_id)
end

And /^I get partner id by admin email from database$/ do
  @partner_id = DBHelper.get_partner_id_by_admin_email @partner.admin_info.email
  Log.debug("partner id is #{@partner_id}")
end

And /^The admin's IP address should be stored in demeter$/ do
  @partner_id = DBHelper.get_partner_id_by_admin_email @partner.admin_info.email
  DBHelper.get_partner_admin_ip(@partner_id).nil?.should == false
end

When /^I delete the current user_payment_infos from the database$/ do
  Log.debug DBHelper.delete_upi_by_id @user_id
end

And /^I get admin id of current partner from the database$/ do
  @admin_id = (DBHelper.get_info_from_admins(@partner.admin_info.email))[0]
  Log.debug("admin id is #{@admin_id}")
end

And /^I delete dialects of current partner from database$/ do
  # check if current partner is bds. Dialects of bds partner should not be deleted
  (DBHelper.get_pro_partner_table(@partner_id)['company_type'] != 'bds').should be_true
  DBHelper.delete_dialects_by_partner_id @partner_id
end
