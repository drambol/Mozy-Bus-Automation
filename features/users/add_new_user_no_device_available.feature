Feature: Add User: no devices or storage available in UG warning#92741

  Background:
    Given I log in bus admin console as administrator


  @TC.20317 @bus @tasks_p2
  Scenario:  Mozy-20317:Add New User: No Devices Available
    #Mozy-20318:Add New User: No Storage Available
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 100 GB      |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 10            | 11      |
    Then Add new user error message should be:
    """
    Invalid number of Desktop devices
    """
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 251           | 1       |
    Then Add new user error message should be:
    """
    User Group (default user group) does not have enough storage available.
    """
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20319 @bus @tasks_p2
  Scenario:  Mozy-20319:Add New User: No Resources Available
    When I add a new MozyEnterprise partner:
      | period | has_initial_purchase |
      | 12     | false                |
    And New partner should be created
    Then I act as newly created partner account
    Then I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group resource details warning message should be No resources available.
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20035 @bus @tasks_p2
  Scenario:  Mozy-20035:Add New User: No Devices Available
    #Mozy-20037:Add New User: No Resources Available
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 10            | 21      |
    Then Add new user error message should be:
    """
    Invalid number of devices
    """
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 101           | 1       |
    Then Add new user error message should be:
    """
    User Group (default user group) does not have enough storage available.
    """
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20036 @bus @tasks_p2
  Scenario: Mozy-20036:Add New User: No Storage Available
    When I add a new Reseller partner:
      | period | has_initial_purchase |
      | 12     | false                |
    And New partner should be created
    Then I act as newly created partner account
    Then I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details warning message should be No storage available.
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20322 @bus @tasks_p2
  Scenario:  Mozy-20322:Add New User: No Storage Available
    When I add a new MozyPro partner:
      | period | root role               | has_initial_purchase |
      | 12     | Bundle Pro Partner Root | false                |
    And New partner should be created
    Then I act as newly created partner account
    Then I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details warning message should be No storage available.
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20322_1 @bus @tasks_p2
  Scenario: Mozy-20322_1:Add New User: No Storage Available(OEM)
    When I add a new OEM partner:
      | Company Name    | Root role         | Company Type     |
      | test_for_20322  | OEM Partner Admin | Service Provider |
    Then New partner should be created
    And I act as newly created subpartner account
    When I add a new user group for an itemized partner:
      | name                 |
      | itemized_user_group  |
    And I add new itemized user(s):
      | user_group          | name     | devices_desktop | quota_desktop |
      | itemized_user_group | oem user | 1               | 1             |
    Then created new itemized user message should be Only 0 Desktop keys available. Only 0 Desktop GB free
    And I stop masquerading as sub partner
    Then I search and delete partner account by newly created subpartner company name

  @TC.20322_2 @bus @tasks_p2
  Scenario: Mozy-20322_2:Add New User: No resources Available(OEM partner migrate to pooled storage)
    When I add a new OEM partner:
      | Company Name            | Root role         | Company Type     |
      | test_for_20322_migrate  | OEM Partner Admin | Service Provider |
    Then New partner should be created
    And I get the subpartner_id
    Then I migrate the partner to pooled storage
    Then I act as newly created subpartner account
    Then I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group resource details warning message should be No resources available.
    Then I stop masquerading as sub partner
    Then I search and delete partner account by newly created subpartner company name


