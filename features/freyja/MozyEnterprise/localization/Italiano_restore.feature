Feature: Localization login and restore

  Background:
    Given I have login freyja as ent user using language Italiano

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Italiano @ent_localization_Italiano_instant_restore
  Scenario: MozyEnterprise user Italiano localization login and instant restore
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completato
#    When I select options menu
#    And I logout


  @TC. @freyja @freyja_smoke @ent1  @ent_localization @ent_localization_Italiano @ent_localization_Italiano_restore_manager_restore
  Scenario: MozyEnterprise user Italiano localization login and restore manager restore
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name         | restore_type |
      | Restore_Manager_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Pronto per il download
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Italiano @ent_localization_Italiano_archive_restore
  Scenario: MozyEnterprise user Italiano localization login and archive restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Elaborazione in corso
    And I download the previous archive result
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Italiano @ent_localization_Italiano_media_restore
  Scenario: MozyEnterprise user Italiano localization login and media restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | media     |
    When I select options menu
    And I select event history
    Then this restore is In corso
#    When I select options menu
#    And I logout