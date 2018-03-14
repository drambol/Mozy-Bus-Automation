When /^I search aria account by (.+)$/ do |search_key|
  @aria_site.admin_tools_page.navigate_to_link(CONFIGS['aria']['primary_menu']['accounts'])
  @aria_site.admin_tools_page.navigate_to_link(CONFIGS['aria']['secondary_menu']['search'])
  @aria_site.accounts_page.outer_if.main_if.work_if.side_menu_section.search_account(search_key)
end