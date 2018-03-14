Then /^Retention period in DB for current partner is (\d+) days$/ do |input_value|
  dbvalue = DBHelper.get_partner_setting_value(@partner_id,'custom_file_retention_days')
  input_value.to_i.should == dbvalue
end

Then /^Alert text should have been "(.+)"$/ do |message|
  $alert_text.should == message
end

And /^I try all (positive|negative) retention date for (MozyPro Direct|MozyPro Reseller|Enterprise|OEM|MozyPro Velocity|Corp)$/ do |pn,type|
  case type
    #when 'Home'; global_setting = 'retention_mozy_home'
    when 'Enterprise'; global_setting = 'retention_mozy_enterprise'
    when 'OEM'; global_setting = 'retention_oem'
    when 'MozyPro Velocity'; global_setting = 'retention_velocity_root_role'
    when 'MozyPro Direct'; global_setting = 'retention_mozy_pro_direct' #Itemized and Bundled
    when 'MozyPro Reseller';global_setting = 'retention_mozy_pro_reseller' #Itemized and Bundled
    else global_setting = 'retention_mozy_default'
  end
  max = DBHelper.get_global_setting_value(global_setting)

  if pn == 'positive'
    array = [1,15,max]
    array.each do |retention_value|
      #puts "Adding partner setting 'custom_file_retention_days' with value '#{retention_value}'"
      step %{I add partner settings}, table(%{
       | Name | Value | Locked |
       | custom_file_retention_days | #{retention_value} | false |
      })
      step %{Retention period in DB for current partner is #{retention_value} days}
      step %{I delete partner settings}, table(%{
       | Name |
       | custom_file_retention_days |
      })
    end
  else
   array = [0,-5,1.2,max+1]
   array.each do |retention_value|
     #puts "Adding partner setting 'custom_file_retention_days' with value '#{retention_value}'"
     step %{I add partner settings}, table(%{
       | Name | Value | Locked |
       | custom_file_retention_days | #{retention_value} | false |
      })
     step %{Alert text should have been "Valid custom_file_retention_days for this type of partner are integers from 1 to #{max}"}
     end
   end
end

And /^I try negative retention dates for partner type$/ do

end