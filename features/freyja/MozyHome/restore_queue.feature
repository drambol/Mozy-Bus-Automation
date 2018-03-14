Feature: Restore files in Restore Queue

  Background:
    Given I have login freyja as home user

  @TC.120700 @freyja @freyja_smoke @home  @home_add_remove_files_restore_queue @home_restore_queue
  Scenario: MozyEnterprise user instant download files in Restore Queue from Freyja
    When I select options menu
    And I select Preferences
    And I choose Yes for restore queue
    And I click save Preferences button
    Then freyja page should be enable restore queue
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Add to Restore Queue
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Add to Restore Queue
    When I click View Restore Queue
    Then Restore Queue is shown
    And I select all files in Restore Queue
    And I click Remove from Restore Queue
    Then Restore Queue is empty
    When I select options menu
    And I logout

@TC.120700 @freyja @freyja_smoke @home  @home_instant_restore_files_restore_queue @home_restore_queue
Scenario: MozyEnterprise user instant download files in Restore Queue from Freyja
  When I select options menu
  And I select Preferences
  And I choose Yes for restore queue
  And I click save Preferences button
  Then freyja page should be enable restore queue
  When I select the Devices tab
  And I choose one file
  And I open Actions panel
  And I click Add to Restore Queue
  When I click View Restore Queue
  Then Restore Queue is shown
  And I select all files in Restore Queue
  And I click Download in detail panel
  When I select options menu
  And I select event history
  Then this restore is Completed
  When I select options menu
  And I logout

@TC.120700 @freyja @freyja_smoke @home  @home_Fryr_restore_files_restore_queue   @home_restore_queue
Scenario: MozyEnterprise user Fryr download files in Restore Queue from Freyja
  When I select options menu
  And I select Preferences
  And I choose Yes for restore queue
  And I click save Preferences button
  Then freyja page should be enable restore queue
  When I select the Devices tab
  And I choose one file
  And I open Actions panel
  And I click Add to Restore Queue
  When I select the Devices tab
  And I choose one folder
  And I open Actions panel
  And I click Add to Restore Queue
  When I click View Restore Queue
  Then Restore Queue is shown
  And I select all files in Restore Queue
  And I click Large Download Options restore wizard
  And I fill out the restore wizard
    | restore_name           | restore_type |
    | Restore_Manager_folder | fryr         |
  When I select options menu
  And I select event history
  Then this restore is Ready for Download
  When I select options menu
  And I logout


@TC.120700 @freyja @freyja_smoke @home  @home_archive_restore_files_restore_queue   @home_restore_queue
Scenario: MozyEnterprise user archive download files in Restore Queue from Freyja
  When I select options menu
  And I select Preferences
  And I choose Yes for restore queue
  And I click save Preferences button
  Then freyja page should be enable restore queue
  When I select the Devices tab
  And I choose one file
  And I open Actions panel
  And I click Add to Restore Queue
  When I select the Devices tab
  And I choose one folder
  And I open Actions panel
  And I click Add to Restore Queue
  When I click View Restore Queue
  Then Restore Queue is shown
  And I select all files in Restore Queue
  And I click Large Download Options restore wizard
  And I fill out the restore wizard
    | restore_name           | restore_type |
    | Restore_Manager_folder | archive         |
  When I select options menu
  And I select event history
  Then this restore is Processing
  When I select options menu
  And I logout

@TC.120700 @freyja @freyja_smoke @home  @home_media_restore_files_restore_queue   @home_restore_queue
Scenario: MozyEnterprise user media download files in Restore Queue from Freyja
  When I select options menu
  And I select Preferences
  And I choose Yes for restore queue
  And I click save Preferences button
  Then freyja page should be enable restore queue
  When I select the Devices tab
  And I choose one file
  And I open Actions panel
  And I click Add to Restore Queue
  When I select the Devices tab
  And I choose one folder
  And I open Actions panel
  And I click Add to Restore Queue
  When I click View Restore Queue
  Then Restore Queue is shown
  And I select all files in Restore Queue
  And I click Large Download Options restore wizard
  And I fill out the restore wizard
    | restore_name           | restore_type |
    | Restore_Manager_folder | media         |
  When I select options menu
  And I select event history
  Then this restore is In Progress
  When I select options menu
  And I logout