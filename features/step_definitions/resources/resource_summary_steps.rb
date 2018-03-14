Then(/^(Itemized|Bundled) (storage|device) summary should be:$/) do |partner_type, resource_type, table|
  # table is a | 0            | 2.4 TB        | 0           | 100 GB       | 2.5 TB    | 0    |
  table_hash = table.hashes.first.inject({}) { |hash, (key, value)| hash[[resource_type, key].join('_').gsub(/\s/, '_').downcase] = value; hash }
  @bus_site.admin_console_page.resource_summary_section.resource_info(partner_type, resource_type).should == table_hash
end

When(/^The following equation about (storage|device) for (Itemized|Bundled) partner is right$/) do |resource_type, partner_type, table|
  # table is a | |
  resource_hash = @bus_site.admin_console_page.resource_summary_section.resource_info(partner_type, resource_type)
  array = table.raw.first.map do |opt|
    if ['+', '-', '*', '/', '=', '=='].include? opt
      opt
    else
      resource_hash[[resource_type, opt].join('_').gsub(/\s/, '_').downcase].match(/\d+/)[0]
    end
  end
  eval(array.join).should == true
end

When(/^I click the (more|hide) link for (storage|device)$/) do |action, type|
  @bus_site.admin_console_page.resource_summary_section.click_more_hide_link(action, type)
end

Then /^I refresh Resource Summary section$/ do
  @bus_site.admin_console_page.resource_summary_section.refresh_bus_section
end

Then /^the storage error message of resource summary section should be:$/ do  |message|
  @bus_site.admin_console_page.resource_summary_section.get_storage_errors.should == message
end


Then /^resource summary section shouldn't have any storage errors$/ do
  @bus_site.admin_console_page.resource_summary_section.storage_errors_visible?.should == false
end
