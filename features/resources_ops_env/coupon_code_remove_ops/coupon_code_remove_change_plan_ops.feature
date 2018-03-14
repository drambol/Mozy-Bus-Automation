Feature: coupon code remove, running on ops env (pantheon / staging)

  Subscription:
   - Requirement #143134 Aria coupon code remove: change period and change plan

   - account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
   - other account, confirmation page with coupon price, not delete coupon.
   - new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
   - coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133462 @ops_env
  Scenario: MozyPro usd with add new line coupon 10 GB monthly to 250 GB monthly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD coupon | 1      | 10 GB     | United States | 10percentoffoutline |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 10percentoffoutline
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount  |
      | Credit for remainder of 10 GB  | -$8.99  |
      | Charge for new 250 GB          | $85.49  |
      |                                |         |
      | Total amount to be charged     | $76.50  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |
    Then API* Aria account coupon code info should be 10percentoffoutline

  @TC.133463 @ops_env
  Scenario: MozyPro Ireland with add new line coupon 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon              | cc number        |
      | DONOT MozyPro 10 gb yearly to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | 10percentoffoutline | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Server Plan       | 1        | €32.89     | €32.89      |
      | Discounts Applied |          |            | -€12.08     |
      | Pre-tax Subtotal  |          |            | €108.70     |
      | Taxes             |          |            | €25.00      |
      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 10percentoffoutline
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€133.70 |
      | Charge for upgraded plans     | €956.66  |
      |                               |          |
      | Total amount to be charged    | €822.96  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil