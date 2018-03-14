Feature: File Versions

  Background:
    Given I have login freyja as home user

  @TC.120515 @freyja @freyja_smoke  @home  @home_versions @home_view_download_sync_file_versions
  Scenario: home user view file versions in Sync container
  When I select the Synced tab
  And I choose one file with versions
  And I open Actions panel
  And I click Show Versions
  Then file versions are displayed
  When I select the latest version
  And I open Actions panel
  And I click download now
  When I select options menu
  And I select event history
  Then this restore is Completed
  When I select options menu
  And I logout

@TC.120515 @freyja  @freyja_smoke @home  @home_versions @home_view_download_backup_file_versions @home_view_instant_download_backup_file_versions
  Scenario: home user view file versions in Sync container
    When I select the Devices tab
    And I choose one file with versions
    And I open Actions panel
    And I click Show Versions
    Then file versions are displayed
    When I select the latest version
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
    When I select options menu
    And I logout

  @TC.120515 @freyja  @freyja_smoke @home  @home_versions @home_view_download_backup_file_versions @home_view_Fryr_download_backup_file_versions
Scenario: home user view file versions in Sync container
  When I select the Devices tab
  And I choose one file with versions
  And I open Actions panel
  And I click Show Versions
  Then file versions are displayed
  When I select the latest version
  And I open Actions panel
  And I click Large Download Options restore wizard
  And I fill out the restore wizard
    | restore_name           | restore_type |
    | Restore_Manager_folder | fryr         |
  When I select options menu
  And I select event history
  Then this restore is Ready for Download
  When I select options menu
  And I logout

@TC.120515 @freyja @freyja_smoke  @home  @home_versions @home_view_download_backup_file_versions @home_view_archive_download_backup_file_versions
  Scenario: home user view file versions in Sync container
    When I select the Devices tab
    And I choose one file with versions
    And I open Actions panel
    And I click Show Versions
    Then file versions are displayed
    When I select the latest version
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name           | restore_type |
      | Restore_Manager_folder | archive         |
    When I select options menu
    And I select event history
    Then this restore is Processing
    When I select options menu
    And I logout

  @TC.120515 @freyja @freyja_smoke  @home  @home_versions @home_view_download_backup_file_versions @home_view_media_download_backup_file_versions
  Scenario: home user view file versions in Sync container
    When I select the Devices tab
    And I choose one file with versions
    And I open Actions panel
    And I click Show Versions
    Then file versions are displayed
    When I select the latest version
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name           | restore_type |
      | Restore_Manager_folder | media         |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I select options menu
    And I logout
