Feature: Misc Operations, running on ops env (pantheon / staging)

    Subscription:
      - None

  Background:
    Given I log in bus admin console as administrator

  @TC.13111 @ops_env
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