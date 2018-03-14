
Then /^I edit (.+) passowrd policy:$/ do |account_type,policy_table|
  attributes = policy_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
  end
  @password_policy = Bus::DataObj::PasswordPolicy.new
  case account_type
    when 'user'
      @password_policy.user_policy_type = attributes["user policy type"] unless attributes["user policy type"].nil?
      @password_policy.user_policy_min_length = attributes["min length"] unless attributes["min length"].nil?
      @password_policy.user_min_character_classes = attributes["min character classes"] unless attributes["min character classes"].nil?
      @password_policy.user_character_classes = attributes["character classes"].split(',') unless attributes["character classes"].nil?
      @password_policy.user_max_failure_per_username = attributes["max failures per username"] unless attributes["max failures per username"].nil?
      @password_policy.user_failure_period_per_username = attributes["failure period per username"] unless attributes["failure period per username"].nil?
      @password_policy.user_lockout_duration_per_username = attributes["lockout duration per username"] unless attributes["lockout duration per username"].nil?
      @bus_site.admin_console_page.edit_password_policy_section.edit_user_password_policy(@password_policy)
    when 'admin'
      @password_policy.admin_user_same_policy = attributes["admin user same policy"] unless attributes["admin user same policy"].nil?
      @password_policy.admin_policy_type = attributes["admin policy type"] unless attributes["admin policy type"].nil?
      @password_policy.admin_policy_min_length = attributes["min length"] unless attributes["min length"].nil?
      @password_policy.admin_min_character_classes = attributes["min character classes"] unless attributes["min character classes"].nil?
      @password_policy.admin_character_classes = attributes["character classes"].split(',') unless attributes["character classes"].nil?
      @bus_site.admin_console_page.edit_password_policy_section.edit_admin_password_policy(@password_policy)
  end
end

Then /^user password policy should be:$/ do |policy_table|
  attributes = policy_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
  end
  @password_policy = Bus::DataObj::PasswordPolicy.new

  @password_policy.user_policy_type = attributes["user policy type"] unless attributes["user policy type"].nil?
  @password_policy.user_policy_min_length = attributes["min length"] unless attributes["min length"].nil?
  @password_policy.user_min_character_classes = attributes["min character classes"] unless attributes["min character classes"].nil?
  @password_policy.user_character_classes = attributes["character classes"].split(',') unless attributes["character classes"].nil?
  @bus_site.admin_console_page.edit_password_policy_section.verify_user_password_policy(@password_policy)
end

Then /^I save password policy$/ do
  @bus_site.admin_console_page.edit_password_policy_section.save_policy
  @bus_site.admin_console_page.edit_password_policy_section.wait_until_bus_section_load
end

Then /^Password policy updated successfully$/ do
  @bus_site.admin_console_page.edit_password_policy_section.message == 'Password policy updated successfully'
end

#if going to clear Max age , using 'I update Max age to unlimited days'
Then /^I update Max age to (.+) days$/ do |days|
  @bus_site.admin_console_page.edit_password_policy_section.update_max_age(days)
  @bus_site.admin_console_page.edit_password_policy_section.save_policy
  @bus_site.admin_console_page.edit_password_policy_section.wait_until_bus_section_load
end


Then /^admin password policy should(| not) be same as user password policy$/ do | same |
  is_same = @bus_site.admin_console_page.edit_password_policy_section.is_admin_same_as_user_policy

  if same == ' not'
    is_same.should == false
  else
    is_same.should == true
  end
end