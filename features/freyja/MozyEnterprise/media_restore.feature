Feature: Media Restore

  Background:
    Given I have login freyja as ent user

  @TC.121726  @freyja @freyja_smoke  @ent  @ent_media_restore_one_file   @ent_media_restore   @ent_smoke
  Scenario: MozyEnterprise user media restore one file in Freyja
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | media    |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I select options menu
    And I logout


  @TC.121726  @freyja @freyja_smoke  @ent  @ent_media_restore_one_folder  @ent_media_restore  @ent_smoke
  Scenario: MozyEnterprise user media restore one folder in Freyja
    When I select the Devices tab
    And I choose one folder
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name     | restore_type |
      | archive_restore_file | media     |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I select options menu
#    And I logout


