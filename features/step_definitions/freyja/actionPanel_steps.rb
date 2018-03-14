
# click download now
And /^I click download now$/ do
  @restore = Freyja::DataObj::Restore.new
  @restore.restore_type = 'instant'
  case  @user.keyType
    when 'ckey'
      @freyja_site.action_panel_page.click_download_now_non_default_key
    when 'private_key'
      @freyja_site.action_panel_page.click_download_now_non_default_key
    else
      @freyja_site.action_panel_page.click_download_now
  end
end

#  launch large download options section
And /^I click Large Download Options restore wizard$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//div[@id='act-moreDownload']/div[2]"
  @freyja_site.action_panel_page.open_restore_wizard(section_id)
end

#  fill restore wizard
#
# Available columns: restore name, restore type
#
And /^I fill out the restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first
  @restore.restore_name = attributes["restore_name"] + "#{Time.now.strftime("%Y%m%d-%H%M%S")}" unless attributes["restore_name"].nil?
  @restore.restore_type = attributes["restore_type"] unless attributes["restore_type"].nil?

  @freyja_site.action_panel_page.large_download_options_section.large_download_options_restore(@restore, @user.language)
  if @restore.restore_type == 'media'
    @freyja_site.cybersource_page.fill_media_billing_info(@restore, @user.language)
  end

end

# launch upload files wizard in Sync device
And /^I click Upload Files$/ do
  @freyja_site.action_panel_page.click_upload_file_from_Actions_panel
end

# upload files in Sync device
And /^I upload one file$/ do
  @freyja_site.action_panel_page.upload_iframe.attach_one_file
  @freyja_site.action_panel_page.click_upload_files_in_Upload_panel
end

# upload files
Then /^one file is uploaded successfully$/ do
  uploaded_file_path = QA_ENV['local_file_upload']
  uploaded_file_name = uploaded_file_path.split('/')[-1]
  @freyja_site.action_panel_page.check_one_file_uploaded(@user.sync_machineID, uploaded_file_name)
end


And /^I click Delete and confirm$/ do
  @freyja_site.action_panel_page.delete_one_file
end

# launch version show page
And /^I click Show Versions$/ do
  @freyja_site.action_panel_page.click_show_versions
end

Then /^file versions are displayed$/ do
  @freyja_site.action_panel_page.check_file_versions
end

And /^I click Include Deleted Files$/ do
  @freyja_site.action_panel_page.click_include_exclude_deleted
end

And /^I click Exclude Deleted Files$/ do
  @freyja_site.action_panel_page.click_include_exclude_deleted
end

And /^I click Add to Restore Queue$/ do
  @freyja_site.action_panel_page.add_restore_queue
end

When /^I click View Restore Queue$/ do
  @freyja_site.action_panel_page.view_restore_queue
end

And /^I click Remove from Restore Queue$/ do
  @freyja_site.action_panel_page.remove_restore_queue
end

#  fill restore wizard for private key or ckey users
#
# Available columns: restore name, restore type
#
And /^I fill out non-default key restore wizard$/ do |restore_table|
  attributes = restore_table.hashes.first
  @restore.restore_name = attributes["restore_name"] + "#{Time.now.strftime("%Y%m%d-%H%M%S")}" unless attributes["restore_name"].nil?
  @restore.restore_type = attributes["restore_type"] unless attributes["restore_type"].nil?

  @freyja_site.action_panel_page.non_default_key_download_section.non_default_key_sync_Fryr_restore(@restore)
end

And /^I click download now for non-default key files$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//div[@id='act-download']/div[2]"
  @freyja_site.action_panel_page.open_restore_wizard(section_id)
end

And /^I click Change Date$/ do
  @freyja_site.action_panel_page.click_change_date
end