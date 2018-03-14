Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
  other account, confirmation page with coupon price, not delete coupon.
  new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
  coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133506 @add_new_partner @mozypro @bus
  Scenario: silver monthly to 20 GB add on
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | coupon                | country       |
      | 1      | Silver        | 100            | <%=QA_ENV['15percentcoupon']%> | United States |
    Then Sub-total before taxes or discounts should be $33.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 100      | $0.33      | $33.00      |
#      | Pre-tax Subtotal     |          |            | $28.05      |
#      | Total Charges        |          |            | $28.05      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 2              |
    Then Change plan charge summary should be:
      | Description                 | Amount |
      | Charge for new 20 GB add-on | $13.20 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 100            | 2              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133507 @add_new_partner @mozypro @bus
  Scenario: silver monthly to server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under   | vat number    | coupon                | country | cc number        |
      | 1      | Silver        | 500            | MozyPro France | FR08410091490 | <%=QA_ENV['15percentcoupon']%> | France  | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €150.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €0.30      | €150.00     |
#      | Pre-tax Subtotal     |          |            | €127.50     |
#      | Total Charges        |          |            | €127.50     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €17.00 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 0              | Yes         |
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>

  @TC.133508 @add_new_partner @mozypro @bus
  Scenario: silver monthly to 20 GB add-on&server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | coupon                | country        | cc number        |
      | 1      | Silver        | 200            | MozyPro UK   | <%=QA_ENV['15percentcoupon']%> | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £44.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 200      | £0.22      | £44.00      |
#      | Pre-tax Subtotal     |          |            | £37.40      |
#      | Taxes                |          |            | £7.48       |
#      | Total Charges        |          |            | £44.88      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 1              | Yes         |
    Then Change plan charge summary should be:
      | Description               | Amount |
      | Charge for upgraded plans | £29.28 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 200            | 1              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133509 @add_new_partner @mozypro @bus
  Scenario: silver yearly to 20 GB add on
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under    | vat number | coupon                | country | cc number        |
      | 12     | Silver        | 500            | yes         | MozyPro Ireland | IE9691104A | <%=QA_ENV['10percentcoupon']%> | Ireland | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €2,040.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
#      | Server Plan          | 1        | €240.00    | €240.00     |
#      | Pre-tax Subtotal     |          |            | €1,836.00   |
#      | Taxes                |          |            | €422.28     |
#      | Total Charges        |          |            | €2,258.28   |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 1              |
    Then Change plan charge summary should be:
      | Description                 | Amount  |
      | Charge for new 20 GB add-on | €88.56  |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 1              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133510 @add_new_partner @mozypro @bus
  Scenario: silver yearly to server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | coupon                | create under | country        | vat number  | net terms |
      | 12     | Silver        | 500            | 10             | <%=QA_ENV['10percentcoupon']%> | MozyPro UK   | United Kingdom | GB117223643 | yes       |
    Then Sub-total before taxes or discounts should be £1,848.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | £2.64      | £1,320.00   |
#      | 20 GB add-on         | 10       | £52.80     | £528.00     |
#      | Pre-tax Subtotal     |          |            | £1,663.20   |
#      | Total Charges        |          |            | £1,663.20   |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for new Server Plan | £240.00 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 10             | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133511 @add_new_partner @mozypro @bus
  Scenario: silver yearly to 20 GB add-on&server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | coupon                | country       |
      | 12     | Silver        | 50             | <%=QA_ENV['10percentcoupon']%> | United States |
    Then Sub-total before taxes or discounts should be $198.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 50       | $3.96      | $198.00     |
#      | Pre-tax Subtotal     |          |            | $178.20     |
#      | Total Charges        |          |            | $178.20     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 5              | Yes         |
    Then Change plan charge summary should be:
      | Description               | Amount  |
      | Charge for upgraded plans | $696.00 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 50             | 5              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133512 @add_new_partner @mozypro @bus
  Scenario: gold monthly to 20 GB add on
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under | vat number  | coupon                | country        | cc number        |
      | 1      | Gold          | 500            | yes         | MozyPro UK   | GB117223643 | <%=QA_ENV['15percentcoupon']%> | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £155.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 500      | £0.18      | £90.00      |
#      | Server Plan        | 1        | £65.00     | £65.00      |
#      | Pre-tax Subtotal   |          |            | £131.75     |
#      | Total Charges      |          |            | £131.75     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 3              |
    Then Change plan charge summary should be:
      | Description                 | Amount  |
      | Charge for new 20 GB add-on | £10.80  |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 3              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133513 @add_new_partner @mozypro @bus
  Scenario: gold monthly to server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under    | coupon                | country | net terms |
      | 1      | Gold          | 20             | MozyPro Germany | <%=QA_ENV['15percentcoupon']%> | Germany | yes       |
    Then Sub-total before taxes or discounts should be €5.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 20       | €0.25      | €5.00       |
#      | Pre-tax Subtotal   |          |            | €4.25       |
#      | Taxes              |          |            | €0.81       |
#      | Total Charges      |          |            | €5.06       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €80.92 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 20             | 0              | Yes         |
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>

  @TC.133514 @add_new_partner @mozypro @bus
  Scenario: gold monthly to 20 GB add-on&server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | coupon                | country       |
      | 1      | Gold          | 10             | <%=QA_ENV['15percentcoupon']%> | United States |
    Then Sub-total before taxes or discounts should be $2.80
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 10       | $0.28      | $2.80       |
#      | Pre-tax Subtotal   |          |            | $2.38       |
#      | Total Charges      |          |            | $2.38       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 4              | Yes         |
    Then Change plan charge summary should be:
      | Description               | Amount  |
      | Charge for upgraded plans | $122.40 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 10             | 4              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133515 @add_new_partner @mozypro @bus
  Scenario: platinum yearly to 20 GB add on
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | country       | coupon                |
      | 12     | Platinum      | 500            | yes       | United States | <%=QA_ENV['15percentcoupon']%> |
    Then Sub-total before taxes or discounts should be $1,440.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 500      | $2.88      | $1,440.00   |
#      | Pre-tax Subtotal       |          |            | $1,224.00   |
#      | Total Charges          |          |            | $1,224.00   |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 6              |
    Then Change plan charge summary should be:
      | Description                 | Amount   |
      | Charge for new 20 GB add-on | $345.60  |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 6              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133516 @add_new_partner @mozypro @bus
  Scenario: platinum yearly to server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under    | coupon                | country | net terms |
      | 12     | Platinum      | 30             | MozyPro Germany | <%=QA_ENV['15percentcoupon']%> | Germany | yes       |
    Then Sub-total before taxes or discounts should be €79.20
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 30       | €2.64      | €79.20      |
#      | Pre-tax Subtotal       |          |            | €67.32      |
#      | Taxes                  |          |            | €12.79      |
#      | Total Charges          |          |            | €80.11      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount    |
      | Charge for new Server Plan | €1,999.20 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 30             | 0              | Yes         |
    Then API* Aria account coupon code info should be nil

  @TC.133517 @add_new_partner @mozypro @bus
  Scenario: platinum yearly to 20 GB add-on&server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | coupon                | country        | cc number        |
      | 12     | Platinum      | 40             | MozyPro UK   | <%=QA_ENV['15percentcoupon']%> | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £76.80
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 40       | £1.92      | £76.80      |
#      | Pre-tax Subtotal       |          |            | £65.28      |
#      | Taxes                  |          |            | £13.06      |
#      | Total Charges          |          |            | £78.34      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on | server plan |
      | 7              | Yes         |
    Then Change plan charge summary should be:
      | Description               | Amount    |
      | Charge for upgraded plans | £1,978.56 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 40             | 7              | Yes         |
    Then API* Aria account coupon code info should be nil
