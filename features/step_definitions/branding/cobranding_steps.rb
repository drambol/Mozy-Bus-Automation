When /^I clean up png files in downloads folder$/ do
  FileHelper.clean_up_csv("*.png")
end

And /^I upload image (.+) for (Web Portal|Win Client|Mac Client) for Co-Branding$/ do |file, platform|
  @bus_site.admin_console_page.branding_section.cobrand_iframe.select_image_platform(platform)
  @bus_site.admin_console_page.branding_section.cobrand_iframe.attach_image_file(file)
  @bus_site.admin_console_page.branding_section.cobrand_iframe.click_save_changes
end

And /^I (activate|deactivate) Co-branding$/ do |option|
  if option == 'activate'
    @bus_site.admin_console_page.branding_section.cobrand_iframe.activate_cobranding
  else
    @bus_site.admin_console_page.branding_section.cobrand_iframe.deactivate_cobranding
  end
end

And /^I download the partner branding img as file (.+) on top left side of dashboard$/ do |file_name|
  @bus_site.admin_console_page.download_top_image(file_name)
end

Then /^the downloaded top img (.+) should be same as the upload img (.+)$/ do |download_file_name, upload_file_name|
  uploaded_file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/test_data/#{upload_file_name}"
  uploaded_file_path.gsub!('/', '\\') if OS.windows?
  uploaded_hash = Digest::MD5.hexdigest(File.read(uploaded_file_path))
  downloaded_file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/downloads/#{download_file_name}"
  downloaded_file_path.gsub!('/', '\\') if OS.windows?
  # waite for image file fully downloaded
  5.times do
    break if File.exists?(downloaded_file_path)
    sleep(1)
  end
  downloaded_hash = Digest::MD5.hexdigest(File.read(downloaded_file_path))
  downloaded_hash.should == uploaded_hash
end

# The step only check that the src of img is changed to co-branding img file name, not check the img content
Then /^the top img should be changed to the branding one$/ do
  img_url = @bus_site.admin_console_page.get_top_image_url
  Log.debug img_url
  img_url.include?("logo-top-cb").should be_true
end