Feature: Add a new user, execute cucumber features/add_new_user_100.feature

  Background:
    Given I log in bus admin console as administrator

  @shijing @add_new_user
  Scenario: ad new user for shijing 8 tb password is Test1234 QAP@SSw0rd
    When I add a new MozyPro partner:
      | company name                                  | period | base plan | server plan | storage add on |
      | shijing pantheon 8 tb test account DONOT EDIT | 24     | 32 TB     | yes         | 1000           |
    And New partner should be created
    When I act as newly created partner account
    And I add multiple users:
      | name           | storage_type | storage_limit | devices | enable_stash |
      | test-sync-user | Desktop      | 500           | 2       | yes          |
