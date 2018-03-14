Feature: Assign User To A New Partner

  As an admin,
  I want to assign a user to a different partner,
  So that their resources and settings will be designated by that partner.

  Success Criteria:
  -If the user is part of a user group...
  -If the user is backing up...
  -If the user has a stash container...

  Background:
    Given I log in bus admin console as administrator

  @change_partner @BUG.74566 @env_dependent
  Scenario: Change Partner
    When I act as partner by:
      | name          |
      | Belgacom Root |
    When I add a new user:
      | desktop licenses | desktop quota |
      | 0                | 0             |
    And I search user by:
      | keywords    | user type           |
      | @user_email | Belgacom Root Users |
    And I view user details by @user_email
    And I reassign the user to partner Enterprise Customer
    Then the user's partner should be Enterprise Customer
    Then I delete user
