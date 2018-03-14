Feature: Login freyja

  @TC.121708 @freyja @freyja_smoke  @ent  @ent_login_logout   @ent_smoke @QA12 @QA6 @std @prd @ROR_smoke
  Scenario: MozyEnterprise user login freyja valid username and password
    When I navigate to freyja ent login page
    And I login as a existing user
    Then freyja page is displayed
    When I select options menu
    And I logout

