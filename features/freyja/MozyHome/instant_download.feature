Feature: Instant Download

  Background:
    Given I have login freyja as home user

  @TC.120346 @freyja @freyja_smoke  @home  @home_instant_download_Sync_file  @home_instant_download_Sync
  Scenario: home user instant download one file in Freyja
    When I select the Synced tab
    And I choose one file
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
    When I select options menu
    And I logout

  @TC.120346 @freyja @freyja_smoke  @home  @home_instant_download_Sync_folder  @home_instant_download_Sync
  Scenario: home user instant download one folder in Freyja
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
    When I select options menu
    And I logout