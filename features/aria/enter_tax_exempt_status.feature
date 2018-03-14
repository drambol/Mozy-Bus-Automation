 Feature: enter_tax_exempt_status
  As a Mozy Administrator
  I want provide tax-exempt information to Mozy
  so that I am not charged taxes if they should not apply to my business

  Background:
    Given I log in bus admin console as administrator

  @TC.17533 @firefox  @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17533 Set both Exempt from State and Federal taxes to false for a new Biennially Mozypro partner
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | vat number   | cc number         |
      | 24     | 50 GB     | yes         | France  | FR08410091490 | 5413271111111222  |
#      | 24     | 50 GB     | yes         | Belgium | BE0883236072 | 5413271111111222  |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* I change the Aria tax exemption level for newly created partner aria id to 0
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
#      | BE0883236072 |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I search and delete partner account by newly created partner company name

  @TC.17537 @firefox @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17537 Set Exempt from State taxes to false for a new 3-years MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | country | vat number   | cc number          |
      | 36     | 1     | France  | FR08410091490 | 5413271111111222  |
#      | 36     | 1     | Belgium | BE0883236072 | 5413271111111222  |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* I change the Aria tax exemption level for newly created partner aria id to 2
    Then API* Aria account should be:
      | taxpayer_id  |
      | FR08410091490 |
#      | BE0883236072 |
    And API* Aria tax exempt status for newly created partner aria id should be Federal/National Tax Exempt
    Then I search and delete partner account by newly created partner company name

  @TC.17539 @firefox  @bus @2.0 @enter_tax-exempt_status @regression @core_function
  Scenario: 17539 Set Exempt from Federal taxes to false for a new Yearly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | country | vat number    | cc number         |
      | 1      | Silver        | 100            | Italy   | IT03018900245 | 4916921703777575  |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* I change the Aria tax exemption level for newly created partner aria id to 1
    Then API* Aria account should be:
      | taxpayer_id   |
      | IT03018900245 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province Tax Exempt
    Then I search and delete partner account by newly created partner company name

   @TC.18897 @bus @others @regression @core_function
   Scenario: 18897 Deletion is triggered by admins in the bus(Mozypro,business,yearly)
     When I add a new MozyPro partner:
       | period | users | server plan | server add on |
       | 12     | 10    | 100 GB      | 1             |
     And New partner should be created
     And I get partner aria id
     And I delete partner account
     When API* I get Aria account details by newly created partner aria id
     Then API* Aria account should be:
       | status_label |
       | CANCELLED    |