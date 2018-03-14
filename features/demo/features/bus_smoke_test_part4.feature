Feature: BUS smoke test 3
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04' related scenarios ===================
  @bus_us @TC.125954 @qa @ROR_smoke
  Scenario: Test Case Mozy-125954: BUS US -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                                                     | period | base plan | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04 | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | user with machine | (default user group) | Desktop      | 5             | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
