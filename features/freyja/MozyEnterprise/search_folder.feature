Feature: Search

  Background:
    Given I have login freyja as ent user

  @TC.121728  @freyja @freyja_smoke  @ent @ent_search  @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user search folder through Freyja
  When I select the Synced tab
  When I enter search folder keyword in search box
  And I click search
  Then search results is displayed
  When I select the Devices tab
  When I enter search folder keyword in search box
  And I click search
  Then search results is displayed
#  When I select options menu
#  And I logout

