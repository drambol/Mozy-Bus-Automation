Feature: Replace Machines

  Background:
    Given I log in bus admin console as administrator

  @TC.868 @bus @machines_sync @tasks_p1 @smoke @ROR_smoke
  Scenario: 868 Replace a machine
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name         | user_group           | storage_type | storage_limit | devices |
      | TC.868.User1 | (default user group) | Desktop      | 100           | 10      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name | user_name                   | machine_type |
      | Machine1_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine2_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Machine1_868
    And I click on the replace machine link
    And I select Machine2_868 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name |
      | Machine2_868 |
    Then I should not search out machine record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.22356 @bus @machines_sync @tasks_p1
  Scenario: 22356:Verify that Enterprise Partner Admins can Replace Machines
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.22356.User1 | (default user group) | Desktop      | 40            | 3       |
      | TC.22356.User2 | (default user group) | Desktop      | 40            | 3       |
    Then 2 new user should be created
    And I search user by:
      | keywords                |
      | <%=@new_users[0].name%> |
    And I view user details by TC.22356.User1
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords                |
      | <%=@new_users[1].name%> |
    And I view user details by TC.22356.User2
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_22356 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_22356 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name   | user_name                | machine_type |
      | Machine1_User2 | <%=@new_users[1].email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Machine2_22356
    And I click on the replace machine link
    Then The machines listed for replacement should be
      | Machine1_22356 |
      | Machine1_User2 |
    And I select Machine1_User2 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name   |
      | Machine1_User2 |
    Then I should not search out machine record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.22454 @bus @machines_sync @tasks_p1
  Scenario: 22454:Verify that BUS Admins can Replace existing machines
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.22454.User1 | (default user group) | Desktop      | 40            | 3       |
      | TC.22454.User2 | (default user group) | Desktop      | 40            | 3       |
    Then 2 new user should be created
    And I search user by:
      | keywords                |
      | <%=@new_users[0].name%> |
    And I view user details by TC.22454.User1
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords                |
      | <%=@new_users[1].name%> |
    And I view user details by TC.22454.User2
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name  | user_name                   | machine_type |
      | auto_generate | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_22454 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name  | user_name                | machine_type |
      | auto_generate | <%=@new_users[1].email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I stop masquerading
    And I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name               |
      | <%=@client.machine_alias%> |
    And I view machine details for @client.machine_alias
    And I click on the replace machine link
    Then The machines listed for replacement should be
      | <%=@clients[0].machine_alias%> |
      | Machine2_22454                 |
    And I select @clients[0].machine_alias to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name                   |
      | <%=@clients[0].machine_alias%> |
    Then I should not search out machine record
    And I search and delete partner account by newly created partner company name

  @TC.2061 @bus @machines_sync @tasks_p2
  Scenario: 2061 Replace a machine
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.2061.User1 | (default user group) | Server       | 40            | 1       |
      | TC.2061.User2 | (default user group) | Server       | 40            | 1       |
    Then 2 new user should be created
    And I search user by:
      | keywords                |
      | <%=@new_users[0].name%> |
    And I view user details by TC.2061.User1
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords                |
      | <%=@new_users[1].name%> |
    And I view user details by TC.2061.User2
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name  | user_name                   | machine_type |
      | Machine1_2061 | <%=@new_users.first.email%> | Server       |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name  | user_name                | machine_type |
      | Machine2_2061 | <%=@new_users[1].email%> | Server       |
    And I update newly created machine encryption value to Default
    And I navigate to Search / List Machines section from bus admin console page
    When I view machine details for Machine1_2061
    And I click on the replace machine link
    And I select Machine2_2061 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name  |
      | Machine2_2061 |
    Then I should not search out machine record
    When I search machine by:
      | machine_name  |
      | Machine1_2061 |
    And I view machine details for Machine1_2061
    Then I will see Replaced Machine2_2061 on today in machine details
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
