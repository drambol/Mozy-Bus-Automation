Then /^I activate and back up the adfs user$/ do |table|
  attributes = table.hashes.first

  client = attributes['Client']
  env = attributes['Environment']
  subdomain = attributes['Subdomain']
  user = attributes['User']

  attributes.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  result = SSHKalypsoE2E.run_adfs_activation_and_backup(client, env, subdomain, user)
  Log.debug("Kalypso Automation run for #{user}")
  result.should == "Pass\r\n"
end