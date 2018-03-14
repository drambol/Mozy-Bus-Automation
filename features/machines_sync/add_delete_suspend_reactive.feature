Feature: Add delete suspend reactive machines


  Background:
   Given I log in bus admin console as administrator


  @TC.129694 @bus @machines_sync @tasks_p2 @ROR_smoke
  Scenario: 129694 Undelete machine time limit
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.129694.User1 | (default user group) | Desktop      | 100           | 10      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name  | user_name                   | machine_type |
      | auto_generate | <%=@new_users.first.email%> | Desktop      |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for @client.machine_alias
    And I delete the machine
    And I stop masquerading
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then device name should show with (deleted)
    And I view deleted machine details from user details section
    And I undelete the machine
    When I refresh User Details section
    Then device table in user details should be:
      | Device                     | Used/Available | Device Storage Limit | Last Update | Action |
      | <%=@client.machine_alias%> | 0 / 100 GB     | Set                  | N/A         |        |
    And I refresh Machine Details section
    And I delete the machine
    When I refresh User Details section
    Then device name should show with (deleted)
    When I update the deleted at time to today minus global_undelete_value-1 days
    And I view deleted machine details from user details section
    Then I should see Undelete Machine link
    And I undelete the machine
    And I refresh Machine Details section
    And I delete the machine
    When I refresh User Details section
    Then device name should show with (deleted)
    When I update the deleted at time to today minus global_undelete_value days
    And I refresh User Details section
    And I view deleted machine details from user details section
    Then I shouldnot see Undelete Machine link
    And I update the deleted at time to today minus global_undelete_value+1 days
    When I refresh Machine Details section
    Then I shouldnot see Undelete Machine link
    And I search and delete partner account by newly created partner company name
