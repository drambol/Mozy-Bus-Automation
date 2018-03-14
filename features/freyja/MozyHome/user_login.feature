Feature: Login freyja

  @TC.120358 @freyja @freyja_smoke  @home  @home_login_logout @QA12 @QA6 @std @prd
  Scenario: home user login freyja valid username and password
    When I navigate to freyja home login page
    And I login as a existing user
    Then freyja page is displayed
    When I select options menu
    And I logout

