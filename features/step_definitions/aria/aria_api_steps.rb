When /^API\* I get Aria account details by (.+)$/ do |aria_id|
  @aria_acc_details = AriaApi.get_acct_details_all({:acct_no=> aria_id.to_i})
end

Then /^API\* Aria account billing info should be:$/ do |info_table|
  expected = info_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'contact name'
        "#{@aria_acc_details['billing_first_name']} #{@aria_acc_details['billing_last_name']}".should == expected[header]
      when 'company name'
        @aria_acc_details['billing_company_name'].should == expected[header]
      when 'address'
        @aria_acc_details['billing_address1'].should == expected[header]
      when 'city'
        @aria_acc_details['billing_city'].should == expected[header]
      when 'country'
        @aria_acc_details['billing_country'].should == expected[header]
      when 'state'
        @aria_acc_details['billing_state'].should == expected[header]
      when 'zip'
        @aria_acc_details['billing_zip'].should == expected[header]
      when 'phone'
        @aria_acc_details['billing_intl_phone'].should == expected[header]
      when 'email'
        @aria_acc_details['billing_email'].should == expected[header]
      when 'partner name'
        @aria_acc_details['company_name'].should == expected[header]
      else
        raise 'Unknown billing information'
    end
  end
end

Then /^API\* Aria account credit card info should be:$/ do |info_table|
  expected = info_table.hashes.first
  expected.keys.each do |header|
    case header
      when 'payment type'
        @aria_acc_details['pay_method_name'].should == expected[header]
      when 'last four digits'
        @aria_acc_details['cc_suffix'].should == expected[header]
      when 'expire month'
        @aria_acc_details['cc_expire_mm'].should == expected[header]
      when 'expire year'
        @aria_acc_details['cc_expire_yyyy'].should == expected[header]
      else
        raise 'Unknown credit card information'
    end
  end
end

#This is a universal Aria API Checker
Then /API\* Aria account should be:/ do |info_table|
  step "API* I get Aria account details by newly created partner aria id"
  expected = info_table.hashes.first
  expected.keys.each do |header|
    #Log.debug("Aria API Check, Key = #{header}: Expected = \"#{expected[header]}\", Aria = \"#{ @aria_acc_details[header]}\"")
    if @aria_acc_details.has_key?(header)
      expected[header] = nil if expected[header] == "" || expected[header] == "nil"
      @aria_acc_details[header].should == expected[header]
    else
      raise "Unknown Aria Key: \"#{header}\""
    end
  end

  #List of Aria API Keys - So you can check anything
  # "first_name", "mi", "last_name", "userid", "birthdate", "job_title", "salutation",
  # "senior_acct_no", "client_acct_id", "resp_level_cd", "is_test_acct", "alt_email",
  # "address1", "address2", "city", "state_prov", "locality", "postal_code", "country",
  # "company_name", "cell_phone_npa", "cell_phone_nxx", "cell_phone_suffix", "fax_phone",
  # "intl_cell_phone", "intl_phone", "phone_extension", "phone_npa", "phone_nxx", "phone_suffix",
  # "work_phone", "work_phone_extension", "work_phone_npa", "work_phone_nxx", "work_phone_suffix",
  # "bill_day", "created", "date_to_expire", "date_to_suspend", "last_arrears_bill_thru_date",
  # "last_bill_date", "last_bill_thru_date", "next_bill_date", "plan_date", "status_date",
  # "status_degrade_date", "status_cd", "status_label", "plan_no", "plan_name", "plan_units",
  # "notify_method", "notify_method_name", "PASSWORD", "pin", "secret_question",
  # "secret_question_answer", "pay_method", "pay_method_name", "currency_cd", "tax_id",
  # "billing_email", "billing_first_name", "billing_middle_initial", "billing_last_name",
  # "billing_address1", "billing_address2", "billing_city", "billing_state", "billing_locality",
  # "billing_zip", "billing_country", "cc_suffix", "cc_expire_mm", "cc_expire_yyyy", "cc_id",
  # "bank_acct_suffix", "bank_routing_no", "billing_cell_phone", "billing_cell_phone_npa",
  # "billing_cell_phone_nxx", "billing_cell_phone_suffix", "billing_company_name",
  # "billing_intl_phone", "billing_phone_extension", "billing_phone_npa", "billing_phone_nxx",
  # "billing_phone_suffix", "billing_work_phone", "billing_work_phone_extension",
  # "billing_work_phone_npa", "billing_work_phone_nxx", "billing_work_phone_suffix", "balance",
  # "acct_create_client_receipt_id", "plan_client_receipt_id", "status_client_receipt_id",
  # "taxpayer_id", "promo_cd", "error_code", "alt_msg_template_no", "address3", "billing_address3",
  # "seq_func_group_no", "address_verification_code", "address_match_score",
  # "billing_address_verification_code", "billing_address_match_score", "error_msg",
end

When (/^API\\\* I get aria client defined field data by (.+)$/) do |aria_id|
  # returns value of user defined fields in hash
  #   [{"field_name"=>"Channel", "field_value"=>"ISS"}, {"field_name"=>"Subsidiary", "field_value"=>"Mozy Inc. (US)"}]
  @aria_supp_fields = AriaApi.get_acct_supp_fields({:acct_no=> aria_id})
end

Then (/^API\\\* Aria client defined field data should be:$/) do |client_defined_fields|
  # | Channel | ISS | Subsidiary | Mozy Inc. (US) |
  # table is a Cucumber::Ast::Table
  expected_values = client_defined_fields.hashes

  r = []
  @aria_supp_fields["supp_fields"].each {|item| r << item.values }
  actual = Hash[r]

  expected_values.each do |key, value|
    actual[key].should == value
  end
end

When /^API\* I change the Aria account status by (.+) to (.+)$/ do |aria_id, status_cd|
  @aria_acc_details = AriaApi.update_acct_status({:account_no=> aria_id.to_i, :status_cd=> status_cd.to_i})
end

When /^API\* I assign the Aria account by (.+) to collections account group (.+)$/ do |aria_id, group_no|
  # Since the group no are different between qa env and ops env, we need to do the convert automatically
  #if TEST_ENV == 'std' || 'pantheon'
  if (TEST_ENV == "std") || (TEST_ENV == "pantheon")
    Log.debug 'Convert the group number'
    group_no = "10039699" if group_no == "10030097"
    group_no = "10026101" if group_no == "10026095"
  end
  Log.debug "group no is #{group_no}"
  @aria_acc_groups_assigned_response = AriaApi.assign_collections_acct_group({:acct_no=> aria_id.to_i, :group_no=> group_no})
end

When /^API\* I get the list of account groups for (.+)$/ do |aria_id|
  @aria_acc_groups = AriaApi.get_acct_groups_by_acct({:acct_no=> aria_id.to_i})
end

When /^API\* Aria tax exempt status for (.+) should be (.+)$/ do |aria_id, tax_status|
  @aria_acc_tax_exempt_status = AriaApi.get_acct_tax_exempt_status({:acct_no=> aria_id.to_i})
  @aria_acc_tax_exempt_status["exemption_level_desc"].should == tax_status
end

When /^API\* I change the Aria tax exemption level for (.+) to (.+)$/ do |aria_id, exemption_level|
  @aria_acc_tax_exempt_level = AriaApi.set_acct_tax_exempt_status({:acct_no=> aria_id.to_i, :exemption_level=> exemption_level})
end

Then /^API\* I set (.+) account notification method to (.+)$/ do |aria_id, notification_method |
  @aria_notification_method = AriaApi.update_acct_notify_method({:account_no=> aria_id.to_i, :notify_method=> notification_method})
end

Then /^API\* I set (.+) account contact to:$/ do |aria_id, acct_contact_table |
  acct_contact_info = acct_contact_table.hashes.first
  acct_contact_info["account_no"] = aria_id.to_i
  @aria_acct_contact_method = AriaApi.update_acct_contact(acct_contact_info)
end

Then /^API\* Aria account plans for (.+) should be:$/ do |aria_id, info_table|
  actual = AriaApi.get_acct_plans_all({:acct_no=> aria_id.to_i})
  expected = info_table.hashes
  expected.each_index{ |index| expected[index].keys.each{ |key| actual['all_acct_plans'][index][key].to_s.should == expected[index][key]} }
end

When(/^API\* I replace aria supplemental units plans for (.+)$/) do |aria_id, table|
  ##param plan_name and plan_units only
  @new_plan = table.hashes
  #get current supplemental plan
  @current_plan_info = AriaApi.get_acct_plans_all({:acct_no=> aria_id.to_i})
  #find plan num based on plan name
  @current_plan_info['all_acct_plans'].each_index do |i|
    #loop through through each account plan
    @new_plan.each_index do |n|
      #loop through each new plan and compare
      if @current_plan_info['all_acct_plans'][i]['plan_name'] == @new_plan[n]['plan_name']
        #modify the plan units
        supp_plan_no = @current_plan_info['all_acct_plans'][i]['plan_no']
        @aria_supp_plans = AriaApi.modify_supp_plan(:acct_no=> aria_id.to_i, :supp_plan_no=> supp_plan_no, :num_plan_units=> @new_plan[n]['num_plan_units'])
      end
    end
  end

end

When /^API\* The Aria account (.+) payment amount should be (.+)$/ do |aria_id, amount|
  transaction_id = AriaApi.get_acct_trans_history({:account_no=> aria_id.to_i})['history'][0]['transaction_id']
  @aria_acc_details = AriaApi.get_payment_applications({:acct_no=> aria_id.to_i,:src_transaction_id=>transaction_id.to_i})['payment_applications'][0]['amount'].to_s.should == amount
end

When /^API\* There is no refunds for aria account (.+)$/ do |aria_id|
  AriaApi.get_refund_details({:acct_no=> aria_id.to_i})['refund_details'].should be nil
end

When /^API\* I change aria supplemental plan for (.+)$/ do |aria_id, info_table|
  new_plan_rate = info_table.hashes
  # get current supplemental plan
  current_plan_info = AriaApi.get_acct_plans_all({:acct_no=> aria_id.to_i})
  acct_plans = current_plan_info['all_acct_plans']
  @return_values = []

  new_plan_rate.each_with_index {|v,_|
    plan_name = v['plan_name']
    new_rate_schedule = v['rate_schedule_name']
    new_currency = v['schedule_currency']
    num_plan_units = v['num_plan_units']

    # find plan num based on given plan name
    acct_plans.each_index { |n|
      flag = false
      if acct_plans[n]['plan_name'] == plan_name
        supp_plan_no = acct_plans[n]['plan_no']
        # get all the rate schedules for the given plan
        rate_sched = AriaApi.get_rate_schedules_for_plan({ "plan_no" => supp_plan_no.to_i })

        # find matching schedule rate and change to it
        rate_sched['rate_sched'].each_with_index { |val, _|
          if val['schedule_name'] == new_rate_schedule && val['schedule_currency'] == new_currency
            rate_schedule_no = val['schedule_no']
            if num_plan_units.nil?
              result = AriaApi.modify_supp_plan(:acct_no=> aria_id.to_i, :supp_plan_no=> supp_plan_no, :alt_rate_schedule_no=> rate_schedule_no)
            else
              result = AriaApi.modify_supp_plan(:acct_no=> aria_id.to_i, :supp_plan_no=> supp_plan_no, :alt_rate_schedule_no=> rate_schedule_no, :num_plan_units=> num_plan_units.to_i)
            end
            @return_values << result
            flag = true
            break
          end
        }
      end
      break if flag
    }
  }
end

When /^API\* I get (all )?aria plan for (.+)$/ do |all, aria_id|
  if all.nil?
    current_plan_info = AriaApi.get_acct_plans({:acct_no=> aria_id.to_i})
    @aria_plan = current_plan_info['acct_plans']
  else
    current_plan_info = AriaApi.get_acct_plans_all({:acct_no=> aria_id.to_i})
    @aria_plan_all = current_plan_info['all_acct_plans']
  end
end

When /^API\* I get supplemental field (.+) for (.+)$/ do |field_name, aria_id|
  # values would like: {"error_code"=>0, "error_msg"=>"OK", "supp_field_values"=>["Mozy International Limited (Ireland)"],
  # "acct_supp_field_values"=>[{"supp_field_value"=>"Mozy International Limited (Ireland)"}]}
  return_value = AriaApi.get_supp_field_values({:acct_no=> aria_id.to_i,:field_name=>field_name})
  @field_value = return_value['acct_supp_field_values'][0]['supp_field_value']
end

Then /^Supplemental field (.+) value should be (.+)$/ do |_,value|
  @field_value.should == value
end

Then /^The aria plan should be$/ do |aria_plan|
  expected = aria_plan.hashes
  expected.each_with_index do |expect_plan, index|
    expect_plan.each do |key, value|
      @aria_plan[index][key].to_s.should == value
    end
  end
end

Then /^Move enterprise to DPS script output should include$/ do |message|
  @move2DPS_output.should include(message)
end

When /^I move enterprise to DPS by script for (.+)$/ do |aria_id, table|
  info_hash = table.hashes.first
  if info_hash['dry run'].nil? || info_hash['dry run'] == 'no'
    dry_run = false
  else
    dry_run = true
  end
  unit = info_hash['units'] || 1
  all_child_plans = AriaApi.get_avail_child_plans_for_acct_all({:acct_no=> aria_id.to_i})
  all_plan = all_child_plans['all_plans']
  all_plan.each {|value|
    if value['plan_name'] == info_hash['plan name']
      plan_no = value['plan_no']
      @move2DPS_output = MoveEnterpriseToDPS.move_me_dps(@partner_id, plan_no, unit.to_i, dry_run)
      break
    end
  }
end

And /^API\* I (change aria plan to|assign aria plan) (.+) with (\d+) units for (.+)$/ do |type, plan_name, units_no, aria_id|
  current_plan_info = AriaApi.get_acct_plans({:acct_no=> aria_id.to_i})
  plan = current_plan_info['acct_plans']
  # get all current plans number for remove and replace
  plan_array = []
  plan.each_index do |i|
    plan_array << plan[i]['plan_no']
  end
  # remove supplemental Plans, except the last one and the first one which is master plan
  # assignment_directive = 3 means assign or replace immediately
  if type.include?('change')
    for i in 1..(plan_array.size-2)
      Log.debug AriaApi.cancel_supp_plan({:acct_no=> aria_id.to_i, :supp_plan_no => plan_array[i], :assignment_directive => 3})
    end
  end
  all_child_plans = AriaApi.get_avail_child_plans_for_acct_all({:acct_no=> aria_id.to_i})

  # replace the last supplemental plan to DPS plan
  all_plan = all_child_plans['all_plans']
  all_plan.each {|value|
    if value['plan_name'] == plan_name
      plan_no = value['plan_no']
      if type.include?('change')
        Log.debug AriaApi.replace_supp_plan({:acct_no=> aria_id.to_i, :existing_supp_plan_no => plan_array[-1], :new_supp_plan_no => plan_no, :num_plan_units => units_no, :assignment_directive => 3})
      else
        Log.debug AriaApi.assign_supp_plan({:acct_no=> aria_id.to_i, :supp_plan_no => plan_no, :num_plan_units => units_no, :assignment_directive => 3})
      end
      break
    end
  }
end

Then /^service rates per rate schedule should be$/ do |info_table|
  expected_service_rate = info_table.hashes
  (@aria_plan_all.size-1).should == expected_service_rate.size
  for i in 1..(@aria_plan_all.size-1)
    @aria_plan_all[i]['plan_name'].should == expected_service_rate[i-1]['plan_name']
    plan_services = @aria_plan_all[i]['plan_services']
    plan_services_rates = plan_services[0]['plan_service_rates']
    plan_services[0]['service_desc'].should == expected_service_rate[i-1]['service_desc']
    plan_services_rates[0]['rate_per_unit'].to_s.should == expected_service_rate[i-1]['rate_per_unit']
    plan_services_rates[0]['monthly_fee'].to_s.should == expected_service_rate[i-1]['monthly_fee']
  end
end

Then /^net pro-ration per rate schedule should be$/ do |info_table|
  expected = info_table.hashes
  Log.debug @return_values
  @return_values.size.should == expected.size
  @return_values.each_with_index do |value, index|
    value['proration_result_amount'].to_s.should == expected[index]['proration_result_amount']
    supp_plan_line_items = value['supp_plan_line_items']
    supp_plan_line_items[0]['rate_per_unit'].to_s.should == expected[index]['rate_per_unit']
    supp_plan_line_items[0]['plan_name'].should == expected[index]['plan_name']
    supp_plan_line_items[0]['line_units'].to_s.should == expected[index]['line_units']
  end
end

When /^I move (forward|backwards) account billing dates (1 month|1 year|2 years|3 years) for (.+)$/ do |action, date, aria_id|
  date_new = Chronic.parse('in ' + date)
  days = (date_new.to_i - Time.now.to_i)/(24*60*60)
  Log.debug days
  action_directive_value = (action == 'forward'? 1 : 2)
  # only allow adjust max 27 days one time
  n = days/27
  (n + 1).downto(1){ |x|
    day = (x==1? days%27 : 27)
    if day > 0
       # action_directive: 1, move forward; 2 move backwards
      response = AriaApi.adjust_billing_dates({ :acct_no=> aria_id.to_i, :action_directive=> action_directive_value, :adjustment_days=> day,:comments=> "Test" })
      Log.debug response
    end
  }
end

And /^API\* I change account schedule price for (.+)$/ do |aria_id, info_table|
  rate_price = info_table.hashes
  rate_price.each_with_index {|v,_|
    plan_name = v['plan_name']
    rate_per_unit = v['rate_per_unit'].to_f

    @aria_plan_all.each_index { |n|
       if @aria_plan_all[n]['plan_name'] == plan_name
        supp_plan_no = @aria_plan_all[n]['plan_no']
        plan_services = @aria_plan_all[n]['plan_services']
        service_no = plan_services[0]['service_no']
        plan_service_rates = plan_services[0]['plan_service_rates']
        rate_seq_no = plan_service_rates[0]['rate_seq_no']
        return_value = AriaApi.assign_custom_acct_rates({:acct_no=> aria_id.to_i,:plan_no=> supp_plan_no, :service_no=>service_no, :rate_seq_no=>rate_seq_no, :rate_per_unit=>rate_per_unit })
        return_value['error_msg'].should == 'OK'
        break
      end
    }
  }

end

Then /^API\* Aria account coupon code info should be (.+)$/ do |coupon|
  coupon.replace ERB.new(coupon).result(binding)
  coupon_details = Aria_SDK.call('get_coupon_details', {:acct_no=> @aria_id.to_i})
  coupons = coupon_details['coupons']

  if !coupons.nil?
    coupon_code = coupons[0]['out_coupon_cd']
    Log.debug coupon_code
    coupon_code.should == coupon
  else
    Log.debug coupons
    coupons.should == nil
  end

end

When /^API\* I assign aria supp plan multi for (.+)$/ do |aria_id, info_table|
  new_plan_rate = info_table.hashes

  all_child_plans = Aria_SDK.call('get_avail_child_plans_for_acct_all', {:acct_no=> @aria_id.to_i})
  all_plan = all_child_plans['all_plans']

  new_plan_rate.each {|v|
    plan_name = v['plan_name']
    new_rate_schedule = v['rate_schedule_name']
    new_currency = v['schedule_currency']
    num_plan_units = v['num_plan_units']

    # find plan num based on given plan name
    all_plan.each { |value|
      flag = false
      if value['plan_name'] == plan_name
        plan_no = value['plan_no']
        Log.debug plan_no.inspect
        rate_schedules = Aria_SDK.call('get_rate_schedules_for_plan', {:plan_no=> plan_no.to_i})

        # find matching schedule rate and assign
        rate_schedules['rate_sched'].each { |rate|
          if rate['schedule_name'] == new_rate_schedule && rate['schedule_currency'] == new_currency
            rate_schedule_no = rate['schedule_no']
            Log.debug rate_schedule_no.inspect

            Aria_SDK.call('assign_supp_plan_multi', {:acct_no=> aria_id.to_i, :supp_plan_no => plan_no, :alt_rate_schedule_no=> rate_schedule_no, :num_plan_units=> num_plan_units.to_i, :assignment_directive => 5, :auto_offset_months_option => 1, :do_write => true})
            flag = true
          end
        }
      end
      break if flag
    }
  }
end

When /^API\* I assign coupon code (.+) to (.+)$/ do |coupon, aria_id|
  coupon.replace ERB.new(coupon).result(binding)
  response = Aria_SDK.call('apply_coupon_to_acct', {:acct_no => @aria_id.to_i, :coupon_code => coupon})
  Log.debug response.body.inspect
end

Then /^API\* Aria account notification template group should be (.+)$/ do |notify_tmplt_grp|
  notification_details = Aria_SDK.call('get_acct_notification_details', {:acct_no=> @aria_id.to_i})
  notification = notification_details['acct_notification_details']
  Log.debug notification

  if !notification.nil?
    notification_template_group = notification[0]['notify_tmplt_grp_id']
    notification_template_group.should == notify_tmplt_grp
  else
    notification.should == nil
  end

end

Then /^API\* Aria account payment is (.+)/ do |status|
  payment_details = Aria_SDK.call('get_acct_payment_history', {:acct_no=> @aria_id.to_i})
  payment = payment_details['payment_history']
  payment[0]['payment_status'].should == status
end

When /^API\* I update payment information to:/ do |info_table|
  attributes = info_table.hashes.first
  payment_method = attributes["payment method"]
  cc_number = attributes["cc number"]
  cc_expire_month = attributes["expire month"]
  cc_expire_year = attributes["expire year"]

  response = Aria_SDK.call('update_payment_method', {:account_number=> @aria_id.to_i, :pay_method => payment_method, :cc_number => cc_number, :cc_expire_mm => cc_expire_month, :cc_expire_yyyy => cc_expire_year})
  Log.debug response.body.inspect
end
