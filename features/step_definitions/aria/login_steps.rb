Given /^I log in aria admin console as administrator$/ do
  @aria_site = AriaSite.new
  @aria_site.login_page.load
  @aria_site.login_page.login(ARIA_ENV['username'],ARIA_ENV['password'])
end

When /^I log in aria admin console with username (.+) and password (.+)$/ do |username,password|
  @aria_site = AriaSite.new
  username = ARIA_ENV['username'] if username == 'correct name'
  password = ARIA_ENV['password'] if password == 'correct password'
  @aria_site.login_page.login(username,password)
end

Then /^fail to login Aria and the message should be:$/ do |message|
  @aria_site = AriaSite.new
  @aria_site.login_page.error_message.should == message
end

Then /^Aria login page should be opened$/ do
  @aria_site = AriaSite.new
  @aria_site.login_page.login_btn_visible?.should == true
end

Then /^Aria account overview page should be opened$/ do
  @aria_site = AriaSite.new
  @aria_site.login_page.account_overview_visible?(@aria_id).should == true
end