def login(environment)
  success = true
  login_start_time = nil
  login_end_time = nil
  d = 0
  begin
    @bus_site = BusSite.new if @bus_site.nil?
    case environment
      when 'bus admin console'
        login_start_time = Time.now.utc
        @bus_site.login_page.load
        @bus_site.login_page.choose_english
        @admin_username = QA_ENV['bus_username']
        @admin_password = QA_ENV['bus_password']
        @bus_site.login_page.login(@admin_username, @admin_password)
        login_end_time = Time.now.utc
      when 'to legacy bus01'
        @bus_site.itemized_login.load
        @admin_username = QA_ENV['bus01_admin']
        @admin_password = QA_ENV['bus01_pass']
        @bus_site.itemized_login.login(@admin_username, @admin_password)
    end
  rescue Exception => ex
    Log.debug(ex.to_s)
    @bus_site.log("fail to log in the bus console.")
    @bus_site.log(ex.to_s)
    success = false
  end
  @bus_site.log("KPI-Login_BUS_Console:start_time:#{login_start_time}/end_time:#{login_end_time}")
  success
end

#Give the login steps more chances to retry since it is a key path to all following steps
Given /^I log in (bus admin console|to legacy bus01) as administrator$/ do |environment|
  i = 0
  while !login(environment) && i < 3
    sleep 60
    i += 1
  end
end

And /^I login as (.+) admin successfully$/ do |admin|
  if admin == 'mozypro'
    admin = @partner.company_info.name
  elsif !(admin.match(/^@.+$/).nil?)
    admin =  '<%=' + admin + '%>'
    admin.replace ERB.new(admin).result(binding)
  else
  end
  @bus_site.admin_console_page.get_partner_name_topcorner.should eq(admin)
end

When /^I navigate to (bus admin console|phoenix) login page$/ do |site|
  if site == 'bus admin console'
    @bus_site = BusSite.new if @bus_site.nil?
    @bus_site.login_page.load
  else
    @bus_site ||= BusSite.new #In case you log into bus through the phoenix page
    @phoenix_site ||= PhoenixSite.new
    @phoenix_site.user_account.load
  end
end

When /^I navigate to (.+) user login page$/ do |subdomain|
  @bus_site = BusSite.new if @bus_site.nil?
  @bus_site.user_login_page(subdomain, 'mozy').load
end

When /^I log in bus admin console with user name (.+) and password (.+)$/ do |username, password|
  if !(username.match(/^@.+$/).nil?)
    username =  '<%=' + username + '%>'
    username.replace ERB.new(username).result(binding)
  end
  password = '' if password == 'AD user default password'
  username = QA_ENV['bus01_admin'] if username == 'bus01_admin'
  password = QA_ENV['bus01_pass'] if password == 'bus01_pass'
  password = '' if password == 'Empty'
  @bus_site.login_page.login(username, password)
end

When /^I log out bus admin console$/ do
  @bus_site.login_page.logout
end

When /^I log out user$/ do
  @bus_site.user_login_page(type = 'mozy').logout
end

Then /^Login page error message should be (.+)$/ do |messages|
  @bus_site.login_page.messages.should == messages
end

Then /^Phoenix Login page error message should be (.+)$/ do |messages|
  @bus_site.login_page.phoenix_login_error_messages.strip.should == messages.strip
end

When /^I save login page cookies (.+) value$/ do |name|
  cookie = @bus_site.login_page.cookies.select{ |cookie| cookie[:name] == name }.first
  @login_page_cookie_value = cookie[:value]
  puts "login page #{name}: #@login_page_cookie_value"
end

And /^I log in bus admin console as new partner admin(.+)?$/ do|password|
  @bus_site.login_page.load
  if password.nil?
    @bus_site.login_page.login(@partner.admin_info.email, CONFIGS['global']['test_pwd'])
  else
    @bus_site.login_page.login(@partner.admin_info.email, password)
  end
end

Then /^the new partner admin should be asked to verify their email address$/ do
  @bus_site.verify_email_page.current_url.should == "#{QA_ENV['bus_host']}/login/email_needs_verification"
  @bus_site.verify_email_page.links_present.should be_true
end

When /^I log into bus admin console with uppercase (.+) and (.+)$/ do |username, password|
  username = username.upcase
  step %{I log in bus admin console with user name #{username} and password #{password}}
end

When /^I log into bus admin console with mixed case (.+) and (.+)$/ do |username, password|
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)==0 ? x.downcase : x.upcase end
  end
  step %{I log in bus admin console with user name #{username} and password #{password}}
end

When /^I log into (.+) with (uppercase|lowercase) username (.+) and (.+)$/ do |subdomain, type, username, password|
  if type.eql?('uppercase')
    username = username.upcase
  else
    username = username.downcase
  end
  user_account = {:user_name => username, :password => password}
  @bus_site.user_login_page(subdomain, 'mozy').login(user_account)
end

When /^I log into (.+) with mixed case username (.+) and (.+)$/ do |subdomain, username, password|
  until username.match(/[A-Z]/) do
    username = username.gsub /[a-z]/i do |x| rand(2)==0 ? x.downcase : x.upcase end
  end
  user_account = {:user_name => username, :password => password}
  @bus_site.user_login_page(subdomain, 'mozy').login(user_account)
end

When /^I navigate to user login page with partner ID( oem\.partners\.com| partners\.mozy\.com)?$/ do |prefix|
  @bus_site = BusSite.new
  if prefix.nil?
    @bus_site.user_pid_login_page(@partner_id, @partner.partner_info.type).load
  else
    @bus_site.user_pid_login_page(@partner_id, 'oem', prefix.strip).load if @partner.nil?
    @bus_site.user_pid_login_page(@partner_id, @partner.partner_info.type, prefix.strip).load unless @partner.nil?
  end
end

When /^I log in bus pid console with user name (.+) and password (.+)$/ do |username, password|
  if password.eql?('empty')
    password = ''
  end
  username.replace ERB.new(username).result(binding)
  @bus_site.user_pid_login_page(@partner_id, @partner.partner_info.type).user_login(username, password)
end

When /^I log in bus pid console with( mixed username| uppercase username| lowercase username)?:$/ do |match,table|
  login_hash = table.hashes.first
  login_hash.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  username = login_hash['username']
  if !match.nil?
    case match.strip
      when  'mixed username'
        until username.match(/[A-Z]/) do
          username = username.gsub /[a-z]/i do |x| rand(2)==0 ? x.downcase : x.upcase end
        end
      when 'uppercase username'
        username = username.upcase
      when 'lowercase username'
        username = username.downcase
    end
  end
  @bus_site.user_pid_login_page(@partner_id, @partner.partner_info.type).user_login(username, login_hash['password'])
end

Then /^I navigate to (new|old) window$/ do |window|
  @main_window = page.driver.browser.window_handles.first
  if window == 'new'
    sleep 5 if page.driver.browser.window_handles.size == 1
    page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
  else
    page.driver.browser.switch_to.window(@main_window)
  end
end

Then /^I close new window$/ do
  page.driver.browser.close
  page.driver.browser.switch_to().window(page.driver.browser.window_handles.first)
end

When /^I go to page (.+)$/ do |url|
  url = url.gsub(/CONFIGS\['fedid'\]\['subdomain'\]/,CONFIGS['fedid']['subdomain'])
  url = url.gsub(/QA_ENV\['bus_host'\]/,QA_ENV['bus_host'])
  url = url.gsub(/@partner_id/, @partner_id) if @partner_id
  @bus_site.login_page.go_to_url(url)
end

Then /^I reset password to (.+)$/ do |pwd|
  @bus_site.user_pid_login_page(@partner_id, @partner.partner_info.type).set_user_password(pwd)
end

And /^I start a new session$/ do
  @bus_site.adfs_login_page.start_a_new_browser
end

When /^I click login link from the email$/ do
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  @mail_content = find_email_content(@email_search_query)
  # the url is like # https://<subdomain>.mozypro.com/login/user | https://www(mozyoem).mozypro.com/login/user?pid=XXXX
  match = @mail_content.match(/https?:\/\/[\S]+\.(mozypro|mozyenterprise)\.com\/login\/user(\?pid=\d+)?/)
  login_url = match[0] unless match.nil?
  Log.debug(login_url)
  @bus_site.login_page.go_to_url(login_url)
end

When /^The login action should be restricted by IP whitelist$/ do
  @bus_site.login_page.get_error_msg.should == "Administrative access to the Admin Console is restricted to specified networks (physical and VPN)."
end

Then /^I (should|should not) see language select field$/ do |option|
  if option == 'should'
    @bus_site.login_page.has_language_select?.should be_true
  else
    @bus_site.login_page.has_language_select?.should be_false
  end
end

And /^language select filed should include option (.+)$/ do |dialect|
  @bus_site.login_page.language_has_option?(dialect).should be_true
end
