Feature:
  Add detele data shuttle

  Background:
    Given I log in bus admin console as administrator

  @bus @TC.12624 @resources @tasks_p1 @smoke
  Scenario: 12624 Tiered Pricing - Add Link (1843GB And Less)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 1       | 32 TB     | yes         | yes       |
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
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1800  |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 3.6 TB | 1        | $375.00  |
      | Total Price         |          | $375.00  |
    When I click finish button
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 3.6 TB | 1        | $375.00  |
      | Total Price         |          | $375.00  |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount   | Total Paid | Balance Due |
      | today | $375.00  | $0.00      | $12,294.84  |
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $375.00 | $0.00      | $12,294.84  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12636 @resources @tasks_p1
  Scenario: 12636 Tiered Pricing - Add Link (Multiple Orders)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 32 TB     | yes         | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.12636.User1 | (default user group) | Desktop      | 10240         | 3       |
      | TC.12636.User2 | (default user group) | Desktop      | 10240         | 3       |
      | TC.12636.User3 | (default user group) | Desktop      | 10240         | 3       |
      | TC.12636.User4 | (default user group) | Desktop      | 10240         | 3       |
      | TC.12636.User5 | (default user group) | Desktop      | 10240         | 3       |
    Then 5 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.12636.User1
    And I update the user password to default password
    Then I close user details section
    And I view user details by TC.12636.User2
    And I update the user password to default password
    Then I close user details section
    And I view user details by TC.12636.User3
    And I update the user password to default password
    Then I close user details section
    And I view user details by TC.12636.User4
    And I update the user password to default password
    Then I close user details section
    And I view user details by TC.12636.User5
    And I update the user password to default password
    Then I close user details section
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine1_12636 | <%=@new_users[0].email%> | Desktop      |
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine2_12636 | <%=@new_users[1].email%> | Desktop      |
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine3_12636 | <%=@new_users[2].email%> | Desktop      |
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine4_12636 | <%=@new_users[3].email%> | Desktop      |
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                | machine_type |
      | Machine5_12636 | <%=@new_users[4].email%> | Desktop      |
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from    | quota                 | drive type     |
      | Data Shuttle US | 5 available | 1;1844;3688;5530;7374 | 3.5" 2TB Drive |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description 	     | Quantity | Total     |
      | Data Shuttle 1.8 TB  | 1	    | $275.00   |
      | Data Shuttle 7.2 TB+ | 1 	    | $575.00   |
      | Data Shuttle 3.6 TB  | 1 	    | $375.00   |
      | Data Shuttle 5.4 TB  | 1 	    | $475.00   |
      | Data Shuttle 7.2 TB  | 1 	    | $575.00   |
      | Total Price 		 |          | $2,275.00 |
    When I click finish button
    Then Data shuttle order should be created
    Then Data shuttle order summary should be:
      | Description 	     | Quantity | Total     |
      | Data Shuttle 1.8 TB  | 1	    | $275.00   |
      | Data Shuttle 7.2 TB+ | 1 	    | $575.00   |
      | Data Shuttle 3.6 TB  | 1 	    | $375.00   |
      | Data Shuttle 5.4 TB  | 1 	    | $475.00   |
      | Data Shuttle 7.2 TB  | 1 	    | $575.00   |
      | Total Price 		 |          | $2,275.00 |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $2,275.00  | $0.00      | $133,393.24 |
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $2,275.00 | $0.00      | $133,393.24 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12714 @resources @tasks_p1
  Scenario: 12714 Verify Payment Information on Partner (Cybersource)
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 24      | 28 TB     | yes         | yes       |
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
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 3690  |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 5.4 TB | 1        | $475.00  |
      | Total Price         |          | $475.00  |
    When I click finish button
    Then Data shuttle order should be created
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | # of Drives | Drives Ordered |
      | 5           | Yes            |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount      | Total Paid | Balance Due |
      | today | $475.00     | $0.00      | $219,502.06 |
      | today | $219,027.06 | $0.00      | $219,027.06 |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12716 @resources @tasks_p1
  Scenario: 12716 Verify Payment Information on EMEA Partner (Cybersource)
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under   | net terms |
      | 1      | 250 GB    | yes         | France  | MozyPro France | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 250           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 250  |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | €199.00  |
      | Total Price         |          | €238.80  |
      | VAT                 |          | €39.80   |
    When I click finish button
    Then Data shuttle order should be created
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | # of Drives | Drives Ordered |
      | 1           | Yes            |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €238.80 | €0.00      | €344.38     |
      | today | €105.58 | €0.00      | €105.58     |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.12717 @resources @tasks_p1
  Scenario: 12717 Verify VAT on EMEA Partner
    When I add a new MozyPro partner:
      | period | base plan | country  | create under    | net terms |
      | 24     | 500 GB    | Germany  | MozyPro Germany | yes       |
    And New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 250           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 250  |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | €199.00  |
      | Total Price         |          | €236.81  |
      | VAT                 |          | €37.81   |
    When I click finish button
    Then Data shuttle order should be created
    When I search order in view data shuttle orders section by newly created partner company name
    Then order search results in data shuttle orders section should be:
      | # of Drives | Drives Ordered |
      | 1           | Yes            |
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €236.81    | €0.00      | €3,255.59   |
    And I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    And I open Keys tab under user group details
    Then The key appears marked as a data shuttle order
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €236.81   | €0.00      | €3,255.59   |
      | today | €3,018.78 | €0.00      | €3,018.78   |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.15211 @resources @tasks_p1
  Scenario: 15211 Verify Data Shuttle Purchase Invoice
    When I add a new MozyPro partner:
      | period  | base plan | server plan | net terms |
      | 12      | 32 TB     | yes         | yes       |
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
    When I fill in data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5690  |
    And I refresh process data shuttle section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 7.2 TB | 1        | $575.00  |
      | Total Price         |          | $575.00  |
    When I click finish button
    Then Data shuttle order should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |              |          |                        |          |         |                   |               |
      | From Date      | To Date      | Quantity | Description            | Price    | Tax     | Percent of Period | Total Price   |
      |                |              |          | Previous Balance       |          |         |                   | $ 131,118.24  |
      | today          | today        |          | Data Shuttle 7.2 TB    | $ 575.00 | $ 0.00  | 100.00%           | $ 575.00      |
      |                |              |          | Total                  |          |         |                   | $ 575.00      |
      |                |              |          | Amount Due             |          |         |                   | $ 131,693.24  |
    And I navigate to old window
    And I search and delete partner account by newly created partner company name


