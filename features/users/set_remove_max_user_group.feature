Feature: Set Remove Max at User Group

  Background:
    Given I log in bus admin console as administrator

  @TC.21002 @bus @2.5 @manage_storage @bundled @reseller @regression @core_function
  Scenario: 21002 [Bundled][Reseller] Change Group Share with Max value less than used quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type | assigned_quota | server_support |
      | TC.21002 UG | Assigned     | 50             | yes            |
    Then TC.21002 UG user group should be created
    And I add new user(s):
      | name       | user_group  | storage_type | devices |
      | TC.21002-1 | TC.21002 UG | Desktop      | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 40 GB
    When I edit TC.21002 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.21002 UG | Assigned     | 30             |
    Then Edit user group error messages should be:
      """
      storage can only be assigned between 40 and 100 GB.
      """
    When I edit TC.21002 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.21002 UG | Limited      | 30            |
    Then TC.21002 UG user group should be updated
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21019 @bus @tasks_p3 @manage_storage
  Scenario: 21019 [Itemized] Change Group Share with Max value less than used quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 50             | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type | assigned_quota | server_support |
      | TC.21019 UG | Assigned     | 50             | yes            |
    Then TC.21019 UG user group should be created
    And I add new user(s):
      | name           | user_group  | storage_type | devices |
      | TC.21019.User1 | TC.21019 UG | Desktop      | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name    | machine_type | partner_name  |
      | @user_email | Machine_21019_1 | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 40 GB
    When I edit TC.21019 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.21019 UG | Assigned     | 30             |
    Then Edit user group error messages should be:
      """
      storage can only be assigned between 40 and 50 GB.
      """
    When I edit TC.21019 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.21019 UG | Limited      | 30            |
    Then TC.21019 UG user group should be updated
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21060 @TC.21061 @bus @tasks_p3 @manage_storage
  Scenario: 21060-21061 [Itemized] Verify machine backup behavior when UG hits MAX
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 50             | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type | assigned_quota | server_support |
      | TC.21060 UG | Assigned     | 20             | yes            |
    Then TC.21060 UG user group should be created
    And I add new user(s):
      | name           | user_group  | storage_type | storage_limit | devices |
      | TC.21060.User1 | TC.21060 UG | Desktop      | 15            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name    | machine_type | partner_name  |
      | @user_email | Machine_21060_1 | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I upload data to device by batch
      | machine_id                  | GB | upload_file |
      | <%=@clients[0].machine_id%> | 15 | false       |
    And I upload data to device by batch
      | machine_id                  | GB    | upload_file |
      | <%=@clients[0].machine_id%> | 0.001 | true        |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I update the newly created machine used quota to 10 GB
    And I upload data to device by batch
      | machine_id                  | GB    | upload_file |
      | <%=@clients[0].machine_id%> | 0.001 | true        |
    Then tds returns successful upload
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21146 @bus @tasks_p3 @manage_storage
  Scenario: 21146 [Bundled]Removed Device is returned to UG
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]Removed Device |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | TC.21146 UG | Shared               | 5               | Shared              | 50             | yes          |
    And I add new user(s):
      | name           | user_group  | storage_type | storage_limit | devices |
      | TC.21146.User1 | TC.21146 UG | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords       |
      | TC.21146.User1 |
    And I view user details by TC.21146.User1
    When  I edit user device quota to 2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    And I close user details section
    And I add new user(s):
      | name           | user_group  | storage_type | storage_limit | devices |
      | TC.21146.User2 | TC.21146 UG | Server       | 50            | 40      |
    Then 1 new user should be created
    And I search user by:
      | keywords       |
      | TC.21146.User2 |
    And I view user details by TC.21146.User2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 48  |
    When  I edit user device quota to 38
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 38        | Server       |
    And I close user details section
    When I search user by:
      | keywords       |
      | TC.21146.User1 |
    And I view user details by TC.21146.User1
    And The range of device by tooltips should be:
      | Min | Max |
      | 0   | 12  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
