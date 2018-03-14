Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  Background:
    Given I log in bus admin console as administrator

  @TC.133625 @add_new_partner @mozypro @bus
  Scenario: Reseller silver monthly France new
    When I add a new Reseller partner:
      | company name                                  | period | reseller type | reseller quota | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller silver monthly France exception new | 1      | Silver        | 100            | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be €30.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 100      | €0.30      | €30.00      |
      | Discounts Applied    |          |            | -€3.00      |
      | Pre-tax Subtotal     |          |            | €27.00      |
      | Taxes                |          |            | €5.40       |
      | Total Charges        |          |            | €32.40      |
    And New partner should be created

  @TC.133626 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland new with server plan and storage addon
    When I add a new Reseller partner:
      | company name                                      | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland exception new | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €2,760.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
      | Server Plan          | 1        | €240.00    | €240.00     |
      | 20 GB add-on         | 10       | €72.00     | €720.00     |
      | Discounts Applied    |          |            | -€276.00    |
      | Pre-tax Subtotal     |          |            | €2,484.00   |
      | Taxes                |          |            | €571.32     |
      | Total Charges        |          |            | €3,055.32   |
    And New partner should be created

  @TC.133627 @add_new_partner @mozypro @bus
  Scenario: Reseller gold monthly GBP new execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                             | period | reseller type | reseller quota | create under | vat number  | coupon                        | country        | cc number        |
      | DONOT EDIT Reseller gold monthly GBP exception new | 1      | Gold          | 500            | MozyPro UK   | GB117223643 | 100pctOffInternalTestCustomer | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £90.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | £0.18      | £90.00      |
      | Total Charges      |          |            | £0.00       |
    And New partner should be created

  @TC.133628 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP new with server plan and storage addon
    When I add a new Reseller partner:
      | company name                            | period | reseller type | reseller quota | server plan | storage add on | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception new | 12     | Gold          | 100            | yes         | 10             | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £1,428.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 100      | £2.16      | £216.00     |
      | Server Plan        | 1        | £780.00    | £780.00     |
      | 20 GB add-on       | 10       | £43.20     | £432.00     |
      | Discounts Applied  |          |            | -£142.80    |
      | Pre-tax Subtotal   |          |            | £1,285.20   |
      | Taxes              |          |            | £257.04     |
      | Total Charges      |          |            | £1,542.24   |
    And New partner should be created

  @TC.133629 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum monthly USD new execute manually as wrong sequence of gold and platinum
    When I add a new Reseller partner:
      | company name                                 | period | reseller type | reseller quota | coupon      | country       |
      | DONOT EDIT Reseller platinum monthly USD exception new | 1      | Platinum      | 100            | Nonprofit10 | United States |
    Then Sub-total before taxes or discounts should be $24.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $0.24      | $24.00      |
      | Discounts Applied      |          |            | -$2.40      |
      | Pre-tax Subtotal       |          |            | $21.60      |
      | Total Charges          |          |            | $21.60      |
    And New partner should be created

  @TC.133630 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD new with server plan and storage addon
    When I add a new Reseller partner:
      | company name                                | period | reseller type | reseller quota | server plan | storage add on | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD exception new | 12     | Platinum      | 100            | yes         | 10             | 100pctOffInternalTestCustomer | United States |
    Then Sub-total before taxes or discounts should be $2,964.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $2.88      | $288.00     |
      | Server Plan            | 1        | $2,100.00  | $2,100.00   |
      | 20 GB add-on           | 10       | $57.60     | $576.00     |
      | Total Charges          |          |            | $0.00       |
    And New partner should be created

  @TC.133631 @add_new_partner @mozypro @bus
  Scenario: Reseller silver yearly EUR Ireland new
    When I add a new Reseller partner:
      | company name                                                  | period | reseller type | reseller quota | create under    | vat number | coupon      | country | cc number        |
      | DONOT EDIT Reseller silver yearly EUR Ireland change plan exception new | 12     | Silver        | 500            | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €1,800.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
      | Discounts Applied    |          |            | -€180.00    |
      | Pre-tax Subtotal     |          |            | €1,620.00   |
      | Taxes                |          |            | €372.60     |
      | Total Charges        |          |            | €1,992.60   |
    And New partner should be created

  @TC.133632 @add_new_partner @mozypro @bus
  Scenario: Reseller gold yearly GBP new
    When I add a new Reseller partner:
      | company name                                        | period | reseller type | reseller quota | create under | coupon      | country        | cc number        |
      | DONOT EDIT Reseller gold yearly GBP exception new change plan | 12     | Gold          | 100            | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £216.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 100      | £2.16      | £216.00     |
      | Discounts Applied  |          |            | -£21.60     |
      | Pre-tax Subtotal   |          |            | £194.40     |
      | Taxes              |          |            | £38.88      |
      | Total Charges      |          |            | £233.28     |
    And New partner should be created

  @TC.133633 @add_new_partner @mozypro @bus
  Scenario: Reseller platinum yearly USD new
    When I add a new Reseller partner:
      | company name                                            | period | reseller type | reseller quota | coupon                        | country       |
      | DONOT EDIT Reseller platinum yearly USD change plan exception new | 12     | Platinum      | 100            | 100pctOffInternalTestCustomer | United States |
    Then Sub-total before taxes or discounts should be $288.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 100      | $2.88      | $288.00     |
      | Total Charges          |          |            | $0.00       |
    And New partner should be created

  @TC.133634 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly USD new without inital purchase
    When I add a new Reseller partner:
      | company name                                | period | country        | coupon      |
      | DONOT EDIT Reseller monthly USD exception new without | 1      | United States  | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.133635 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly France new without inital purchase
    When I add a new Reseller partner:
      | company name                                   | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller monthly France exception new without | 1      | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.133636 @add_new_partner @mozypro @bus
  Scenario: Reseller monthly GBP  newwithout inital purchase
    When I add a new Reseller partner:
      | company name                                | period | create under | country        | coupon      |
      | DONOT EDIT Reseller monthly GBP exception new without | 1      | MozyPro UK   | United Kingdom | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.133637 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly USD new without inital purchase
    When I add a new Reseller partner:
      | company name                               | period | country        | coupon      |
      | DONOT EDIT Reseller yearly USD exception new without | 12     | United States  | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.133638 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly France new without inital purchase
    When I add a new Reseller partner:
      | company name                                  | period | create under   | country | cc number        | coupon      |
      | DONOT EDIT Reseller yearly France exception new without | 12     | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created

  @TC.133639 @add_new_partner @mozypro @bus
  Scenario: Reseller yearly GBP new without inital purchase
    When I add a new Reseller partner:
      | company name                               | period | create under | country        | coupon      |
      | DONOT EDIT Reseller yearly GBP exception new without | 12     | MozyPro UK   | United Kingdom | Nonprofit10 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
