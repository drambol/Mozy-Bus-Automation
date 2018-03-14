Feature: Capture City State Zip

  @TC.2357 @bus @city_state_zip @tasks_p3
  Scenario: 2357 Verify that the United States is the default country (MozyPro)
    When I am at dom selection point:
    And I select to add a phoenix MozyPro partner:
    And I verify that the default country is United States

  @TC.2359 @bus @city_state_zip @tasks_p3
  Scenario: 2359 Verify that the United States is the default country (MozyHome)
    When I am at dom selection point:
    And I select to add a phoenix MozyHome partner:
    And I verify that the default country is United States

  @TC.2360 @bus @city_state_zip @tasks_p3
  Scenario: 2360 Verify that the United States is the default country (BUS)
    When I log in bus admin console as administrator
    And I navigate to Add New Partner section
    And I select MozyPro as the company type
    Then I verify default country in Add New Partner page should be United States