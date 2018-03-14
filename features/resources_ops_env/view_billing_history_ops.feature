Feature: View billing history, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator


  @TC.15139 @ops_env
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
      #| today          |                        |          | Electronic Payment                         |             |         |                   | $-95,039.34   |
      # replace with the below code if running on staging
      | today          |                        |          | Electronic Payment                         |             |         |                   | $--95,039.34  |
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
      | today          | after 1 year yesterday  |          | Credit - MozyPro Bundle                     | $ 0.00       |  $ 0.00 | 100.00%           | $ -95,039.34  |
      |                |                         |          | Total                                       |              |         |                   | $ 15,839.89   |
      #| today          |                         |          | Electronic Payment                          |              |         |                   | $-15,839.89   |
      #replace with the below code if running on staging
      | today          |                         |          | Electronic Payment                          |              |         |                   | $--15,839.89   |
      |                |                         |          | Balance                                     |              |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.15128 @ops_env
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
      | today          | after 1 year yesterday | 30       | MozyEnterprise User (Annual) Mozy Enterprise                           | $ 95.00     | $ 0.00  | 100.00%           | $ 2,850.00   |
      #| today          | after 1 year yesterday | 1        | MozyEnterprise 2 TB Server Plan (Annual) Mozy Enterprise Server Bundle| $ 8,689.78  | $ 0.00  | 100.00%           | $ 8,689.78  |
      #replace with below code if running on staging
      | today          | after 1 year yesterday | 1        | MozyEnterprise 2 TB Server Plan (Annual) Mozy Enterprise Server Bundle | $ 8,689.78  | $ 0.00  | 100.00%           | $ 8,689.78  |
      |                |                        |          | Total                                                                  |             |         |                   | $ 11,539.78  |
      #| today          |                        |          | Electronic Payment                                                    |             |         |                   | $-11,539.78  |
      #replace with below code if running on staging
      | today          |                        |          | Electronic Payment                                                     |             |         |                   | $--11,539.78  |
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
      #| today          | after 1 year yesterday  | 1        | MozyEnterprise 8 TB Server Plan (Annual) Mozy Enterprise Server Bundle  | $ 32,779.56  | $ 0.00  | 100.00%           | $ 32,779.56   |
      #| today          | after 1 year yesterday  | 1        | Credit - Mozy Enterprise Server Bundle                                  | $ 0.00       | $ 0.00  | 100.00%           | $ -3,939.78   |
      #replace with below code if running on staging
      | today          | after 1 year yesterday  | 1        | MozyEnterprise 8 TB Server Plan (Annual) Mozy Enterprise Server Bundle  | $ 32,779.56  | $ 0.00  | 100.00%           | $ 32,779.56   |
      | today          | after 1 year yesterday  |          | Credit - Mozy Enterprise Server Bundle                                  | $ 0.00       | $ 0.00  | 100.00%           | $ -3,939.78   |
      | today          | after 1 year yesterday  |          | Credit - Mozy Enterprise                                                | $ 0.00       | $ 0.00  | 100.00%           | $ -2,850.00   |
      |                |                         |          | Total                                                                   |              |         |                   | $ 25,989.78   |
      #| today          |                         |          | Electronic Payment                                                      |              |         |                   | $-25,989.78   |
      #replace with below code if running on staging
      | today          |                         |          | Electronic Payment                                                      |              |         |                   | $--25,989.78   |
      |                |                         |          | Balance                                                                 |              |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.15128R @ops_env
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
      #| today          |                        |          | Electronic Payment                             |             |         |                   | $-3,353.28    |
      #replace with below code if running on staging
      | today          |                        |          | Electronic Payment                             |             |         |                   | $--3,353.28    |
      |                |                        |          | Balance                                        |             |         |                   | $ 0.00        |
    And I navigate to old window
    And I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    #Then Reseller supplemental plans should be:
      #| storage add on type | # storage add on | has server plan |
      #| 20 GB add-on        | 3                | No              |
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
      | today          |                        |          | Electronic Payment                                       |             |         |                   | $--201.60     |
      |                |                        |          | Balance                                                  |             |         |                   | $ 0.00        |
    And I navigate to old window
    And I stop masquerading
    And I search and delete partner account by newly created partner company name