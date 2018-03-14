When /^I wait for (\d+) seconds for email search if in outlook$/ do |seconds|
  sleep seconds.to_i if QA_ENV['read_aria_email_from_outlook'].to_s.upcase == "TRUE"
end


Given /^I identify the email is sent from (aria|bus)$/ do |service|
  Log.debug QA_ENV['read_aria_email_from_outlook'].to_s.upcase
  @send_from_aria = ""
  if service == "aria"
    @send_from_aria = "Yes"
  else
    @send_from_aria = "No"
  end
end

# If use qa code to create a AD user with dynamic email, @AD_User_Emails hash instance variable will be created.
# See below example for how to check email for a unique and dynamic AD user email
# And I search emails by keywords:
#     | to                                | subject                               |
#     | @AD_User_Emails["tc131019.user1"] | New Account Created on MozyEnterprise |
# =======================================================================================
# We provide two ways to search email by keywords
#  - criteria: search email in aria
#     - case1: Given I identify the email is sent from aria + read_aria_email_from_outlook = No (eny.yml)
When /^I search emails by keywords:$/ do |keywords_table|
  #initialize @send_from_aria if the instance variable doesn't exist, set value = "NO", so current step will get the email from outlook.
  puts "Instance variable @send_from_aria is not defined, define @send_from_aria and set value with 'NO'." if @send_from_aria.nil?
  @send_from_aria = "NO" if @send_from_aria.nil?
  if !(QA_ENV['read_aria_email_from_outlook'].to_s.upcase == "FALSE" && @send_from_aria.to_s.upcase == "YES")
    #This is a temporary workaround to move the step <I wait for 1200 seconds> to here since we can make choice of getting email etither from outlook or aria
    Log.debug "Find the email in outook"
    @email_search_query = []
    expected = keywords_table.hashes
    expected.each do |col|
      col.each do |k,v|
        case k
          when 'to'
            v.gsub!(/@new_user_email/, @new_users.first.email) unless @new_users.nil?
            v.gsub!(/@new_admin_email/, @partner.admin_info.email) unless @partner.nil?
            v.gsub!(/@existing_admin_email/, @existing_admin_email) unless @existing_admin_email.nil?
            v.gsub!(/@existing_user_email/, @existing_user_email) unless @existing_user_email.nil?
            # scenario - check the AD user email which is a dynamic email address with prefix as mozyautotest+xxx@emc.com
            if v.include?("@AD_User_Emails")
              @bus_site.log("AD user's email requies converted.")
              match = v.scan(/".*"/)
              puts match[0]
              puts match[0].length
              puts match[0][1..match[0].length-2]
              v = @AD_User_Emails[match[0][1..match[0].length-2]]
              puts v
            end
          when 'content'
            unless @partner.nil?
              v.gsub!(/@new_admin_email/, @partner.admin_info.email)
              v.gsub!(/@company_address/, @partner.company_info.address)
              v.gsub!(/@XXXX/, @partner.credit_card.number[12..-1])
              v.gsub!(/@admin_first_name/,@partner.admin_info.first_name)
              v.gsub!(/@first_name/, @partner.credit_card.first_name)
            end
          #Legacy from Zimbra
          when  'date','after'
            #IMAP doesn't search over minutes just dates
            v = Net::IMAP.format_date(Date.today) if v == 'today'
          when 'subject'
            v.gsub!(/@license_key/, @order.license_key[0]) if v.include?("@license_key")
          else
            # do nothing
        end
        v.replace ERB.new(v).result(binding)
        # for license key, the value contains space, need to remove the space
        v.gsub!(/ /,'') unless v.match(/^\[.+\]$/).nil?
        case k.downcase
          when 'to','cc','from','subject','body';
          when 'before','since', 'on' ;
            #Legacy Zimbra corrections
          when 'date'; k = 'on'
          when 'after'; k = 'since'
          when 'content'; k = 'body'
          else
            Log.debug("'#{k}' is not a valid imap search key")
            next
        end
        @email_search_query << k.upcase
        @email_search_query << v
      end
    end
    sleep 15

    Log.info(@email_search_query)
    3.times do
      @found_emails = find_emails(@email_search_query)
      sleep 60 if @found_emails.size == 0
      break if @found_emails.size > 0
    end
  else
    # call aria API to get the @partner.admin_info.email / @aria_id
    Log.debug "Find the email in Aria directly"
    subject = ""
    expected = keywords_table.hashes
    expected.each do |col|
      col.each do |k,v|
        case k
          when 'subject'
            v.gsub!(/@license_key/, @order.license_key[0]) if v.include?("@license_key")
            if v.include?("[")
              subject = v.gsub!("[", "").gsub!("]", "")
            else
              subject = v
            end
        end
      end
    end

    @found_emails = []
    #======print the parameter on the screen======
    Log.debug start_date = (Date.today()- 1).strftime("%Y-%m-%d").to_s
    Log.debug end_date = Date.today().strftime("%Y-%m-%d").to_s
    Log.debug aria_account = @aria_id.to_i
    Log.debug user_email = (@partner.admin_info.email).gsub("+", "_")
    Log.debug subject
    Log.debug client_no = ARIA_API_ENV["client_no"]
    Log.debug auth_key = ARIA_API_ENV["auth_key"]
    #======write the parameter into the log file======
    @bus_site.log("======Aria API Call parameters======")
    @bus_site.log("Aria Auth Key is #{auth_key}")
    @bus_site.log("Client no is #{client_no}")
    @bus_site.log("Start Date is #{start_date}")
    @bus_site.log("End Date is #{end_date}")
    @bus_site.log("Aria account is #{aria_account}")
    @bus_site.log("User email is #{user_email}")
    @bus_site.log("Subject is #{subject}")

    api = AriaCoreRestClient.new(ARIA_API_ENV["client_no"], ARIA_API_ENV["auth_key"])
    begin
      results = api.call('get_acct_comments', {:acct_no => aria_account, :date_range_start => start_date, :date_range_end => end_date })
      Log.debug current_date = Date.today().strftime("%-m/%-d/%Y").to_s
      @bus_site.log("Current date is #{current_date}")
    rescue
      results = api.call('get_acct_comments', {:acct_no => aria_account, :date_range_start => start_date, :date_range_end => start_date })
      Log.debug current_date = (Date.today() - 1).strftime("%-m/%-d/%Y").to_s
      Log.debug "Change the end date to #{start_date}"
      @bus_site.log("Current date is #{current_date}")
    end
    results["acct_comments"].each do |result|
      puts result["comment"] if result["comment"].start_with?("Email message of type")
      puts result["comment"].gsub("[", "").gsub("]", "").gsub("\"", "").gsub("+","_") if result["comment"].start_with?("Email message of type")
      @found_emails << result["comment"] if !(result["comment"].gsub("[", "").gsub("]", "").gsub("\"", "").gsub("+","_") =~ /#{subject}*.\ssent to address\s*.#{user_email}*.\son\s#{current_date}/).nil?
    end
  end
  Log.debug @found_emails
  @bus_site.log("Get emails: #{@found_emails}") unless @bus_site.nil?
end

Then /^I should see (\d+) email\(s\)$/ do |num_emails|
  @found_emails = [] if @found_emails.nil?
  @found_emails.size.should == num_emails.to_i
  #Log.debug @found_emails[0].body if @found_emails.size > 0
end

When /^I (retrieve email content|download email attachment) by keywords:$/ do |type, keywords_table|
  sleep 30
  step %{I search emails by keywords:}, table(%{
      |#{keywords_table.headers.join('|')}|
      |#{keywords_table.rows.first.join('|')}|
    })
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  attach =(type.include?("download")? true: nil)
  @mail_content = find_email_content(@email_search_query, attach)
  Log.debug(@mail_content)
end

Then /^I get verify email address from email content$/ do
    if @partner.base_plan.eql?("free") # free account url is different
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/c\/[\S]+/)
    else # standard email url piece
      match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
    end
  @verify_email_query = match[0] unless match.nil?
end

# for mozyhome user change email address the new email will receive Email Address Verification
And /^I get verify email address from email content for mozyhome change email address$/ do
  match = @mail_content.match(/https?:\/\/secure.mozy.[\S]+\/registration\/verify_email_address\/[\S]+/)
  (match.nil?).should == false
  @verify_email_query = match[0] unless match.nil?
end

Then /^I check the email content should include:$/ do |msg|
  msg.replace ERB.new(msg).result(binding)
  @mail_content.should include (msg)
end

Then /^I check the mozy brand logo in email content is:(.+)$/ do |logo_url|
  @mail_content.should include (logo_url)
end
