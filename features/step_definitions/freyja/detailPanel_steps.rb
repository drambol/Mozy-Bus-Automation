# launch restore wizard for the whole machine
And /^I click restore all files in the detail panel$/ do
  @restore = Freyja::DataObj::Restore.new
  section_id = "//*[@id='backup_tab']//a[@title='Restore All Files...']"
  @freyja_site.detail_panel_page.open_restore_all_files_wizard(section_id)
end

#  fill restore wizard to restore all files
#
# Available columns: restore name, restore type
#
And /^I fill out the restore (all files|VMs) wizard$/ do |_, restore_table|
  attributes = restore_table.hashes.first
  @restore.restore_name = attributes["restore_name"] + "#{Time.now.strftime("%Y%m%d-%H%M%S")}" unless attributes["restore_name"].nil?
  @restore.restore_type = attributes["restore_type"] unless attributes["restore_type"].nil?

  @freyja_site.detail_panel_page.restore_all_files_section.restore_all_files(@restore)

  if @restore.restore_type == 'media'
    @freyja_site.cybersource_page.fill_media_billing_info(@restore)
  end

end

# launch download
And /^I click Download in detail panel$/ do
  @restore = Freyja::DataObj::Restore.new
  @restore.restore_type = 'instant'
  case  @user.keyType
    when 'ckey'
      @freyja_site.detail_panel_page.click_download_non_default_key
    when 'private_key'
      @freyja_site.detail_panel_page.click_download_non_default_key
    else
      @freyja_site.detail_panel_page.click_download
  end

end