
When (/^I verify download page contents$/) do
  @cms_site = CmsSite.new
  @cms_site.content_pages.load
  @cms_site.content_pages.download_check_verification
end

When /^I go to cms page$/ do
  @cms_site = CmsSite.new
  @cms_site.content_pages.load
end

When /^I download (home|pro|sync) client$/ do |type|
  case type
    when 'home'
      @cms_site.content_pages.download_home_client.should be_true
    when 'pro'
      @cms_site.content_pages.download_pro_client.should be_true
    when 'sync'
      @cms_site.content_pages.download_sync_client.should be_true
  end
end
