Feature: Remove a user

  Background:
    Given I log in bus admin console as administrator

  @TC.20938 @bus @2.5 @manage_storage @remove_user @bundled @reseller @regression @core_function
  Scenario: 20938 [Bundled][Reseller] Delete user from new user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    When I add a new Bundled user group:
      | name              | storage_type | assigned_quota | server_support |
      | TC.20938-Assigned | Assigned     | 50             | yes            |
    Then TC.20938-Assigned user group should be created
    When I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  |
      | 50 GB     | 50 GB |
    And I add new user(s):
      | name       | user_group        | storage_type | storage_limit | devices |
      | TC.20938-1 | TC.20938-Assigned | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 5 GB    |
    And I delete user
    And I add new user(s):
      | name       | user_group        | storage_type | storage_limit | devices |
      | TC.20938-2 | TC.20938-Assigned | Server       | 20            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    And I delete user
    When I refresh Search List User section
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20944 @bus @tasks_p2 @remove_user
  Scenario: 20944 [Itemized][Enterprise] Delete user from default user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20944-1 | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 5 GB    |
    When I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | used  | Available |
      | 5 GB         | 250 GB        | 0           | 100 GB       | 5 GB  | 345 GB    |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync  | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 5 GB                 | 1                    | 10                    | Shared              |                   | 0                   | 0                   | 200                  |
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    Then I act as partner by:
      | email        |
      | @admin_email |
    And I search user by:
      | keywords   |
      | @user_name |
    Then I view user details by newly created user email
    And I delete user
    When I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | used |Available |
      | 0            | 250 GB        | 0           | 100 GB       | 0    |350 GB    |
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Incorrect email or password.
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.20945 @bus @2.5 @manage_storage @remove_user @itemized @enterprise @regression @core_function
  Scenario: 20945 [Itemized][Enterprise] Delete user from new user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    When I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20945-Assigned | Assigned             | 50                    | 1                | Assigned            | 50                    | 2              |
    Then TC.20945-Assigned user group should be created
    When I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used   |
      | 50 GB        | 250 GB        | 50 GB       | 100 GB       | 250 GB    | 100 GB |
    And I add new user(s):
      | name       | user_group        | storage_type | storage_limit | devices |
      | TC.20945-1 | TC.20945-Assigned | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 5 GB    |
    And I delete user
    And I add new user(s):
      | name       | user_group        | storage_type | storage_limit | devices |
      | TC.20945-2 | TC.20945-Assigned | Server       | 20            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    And I delete user
    When I refresh Search List User section
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20946 @bus @2.5 @manage_storage @remove_user @mozypro @regression @core_function
  Scenario: 20946 [MozyPro] Delete device
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20946-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    And I delete user
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20946-1 | Server       | 20            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete user
    And I refresh Search List User section
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
