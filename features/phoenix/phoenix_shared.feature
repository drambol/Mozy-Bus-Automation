Feature: Phoenix Shared

  These are for any tests cases that are shared between MozyHome and MozyPro in Phoenix

  @TC.120666 @phoenix @regression @core_function
  Scenario: 120666 Login to phoenix with capitalized username
    When I log into phoenix with capitalized username
    Then I navigate to Account Details section from bus admin console page

  @TC.120667 @phoenix @regression @core_function
  Scenario: 120667 Login to phoenix with mixed case username

    When I log into phoenix with mixed case username
    Then I navigate to Account Details section from bus admin console page