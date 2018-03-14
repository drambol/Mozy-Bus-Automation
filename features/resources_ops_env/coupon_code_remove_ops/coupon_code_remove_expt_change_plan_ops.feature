Feature: coupon code remove expt change plan, running on ops env (pantheon / staging)

  Subscription:
    - Requirement #143134 Aria coupon code remove: change period and change plan

    - account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
    - other account, confirmation page with coupon price, not delete coupon.
    - new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
    - coupon exception list: nonprofit10, 100pctoffinternaltestcustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator


  @TC.133521 @ops_env
  Scenario: MozyPro 500 GB Plan yearly GBP VAT 500 GB yearly to 8 TB yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | server plan | create under | country        | vat number  | cc number        |
      | DONOT EDIT MozyPro 500 GB yearly to 8 TB yearly | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89    | £954.89     |
      | Server Plan       | 1        | £101.89    | £101.89     |
      | Pre-tax Subtotal  |          |            | £1,056.78   |
      | Total Charges     |          |            | £1,056.78   |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£1,056.78 |
      | Charge for upgraded plans     | £20,811.56 |
      |                               |            |
      | Total amount to be charged    | £19,754.78 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |


  @TC.133524 @ops_env
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro USD 10 gb yearly to 500 gb yearly | 12     | 10 GB     | United States | nonprofit10 |
    Then Sub-total before taxes or discounts should be $109.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $109.89    | $109.89     |
      #| Discounts Applied |          |            | -$10.99     |
      | Pre-tax Subtotal  |          |            | $98.90      |
      | Total Charges     |          |            | $98.90      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -$98.90   |
      | Charge for new 500 GB         | $1,459.89 |
      |                               |           |
      | Total amount to be charged    | $1,360.99 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    Then API* Aria account coupon code info should be nonprofit10