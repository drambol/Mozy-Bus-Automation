Feature: Check the invoice of MozyHome user

  As a private citizen
  I should receive the invoice when I sign up / upgrade / re-subscription my MozyHome product
  So that I can have a understanding on how much vat I paid for my MozyHome service

  Background:

  @TC.125476 @phoenix @mozyhome @invoice
  Scenario: 125476 Adding a new US monthly basic MozyHome user will not receive invoice
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 50 GB     | United States | United States   |
    Then the user is successfully added.
    When I search emails by keywords:
      | to               | subject                |
      | @new_admin_email | Mozy Account Statement |
    Then I should see 0 email(s)

  @TC.125477 @phoenix @mozyhome @invoice
  Scenario: 125477 Adding a new EU free MozyHome user will not receive invoice
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country        |  billing country |
      | free      | United Kingdom |  United Kingdom  |
    Then the user is successfully added.
    When I search emails by keywords:
      | to               | subject               |
      | @new_admin_email | Mozy Account Statement |
    Then I should see 0 email(s)

  @TC.125481 @phoenix @mozyhome @invoice
  Scenario: 125481 Add a new UK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country         | billing country | cc number        |
      | 1      | 50 GB     | United Kingdom  | United Kingdom  | 4916783606275713 |
    Then the user is successfully added.
    When I search emails by keywords:
      | to               | subject                |
      | @new_admin_email | Mozy Account Statement |
    Then I should see 1 email(s)
    And I clear downloads folder
    And I download the invoice content
    And I open invoice page
    And invoice country is United Kingdom
    And Billing details of home invoice should be:
      | Billing Detail |               |          |                        |       |               |                   |             |
      | From Date      | To Date       | Quantity | Description            | Price | VAT(GB - 20%) | Percent of Period | Total Price |
      | today          | after 1 month |    1     | MozyHome 50 GB         | £4.16 | £0.83         | 100.0%            | £4.99       |
      |                |               |          | Total                  |       |               |                   | £4.99       |
      | today          |               |          | Electronic Payment     |       |               |                   | £-4.99      |
      |                |               |          | Balance                |       |               |                   | £0.00       |
    And Exchange rate table should be:
      | From Currency | To Currency | Exchange Rate |
      | GBP           | EUR         | 1.25          |
    And vat charged is €1.04

  @TC.125483 @phoenix @mozyhome @invoice
  Scenario: 125483 Add a new UK yearly MozyHome user with coupon
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | addl storage | addl computers | cc number        |  coupon       |
      | 12     | 125 GB    | United Kingdom | United Kingdom  |    9         |   2            | 4916783606275713 |  10percentoff |
    Then the user is successfully added.
    When I search emails by keywords:
      | to               | subject                |
      | @new_admin_email | Mozy Account Statement |
    Then I should see 1 email(s)
    And I clear downloads folder
    And I download the invoice content
    And I open invoice page
    And invoice country is United Kingdom
    And Billing details of home invoice should be:
      | Billing Detail |               |          |                        |         |               |                   |             |
      | From Date      | To Date       | Quantity | Description            | Price   | VAT(GB - 20%) | Percent of Period | Total Price |
      | today          | after 1 year  |    1     | MozyHome 125 GB        | £73.24  | £14.65        | 100.0%            | £87.89      |
      | today          | after 1 year  |    9     | + 20 GB                | £16.04  | £28.88        | 100.0%            | £173.25     |
      | today          | after 1 year  |    2     | + 1 machine            | £16.04  | £6.42         | 100.0%            | £38.50      |
      | today          | after 1 year  |    1     | 12 months at 10.0% off |         |               | 100.0%            | £-29.96     |
      |                |               |          | Total                  |         |               |                   | £269.68     |
      | today          |               |          | Electronic Payment     |         |               |                   | £-269.68    |
      |                |               |          | Balance                |         |               |                   | £0.00       |
    And Exchange rate table should be:
      | From Currency | To Currency | Exchange Rate |
      | GBP           | EUR         | 1.25          |
    And vat charged is €56.19