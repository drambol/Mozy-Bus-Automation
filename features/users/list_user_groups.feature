Feature: list user groups

  Background:
    Given I log in bus admin console as administrator

  @TC.838 @bus @tasks_p2 @list_user_groups
  Scenario: Mozy-838:List User Groups with no filter
    When I add a new OEM partner:
      | Company Name    | Root role          | Company Type     |
      | test_for_838    | OEM Partner Admin  | Service Provider |
    Then New partner should be created
    Then I view the newly created subpartner admin details
    And I active admin in admin details default password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created subpartner admin email and password default password
    When I add a new user group for an itemized partner:
      | name            |
      | 838_user_group  |
    When I navigate to List User Groups section from bus admin console page
    Then I set user group filter to None
    Then MozyPro Itemized user groups table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota           | Desktop Keys | Desktop quota          |
      | (default user group) * | 0     | 1      |     0 / 0   | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.0 (0.0 active) / 0.0 |
      | 838_user_group         | 0     | 1      |     0 / 0   | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.0 (0.0 active) / 0.0 |
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name

  @TC.839 @bus @tasks_p2 @list_user_groups
  Scenario: Mozy-839:List all Non-empty user groups
    When I add a new OEM partner:
      | Company Name    | Root role         | Company Type     |
      | test_for_839    | OEM Partner Admin | Service Provider |
    Then New partner should be created
    Then I view the newly created subpartner admin details
    And I active admin in admin details default password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created subpartner admin email and password default password
    When I add a new user group for an itemized partner:
      | name            |
      | 839_user_group  |
    And I add new itemized user(s):
      | user_group     | name     |
      | 839_user_group | oem user |
    And new itemized user should be created
    When I navigate to List User Groups section from bus admin console page
    Then I set user group filter to Non-empty
    Then MozyPro Itemized user groups table should be:
      | Name           | Users | Admins | Server Keys | Server Quota           | Desktop Keys | Desktop quota          |
      | 839_user_group | 1     | 1      |     0 / 0   | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.0 (0.0 active) / 0.0 |
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
