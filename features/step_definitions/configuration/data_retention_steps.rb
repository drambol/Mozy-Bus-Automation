Then /^default adr policy should be:$/ do |table|
  adr_policy = table.hashes.first

  @bus_site.admin_console_page.data_retention_section.get_adr_policy
  adr_policy['partner adr'].should == expected_lock_value unless adr_policy['partner'].nil?
  adr_policy['default user group adr'].should == expected_lock_value unless adr_policy['default user group adr'].nil?
  adr_policy['sub partner adr'].should == expected_lock_value unless adr_policy['sub partner adr'].nil?
end

Then /^partner adr policy should be (.+)/ do |policy|
  @bus_site.admin_console_page.data_retention_section.get_partner_adr_policy.should == policy
end

Then /^user group adr policy should be:$/ do |policy|
  attributes = policy.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.data_retention_section.user_group_adr_policy_table_hashes
  expected = policy.rows
  actual.should == expected
end

Then /^sub partner adr policy should be:$/ do |policy|
  attributes = policy.hashes.first
  attributes.each do |k,v|
    v.replace ERB.new(v).result(binding)
  end
  actual = @bus_site.admin_console_page.data_retention_section.sub_partner_adr_policy_table_hashes
  expected = policy.rows
  actual.should == expected
end

Then /^I should see (.+) in sub partner adr policy list$/ do |message|
  @bus_site.admin_console_page.data_retention_section.sub_partner_adr_policy_table_text.should include(message)
end

When /^I click partner adr policy$/ do
  @bus_site.admin_console_page.data_retention_section.click_partner_adr_policy
end

When /^I set adr policy to (.+)$/ do |policy|
  @bus_site.admin_console_page.data_retention_section.create_adr_policy(policy, QA_ENV['bus_password'])
end

Then /^Change ADR Policy section message should be (.+)/ do |message|
  @bus_site.admin_console_page.data_retention_section.messages.should == message
end

When /^I refresh Data Retention section$/ do
  @bus_site.admin_console_page.data_retention_section.refresh_bus_section
end

Then /^ADR policy in DB for partner is (.+)$/ do |adr_policy_name|
  partner_adr = DBHelper.get_partner_adr_policy_name(@partner_id)

  if adr_policy_name == "nil"
    partner_adr.should == nil
  else
    partner_adr.should == adr_policy_name
  end

end

Then /^ADR policy in DB for all user groups are nil$/ do
  user_groups_adr = DBHelper.get_user_groups_adr_from_partner(@partner_id)
  user_groups_adr.each do |adr|
    adr.should == nil
  end
end

When /^I click user group (.+) adr policy$/ do |user_group|
  @bus_site.admin_console_page.data_retention_section.click_user_group_adr_policy(user_group)
end

Then /^ADR policy in DB for user group (.+) is (.+)$/ do |user_group, adr_policy_name|
  user_groups_adr = DBHelper.get_user_group_adr_policy_name(@partner_id, user_group)

  if adr_policy_name == "nil"
    user_groups_adr.should == nil
  else
    user_groups_adr.should == adr_policy_name
  end

end

Then /^adr policy name should be (.+)$/ do |adr_policy_name|
  @bus_site.admin_console_page.data_retention_section.get_adr_policy_name.should == adr_policy_name
end

Then /^available adr policy names should be:$/ do |policy_name|
  @bus_site.admin_console_page.data_retention_section.available_policy_names.should == policy_name.rows.flatten
end

Then /^available adr policy values should be:$/ do |policy_name|
  @bus_site.admin_console_page.data_retention_section.available_policy_values.should == policy_name.rows.flatten
end

Then /^the record from adr_jobs table for main job (.+) should be:$/ do |type, table|
  if type == "partner"
    actual = DBHelper.get_main_adr_jobs(@partner_id)
  elsif type == "user group"
    actual = DBHelper.get_main_adr_jobs(@user_group_id)
  end

  @main_job_id = actual[0][0]
  expected = table.raw

  expected.each_index { |index|
    expected[index].each_index { |key|

      expected[index][key] = ERB.new(expected[index][key]).result(binding)

      case key
        when 0
          (actual[index][key].match(/^\d+$/).nil?).should == false
        when 4
          (Time.at(actual[index][key].to_i) - 3*24*60*60).utc.to_s.should include(Chronic.parse(expected[index][key]).utc.strftime("%F"))
        when 5,10,11
          actual[index][key].should == nil
        when 8
          with_timezone("Mountain Time (US & Canada)") do
            puts Chronic.parse(expected[index][key])
            puts Chronic.parse(expected[index][key]).strftime("%F")
            actual[index][key].to_s.should include(Chronic.parse(expected[index][key]).strftime("%F"))
          end
        when 9
          with_timezone("Mountain Time (US & Canada)") do
            puts Chronic.parse(expected[index][key]).strftime("%F")
            actual[index][key].to_s.should include(Chronic.parse(expected[index][key]).strftime("%F"))
          end
        else
          actual[index][key].should == expected[index][key]
      end

    }
  }

end

When /^I get user group id for user group (.+)$/ do |user_group|
  @user_group_id = DBHelper.get_user_group_id(@partner_id, user_group)
end

Then /^the record from adr_jobs table for sub job user group (.+) should be:$/ do |user_group, table|
  actual = DBHelper.get_sub_adr_jobs(@main_job_id)
  expected = table.raw

  expected.each_index { |index|
    expected[index].each_index { |key|

      expected[index][key] = ERB.new(expected[index][key]).result(binding)

      case key
        when 0
          (actual[index][key].match(/^\d+$/).nil?).should == false
        # when 2
        #   actual[index][key].should == DBHelper.get_user_group_id(@partner_id, user_group)
        when 4
          (Time.at(actual[index][key].to_i) - 3*24*60*60).utc.to_s.should include(Chronic.parse(expected[index][key]).utc.strftime("%F"))
        when 10,11
          actual[index][key].should == nil
        when 8
          with_timezone("Mountain Time (US & Canada)") do
            puts Chronic.parse(expected[index][key])
            puts Chronic.parse(expected[index][key]).strftime("%F")
            actual[index][key].to_s.should include(Chronic.parse(expected[index][key]).strftime("%F"))
          end
        when 9
          with_timezone("Mountain Time (US & Canada)") do
            puts Chronic.parse(expected[index][key]).strftime("%F")
            actual[index][key].to_s.should include(Chronic.parse(expected[index][key]).strftime("%F"))
          end
        else
          actual[index][key].should == expected[index][key]
      end

    }
  }
end


When /^I set adr policy (.+) but click cancel$/ do |policy|
  @bus_site.admin_console_page.data_retention_section.create_but_cancel_adr_policy(policy, QA_ENV['bus_password'])
end

And /^I try to set adr policy to (.+) but input invalid password (.+)$/ do |adr_policy_name, password|
  @bus_site.admin_console_page.data_retention_section.create_adr_policy(adr_policy_name, password)
end

And /^I close opened data retention section$/ do
  @bus_site.admin_console_page.data_retention_section.close_data_retention_section
end

When /^I click button to invoke adr popup dialog$/ do
  @bus_site.admin_console_page.data_retention_section.click_adr_policy_popup_button
end

When /^I click sub partner (.+) adr policy$/ do |sub_partner|
  @bus_site.admin_console_page.data_retention_section.click_sub_partner_adr_policy(sub_partner)
end

When /^I get (partner|user group)'s (.+) adr job id$/ do |bus_object, object_id_or_name|
  case bus_object
  #======make sure you could search the partner/sub partner under current parent partner/root=======
  when "partner"
    if @partner_id.nil?
      step %{I navigate to Search / List Partners section from bus admin console page}
      step %{I search partner by:}, table(%{
        | name                 |
        | #{object_id_or_name} |
      })
      step %{I view partner details by #{object_id_or_name}}
      step %{I get the partner_id}
    end
    @adr_job = DBHelper.get_main_job_id(@partner_id)
  #======make sure you could search the user group under current partner======
   when "user group"
    Log.debug "user group name is: #{object_id_or_name}"
    step %{I view user group details by name: #{object_id_or_name}}
    @user_group_id = @bus_site.admin_console_page.user_group_details_section.group_details_hash["ID:"]
    Log.debug "user group id is: #{@user_group_id}"
    @adr_job = DBHelper.get_main_job_id(@user_group_id)
  end
end

Then /^adr job is (empty|not empty)$/ do |empty|
  if empty == "empty"
    @adr_job.should == nil
  end
end

#====================================
# Call: Then I get machine details info to get @machine_info hashtable
#====================================
Then /^ADR policy in DB for device is (.+)$/ do |adr_policy_name|
  user_groups_adr = DBHelper.get_device_adr_policy_name_by_device_id(@machine_info['ID:'])

  if adr_policy_name == "nil"
    user_groups_adr.should == nil
  else
    user_groups_adr.should == adr_policy_name
  end
end

#====================================
# Call: And I get the user id
#====================================
Then /^ADR policy in DB for (deleted|existing) device (.+) is (.+)$/ do |del_ex, device_name, adr_policy_name|
  user_groups_adr = DBHelper.get_device_adr_policy_name_by_user_id_and_device_name(del_ex, @user_id, device_name)

  if adr_policy_name == "nil"
    user_groups_adr.should == nil
  else
    (user_groups_adr == adr_policy_name || user_groups_adr == nil).should be_true
  end
end