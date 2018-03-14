Then /^I push the adfs user\(s\) to BUS$/ do
  result = SSHPushConnector.push_users(@partner_id)
  Log.debug("Push connector run for partner: #{@partner_id}")
  result = result.scan(/LDAP upload to Mozy servers succeeded\./)
  result.should == ["LDAP upload to Mozy servers succeeded."]
end