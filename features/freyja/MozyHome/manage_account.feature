Feature: manage account

  @TC.131855 @freyja @freyja_smoke  @home  @home_manage_account @QA12 @QA6 @std @prd
  Scenario: home user login freyja manage account
    When I navigate to freyja home login page
    And I login as a existing user
    Then freyja page is displayed
    When I select options menu
    And I click manage account
    Then Phoenix account page login successfully

