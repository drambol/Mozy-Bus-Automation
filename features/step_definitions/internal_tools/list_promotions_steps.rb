When /^I search promition (.+)$/ do |promo_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['list_promotions'])
  @bus_site.admin_console_page.list_promotions_section.search_promotion(promo_name)
end

When /^I delete promotion (.+) if exists before creating a new one$/ do |promo|
  step %{I search promition #{promo}}
  if @bus_site.admin_console_page.promotion_details_view_section.delete_promtion_btn_visible.should == true
    @bus_site.log("Find a same name promotion before creating a new one, delete it.")
    step %{I delete promotion}
  else
    @bus_site.log("No same name promotion found.")
  end
end

Given /^I delete promo (.+) from plsql$/ do |promo|
  @bus_site.log("delete promo #{promo} from plslq using update")
  DBHelper.delete_promo(promo)
end