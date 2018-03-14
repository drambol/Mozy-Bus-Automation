Feature: Instant Download

  Background:
    Given I have login freyja as ent user

  @TC.121723 @freyja  @freyja_smoke  @ent  @ent_instant_download_Sync_file    @ent_instant_download   @ent_smoke @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user instant download one file in Freyja
    When I select the Synced tab
    And I choose one file
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
    When I select options menu
    And I logout

  @TC.121723 @freyja @freyja_smoke   @ent  @ent_instant_download_Sync_folder   @ent_instant_download  @ent_smoke @QA12 @QA6 @std @prd
  Scenario: MozyEnterprise user instant download one folder in Freyja
    When I select the Synced tab
    And I choose one folder
    And I open Actions panel
    And I click download now
    When I select options menu
    And I select event history
    Then this restore is Completed
    When I select options menu
#    And I logout