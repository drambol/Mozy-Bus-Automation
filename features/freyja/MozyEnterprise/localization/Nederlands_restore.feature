Feature: Localization login and restore

  Background:
    Given I have login freyja as ent user using language Nederlands

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Nederlands @ent_localization_Nederlands_instant_restore
  Scenario: MozyEnterprise user Nederlands localization login and instant restore
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Voltooid
#    When I select options menu
#    And I logout


  @TC. @freyja @freyja_smoke @ent1  @ent_localization @ent_localization_Nederlands @ent_localization_Nederlands_restore_manager_restore
  Scenario: MozyEnterprise user Nederlands localization login and restore manager restore
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name         | restore_type |
      | Restore_Manager_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Gereed voor downloaden
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Nederlands @ent_localization_Nederlands_archive_restore
  Scenario: MozyEnterprise user Nederlands localization login and archive restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Bezig met verwerken
    And I download the previous archive result
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke  @ent1 @ent_localization @ent_localization_Nederlands @ent_localization_Nederlands_media_restore
  Scenario: MozyEnterprise user Nederlands localization login and media restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | media     |
    When I select options menu
    And I select event history
    Then this restore is Wordt uitgevoerd
#    When I select options menu
#    And I logout