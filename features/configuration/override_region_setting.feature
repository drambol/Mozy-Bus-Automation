Feature: Override Region Setting


  Background:
    Given I log in bus admin console as administrator

  @TC.131175 @tasks_p1 @override_region_setting @bus
  Scenario: 131175 Regional Presidence
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    And I change root role to FedID role
    And I add partner settings
      | Name                    | Value     |
      | install_region_override | americas  |
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I change user install override region to qa
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine1_131175 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I upload data to device
      | machine_id                         | GB |
      | <%=@new_clients.last.machine_id%>  | 2  |
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center: |
      | qa6          |
    When I add a new Bundled user group:
      | name            | storage_type | install_region_override |
      | TC.131175_group | Shared       | test_qa5                |
    Then TC.131175_group user group should be created
    And I add new user(s):
      | user_group       | storage_type | storage_limit | devices |
      | TC.131175_group  | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | ug_region |
      | Machine2_131175 | <%=@new_users.last.email%> | Desktop      | test_qa5  |
    And I upload data to device
      | machine_id                         | GB |
      | <%=@new_clients.last.machine_id%>  | 2  |
    When I navigate to Search / List Machines section from bus admin console page
    And I refresh Search List Machines section
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center:  |
      | qa5           |
    And I close User Details section
    And I close machine details section
    And I add new user(s):
      | user_group       | storage_type | storage_limit | devices |
      | TC.131175_group  | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I change user install override region to qa
    And I close User Details section
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine3_131175 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I upload data to device
      | machine_id                         | GB |
      | <%=@new_clients.last.machine_id%>  | 2  |
    When I navigate to Search / List Machines section from bus admin console page
    And I refresh Search List Machines section
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131176 @tasks_p1 @override_region_setting @bus @ROR_smoke
  Scenario: 131176 Regional User - Change
    When I add a new MozyPro partner:
      | period | base plan  | server plan | net terms |
      | 24     | 100 GB     | yes         | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I change user install override region to qa
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine1_131176 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I upload data to device
      | machine_id                        | GB |
      | <%=@new_clients.last.machine_id%> | 2  |
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I refresh User Details section
    And I delete device by name: the newly created device name
    And I change user install override region to test_qa5
    And I close User Details section
    And I close machine details section
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine2_131176 | <%=@new_users.last.email%> | Desktop      | test_qa5    |
    And I upload data to device
      | machine_id                         | GB |
      | <%=@new_clients.last.machine_id%>  | 2  |
    When I navigate to Search / List Machines section from bus admin console page
    And I refresh Search List Machines section
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center:  |
      | qa5           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name



