Feature: Restore Manager Restore

  Background:
    Given I have login freyja as ent user

  @TC.121725  @freyja @freyja_smoke  @ent  @ent_restore_manager_restore_one_file @ent_restore_manager_restore  @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user restore one file through restore manager in Freyja
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

 @TC.121725  @freyja @freyja_smoke  @ent  @ent_restore_manager_restore_one_folder @ent_restore_manager_restore  @ent_smoke @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user restore one file through restore manager in Freyja
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
#    When I select options menu
#    And I logout