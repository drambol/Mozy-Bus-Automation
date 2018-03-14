Then /^Number of activated keys should be (\d+)$/ do |num_keys|
  @bus_site.admin_console_page.user_details_section.activated_keys_table_rows.count.should == num_keys.to_i
  @activated_keys = @bus_site.admin_console_page.user_details_section.activated_keys_table_rows.map {|column| column[1] }
end

Then /^Number of unactivated keys should be (\d+)$/ do |num_keys|
  @bus_site.admin_console_page.user_details_section.unactivated_keys_table_rows.count.should == num_keys.to_i
  @unactivated_keys = @bus_site.admin_console_page.user_details_section.unactivated_keys_table_rows.map(&:first)
end

Then /^Number of (Server|Desktop) (activated|unactivated) keys should be (\d+)$/ do |type, status, num_keys|
  step %{Number of #{status} keys should be #{num_keys}}
  section = @bus_site.admin_console_page.user_details_section
  if status == 'activated'
    section.activated_keys_table_rows.each {|column| column[2].should == type }
  elsif status == 'unactivated'
    section.unactivated_keys_table_rows.each {|column| column[1].should == type }
  end
end

Then /^Log (activated|unactivated) keys$/ do | status|
  section = @bus_site.admin_console_page.user_details_section
  if status == 'activated'
    section.activated_keys_table_rows.each.with_index {|column,index| Log.debug("key#{index+1}:#{column[2]}-#{column[1]}")}
  elsif status == 'unactivated'
    section.unactivated_keys_table_rows.each.with_index {|column,index| Log.debug("key#{index+1}:#{column[1]}-#{column[0]}")}
  end
end