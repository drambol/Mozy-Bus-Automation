Feature: Restore All Files

  Background:
    Given I have login freyja as home user

  @TC.120475 @freyja @freyja_smoke  @home  @home_restore_all_fryr @home_restore_all
  Scenario: home user restore all file through restore manager in Freyja
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

  @TC.120475 @freyja @freyja_smoke  @home  @home_restore_all_archive @home_restore_all
Scenario: home user restore all file through archive in Freyja
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

@TC.120475 @freyja @freyja_smoke @home @home_restore_all_media @home_restore_all
Scenario: home user restore all file through media in Freyja
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