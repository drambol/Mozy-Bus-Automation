#This is for Reap
# Reap runs in production automatically once a week.
# If a home user is in a delinquent state (bad credit card, time to renew) reap catches them
# Reap will send out a notice every other week, then delete their account after 90 days.
# If for some reason reap hasn't been running in production the 'Z-date' process happens



And /^I force current MozyHome account to (delinquent state|grace period)$/ do |state|

  fail('User ID needed for setting account to delinquent state')  if @user_id.nil?

  enable_cybersoure_payment_force_failure

  DBHelper.set_expiration_time(@user_id,1)
  run_phoenix_process_subscription_script(@user_id)

  if state == "delinquent state"
    DBHelper.set_expiration_time(@user_id,1)
    run_phoenix_process_subscription_script(@user_id)
  end

  disable_cybersoure_payment_force_failure

end

And /^I force current MozyHome account to inactive state$/ do

  fail('User ID needed for setting account to inactive state')  if @user_id.nil?

  DBHelper.set_last_backup_at(@user_id,91)
end

Then /I run (first notification|second notification|third notification|fourth notification|fifth notification|final notification|deletion) reap script for mozyhome free$/ do |instance|
  fail('User ID needed for Reap script') if @user_id.nil?

  unless instance == 'identification'
    case instance
      #Reap script moves the gc_notify_at forward two weeks each time, this simulates that effect
      when 'first notification';  gc_weeks = 3; bs_weeks = 4; days_left = 75
      when 'second notification'; gc_weeks = 5; bs_weeks = 6; days_left = 61
      when 'third notification';  gc_weeks = 7; bs_weeks = 8; days_left = 47
      when 'fourth notification'; gc_weeks = 9; bs_weeks = 10; days_left = 33
      when 'final notification';  gc_weeks = 11; bs_weeks = 12; days_left = 5
      else gc_weeks = 12; bs_weeks = 13; days_left = nil #'deletion'
    end
    DBHelper.set_last_backup_attempt(@user_id,bs_weeks)
    DBHelper.set_gc_notify_at(@user_id,gc_weeks)
  end

  puts "Reap run: #{instance}"

  #Set reap to have a start date of a year ago and then run the script
  change_reap_yml_file(@user_id,365)
  start_reap_free

  sleep(30) #Wait for email to show up.

  unless instance == 'identification' || instance == 'deletion'
    step 'I search emails by keywords:', table('
     | to               |
     | @new_admin_email |
     ')

    if instance == 'final notification'
      match = @found_emails.to_s.match("Final Notice! Your files are scheduled to be deleted in #{days_left} days.")
    else
      match = @found_emails.to_s.match("Attention! Your files are scheduled to be deleted in #{days_left} days.")
    end
    fail("Reap email not received for #{instance} with #{days_left} days left.") if match.nil?
  end

end

Then /^I run (identification|first notification|second notification|third notification|fourth notification|fifth notification|sixth notification|seventh notification|final notification|deletion) reap script for mozyhome free with z-dates$/ do |instance|
  #Z-dates will always send out 8 notifications then delete
  #Reap sets the gc_notify date to 1966 then goes up one year every time it runs
  #It sends notifications on 1966 then every odd year after
  #After 1978 it will send the final notification then delete the next time.

  fail('User ID needed for Reap script') if @user_id.blank?

  case instance
    when 'identification'; bs_weeks = 13; reap_days, days_left, extra_run = nil,nil,nil
    when 'first notification';   reap_days = 0;  days_left = 89; extra_run = false; bs_weeks = nil
    when 'second notification';  reap_days = 7;  days_left = 82; extra_run = true; bs_weeks = nil
    when 'third notification';   reap_days = 21; days_left = 68; extra_run = true; bs_weeks = nil
    when 'fourth notification';  reap_days = 35; days_left = 54; extra_run = true; bs_weeks = nil
    when 'fifth notification';   reap_days = 49; days_left = 40; extra_run = true; bs_weeks = nil
    when 'sixth notification';   reap_days = 63; days_left = 26; extra_run = true; bs_weeks = nil
    when 'seventh notification'; reap_days = 77; days_left = 12; extra_run = false; bs_weeks = nil
    when 'final notification';   reap_days = 84; days_left = 5;  extra_run = false; bs_weeks = nil
    else reap_days = 90; extra_run = false; bs_weeks,days_left = nil,nil #Deletion
  end

  puts "Reap run: #{instance}"

  if instance == 'identification'
    DBHelper.set_last_backup_attempt(@user_id,bs_weeks)
  else
    change_reap_yml_file(@user_id,reap_days.to_i)
    start_reap_free
    start_reap_free if extra_run
  end

  sleep(30) #Wait for email to show up.

  unless instance == 'identification' || instance == 'deletion'
    step 'I search emails by keywords:', table('
     | to               |
     | @new_admin_email |
     ')

    if instance == 'final notification'
      match = @found_emails.to_s.match("Final Notice! Your files are scheduled to be deleted in #{days_left} days.")
    else
      match = @found_emails.to_s.match("Attention! Your files are scheduled to be deleted in #{days_left} days.")
    end
    fail("Reap email not received for #{instance} with #{days_left} days left.") if match.nil?
  end
end

Then /^I run (identification|first notification|second notification|third notification|fourth notification|fifth notification|final notification|deletion) reap script$/ do |instance|
  #First sends no email #Time after Final deletes

  fail('User ID needed for Reap script') if @user_id.nil?

  unless instance == 'identification'
    case instance
      #Reap script moves the gc_notify_at forward two weeks each time, this simulates that effect
      when 'first notification';  gc_weeks = 0; bs_weeks = 1; days_left = 75
      when 'second notification'; gc_weeks = 2; bs_weeks = 3; days_left = 61
      when 'third notification';  gc_weeks = 4; bs_weeks = 5; days_left = 47
      when 'fourth notification'; gc_weeks = 6; bs_weeks = 7; days_left = 33
      when 'fifth notification';  gc_weeks = 8; bs_weeks = 9; days_left = 19
      when 'final notification';  gc_weeks = 10; bs_weeks = 11; days_left = 5
      else gc_weeks = 12; bs_weeks = 13; days_left = nil #'deletion'
    end
    DBHelper.set_backup_suspended_at(@user_id,bs_weeks)
    DBHelper.set_gc_notify_at(@user_id,gc_weeks)
  end

  puts "Reap run: #{instance}"

  #Set reap to have a start date of a year ago and then run the script
  change_reap_yml_file(@user_id,365)
  start_reap

  sleep(30) #Wait for email to show up.

  unless instance == 'identification' || instance == 'deletion'
    step 'I search emails by keywords:', table('
     | to               |
     | @new_admin_email |
     ')

    if instance == 'final notification'
      match = @found_emails.to_s.match("Final Notice! Your files are scheduled to be deleted in #{days_left} days.")
    else
      match = @found_emails.to_s.match("Attention! Your files are scheduled to be deleted in #{days_left} days.")
    end
    fail("Reap email not received for #{instance} with #{days_left} days left.") if match.nil?
  end
end

Then /^I run (identification|first notification|second notification|third notification|fourth notification|fifth notification|sixth notification|seventh notification|final notification|deletion) reap script with z-dates$/ do |instance|
  #Z-dates will always send out 8 notifications then delete
  #Reap sets the gc_notify date to 1966 then goes up one year every time it runs
  #It sends notifications on 1966 then every odd year after
  #After 1978 it will send the final notification then delete the next time.

  fail('User ID needed for Reap script') if @user_id.blank?

  case instance
    when 'identification'; bs_weeks = 13; reap_days, days_left, extra_run = nil,nil,nil
    when 'first notification';   reap_days = 0;  days_left = 89; extra_run = false; bs_weeks = nil
    when 'second notification';  reap_days = 7;  days_left = 82; extra_run = true; bs_weeks = nil
    when 'third notification';   reap_days = 21; days_left = 68; extra_run = true; bs_weeks = nil
    when 'fourth notification';  reap_days = 35; days_left = 54; extra_run = true; bs_weeks = nil
    when 'fifth notification';   reap_days = 49; days_left = 40; extra_run = true; bs_weeks = nil
    when 'sixth notification';   reap_days = 63; days_left = 26; extra_run = true; bs_weeks = nil
    when 'seventh notification'; reap_days = 77; days_left = 12; extra_run = false; bs_weeks = nil
    when 'final notification';   reap_days = 84; days_left = 5;  extra_run = false; bs_weeks = nil
    else reap_days = 90; extra_run = false; bs_weeks,days_left = nil,nil #Deletion
  end

  puts "Reap run: #{instance}"

  if instance == 'identification'
    DBHelper.set_backup_suspended_at(@user_id,bs_weeks)
  else
    change_reap_yml_file(@user_id,reap_days.to_i)
    start_reap
    start_reap if extra_run
  end

  sleep(30) #Wait for email to show up.

  unless instance == 'identification' || instance == 'deletion'
    step 'I search emails by keywords:', table('
     | to               |
     | @new_admin_email |
     ')

    if instance == 'final notification'
      match = @found_emails.to_s.match("Final Notice! Your files are scheduled to be deleted in #{days_left} days.")
    else
      match = @found_emails.to_s.match("Attention! Your files are scheduled to be deleted in #{days_left} days.")
    end
    fail("Reap email not received for #{instance} with #{days_left} days left.") if match.nil?
  end
end

And /^I force current MozyHome account to billed$/ do
  DBHelper.set_expiration_time(@user_id,1)
  Log.debug run_phoenix_process_subscription_script(@user_id)
end

And /^I set current MozyHome account to be expired (\d+) days later$/ do |days|
  DBHelper.set_expiration_time(@user_id,-days.to_i)
end

And /^I run process_subscription script for the user$/ do
  Log.debug run_phoenix_process_subscription_script(@user_id)
end

And /^I run send_initial_renewal_notification for the user$/ do
  Log.debug run_phoenix_send_notification_script(@user_id)
end


