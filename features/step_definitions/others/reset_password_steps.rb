And /^I click forget your password link$/ do
  @bus_site.login_page.click_forget_password
end

And /^I input email (.+) in reset password panel to reset password$/ do |email|
  if !(email.match(/^@.+$/).nil?)
    email =  '<%=' + email + '%>'
    email.replace ERB.new(email).result(binding)
  end
  @bus_site.login_page.reset_password(email)
end

When /^I click reset password link from the email$/ do
  Log.debug("#{@found_emails.size} emails found, please update your search query") if @found_emails.size != 1
  @mail_content = find_email_content(@email_search_query)
  # For MozyEnterprise, the password recovery link is like https://www.mozyenterprise.com/p/303126690/1474620831/12b335ddc241faa48dbafc804fd6155c/pass/?pid=3493681
  # For MozyPro, the url is like https://mozy.com/p/531724/1441692752/58674ae5dcf8939a9d206093eac25b69/pass, which will be redirect to phoenix page
  # For MozyHome user, the url is https://secure.mozy.com/p/34708254/1471401645/32c639a25e6287cee339249891d51a79/pass/
  # For partner with subdomain, url begins with https://subdomain.xxx 
  match = @mail_content.match(/https?:\/\/(mozy|secure\.mozy)\.com\/[\S]+\/pass/)||@mail_content.match(/https?:\/\/(\w+\.)(mozypro|mozyenterprise|mozy)\.com\/[\S]+\/pass(\/\?pid=[\d]+)?/)
  reset_url = match[0] unless match.nil?
  Log.debug "reset_url: #{reset_url}"
  @bus_site.login_page.go_to_url(reset_url)
end

Then /^I reset password with (.+)$/ do |password|
  @bus_site.login_page.reset_password_enter(password)
end

And /^I will see reset password (|full )massage (.+)$/ do |full,msg|
  if full.nil?
    @bus_site.login_page.reset_password_msg.include?(msg).should == true
  else
    @bus_site.login_page.reset_password_msg.should == msg
  end
end
