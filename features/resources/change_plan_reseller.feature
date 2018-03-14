Feature: Change Plan for Reseller Partners

  Background:
    Given I log in bus admin console as administrator

  @TC.17236 @bus @change_plan @tasks_p3 @regression
  Scenario: 17236 Reseller Silver plan adding server add-on yearly.
    When I add a new Reseller partner:
      | period  | reseller type |  reseller quota |net terms |
      | 12      | Silver        |  100            |yes       |
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 100      | $3.96      | $396.00     |
      | Pre-tax Subtotal     |          |            | $396.00     |
      | Total Charges        |          |            | $396.00     |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 7              | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for upgraded plans  | $854.40 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 100            | 7              | Yes         |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount   | Total Paid    | Balance Due |
      | today | $854.40  |   $0.00       | $1,250.40   |
      | today | $396.00  |   $0.00       | $396.00     |
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      |Number purchased| Price each|Total price for GB - Silver Reseller|
      |100             | $3.96     |$396.00                             |
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                    | Payment Type                         |
      | Yearly (change) | after 1 years| $1,250.40 (Without taxes or discounts)    | Invoice (change payment information) |
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |


  @TC.17245 @bus @change_plan @tasks_p3 @regression
  Scenario: 17245 Reseller Platinum plan add server add-on monthly.
    When I add a new Reseller partner:
      | period  | reseller type |  reseller quota |net terms |
      | 1       | Platinum      |  100            |yes       |
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price|
      | GB - Platinum Reseller | 100      | $0.24      | $24.00     |
      | Pre-tax Subtotal       |          |            | $24.00     |
      | Total Charges          |          |            | $24.00     |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 2              | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for upgraded plans  | $184.60 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 100            | 2              | Yes         |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount   | Total Paid    | Balance Due |
      | today | $184.60  | $0.00         | $208.60     |
      | today | $24.00   | $0.00         |  $24.00     |
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      |Number purchased| Price each|Total price for GB - Platinum Reseller|
      |100             | $0.24     |$24.00                                |
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                    | Payment Type                         |
      | Monthly (change)| after 1 month| $208.60 (Without taxes or discounts)       | Invoice (change payment information) |
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 140       | 140      | 0    | Unlimited | Unlimited |

  @TC.17246 @bus @change_plan @tasks_p3 @regression
  Scenario: 17246 Reseller Gold plan add resources w/ coupon monthly.
    When I add a new Reseller partner:
      | period  | reseller type |  reseller quota |net terms |
      | 1       | Gold          |  100            |yes       |
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price|
      | GB - Gold Reseller     | 100      | $0.28      | $28.00     |
      | Pre-tax Subtotal       |          |            | $28.00     |
      | Total Charges          |          |            | $28.00     |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Change plan charge summary should be:
      | Description                       | Amount  |
      | Charge for new 20 GB add-on       | $16.80  |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on |
      | 100            | 3              |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount   | Total Paid    | Balance Due |
      | today | $16.80   | $0.00         | $44.80      |
      | today | $28.00   | $0.00         |  $28.00     |
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      |Number purchased| Price each|Total price for GB - Gold Reseller  |
      |100             | $0.28     |$28.00                              |
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                    | Payment Type                         |
      | Monthly (change)| after 1 month| $44.80 (Without taxes or discounts)       | Invoice (change payment information) |
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 160       | 160      | 0    | Unlimited | Unlimited |