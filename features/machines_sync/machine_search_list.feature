Feature: Machine search list


  Background:
    Given I log in bus admin console as administrator

  @TC.865 @TC.1054 @bus @machines_sync @tasks_p2
  Scenario: 865 1054 Search list machine
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name         | user_group           | storage_type | storage_limit | devices |
      | TC.865.User1 | (default user group) | Desktop      | 40            | 3       |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name  | user_name                   | machine_type |
      | auto_generate | <%=@new_users.first.email%> | Desktop      |
    And I stop masquerading
    When I search machine by:
      | machine_name               |
      | <%=@client.machine_alias%> |
    Then I should can search out machine record
    When I view machine details for @client.machine_alias
    Then Machine action bar links should be
      | links                     |
      | Delete Machine            |
      | Replace Machine           |
      | View                      |
      | Raw                       |
      | View Logfile              |
      | View Client Configuration |
    And I search and delete partner account by newly created partner company name


