When /^I act as partner to get welcome page$/ do
  @bus_site.admin_console_page.partner_details_section.click_act_as_link
end

And /^get welcome page title (.+)$/ do | title |
  @bus_site.admin_console_page.get_welcome_page_title.should == title
end

Then /^click Download Mozy Software link on welcome page$/ do
  @bus_site.admin_console_page.click_download_link_on_welcome_page
end

When /^act as partner and click Download Mozy Software link on welcome page$/ do
  @bus_site.admin_console_page.partner_details_section.click_act_as_link
end

And /^I download the partner backup overview img as file (.+)$/ do |file_name|
  @bus_site.admin_console_page.download_backup_image(file_name)
end