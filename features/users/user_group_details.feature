Feature: view user group details

  Background:
    Given I log in bus admin console as administrator

  @TC.842 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-842:View users that are currently assigned to a user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.842.User | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | External ID | User                        | Name        | Sync     | Machines | Storage           | Storage Used  | Created  | Backed Up |
      |             | <%=@new_users.first.email%> | TC.842.User | Disabled |   0      | 10 GB (Limited)   | None          | today    | never     |
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.843 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-843:View the keys that are assigned and available in a user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 10    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    When I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices |
      | TC.843_group | Shared               | 1               |
    Then TC.843_group user group should be created
    And I add new user(s):
      | name        | user_group   | storage_type | storage_limit | devices |
      | TC.843-user | TC.843_group | Desktop      | 1             | 1       |
    Then 1 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.843_group
    Then I open Keys tab under user group details
    Then the Keys table details under user group details should be:
      |Product Key| User/Email                  |
      |           | <%=@new_users.first.email%> |
    Then I close the user group detail page
    And I view user group details by clicking group name: (default user group)
    Then I open Keys tab under user group details
    Then I check total keys under user group details is 209 results
    Then I click the last keys page under user group details
    Then I wait for 3 seconds
    And There are 14 keys under user group details
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.844 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-844:View the admins that are assigned to a user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.842.User | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Admins tab under user group details
    Then the Admins table details under user group details should be:
      | Name                                 | Email                          |
      | <%=@partner.admin_info.full_name%>   | <%=@partner.admin_info.email%> |
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.845 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-845:View what client configs are assigned to a user group
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC845-group-1 | Shared       | yes            |
    Then TC845-group-1 user group should be created
    When I create a new client config:
      | name                       | type   | user group    |
      | TC845-server-client-config | Server | TC845-group-1 |
    Then client configuration section message should be Your configuration was saved.
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC845-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be TC845-server-client-config
    Then Desktop client configuration should be TC1845-desktop-client-config
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.847 @bus @tasks_p2 @user_group_details @ROR_smoke
  Scenario: Mozy-847:Change the name on a user group
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name         | storage_type | server_support |
      | TC.847-group | Shared       | yes            |
    Then TC.847-group user group should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.847-group
    Then I change user group name to TC.847-group-update
    Then Bundled user groups table should be:
      | Group Name          | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      |(default user group) | true  | true   | Shared       |            | 0            | 0            |
      | TC.847-group-update | false | true   | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.467 @bus @tasks_p2 @user_group_details
  Scenario:Mozy-467:Suspend a User Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 10    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    When I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices |
      | TC.467_group | Shared               | 1               |
    Then TC.467_group user group should be created
    And I add new user(s):
      | name        | user_group   | storage_type | storage_limit | devices |
      | TC.467-user | TC.467_group | Desktop      | 1             | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.467-user
    And I update the user password to default password
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.467_group
    Then I change user group status to Suspended
    Then I use keyless activation to activate devices unsuccessful
      | machine_name | user_name                   | machine_type |
      | Machine1_467 | <%=@new_users.first.email%> | Desktop      |
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    When I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name

  @TC.468 @bus @tasks_p2 @user_group_details
  Scenario:Mozy-468:Activate a User Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 10    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    When I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices |
      | TC.468_group | Shared               | 1               |
    Then TC.468_group user group should be created
    And I add new user(s):
      | name        | user_group   | storage_type | storage_limit | devices |
      | TC.468-user | TC.468_group | Desktop      | 1             | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.468-user
    And I update the user password to default password
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.468_group
    Then I change user group status to Suspended
    Then I change user group status to Active
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine1_468 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.846 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-846:Change the default for a user group
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name        | storage_type | server_support |
      | TC.846-group | Shared       | yes            |
    Then TC.846-group user group should be created
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.846-group
    Then User group details should be:
      | Default storage limit for new users: |
      | (change)                             |
    And I change user group default storage to 1 GB
    Then User group details should be:
      | Default storage limit for new users: |
      | 1 GB (change)                        |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.2171 @bus @tasks_p2 @user_group_details
  Scenario: Mozy-2171:Modify user group in BUS to set it to unlimited quota
    When I add a new OEM partner:
      | Company Name    | Root role         | Security | Company Type     |
      | test_for_2171   | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new user group for an itemized partner:
      | name            |
      | 2171_user_group |
    When I navigate to List User Groups section from bus admin console page
    And I view user group details by clicking group name: 2171_user_group
    And I change legacy user group desktop default storage to -1 GB
    Then User group details should be:
      | Default quota for new installs:           |
      | ∞ GB (Desktop) and 2 GB (Server) (change) |
    Then I stop masquerading as sub partner
    Then I stop masquerading as sub partner
    Then I search and delete partner account by newly created subpartner company name
