Feature:
  Data shuttle integration testing

  Background:
    Given I log in bus admin console as administrator

  ###############################################################################

  # Purchase Resources

  ###############################################################################
  @bus @TC.12676 @resources @tasks_p1 @smoke
  Scenario: 12676 Partner purchase data shuttle order
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 4 TB      | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name               | # of Drives | Drives Ordered |
      | <%=@partner.company_info.name%>| 1           | Yes            |
    When I view data shuttle order details
    Then data shuttle order details info should be
      | License Key                | Quota(GB) |
      | <%=@order.license_key[0]%> | 1         |
    And I should not query resources orders record from DB for the data shuttle order
    And I search and delete partner account by newly created partner company name

  @bus @TC.12809 @resources @tasks_p1
  Scenario: 12809 Overdraft partner purchase data shuttle order for an activated machine
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 10             | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @bus @TC.12784 @resources @tasks_p1
  Scenario: 12784 Billing history for purchase data shuttle order
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 20 TB     | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10240         | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1800  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 3.6 TB | 1        | $375.00  |
      | Total Price         |          | $375.00  |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $375.00 | $0.00      | $82,323.90  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12836 @resources @tasks_p1
  Scenario: 12836 Billing history for overdraft partner purchase data shuttle order for an activated machine
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 2  |
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $275.00  |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $275.00 | $275.00    | $0.00       |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.13533 @resources @tasks_p1
  Scenario: 13533 Add a 100% discount to a charge and quota (add link invoiced partner)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 2 TB      | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.13533.User1 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.13533.User1
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine1_13533 | <%=@new_users[0].email%> | Desktop      |
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 100   |
    And I input discount percentage value 100
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $275.00 |
    When I click finish button
    Then Data shuttle order should be created
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $275.00 |
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name               | # of Drives | Drives Ordered |
      | <%=@partner.company_info.name%>| 1           | Yes            |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $275.00    | $0.00      | $6,357.78   |
    And I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $275.00 | $0.00      | $6,357.78   |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12708 @resources @tasks_p2
  Scenario: 12708 There is data shuttle related info under User Group Keys tab when user group have data shuttle order
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan | net terms |
      | TC.12708_partner | 12     | 45    | 100 GB      | yes       |
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
      | power adapter   | key from  |
      | Data Shuttle US | available |
    Then Data shuttle order should be created
    And I act as partner by:
      | name             |
      | TC.12708_partner |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then there is data shuttle text in the user group keys section
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12709 @resources @tasks_p2
  Scenario: 12709 1 partner key in one user group assigned to a data shuttle order contains an asterisk
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan |
      | TC.12709_partner | 36     | 121   | 250 GB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 11            | 1       |
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
    And I act as partner by:
      | name             |
      | TC.12709_partner |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12839 @resources @tasks_p2
  Scenario: 12839 No data shuttle related info under User Group Keys tab whenthere is no data shuttle key under
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota | net terms |
      | TC.12839_partner | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 19            | 1       |
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
    And I cancel the latest data shuttle order for newly created partner company name
    And I act as partner by:
      | name             |
      | TC.12839_partner |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then there is not data shuttle text in the user group keys section
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.12712 @tasks_p2 @resources @bus
  Scenario: 12712 Sub-partner keys assigned to a data shuttle order contains an asterisk
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan |
      | TC.12712_partner | 36     | 129   | 16 TB       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.12712_sub_partner |
    Then New partner should be created
    And I get the subpartner_id
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota |
      | 1               | 50            |
    Then Resources should be purchased
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I stop masquerading as sub partner
    And I stop masquerading
    And I log in bus admin console as administrator
    When I order data shuttle for TC.12712_sub_partner
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available |
    Then Data shuttle order should be created
    And I act as partner by:
      | name                      |
      | TC.12712_sub_partner      |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I stop masquerading
    And I search and delete partner account by TC.12712_sub_partner
    And I search and delete partner account by TC.12712_partner

  @bus @TC.12761 @resources @tasks_p2
  Scenario: 12761 Keys assigned to data shuttle order don't contain an asterisk after data shuttle phase is Cancelled
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan | server add on |
      | TC.12761_partner | 36     | 112   | 24 TB       | 9             |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
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
    Then The order should be Cancelled
    And I act as partner by:
      | name             |
      | TC.12761_partner |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears not marked as a data shuttle order
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12755 @resources @tasks_p2
  Scenario: 12755 Keys assigned to data shuttle order contain an asterisk after data shuttle phase is Seeding
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan |
      | TC.12755_partner | 12     | 299   | 8 TB        |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 19            | 1       |
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
    When I set the data shuttle seed status:
      | status  |
      | seeding |
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then The order should be Seeding
    And I act as partner by:
      | name             |
      | TC.12755_partner |
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


