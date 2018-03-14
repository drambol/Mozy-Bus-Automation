Then /^the overdraft script should report:$/ do |message|
  message.replace ERB.new(message).result(binding)
  SSHRecordOverdraft.record_overdraft(@current_partner[:id]).should == message
end