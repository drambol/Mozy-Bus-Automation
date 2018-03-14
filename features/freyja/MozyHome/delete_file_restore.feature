Feature: Restore Deleted Files

  Background:
    Given I have login freyja as home user

  @TC.120483 @freyja  @freyja_smoke @home  @home_sync_delete_file_restore
Scenario: Mozyhome user restore deleted files in Sync container through Freyja
  When I select the Synced tab
  And I open Actions panel
  And I click Include Deleted Files
  And I choose one deleted file
  And I click download now
  When I select options menu
  And I select event history
  Then this restore is Completed
  When I select the Synced tab
  And I open Actions panel
  And I click Exclude Deleted Files
  Then deleted files isn't shown
  When I select options menu
  And I logout
