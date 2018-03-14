Feature: manage price schedules - billed partner

  Background:
   Given I log in bus admin console as administrator


  @TC.15666 @bus @aria @tasks_p2
  Scenario: 15666:BILL.18004 Verify that MozyPro Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 250 GB    | yes         |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
     | plan_name                                       |
     | Monthly EN                                      |
     | MozyPro 250 GB Plan (Monthly)                   |
     | MozyPro Server Add-on for 250 GB Plan (Monthly) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | create under    | net terms | country |
      | 12      | Gold          | 200            | 2              | MozyPro Germany | yes       | Germany |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                  |
      | Annual DE                                  |
      | Mozy Reseller GB - Gold (Annual)           |
      | Mozy Reseller 20 GB add-on - Gold (Annual) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new MozyPro partner:
      | period | base plan | server plan | create under   | net terms |  country |
      | 24     | 250 GB    | yes         | MozyPro France | yes       |  France  |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        |
      | Biennial FR                                      |
      | MozyPro 250 GB Plan (Biennial)                   |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | net terms |
      | 1      | Platinum      | 500            | 10             | yes       |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                       |
      | Monthly EN                                      |
      | Mozy Reseller GB - Platinum (Monthly)           |
      | Mozy Reseller 20 GB add-on - Platinum (Monthly) |
    And I delete partner account

  @TC.15666 @bus @aria @tasks_p2
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
      | Mozy Reseller Server Add-on - Gold (Monthly) |
      | Mozy Reseller 20 GB add-on - Gold (Monthly)  |
    And I delete partner account

  @TC.15666 @bus @aria @tasks_p2
  Scenario: 15666:BILL.18004 Verify that MozyEnterprise DPS Plans are migrated into Aria with the appropriate plan names
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | sales channel |
      | 12     | 2         | United States | Velocity      |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                            |
      | Annual EN                            |
      | MozyEnterprise for DPS 1 TB (Annual) |
    And I delete partner account
    And I refresh Add New Partner section
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       |
      | 24     | 200   | 250 GB      | 10            | United States |
    Then New partner should be created
    And I get partner aria id
    When API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                               |
      | Biennial EN                                             |
      | MozyEnterprise User (Biennial)                          |
      | MozyEnterprise 250 GB Server Plan (Biennial)            |
      | 250 GB Add-on for MozyEnterprise Server Plan (Biennial) |
    And I delete partner account

  @TC.15713 @bus @aria @tasks_p2
  Scenario: 15713:BILL 18500 Verify that Configuration add and list pro plans are not available MozyPro admins
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    When I act as newly created partner account
    Then Navigation item List Pro Plan should be unavailable
    And  Navigation item Add New Pro Plan should be unavailable
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Gold          | 500            | yes       |
    Then New partner should be created
    When I act as newly created partner account
    Then Navigation item List Pro Plan should be available
    And  Navigation item Add New Pro Plan should be available
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | yearly  | 10             | test     | false            | 1                          | 1                     |
    When I navigate to List Pro Plans section from bus admin console page
    Then list pro plan is
      | Name    | Enabled | Public |
      | subplan | Yes     | No     |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | country        | cc number        |
      | 24     | 98    | 500 GB       | United Kingdom | 4916783606275713 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I navigate to List Pro Plans section from bus admin console page
    Then list pro plan is
      | Name    | Enabled | Public |
      | subplan | Yes     | No     |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
    When I add a new OEM partner:
      | company_name | security |
      | Test.OEM     | HIPAA    |
    And New partner should be created
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | newrole   | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    When I navigate to List Pro Plans section from bus admin console page
    Then list pro plan is
      | Name    | Enabled | Public |
      | subplan | Yes     | No     |
    And I stop masquerading from subpartner
    Then I search and delete partner account by Test.OEM

  @TC.18749 @bus @aria @tasks_p2
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
      | MozyPro Server Add-on for 100 GB Plan (Annual) | Mozy Pro Server Add On | 128.6         | 10.72       |
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


  @TC.18752 @bus @aria @tasks_p2 @ROR_smoke
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
      | 10 GB, $8.00                     |
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

  @TC.18753 @bus @aria @tasks_p2
  Scenario: 18753 Billing History will reflect the price schedule for a partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 24     | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $566.58 | $566.58    | $0.00       |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                       | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 50 GB Plan (Biennial)                   | Non-profit Discount | usd               | 2              |
      | MozyPro Server Add-on for 50 GB Plan (Biennial) | Non-profit Discount | usd               | 3              |
    When I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                 | Payment Type                  |
      | Biennial (change) | after 2 years | $1,151.95 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    Then Next renewal supplemental plan details should be:
      | Number purchased | Price each | Total price for 50 GB |
      | 2                | $377.81    | $755.62               |
    Then Next renewal supplemental plan server plan details should be:
      | Number purchased | Price each | Total price for Server Plan |
      | 3                | $132.11    | $396.33                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18754 @bus @aria @tasks_p2
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
      | 10 GB, $8.00 (current purchase)  |
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

  @TC.18764 @bus @aria @tasks_p2
  Scenario: 18764 Price schedule will apply to customers in the next subscription period
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 250 GB    | yes         |
    Then New partner should be created
    And I get partner aria id
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                       | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Monthly)                   | Non-profit Discount | usd               | 2              |
      | MozyPro Server Add-on for 250 GB Plan (Monthly) | Non-profit Discount | usd               | 3              |
    And I move backwards account billing dates 1 month for newly created partner aria id
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    And Billing history table should be:
      | Date      | Amount  | Total Paid | Balance Due |
      | today     | $27.18  | $27.18     | $0.00       |
      | today     | $75.99  | $75.99     | $0.00       |
      | today     | $110.98 | $110.98    | $0.00       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.18812 @bus @aria @tasks_p2
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
      | MozyPro Server Add-on for 12 TB Plan (Monthly) | Mozy Pro Server Add On | 149.97        | 149.97        |
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

  @TC.18813 @bus @aria @tasks_p2
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
      | MozyPro 250 GB Plan (Biennial)                   | Velocity           | eur               |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Velocity           | eur               |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name  |
      | Biennial FR                                      | 1          | eur         | Standard EUR        |
      | MozyPro 250 GB Plan (Biennial)                   | 1          | eur         | Velocity            |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 1          | eur         | Velocity            |
    When API* I get all aria plan for newly created partner aria id
    Then service rates per rate schedule should be
      | plan_name                                        | service_desc           | rate_per_unit | monthly_fee |
      | MozyPro 250 GB Plan (Biennial)                   | MozyPro Bundle         | 0             | 0           |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Mozy Pro Server Add On | 0             | 0           |
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                        | rate_schedule_name | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial)                   | Velocity           | eur               | 2              |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Velocity           | eur               | 4              |
    And API* I get aria plan for newly created partner aria id
    Then The aria plan should be
      | plan_name                                        | plan_units | currency_cd | rate_schedule_name  |
      | Biennial FR                                      | 1          | eur         | Standard EUR        |
      | MozyPro 250 GB Plan (Biennial)                   | 2          | eur         | Velocity            |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 4          | eur         | Velocity            |
    And net pro-ration per rate schedule should be
      | plan_name                                        | proration_result_amount | rate_per_unit | line_units |
      | MozyPro 250 GB Plan (Biennial)                   | 0                       | 0             | 2          |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | 0                       | 0             | 4          |
    And I delete partner account

  @TC.18788 @bus @aria @tasks_p2
  Scenario: 18788 Price schedules and tiers cannot be chosen for a given customer within the Mozy
    When I navigate to Add New Partner section from bus admin console page
    Then Rate schedule can not be choosen when add partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 12     | 250 GB    | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then Rate schedule can not be choosen when change plan
    When I stop masquerading
    And I search and delete partner account by newly created partner company name