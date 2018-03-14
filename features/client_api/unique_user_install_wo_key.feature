Feature: unique user install w/o key client dependant on BUS


  Background:
    Given I log in bus admin console as administrator

  @TC.20262 @bus @client_api @smoke @tasks_p1
  Scenario: 20262 Bundled - Activating machine success
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20262-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices newly
      | user_email  | machine_name | machine_type |
      | @user_email | M_20262_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20375 @bus @client_api @tasks_p1
  Scenario: 20375 Bundled - Activating server device success
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 12 TB     | yes         |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20375-1 | Server       | 250           | 4       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type |
      | @user_email | M_20375_user | Server       |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20266 @bus @client_api @tasks_p1
  Scenario: 20266 Bundled - Activating machine which have been activated success
    When I add a new MozyPro partner:
      | period | base plan | country        | create under | server plan | storage add on | cc number        |
      | 24     | 2 TB      | United Kingdom | MozyPro UK   | yes         |     10         | 4916783606275713 |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20266-1 | Server       | 2             | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate same devices twice
      | user_email  | machine_name | machine_type |
      | @user_email | M_20266_user | Server       |
    Then activate machine result should be
      | code | body                           |
      | 200  | <%=@clients[0].response.body%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20268 @bus @client_api @tasks_p1
  Scenario: 20268 Bundled - Activating machine fail because of none machine hash
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 10 GB     |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20268-1 | Desktop      | 10            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with none machine hash
      | user_email  | machine_name | machine_type |
      | @user_email | M_20268_user | Desktop      |
    Then activate machine result should be
      | code |
      | 404  |
    And I use keyless activation to activate devices with wrong codename
      | user_email  | machine_name | machine_type |
      | @user_email | M_20268_user | Desktop      |
    Then activate machine result should be
      | code | body                                                        |
      | 400  | {"error_description":"Wrong Client","error":"wrong-client"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20264 @bus @client_api @tasks_p1
  Scenario: 20264 Bundled - Activating machine fail because of invalid machine hash
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 500 GB    | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20264-1 | Desktop      | 30            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with invalid machine hash
      | user_email  | machine_name | machine_type |
      | @user_email | M_20264_user | Desktop      |
    Then activate machine result should be
      | code | body                                                                         |
      | 400  | {"error_description":"Invalid machine hash.","error":"invalid-machine-hash"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20269 @bus @client_api @tasks_p1
  Scenario: 20269 Bundled - Activating machine fail because of no more device available
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 28 TB     | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20269-1 | Desktop      | 300           | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name  | machine_type |
      | @user_email | M1_20269_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I use keyless activation to activate devices unsuccessful
      | user_email  | machine_name  | machine_type |
      | @user_email | M2_20269_user | Desktop      |
    Then activate machine result should be
      | code | body                                                                         |
      | 400  | {"error_description":"No available devices.","error":"no-available-devices"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

######################################################################################
  @TC.20369 @bus @client_api @tasks_p1
  Scenario: 20369 Itemized - Activating machine success
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Test | Shared               | 5               | Shared              | 10             |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices |
      | TC.20369.User | Test       | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type |
      | @user_email | M_20369_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20376 @bus @client_api @tasks_p1
  Scenario: 20376 Itemized - Activating server device success
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 1     | 500 GB      |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           |storage_type | storage_limit | devices |
      | TC.20376-1 | (default user group) |Server       | 50            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type |
      | @user_email | M_20376_user | Server       |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20373 @bus @client_api @tasks_p1
  Scenario: 20373 Itemized - Activating machine which have been activated success
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 24     | 18    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20373-1 | (default user group) | Server       | 2             | 4       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate same devices twice
      | user_email  | machine_name | machine_type |
      | @user_email | M_20373_user | Server       |
    Then activate machine result should be
      | code | body                           |
      | 200  | <%=@clients[0].response.body%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20374 @bus @client_api @tasks_p1
  Scenario: 20374 Itemized - Activating machine fail because of none machine hash
    When I add a new MozyEnterprise partner:
      | period | users |
      | 36     | 50    |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20374-1 | (default user group) | Desktop      | 10            | 50       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with none machine hash
      | user_email  | machine_name | machine_type |
      | @user_email | M_20374_user | Desktop      |
    Then activate machine result should be
      | code |
      | 404  |
    And I use keyless activation to activate devices with wrong codename
      | user_email  | machine_name | machine_type |
      | @user_email | M_20374_user | Desktop      |
    Then activate machine result should be
      | code | body                                                        |
      | 400  | {"error_description":"Wrong Client","error":"wrong-client"} |
    # leave a case here for bug #144905
    # that bus can not parse API devices/:device_hash/activate correctly when device hash is blankspace
    And I use keyless activation to activate devices with blank machine hash
      | user_email  | machine_name | machine_type |
      | @user_email | M_20374_user | Desktop      |
    Then activate machine result should be
      | code | body                                                                        |
      | 400  | {"error_description":"Invalid machine hash","error":"invalid-machine-hash"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20371 @bus @client_api @tasks_p1
  Scenario: 20371 Itemized - Activating machine fail because of invalid machine hash
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 10    | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20371-1 | (default user group) | Desktop      | 10            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with invalid machine hash
      | user_email  | machine_name | machine_type |
      | @user_email | M_20371_user | Desktop      |
    Then activate machine result should be
      | code | body                                                                         |
      | 400  | {"error_description":"Invalid machine hash.","error":"invalid-machine-hash"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20293 @bus @client_api @tasks_p1
  Scenario: 20293 Itemized - Activating machine fail because of no key available
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 12     | 15    | 16 TB       | 5             |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20293-1 | (default user group) | Desktop      | 300           | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name  | machine_type |
      | @user_email | M1_20293_user | Desktop      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I use keyless activation to activate devices unsuccessful
      | user_email  | machine_name  | machine_type |
      | @user_email | M2_20293_user | Desktop      |
    Then activate machine result should be
      | code | body                                                                         |
      | 400  | {"error_description":"No available devices.","error":"no-available-devices"} |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20267 @bus @client_api @tasks_p1
  Scenario: 20267 Activating machine fail because of none access token
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 36     | 10    | 16 TB       | 1             |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | user_group           |
      | TC.20267-1 | Desktop      | 50            | 3       | (default user group) |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with none access token
      | user_email  | machine_name  | machine_type |
      | @user_email | M1_20267_user | Desktop      |
    Then activate machine result should be
      | code | body                 |
      | 401  | ERROR: invalid token |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20263 @bus @client_api @tasks_p1
  Scenario: 20263 Activating machine fail because of error access token
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 12     | 100 GB    | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20263-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices with error access token
      | user_email  | machine_name | machine_type |
      | @user_email | M_20263_user | Desktop      |
    Then activate machine result should be
      | code | body                 |
      | 401  | ERROR: invalid token |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

