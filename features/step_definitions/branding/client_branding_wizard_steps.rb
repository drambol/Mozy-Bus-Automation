And /^I use branding version (.+)$/ do |version|
  @bus_site.branding_page.select_version(version)
end

And /^I use (.+) as branding language$/ do |language|
  @bus_site.branding_page.select_language(language)
end

And /^I choose file (.+) for branding item (.+)$/ do |file, item|
  @bus_site.branding_page.change_branding_item(file,item)
end

Then /^I finish all the branding settings$/ do
  @bus_site.branding_page.finish_settings
  @bus_site.branding_page.setting_saved_message.should == "Your changes have been saved successfully."
end

And /^I wait for branding finished$/ do
  @bus_site.branding_page.start_build
  sleep(15)
  150.times do
    sleep(10)
    break if @bus_site.branding_page.has_branding_done_div?
  end
end

Then /^branding build download link should be generated successfully$/ do
  Log.debug(@bus_site.branding_page.build_done_message)
  @bus_site.branding_page.has_branding_executable_link?.should be_true
  @bus_site.branding_page.close_page
end