Feature: manage price schedules - billed partner

  Background:
    Given I log in bus admin console as administrator

  @TC.15666 @ops_env
  Scenario: 15666:BILL.18004 Verify that MozyPro UK Ireland Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyPro partner:
      | period | base plan | server plan | create under | net terms | country        |
      | 12     | 32 TB     | yes         | MozyPro UK   | yes       | United Kingdom |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                     |
      | Annual EN                                     |
      | MozyPro 32 TB Plan (Annual)                   |
      | MozyPro Server Add-on for 32 TB Plan (Annual) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new MozyPro partner:
      | period | base plan | create under    | net terms | country |
      | 1      | 16 TB     | MozyPro Ireland | yes       | Ireland |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                    |
      | Monthly EN                   |
      | MozyPro 16 TB Plan (Monthly) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | create under | net terms | country        |
      | 12      | Silver        | 10             | MozyPro UK   | yes       | United Kingdom |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                          |
      | Annual EN                          |
      | Mozy Reseller GB - Silver (Annual) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under    | net terms | country |
      | 1      | Gold          | 10             | yes         | 10             | MozyPro Ireland | yes       | Ireland |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                    |
      | Monthly EN                                   |
      | Mozy Reseller GB - Gold (Monthly)            |
      | Mozy Reseller 20 GB add-on - Gold (Monthly)  |
      | Metallic Reseller Server Add-On (monthly)    |
    And I delete partner account


  @TC.18749 @ops_env
  Scenario: 18749 Mozy Employees can assign Aria price schedules and tiers to an account
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 100 GB    | yes         |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name |
      | Annual EN                                      | 1          | usd         | Standard           |
      | MozyPro 100 GB Plan (Annual)                   | 1          | usd         | Standard           |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | 1          | usd         | Standard           |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 100 GB Plan (Annual)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | Non-profit Discount | usd               |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name  |
      | Annual EN                                      | 1          | usd         | Standard            |
      | MozyPro 100 GB Plan (Annual)                   | 1          | usd         | Non-profit Discount |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | 1          | usd         | Non-profit Discount |
    And API* I get all aria plan for newly created partner aria id
    Then service rates per rate schedule should be
      | plan_name                                      | service_desc           | rate_per_unit | monthly_fee |
      | MozyPro 100 GB Plan (Annual)                   | MozyPro Bundle         | 395.9         | 32.99       |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | MozyPro Server Add On  | 128.6         | 10.72       |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 100 GB Plan (Annual)                   | Non-profit Discount | usd               | 2              |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | Non-profit Discount | usd               | 10             |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name  |
      | Annual EN                                      | 1          | usd         | Standard            |
      | MozyPro 100 GB Plan (Annual)                   | 2          | usd         | Non-profit Discount |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | 10         | usd         | Non-profit Discount |
    And net pro-ration per rate schedule should be
      | plan_name                                      | proration_result_amount | rate_per_unit | line_units |
      | MozyPro 100 GB Plan (Annual)                   | 337.62                  | 395.9         | 2          |
      | MozyPro Server Add-on for 100 GB Plan (Annual) | 1157.4                  | 128.6         | 10          |
    And I delete partner account


  @TC.18752 @ops_env
  Scenario: 18752 Change plan will reflect the price schedule for a partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $9.99                     |
      | 50 GB, $19.99 (current purchase) |
      | 100 GB, $39.99                   |
      | 250 GB, $94.99                   |
      | 500 GB, $189.99                  |
      | 1 TB, $379.99                    |
      | 2 TB, $749.99                    |
      | 4 TB, $1,439.99                  |
      | 8 TB, $2,879.98                  |
      | 12 TB, $4,319.97                 |
      | 16 TB, $5,759.96                 |
      | 20 TB, $7,199.95                 |
      | 24 TB, $8,639.94                 |
      | 28 TB, $10,079.93                |
      | 32 TB, $11,519.92                |
    And Add-ons price should be Server Plan, $6.99
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 50 GB Plan (Monthly)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 50 GB Plan (Monthly) | Non-profit Discount | usd               |
    And I wait for 10 seconds
    And I refresh Change Plan section
    Then MozyPro available base plans and price should be:
      | plan                             |
      #| 10 GB, $8.00                     |
      # if case failed on staging at here, replace the above code with below one
      | 10 GB, $8.99                     |
      | 50 GB, $17.99 (current purchase) |
      | 100 GB, $35.99                   |
      | 250 GB, $85.49                   |
      | 500 GB, $170.99                  |
      | 1 TB, $341.99                    |
      | 2 TB, $674.99                    |
      | 4 TB, $1,295.99                  |
      | 8 TB, $2,591.98                  |
      | 12 TB, $3,887.97                 |
      | 16 TB, $5,183.96                 |
      | 20 TB, $6,479.96                 |
      | 24 TB, $7,775.95                 |
      | 28 TB, $9,071.94                 |
      | 32 TB, $10,367.93                |
    And Add-ons price should be Server Plan, $6.29
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.18754 @ops_env
  Scenario: 18754 Change plan will reflect the Modified Price schedule
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 10 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $9.99 (current purchase)  |
      | 50 GB, $19.99                    |
      | 100 GB, $39.99                   |
      | 250 GB, $94.99                   |
      | 500 GB, $189.99                  |
      | 1 TB, $379.99                    |
      | 2 TB, $749.99                    |
      | 4 TB, $1,439.99                  |
      | 8 TB, $2,879.98                  |
      | 12 TB, $4,319.97                 |
      | 16 TB, $5,759.96                 |
      | 20 TB, $7,199.95                 |
      | 24 TB, $8,639.94                 |
      | 28 TB, $10,079.93                |
      | 32 TB, $11,519.92                |
    And Add-ons price should be Server Plan, $3.99
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 10 GB Plan (Monthly)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 10 GB Plan (Monthly) | Non-profit Discount | usd               |
    And I wait for 5 seconds
    And I refresh Change Plan section
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $8.99 (current purchase)  |
      | 50 GB, $17.99                    |
      | 100 GB, $35.99                   |
      | 250 GB, $85.49                   |
      | 500 GB, $170.99                  |
      | 1 TB, $341.99                    |
      | 2 TB, $674.99                    |
      | 4 TB, $1,295.99                  |
      | 8 TB, $2,591.98                  |
      | 12 TB, $3,887.97                 |
      | 16 TB, $5,183.96                 |
      | 20 TB, $6,479.96                 |
      | 24 TB, $7,775.95                 |
      | 28 TB, $9,071.94                 |
      | 32 TB, $10,367.93                |
    And Add-ons price should be Server Plan, $3.59
    When API* I get all aria plan for newly created partner aria id
    And API* I change account schedule price for newly created partner aria id
      | plan_name                                      | rate_per_unit  |
      | MozyPro 10 GB Plan (Monthly)                   | 11.09          |
      | MozyPro Server Add-on for 10 GB Plan (Monthly) | 3.77           |
    And I wait for 5 seconds
    And I refresh Change Plan section
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $11.09 (current purchase) |
      | 50 GB, $19.99                    |
      | 100 GB, $39.99                   |
      | 250 GB, $94.99                   |
      | 500 GB, $189.99                  |
      | 1 TB, $379.99                    |
      | 2 TB, $749.99                    |
      | 4 TB, $1,439.99                  |
      | 8 TB, $2,879.98                  |
      | 12 TB, $4,319.97                 |
      | 16 TB, $5,759.96                 |
      | 20 TB, $7,199.95                 |
      | 24 TB, $8,639.94                 |
      | 28 TB, $10,079.93                |
      | 32 TB, $11,519.92                |
    And Add-ons price should be Server Plan, $3.77
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.18812 @ops_env
  Scenario: 18812 Mozy Employees change from another rate schedule back to standard
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 12 TB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name |
      | Monthly EN                                     | 1          | usd         | Standard           |
      | MozyPro 12 TB Plan (Monthly)                   | 1          | usd         | Standard           |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | 1          | usd         | Standard           |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 12 TB Plan (Monthly)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | Non-profit Discount | usd               |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name  |
      | Monthly EN                                     | 1          | usd         | Standard            |
      | MozyPro 12 TB Plan (Monthly)                   | 1          | usd         | Non-profit Discount |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | 1          | usd         | Non-profit Discount |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name | schedule_currency |
      | MozyPro 12 TB Plan (Monthly)                   | Standard           | usd               |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | Standard           | usd               |
    And API* I get all aria plan for newly created partner aria id
    Then service rates per rate schedule should be
      | plan_name                                      | service_desc           | rate_per_unit | monthly_fee   |
      | MozyPro 12 TB Plan (Monthly)                   | MozyPro Bundle         | 4319.97       | 4319.97       |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | MozyPro Server Add On  | 149.97        | 149.97        |
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name  |
      | Monthly EN                                     | 1          | usd         | Standard            |
      | MozyPro 12 TB Plan (Monthly)                   | 1          | usd         | Standard            |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | 1          | usd         | Standard            |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name | schedule_currency | num_plan_units |
      | MozyPro 12 TB Plan (Monthly)                   | Standard           | usd               | 2              |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | Standard           | usd               | 4              |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                      | plan_units | currency_cd | rate_schedule_name  |
      | Monthly EN                                     | 1          | usd         | Standard            |
      | MozyPro 12 TB Plan (Monthly)                   | 2          | usd         | Standard            |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | 4          | usd         | Standard            |
    And net pro-ration per rate schedule should be
      | plan_name                                      | proration_result_amount | rate_per_unit | line_units |
      | MozyPro 12 TB Plan (Monthly)                   | 4319.97                 | 4319.97       | 2          |
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | 449.91                  | 149.97        | 4          |
    And I delete partner account


  @TC.18813 @ops_env
  Scenario: 18813 Mozy Employees change one rate schedule back to another rate schedule
    When I add a new MozyPro partner:
      | period | base plan | server plan | create under   | net terms |  country |
      | 24     | 250 GB    | yes         | MozyPro France | yes       |  France  |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name |
      | Biennial FR                                      | 1          | eur         | Standard EUR       |
      | MozyPro 250 GB Plan (Biennial)                   | 1          | eur         | Standard           |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 1          | eur         | Standard           |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency |
      | MozyPro 250 GB Plan (Biennial)                   | Non-profit Discount | eur               |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Non-profit Discount | eur               |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name  |
      | Biennial FR                                      | 1          | eur         | Standard EUR        |
      | MozyPro 250 GB Plan (Biennial)                   | 1          | eur         | Non-profit Discount |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 1          | eur         | Non-profit Discount |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                        | rate_schedule_name | schedule_currency |
      | MozyPro 250 GB Plan (Biennial)                   | Standard            | eur               |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Standard            | eur               |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name  |
      | Biennial FR                                      | 1          | eur         | Standard EUR        |
      | MozyPro 250 GB Plan (Biennial)                   | 1          | eur         | Standard            |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 1          | eur         | Standard            |
    When API* I get all aria plan for newly created partner aria id
    Then service rates per rate schedule should be
      | plan_name                                        | service_desc           | rate_per_unit | monthly_fee |
      | MozyPro 250 GB Plan (Biennial)                   | MozyPro Bundle         | 1272.79       | 53.03       |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | MozyPro Server Add On  | 210.79        | 8.78        |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                        | rate_schedule_name | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial)                   | Standard           | eur               | 2              |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Standard           | eur               | 4              |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name  |
      | Biennial FR                                      | 1          | eur         | Standard EUR        |
      | MozyPro 250 GB Plan (Biennial)                   | 2          | eur         | Standard            |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 4          | eur         | Standard            |
    And net pro-ration per rate schedule should be
      | plan_name                                        | proration_result_amount | rate_per_unit | line_units |
      | MozyPro 250 GB Plan (Biennial)                   | 1312.27                 | 1272.79       | 2          |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 758.84                  | 210.79        | 4          |
    And I delete partner account


