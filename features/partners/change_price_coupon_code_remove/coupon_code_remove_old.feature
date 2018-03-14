#Feature: Requirement #143134 Aria coupon code remove: change period and change plan
#
#  Background:
#    Given I log in bus admin console as administrator
#
#  @TC.143134_01 @add_new_partner @mozypro @bus
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
#  @TC.143134_02 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan monthly USD coupon
#    When I add a new MozyPro partner:
#      | company name                                     | period | base plan | country       | coupon              |
#      | DONOT EDIT MozyPro 10 GB Plan monthly USD coupon | 1      | 10 GB     | United States | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $9.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | $9.99      | $9.99       |
#      | Discounts Applied |          |            | -$1.00      |
#      | Pre-tax Subtotal  |          |            | $8.99       |
#      | Total Charges     |          |            | $8.99       |
#    And New partner should be created
#
#  @TC.143134_03 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan yearly Ireland coupon
#    When I add a new MozyPro partner:
#      | company name                                        | period | base plan | server plan | create under    | country | coupon              | cc number        |
#      | DONOT EDIT MozyPro 10 GB Plan yearly Ireland coupon | 12     | 10 GB     | yes         | MozyPro Ireland | Ireland | 20PERCENTOFFOUTLINE | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €120.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Server Plan       | 1        | €32.89     | €32.89      |
#      | Discounts Applied |          |            | -€24.16     |
#      | Pre-tax Subtotal  |          |            | €96.62      |
#      | Taxes             |          |            | €22.22      |
#      | Total Charges     |          |            | €118.84     |
#    And New partner should be created
#
#  @TC.143134_04 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB Plan yearly GBP coupon
#    When I add a new MozyPro partner:
#      | company name                                    | period | base plan | create under | country        | coupon               | cc number        |
#      | DONOT EDIT MozyPro 10 GB Plan yearly GBP coupon | 24     | 10 GB     | MozyPro UK   | United Kingdom | 100PERCENTOFFOUTLINE | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £146.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | £146.79    | £146.79     |
#      | Discounts Applied |          |            | -£146.79    |
#      | Total Charges     |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_05 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 250 GB Plan monthly GBP coupon
#    When I add a new MozyPro partner:
#      | company name                                      | period | base plan | server plan | storage add on 50 gb | create under | country        | coupon              | cc number        |
#      | DONOT EDIT MozyPro 250 GB Plan monthly GBP coupon | 1      | 250 GB    | yes         | 1                    | MozyPro UK   | United Kingdom | 10PERCENTOFFOUTLINE | 4916783606275713 |
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
#  @TC.143134_06 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan yearly USD coupon
#    When I add a new MozyPro partner:
#      | company name                              | period | base plan | country       | coupon              |
#      | DONOT EDIT MozyPro 250 GB Plan yearly USD | 12     | 250 GB    | United States | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $1,044.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
#      | Discounts Applied |          |            | -$208.98    |
#      | Pre-tax Subtotal  |          |            | $835.91     |
#      | Total Charges     |          |            | $835.91     |
#    And New partner should be created
#
#  @TC.143134_07 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan Biennially EUR Germany
#    When I add a new MozyPro partner:
#      | company name                                          | period | base plan | server plan | create under    | country | cc number        | coupon               |
#      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany | 24     | 250 GB    | yes         | MozyPro Germany | Germany | 4188181111111112 | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €1,847.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Server Plan       | 1        | €272.79    | €272.79     |
#      | Discounts Applied |          |            | -€1,847.58  |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_08 @add_new_partner @mozypro
#  Scenario: MozyPro 500 GB Plan monthly GBP VAT coupon
#    When I add a new MozyPro partner:
#      | company name                                          | period | base plan | create under   | country | vat number    | coupon              | cc number        |
#      | DONOT EDIT MozyPro 500 GB Plan monthly GBP VAT Coupon | 1      | 500 GB    | MozyPro France | France  | FR08410091490 | 10PERCENTOFFOUTLINE | 4485393141463880 |
#    Then Sub-total before taxes or discounts should be €149.99
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | €149.99    |  €149.99    |
#      | Discounts Applied |          |            | -€15.00     |
#      | Pre-tax Subtotal  |          |            | €134.99     |
#      | Total Charges     |          |            | €134.99     |
#    And New partner should be created
#
#  @TC.143134_09 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan yearly GBP VAT coupon NOT execute successfully
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | server plan | create under | country        | vat number  | coupon              | cc number        |
#      | DONOT EDIT MozyPro 500 GB Plan yearly GBP VAT Coupon | 12     | 500 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | 20PERCENTOFFOUTLINE | 4916783606275713 |
##    Then Sub-total before taxes or discounts should be £1,528.78
##    And Order summary table should be:
##      | Description       | Quantity | Price Each | Total Price |
##      | 500 GB            | 1        | £1,374.89  | £1,374.89   |
##      | Server Plan       | 1        | £153.89    | £153.89     |
##      | Discounts Applied |          |            | -£305.76    |
##      | Pre-tax Subtotal  |          |            | £1,223.02   |
##      | Total Charges     |          |            | £1,223.02   |
#    And New partner should be created
#
#  @TC.143134_010 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan Biennially USD coupon
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | country       | coupon               |
#      | DONOT EDIT MozyPro 500 GB Plan Biennially USD coupon | 24     | 500 GB    | United States | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $3,989.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | $3,989.79  | $3,989.79   |
#      | Discounts Applied |          |            | -$3,989.79  |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_011 @add_new_partner @mozypro
#  Scenario: MozyPro 1 TB Plan monthly USD coupon
#    When I add a new MozyPro partner:
#      | company name                                    | period | base plan | server plan | storage add on | country       | coupon              |
#      | DONOT EDIT MozyPro 1 TB Plan monthly USD coupon | 1      | 1 TB      | yes         | 2              | United States | 10PERCENTOFFOUTLINE |
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
#  @TC.143134_012 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 1 TB Plan yearly Ireland coupon
#    When I add a new MozyPro partner:
#      | company name                                       | period | base plan | create under     | country | coupon              | vat number | cc number        |
#      | DONOT EDIT MozyPro 1 TB Plan yearly Ireland coupon | 12     | 1 TB      | MozyPro Ireland  | Ireland | 20PERCENTOFFOUTLINE | IE9691104A | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €3,299.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 1 TB              | 1        | €3,299.89  | €3,299.89   |
#      | Discounts Applied |          |            | -€659.98    |
#      | Pre-tax Subtotal  |          |            | €2,639.91   |
#      | Taxes             |          |            | €607.18     |
#      | Total Charges     |          |            | €3,247.09   |
#    And New partner should be created
#
#  @TC.143134_013 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 1 TB Plan Biennially GBP coupon
#    When I add a new MozyPro partner:
#      | company name                                  | period | base plan | server plan | create under | country        | coupon               | cc number        |
#      | DONOT EDIT MozyPro 1 TB Biennially GBP Coupon | 24     | 1 TB      | yes         | MozyPro UK   | United Kingdom | 100PERCENTOFFOUTLINE | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £5,564.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 1 TB              | 1        | £5,144.79  | £5,144.79   |
#      | Server Plan       | 1        | £419.79    | £419.79     |
#      | Discounts Applied |          |            | -£5,564.58  |
#      | Total Charges     |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_014 @add_new_partner @mozypro
#  Scenario: MozyPro 2 TB Plan monthly GBP coupon
#    When I add a new MozyPro partner:
#      | company name                               | period | base plan | create under | country        | coupon               | cc number        |
#      | DONOT EDIT MozyPro 2 TB monthly GBP Coupon | 1      | 2 TB      | MozyPro UK   | United Kingdom | 10PERCENTOFFOUTLINE  | 4916783606275713 |
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
#  @TC.143134_015 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 2 TB Plan yearly USD coupon
#    When I add a new MozyPro partner:
#      | company name                              | period | base plan | server plan | country       | coupon              |
#      | DONOT EDIT MozyPro 2 TB yearly USD coupon | 12     | 2 TB      | yes         | United States | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $8,689.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 2 TB              | 1        | $8,249.89  | $8,249.89   |
#      | Server Plan       | 1        | $439.89    | $439.89     |
#      | Discounts Applied |          |            | -$1,737.96  |
#      | Pre-tax Subtotal  |          |            | $6,951.82   |
#      | Total Charges     |          |            | $6,951.82   |
#    And New partner should be created
#
#  @TC.143134_016 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 2 TB Plan Biennially EUR Germany
#    When I add a new MozyPro partner:
#      | company name                                          | period | base plan | create under    | country | cc number        | coupon               |
#      | DONOT EDIT MozyPro 2 TB Biennially EUR Germany coupon | 24     | 2 TB      | MozyPro Germany | Germany | 4188181111111112 | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €12,179.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 2 TB              | 1        | €12,179.79 | €12,179.79  |
#      | Discounts Applied |          |            | -€12,179.79 |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_017 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 4 TB Plan monthly EUR France
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | server plan | create under   | country | cc number        | coupon              |
#      | DONOT EDIT MozyPro 4 TB Biennially EUR France coupon | 1      | 4 TB      | yes         | MozyPro France | France  | 4485393141463880 | 10PERCENTOFFOUTLINE |
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
#  @TC.143134_018 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 4 TB Plan yearly GBP coupon
#    When I add a new MozyPro partner:
#      | company name                              | period | base plan | create under | country        | coupon               | cc number        |
#      | DONOT EDIT MozyPro 4 TB yearly GBP Coupon | 12     | 4 TB      | MozyPro UK   | United Kingdom | 20PERCENTOFFOUTLINE  | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £10,020.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 4 TB              | 1        | £10,020.89 | £10,020.89  |
#      | Discounts Applied |          |            | -£2,004.18  |
#      | Pre-tax Subtotal  |          |            | £8,016.71   |
#      | Taxes             |          |            | £1,603.34   |
#      | Total Charges     |          |            | £9,620.05   |
#    And New partner should be created
#
#  @TC.143134_019 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 4 TB Plan Biennially USD coupon
#    When I add a new MozyPro partner:
#      | company name                                  | period | base plan | server plan | country       | coupon               |
#      | DONOT EDIT MozyPro 4 TB Biennially USD coupon | 24     | 4 TB      | yes         | United States | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $31,289.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 4 TB              | 1        | $30,239.79 | $30,239.79  |
#      | Server Plan       | 1        | $1,049.79  | $1,049.79   |
#      | Discounts Applied |          |            | -$31,289.58 |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_020 @add_new_partner @mozypro @bus
#  Scenario: MozyPro 10 GB yearly Ireland coupon change plan
#    When I add a new MozyPro partner:
#      | company name                                               | period | base plan | create under    | country | coupon              | cc number        |
#      | DONOT EDIT MozyPro 10 GB yearly Ireland coupon change plan | 12     | 10 GB     | MozyPro Ireland | Ireland | 20PERCENTOFFOUTLINE | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €87.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 10 GB             | 1        | €87.89     | €87.89      |
#      | Discounts Applied |          |            | -€17.58     |
#      | Pre-tax Subtotal  |          |            | €70.31      |
#      | Taxes             |          |            | €16.17      |
#      | Total Charges     |          |            | €86.48      |
#    And New partner should be created
#
#  @TC.143134_021 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan Biennially EUR Germany change plan
#    When I add a new MozyPro partner:
#      | company name                                                      | period | base plan | create under    | country | cc number        | coupon               |
#      | DONOT EDIT MozyPro 250 GB Plan Biennially EUR Germany change plan | 24     | 250 GB    | MozyPro Germany | Germany | 4188181111111112 | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €1,574.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Discounts Applied |          |            | -€1,574.79  |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.143134_022 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver monthly France
#    When I add a new Reseller partner:
#      | company name                              | period | reseller type | reseller quota | create under   | country | cc number        | coupon              |
#      | DONOT EDIT Reseller silver monthly France | 1      | Silver        | 100            | MozyPro France | France  | 4485393141463880 | 10PERCENTOFFOUTLINE |
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
#  @TC.143134_023 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver yearly EUR Ireland
#    When I add a new Reseller partner:
#      | company name                                  | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon              | country | cc number        |
#      | DONOT EDIT Reseller silver yearly EUR Ireland | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | 20PERCENTOFFOUTLINE | Ireland | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €2,761.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €3.63      | €1,815.00   |
#      | Server Plan          | 1        | €220.00    | €220.00     |
#      | 20 GB add-on         | 10       | €72.60     | €726.00     |
#      | Discounts Applied    |          |            | -€552.20    |
#      | Pre-tax Subtotal     |          |            | €2,208.80   |
#      | Taxes                |          |            | €508.02     |
#      | Total Charges        |          |            | €2,716.82   |
#    And New partner should be created
#
#  @TC.143134_024 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold monthly GBP execute manually as wrong sequence of gold and platinum
#    When I add a new Reseller partner:
#      | company name                         | period | reseller type | reseller quota | create under | vat number  | coupon               | country        | cc number        |
#      | DONOT EDIT Reseller gold monthly GBP | 1      | Gold          | 500            | MozyPro UK   | GB117223643 | 100PERCENTOFFOUTLINE | United Kingdom | 4916783606275713 |
#    Then Sub-total before taxes or discounts should be £115.00
#    And Order summary table should be:
#      | Description        | Quantity | Price Each | Total Price |
#      | GB - Gold Reseller | 500      | £0.23      | £115.00     |
#      | Discounts Applied  |          |            | -£115.00    |
#      | Total Charges      |          |            | £0.00       |
#    And New partner should be created
#
#  @TC.143134_025 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold yearly GBP
#    When I add a new Reseller partner:
#      | company name                        | period | reseller type | reseller quota | server plan | storage add on | create under | coupon              | country        | cc number        |
#      | DONOT EDIT Reseller gold yearly GBP | 12     | Gold          | 100            | yes         | 10             | MozyPro UK   | 10PERCENTOFFOUTLINE | United Kingdom | 4916783606275713 |
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
#  @TC.143134_026 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum monthly USD execute manually as wrong sequence of gold and platinum
#    When I add a new Reseller partner:
#      | company name                             | period | reseller type | reseller quota | coupon              | country       |
#      | DONOT EDIT Reseller platinum monthly USD | 1      | Platinum      | 100            | 20PERCENTOFFOUTLINE | United States |
#    Then Sub-total before taxes or discounts should be $30.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $0.30      | $30.00      |
#      | Discounts Applied      |          |            | -$6.00      |
#      | Pre-tax Subtotal       |          |            | $24.00      |
#      | Total Charges          |          |            | $24.00      |
#    And New partner should be created
#
#  @TC.143134_027 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum yearly USD
#    When I add a new Reseller partner:
#      | company name                            | period | reseller type | reseller quota | server plan | storage add on | coupon               | country       |
#      | DONOT EDIT Reseller platinum yearly USD | 12     | Platinum      | 100            | yes         | 10             | 100PERCENTOFFOUTLINE | United States |
#    Then Sub-total before taxes or discounts should be $2,915.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
#      | Server Plan            | 1        | $1,925.00  | $1,925.00   |
#      | 20 GB add-on           | 10       | $66.00     | $660.00     |
#      | Discounts Applied      |          |            | -$2,915.00  |
#      | Total Charges          |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_028 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller silver yearly EUR Ireland
#    When I add a new Reseller partner:
#      | company name                                              | period | reseller type | reseller quota | create under    | vat number | coupon              | country | cc number        |
#      | DONOT EDIT Reseller silver yearly EUR Ireland change plan | 12     | Silver        | 500            | MozyPro Ireland | IE9691104A | 20PERCENTOFFOUTLINE | Ireland | 4319402211111113 |
#    Then Sub-total before taxes or discounts should be €1,815.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €3.63      | €1,815.00   |
#      | Discounts Applied    |          |            | -€363.00    |
#      | Pre-tax Subtotal     |          |            | €1,452.00   |
#      | Taxes                |          |            | €333.96     |
#      | Total Charges        |          |            | €1,785.96   |
#    And New partner should be created
#
#  @TC.143134_029 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller gold yearly GBP
#    When I add a new Reseller partner:
#      | company name                                    | period | reseller type | reseller quota | create under | coupon              | country        | cc number        |
#      | DONOT EDIT Reseller gold yearly GBP changa plan | 12     | Gold          | 100            | MozyPro UK   | 10PERCENTOFFOUTLINE | United Kingdom | 4916783606275713 |
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
#  @TC.143134_030 @add_new_partner @mozypro @bus @price_changed
#  Scenario: Reseller platinum yearly USD
#    When I add a new Reseller partner:
#      | company name                                        | period | reseller type | reseller quota | coupon               | country       |
#      | DONOT EDIT Reseller platinum yearly USD change plan | 12     | Platinum      | 100            | 100PERCENTOFFOUTLINE | United States |
#    Then Sub-total before taxes or discounts should be $330.00
#    And Order summary table should be:
#      | Description            | Quantity | Price Each | Total Price |
#      | GB - Platinum Reseller | 100      | $3.30      | $330.00     |
#      | Discounts Applied      |          |            | -$330.00    |
#      | Total Charges          |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.143134_031 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly USD without inital purchase
#    When I add a new Reseller partner:
#      | company name                            | period | country        | coupon              |
#      | DONOT EDIT Reseller monthly USD without | 1      | United States  | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_032 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly France without inital purchase
#    When I add a new Reseller partner:
#      | company name                               | period | create under   | country | cc number        | coupon              |
#      | DONOT EDIT Reseller monthly France without | 1      | MozyPro France | France  | 4485393141463880 | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_033 @add_new_partner @mozypro @bus
#  Scenario: Reseller monthly GBP without inital purchase
#    When I add a new Reseller partner:
#      | company name                            | period | create under | country        | coupon              |
#      | DONOT EDIT Reseller monthly GBP without | 1      | MozyPro UK   | United Kingdom | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_034 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly USD without inital purchase
#    When I add a new Reseller partner:
#      | company name                           | period | country        | coupon              |
#      | DONOT EDIT Reseller yearly USD without | 12     | United States  | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_035 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly France without inital purchase
#    When I add a new Reseller partner:
#      | company name                              | period | create under   | country | cc number        | coupon              |
#      | DONOT EDIT Reseller yearly France without | 12     | MozyPro France | France  | 4485393141463880 | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#  @TC.143134_036 @add_new_partner @mozypro @bus
#  Scenario: Reseller yearly GBP without inital purchase
#    When I add a new Reseller partner:
#      | company name                           | period | create under | country        | coupon              |
#      | DONOT EDIT Reseller yearly GBP without | 12     | MozyPro UK   | United Kingdom | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be 0
#    And New partner should be created
#
#
#
