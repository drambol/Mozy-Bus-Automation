Then /^(old|current) cybersource token is (deleted|in use)$/ do |prefix, token_status|
  country_code = (@partner.company_info.country == "United States")? "US" : "EMEA"
  user_info = {
      :cybersource_id => @cybersource_id,
      :user_query_code => "Test_Query_#{country_code}_#{@user_id}",
      :country => country_code
  }
  response = CybersourceApi.build_retrieve_request(CYBERSOURCE_API_ENV, user_info)
  if token_status == 'deleted'
    response['Envelope']['Body']['replyMessage']['decision'].should == "REJECT"
    response['Envelope']['Body']['replyMessage']['reasonCode'].should == "102"
  else
    response['Envelope']['Body']['replyMessage']['decision'].should == "ACCEPT"
    response['Envelope']['Body']['replyMessage']['reasonCode'].should == "100"
    response['Envelope']['Body']['replyMessage']['paySubscriptionRetrieveReply']['email'].should == @partner.admin_info.email
    response['Envelope']['Body']['replyMessage']['paySubscriptionRetrieveReply']['reasonCode'].should == "100"
  end
  # check if response is rejected
end

Then /^I am able to retrieve information from CyberSource:$/ do |info_table|
  country_code = (@partner.company_info.country == "United States")? "US" : "EMEA"
  user_info = {
      :cybersource_id => @cybersource_id,
      :user_query_code => "Test_Query_#{country_code}_#{@user_id}",
      :country => country_code
  }
  response = CybersourceApi.build_retrieve_request(CYBERSOURCE_API_ENV, user_info)
  expected = info_table.hashes.first
  expected.keys.each do |header|
    expected[header].replace ERB.new(expected[header]).result(binding)
    case header
      when 'last four digits'
        response['Envelope']['Body']['replyMessage']['paySubscriptionRetrieveReply']['cardAccountNumber'].split('XXXXXX')[1].should == expected[header]
      when 'BIN country'
        expected[header] = 'US' if expected[header] == 'United States'
        response['Envelope']['Body']['replyMessage']['paySubscriptionRetrieveReply']['country'].should == expected[header]
      else
        raise 'Unknown credit card information'
    end
  end
end