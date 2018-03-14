Feature: Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.133568 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) USD coupon | 12     | 250 GB    | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $729.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Discounts Applied |          |            | -$72.99     |
      | Pre-tax Subtotal  |          |            | $656.90     |
      | Total Charges     |          |            | $656.90     |
    And New partner should be created

  @TC.133569 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                                             | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon | 12     | 250 GB    | yes         | United States | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $854.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Server Plan       | 1        | $124.89    | $124.89     |
      | Discounts Applied |          |            | -$170.96    |
      | Pre-tax Subtotal  |          |            | $683.82     |
      | Total Charges     |          |            | $683.82     |
    And New partner should be created

  @TC.133570 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                 | period | base plan | server plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) USD coupon 100 | 12     | 250 GB    | yes         | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $854.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $729.89    | $729.89     |
      | Server Plan       | 1        | $124.89    | $124.89     |
      | Discounts Applied |          |            | -$854.78    |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.133571 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR France coupon
    When I add a new MozyPro partner:
      | company name                                              | period | base plan | create under   | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR France coupon | 12     | 250 GB    | MozyPro France | France  | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Discounts Applied |          |            | -€663.89    |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.133572 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon
    When I add a new MozyPro partner:
      | company name                                                                     | period | base plan | server plan | create under    | country | net terms | coupon              |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Germany coupon | 12     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €777.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Server Plan       | 1        | €113.89    | €113.89     |
      | Discounts Applied |          |            | -€77.78     |
      | Pre-tax Subtotal  |          |            | €700.00     |
      | Taxes             |          |            | €133.01     |
      | Total Charges     |          |            | €833.01     |
    And New partner should be created

  @TC.133573 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                         | period | base plan | server plan | create under    | country | net terms | coupon              | vat number |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) EUR Ireland coupon VAT | 12     | 250 GB    | yes         | MozyPro Ireland | Ireland | yes       | 20PERCENTOFFOUTLINE | IE9691104A |
    Then Sub-total before taxes or discounts should be €777.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Server Plan       | 1        | €113.89    | €113.89     |
      | Discounts Applied |          |            | -€155.56    |
      | Pre-tax Subtotal  |          |            | €622.22     |
      | Taxes             |          |            | €143.12     |
      | Total Charges     |          |            | €765.34     |
    And New partner should be created

  @TC.133574 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) EUR Germany VAT
    When I add a new MozyPro partner:
      | company name                                            | period | base plan | create under    | country | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) EUR Germany VAT | 12     | 250 GB    | MozyPro Germany | Germany | yes       | DE812321109 |
    Then Sub-total before taxes or discounts should be €663.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €663.89    | €663.89     |
      | Pre-tax Subtotal  |          |            | €663.89     |
      | Total Charges     |          |            | €663.89     |
    And New partner should be created

  @TC.133575 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon
    When I add a new MozyPro partner:
      | company name                                       | period | base plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£95.58     |
      | Pre-tax Subtotal  |          |            | £382.31     |
      | Taxes             |          |            | £76.46      |
      | Total Charges     |          |            | £458.77     |
    And New partner should be created

  @TC.133576 @add_new_partner @mozypro @bus
  Scenario: MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT
    When I add a new MozyPro partner:
      | company name                                                          | period | base plan | server plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro250 Server Add-on for MozyPro Plan( Annual) GBP VAT | 12     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £558.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Server Plan       | 1        | £80.89     | £80.89      |
      | Pre-tax Subtotal  |          |            | £558.78     |
      | Total Charges     |          |            | £558.78     |
    And New partner should be created

  @TC.133577 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Annual) GBP coupon VAT
    When I add a new MozyPro partner:
      | company name                                           | period | base plan | create under | country        | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Annual) GBP coupon VAT | 12     | 250 GB    | MozyPro UK   | United Kingdom | yes       | 10PERCENTOFFOUTLINE | GB117223643 |
    Then Sub-total before taxes or discounts should be £477.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £477.89    | £477.89     |
      | Discounts Applied |          |            | -£47.79     |
      | Pre-tax Subtotal  |          |            | £430.10     |
      | Total Charges     |          |            | £430.10     |
    And New partner should be created

  @TC.133578 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | country       | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | United States | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,399.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,399.79  | $1,399.79   |
      | Discounts Applied |          |            | -$1,399.79  |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created

  @TC.133579 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | country       | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) USD coupon | 24     | 250 GB    | yes         | United States | yes       | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,631.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | $1,399.79  | $1,399.79   |
      | Server Plan       | 1        | $231.79    | $231.79     |
      | Discounts Applied |          |            | -$163.16    |
      | Pre-tax Subtotal  |          |            | $1,468.42   |
      | Total Charges     |          |            | $1,468.42   |
    And New partner should be created

  @TC.133580 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) EUR Ireland coupon
    When I add a new MozyPro partner:
      | company name                                                 | period | base plan | create under    | country | net terms | coupon               |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) EUR Ireland coupon | 24     | 250 GB    | MozyPro Ireland | Ireland | yes       | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,272.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Discounts Applied |          |            | -€1,272.79  |
      | Total Charges     |          |            | €0.00       |
    And New partner should be created

  @TC.133581 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT
    When I add a new MozyPro partner:
      | company name                                                               | period | base plan | server plan | create under   | country | net terms | vat number    |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR France VAT | 24     | 250 GB    | yes         | MozyPro France | France  | yes       | FR08410091490 |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79  | €1,272.79   |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Pre-tax Subtotal  |          |            | €1,483.58   |
      | Total Charges     |          |            | €1,483.58   |
    And New partner should be created

  @TC.133582 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT
    When I add a new MozyPro partner:
      | company name                                                                       | period | base plan | server plan | create under    | country | net terms | coupon              | vat number  |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) EUR Germany Coupon VAT | 24     | 250 GB    | yes         | MozyPro Germany | Germany | yes       | 20PERCENTOFFOUTLINE | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,483.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €1,272.79   | €1,272.79  |
      | Server Plan       | 1        | €210.79    | €210.79     |
      | Discounts Applied |          |            | -€296.72    |
      | Pre-tax Subtotal  |          |            | €1,186.86   |
      | Total Charges     |          |            | €1,186.86   |
    And New partner should be created

  @TC.133583 @add_new_partner @mozypro @bus
  Scenario: MozyPro 250 GB Plan (Biennial) GBP VAT
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | create under | country        | net terms | vat number  |
      | DONOT EDIT MozyPro 250 GB Plan (Biennial) GBP VAT | 24     | 250 GB    | MozyPro UK   | United Kingdom | yes       | GB117223643 |
    Then Sub-total before taxes or discounts should be £914.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £914.79    | £914.79     |
      | Pre-tax Subtotal  |          |            | £914.79     |
      | Total Charges     |          |            | £914.79     |
    And New partner should be created

  @TC.133584 @add_new_partner @mozypro @bus
  Scenario: MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | server plan | create under | country        | net terms | coupon              |
      | DONOT EDIT MozyPro Server Add-on for 250 GB Plan (Biennial) GBP Coupon | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be £1,066.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | £914.79    | £914.79     |
      | Server Plan       | 1        | £151.79    | £151.79     |
      | Discounts Applied |          |            | -£213.32    |
      | Pre-tax Subtotal  |          |            | £853.26     |
      | Taxes             |          |            | £170.66     |
      | Total Charges     |          |            | £1,023.92   |
    And New partner should be created


  @TC.133585 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) USD coupon new| 12    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,459.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | $1,459.89  | $1,459.89  |
      | Discounts Applied |          |            | -$145.99    |
      | Pre-tax Subtotal  |          |            | $1,313.90    |
      | Total Charges    |          |            | $1,313.90    |
    And New partner should be created

  @TC.133586 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Annual) USD coupon new| 12    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,616.78
    And Order summary table should be:
      | Description| Quantity | Price Each | Total Price |
      | 500 GB     |1         | $1,459.89  | $1,459.89   |
      | Server Plan|1         |  $156.89   | $156.89     |
      | Discounts Applied|    |            |-$323.36     |
      | Pre-tax Subtotal |    |            | $1,293.42   |
      | Total Charges    |    |            | $1,293.42   |
    And New partner should be created

  @TC.133587 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Annual) USD coupon 100 new| 12    | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $1,616.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     | $1,459.89  | $1,459.89   |
      | Server Plan      |    1     | $156.89    | $156.89     |
      | Discounts Applied|          |            | -$1,616.78  |
      | Total Charges    |          |            |  $0.00      |
    And New partner should be created


  @TC.133588 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon-VAT new| 12    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €1,327.89 |  €1,327.89  |
      | Server Plan      |    1     |   €141.89  |  €141.89    |
      | Discounts Applied|          |            | -€146.98    |
      | Pre-tax Subtotal |          |            | €1,322.80   |
      | Total Charges    |          |            | €1,322.80   |
    And New partner should be created

  @TC.133589 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR coupon new| 12    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      |  Server Plan     |    1     |  €141.89   |  €141.89    |
      | Discounts Applied|          |            | -€293.96    |
      | Pre-tax Subtotal |          |            | €1,175.82   |
      |    Taxes         |          |            |  €270.44    |
      | Total Charges    |          |            | €1,446.26   |
    And New partner should be created


  @TC.133590 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) EUR VAT new   | 12    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,469.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      |  Server Plan     |    1     |  €141.89   |  €141.89    |
      | Pre-tax Subtotal |          |            | €1,469.78   |
      | Total Charges    |          |            | €1,469.78   |
    And New partner should be created



  @TC.133591 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR VAT only
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | create under      |country       | net terms | vat number  |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR VAT only new| 12     | 500 GB    |   MozyPro Germany |Germany       | yes       | DE812321109 |
    Then Sub-total before taxes or discounts should be €1,327.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      | Pre-tax Subtotal |          |            |  €1,327.89  |
      | Total Charges    |          |            |  €1,327.89  |
    And New partner should be created


  @TC.133592 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) EUR coupon only
    When I add a new MozyPro partner:
      | company name                                             | period | base plan | create under    |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Annual) EUR coupon only new| 12    | 500 GB    |   MozyPro Ireland |Ireland      | yes       | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €1,327.89
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      |   500 GB         |    1     |  €1,327.89 |  €1,327.89  |
      | Discounts Applied|          |            | -€265.58    |
      | Pre-tax Subtotal |          |            | €1,062.31   |
      |    Taxes         |          |            |  €244.33    |
      | Total Charges    |          |            | €1,306.64   |
    And New partner should be created


  @TC.133593 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
      | DONOT EDIT MozyPro 500 GB Plan (Annual) GBP VAT-Coupon new          | 12    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £954.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     |  £954.89 |  £954.89  |
      | Discounts Applied |          |            | -£954.89  |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created


  @TC.133594 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Annual) GBP VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number  |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Annual) GBP VAT new   | 12    | 500 GB    |   yes       |MozyPro UK |United Kingdom    | yes      | GB117223643 |
    Then Sub-total before taxes or discounts should be £1,056.78
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     |  £954.89 |  £954.89  |
      |  Server Plan      |    1     |  £101.89   |   £101.89   |
      | Pre-tax Subtotal  |          |            |	 £1,056.78  |
      | Total Charges     |          |            |  £1,056.78  |
    And New partner should be created


  @TC.133595 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                      | period | base plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) USD coupon new| 24    | 500 GB    | United States | yes      | 10PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $2,789.79
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           | 1        | $2,789.79  | $2,789.79   |
      | Discounts Applied|          |            | -$278.98    |
      | Pre-tax Subtotal |          |            | $2,510.81   |
      | Total Charges    |          |            | $2,510.81   |
    And New partner should be created

  @TC.133596 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon
    When I add a new MozyPro partner:
      | company name                                                            | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro 500GB Server Add-on for MozyPro Plan( Biennial) USD coupon new| 24    | 500 GB    | yes        | United States | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $3,086.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  $2,789.79 | $2,789.79   |
      | Server Plan      |    1     |  $296.79   |  $296.79    |
      | Discounts Applied|          |            |  -$617.32   |
      | Pre-tax Subtotal |          |            | $2,469.26   |
      | Total Charges    |          |            | $2,469.26   |
    And New partner should be created

  @TC.133597 @add_new_partner @mozypro
  Scenario: MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100
    When I add a new MozyPro partner:
      | company name                                                                | period | base plan | server plan | country      | net terms | coupon              |
      | DONOT EDIT MozyPro500 Server Add-on for MozyPro Plan( Biennial) USD coupon 100 new| 24   | 500 GB    | yes        | United States | yes      | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $3,086.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     | $2,789.79  | $2,789.79   |
      | Server Plan      |    1     | $296.79    | $296.79     |
      | Discounts Applied|          |            | -$3,086.58  |
      | Total Charges    |          |            | $0.00       |
    And New partner should be created


  @TC.133598 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |vat number|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon-VAT new| 24    | 500 GB    |    yes         |MozyPro France |France | yes      | 10PERCENTOFFOUTLINE |   FR08410091490           |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |     1    |  €2,536.79 |  €2,536.79  |
      | Server Plan      |     1    |  €268.79   |  €268.79    |
      | Discounts Applied|          |            | -€280.56    |
      | Pre-tax Subtotal |          |            | €2,525.02   |
      | Total Charges    |          |            | €2,525.02   |
    And New partner should be created

  @TC.133599 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR coupon - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR coupon new| 24    | 500 GB    |    yes         |MozyPro Ireland |Ireland | yes      | 20PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |  €2,536.79  |
      | Server Plan      |    1     |  €268.79   |  €268.79    |
      | Discounts Applied|          |            | -€561.12    |
      | Pre-tax Subtotal |          |            | €2,244.46   |
      |    Taxes         |          |            |  €516.23    |
      | Total Charges    |          |            | €2,760.69   |
    And New partner should be created


  @TC.133600 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | vat number              |
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) EUR VAT new | 24    | 500 GB    |    yes         |MozyPro Germany |Germany | yes      | DE812321109 |
    Then Sub-total before taxes or discounts should be €2,805.58
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |   €2,536.79 |
      | Server Plan      |    1     |  €268.79   |   €268.79   |
      | Pre-tax Subtotal |          |            | €2,805.58   |
      | Total Charges    |          |            | €2,805.58   |
    And New partner should be created


  @TC.133601 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) EUR VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | create under  |country       | net terms | vat number     |coupon              |
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) EUR VAT-coupon new| 24    | 500 GB    |    MozyPro Germany |Germany | yes      | DE812321109 |  10PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be €2,536.79
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 500 GB           |    1     |  €2,536.79 |   €2,536.79 |
      | Discounts Applied|          |            | -€253.68    |
      | Pre-tax Subtotal |          |            | €2,283.11   |
      | Total Charges    |          |            | €2,283.11   |
    And New partner should be created

  @TC.133602 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) GBP VAT - coupon
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | create under  |country       | net terms | vat number  |coupon|
      | DONOT EDIT MozyPro 500 GB Plan (Biennial) GBP VAT-Coupon new        | 24    | 500 GB    | MozyPro UK |United Kingdom    | yes      | GB117223643 |  100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £1,823.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     | £1,823.79  |   £1,823.79 |
      | Discounts Applied |          |            |  -£1,823.79 |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created

  @TC.133603 @add_new_partner @mozypro
  Scenario: MozyPro 500 GB Plan (Biennial) GBP  coupon- server plan
    When I add a new MozyPro partner:
      | company name                                                        | period | base plan | server plan|create under  |country       | net terms | coupon|
      | DONOT EDIT MozyPro 500 GB server add-on Plan (Biennial) GBP Coupon new | 24    | 500 GB    | yes         |MozyPro UK |United Kingdom    | yes      | 100PERCENTOFFOUTLINE     |
    Then Sub-total before taxes or discounts should be £2,017.58
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            |    1     | £1,823.79  |   £1,823.79 |
      | Server Plan       |	   1	 |  £193.79   |   £193.79   |
      | Discounts Applied |          |            |  -£2,017.58 |
      | Total Charges     |          |            |    £0.00    |
    And New partner should be created
