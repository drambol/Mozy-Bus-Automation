#Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS
#
#  Background:
#    Given I log in bus admin console as administrator
#
#  @TC.141405_coupon_1 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Annual) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                       | period | base plan | country       | net terms | coupon              |
#      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD coupon | 12     | 250 GB    | United States | yes       | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $1,044.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
#      | Discounts Applied |          |            | -$104.49    |
#      | Pre-tax Subtotal  |          |            | $940.40     |
#      | Total Charges     |          |            | $940.40     |
#    And New partner should be created
#
#  @TC.141405_coupon_2 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                                             | period | base plan | server plan | country       | net terms | coupon              |
#      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon | 12     | 250 GB    | yes         | United States | yes       | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $1,220.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
#      | Server Plan       | 1        | $175.89    | $175.89     |
#      | Discounts Applied |          |            | -$244.16    |
#      | Pre-tax Subtotal  |          |            | $976.62     |
#      | Total Charges     |          |            | $976.62     |
#    And New partner should be created
#
#  @TC.141405_coupon_3 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100
#    When I add a new MozyPro partner:
#      | company name                                                                 | period | base plan | server plan | country       | net terms | coupon               |
#      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100 | 12     | 250 GB    | yes         | United States | yes       | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $1,220.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,044.89  | $1,044.89   |
#      | Server Plan       | 1        | $175.89    | $175.89     |
#      | Discounts Applied |          |            | -$1,220.78  |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.141405_coupon_4 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Annual) EUR France coupon
#    When I add a new MozyPro partner:
#      | company name                                              | period | base plan | create under   | country | net terms | coupon               |
#      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France coupon | 12     | 250 GB    | MozyPro France | France  | yes       | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €824.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €824.89    | €824.89     |
#      | Discounts Applied |          |            | -€824.89    |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.141405_coupon_5 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon
#    When I add a new MozyPro partner:
#      | company name                                                                     | period | base plan | server plan | create under    | country | net terms | coupon              |
#      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €967.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €824.89    | €824.89     |
#      | Server Plan       | 1        | €142.89    | €142.89     |
#      | Discounts Applied |          |            | -€96.78     |
#      | Pre-tax Subtotal  |          |            | €871.00     |
#      | Taxes             |          |            | €165.49     |
#      | Total Charges     |          |            | €1,036.49   |
#    And New partner should be created
#
#  @TC.141405_coupon_6 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT
#    When I add a new MozyPro partner:
#      | company name                                                                         | period | base plan | server plan | create under    | country | net terms | coupon              | vat number |
#      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT | 12     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       | 20PERCENTOFFOUTLINE | IE9691104A |
#    Then Sub-total before taxes or discounts should be €967.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €824.89    | €824.89     |
#      | Server Plan       | 1        | €142.89    | €142.89     |
#      | Discounts Applied |          |            | -€193.56    |
#      | Pre-tax Subtotal  |          |            | €774.22     |
#      | Taxes             |          |            | €178.07     |
#      | Total Charges     |          |            | €952.29     |
#    And New partner should be created
#
#  @TC.141405_coupon_7 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Annual) EUR Germany VAT
#    When I add a new MozyPro partner:
#      | company name                                            | period | base plan | create under    | country | net terms | vat number  |
#      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR Germany VAT | 12     | 250 GB    | MozyPro Germany | Germany | yes       | DE812321109 |
#    Then Sub-total before taxes or discounts should be €824.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €824.89    | €824.89     |
#      | Pre-tax Subtotal  |          |            | €824.89     |
#      | Total Charges     |          |            | €824.89     |
#    And New partner should be created
#
#  @TC.141405_coupon_8 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon
#    When I add a new MozyPro partner:
#      | company name                                       | period | base plan | create under | country        | net terms | coupon              |
#      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be £703.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £703.89    | £703.89     |
#      | Discounts Applied |          |            | -£140.78    |
#      | Pre-tax Subtotal  |          |            | £563.11     |
#      | Taxes             |          |            | £112.62     |
#      | Total Charges     |          |            | £675.73     |
#    And New partner should be created
#
#  @TC.141405_coupon_9 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT
#    When I add a new MozyPro partner:
#      | company name                                                          | period | base plan | server plan | create under | country        | net terms | vat number  |
#      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | GB117223643 |
#    Then Sub-total before taxes or discounts should be £824.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £703.89    | £703.89     |
#      | Server Plan       | 1        | £120.89    | £120.89     |
#      | Pre-tax Subtotal  |          |            | £824.78     |
#      | Total Charges     |          |            | £824.78     |
#    And New partner should be created
#
#  @TC.141405_coupon_10 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon VAT
#    When I add a new MozyPro partner:
#      | company name                                           | period | base plan | create under | country        | net terms | coupon              | vat number  |
#      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon VAT | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 10PERCENTOFFOUTLINE | GB117223643 |
#    Then Sub-total before taxes or discounts should be £703.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £703.89    | £703.89     |
#      | Discounts Applied |          |            | -£70.39     |
#      | Pre-tax Subtotal  |          |            | £633.50     |
#      | Total Charges     |          |            | £633.50     |
#    And New partner should be created
#
#  @TC.141405_coupon_11 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Biennial) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | country       | net terms | coupon               |
#      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | United States | yes       | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $1,994.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
#      | Discounts Applied |          |            | -$1,994.79  |
#      | Total Charges     |          |            | $0.00       |
#    And New partner should be created
#
#  @TC.141405_coupon_12 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                                           | period | base plan | server plan | country       | net terms | coupon              |
#      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | yes         | United States | yes       | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $2,330.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | $1,994.79  | $1,994.79   |
#      | Server Plan       | 1        | $335.79    | $335.79     |
#      | Discounts Applied |          |            | -$233.06    |
#      | Pre-tax Subtotal  |          |            | $2,097.52   |
#      | Total Charges     |          |            | $2,097.52   |
#    And New partner should be created
#
#  @TC.141405_coupon_13 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland coupon
#    When I add a new MozyPro partner:
#      | company name                                                 | period | base plan | create under    | country | net terms | coupon               |
#      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland coupon | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €1,574.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Discounts Applied |          |            | -€1,574.79  |
#      | Total Charges     |          |            | €0.00       |
#    And New partner should be created
#
#  @TC.141405_coupon_14 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT
#    When I add a new MozyPro partner:
#      | company name                                                               | period | base plan | server plan | create under   | country | net terms | vat number    |
#      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT | 24     | 250 GB    | yes         | MozyPro France | France  | yes       | FR08410091490 |
#    Then Sub-total before taxes or discounts should be €1,847.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Server Plan       | 1        | €272.79    | €272.79     |
#      | Pre-tax Subtotal  |          |            | €1,847.58   |
#      | Total Charges     |          |            | €1,847.58   |
#    And New partner should be created
#
#  @TC.141405_coupon_15 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT
#    When I add a new MozyPro partner:
#      | company name                                                                       | period | base plan | server plan | create under    | country | net terms | coupon              | vat number  |
#      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT | 24     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 20PERCENTOFFOUTLINE | DE812321109 |
#    Then Sub-total before taxes or discounts should be €1,847.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | €1,574.79  | €1,574.79   |
#      | Server Plan       | 1        | €272.79    | €272.79     |
#      | Discounts Applied |          |            | -€369.52    |
#      | Pre-tax Subtotal  |          |            | €1,478.06   |
#      | Total Charges     |          |            | €1,478.06   |
#    And New partner should be created
#
#  @TC.141405_coupon_16 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro 250 GB Plan (Biennial) GBP VAT
#    When I add a new MozyPro partner:
#      | company name                                      | period | base plan | create under | country        | net terms | vat number  |
#      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP VAT | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       | GB117223643 |
#    Then Sub-total before taxes or discounts should be £1,343.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
#      | Pre-tax Subtotal  |          |            | £1,343.79   |
#      | Total Charges     |          |            | £1,343.79   |
#    And New partner should be created
#
#  @TC.141405_coupon_17 @add_new_partner @mozypro @bus @price_changed
#  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon
#    When I add a new MozyPro partner:
#      | company name                                                           | period | base plan | server plan | create under | country        | net terms | coupon              |
#      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be £1,574.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 250 GB            | 1        | £1,343.79  | £1,343.79   |
#      | Server Plan       | 1        | £230.79    | £230.79     |
#      | Discounts Applied |          |            | -£314.92    |
#      | Pre-tax Subtotal  |          |            | £1,259.66   |
#      | Taxes             |          |            | £251.94     |
#      | Total Charges     |          |            | £1,511.60   |
#    And New partner should be created
#
#
#  @TC.141405_coupon_us1 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                      | period | base plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro 500 GB Plan (Annual) USD coupon | 12    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $2,089.89
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB            | 1        | $2,089.89  | $2,089.89  |
#      | Discounts Applied |          |            | -$208.99    |
#      | Pre-tax Subtotal  |          |            | $1,880.90    |
#      | Total Charges    |          |            | $1,880.90    |
#    And New partner should be created
#
#  @TC.141405_coupon_us2 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Annual) USD coupon | 12    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $2,309.78
#    And Order summary table should be:
#      | Description| Quantity | Price Each | Total Price |
#      | 500 GB     |1         | $2,089.89  | $2,089.89   |
#      | Server Plan|1         |  $219.89   | $219.89     |
#      | Discounts Applied|    |            |-$461.96     |
#      | Pre-tax Subtotal |    |            | $1,847.82   |
#      | Total Charges    |    |            | $1,847.82   |
#    And New partner should be created
#
#  @TC.141405_coupon_us3 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100
#    When I add a new MozyPro partner:
#      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100 | 12    | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $2,309.78
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     | $2,089.89  | $2,089.89   |
#      | Server Plan      |    1     | $219.89    | $219.89     |
#      | Discounts Applied|          |            | -$2,309.78  |
#      | Total Charges    |          |            |  $0.00      |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR1 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - VAT - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon-VAT| 12    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
#    Then Sub-total before taxes or discounts should be €1,825.78
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     |  €1,649.89 |  €1,649.89  |
#      | Server Plan      |    1     |   €175.89  |  €175.89    |
#      | Discounts Applied|          |            | -€182.58    |
#      | Pre-tax Subtotal |          |            | €1,643.20   |
#      | Total Charges    |          |            | €1,643.20   |
#    And New partner should be created
#
#  @TC.141405_coupon_EUR2 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon    | 12    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €1,825.78
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      |   500 GB         |    1     |  €1,649.89 |  €1,649.89  |
#      |  Server Plan     |    1     |  €175.89   |  €175.89    |
#      | Discounts Applied|          |            | -€365.16    |
#      | Pre-tax Subtotal |          |            | €1,460.62   |
#      |    Taxes         |          |            |  €335.94    |
#      | Total Charges    |          |            | €1,796.56   |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR3 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR VAT    | 12    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
#    Then Sub-total before taxes or discounts should be €1,825.78
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      |   500 GB         |    1     |  €1,649.89 |  €1,649.89  |
#      |  Server Plan     |    1     |  €175.89   |  €175.89    |
#      | Pre-tax Subtotal |          |            | €1,825.78    |
#      | Total Charges    |          |            | €1,825.78   |
#    And New partner should be created
#
#
#
#  @TC.141405_coupon_EUR4 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT only
#    When I add a new MozyPro partner:
#      | company name                                         | period | base plan | create under      |country       | net terms | vat number  |
#      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR VAT only | 12     | 500 GB    |   MozyPro Germany |Germany       | yes       | DE812321109 |
#    Then Sub-total before taxes or discounts should be €1,649.89
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      |   500 GB         |    1     |  €1,649.89 |  €1,649.89  |
#      | Pre-tax Subtotal |          |            |  €1,649.89  |
#      | Total Charges    |          |            |  €1,649.89  |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR5 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon only
#    When I add a new MozyPro partner:
#      | company name                                             | period | base plan | create under    |country       | net terms | coupon              |
#      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR coupon only  | 12    | 500 GB    |   MozyPro Ireland |Ireland      | yes       | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €1,649.89
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      |   500 GB         |    1     |  €1,649.89 |  €1,649.89  |
#      | Discounts Applied|          |            | -€329.98    |
#      | Pre-tax Subtotal |          |            | €1,319.91   |
#      |    Taxes         |          |            |  €303.58    |
#      | Total Charges    |          |            | €1,623.49   |
#    And New partner should be created
#
#
#  @TC.141405_coupon_GBP @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - coupon
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
#      | DONOT EDIT MozyPro 500 GB Plan (Annual) GBP VAT-Coupon              | 12    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
#    Then Sub-total before taxes or discounts should be £1,374.89
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            |    1     |  £1,374.89 |  £1,374.89  |
#      | Discounts Applied |          |            | -£1,374.89  |
#      | Total Charges     |          |            |    £0.00    |
#    And New partner should be created
#
#
#  @TC.141405_coupon_GBP1 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number  |
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) GBP VAT       | 12    | 500 GB    |   yes       |MozyPro UK |United Kingdom    | yes      | GB117223643 |
#    Then Sub-total before taxes or discounts should be £1,528.78
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            |    1     |  £1,374.89 |  £1,374.89  |
#      |  Server Plan      |    1     |  £153.89   |   £153.89   |
#      | Pre-tax Subtotal  |          |            |	 £1,528.78  |
#      | Total Charges     |          |            |  £1,528.78  |
#    And New partner should be created
#
#
#  @TC.141405_coupon_us11 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                      | period | base plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro 500 GB Plan (Biennial) USD coupon | 24    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $3,989.79
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           | 1        | $3,989.79  | $3,989.79   |
#      | Discounts Applied|          |            | -$398.98    |
#      | Pre-tax Subtotal |          |            | $3,590.81   |
#      | Total Charges    |          |            | $3,590.81   |
#    And New partner should be created
#
#  @TC.141405_coupon_us21 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon
#    When I add a new MozyPro partner:
#      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Biennial) USD coupon | 24    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $4,409.58
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     |  $3,989.79 | $3,989.79   |
#      | Server Plan      |    1     |  $419.79   |  $419.79    |
#      | Discounts Applied|          |            |  -$881.92   |
#      | Pre-tax Subtotal |          |            | $3,527.66   |
#      | Total Charges    |          |            | $3,527.66   |
#    And New partner should be created
#
#  @TC.141405_coupon_us31 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100
#    When I add a new MozyPro partner:
#      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
#      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100 | 24   | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be $4,409.58
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     | $3,989.79  | $3,989.79   |
#      | Server Plan      |    1     | $419.79    | $419.79     |
#      | Discounts Applied|          |            | -$4,409.58  |
#      | Total Charges    |          |            | $0.00       |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR11 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - VAT - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon-VAT| 24    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
#    Then Sub-total before taxes or discounts should be €3,485.58
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |     1    |  €3,149.79 |  €3,149.79  |
#      | Server Plan      |     1    |  €335.79   |  €335.79    |
#      | Discounts Applied|          |            | -€348.56    |
#      | Pre-tax Subtotal |          |            | €3,137.02   |
#      | Total Charges    |          |            | €3,137.02   |
#    And New partner should be created
#
#  @TC.141405_coupon_EUR21 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon    | 24    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
#    Then Sub-total before taxes or discounts should be €3,485.58
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     |  €3,149.79 |  €3,149.79  |
#      | Server Plan      |    1     |  €335.79   |  €335.79    |
#      | Discounts Applied|          |            | -€697.12    |
#      | Pre-tax Subtotal |          |            | €2,788.46   |
#      |    Taxes         |          |            |  €641.35    |
#      | Total Charges    |          |            | €3,429.81   |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR31 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR VAT    | 24    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
#    Then Sub-total before taxes or discounts should be €3,485.58
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     |  €3,149.79 |   €3,149.79 |
#      | Server Plan      |    1     |  €335.79   |   €335.79   |
#      | Pre-tax Subtotal |          |            | €3,485.58   |
#      | Total Charges    |          |            | €3,485.58   |
#    And New partner should be created
#
#
#  @TC.141405_coupon_EUR41 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - coupon
#    When I add a new MozyPro partner:
#      | company name                                                | period | base plan | create under  |country       | net terms | vat number     |coupon              |
#      | DONOT EDIT MozyPro 500 GB Plan (Biennial) EUR VAT-coupon    | 24    | 500 GB    |    MozyPro Germany |Germany | yes      | DE812321109 |  10PERCENTOFFOUTLINE     |
#    Then Sub-total before taxes or discounts should be €3,149.79
#    And Order summary table should be:
#      | Description      | Quantity | Price Each | Total Price |
#      | 500 GB           |    1     |  €3,149.79 |   €3,149.79 |
#      | Discounts Applied|          |            | -€314.98    |
#      | Pre-tax Subtotal |          |            | €2,834.81   |
#      | Total Charges    |          |            | €2,834.81   |
#    And New partner should be created
#
#  @TC.141405_coupon_GBP2 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) GBP VAT - coupon
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
#      | DONOT EDIT MozyPro 500 GB Plan (Biennial) GBP VAT-Coupon              | 24    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
#    Then Sub-total before taxes or discounts should be £2,624.79
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            |    1     | £2,624.79  |   £2,624.79 |
#      | Discounts Applied |          |            |  -£2,624.79 |
#      | Total Charges     |          |            |    £0.00    |
#    And New partner should be created
#
#  @TC.141405_coupon_GBP3 @add_new_partner @mozypro @price_changed
#  Scenario: MozyPro 500 GB Plan (Biennial) GBP  coupon- server plan
#    When I add a new MozyPro partner:
#      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon|
#      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) GBP Coupon  | 24    | 500 GB    | yes         |MozyPro UK |United Kingdom    | yes      | 100PERCENTOFFOUTLINE     |
#    Then Sub-total before taxes or discounts should be £2,918.58
#    And Order summary table should be:
#      | Description       | Quantity | Price Each | Total Price |
#      | 500 GB            |    1     | £2,624.79  |   £2,624.79 |
#      | Server Plan       |    1     |  £293.79   |   £293.79   |
#      | Discounts Applied |          |            |  -£2,918.58 |
#      | Total Charges     |          |            |    £0.00    |
#    And New partner should be created
