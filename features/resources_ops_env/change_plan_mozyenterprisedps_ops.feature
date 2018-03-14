Feature: Change Plan for MozyEnterprisedps Partners, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.22480 @ops_env
  Scenario: 22480 [positive]Change Plan to available higher/lower capacity plan for DPS partner
    When I add a new MozyEnterprise DPS partner:
      | period | base plan   | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 100         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $0.00
    And Order summary table should be:
      | Description             | Quantity | Price Each | Total Price |
      | TB - MozyEnterprise DPS | 100      | $0.00      | $0.00       |
      | Total Charges           |          |            | $0.00       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    When I cancel MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    And MozyEnterpriseDPS new plan should be 100
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    Then Change plan charge summary should be:
      | Description                            | Amount     |
      |Charge for new TB - MozyEnterprise DPS  | $0.00      |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 200
    And I refresh Change Plan section
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 100       |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 100
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name