Feature: Private Key user Restore Files

  Background:
    Given I have login freyja as pro and private_key user

  @TC.120363 @freyja @freyja_smoke  @pro  @pro_restore_all_fryr_pk @pro_restore_pk
  Scenario: pro user restore all file through restore manager in Freyja
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name             | restore_type |
      | Restore_Manager_all_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout

  @TC.120363 @freyja @freyja_smoke @pro  @pro_restore_all_archive_pk @pro_restore_pk
  Scenario: pro user restore all file through archive in Freyja
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name             | restore_type |
      | archive_all_file | archive         |
    When I select options menu
    And I select event history
    Then this restore is Processing
    When I select options menu
    And I logout

  @TC.120363 @freyja @freyja_smoke @pro @pro_restore_all_media_pk @pro_restore_pk
Scenario: pro user restore all file through media in Freyja
  When I select the Devices tab
  And I choose one device
  And I click restore all files in the detail panel
  And I fill out the restore all files wizard
    | restore_name             | restore_type |
    | archive_all_file | media         |
  When I select options menu
  And I select event history
  Then this restore is In Progress
  When I select options menu
  And I logout

@TC.120363 @freyja  @freyja_smoke  @pro  @pro_instant_download_Sync_file_pk  @pro_restore_pk
  Scenario: pro user instant download one file in Freyja
    When I select the Synced tab
    And I choose one file
    And I open Actions panel
    And I click download now for non-default key files
    And I fill out non-default key restore wizard
      | restore_name             | restore_type |
      | Restore_Manager_sync_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout
