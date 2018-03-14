Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
  other account, confirmation page with coupon price, not delete coupon.
  new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
  coupon exception list: nonprofit10, 100pctoffinternaltestcustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133518 @add_new_partner @mozypro @bus
  Scenario: MozyPro without coupon 10 GB monthly to 250 GB monthly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       |
      | DONOT EDIT MozyPro 10 GB monthly to 250 GB monthly | 1      | 10 GB     | United States |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal  |          |            | $9.99       |
      | Total Charges     |          |            | $9.99       |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount  |
      | Credit for remainder of 10 GB  | -$9.99  |
      | Charge for new 250 GB          | $94.99  |
      |                                |         |
      | Total amount to be charged     | $85.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.133519 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly GBP 10 GB biennially-> 250 GB biennially
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | create under | country        | cc number        |
      | DONOT EDIT MozyPro 10 GB Plan yearly GBP 10 GB biennially to 250 GB biennially | 24     | 10 GB     | MozyPro UK   | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £146.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £146.79    | £146.79     |
      | Pre-tax Subtotal  |          |            | £146.79     |
      | Taxes             |          |            | £29.36      |
      | Total Charges     |          |            | £176.15     |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 10 GB  | -£176.15  |
      | Charge for new 250 GB          | £1,097.75 |
      |                                |           |
      | Total amount to be charged     | £921.60   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |

  @TC.133520 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan Biennially EUR Germany 250 GB Biennially to 8 tb Biennially
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | server plan | create under    | country | cc number        | coupon                        |
      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany 250 GB Biennially to 8 tb Biennially | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100pctoffinternaltestcustomer |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 100pctoffinternaltestcustomer
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount |
      | Charge for upgraded plans     | €0.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |
    Then API* Aria account coupon code info should be 100pctoffinternaltestcustomer

  @TC.133521 @add_new_partner @mozypro
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

  @TC.133522 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan Biennially USD to 2 TB Biennially
    When I add a new MozyPro partner:
      | company name                                                     | period | base plan | country       |
      | DONOT EDIT MozyPro 500 GB Plan Biennially USD to 2 TB Biennially | 24     | 500 GB    | United States |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $2,789.79  | $2,789.79   |
      | Pre-tax Subtotal  |          |            | $2,789.79   |
      | Total Charges     |          |            | $2,789.79   |
    And New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 500 GB | -$2,789.79 |
      | Charge for new 2 TB            | $11,019.79 |
      |                                |            |
      | Total amount to be charged     | $8,230.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 2 TB      |

  @TC.133523 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon      | cc number        |
      | DONOT MozyPro 10 gb yearly to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | nonprofit10 | 4319402211111113 |
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
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€133.70 |
      | Charge for upgraded plans     | €861.01  |
      |                               |          |
      | Total amount to be charged    | €727.31  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133524 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro USD 10 gb yearly to 500 gb yearly | 12     | 10 GB     | United States | nonprofit10 |
    Then Sub-total before taxes or discounts should be $109.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $109.89    | $109.89     |
      | Discounts Applied |          |            | -$10.99     |
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
      | Charge for new 500 GB         | $1,313.90 |
      |                               |           |
      | Total amount to be charged    | $1,215.00 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133525 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon      | cc number        |
      | DONOT EDIT MozyPro USD 10 gb yearly to 1 tb yearly | 12     | 10 GB     | MozyPro UK   | United Kingdom | nonprofit10 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £76.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £76.89     | £76.89      |
      | Discounts Applied |          |            | -£7.69      |
      | Pre-tax Subtotal  |          |            | £69.20      |
      | Taxes             |          |            | £13.84      |
      | Total Charges     |          |            | £83.04      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -£83.04   |
      | Charge for upgraded plans     | £2,228.88 |
      |                               |           |
      | Total amount to be charged    | £2,145.84 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133526 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | create under   | country | coupon      | cc number        |
      | DONOT MozyPro 10 gb yearly to 2 tb yearly | 12     | 10 GB     | MozyPro France | France  | nonprofit10 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Taxes             |          |            | €15.82      |
      | Total Charges     |          |            | €94.92      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€94.92   |
      | Charge for new 2 TB           | €5,665.56 |
      |                               |           |
      | Total amount to be charged    | €5,570.64 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 2 TB      |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133527 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | create under    | country | coupon      | cc number        | vat number  |
      | DONOT MozyPro 10 gb yearly to 4 tb yearly | 12     | 10 GB     | MozyPro Germany | Germany | nonprofit10 | 4188181111111112 | DE812321109 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Total Charges     |          |            | €79.10      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€79.10   |
      | Charge for upgraded plans     | €9,386.80 |
      |                               |           |
      | Total amount to be charged    | €9,307.70  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133528 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly USD 10 gb yearly to server plan
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro USD 10 gb yearly to server plan | 12     | 10 GB     | United States | nonprofit10 |
    Then Sub-total before taxes or discounts should be $109.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $109.89    | $109.89     |
      | Discounts Applied |          |            | -$10.99     |
      | Pre-tax Subtotal  |          |            | $98.90      |
      | Total Charges     |          |            | $98.90      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | $39.50 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 10 GB     | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133529 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 100 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | create under    | country | coupon      | cc number        | vat number  |
      | DONOT MozyPro 10 gb yearly to 100 gb yearly | 12     | 10 GB     | MozyPro Germany | Germany | nonprofit10 | 4188181111111112 | DE812321109 |
    Then Sub-total before taxes or discounts should be €87.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Discounts Applied |          |            | -€8.79      |
      | Pre-tax Subtotal  |          |            | €79.10      |
      | Total Charges     |          |            | €79.10      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of 10 GB | -€79.10  |
      | Charge for upgraded plans     | €405.70  |
      |                               |          |
      | Total amount to be charged    | €326.60  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133530 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan monthly USD 10 GB monthly to 250 gb monthly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro 10 GB monthly to 250 gb monthly | 1      | 10 GB     | United States | nonprofit10 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
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
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133531 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK with exception coupon 10 GB monthly to 250 GB monthly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB monthly to 250 GB monthly | 1      | 10 GB     | MozyPro UK   | United Kingdom | nonprofit10 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £6.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | £6.99      | £6.99       |
      | Discounts Applied |          |            | -£0.70      |
      | Pre-tax Subtotal  |          |            | £6.29       |
      | Taxes             |          |            | £1.26     |
      | Total Charges     |          |            | £7.55       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | £3.23  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 10 GB     | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133532 @add_new_partner @mozypro @bus
  Scenario: MozyPro France with exception coupon 10 GB monthly to 250 GB monthly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under   | country | coupon      | cc number        |
      | DONOT EDIT MozyPro 10 GB monthly to 250 GB monthly | 1      | 10 GB     | MozyPro France | France  | nonprofit10 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €7.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €7.99      | €7.99       |
      | Discounts Applied |          |            | -€0.80      |
      | Pre-tax Subtotal  |          |            | €7.19       |
      | Taxes             |          |            | €1.44       |
      | Total Charges     |          |            | €8.63       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 50 GB     | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount  |
      | Credit for remainder of 10 GB  | -€8.63  |
      | Charge for upgraded plans      | €23.20  |
      |                                |         |
      | Total amount to be charged     | €14.57  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133533 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon      |
      | DONOT EDIT MozyPro  250 gb yearly to 4 tb yearly | 12     | 250 GB    | United States | nonprofit10 |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 250 GB | -$656.90  |
      | Charge for new 4 TB            | $9,980.90 |
      |                                |           |
      | Total amount to be charged     | $9,324.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133534 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to server plan
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | create under    | country | coupon      | cc number        |
      | DONOT EDIT MozyPro  250 gb yearly to server plan | 12     | 250 GB    | MozyPro Ireland | Ireland | nonprofit10 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Discounts Applied |          |            | -€66.39     |
      | Pre-tax Subtotal  |          |            | €597.50     |
      | Taxes             |          |            | €137.43     |
      | Total Charges     |          |            | €734.93     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for new Server Plan | €126.08 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nonprofit10

  @TC.133535 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | coupon      | cc number        | vat number  |
      | DONOT EDIT MozyPro 250 gb yearly to 500 gb yearly | 12     | 250 GB    | MozyPro UK   | United Kingdom | nonprofit10 | 4916783606275713 | GB117223643 |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£47.79     |
      | Pre-tax Subtotal  |          |            | £430.10     |
      | Total Charges     |          |            | £430.10     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be nonprofit10
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 250 GB | -£430.10 |
      |Charge for upgraded plans       | £951.10  |
      |                                |          |
      | Total amount to be charged     | £521.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then API* Aria account coupon code info should be nonprofit10
