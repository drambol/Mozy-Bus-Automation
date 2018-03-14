
# verify restore queue displayed
Then /^Restore Queue is shown$/ do
  @freyja_site.restore_queue_page.verify_show_restore_queue.should be_true
end

And /^I select all files in Restore Queue$/ do
  @freyja_site.restore_queue_page.select_all_files
end

Then /^Restore Queue is empty$/ do
  @freyja_site.restore_queue_page.verify_no_files_restore_queue.should be_true
end

