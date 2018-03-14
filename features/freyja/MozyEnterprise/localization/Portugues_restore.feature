Feature: Localization login and restore

  Background:
    Given I have login freyja as ent user using language Português (Brasil)

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Portugues @ent_localization_Portugues_instant_restore
  Scenario: MozyEnterprise user Portugues localization login and instant restore
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Concluído
#    When I select options menu
#    And I logout


  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Portugues @ent_localization_Portugues_restore_manager_restore
  Scenario: MozyEnterprise user Portugues localization login and restore manager restore
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name         | restore_type |
      | Restore_Manager_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Pronto para download
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Portugues @ent_localization_Portugues_archive_restore
  Scenario: MozyEnterprise user Portugues localization login and archive restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Processando
    And I download the previous archive result
#    When I select options menu
#    And I logout

  @TC. @freyja @freyja_smoke @ent1 @ent_localization @ent_localization_Portugues @ent_localization_Portugues_media_restore
  Scenario: MozyEnterprise user Portugues localization login and media restore
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | media     |
    When I select options menu
    And I select event history
    Then this restore is Em andamento
    When I select options menu
    And I logout