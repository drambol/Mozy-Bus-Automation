Feature: Corporate Invoices, running on ops env (pantheon / staging)

  Description:
   - As a Mozy Enterprise customer
   - I want to construct my billing terms in a way that fits my needs and usage
   - so that I can pay the way that makes sense to me (ex. bundles packages, minimums, per-user licensing, etc).

  Background:
    Given I log in bus admin console as administrator

  @TC.15686 @ops_env
  Scenario: 15686 Verify Aria sends email when create a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I get partner aria id
    Given I identify the email is sent from bus
    And I wait for 10 seconds
    When I search emails by keywords:
      | to               | subject                            |
      | @new_admin_email | BDS Online Backup Account Created! |
    Then I should see 1 email(s)
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)


  @TC.124568 @ops_env
  Scenario: 124568 Check the invoice when adding a new EU pro partner under MozyPro France with valid vat number
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | server plan | vat number  | coupon              | cc number        |
      | 12     | 1 TB      | MozyPro France | Germany | yes         | DE812321109 | 10PERCENTOFFOUTLINE | 4188181111111112 |
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €2,582.80 | €2,582.80  | €0.00       |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
    | Détails de facturation |                        |          |                                                                     |            |           |                   |             |
    | Depuis la date | Jusqu'à la date        | Quantité | Description                                                         | Prix      | TVA        | Pourcentage de la période | Prix total |
    |                |                        |          | Solde précédent                                                     |            |           |                           | € 0.00      |
    | today          | after 1 year yesterday | 1        | MozyPro 1 TB Plan (Annual) MozyPro Bundle                           | € 2,654.89 | € 0.00    | 100.00%                   | € 2,654.89  |
    | today          | after 1 year yesterday | 1        | MozyPro Server Add-on for 1 TB Plan (Annual) MozyPro Server Add On  | € 214.89   | € 0.00    | 100.00%                   | € 214.89    |
    | today          | after 1 year yesterday | 1        | 10percentoffoutline RULE-10PERCENTOFFOUTLINE                        | € -265.49  | € 0.00    | 100.00%                   | € -265.49   |
    | today          | after 1 year yesterday | 1        | 10percentoffoutline RULE-10PERCENTOFFOUTLINE                        | € -21.49   | € 0.00    | 100.00%                   | € -21.49    |
    |                |                        |          | Total                                                               |            |           |                           | € 2,582.80  |
    | today          |                        |          | Electronic Payment                                                  |            |           |                           | €--2,582.80 |
    |                |                        |          | Solde                                                               |            |           |                           | € 0.00      |
    And Exchange rate of partner invoice should be:
    | partir de la devise | En devise | Taux de change |
    | EUR                 | EUR         | 1            |
    When I close new window
    And I delete partner account


  @TC.124571 @ops_env
  Scenario: 124571 Check the invoice when adding a new EU mozypro partner under MozyPro Ireland - net terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | net terms |
      | 1      | 100 GB    | MozyPro Ireland | Belgium | yes       |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €37.50        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €37.50 | €0.00      | €37.50      |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                              |         |           |                   |             |
      | From Date                | To Date                 | Quantity | Description                                  | Price   | VAT (23%) | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                             |         |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1        | MozyPro 100 GB Plan (Monthly) MozyPro Bundle | € 30.99 | € 6.51    | 100.00%           | € 37.50     |
      |                          |                         |          | Total                                        |         |           |                   | € 37.50     |
      |                          |                         |          | Amount Due                                   |         |           |                   | € 37.50     |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account


  @TC.124577 @ops_env
  Scenario: 124577 Check the invoice when change subscription period - EU reseller - net terms
    When I add a new Reseller partner:
      | period | reseller type | country | create under    | reseller quota | storage add on | net terms |
      | 1      | Gold          | Ireland | MozyPro Ireland | 1000           | 2              | yes       |
    #And the sub-total before taxes or discounts should be correct
    #And the order summary table should be correct
    And New partner should be created
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Monthly            |
      | Unpaid Balance: | €332.59       | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €332.59 | €0.00      | €332.59     |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                         |          |                                                           |        |           |                   |             |
      | From Date                |  To Date                | Quantity | Description                                               | Price  | VAT (23%) | Percent of Period | Total Price |
      |                          |                         |          | Previous Balance                                          |        |           |                   | € 0.00      |
      | today                    | after 1 month yesterday | 1000     | Mozy Reseller GB - Gold (Monthly) Mozy Reseller           | € 0.26 | € 59.80   | 100.00%           | € 319.80    |
      | today                    | after 1 month yesterday | 2        | Mozy Reseller 20 GB add-on - Gold (Monthly) Mozy Reseller | € 5.20 | € 2.39    | 100.00%           | € 12.79     |
      |                          |                         |          | Total                                                     |        |           |                   | € 332.59    |
      |                          |                         |          | Amount Due                                                |        |           |                   | € 332.59    |
    And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    When I act as newly created partner account
    And I change account subscription to annual billing period
    # comment below if running on stating
    #Then Change subscription confirmation message should be:
    #"""
    #Are you sure that you want to change your subscription period from monthly to yearly billing? If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service. Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
    #"""
    And Change subscription price table should be:
      | Description                                   | Amount    |
      | Credit for remainder of monthly subscription  | €332.59   |
      | Charge for new yearly subscription            | €3,244.80 |
      | Total amount to be charged                    | €2,912.21 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                |
      | Yearly (change) | after 1 year | €3,244.80 (Without taxes or discounts) |
    And I navigate to Billing History section from bus admin console page
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €153.50   | €0.00      | €3,991.10   |
      | today | €3,505.01 | €0.00      | €3,837.60   |
      | today | €332.59   | €0.00      | €332.59     |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Invoice head should include newly created partner company name
    And Billing details of partner invoice should be:
      | Billing Detail           |                        |          |                                                          |         |           |                   |             |
      | From Date                | To Date                | Quantity | Description                                              | Price   | VAT (23%) | Percent of Period | Total Price |
      |                          |                        |          | Previous Balance                                         |         |           |                   | € 3,837.60  |
      | today                    | after 1 year yesterday |   2      | Mozy Reseller 20 GB add-on - Gold (Annual) Mozy Reseller | € 62.40 | € 28.70   | 100.00%           | € 153.50    |
      |                          |                        |          | Total                                                    |         |           |                   | € 153.50    |
      |                          |                        |          | Amount Due                                               |         |           |                   | € 3,991.10  |
      And Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | EUR           | EUR         | 1             |
    When I close new window
    And I delete partner account


  @TC.124660 @ops_env @bus @2.17 @corporate_invoices @EU_in_GBP @FX @tasks_p3
  Scenario: 124660 Check the exchange rate table in invoice - EU country charged in GBP
    When I add a new MozyPro partner:
      | period | base plan | create under | country | cc number        |
      | 1      | 50 GB     | MozyPro UK   | France  | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                               |
      | Renewal Date:   | <%=@partner.subscription_period%>         | Renewal Period: | Use Current Period                |
      | Next Charge:    | <%=@partner.subscription_period%>         |                 |                                   |
    And Partner billing history should be:
      | Date  | Amount                                         | Total Paid                                     | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%> | <%=@partner.billing_info.billing[:total_str]%> | <%=@partner.billing_info.billing[:zero]%> |
    When I click the latest date link to view the invoice
    And I navigate to new window
    Then Exchange rate of partner invoice should be:
      | From Currency | To Currency | Exchange Rate |
      | GBP           | EUR         | 1.274381      |
    When I close new window
    And I delete partner account