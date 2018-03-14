Feature: Tax exempt status
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  Background:
    Given I log in bus admin console as administrator

  @TC.17526 @firefox @bus @2.0 @enter_tax-exempt_status @regression @core_function @ROR_smoke
  Scenario: 17526 Verify default tax-exempt status of a new Yearly MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number     | net terms |
      | 1      | 50 GB     | yes         | France | FR08410091490  | yes       |
#      | 1      | 50 GB     | yes         | Belgium | BE0883236072 | yes       |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
#      | BE0883236072 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I search and delete partner account by newly created partner company name

  @TC.17527 @firefox @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17527 Verify default tax-exemtp status of a new Biennially MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number     | net terms |
      | 24     | 1     | France | FR08410091490  | yes       |
#      | 24     | 1     | Belgium | BE0883236072 | yes       |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
#      | BE0883236072 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I search and delete partner account by newly created partner company name

  @TC.17528 @firefox @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17528 Verify default tax-exemtp status of a new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | country | vat number    | net terms |
      | 1      | Gold          | 100            | yes         | Italy   | IT03018900245 | yes       |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | IT03018900245 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I search and delete partner account by newly created partner company name
  @TC.17547 @bus @2.0 @enter_tax-exempt_status @regression @core_function
    Scenario: 17547 No taxes charged when create a new Monthly MozyPro partner
      When I add a new MozyPro partner:
        | period | base plan | country | vat number     | net terms |
        | 1      | 50 GB     | France | FR08410091490  | yes       |
#        | 1      | 50 GB     | Belgium | BE0883236072 | yes       |
      Then Order summary table should be:
        | Description       | Quantity | Price Each | Total Price |
        | 50 GB             | 1        | $19.99     | $19.99      |
        | Pre-tax Subtotal  |          |            | $19.99      |
        | Total Charges     |          |            | $19.99      |
      And New partner should be created

  @TC.17555 @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17555 No taxes charged when create a new Yearly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number     | net terms |
      | 12     | 1     | France | FR08410091490  | yes       |
#      | 12     | 1     | Belgium | BE0883236072 | yes       |
    Then Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 1        | $95.00     | $95.00      |
      | Pre-tax Subtotal      |          |            | $95.00      |
      | Total Charges         |          |            | $95.00      |
    And New partner should be created

  @TC.17556 @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17556 No taxes charged when create a new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | country | vat number    | net terms |
      | 1      | Platinum      | 100            | Italy   | IT03018900245 | yes       |
    Then Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $0.24      | $24.00      |
      | Pre-tax Subtotal       |          |            | $24.00      |
      | Total Charges          |          |            | $24.00      |
    And New partner should be created


