Then /^Supplemental plans should be:$/ do |supp_plans|

end

When /^I change (.+) plan units to (\d+)$/ do |target_plan, new_units|
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.account_overview_section.navigate_to_link('Supplemental Plans')
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.supplemental_plans_section.view_plan_units_details(target_plan)
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.change_plan_units_section.change_plan_units(new_units)
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.save_plan_units_section.save_plan_units
end

Then /^Supplemental plan units should be changed$/ do
  @aria_site.accounts_page.outer_if.main_if.work_if.inner_work_if.supplemental_plans_section.messages.should include('Plan Change Saved. This change will take effect immediately.')
end