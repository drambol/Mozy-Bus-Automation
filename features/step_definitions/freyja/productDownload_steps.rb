
# click View website
And /^I click View website$/ do
  @freyja_site.product_download_page.click_view_website
end


And /^I click backup download$/ do
  FileHelper.clean_up_client
  if RbConfig::CONFIG["host_os"].include? "linux"
    @freyja_site.product_download_page.click_additional_download
  else
    @freyja_site.product_download_page.click_backup_software
    @freyja_site.product_download_page.click_backup_sync
  end
end
