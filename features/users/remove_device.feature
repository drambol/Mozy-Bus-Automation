Feature: Remove a device

  Background:
    Given I log in bus admin console as administrator

  @TC.21070 @bus @2.5 @user_view @delete_device @bundled @reseller @regression @core_function
  Scenario: 21070 [Bundled][Reseller] Delete device
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                      |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Reseller] Delete device |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21070-1 | (default user group) | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M1
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I close user details section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21070-2 | (default user group) | Server       | 20            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server       | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M2
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21079 @bus @2.5 @user_view @delete_device @itemized @enterprise @regression @core_function
  Scenario: 21079 [Itemized][MozyEnterprise] Delete device
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                             |
      | 12     | 10    | 100 GB      | yes       | [Itemized][MozyEnterprise] Delete device |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21079-1 | (default user group) | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M1
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I close user details section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21079-2 | (default user group) | Server       | 20            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server       | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M2
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21080 @bus @2.5 @user_view @delete_device @mozypro @regression @core_function @ROR_smoke
  Scenario: 21080 [MozyPro] Delete device
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21080-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M1
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I close user details section
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21080-2 | Server       | 20            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server       | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M2
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I stop masquerading
    And I search and delete partner account by newly created partner company name