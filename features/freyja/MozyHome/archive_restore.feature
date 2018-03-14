Feature: Archive Restore

Background:
    Given I have login freyja as home user

@TC.120347 @freyja @freyja_smoke @home  @home_archive_restore_one_file  @home_archive_restore
  Scenario: home user archive restore one file in Freyja
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Processing
    When I select options menu
    And I logout


  @TC.120347   @freyja  @freyja_smoke @home  @home_archive_restore_one_folder  @home_archive_restore
  Scenario: home user archive restore one folder in Freyja
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Processing
    When I select options menu
    And I logout


