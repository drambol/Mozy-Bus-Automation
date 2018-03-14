Feature: Assign User To A New User Group

  As an admin,
  I want to assign a user to a different user group,
  So that their resources and settings will be designated by that user group.

  Success Criteria:
  -If the user is part of a user group...
  -If the user is backing up...
  -If the user has a stash container...

  Background:
    Given I log in bus admin console as administrator

  @change_user_group @env_dependent
  Scenario: Change User Group
    When I act as partner by:
      | email                            |
      | qa1+nancy+sanchez+1535@decho.com |
    When I add a new user:
      | desktop licenses | desktop quota | user group           |
      | 0                | 0             | (default user group) |
    Then New user should be created
    When I search user by newly created user email
    And I view user details by @user_email
    And I reassign the user to user group TC.19063 group
    Then the user's user group should be TC.19063 group
    Then I delete user
