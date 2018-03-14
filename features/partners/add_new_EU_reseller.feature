
Feature: Add a new EU reseller partner

  As a Mozy Administrator
  I want to create Reseller EU partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator


  @TC.124345 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124345 Add New Reseller Partner - US - Monthly - Silver 780 GB - Server Plan - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | coupon              | country       |
      | 1      | Silver        | 780            | yes         |     10         | 10PERCENTOFFOUTLINE | United States |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124346 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124346 Add New Reseller Partner  -- Monthly -- Silver -- IE -- 1000 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  net terms |
      |   1    |  Silver          | Ireland         | MozyPro Ireland  | 1000            |      yes     |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124347 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124347 Add New Reseller Partner  -- Monthly -- Gold -- IT -- 1000 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   1    |  Gold            | Italy           | MozyPro Germany  | 1000            |     10         | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124348 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 124348 Add New Reseller Partner  -- Monthly -- Platinum -- FR -- 2000 GB -- Server Plan -- Coupon -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | storage add on | cc number        |
      |   1    |  Platinum        | France          | MozyPro France   | 2000            |      yes     |  10PERCENTOFFOUTLINE |     10         | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                                                            | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124349 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124349 Add New Reseller Partner  -- Monthly -- Silver -- SE -- 1000 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  net terms |
      |   1    |  Silver          | Sweden          | MozyPro Germany  | 1000            |      yes     |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124350 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124350 Add New Reseller Partner  -- Monthly -- Gold -- DE -- 1024 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   1    |  Gold            | Germany         | MozyPro Germany  | 1024            |     10         | 4188181111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124351 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 124351 Add New Reseller Partner  -- Monthly -- Platinum -- PL -- 3500 GB -- Server Plan -- Coupon -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | storage add on | cc number        |
      |   1    |  Platinum        | Poland          | MozyPro France   | 3500            |      yes     |  10PERCENTOFFOUTLINE |     10         | 4023581211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124352 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 124352 Add New Reseller Partner  -- Monthly -- Silver -- ES -- 500 GB -- Server Plan -- Coupon -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | cc number        |
      |   1    |  Silver          | Spain           | MozyPro Ireland  | 500             |      yes     |  10PERCENTOFFOUTLINE | 4328191211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124353 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124353 Add New Reseller Partner  -- Monthly -- Gold -- FR -- 600 GB -- Server Plan -- Coupon -- CC -- VAT -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | storage add on | cc number        |
      |   1    |  Gold            | France          | MozyPro France   | 600             |      yes     |  10PERCENTOFFOUTLINE | FR08410091490 |     10         | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124354 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124354 Add New Reseller Partner  -- Monthly -- Platinum -- IT -- 400 GB -- Server Plan -- Coupon -- CC -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | cc number        |
      |   1    |  Platinum        | Italy           | MozyPro UK       | 400             |      yes     |  10PERCENTOFFOUTLINE | IT03018900245 | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124355 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124355 Add New Reseller Partner  -- Monthly -- Silver -- AT -- 400 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   1    |  Silver          | Austria         | MozyPro France   | 400             |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124356 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124356 Add New Reseller Partner  -- Monthly -- Gold -- BE -- 550 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | vat number     |
      |   1    |  Gold            | France         | MozyPro UK       | 550             |      yes     |  10PERCENTOFFOUTLINE |      yes   | FR08410091490  |
#      |   1    |  Gold            | Belgium         | MozyPro UK       | 550             |      yes     |  10PERCENTOFFOUTLINE |      yes   | BE0883236072 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124357 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124357 Add New Reseller Partner  -- Monthly -- Platinum -- FI -- 2048 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   1    |  Platinum        | Finland         | MozyPro France   | 2048            |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124358 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 124358 Add New Reseller Partner  -- Yearly -- Silver -- PT -- 2000 GB -- Server Plan -- Coupon -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | storage add on |
      |   12   |  Silver          | Portugal        | MozyPro Ireland  | 2000            |      yes     |  10PERCENTOFFOUTLINE |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124359 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124359 Add New Reseller Partner  -- Yearly -- Gold -- IE -- 1000 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | vat number |
      |   12   |  Gold            | Ireland         | MozyPro Ireland  | 1000            |      yes     |  10PERCENTOFFOUTLINE |      yes   | IE9691104A |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124360 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124360 Add New Reseller Partner  -- Yearly -- Platinum -- SE -- 1200 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   12   |  Platinum        | Sweden          | MozyPro Germany  | 1200            |     10         | 4581092111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124361 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124361 Add New Reseller Partner  -- Yearly -- Silver -- UK -- 500 GB -- Server Plan -- Coupon -- CC -- VAT -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota |  server plan |  coupon              | vat number  | storage add on | cc number        |
      |   12   |  Silver          | United Kingdom  | MozyPro UK   | 500             |      yes     |  10PERCENTOFFOUTLINE | GB117223643 |     10         | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124362 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124362 Add New Reseller Partner  -- Yearly -- Gold -- IT -- 800 GB -- Server Plan -- Coupon -- CC -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              | vat number    | cc number        |
      |   12   |  Gold            | Italy           | MozyPro UK       | 800             |      yes     |  10PERCENTOFFOUTLINE | IT03018900245 | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124363 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124363 Add New Reseller Partner  -- Yearly -- Platinum -- BG -- 600 GB -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms | storage add on |
      |   12   |  Platinum        | Bulgaria        | MozyPro Germany  | 600             |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124364 @bus @2.17 @add_new_partner @reseller @env_dependent @coupon
  Scenario: 124364 Add New Reseller Partner  -- Yearly -- Silver -- DE -- 2000 GB -- Server Plan -- Coupon -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  server plan |  coupon              |  net terms | storage add on |
      |   12   |  Silver          | Germany         | MozyPro Germany  | 2000            |      yes     |  10PERCENTOFFOUTLINE |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124365 @bus @2.17 @add_new_partner @reseller @vat @env_dependent @coupon
  Scenario: 124365 Add New Reseller Partner  -- Yearly -- Gold -- UK -- 600 GB -- Server Plan -- Coupon -- Net Terms -- VAT
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota |  server plan |  coupon              |  net terms | vat number  |
      |   12   |  Gold            | United Kingdom  | MozyPro UK   | 600             |      yes     |  10PERCENTOFFOUTLINE |      yes   | GB117223643 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124366 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124366 Add New Reseller Partner  -- Yearly -- Platinum -- UK -- 3000 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under |  reseller quota | storage add on | billing country | cc number        |
      |   12   |  Platinum        | United Kingdom  | MozyPro UK   | 3000            |     10         | United Kingdom  | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124367 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124367 Add New Reseller Partner  -- Yearly -- Silver -- EL -- 600 GB -- Net Terms -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms | storage add on |
      |   12   |  Silver          | Greece          | MozyPro France   | 600             |      yes   |     10         |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124368 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124368 Add New Reseller Partner  -- Yearly -- Gold -- DK -- 850 GB -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota |  net terms |
      |   12   |  Gold            | Denmark         | MozyPro UK       | 850             |      yes   |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124369 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124369 Add New Reseller Partner  -- Yearly -- Platinum -- LU -- 2600 GB -- CC -- 10 add on
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     |  reseller quota | storage add on | cc number        |
      |   12   |  Platinum        | Luxembourg      | MozyPro Ireland  | 2600            |     10         | 4779531111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124370 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124370 Add New Reseller Partner  -- BE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Belgium         | MozyPro France   |     800        |      yes     | 5413271111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124371 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124371 Add New Reseller Partner  -- BG -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Bulgaria        | MozyPro UK       |     800        |      yes     | 4169912111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124372 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124372 Add New Reseller Partner  -- CZ -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Czech Republic  | MozyPro France   |     800        |      yes     | 5101420111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124373 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124373 Add New Reseller Partner  -- DK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Denmark         | MozyPro Ireland  |     800        |      yes     | 5578922111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124374 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124374 Add New Reseller Partner  -- DE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Germany         | MozyPro Germany  |     800        |      yes     | 4188181111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124375 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124375 Add New Reseller Partner  -- EE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Estonia         | MozyPro France   |     800        |      yes     | 4238370111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124376 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124376 Add New Reseller Partner  -- EL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Greece          | MozyPro France   |     800        |      yes     | 4532121111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124377 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124377 Add New Reseller Partner  -- ES -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Spain           | MozyPro Ireland  |     800        |      yes     | 4328191211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124378 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124378 Add New Reseller Partner  -- FR -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under    | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | France          | MozyPro France  |     800        |      yes     | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124379 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124379 Add New Reseller Partner  -- HR -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Croatia         | MozyPro Germany  |     800        |      yes     | 5437781111111222 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124380 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124380 Add New Reseller Partner  -- IE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Ireland         | MozyPro Ireland  |     800        |      yes     | 4319402211111113 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124381 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124381 Add New Reseller Partner  -- IT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Italy           | MozyPro France   |     800        |      yes     | 4916921703777575 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124382 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124382 Add New Reseller Partner  -- CY -- Yearly -- Gold -- 800 GB -- Server Plan -- Net Terms
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | net terms |
      |   12   |   Gold           | Cyprus          | MozyPro Germany  |     800        |      yes     |   yes     |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                                | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>  | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>           | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>           |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                | Balance Due                                |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> | <%=@partner.billing_info.billing[:total_str]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124383 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124383 Add New Reseller Partner  -- LV -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Latvia          | MozyPro Ireland  |     800        |      yes     | 4405211111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124384 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124384 Add New Reseller Partner  -- LT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Lithuania       | MozyPro France   |     800        |      yes     | 4797121111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124385 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124385 Add New Reseller Partner  -- LU -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Luxembourg      | MozyPro Ireland  |     800        |      yes     | 4779531111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124386 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124386 Add New Reseller Partner  -- HU -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Hungary         | MozyPro Germany  |     800        |      yes     | 4333112111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124387 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124387 Add New Reseller Partner  -- MT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Malta           | MozyPro UK       |     800        |      yes     | 4313801111111121 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124388 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124388 Add New Reseller Partner  -- NL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Netherlands     | MozyPro Ireland  |     800        |      yes     | 5100291111111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124389 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124389 Add New Reseller Partner  -- AT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Austria         | MozyPro Ireland  |     800        |      yes     | 4548181211111124 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124390 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124390 Add New Reseller Partner  -- PL -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Poland          | MozyPro Ireland  |     800        |      yes     | 4023581211111111 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124391 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124391 Add New Reseller Partner  -- PT -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Portugal        | MozyPro France   |     800        |      yes     | 4556581910687747 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124392 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124392 Add New Reseller Partner  -- RO -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Romania         | MozyPro France   |     800        |      yes     | 4493590111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124393 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124393 Add New Reseller Partner  -- SI -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Slovenia        | MozyPro Germany  |     800        |      yes     | 4493690111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124394 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124394 Add New Reseller Partner  -- SK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Slovakia        | MozyPro Ireland  |     800        |      yes     | 4544170111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124395 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124395 Add New Reseller Partner  -- FI -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | Finland         | MozyPro Ireland  |     800        |      yes     | 4920111111111112 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124396 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124396 Add New Reseller Partner  -- SE -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under     | reseller quota |  server plan |   cc number      |
      |   12   |   Gold           | Sweden          | MozyPro Germany  |     800        |      yes     | 4581092111111122 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name

  @TC.124397 @bus @2.17 @add_new_partner @reseller @env_dependent
  Scenario: 124397 Add New Reseller Partner  -- UK -- Yearly -- Gold -- 800 GB -- Server Plan -- CC
    When I add a new Reseller partner:
      | period |   reseller type  | country         | create under | reseller quota |  server plan | cc number        |
      |   12   |   Gold           | United Kingdom  | MozyPro UK   |     800        |      yes     | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%>           |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                    |
    And Partner billing history should be:
      | Date  | Amount                                      | Total Paid                                  | Balance Due                               |
      | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
    And I search and delete partner account by newly created partner company name
