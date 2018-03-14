Feature: Restore All Files

  Background:
    Given I have login freyja as ent user

  @TC.121719 @freyja @freyja_smoke  @ent_restore_all_fryr @ent_restore_all @ent_smoke @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user restore all file through restore manager in Freyja
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name             | restore_type |
      | Restore_Manager_all_file | fryr         |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout

  @TC.121719 @freyja @freyja_smoke  @ent  @ent_restore_all_archive @ent_restore_all @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user restore all file through archive in Freyja
  When I select the Devices tab
  And I choose one device
  And I click restore all files in the detail panel
  And I fill out the restore all files wizard
    | restore_name             | restore_type |
    | archive_all_file | archive         |
  When I select options menu
  And I select event history
  Then this restore is Ready for Download
  When I select options menu
  And I logout

  @TC.121719 @freyja @freyja_smoke @ent  @ent_restore_all_media @ent_restore_all  @ent_smoke
Scenario: MozyEnterprise user restore all file through media in Freyja
  When I select the Devices tab
  And I choose one device
  And I click restore all files in the detail panel
  And I fill out the restore all files wizard
    | restore_name             | restore_type |
    | archive_all_file | media         |
  When I select options menu
  And I select event history
  Then this restore is In Progress
#  When I select options menu
#  And I logout