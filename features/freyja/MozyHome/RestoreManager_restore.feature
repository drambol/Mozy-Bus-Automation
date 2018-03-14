Feature: Restore Manager Restore

  Background:
    Given I have login freyja as home user

  @TC.120348 @freyja @freyja_smoke  @home  @home_restore_manager_restore_one_file     @home_restore_manager_restore
Scenario: home user restore one file through restore manager in Freyja
  When I select the Devices tab
  And I choose one file
  And I open Actions panel
  And I click Large Download Options restore wizard
  And I fill out the restore wizard
    | restore_name         | restore_type |
    | Restore_Manager_file | fryr         |
  When I select options menu
  And I select event history
  Then this restore is Ready for Download
  When I select options menu
  And I logout

@TC.120348 @freyja @freyja_smoke  @home  @home_restore_manager_restore_one_folder       @home_restore_manager_restore
  Scenario: home user restore one file through restore manager in Freyja
    When I select the Devices tab
    And I choose one folder
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