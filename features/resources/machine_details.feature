Feature: Machine Details

  Background:
    Given I log in bus admin console as administrator

  @TC.12733 @tasks_p1 @resources @bus
  Scenario: 12733 No Data Shuttle table appears when the machine is not installed with a data shuttle key
    When I add a new MozyPro partner:
      | period |  base plan | storage add on |
      |   12   |  20 TB     | 35             |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 30            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I refresh User Details section
    And I view machine AUTOTEST details from user details section
    Then I should not see data shuttle table in machine details section
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12734 @tasks_p1 @resources @bus
  Scenario: 12734 There is Data Shuttle table when machine is installed with a data shuttle key
    When I add a new MozyPro partner:
      | period |  base plan | server plan | storage add on |
      |   24   |  1 TB      | yes         | 15             |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 30            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  |
      | Data Shuttle US | available |
    Then Data shuttle order should be created
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I view machine AUTOTEST details from user details section
    Then I should see data shuttle table in machine details section
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12736 @tasks_p1 @smoke @resources @bus
  Scenario: 12736 Data Shuttle table is with order for data shuttle machine at first
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 15    | 500 GB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  1            |  1      |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  |
      | Data Shuttle US | available |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I view machine AUTOTEST details from user details section
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> |                        | Ordered |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126315 @tasks_p1 @resources @bus
  Scenario: 126315 Machine deteails section include Linux data shuttle info
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 36     | 112   | 24 TB       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 30            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  |
      | Data Shuttle US | available |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I view machine AUTOTEST details from user details section
    Then I should see data shuttle table in machine details section
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12737 @tasks_p1 @resources @bus
  Scenario: 12737 Data shuttle phase is updated to Seeding right after execute HTTP Get 'statusseeding'
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 2     | 250 GB      |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  20           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12738 @tasks_p1 @resources @bus
  Scenario: 12738 Data shuttle phase is updated to Seed Error right after execute HTTP Get 'statusseed_error'
    When I add a new MozyPro partner:
      | period |  base plan | server plan | storage add on |
      |   24   |  1 TB      | yes         | 15             |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Desktop     | 29            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 29    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status     |
      | seed_error |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase      |
      | <%=@seed_id%> | <%=@seed_id%>          | Seed Error |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12739 @tasks_p1 @resources @bus
  Scenario: 12739 Data shuttle phase is updated to Seed Complete right after execute HTTP Get 'statusseed_complete'
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  500 GB    | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Desktop     | 35            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 35    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status        |
      | seed_complete |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Seed Complete |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12740 @tasks_p1 @resources @bus
  Scenario: 12740 Data shuttle phase is updated to Loading right after execute HTTP Get 'statusloading'
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 4 TB       | yes         |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Desktop     | 28            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 28    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    And I set the data shuttle seed status:
      | status  |
      | loading |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Loading |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12741 @tasks_p1 @resources @bus
  Scenario: 12741 Data shuttle phase is updated to Load Error right after execute HTTP Get 'statusload_error'
    When I add a new MozyEnterprise partner:
      | period | users  | server plan | server add on |
      |   24   | 45     | 4 TB        | 9             |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     | 99            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 99    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    And I set the data shuttle seed status:
      | status     |
      | load_error |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase      |
      | <%=@seed_id%> | <%=@seed_id%>          | Load Error |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12742 @tasks_p1 @resources @bus
  Scenario: 12742 Data shuttle phase is updated to Load Complete right after execute HTTP Get 'statusload_complete'
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 36     | 30    | 2 TB        | 1             |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     | 100           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 100   | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    And I set the data shuttle seed status:
      | status        | total files | total bytes | total files seeded | total bytes seeded |
      | load_complete | 1000        | 2097152     | 1000               | 2097152            |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Load Complete |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12743 @tasks_p1 @resources @bus
  Scenario: 12743 Data shuttle phase is updated to Cancelled right after execute HTTP Get 'statuscancelled'
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 98    | 8 TB        | yes       |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     | 101           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 101   | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    And I set the data shuttle seed status:
      | status    |
      | cancelled |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase     |
      | <%=@seed_id%> | <%=@seed_id%>          | Cancelled |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name



