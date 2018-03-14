Feature: CustomCD integration


  Background:
    Given I log in bus admin console as administrator

  @bus @TC.12894 @resources @tasks_p2
  Scenario: 12894 Cancel order in BUS, make sure Custom CD order gets cancelled
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 4 TB      | yes         | yes       |
    And New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | storage_type  | storage_limit | devices |
      | Desktop       | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    And I cancel the latest data shuttle order for newly created partner company name
    And I get customcd order id from database for data shuttle order
    And I wait for 60 seconds
    Then API* data shuttle order status should be Cancelled
    And I search and delete partner account by newly created partner company name

  @bus @TC.12924 @resources @tasks_p2 @ROR_smoke
  Scenario: 12924:Verify shipped orders
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 18    | 100 GB      |
    And New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      |  10           |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    And I set customcd order id to 24651 for just created data shuttle order
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then the shipping tracking table of data shuttle order should be
      | Drive # | Outbound     | Inbound       | Status   |
      | 1       | 797391637123 | 797391636848  | Shipped  |
    And I click outbound link of shipping tracking table
    And I navigate to new window
    Then the new url should contains /fedextrack/?action=track&tracknumbers=797391637123
    And I close new window
    And I click inbound link of shipping tracking table
    And I navigate to new window
    Then the new url should contains /fedextrack/?action=track&tracknumbers=797391636848
    And I close new window
    And I search and delete partner account by newly created partner company name

  @bus @TC.12898 @resources @tasks_p2
  Scenario: 12898 Verify CustomCD order status updates make it through to BUS.
    When I add a new MozyPro partner:
      | company name    | period  | base plan | storage add on |
      | tc12898_partner | 24      | 8 TB      | 28             |
    And New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | storage_type  | storage_limit | devices |
      | Desktop       | 55            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then the status of shipping tracking table should have Submitted and Processing and Burned
    And I get the data shuttle seed id for newly created partner company name
    And I get customcd order id from database for data shuttle order
    When API* cancel data shuttle order in customcd
    And I wait for 60 seconds
    Then API* data shuttle order status should be Cancelled
    And I refresh view data shuttle order section
    Then the shipping tracking table of data shuttle order should be
      | Drive # | Outbound | Inbound | Status     |
      | 1       |          |         | Cancelled  |
    And I search and delete partner account by newly created partner company name

#  @bus @TC.125785 @qa12 @env_dependent @resources @tasks_p2
#  Scenario: 125785 VMBU data shuttle is reflected correctly in CustomCD
#    When I order data shuttle for ClientQA-VMBU
#      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from             | os         |
#      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | 9X37WGFV58DBXBC7TSS2 | vSphere    |
#    Then Data shuttle order should be created
#    And I search order in view data shuttle orders section by ClientQA-VMBU
#    And I view data shuttle order details
#    Then the status of shipping tracking table should have Submitted and Processing and Burned
#    And I get the data shuttle seed id for ClientQA-VMBU
#    And I get customcd order id from database for data shuttle order
#    Then API* data shuttle order status should be Burned
#    And I cancel the latest data shuttle order for ClientQA-VMBU
#    And I wait for 60 seconds
#    Then API* data shuttle order status should be Cancelled

