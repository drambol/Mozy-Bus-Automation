Feature: Change Plan for Reseller Partners, on ops aria(pantheon/staging)

  Background:
    Given I log in bus admin console as administrator


  @TC.17245 @ops_env
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
      | Charge for upgraded plans  | $34.60 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 100            | 2              | Yes         |
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount   | Total Paid    | Balance Due |
      | today | $34.60   | $0.00         | $58.60     |
      | today | $24.00   | $0.00         |  $24.00     |
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal supplemental plan details should be:
      |Number purchased| Price each|Total price for GB - Platinum Reseller|
      |100             | $0.24     |$24.00                                |
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                    | Payment Type                         |
      | Monthly (change)| after 1 month| $58.60 (Without taxes or discounts)       | Invoice (change payment information) |
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 140       | 140      | 0    | Unlimited | Unlimited |

