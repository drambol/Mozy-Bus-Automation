Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
  other account, confirmation page with coupon price, not delete coupon.
  new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
  coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133462 @add_new_partner @mozypro @bus
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

  @TC.133463 @add_new_partner @mozypro @bus
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

  @TC.133464 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK with add new line coupon 250 gb yearly to 8 tb yearly
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | coupon              | cc number        | vat number  |
      | DONOT EDIT MozyPro 250 gb yearly to 500 gb yearly | 12     | 250 GB    | MozyPro UK   | United Kingdom | 10percentoffoutline | 4916783606275713 | GB117223643 |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£47.79     |
      | Pre-tax Subtotal  |          |            | £430.10     |
      | Total Charges     |          |            | £430.10     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 10percentoffoutline
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -£430.10   |
      | Charge for new 8 TB            | £18,037.60 |
      |                                |            |
      | Total amount to be charged     | £17,607.50 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |
    Then API* Aria account coupon code info should be 10percentoffoutline

  @TC.133465 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD with add new line coupon 250 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro  250 gb yearly to 4 tb yearly | 12     | 250 GB    | United States | 10percentoffoutline |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 10percentoffoutline
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$656.90   |
      | Charge for new 4 TB            | $11,089.89 |
      |                                |            |
      | Total amount to be charged     | $10,432.99 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |
    Then API* Aria account coupon code info should be nil

  @TC.133466 @add_new_partner @mozypro @bus
  Scenario: MozyPro usd with reduce line coupon 10 GB monthly to 250 GB monthly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon                |
      | DONOT EDIT MozyPro 10 GB Plan monthly USD coupon | 1      | 10 GB     | United States | catherine10pctultdpro |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be catherine10pctultdpro
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
    Then API* Aria account coupon code info should be catherine10pctultdpro

  @TC.133467 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with reduce line coupon 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | catherine10pctultdpro | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | €87.89     | €87.89      |
      | Server Plan       | 1        | €32.89     | €32.89      |
      | Pre-tax Subtotal  |          |            | €108.70     |
      | Taxes             |          |            | €25.00      |
      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be catherine10pctultdpro
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€133.70 |
      | Charge for upgraded plans     | €956.68  |
      |                               |          |
      | Total amount to be charged    | €822.98  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133468 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK with reduce line coupon 250 gb yearly to 8 tb yearly
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | coupon                | cc number        | vat number  |
      | DONOT EDIT MozyPro 250 gb yearly to 500 gb yearly | 12     | 250 GB    | MozyPro UK   | United Kingdom | catherine10pctultdpro | 4916783606275713 | GB117223643 |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Pre-tax Subtotal  |          |            | £430.10     |
      | Total Charges     |          |            | £430.10     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be catherine10pctultdpro
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 8 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -£430.10   |
      | Charge for new 8 TB            | £18,037.60 |
      |                                |            |
      | Total amount to be charged     | £17,607.50 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 8 TB      |
    Then API* Aria account coupon code info should be catherine10pctultdpro

  @TC.133469 @add_new_partner @mozypro @bus
  Scenario: MozyPro usd with reduce line coupon 250 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon                |
      | DONOT EDIT MozyPro  250 gb yearly to 4 tb yearly | 12     | 250 GB    | United States | catherine10pctultdpro |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be catherine10pctultdpro
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$656.90   |
      | Charge for new 4 TB            | $11,089.89 |
      |                                |            |
      | Total amount to be charged     | $10,432.99 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |
    Then API* Aria account coupon code info should be nil

  @TC.133470 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 500 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | <%=QA_ENV['10percentcoupon']%> | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€12.08     |
#      | Pre-tax Subtotal  |          |            | €108.70     |
#      | Taxes             |          |            | €25.00      |
#      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | No          |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€97.29   |
      | Charge for new 500 GB         | €1,633.30 |
      |                               |           |
      | Total amount to be charged    | €1,536.01 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133471 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 1 tb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | <%=QA_ENV['10percentcoupon']%> | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€12.08     |
#      | Pre-tax Subtotal  |          |            | €108.70     |
#      | Taxes             |          |            | €25.00      |
#      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | No          |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€97.29   |
      | Charge for new 1 TB           | €3,265.51 |
      |                               |           |
      | Total amount to be charged    | €3,168.22 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133472 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 2 tb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | <%=QA_ENV['10percentcoupon']%> | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€12.08     |
#      | Pre-tax Subtotal  |          |            | €108.70     |
#      | Taxes             |          |            | €25.00      |
#      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -€133.70  |
      | Charge for upgraded plans     | €6,801.62 |
      |                               |           |
      | Total amount to be charged    | €6,667.92 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133473 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan yearly Ireland 10 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                              | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 4 tb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | <%=QA_ENV['10percentcoupon']%> | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€12.08     |
#      | Pre-tax Subtotal  |          |            | €108.70     |
#      | Taxes             |          |            | €25.00      |
#      | Total Charges     |          |            | €133.70     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€133.70   |
      | Charge for upgraded plans     | €12,828.62 |
      |                               |            |
      | Total amount to be charged    | €12,694.92 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133474 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to server plan
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb yearly to server plan | 12     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    Then Sub-total before taxes or discounts should be $729.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $729.89    | $729.89     |
#      | Discounts Applied |          |            | -$109.48    |
#      | Pre-tax Subtotal  |          |            | $620.41     |
#      | Total Charges     |          |            | $620.41     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | $124.89    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133475 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb yearly to 500 gb yearly | 12     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    Then Sub-total before taxes or discounts should be $729.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $729.89    | $729.89     |
#      | Discounts Applied |          |            | -$109.48    |
#      | Pre-tax Subtotal  |          |            | $620.41     |
#      | Total Charges     |          |            | $620.41     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 250 GB | -$620.41  |
      | Charge for new 500 GB          | $1,459.89 |
      |                                |           |
      | Total amount to be charged     | $839.48   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133476 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb yearly to 1 tb yearly | 12     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    Then Sub-total before taxes or discounts should be $729.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $729.89    | $729.89     |
#      | Discounts Applied |          |            | -$109.48    |
#      | Pre-tax Subtotal  |          |            | $620.41     |
#      | Total Charges     |          |            | $620.41     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 250 GB | -$620.41  |
      | Charge for upgraded plans      | $3,156.78 |
      |                                |           |
      | Total amount to be charged     | $2,536.37 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133477 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb yearly to 2 tb yearly | 12     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    Then Sub-total before taxes or discounts should be $729.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $729.89    | $729.89     |
#      | Discounts Applied |          |            | -$109.48    |
#      | Pre-tax Subtotal  |          |            | $620.41     |
#      | Total Charges     |          |            | $620.41     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | No          |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 250 GB | -$620.41  |
      | Charge for new 2 TB            | $5,769.89 |
      |                                |           |
      | Total amount to be charged     | $5,149.48 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133478 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan yearly to 250 gb yearly | 12     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133479 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan yearly to 250 gb yearly | 12     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | £122.27    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133480 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan yearly to 1 tb yearly | 12     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | No          |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133481 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon                         | net terms | vat number  |
      | DONOT EDIT MozyPro 8 TB Plan yearly to 2 tb yearly | 12     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | yes       | GB117223643 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | £203.89    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133482 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan yearly to 4 tb yearly | 12     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | No          |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133483 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan biennially France 10 gb biennially to 250 gb biennially
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | server plan | create under   | country | coupon | net terms | vat number    |
      | DONOT MozyPro 10 gb biennially to 250 gb biennially | 24     | 10 GB     | yes         | MozyPro France | France  | <%=QA_ENV['10percentcoupon']%> | yes       | FR08410091490 |
    Then Sub-total before taxes or discounts should be €230.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €167.79    | €167.79     |
#      | Server Plan       | 1        | €62.79     | €62.79      |
#      | Discounts Applied |          |            | -€23.06     |
#      | Pre-tax Subtotal  |          |            | €207.52     |
#      | Total Charges     |          |            | €207.52     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | No          |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€151.01  |
      | Charge for new 250 GB         | €1,272.79 |
      |                               |           |
      | Total amount to be charged    | €1,121.78 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133484 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan biennially France 10 gb biennially to 500 gb biennially
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | create under   | country | coupon | net terms | vat number    |
      | DONOT MozyPro 10 gb biennially to 500 gb biennially | 24     | 10 GB     | MozyPro France | France  | <%=QA_ENV['10percentcoupon']%> | yes       | FR08410091490 |
    Then Sub-total before taxes or discounts should be €167.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €167.79    | €167.79     |
#      | Discounts Applied |          |            | -€16.78     |
#      | Pre-tax Subtotal  |          |            | €151.01     |
#      | Total Charges     |          |            | €151.01     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€151.01  |
      | Charge for new 500 GB         | €2,536.79 |
      |                               |           |
      | Total amount to be charged    | €2,385.78 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133485 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan biennially France 10 gb biennially to 1 tb biennially
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under   | country | coupon | net terms |
      | DONOT MozyPro 10 gb biennially to 1 tb biennially | 24     | 10 GB     | MozyPro France | France  | <%=QA_ENV['10percentcoupon']%> | yes       |
    Then Sub-total before taxes or discounts should be €167.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €167.79    | €167.79     |
#      | Discounts Applied |          |            | -€16.78     |
#      | Pre-tax Subtotal  |          |            | €151.01     |
#      | Taxes             |          |            | €30.20      |
#      | Total Charges     |          |            | €181.21     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€181.21  |
      | Charge for upgraded plans     | €6,574.30 |
      |                               |           |
      | Total amount to be charged    | €6,393.09 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133486 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan biennially France 10 gb biennially to 2 tb biennially
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | server plan | create under   | country | coupon | net terms |
      | DONOT MozyPro 10 gb biennially to 2 tb biennially | 24     | 10 GB     | yes         | MozyPro France | France  | <%=QA_ENV['10percentcoupon']%> | yes       |
    Then Sub-total before taxes or discounts should be €230.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €167.79    | €167.79     |
#      | Server Plan       | 1        | €62.79     | €62.79      |
#      | Discounts Applied |          |            | -€23.06     |
#      | Pre-tax Subtotal  |          |            | €207.52     |
#      | Taxes             |          |            | €41.50      |
#      | Total Charges     |          |            | €249.02     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€249.02   |
      | Charge for upgraded plans     | €12,667.90 |
      |                               |            |
      | Total amount to be charged    | €12,418.88 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133487 @add_new_partner @mozypro @bus
  Scenario: MozyPro 10 GB Plan biennially France 10 gb biennially to 4 tb biennially
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | server plan | create under   | country | coupon | net terms |
      | DONOT MozyPro 10 gb biennially to 4 tb biennially | 24     | 10 GB     | yes         | MozyPro France | France  | <%=QA_ENV['10percentcoupon']%> | yes       |
    Then Sub-total before taxes or discounts should be €230.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €167.79    | €167.79     |
#      | Server Plan       | 1        | €62.79     | €62.79      |
#      | Discounts Applied |          |            | -€23.06     |
#      | Pre-tax Subtotal  |          |            | €207.52     |
#      | Taxes             |          |            | €41.50      |
#      | Total Charges     |          |            | €249.02     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€249.02   |
      | Charge for upgraded plans     | €23,893.90 |
      |                               |            |
      | Total amount to be charged    | €23,644.88 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133488 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb biennially to server plan
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb biennially to server plan | 24     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | $231.79    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133489 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb biennially to 500 gb biennially
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb biennially to 500 gb biennially | 24     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$1,189.82 |
      | Charge for new 500 GB          | $2,789.79  |
      |                                |            |
      | Total amount to be charged     | $1,599.97    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133490 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb biennially to 1 tb biennially
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb biennially to 1 tb biennially | 24     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$1,189.82 |
      | Charge for upgraded plans      | $6,026.58  |
      |                                |            |
      | Total amount to be charged     | $4,836.76  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133491 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb biennially to 2 tb biennially
    When I add a new MozyPro partner:
      | company name                                    | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb biennially to 2 tb biennially | 24     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | No          |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$1,189.82 |
      | Charge for new 2 TB            | $11,019.79 |
      |                                |            |
      | Total amount to be charged     | $9,829.97  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133492 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 gb biennially to 4 tb biennially
    When I add a new MozyPro partner:
      | company name                                     | period | base plan | country       | coupon              |
      | DONOT EDIT MozyPro 250 gb biennially to 4 tb biennially | 24     | 250 GB    | United States | <%=QA_ENV['15percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -$1,189.82 |
      | Charge for new 4 TB            | $21,169.79 |
      |                                |            |
      | Total amount to be charged     | $19,979.97 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |
    Then API* Aria account coupon code info should be nil

  @TC.133493 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan biennially to 250 gb biennially
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan biennially to 250 gb biennially | 24     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133494 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan biennially to 500 gb biennially
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan biennially to 250 gb biennially | 24     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | £232.55    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133495 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan biennially to 1 tb biennially
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan biennially to 1 tb biennially | 24     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | No          |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133496 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan biennially to 2 tb biennially
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon                         | net terms | vat number  |
      | DONOT EDIT MozyPro 8 TB Plan biennially to 2 tb biennially | 24     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | yes       | GB117223643 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Charge for new Server Plan     | £386.79    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133497 @add_new_partner @mozypro
  Scenario: MozyPro 8 TB Plan biennially to 4 tb biennially
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | coupon               | cc number        |
      | DONOT EDIT MozyPro 8 TB Plan biennially to 4 tb biennially | 24     | 8 TB      | MozyPro UK   | United Kingdom | <%=QA_ENV['15percentcoupon']%> | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | No          |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133498 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with storage addon and multiple discount rule coupon 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 250 gb yearly | 12     | 100 GB    | 1                    | MozyPro Ireland | Ireland | <%=QA_ENV['20multiple']%> | yes       |
    Then Sub-total before taxes or discounts should be €516.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | 50GB Add-on       | 1        | €175.89    | €175.89     |
#      | Discounts Applied |          |            | -€103.36    |
#      | Pre-tax Subtotal  |          |            | €413.42     |
#      | Taxes             |          |            | €95.08      |
#      | Total Charges     |          |            | €508.50     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['20multiple']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -€335.43 |
      | Charge for new 250 GB          | €816.58  |
      |                                |          |
      | Total amount to be charged     | €481.15  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 250 GB    | 1              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133499 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with storage addon 100 gb yearly to 500 gb yearly
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 500 gb yearly | 12     | 100 GB    | 1                    | MozyPro Ireland | Ireland | <%=QA_ENV['20multiple']%> | yes       |
    Then Sub-total before taxes or discounts should be €516.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | 50GB Add-on       | 1        | €175.89    | €175.89     |
#      | Discounts Applied |          |            | -€103.36    |
#      | Pre-tax Subtotal  |          |            | €413.42     |
#      | Taxes             |          |            | €95.08      |
#      | Total Charges     |          |            | €508.50     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['20multiple']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 100 GB | -€335.43  |
      | Charge for upgraded plans      | €1,807.82 |
      |                                |           |
      | Total amount to be charged     | €1,472.39 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 500 GB    | 1              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133500 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with server plan and storage addon 100 gb yearly to 1 tb yearly
    When I add a new MozyPro partner:
      | company name                               | period | base plan | server plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 1 tb yearly | 12     | 100 GB    | yes         | 1                    | MozyPro Ireland | Ireland | <%=QA_ENV['20multiple']%> | yes       |
    Then Sub-total before taxes or discounts should be €626.67
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | Server Plan       | 1        | €109.89    | €109.89     |
#      | 50GB Add-on       | 1        | €175.89    | €175.89     |
#      | Discounts Applied |          |            | -€125.34    |
#      | Pre-tax Subtotal  |          |            | €501.33     |
#      | Taxes             |          |            | €115.30     |
#      | Total Charges     |          |            | €616.63     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['20multiple']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -€443.56  |
      | Charge for upgraded plans     | €3,529.82 |
      |                               |           |
      | Total amount to be charged    | €3,086.26 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 1 TB      | 1              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133501 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with server plan and storage addon 100 gb yearly to 2 tb yearly
    When I add a new MozyPro partner:
      | company name                               | period | base plan | server plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 2 tb yearly | 12     | 100 GB    | yes         | 1                    | MozyPro Ireland | Ireland | <%=QA_ENV['20multiple']%> | yes       |
    Then Sub-total before taxes or discounts should be €626.67
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | Server Plan       | 1        | €109.89    | €109.89     |
#      | 50GB Add-on       | 1        | €175.89    | €175.89     |
#      | Discounts Applied |          |            | -€125.34    |
#      | Pre-tax Subtotal  |          |            | €501.33     |
#      | Taxes             |          |            | €115.30     |
#      | Total Charges     |          |            | €616.63     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['20multiple']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | No          |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 100 GB | -€335.43  |
      | Charge for new 2 TB            | €6,452.44 |
      |                                |           |
      | Total amount to be charged     | €6,117.01 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 2 TB      | 1              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133502 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with server plan and storage addon 100 gb yearly to 4 tb yearly
    When I add a new MozyPro partner:
      | company name                               | period | base plan | server plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 4 tb yearly | 12     | 100 GB    | yes         | 100                  | MozyPro Ireland | Ireland | <%=QA_ENV['20multiple']%> | yes       |
    Then Sub-total before taxes or discounts should be €18,039.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | Server Plan       | 1        | €109.89    | €109.89     |
#      | 50GB Add-on       | 100      | €175.89    | €17,589.00  |
#      | Discounts Applied |          |            | -€3,607.96  |
#      | Pre-tax Subtotal  |          |            | €14,431.82  |
#      | Taxes             |          |            | €3,319.32   |
#      | Total Charges     |          |            | €17,751.14  |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['20multiple']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€443.56   |
      | Charge for upgraded plans     | €12,828.62 |
      |                               |            |
      | Total amount to be charged    | €12,385.06 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 4 TB      | 100            | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133503 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | storage add on 50 gb | create under    | country | coupon                    | net terms |
      | DONOT MozyPro 100 gb yearly to 250 gb yearly | 12     | 100 GB    | 1                    | MozyPro Ireland | Ireland | <%=QA_ENV['coupon20pc']%> | yes       |
    Then Sub-total before taxes or discounts should be €516.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 100 GB            | 1        | €340.89    | €340.89     |
#      | 50GB Add-on       | 1        | €175.89    | €175.89     |
##      | Discounts Applied |          |            | -€103.36    |
#      | Pre-tax Subtotal  |          |            | €413.42     |
#      | Taxes             |          |            | €95.08      |
#      | Total Charges     |          |            | €508.50     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['coupon20pc']%>
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -€335.43 |
      | Charge for new 250 GB          | €816.59  |
      |                                |          |
      | Total amount to be charged     | €481.16  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | storage add-on | server plan |
      | 250 GB    | 1              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133504 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD with server plan 100 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                 | period | base plan | server plan | coupon              | net terms |
      | DONOT MozyPro 100 gb yearly to 250 gb yearly | 12     | 100 GB    | yes         | 10percentoffoutline | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be 10percentoffoutline
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -$395.90 |
      | Charge for new 250 GB          | $729.89  |
      |                                |          |
      | Total amount to be charged     | $333.99  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133505 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland with server plan 10 gb yearly to 250 gb yearly
    When I add a new MozyPro partner:
      | company name                                | period | base plan | server plan | create under    | country | coupon                | cc number        |
      | DONOT MozyPro 10 gb yearly to 250 gb yearly | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | catherine15pctultdpro | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Pre-tax Subtotal  |          |            | €102.67     |
#      | Taxes             |          |            | €23.61      |
#      | Total Charges     |          |            | €126.28     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be catherine15pctultdpro
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€126.28 |
      | Charge for upgraded plans     | €956.67  |
      |                               |          |
      | Total amount to be charged    | €830.39  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    Then API* Aria account coupon code info should be nil
