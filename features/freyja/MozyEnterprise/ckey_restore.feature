Feature: Corporate Key user Restore Files

  Background:
    Given I have login freyja as ent and ckey user

  @TC.121721 @freyja @freyja_smoke  @ent @ent_restore_all_fryr_ckey @ent_restore_ckey @QA12  @QA6  @std @prd
  Scenario: ent user restore all file through restore manager in Freyja
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name             | restore_type |
      | Restore_Manager_all_file_ckey | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout

  @TC.121721 @freyja @freyja_smoke @ent  @ent_restore_one_file_archive_ckey @ent_restore_ckey @QA12 @QA6 @std @prd
  Scenario: ent user restore one_file through archive in Freyja
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore all files wizard
      | restore_name             | restore_type |
      | archive_restore_file_ckey | archive         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout

 @TC.121721 @freyja @freyja_smoke @ent @ent_restore_all_media_ckey @ent_restore_ckey
Scenario: ent user restore all file through media in Freyja
  When I select the Devices tab
  And I choose one device
  And I click restore all files in the detail panel
  And I fill out the restore all files wizard
    | restore_name             | restore_type |
    | archive_all_file_ckey | media         |
  When I select options menu
  And I select event history
  Then this restore is In Progress
#  When I select options menu
#  And I logout


@TC.121721 @freyja  @freyja_smoke  @ent  @ent_instant_download_Sync_file_ckey  @ent_restore_ckey @QA12  @QA6 @std @prd
  Scenario: ent user instant download one file in Freyja
    When I select the Synced tab
    And I choose one file
    And I open Actions panel
    And I click download now for non-default key files
    And I fill out non-default key restore wizard
      | restore_name             | restore_type |
      | Restore_Manager_sync_file_ckey | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout
