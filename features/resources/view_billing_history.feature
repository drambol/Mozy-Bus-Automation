Feature: View billing history

  As a Mozy Administrator
  I want to view itemized statements for the services I have used
  so that I can understand why I was charged what I was charged

  Background:
    Given I log in bus admin console as administrator

  @TC.18898 @smoke @bus @2.0 @view_billing_history @regression @core_function
  Scenario: 18898 Verify billing history after create MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $94.99  | $94.99     | $0.00       |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @bus @TC.126321 @resources @tasks_p2
  Scenario: 126321 View Account in Aria from Resources Billing History with Credentials
    When I add a new MozyPro partner:
      | period  | base plan | storage add on |
      | 1       | 8 TB      | 19             |
    And New partner should be created
    And I get partner aria id
    And I expand the billing information section
    And I click view in aria link of billing history section
    And I navigate to new window
    Then Aria login page should be opened
    When I log in aria admin console with username correct name and password correct password
    Then Aria account overview page should be opened
    And I navigate to old window
    And I delete partner account

  @bus @TC.126322 @resources @tasks_p2
  Scenario: 126322 View Account in Aria from Resources Billing History without Credentials
    When I add a new MozyPro partner:
      | period  | base plan | storage add on |
      | 12      | 24 TB     | 100            |
    And New partner should be created
    And I expand the billing information section
    And I click view in aria link of billing history section
    And I navigate to new window
    Then Aria login page should be opened
    When I log in aria admin console with username incorrect name and password incorrect password
    Then fail to login Aria and the message should be:
    """
    Invalid username or password.
    """
    And I navigate to old window
    And I delete partner account

  @bus @TC.19257 @resources @tasks_p2
  Scenario: 19257 Billing History MozyPro Enterprise Upgrade Plan (10, 250, 0 => 15, 500, 5)
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    And New partner should be created
    And I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyEnterprise new plan should be:
      | users | server plan |
      | 10    | 250 GB      |
    When I change MozyEnterprise account plan to:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5              |
    Then the MozyEnterprise account plan should be changed
    Then MozyEnterprise new plan should be:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5              |
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $6,788.45  | $6,788.45  | $0.00       |
      | today | $0.00 	   | $0.00 	    | $0.00       |
      | today | $2,170.78  | $2,170.78  | $0.00       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15132 @tasks_p2 @resources @bus
  Scenario: 15132 Bill.20002 Sub partner cannot view billing history and are not in Aria
    When I add a new Reseller partner:
      | company name              | period | reseller type | reseller quota |
      | TC.15132_reseller_partner | 12     | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                  |
      | TC.15132_reseller_sub_partner |
    And New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | generic quota   |
      | 50              |
    Then Resources should be purchased
    And I navigate to Billing History section from bus admin console page
    Then there no recent billing history content in billing history section
    And I stop masquerading as sub partner
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount   | Total Paid | Balance Due |
      | today | $396.00  | $396.00    | $0.00       |
    When I stop masquerading
    And I search and delete partner account by TC.15132_reseller_sub_partner
    And I search and delete partner account by TC.15132_reseller_partner

  @TC.15139 @tasks_p2 @resources @bus
  Scenario: 15139 Bill.20000 View Partner Billing History - new customer with additional purchases-mozypro
    When I add a new MozyPro partner:
      | period |  base plan |
      |   12   |  24 TB     |
    Then New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card     | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00           | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year    | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year    |                 |                    |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid   | Balance Due |
      | today | $95,039.34  | $95,039.34   | $0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                            |             |         |                   |               |
      | From Date      | To Date                | Quantity | Description                                | Price       | Tax     | Percent of Period | Total Price   |
      |                |                        |          | Previous Balance                           |             |         |                   | $ 0.00        |
      | today          | after 1 year yesterday | 1        | MozyPro 24 TB Plan (Annual) MozyPro Bundle | $ 95,039.34 | $ 0.00  | 100.00%           | $ 95,039.34   |
      |                |                        |          | Total                                      |             |         |                   | $ 95,039.34   |
      | today          |                        |          | Electronic Payment                         |             |         |                   | $-95,039.34   |
      |                |                        |          | Balance                                    |             |         |                   | $ 0.00        |
    And I navigate to old window
    And I act as newly created partner account
    When I change MozyPro account plan to:
      | base plan |
      | 28 TB     |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 28 TB     |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount     | Total Paid  | Balance Due |
      | today | $15,839.89 | $15,839.89  | $0.00       |
      | today | $95,039.34 | $95,039.34  | $0.00       |
    When I click the latest date link to view the invoice from billing history section
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                         |          |                                             |              |         |                   |               |
      | From Date      | To Date                 | Quantity | Description                                 | Price        | Tax     | Percent of Period | Total Price   |
      |                |                         |          | Previous Balance                            |              |         |                   | $ 0.00        |
      | today          | after 1 year yesterday  | 1        | MozyPro 28 TB Plan (Annual) MozyPro Bundle  | $ 110,879.23 | $ 0.00  | 100.00%           | $ 110,879.23  |
      | today          | after 1 year yesterday  | 1        | Credit - MozyPro Bundle                     | $ 0.00       |  $ 0.00 | 100.00%           | $ -95,039.34  |
      |                |                         |          | Total                                       |              |         |                   | $ 15,839.89   |
      | today          |                         |          | Electronic Payment                          |              |         |                   | $-15,839.89   |
      |                |                         |          | Balance                                     |              |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15140 @tasks_p2 @resources @bus
  Scenario: 15140 Bill.20001 View Billing History for Migrated Partner - oem (with pooled resources)
    When I add a new OEM partner:
      | Company Name             | Root role         | Company Type     |
      | tc15140_migrate_partner  | OEM Partner Admin | Service Provider |
    Then New partner should be created
    And I get the subpartner_id
    Then I migrate the partner to pooled storage
    And I stop masquerading as sub partner
    And I stop masquerading
    When I search partner by tc15140_migrate_partner
    And I view partner details by tc15140_migrate_partner
    And New Partner internal billing should be:
      | Account Type:   | Invoiced | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00    | Collect On:     | --                 |
      | Renewal Date:   |          | Renewal Period: | Use Current Period |
    Then billing history section should not visible
    And I act as newly created partner account
    Then I should not see Billing History link
    And I stop masquerading
    And I search and delete partner account by tc15140_migrate_partner

  @TC.15128 @tasks_p2 @resources @bus
  Scenario: 15128:Bill.20000 View Partner Billing History - existing customer with additional purchase - mozy enterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 30    | 2 TB        |
    Then New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card     | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00           | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year    | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year    |                 |                    |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid   | Balance Due |
      | today | $11,539.78  | $11,539.78   | $0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                                        |             |         |                   |              |
      | From Date      | To Date                | Quantity | Description                                                            | Price       | Tax     | Percent of Period | Total Price  |
      |                |                        |          | Previous Balance                                                       |             |         |                   | $ 0.00       |
      | today          | after 1 year yesterday | 30       | MozyEnterprise User (Annual) MozyEnterprise                            | $ 95.00     | $ 0.00  | 100.00%           | $ 2,850.00   |
      | today          | after 1 year yesterday | 1        | MozyEnterprise 2 TB Server Plan (Annual) Mozy Enterprise Server Bundle | $ 8,689.78  | $ 0.00  | 100.00%           | $ 8,689.78  |
      |                |                        |          | Total                                                                  |             |         |                   | $ 11,539.78  |
      | today          |                        |          | Electronic Payment                                                     |             |         |                   | $-11,539.78  |
      |                |                        |          | Balance                                                                |             |         |                   | $ 0.00       |
    And I navigate to old window
    And I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 50    | 8 TB        | 2             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 50    | 8 TB        | 2             |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount     | Total Paid  | Balance Due |
      | today | $25,989.78 | $25,989.78  | $0.00       |
      | today | $0.00      | $0.00       | $0.00       |
      | today | $11,539.78 | $11,539.78  | $0.00       |
    When I click the latest date link to view the invoice from billing history section
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                         |          |                                                                         |              |         |                   |               |
      | From Date      | To Date                 | Quantity | Description                                                             | Price        | Tax     | Percent of Period | Total Price   |
      |                |                         |          | Previous Balance                                                        |              |         |                   | $ 0.00        |
      | today          | after 1 year yesterday  | 1        | MozyEnterprise 8 TB Server Plan (Annual) Mozy Enterprise Server Bundle  | $ 32,779.56  | $ 0.00  | 100.00%           | $ 32,779.56   |
      | today          | after 1 year yesterday  | 1        | Credit - Mozy Enterprise Server Bundle                                  | $ 0.00       | $ 0.00  | 100.00%           | $ -3,939.78   |
      | today          | after 1 year yesterday  | 30       | Credit - MozyEnterprise                                                 | $ 0.00       | $ 0.00  | 100.00%           | $ -2,850.00   |
      |                |                         |          | Total                                                                   |              |         |                   | $ 25,989.78   |
      | today          |                         |          | Electronic Payment                                                      |              |         |                   | $-25,989.78   |
      |                |                         |          | Balance                                                                 |              |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15128 @tasks_p2 @resources @bus
  Scenario: 15128:Bill.20000 View Partner Billing History - existing customer with additional purchase - oem
    When I add a new OEM partner:
      | Company Name        | Root role         | Company Type     |
      | tc15128_oem_partner | OEM Partner Admin | Service Provider |
    Then New partner should be created
    And I stop masquerading as sub partner
    And I stop masquerading
    When I search partner by tc15128_oem_partner
    And I view partner details by tc15128_oem_partner
    And New Partner internal billing should be:
      | Account Type:   | Invoiced | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00    | Collect On:     | --                 |
      | Renewal Date:   |          | Renewal Period: | Use Current Period |
    Then billing history section should not visible
    And I act as newly created partner account
    Then I should not see Billing History link
    And I stop masquerading
    And I search and delete partner account by tc15128_oem_partner

  @TC.15128 @tasks_p2 @resources @bus
  Scenario: 15128:Bill.20000 View Partner Billing History - existing customer with additional purchase - reseller
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |
      |   12   |  Gold           | 998            |
    Then New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card     | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00           | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year    | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year    |                 |                    |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid   | Balance Due |
      | today | $3,353.28   | $3,353.28    | $0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                |             |         |                   |               |
      | From Date      | To Date                | Quantity | Description                                    | Price       | Tax     | Percent of Period | Total Price   |
      |                |                        |          | Previous Balance                               |             |         |                   | $ 0.00        |
      | today          | after 1 year yesterday | 998      | Mozy Reseller GB - Gold (Annual) Mozy Reseller | $ 3.36      | $ 0.00  | 100.00%           | $ 3,353.28    |
      |                |                        |          | Total                                          |             |         |                   | $ 3,353.28    |
      | today          |                        |          | Electronic Payment                             |             |         |                   | $-3,353.28    |
      |                |                        |          | Balance                                        |             |         |                   | $ 0.00        |
    And I navigate to old window
    And I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      | 20 GB add-on        | 3                | No              |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount     | Total Paid  | Balance Due |
      | today | $201.60    | $201.60     | $0.00       |
      | today | $3,353.28  | $3,353.28   | $0.00       |
    When I click the latest date link to view the invoice from billing history section
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail |                        |          |                                                          |             |         |                   |               |
      | From Date      | To Date                | Quantity | Description                                              | Price       | Tax     | Percent of Period | Total Price   |
      |                |                        |          | Previous Balance                                         |             |         |                   | $ 0.00        |
      | today          | after 1 year yesterday | 3        | Mozy Reseller 20 GB add-on - Gold (Annual) Mozy Reseller | $ 67.20     | $ 0.00  | 100.00%           | $ 201.60      |
      |                |                        |          | Total                                                    |             |         |                   | $ 201.60      |
      | today          |                        |          | Electronic Payment                                       |             |         |                   | $-201.60      |
      |                |                        |          | Balance                                                  |             |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    

