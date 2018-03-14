Feature: View Sync Details


  Background:
   Given I log in bus admin console as administrator


  @TC.120013 @machines_sync @bus @tasks_p1
  Scenario: 120013:Add sync container for user with stash_region & install_region & an active machine[ME]
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I add partner settings
      | Name                    | Value    |
      | install_region_override | test_qa5 |
    And I add partner settings
      | Name                  | Value |
      | stash_region_override | qa    |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.120013.User1 | (default user group) | Desktop      | 40            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine1_120013 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I enable stash without send email in user details section
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120016 @machines_sync @bus @tasks_p1 @smoke
  Scenario: 120016:Add sync container for user with one active machine and one deleted machine[ME]
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 10    | 500 GB      |
    Then New partner should be created
    And I delete partner settings if exist
      | Name                    |
      | install_region_override |
      | stash_region_override   |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.120016.User1 | (default user group) | Desktop      | 40            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine1_120016 | <%=@new_users.last.email%> | Desktop      | test_qa5    |
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine2_120016 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I refresh User Details section
    And I delete device by name: Machine1_120016
    And I enable stash without send email in user details section
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I close user details section
    And I close Sync section
    And I navigate to Add New User section from bus admin console page
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.120016.User2 | (default user group) | Desktop      | 40            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name      | user_name                  | machine_type | user_region |
      | Machine1_120016_2 | <%=@new_users.last.email%> | Desktop      | test_qa5    |
    Then I use keyless activation to activate devices
      | machine_name      | user_name                  | machine_type | user_region |
      | Machine2_120016_2 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I refresh User Details section
    And I delete device by name: Machine2_120016_2
    And I enable stash without send email in user details section
    And I refresh User Details section
    And I view Sync details
    Then machine details should be:
      | Data Center: |
      | qa5          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120093 @machines_sync @bus @tasks_p1
  Scenario: 120093:Sync client region matches containers region
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    And I add partner settings
      | Name                  | Value    |
      | stash_region_override | americas |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120093.User1 | (default user group) | Desktop      | 40            | 3       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    Then machine details should be:
      | Data Center: |
      | qa6          |
    When I set newly created user sync client region as americas and country as default
    And I refresh sync details section
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120094 @machines_sync @bus @tasks_p1
  Scenario: 120094:Sync client region does not match containers region without sync activity valid region and country
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120094.User1 | (default user group) | Desktop      | 40            | 3       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    Then machine details should be:
      | Data Center: |
      | qa6          |
    When I set newly created user sync client region as canada and country as default
    And I refresh sync details section
    Then machine details should be:
      | Data Center: |
      | qa5          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120166 @machines_sync @bus @tasks_p1
  Scenario: 120166:Sync client region does not match containers region without sync activity valid region and country
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    And I add partner settings
      | Name                  | Value    |
      | stash_region_override | americas |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120166.User1 | (default user group) | Desktop      | 40            | 3       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I update Sync used quota to 3 GB
    When I got client config for the user machine:
      | user_name                   | machine  | platform | arch | codename | version |
      | <%=@new_users.first.email%> | @user_id | win      | x64  | bds      | 0.0.0.2 |
    And I refresh sync details section
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

