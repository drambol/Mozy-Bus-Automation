Then /^API\* data shuttle order status should be (.+)$/ do |status|
  customcd = CustomCDAPI::CustomCD.new
  customcd.get_order_status(@customcd_order_id)[:order_status].should == status
end

And /^API\* cancel data shuttle order in customcd$/ do
  customcd = CustomCDAPI::CustomCD.new
  customcd.cancel_order(@customcd_order_id)
end