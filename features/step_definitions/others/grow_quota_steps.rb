When /^I upload ([0-9]*) GB of data to device$/ do |amount|
  @grow_quota_response = [] if @grow_quota_response.nil?
  amount.to_i.times do |i|
    @grow_quota_response[i] = SSHTDSGrowQuota.grow_quota(@new_users.first.email, CONFIGS['global']['test_pwd'], @machine_id, i)
  end
end

When /^I upload data to device(| by batch)$/ do |upload_type, grow_quota_table|
  attr = grow_quota_table.hashes.first
  attr.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end
  user_email = attr['user_email'] || @current_user[:email]
  machine_id = attr['machine_id'] || @machine_id
  filename = attr['file_name']
  upload_file = attr['upload_file']
  amount = attr['GB'] || 1
  user_agent = attr['user_agent']
  @grow_quota_response = [] if @grow_quota_response.nil?
  if attr['password'].nil?
    password = CONFIGS['global']['test_pwd']
  else
    password = attr['password']
  end
  @filename =filename

  if upload_type == ' by batch'
    @grow_quota_response[0] = SSHTDSGrowQuota.grow_quota(user_email, password, machine_id, amount, filename, upload_file, user_agent)
  else
    amount.to_i.times do |i|
      @grow_quota_response[i] = SSHTDSGrowQuota.grow_quota(user_email, password, machine_id, i + 1, filename, user_agent)
    end
  end
end

When /^tds returns successful upload$/ do
  @grow_quota_response.last.code.should == '200'
end

When /^tds return(| first) message should be:$/ do |return_index, message|
  if return_index == ' first'
    @grow_quota_response.first.body.should == message
  else
    @grow_quota_response.last.body.should == message
  end
end

