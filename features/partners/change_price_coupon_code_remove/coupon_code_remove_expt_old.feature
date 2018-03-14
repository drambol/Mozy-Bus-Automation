#Feature: Requirement #143134 Aria coupon code remove: change period and change plan
#
#  Background:
#    Given I log in bus admin console as administrator
#
#  @TC.143134_21 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan monthly USD
#    When I add a new MozyPro partner:
#      | company name                              | period | base plan | country       |
#      | DONOT EDIT MozyPro 10 GB Plan monthly USD | 1      | 10 GB     | United States |
#    Then Sub-total before taxes or discounts should be $9.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | $9.99      | $9.99       |
#      | Pre-tax Subtotal  |          |            | $9.99       |
#      | Total Charges     |          |            | $9.99       |
#    And New partner should be created
#
#  @TC.143134_22 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan monthly USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                               | period | base plan | country       | coupon      |
#      | DONOT EDIT MozyPro 10 GB Plan monthly USD exception coupon | 1      | 10 GB     | United States | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be $9.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | $9.99      | $9.99       |
#      | Discounts Applied |          |            | -$1.00      |
#      | Pre-tax Subtotal  |          |            | $8.99       |
#      | Total Charges     |          |            | $8.99       |
#    And New partner should be created
#
#  @TC.143134_23 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan yearly Ireland exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                  | period | base plan | server plan | create under    | country | coupon      | cc number        |
#      | DONOT EDIT MozyPro 10 GB Plan yearly Ireland exception coupon | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€12.08     |
#      | Pre-tax Subtotal  |          |            | €108.70     |
#      | Taxes             |          |            | €25.00      |
#      | Total Charges     |          |            | €133.70     |
#    And New partner should be created
#
#  @TC.143134_24 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan yearly GBP exception coupon
#    When I add a new MozyPro partner:
#      | company name                                              | period | base plan | create under | country        | coupon                        | cc number        |
#      | DONOT EDIT MozyPro 10 GB Plan yearly GBP exception coupon | 24     | 10 GB     | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £146.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | £146.79    | £146.79     |
#      | Total Charges     |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_25 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 250 GB Plan monthly GBP exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                | period | base plan | server plan | storage add on 50 gb | create under | country        | coupon      | cc number        |
#      | DONOT EDIT MozyPro 250 GB Plan monthly GBP exception coupon | 1      | 250 GB    | yes         | 1                    | MozyPro UK   | United Kingdom | Nonprofit10 | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £88.97
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £63.99     | £63.99      |
#      | Server Plan       | 1        | £10.99     | £10.99      |
#      | 50GB Add-on       | 1        | £13.99     | £13.99      |
#      | Discounts Applied |          |            | -£8.90      |
#      | Pre-tax Subtotal  |          |            | £80.07      |
#      | Taxes             |          |            | £16.02      |
#      | Total Charges     |          |            | £96.09      |
#    And New partner should be created
#
#  @TC.143134_26 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan yearly USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                               | period | base plan | country       | coupon      |
#      | DONOT EDIT MozyPro 250 GB Plan yearly USD exception coupon | 12     | 250 GB    | United States | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be $1,044.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
#      | Discounts Applied |          |            | -$104.49    |
#      | Pre-tax Subtotal  |          |            | $940.40     |
#      | Total Charges     |          |            | $940.40     |
#    And New partner should be created
#
#  @TC.143134_27 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan Biennially EUR Germany exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                           | period | base plan | server plan | create under    | country | cc number        | coupon                        |
#      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception coupon | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
#    Then Sub-total before taxes or discounts should be €1,847.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Server Plan       | 1        | €272.79    | €272.79     |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_28 @add_new_partner @mozypro
#  Scenario: MozyPro 500 GB Plan monthly GBP VAT exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                    | period | base plan | create under   | country | vat number    | coupon      | cc number        |
#      | DONOT EDIT MozyPro 500 GB Plan monthly GBP VAT exception Coupon | 1      | 500 GB    | MozyPro France | France  | FR08410091490 | Nonprofit10 | 4485393141463880 |
#    Then Sub-total before taxes or discounts should be €149.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | €149.99    |  €149.99    |
#      | Discounts Applied |          |            | -€15.00     |
#      | Pre-tax Subtotal  |          |            | €134.99     |
#      | Total Charges     |          |            | €134.99     |
#    And New partner should be created
#
#  @TC.143134_29 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan yearly GBP VAT exception coupon NOT execute successfully
#    When I add a new MozyPro partner:
#      | company name                                                   | period | base plan | server plan | create under | country        | vat number  | coupon      | cc number        |
#      | DONOT EDIT MozyPro 500 GB Plan yearly GBP VAT exception Coupon | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | Nonprofit10 | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £1,528.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | £1,374.89  | £1,374.89   |
#      | Server Plan       | 1        | £153.89    | £153.89     |
#      | Discounts Applied |          |            | -£152.88    |
#      | Pre-tax Subtotal  |          |            | £1,375.90   |
#      | Total Charges     |          |            | £1,375.90   |
#    And New partner should be created
#
#  @TC.143134_210 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan Biennially USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                   | period | base plan | country       | coupon                        |
#      | DONOT EDIT MozyPro 500 GB Plan Biennially USD exception coupon | 24     | 500 GB    | United States | 100pctOffInternalTestCustomer |
#    Then Sub-total before taxes or discounts should be $3,989.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | $3,989.79  | $3,989.79   |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_211 @add_new_partner @mozypro
#  Scenario: MozyPro 1 TB Plan monthly USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                              | period | base plan | server plan | storage add on | country       | coupon      |
#      | DONOT EDIT MozyPro 1 TB Plan monthly USD exception coupon | 1      | 1 TB      | yes         | 2              | United States | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be $599.96
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 1 TB              | 1        | $379.99    | $379.99     |
#      | Server Plan       | 1        | $29.99     | $29.99      |
#      | 250 GB Add-on     | 2        | $94.99     | $189.98     |
#      | Discounts Applied |          |            | -$60.00     |
#      | Pre-tax Subtotal  |          |            | $539.96     |
#      | Total Charges     |          |            | $539.96     |
#    And New partner should be created
#
#  @TC.143134_212 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 1 TB Plan yearly Ireland exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                 | period | base plan | create under     | country | coupon      | vat number | cc number        |
#      | DONOT EDIT MozyPro 1 TB Plan yearly Ireland exception coupon | 12     | 1 TB      | MozyPro Ireland  | Ireland | Nonprofit10 | IE9691104A | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €3,299.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 1 TB              | 1        | €3,299.89  | €3,299.89   |
#      | Discounts Applied |          |            | -€329.99    |
#      | Pre-tax Subtotal  |          |            | €2,969.90   |
#      | Taxes             |          |            | €683.08     |
#      | Total Charges     |          |            | €3,652.98   |
#    And New partner should be created
#
#  @TC.143134_213 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 1 TB Plan Biennially GBP exception coupon
#    When I add a new MozyPro partner:
#      | company name                                            | period | base plan | server plan | create under | country        | coupon                        | cc number        |
#      | DONOT EDIT MozyPro 1 TB Biennially GBP exception Coupon | 24     | 1 TB      | yes         | MozyPro UK   | United Kingdom | 100pctOffInternalTestCustomer | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £5,564.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 1 TB              | 1        | £5,144.79  | £5,144.79   |
#      | Server Plan       | 1        | £419.79    | £419.79     |
#      | Total Charges     |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_214 @add_new_partner @mozypro
#  Scenario: MozyPro 2 TB Plan monthly GBP exception coupon
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | create under | country        | coupon       | cc number        |
#      | DONOT EDIT MozyPro 2 TB monthly GBP exception Coupon | 1      | 2 TB      | MozyPro UK   | United Kingdom | Nonprofit10  | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £474.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 2 TB              | 1        | £474.99    | £474.99     |
#      | Discounts Applied |          |            | -£47.50     |
#      | Pre-tax Subtotal  |          |            | £427.49     |
#      | Taxes             |          |            | £85.50      |
#      | Total Charges     |          |            | £512.99     |
#    And New partner should be created
#
#  @TC.143134_215 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 2 TB Plan yearly USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                        | period | base plan | server plan | country       | coupon      |
#      | DONOT EDIT MozyPro 2 TB yearly USD exception coupon | 12     | 2 TB      | yes         | United States | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be $8,689.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 2 TB              | 1        | $8,249.89  | $8,249.89   |
#      | Server Plan       | 1        | $439.89    | $439.89     |
#      | Discounts Applied |          |            | -$868.98    |
#      | Pre-tax Subtotal  |          |            | $7,820.80   |
#      | Total Charges     |          |            | $7,820.80   |
#    And New partner should be created
#
#  @TC.143134_216 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 2 TB Plan Biennially EUR Germany exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                    | period | base plan | create under    | country | cc number        | coupon                        |
#      | DONOT EDIT MozyPro 2 TB Biennially EUR Germany exception coupon | 24     | 2 TB      | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
#    Then Sub-total before taxes or discounts should be €12,179.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 2 TB              | 1        | €12,179.79 | €12,179.79  |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_217 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 4 TB Plan monthly EUR France exception coupon
#    When I add a new MozyPro partner:
#      | company name                                                   | period | base plan | server plan | create under   | country | cc number        | coupon      |
#      | DONOT EDIT MozyPro 4 TB Biennially EUR France exception coupon | 1      | 4 TB      | yes         | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be €1,149.98
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 4 TB              | 1        | €1,109.99  | €1,109.99   |
#      | Server Plan       | 1        | €39.99     | €39.99      |
#      | Discounts Applied |          |            | -€115.00    |
#      | Pre-tax Subtotal  |          |            | €1,034.98   |
#      | Taxes             |          |            | €207.00     |
#      | Total Charges     |          |            | €1,241.98   |
#    And New partner should be created
#
#  @TC.143134_218 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 4 TB Plan yearly GBP exception coupon
#    When I add a new MozyPro partner:
#      | company name                                        | period | base plan | create under | country        | coupon       | cc number        |
#      | DONOT EDIT MozyPro 4 TB yearly GBP exception Coupon | 12     | 4 TB      | MozyPro UK   | United Kingdom | Nonprofit10  | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £10,020.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 4 TB              | 1        | £10,020.89 | £10,020.89  |
#      | Discounts Applied |          |            | -£1,002.09  |
#      | Pre-tax Subtotal  |          |            | £9,018.80   |
#      | Taxes             |          |            | £1,803.76   |
#      | Total Charges     |          |            | £10,822.56  |
#    And New partner should be created
#
#  @TC.143134_219 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 4 TB Plan Biennially USD exception coupon
#    When I add a new MozyPro partner:
#      | company name                                            | period | base plan | server plan | country       | coupon                        |
#      | DONOT EDIT MozyPro 4 TB Biennially USD exception coupon | 24     | 4 TB      | yes         | United States | 100pctOffInternalTestCustomer |
#    Then Sub-total before taxes or discounts should be $31,289.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 4 TB              | 1        | $30,239.79 | $30,239.79  |
#      | Server Plan       | 1        | $1,049.79  | $1,049.79   |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_220 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB yearly Ireland exception coupon change plan
#    When I add a new MozyPro partner:
#      | company name                                                         | period | base plan | create under    | country | coupon      | cc number        |
#      | DONOT EDIT MozyPro 10 GB yearly Ireland exception coupon change plan | 12     | 10 GB     | MozyPro Ireland | Ireland | Nonprofit10 | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €87.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Discounts Applied |          |            | -€8.79      |
#      | Pre-tax Subtotal  |          |            | €79.10      |
#      | Taxes             |          |            | €18.19      |
#      | Total Charges     |          |            | €97.29      |
#    And New partner should be created
#
#  @TC.143134_221 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan Biennially EUR Germany exception coupon change plan
#    When I add a new MozyPro partner:
#      | company name                                                                       | period | base plan | create under    | country | cc number        | coupon                        |
#      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany exception coupon change plan | 24     | 250 GB    | MozyPro Germany | Germany | 4188181111111112 | 100pctOffInternalTestCustomer |
#    Then Sub-total before taxes or discounts should be €1,574.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_222 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver monthly France exception coupon
#    When I add a new Reseller partner:
#      | company name                                               | period | reseller type | reseller quota | create under   | country | cc number        | coupon      |
#      | DONOT EDIT Reseller silver monthly France exception coupon | 1      | Silver        | 100            | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be €33.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 100      | €0.33      | €33.00      |
#      | Discounts Applied    |          |            | -€3.30      |
#      | Pre-tax Subtotal     |          |            | €29.70      |
#      | Taxes                |          |            | €5.94       |
#      | Total Charges        |          |            | €35.64      |
#    And New partner should be created
#
#  @TC.143134_223 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver yearly EUR Ireland exception coupon
#    When I add a new Reseller partner:
#      | company name                                                   | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon      | country | cc number        |
#      | DONOT EDIT Reseller silver yearly EUR Ireland exception coupon | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €2,761.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €3.63      | €1,815.00   |
#      | Server Plan          | 1        | €220.00    | €220.00     |
#      | 20 GB add-on         | 10       | €72.60     | €726.00     |
#      | Discounts Applied    |          |            | -€276.10    |
#      | Pre-tax Subtotal     |          |            | €2,484.90   |
#      | Taxes                |          |            | €571.53     |
#      | Total Charges        |          |            | €3,056.43   |
#    And New partner should be created
#
#  @TC.143134_224 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold monthly GBP exception coupon execute manually as wrong sequence of gold and platinum
#    When I add a new Reseller partner:
#      | company name                                          | period | reseller type | reseller quota | create under | vat number  | coupon                        | country        | cc number        |
#      | DONOT EDIT Reseller gold monthly GBP exception coupon | 1      | Gold          | 500            | MozyPro UK   | GB117223643 | 100pctOffInternalTestCustomer | United Kingdom | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £115.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 500      | £0.23      | £115.00     |
#      | Total Charges      |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_225 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold yearly GBP exception coupon
#    When I add a new Reseller partner:
#      | company name                                         | period | reseller type | reseller quota | server plan | storage add on | create under | coupon      | country        | cc number        |
#      | DONOT EDIT Reseller gold yearly GBP exception coupon | 12     | Gold          | 100            | yes         | 10             | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £1,474.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 100      | £2.53      | £253.00     |
#      | Server Plan        | 1        | £715.00    | £715.00     |
#      | 20 GB add-on       | 10       | £50.60     | £506.00     |
#      | Discounts Applied  |          |            | -£147.40    |
#      | Pre-tax Subtotal   |          |            | £1,326.60   |
#      | Taxes              |          |            | £265.32     |
#      | Total Charges      |          |            | £1,591.92   |
#    And New partner should be created
#
#  @TC.143134_226 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum monthly USD exception coupon execute manually as wrong sequence of gold and platinum
#    When I add a new Reseller partner:
#      | company name                                              | period | reseller type | reseller quota | coupon      | country       |
#      | DONOT EDIT Reseller platinum monthly USD exception coupon | 1      | Platinum      | 100            | Nonprofit10 | United States |
#    Then Sub-total before taxes or discounts should be $30.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $0.30      | $30.00      |
#      | Discounts Applied      |          |            | -$3.00      |
#      | Pre-tax Subtotal       |          |            | $27.00      |
#      | Total Charges          |          |            | $27.00      |
#    And New partner should be created
#
#  @TC.143134_227 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum yearly USD exception coupon
#    When I add a new Reseller partner:
#      | company name                                             | period | reseller type | reseller quota | server plan | storage add on | coupon                        | country       |
#      | DONOT EDIT Reseller platinum yearly USD exception coupon | 12     | Platinum      | 100            | yes         | 10             | 100pctOffInternalTestCustomer | United States |
#    Then Sub-total before taxes or discounts should be $2,915.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
#      | Server Plan            | 1        | $1,925.00  | $1,925.00   |
#      | 20 GB add-on           | 10       | $66.00     | $660.00     |
#      | Total Charges          |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_228 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver yearly EUR Ireland exception coupon
#    When I add a new Reseller partner:
#      | company name                                                               | period | reseller type | reseller quota | create under    | vat number | coupon      | country | cc number        |
#      | DONOT EDIT Reseller silver yearly EUR Ireland change plan exception coupon | 12     | Silver        | 500            | MozyPro Ireland | IE9691104A | Nonprofit10 | Ireland | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €1,815.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €3.63      | €1,815.00   |
#      | Discounts Applied    |          |            | -€181.50    |
#      | Pre-tax Subtotal     |          |            | €1,633.50   |
#      | Taxes                |          |            | €375.71     |
#      | Total Charges        |          |            | €2,009.21   |
#    And New partner should be created
#
#  @TC.143134_229 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold yearly GBP exception coupon
#    When I add a new Reseller partner:
#      | company name                                                     | period | reseller type | reseller quota | create under | coupon      | country        | cc number        |
#      | DONOT EDIT Reseller gold yearly GBP exception coupon change plan | 12     | Gold          | 100            | MozyPro UK   | Nonprofit10 | United Kingdom | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £253.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 100      | £2.53      | £253.00     |
#      | Discounts Applied  |          |            | -£25.30     |
#      | Pre-tax Subtotal   |          |            | £227.70     |
#      | Taxes              |          |            | £45.54      |
#      | Total Charges      |          |            | £273.24     |
#    And New partner should be created
#
#  @TC.143134_230 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum yearly USD exception coupon
#    When I add a new Reseller partner:
#      | company name                                                         | period | reseller type | reseller quota | coupon                        | country       |
#      | DONOT EDIT Reseller platinum yearly USD change plan exception coupon | 12     | Platinum      | 100            | 100pctOffInternalTestCustomer | United States |
#    Then Sub-total before taxes or discounts should be $330.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
#      | Total Charges          |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_231 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly USD exception coupon without inital purchase
#    When I add a new Reseller partner:
#      | company name                                             | period | country        | coupon      |
#      | DONOT EDIT Reseller monthly USD exception coupon without | 1      | United States  | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_232 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly France exception coupon without inital purchase
#    When I add a new Reseller partner:
#      | company name                                                | period | create under   | country | cc number        | coupon      |
#      | DONOT EDIT Reseller monthly France exception coupon without | 1      | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_233 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly GBP  exception couponwithout inital purchase
#    When I add a new Reseller partner:
#      | company name                                             | period | create under | country        | coupon      |
#      | DONOT EDIT Reseller monthly GBP exception coupon without | 1      | MozyPro UK   | United Kingdom | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_234 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly USD exception coupon without inital purchase
#    When I add a new Reseller partner:
#      | company name                                            | period | country        | coupon      |
#      | DONOT EDIT Reseller yearly USD exception coupon without | 12     | United States  | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_235 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly France exception coupon without inital purchase
#    When I add a new Reseller partner:
#      | company name                                               | period | create under   | country | cc number        | coupon      |
#      | DONOT EDIT Reseller yearly France exception coupon without | 12     | MozyPro France | France  | 4485393141463880 | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_236 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly GBP exception coupon without inital purchase
#    When I add a new Reseller partner:
#      | company name                                            | period | create under | country        | coupon      |
#      | DONOT EDIT Reseller yearly GBP exception coupon without | 12     | MozyPro UK   | United Kingdom | Nonprofit10 |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#
#
