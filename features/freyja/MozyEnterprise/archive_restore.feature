Feature: Archive Restore

Background:
    Given I have login freyja as ent user

  @TC.121724   @freyja @freyja_smoke @ent  @ent_archive_restore_one_file  @ent_archive_restore  @ent_smoke  @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user archive restore one file in Freyja
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    #And I download the previous archive result
    When I select options menu
    And I logout


  @TC.121724   @freyja @freyja_smoke  @ent  @ent_archive_restore_one_folder   @ent_archive_restore @ent_smoke @QA12 @QA6  @std @prd
  Scenario: MozyEnterprise user archive restore one folder in Freyja
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | archive     |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    And I download the previous archive result
#    When I select options menu
#    And I logout


