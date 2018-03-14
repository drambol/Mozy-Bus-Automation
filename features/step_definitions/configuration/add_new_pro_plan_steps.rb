When /^I add a new pro plan for (MozyEnterprise|Mozypro|Reseller|OEM|MozyEnterprise DPS) partner:$/ do |partner_type, table|
  pro_plan = friendly_hash(table.hashes.first)
  plan = {}
  pro_plan.each do |k, v|
    if k.match(/(server|desktop|grandfathered)_(.+)/)
      plan[$1] ||= {}
      plan[$1][$2.to_sym] = v
    else
      plan[k] = v
    end
  end
  desktop_server_default = {price_per_key:1, min_keys:1, price_per_gigabyte:1, min_gigabytes:1}
  if partner_type == 'MozyEnterprise'
    (plan['server'] ||= desktop_server_default) unless @partner.server_plan == 'None'
    plan['desktop'] ||= desktop_server_default
  elsif partner_type == 'OEM'
    plan['server'] ||= desktop_server_default
    plan['desktop'] ||= desktop_server_default
    plan['grandfathered'] ||= desktop_server_default unless plan['pooled'] == 'yes'
  else
    plan['generic'] ||= {price_per_gigabyte:1, min_gigabytes:1}
  end
  pro_plan = Bus::DataObj::ProPlan.new(plan)
  @bus_site.admin_console_page.add_new_pro_plan_section.add_new_pro_plan(pro_plan)
end

When /^add new pro plan success message should be displayed$/ do
  @bus_site.admin_console_page.add_new_pro_plan_section.anpp_messages.should match(/Pro plan was successfully created./)
end

Then /^list pro plan is$/ do |proplan_info|
  @bus_site.admin_console_page.add_new_pro_plan_section.get_proplan_info.should == proplan_info.raw
end
