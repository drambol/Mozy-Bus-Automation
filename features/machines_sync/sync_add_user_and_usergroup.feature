Feature: Machine and Sync


  Background:
    Given I log in bus admin console as administrator

  @TC.19039 @bus @machines_sync @tasks_p3
  Scenario: 19039 MozyPro Partner Verify Stash UI in Add New User (Local Execution = 5min~6min)
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms | root role               |
      | 1      | 10 GB     | yes         | yes       | Bundle Pro Partner Root |
    Then New partner should be created
    When I enable stash for the partner
    And I get the admin id from partner details
    When I act as newly created partner account
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | false                   | true                   |
    #======new user successfully======
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19039-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    #======new user unsuccessfully, invalid storage quota======
    When I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19039-2  | (default user group) | Desktop      | test          | 3       | yes          |
    #======new user unsuccessfully, input storage quota > limitation======
    When I add new user with error message User Group (default user group) does not have enough storage available. unsuccessfully:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19039-2  | (default user group) | Desktop      | 20            | 3       | yes          |
    #======new user unsuccessfully, invalid email format======
    When I add new user with error message Failed to create 1 user(s) unsuccessfully:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash | email |
      | TC.19039-2  | (default user group) | Desktop      | 5             | 3       | yes          | abc   |
    Then The error message beside email should be Invalid Email
    #======new user unsuccessfully, empty name======
    When I add new user with error message Failed to create 1 user(s) unsuccessfully:
      | name | user_group           | storage_type | storage_limit | devices | enable_stash | email       |
      |      | (default user group) | Desktop      | 5             | 3       | yes          | abc@abc.com |
    Then The error message beside email should be Name Required
    And I stop masquerading


  @TC.22478 @bus @machines_sync @tasks_p3
  Scenario: 22478 Enable Stash and Sync files for DPS customers (Local Execution = 5min~6min)
  #======create a MozyEnterprise partner======
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
      | 12     | 1         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
    Then Sub-total before taxes or discounts should be $0.00
    And New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
  #======create a user and update its password======
    And I add new user(s):
      | name           |   user_group         | storage_type | storage_limit | devices | enable_stash |
      | TC.22478.User  | (default user group) | Desktop      | 1024          | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
  #======upload file to the sync device======
    And I view machine details for Sync
    And I get machine details info
    And I upload data to device
      | machine_id                 | GB |
      | <%=@machine_info['ID:']%>  | 1  |
  #======Refresh Search List User Section======
    Then I refresh User Details section
    And sync device info should be:
      | Sync Container | Used/Available |
      | Sync           | 1 GB / 1023 GB |
  #======Update device storage======
    And device Sync has tooltip Min: 0 GB, Max: 1024 GB on its Device Storage Limit
    When update the device Sync with amount -1
    And update the device Sync with amount 1025
    Then device detail section has error message The Sync Storage limit cannot be more than what is available for this user.
  #======Delete sync device, have the used storage back======
    When delete device Sync by without keeping data
    And I refresh User Details section
    Then user resources details rows should be:
      | Storage                 |
      | 0 Used / 1 TB Available |
    And I stop masquerading