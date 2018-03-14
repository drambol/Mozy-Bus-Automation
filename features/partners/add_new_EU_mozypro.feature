  Feature: Add a new EU mozypro partner

    As a Mozy Administrator
    I want to create MozyPro EU partners
    So that I can organize my business in a way that works for me

    Background:
      Given I log in bus admin console as administrator

    #---------------------------------------------------------------------------------
    #    negative test cases:
    #---------------------------------------------------------------------------------

  @TC.124398 @bus @2.17 @add_new_partner @mozypro @signup_neg @vat
  Scenario: 124398 Add New MozyPro Partner - invalid VAT number

  # no country code in vat number
    When I add a new MozyPro partner:
      | period |   create under   |  country  |    vat number     |
      | 1      |  MozyPro Ireland |  Ireland  |   820c9dIN@#;v    |
    Then Create partner error message should be VAT number is invalid. Please try again.

  # country code match, vat number is invalid
    When I add a new MozyPro partner:
      | period |  country  |    vat number     |
      | 1      |  Ireland  |   IE08410091490   |
    Then Create partner error message should be VAT number is invalid. Please try again.

  # vat number country code not match country
    When I add a new MozyPro partner:
      | period |  create under    | country   |    vat number      |
      | 1      |  MozyPro Germany |  Ireland  |   FR08410091490    |
    Then Create partner error message should be VAT number is invalid. Please try again.


  @TC.124399 @bus @2.17 @add_new_partner @mozypro @signup_neg
  Scenario: 124399 Add New MozyPro Partner - invalid coupon
    When I add a new MozyPro partner:
      | period |  country          |    coupon              |
      | 1      |  United Kingdom   |   10OffInvalidCoupon   |
    Then Create partner error message should be Invalid coupon code

  @TC.124400 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124400 Add New MozyPro Partner - If no vat number, profile country is EU, billing country is not EU, alert will pop up. Partner created failed if BIN country not match.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country   | cc number        |
      | 1      | 50 GB     |  MozyPro Germany  |  Spain    |    United States  | 5232037812229004 |
    And Aria payment error message should be Could not validate payment information.
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.124401 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124401 Add New MozyPro Partner - If no vat number, profile country is not EU, billing country is EU, alert will pop up. BIN country check will take effect.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country       | billing country   | cc number        |
      | 1      | 50 GB     |  MozyPro          |  United States |  United Kingdom   | 4916783606275713 |
    And New partner should be created
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.124402 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124402 Add New MozyPro Partner - If no vat number, profile country&billing country all EU and profile country not match billing country, alert will pop up.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country | cc number        |
      | 1      | 50 GB     |  MozyPro France   |   Germany |  Poland         | 5232037812229004 |
    And New partner should be created
    And the billing country alert is This customer might be an EU customer without a VAT number, the billing contact address doesn't match the account country. Please verify the customer's location manually offline

  @TC.124403 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124403 Add New MozyPro Partner - If no vat number, profile country is EU, when select payment method as Net Terms, alert will pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  net terms |
      | 1      | 50 GB     |  MozyPro Ireland  |   Finland |  yes       |
    And New partner should be created
    And the billing country alert is This is an EU customer without a VAT number and credit card info. Please verify the customer's location manually offline.

  @TC.124404 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124404 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country not match billing country, alert will not pop up
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country   |  billing country | net terms  |
      | 12     | 50 GB     |  MozyPro      |  Hong Kong |  United States   | yes        |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124405 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124405 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country match billing country, alert will not pop up
    When I add a new MozyPro partner:
      | period | base plan |  create under | country       | net terms  |
      | 12     | 50 GB     |  MozyPro      | United States | yes        |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124406 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124406 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU and profile country not match billing country, alert will not pop up, sign up will succeed even BIN country not match.
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country         | billing country |
      | 12     | 50 GB     |  MozyPro      |  United States   | Japan           |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124407 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124407 Add New MozyPro Partner - If no vat number, profile country&billing country all not EU, alert will not pop up, sign up will succeed
    When I add a new MozyPro partner:
      | period | base plan |  create under |  country         |
      | 12     | 50 GB     |  MozyPro      |  United States   |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124408 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124408 Add New MozyPro Partner - If no vat number, profile country is same as billing country (EU), sign up using nt, alert will pop up, sign up will secceed
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  net terms |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  yes       |
    And New partner should be created
    And the billing country alert is This is an EU customer without a VAT number and credit card info. Please verify the customer's location manually offline.

  @TC.124409 @bus @2.17 @add_new_partner @mozypro @signup_alert
  Scenario: 124409 Add New MozyPro Partner - If no vat number, profile country is same as billing country (EU), alert will not pop up, sign up use cc will secceed if BIN country match.
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  cc number        |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  4319402211111113 |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124410 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 124410 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  |  cc number        |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  4319402211111113 |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124411 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 124411 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country |  cc number        |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  France         |  4485393141463880 |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124412 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 124412 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | billing country | net terms |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  | France          |  yes      |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation

  @TC.124413 @bus @2.17 @add_new_partner @mozypro @signup_alert @vat
  Scenario: 124413 Add New MozyPro Partner - partner with valid vat number should sign up successfully, no alert pop up
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | net terms |  vat number |
      | 12     | 50 GB     |  MozyPro Ireland  |  Ireland  |  yes      |  IE9691104A |
    And New partner should be created
    And there is no popup alert during partner creation



  #   Verified in busclient04 2.17.0.2
  #  manual case: VAT validation service is currently not available
  #  steps:
  #  1. edit app/models/vat.rb,  change soap server address
  #  2. run case TC.40005. test pass
  #  3. create EU partner with the vat number blank
  #  4. new partner should be created
  #  5. change app/models/vat.rb back
  # @TC.40005 @bus @2.17 @add_new_partner @mozypro
  # Scenario: 40002 Add New MozyPro Partner - VAT number not match country
  #  When I add a new MozyPro partner:
  #    | period | country   |    vat number      |
  #    | 1      |  France   |   FR08410091490    |
  #  Then Create partner error message should be The VAT validation service is temporarily unavailable, please leave the field blank and update later.






  #---------------------------------------------------------------------------------
  #    Create MozyPro US partner:
  #---------------------------------------------------------------------------------

  @TC.124290 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124290 Add New MozyPro Partner  -- US -- Monthly -- 10 GB -- Server Plan -- Net Terms
    When I add a new MozyPro partner:
      | period |  base plan |  country       |   server plan |  net terms |   billing country  |  billing state abbrev |
      |   1    |  10 GB     |  United States |       yes     |     yes    |      United States |         CA            |
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

  @TC.124291 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124291 Add New MozyPro Partner  -- US -- Yearly -- 24 TB -- Coupon -- HIPAA -- CC
    When I add a new MozyPro partner:
      | period |  base plan |  country       |  coupon               |  security |
      |   12   |  24 TB     |  United States |  10PERCENTOFFOUTLINE  |    HIPAA  |
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

    @TC.124292 @bus @2.17 @add_new_partner @mozypro
    Scenario: 124292 Add New MozyPro Partner  -- US -- Monthly -- 1 TB -- server plan -- billing country
      When I add a new MozyPro partner:
        | period |  base plan |  country       | server plan | billing country | cc number        |
        |   12   |  24 TB     |  United States | yes         | France          | 4485393141463880 |
      And the sub-total before taxes or discounts should be correct
      And the order summary table should be correct
      And New partner should be created
      And New Partner internal billing should be:
        | Account Type:   | Credit Card                               | Current Period: | <%=@partner.subscription_period%> |
        | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                               |
        | Renewal Date:   | <%=@partner.subscription_period%>         | Renewal Period: | Use Current Period |
        | Next Charge:    | <%=@partner.subscription_period%>         |                 |                    |
      And Partner billing history should be:
        | Date  | Amount                                          | Total Paid                                      | Balance Due                               |
        | today | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:total_str]%>  | <%=@partner.billing_info.billing[:zero]%> |
      And I search and delete partner account by newly created partner company name
  #----------------------------------------------------------------------------------
  #
  #          Create under is not following  currency
  #     (country EU, under us)
  #     (country US, under EU)
  #     (country JP, under us)
  # #    (country uk, under de)
  # #    (country EU, under us)
  # #    (country fr, under uk)
  #----------------------------------------------------------------------------------

  @TC.124293 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124293 Add New MozyPro Partner  -- BE -- Yearly -- 500 GB -- HIPAA -- CC
    When I add a new MozyPro partner:
      | period |  base plan |  country | security |  cc number        |
      |   12   |  500 GB    |  Belgium |  HIPAA   |  5413271111111222 |
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

  @TC.124294 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124294 Add New MozyPro Partner  -- US -- Yearly -- 50 GB -- Coupon -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country        | create under     |  coupon              |  net terms |
      |   12   |       50 GB |  United States | MozyPro France   |  10PERCENTOFFOUTLINE |     yes    |
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


  @TC.124295 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124295 Add New MozyPro Partner  -- JP -- Monthly -- 100 GB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |  base plan |  country |  server plan  | cc number        |
      |   1    |  100 GB    |   Japan  |     yes       | 4542465014608212 |
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


  #---------------------------------------------------------------------------------
  #    negative test cases:
  #---------------------------------------------------------------------------------

  @TC.124296 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124296 Add New MozyPro Partner  -- ES -- Monthly -- 10 GB -- Server Plan -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country       | create under     |  server plan |  net terms |
      |   1    |       10 GB | Spain         | MozyPro Ireland  |      yes     |     yes    |
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

  @TC.124297 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124297 Add New MozyPro Partner  -- DK -- Monthly -- 250 GB -- Coupon -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              |  net terms |
      |   1    |      250 GB | Denmark         | MozyPro France   |  10PERCENTOFFOUTLINE |     yes    |
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

  @TC.124298 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124298 Add New MozyPro Partner  -- EL -- Monthly -- 2 TB -- Server Plan -- billing country -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | billing country |  net terms |
      |   1    |        2 TB | Greece          | MozyPro France   |      yes     | Greece          |     yes    |
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

  @TC.124299 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124299 Add New MozyPro Partner  -- CZ -- Monthly -- 12 TB -- Coupon -- HIPAA -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | security |  net terms |
      |   1    |       12 TB | Czech Republic  | MozyPro Germany  |  10PERCENTOFFOUTLINE | HIPAA    |     yes    |
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

  @TC.124300 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124300 Add New MozyPro Partner  -- CY -- Monthly -- 24 TB -- Server Plan -- 15 add on -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  net terms | storage add on |
      |   1    |       24 TB | Cyprus          | MozyPro Ireland  |      yes     |     yes    |     15         |
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

  @TC.124301 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124301 Add New MozyPro Partner  -- BG -- Yearly -- 50 GB -- Coupon -- HIPAA -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | security |  net terms |
      |   12   |       50 GB | Bulgaria        | MozyPro France   |  10PERCENTOFFOUTLINE | HIPAA    |     yes    |
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

  @TC.124302 @bus @2.17 @add_new_partner @mozypro @vat @coupon
  Scenario: 124302 Add New MozyPro Partner  -- DE -- Yearly -- 500 GB -- Server Plan -- Coupon -- VAT -- Net Terms
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     |  server plan |  coupon              | vat number  |  net terms |
        |   12   |      500 GB | Germany         | MozyPro Germany  |      yes     |  10PERCENTOFFOUTLINE | DE812321109 |     yes    |
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

  @TC.124303 @bus @2.17 @add_new_partner @mozypro @vat
  Scenario: 124303 Add New MozyPro Partner  -- IE -- Yearly -- 4 TB -- Server Plan -- VAT -- HIPAA -- Net Terms
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     |  server plan | vat number | security |  net terms |
        |   12   |        4 TB | Ireland         | MozyPro Ireland  |      yes     | IE9691104A | HIPAA    |     yes    |
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

  @TC.124304 @bus @2.17 @add_new_partner @mozypro @vat
  Scenario: 124304 Add New MozyPro Partner  -- IT -- Yearly -- 16 TB -- Server Plan -- VAT -- 10 add on -- Net Terms
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     |  server plan | vat number    | storage add on |  net terms |
        |   12   |       16 TB | Italy           | MozyPro Germany  |      yes     | IT03018900245 |     10         |     yes    |
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

  # Hard code amount here as amount in BUS order summary €96,429.27 is different from invoice in Aria €96,429.29
  @TC.124305 @BUG.132150 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124305 Add New MozyPro Partner  -- LV -- Yearly -- 28 TB -- Server Plan -- Coupon -- billing country -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  coupon              | billing country | billing state abbrev |  net terms |
      |   12   |       28 TB | Latvia          | MozyPro Ireland  |      yes     |  10PERCENTOFFOUTLINE | United States   |      NY              |     yes    |
    And the sub-total before taxes or discounts should be correct
    And the order summary table should be correct
    And New partner should be created
    And New Partner internal billing should be:
      | Account Type:   | Net Terms 30                        | Current Period: | <%=@partner.subscription_period%> |
      | Unpaid Balance: | €96,429.29                          | Collect On:     | N/A                               |
      | Renewal Date:   | <%=@partner.subscription_period%>   | Renewal Period: | Use Current Period                |
      | Next Charge:    | <%=@partner.subscription_period%>   |                 |                                   |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €96,429.29 | €0.00      | €96,429.29  |
    And I search and delete partner account by newly created partner company name

  @TC.124306 @bus @2.17 @add_new_partner @mozypro @vat
  Scenario: 124306 Add New MozyPro Partner  -- FR -- Biennially -- 100 GB -- VAT -- billing country -- Net Terms
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     | vat number    | billing country | billing state |  net terms |
        |   24   |      100 GB | France          | MozyPro France   | FR08410091490 | United Kingdom  |     Wales     |     yes    |
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

  @TC.124307 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124307 Add New MozyPro Partner  -- EE -- Biennially -- 1 TB -- Coupon -- 12 add on -- HIPAA -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | storage add on | security |  net terms |
      |   24   |        1 TB | Estonia         | MozyPro Germany  |  10PERCENTOFFOUTLINE |     12         | HIPAA    |     yes    |
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

  @TC.124308 @bus @2.17 @add_new_partner @mozypro @vat
  Scenario: 124308 Add New MozyPro Partner  -- BE -- Biennially -- 8 TB -- Server Plan -- VAT -- Net Terms
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     |  server plan | vat number     |  net terms |
        |   24   |        8 TB | France         | MozyPro France   |      yes     | FR08410091490  |     yes    |
#        |   24   |        8 TB | Belgium         | MozyPro France   |      yes     | BE0883236072 |     yes    |
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

  @TC.124309 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124309 Add New MozyPro Partner  -- IT -- Biennially -- 16 TB -- Server Plan -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  net terms |
      |   24   |       16 TB | Italy           | MozyPro UK       |      yes     |     yes    |
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

  @TC.124310 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124310 Add New MozyPro Partner  -- HR -- Biennially -- 20 TB -- Server Plan -- Coupon -- 10 add on -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  coupon              | storage add on |  net terms |
      |   24   |       20 TB | Croatia         | MozyPro France   |      yes     |  10PERCENTOFFOUTLINE |     10         |     yes    |
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

  @TC.124311 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124311 Add New MozyPro Partner  -- LU -- Biennially -- 32 TB -- Server Plan -- HIPAA -- Coupon -- Net Terms
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | security |  coupon              |  net terms |
      |   24   |       32 TB | Luxembourg      | MozyPro France   |      yes     | HIPAA    |  10PERCENTOFFOUTLINE |     yes    |
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

  @TC.124312 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124312 Add New MozyPro Partner  -- LT -- Monthly -- 100 GB -- Server Plan -- HIPAA -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country       | create under     |  server plan | security | cc number        |
      |   1    |      100 GB |   Lithuania   | MozyPro Ireland  |      yes     | HIPAA    | 4797121111111111 |
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

  @TC.124313 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124313 Add New MozyPro Partner  -- PT -- Monthly -- 1 TB -- 10 add on -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     | storage add on | cc number        |
      |   1    |        1 TB | Portugal        | MozyPro France   |     10         | 4556581910687747 |
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

  @TC.124314 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124314 Add New MozyPro Partner  -- SI -- Monthly -- 8 TB -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  cc number       |
      |   1    |        8 TB | Slovenia        | MozyPro Ireland  | 4493690111111112 |
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

  @TC.124315 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124315 Add New MozyPro Partner  -- SE -- Monthly -- 20 TB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   1    |       20 TB | Sweden          | MozyPro Germany  |      yes     | 4581092111111122 |
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

  @TC.124316 @bus @2.17 @add_new_partner @mozypro @vat
  Scenario: 124316 Add New MozyPro Partner  -- DE -- Monthly -- 32 TB -- VAT -- 10 add on -- CC
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     | vat number   | storage add on | cc number        |
        |   1    |       32 TB | Germany         | MozyPro Germany  | DE812321109  |     10         | 4188181111111112 |
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

  @TC.124317 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124317 Add New MozyPro Partner  -- HU -- Yearly -- 10 GB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | cc number        |
      |   12   |       10 GB | Hungary         | MozyPro France   |  10PERCENTOFFOUTLINE | 4333112111111111 |
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

  @TC.124318 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124318 Add New MozyPro Partner  -- AT -- Yearly -- 250 GB -- Server Plan -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  coupon              | cc number        |
      |   12   |      250 GB | Austria         | MozyPro Ireland  |      yes     |  10PERCENTOFFOUTLINE | 4548181211111124 |
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

  @TC.124319 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124319 Add New MozyPro Partner  -- IE -- Yearly -- 500 GB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | cc number        |
      |   12   |      500 GB | Ireland         | MozyPro Ireland  |  10PERCENTOFFOUTLINE | 4319402211111113 |
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

  @TC.124320 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124320 Add New MozyPro Partner  -- EL -- Yearly -- 2 TB -- Coupon -- HIPAA -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | security | cc number        |
      |   12   |        2 TB | Greece          | MozyPro Germany  |  10PERCENTOFFOUTLINE | HIPAA    | 4532121111111111 |
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

  @TC.124321 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124321 Add New MozyPro Partner  -- SK -- Yearly -- 12 TB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   12   |       12 TB | Slovakia        | MozyPro Ireland  |      yes     | 4544170111111122 |
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

  @TC.124322 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124322 Add New MozyPro Partner  -- DE -- Yearly -- 16 TB -- Coupon -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              |  server plan | cc number        |
      |   12   |       16 TB | Germany         | MozyPro Ireland  |  10PERCENTOFFOUTLINE |      yes     | 4188181111111112 |
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

  @TC.124323 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124323 Add New MozyPro Partner  -- UK -- Yearly -- 24 TB -- Coupon -- HIPAA -- 10 add on -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | security | storage add on | cc number        |
      |   12   |       24 TB | United Kingdom  | MozyPro UK       |  10PERCENTOFFOUTLINE | HIPAA    |     10         | 4916783606275713 |
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

  @TC.124324 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124324 Add New MozyPro Partner  -- MT -- Biennially -- 50 GB -- Server Plan -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  coupon              | cc number        |
      |   24   |       50 GB | Malta           | MozyPro Germany  |      yes     |  10PERCENTOFFOUTLINE | 4313801111111121 |
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

  @TC.124325 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124325 Add New MozyPro Partner  -- PL -- Biennially -- 500 GB -- HIPAA -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     | security | cc number        |
      |   24   |      500 GB | Poland          | MozyPro Germany  | HIPAA    | 4056702111111122 |
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

  @TC.124326 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124326 Add New MozyPro Partner  -- RO -- Biennially -- 4 TB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   24   |        4 TB | Romania         | MozyPro UK       |      yes     | 4493590111111122 |
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

  @TC.124327 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124327 Add New MozyPro Partner  -- FR -- Biennially -- 8 TB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   24   |        8 TB | France          | MozyPro France   |      yes     | 4485393141463880 |
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

  @TC.124328 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124328 Add New MozyPro Partner  -- FI -- Biennially -- 16 TB -- Coupon -- 10 add on -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | storage add on | cc number        |
      |   24   |       16 TB | Finland         | MozyPro Ireland  |  10PERCENTOFFOUTLINE |     10         | 4920111111111112 |
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

  @TC.124329 @bus @2.17 @add_new_partner @mozypro @vat
    Scenario: 124329 Add New MozyPro Partner  -- FR -- Biennially -- 28 TB -- Server Plan -- VAT -- CC
      When I add a new MozyPro partner:
        | period |   base plan | country         | create under     |  server plan | vat number    | cc number        |
        |   24   |       28 TB | France          | MozyPro France   |      yes     | FR08410091490 | 4485393141463880 |
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

  @TC.124330 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124330 Add New MozyPro Partner  -- FI -- Monthly -- 50 GB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   1    |       50 GB | Finland         | MozyPro Ireland  |      yes     | 4920111111111112 |
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

  @TC.124331 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124331 Add New MozyPro Partner  -- UK -- Monthly -- 500 GB -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under | cc number        |
      |   1    |      500 GB | United Kingdom  | MozyPro UK   | 4916783606275713 |
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

  @TC.124332 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124332 Add New MozyPro Partner  -- IE -- Monthly -- 4 TB -- Server Plan -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan |  coupon              | cc number        |
      |   1    |        4 TB | Ireland         | MozyPro Ireland  |      yes     |  10PERCENTOFFOUTLINE | 4319402211111113 |
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

  @TC.124333 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124333 Add New MozyPro Partner  -- FR -- Monthly -- 16 TB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under    |  coupon              | cc number        |
      |   1    |       16 TB | France          | MozyPro France  |  10PERCENTOFFOUTLINE | 4485393141463880 |
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

  @TC.124334 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124334 Add New MozyPro Partner  -- BE -- Monthly -- 28 TB -- 10 add on -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     | storage add on | cc number        |
      |   1    |       28 TB | Belgium         | MozyPro Germany  |     10         | 5413271111111222 |
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

  @TC.124335 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124335 Add New MozyPro Partner  -- EL -- Yearly -- 100 GB -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     | cc number        |
      |   12   |      100 GB | Greece          | MozyPro Ireland  | 4532121111111111 |
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

  @TC.124336 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124336 Add New MozyPro Partner  -- BE -- Yearly -- 1 TB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | cc number        |
      |   12   |        1 TB | Belgium         | MozyPro Ireland  |  10PERCENTOFFOUTLINE | 5413271111111222 |
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

  @TC.124337 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124337 Add New MozyPro Partner  -- NL -- Yearly -- 8 TB -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country      | create under     | cc number        |
      |   12   |        8 TB | Netherlands  | MozyPro Germany  | 5100291111111111 |
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

  @TC.124338 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124338 Add New MozyPro Partner  -- RO -- Yearly -- 20 TB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | cc number        |
      |   12   |       20 TB | Romania         | MozyPro Ireland  |  10PERCENTOFFOUTLINE | 4493590111111122 |
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

  @TC.124339 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124339 Add New MozyPro Partner  -- UK -- Yearly -- 32 TB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under |  coupon              | cc number        |
      |   12   |       32 TB | United Kingdom  | MozyPro UK   |  10PERCENTOFFOUTLINE | 4916783606275713 |
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

  @TC.124340 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124340 Add New MozyPro Partner  -- IE -- Biennially -- 10 GB -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     | cc number        |
      |   24   |       10 GB | Ireland         | MozyPro Ireland  | 4319402211111113 |
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

  @TC.124341 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124341 Add New MozyPro Partner  -- DE -- Biennially -- 250 GB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   24   |      250 GB | Germany         | MozyPro Germany  |      yes     | 4188181111111112 |
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

  @TC.124342 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124342 Add New MozyPro Partner  -- UK -- Biennially -- 2 TB -- Server Plan -- 10 add on -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under |  server plan | storage add on | cc number        |
      |   24   |        2 TB | United Kingdom  | MozyPro UK   |      yes     |     10         | 4916783606275713 |
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

  @TC.124343 @bus @2.17 @add_new_partner @mozypro @coupon
  Scenario: 124343 Add New MozyPro Partner  -- IE -- Biennially -- 12 TB -- Coupon -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  coupon              | cc number        |
      |   24   |       12 TB | Ireland         | MozyPro Germany  |  10PERCENTOFFOUTLINE | 4319402211111113 |
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

  @TC.124344 @bus @2.17 @add_new_partner @mozypro
  Scenario: 124344 Add New MozyPro Partner  -- SE -- Biennially -- 24 TB -- Server Plan -- CC
    When I add a new MozyPro partner:
      | period |   base plan | country         | create under     |  server plan | cc number        |
      |   24   |       24 TB | Sweden          | MozyPro Germany  |      yes     | 4581092111111122 |
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
