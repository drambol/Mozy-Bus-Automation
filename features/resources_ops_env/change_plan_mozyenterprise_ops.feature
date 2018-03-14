Feature: Change Plan for MozyEnterprise Partners, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.19239 @ops_env
  Scenario: 19239 MozyEnterprise 250 GB storage add-on yearly to 500 GB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5              |
    Then Change plan charge summary should be:
      | Description                                | Amount     |
      | Credit for remainder of 250 GB Server Plan | -$1,220.78 |
      | Charge for upgraded plans                  | $8,009.23  |
      |                                            |            |
      | Total amount to be charged                 | $6,788.45  |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.19272 @ops_env
  Scenario: 19272 MozyEnterprise VAT yearly to 20 TB add-on
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | vat number    | country | cc number        |
      | 12     | 15    | 24 TB       | 5             | FR08410091490 | France  | 4485393141463880 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | storage add-on |
      | 10    | 20 TB       | 0              |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | storage add-on |
      | 10    | 20 TB       | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.17815 @ops_env
  Scenario: 17815 MozyPro Enterprise Yearly add server option
    When I add a new MozyEnterprise partner:
      |company name            | period |users | country      | address           | city      | state abbrev | zip   | phone          |
      |TC.17815_mozyent_partner| 12     |   10 |United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $950.00
    And Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 10       | $95.00     | $950.00     |
      | Pre-tax Subtotal    |          |            | $950.00     |
      | Total Charges       |          |            | $950.00     |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan |storage add-on|
      | 20    | 10 GB       |    0         |
    Then Change plan charge summary should be:
      | Description               | Amount     |
      |Charge for upgraded plans  | $1,103.78  |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan| storage add-on |
      | 20    | 10 GB      | 0              |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount   | Total Paid    | Balance Due |
      | today | $153.78  | $153.78       | $0.00       |
      | today | $950.00  | $950.00       | $0.00       |
      | today | $950.00  | $950.00       | $0.00       |
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      |Number purchased| Price each|Total price for MozyEnterprise User|
      |20              | $95.00    |$1,900.00                          |
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                    | Payment Type                  |
      | Yearly (change) | after 1 years| $2,053.78 (Without taxes or discounts)    | Visa ending in @XXXX (change) |
    When I stop masquerading
    Then I search and delete partner account by TC.17815_mozyent_partner
