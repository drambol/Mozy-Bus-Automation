Feature: Misc Operations
  
  Background:
    Given I log in bus admin console as administrator

  @TC.13110 @bus @aria @tasks_p3 @misc_operations @regression
  Scenario: Mozy-13110:Changes in Company Name not reflected in Aria
    When I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I get partner aria id
    And I can change partner name
    And I change partner name to Test_changed_partnername
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account billing info should be:
      | partner name            |
      | Test_changed_partnername|

  @TC.13111 @bus @aria @tasks_p3 @misc_operations @regression
  Scenario: Mozy-13111:Payment in Aria appears in BUS as an unpaid balance.
    When I add a new MozyPro partner:
      | period | base plan |company name       |
      | 1      | 10 GB     |Internal test 13111|
    Then New partner should be created
    And I get partner aria id
    Then API* The Aria account newly created partner aria id payment amount should be 9.99
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
    When I stop masquerading
    And I search partner by Internal test 13111
    And I view partner details by Internal test 13111
    And I get partner aria id
    Then API* The Aria account newly created partner aria id payment amount should be 10
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And I delete partner account

  @TC.13112 @bus @aria @tasks_p3 @misc_operations @regression
  Scenario: Mozy-13112:The coupon code has no effect for total amount caculating.
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And I delete partner account


