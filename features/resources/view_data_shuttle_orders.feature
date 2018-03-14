Feature:
  View Data Shuttle Orders

  Background:
    Given I log in bus admin console as administrator

  @bus @TC.12824 @resources @tasks_p2
  Scenario: 12824 Data Shuttle Order Status (Add Link)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 24     | 2     | 250 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  20           | 1       |
    Then 1 new user should be created
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
    And I get the data shuttle seed id for newly created partner company name
    When I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Ordered
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> |                        | Ordered |
    When I set the data shuttle seed status:
      | status  |
      | seeding |
    And I refresh Machine Details section
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Seeding
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status        |
      | seed_complete |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Seed Complete |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Seed Complete
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status     |
      | seed_error |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase      |
      | <%=@seed_id%> | <%=@seed_id%>          | Seed Error |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Seed Error
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | loading |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Loading |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Loading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status        |
      | load_complete |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Load Complete |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Load Complete
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status     |
      | load_error |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase      |
      | <%=@seed_id%> | <%=@seed_id%>          | Load Error |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Load Error
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status    |
      | cancelled |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase     |
      | <%=@seed_id%> | <%=@seed_id%>          | Cancelled |
    And I stop masquerading
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Cancelled
    And I search and delete partner account by newly created partner company name

#existing bug for data shuttle quota
  @bus @TC.12652 @resources @tasks_p2
  Scenario: 12652 Accessing Data Shuttle Order
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 112   | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 30            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | name           | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | tc.12652_order | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US  | available | 1     |
    Then Data shuttle order should be created
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then data shuttle order info should be
      | Partner                         | Name             | Address                                         | Phone      | Target Data Center         |
      | <%=@partner.company_info.name%> | tc.12652_order   | 151 S Morgan,Shelbyville,IL,62565,United States | 3127584030 | <%=QA_ENV['data_center']%> |
    Then data shuttle order details info should be
      | Created | Status   | Machine  | License Key                | Shuttle SN | Quota(GB) | Total(GB) | Seeded(GB) | Loaded(GB) | # of Files | # of Seeded | # of Loaded | Action |
      | today   | Ordered  | AUTOTEST | <%=@order.license_key[0]%> |            | 1         |0          |0           | 0          | 0          | 0           | 0           | Cancel |
    Then the shipping tracking table of data shuttle order should be
      | Drive # | Outbound | Inbound | Status      |
      | 1       |          |         | Processing  |
    And I search and delete partner account by newly created partner company name

  @bus @TC.12657 @resources @tasks_p2
  Scenario: 12657 Add Drive to Order
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 1       | 32 TB     | yes         | yes       |
    And New partner should be created
    When I get the partner_id
    When I act as newly created partner account
    And I add new user(s):
      | storage_type  | storage_limit | devices |
      | Desktop       | 10240         | 1       |
    Then 1 new user should be created
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
    When I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    And I search and delete partner account by newly created partner company name

  @bus @TC.12562 @resources @tasks_p2
  Scenario: 12562 Canceling Orders That Were Created Using the Add Link (Unassigned)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | storage add on |
      | 24      | 1 TB      | yes         | 68             |
    And New partner should be created
    When I get the partner_id
    When I act as newly created partner account
    And I add new user(s):
      | storage_type  | storage_limit | devices |
      | Desktop       | 99            | 1       |
    Then 1 new user should be created
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
    And I cancel the latest data shuttle order for newly created partner company name
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then data shuttle order details info should be
      | Status     | License Key                |
      | Cancelled  | <%=@order.license_key[0]%> |
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle cancelled status table
    And I should see data shuttle order @seed_id in the cancelled status table
    And I search and delete partner account by newly created partner company name
