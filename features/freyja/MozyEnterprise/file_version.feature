Feature: File Versions

  Background:
    Given I have login freyja as ent user

  @TC.121716 @freyja @freyja_smoke  @ent  @ent_view_download_sync_file_versions @ent_smoke @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user view file versions in Sync container
    When I select the Synced tab
    And I choose one file with versions
    And I open Actions panel
    And I click Show Versions
    Then file versions are displayed
    When I select the latest version
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
#    When I select options menu
#    And I logout
