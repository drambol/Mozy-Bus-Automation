Feature: Bot Scenarios

  Background: This will hold test cases that an ircbot can run to get users.
              #/scripts/ircbot

  @bot
  Scenario:Create and display MozyFree user information
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    Then I display login information

  @bot
  Scenario:Create and display MozyPro user information
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | storage_type | devices | enable_stash |
      | Desktop      | 10      | yes          |
    Then 1 new user should be created
    Then I display login information

  @bot @prod
  Scenario:Create and display PROD MozyPro user information
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms | coupon | account type  |
      | 1      | 100 GB    | yes         | yes       | MOZYQA | Internal Test |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | storage_type | devices | enable_stash |
      | Desktop      | 10      | yes          |
    Then 1 new user should be created
    Then I display login information
