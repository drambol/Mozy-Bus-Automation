Feature: Change subscription period

  As a Mozy Administrator
  I want to change my subscription period longer
  so that I can save money on my Mozy subscription and be billed less frequently.

  Background:
    Given I log in bus admin console as administrator

  # This case will fail due to #108559 session is wriong when I stop masqerading
  @TC.15231 @bus @change_period @regression @core_function @ROR_smoke
  Scenario: 15231 MozyPro US - Change Period from Monthly to Yearly - CC
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I delete partner account

  @TC.15232 @bus @change_period @regression @core_function
  Scenario: 15232 MozyPro FR - Change Period from Yearly to Biennially - CC
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | cc number        |
      | 12     | 50 GB     | MozyPro France | France  | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                |
      | Biennial (change) | after 2 years | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial           |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years |                 |                    |
    And I delete partner account

  @TC.15233 @bus @change_period @regression @core_function
  Scenario: 15233 MozyPro PT - Change Period from Monthly to Biennially - CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | country  | cc number        |
      | 1      | 50 GB     | MozyPro Germany | Portugal | 4556581910687747 |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                |
      | Biennial (change) | after 2 years | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | €0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 2 years |                 |                     |
    And I delete partner account

  @TC.15234 @bus @change_period @regression @core_function
  Scenario: 15234 MozyPro IE - Change Period from Biennially to Yearly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | net terms |
      | 24     | 50 GB     | MozyPro Ireland | Ireland | yes       |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                |
      | Yearly (change) | after 2 years | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial  |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%> | Collect On:     | N/A       |
      | Renewal Date:   | after 2 years | Renewal Period: | Yearly    |
      | Next Charge:    | after 2 years |                 |           |
    And I delete partner account

  @TC.15235 @bus @change_period @regression @core_function
  Scenario: 15235 MozyPro UK - Change Period from Yearly to Monthly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under | country        | net terms |
      | 12     | 50 GB     | MozyPro UK   | United Kingdom | yes       |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period           | Date         | Amount                               |
      | Monthly (change) | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
        | Account Type:   | Net Terms 30 | Current Period: | Yearly  |
        | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%> | Collect On:     | N/A     |
        | Renewal Date:   | after 1 year | Renewal Period: | Monthly |
        | Next Charge:    | after 1 year |                 |         |
    And I delete partner account

  @TC.15236 @bus @change_period @regression @core_function
  Scenario: 15236 MozyPro US - Change Period from Biennially to Monthly - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 50 GB     | yes       |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period           | Date          | Amount                               |
      | Monthly (change) | after 2 years | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial    |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>       | Collect On:     | N/A         |
      | Renewal Date:   | after 2 years | Renewal Period: | Monthly     |
      | Next Charge:    | after 2 years |                 |          |
    And I delete partner account

  @TC.15238 @bus @change_period @regression @core_function
  Scenario: 15238 MozyEnterprise - Change Period from Yearly to Biennially - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                 |
      | Biennial (change) | after 2 years | $1,810.00 (Without taxes or discounts) |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | Biennial            |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 2 years |                 |                     |
    And I delete partner account

  @TC.15239 @bus @change_period @regression @core_function
  Scenario: 15239 MozyEnterprise - Change Period from Biennially to 3 Years - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period!
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                  |
      | 3-year (change) | after 3 years | $2,590.00 (Without taxes or discounts)  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | 3-year              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 3 years | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 3 years |                 |                     |
    And I delete partner account

  @TC.15240 @bus @change_period @regression @core_function
  Scenario: 15240 MozyEnterprise - Change Period from Yearly to 3 Years - CC
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period!
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                 |
      | 3-year (change) | after 3 years | $2,590.00 (Without taxes or discounts) |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card   | Current Period: | 3-year              |
      | Unpaid Balance: | $0.00         | Collect On:     | N/A                 |
      | Renewal Date:   | after 3 years | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 3 years |                 |                     |
    And I delete partner account

  @TC.15241 @bus @change_period @regression @core_function
  Scenario: 15241 MozyEnterprise - Change Period from Biennially to Yearly - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 24     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                |
      | Yearly (change) | after 2 years | $950.00 (Without taxes or discounts)  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | Biennial  |
      | Unpaid Balance: | $1,810.00     | Collect On:     | N/A       |
      | Renewal Date:   | after 2 years | Renewal Period: | Yearly    |
      | Next Charge:    | after 2 years |                 |           |
    And I delete partner account

  @TC.15243 @bus @change_period @regression @core_function
  Scenario: 15243 MozyEnterprise - Change Period from 3 Years to Biennially - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account will be switched to biennial billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                 |
      | Biennial (change) | after 3 years | $1,810.00 (Without taxes or discounts) |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | 3-year     |
      | Unpaid Balance: | $2,590.00     | Collect On:     | N/A        |
      | Renewal Date:   | after 3 years | Renewal Period: | Biennially |
      | Next Charge:    | after 3 years |                 |            |
    And I delete partner account

  @TC.15244 @bus @change_period @regression @core_function
  Scenario: 15244 MozyEnterprise - Change Period from 3 Years to Yearly - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 36     | 10    | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account will be switched to yearly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                               |
      | Yearly (change) | after 3 years | $950.00 (Without taxes or discounts) |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Net Terms 30  | Current Period: | 3-year |
      | Unpaid Balance: | $2,590.00     | Collect On:     | N/A    |
      | Renewal Date:   | after 3 year  | Renewal Period: | Yearly |
      | Next Charge:    | after 3 years |                 |        |
    And I delete partner account

  @TC.15245 @bus @change_period @regression @core_function
  Scenario: 15245 Reseller US - Change Period from Monthly to Yearly - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                                                                                                                        |
      | Yearly (change) | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I delete partner account

  @TC.15246 @bus @change_period @regression @core_function
  Scenario: 15246 Reseller US - Change Period from Yearly to Monthly - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Gold          | 100            | yes       |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period           | Date         | Amount                               |
      | Monthly (change) | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30 | Current Period: | Yearly  |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>      | Collect On:     | N/A     |
      | Renewal Date:   | after 1 year | Renewal Period: | Monthly |
      | Next Charge:    | after 1 year |                 |         |
    And I delete partner account

  @TC.15383 @bus @change_period @regression @core_function
  Scenario: 15383 Verify Reseller confirmation message when change period to yearly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of monthly subscription  | <%=@previous_period_partner.billing_info.billing[:total_str]%>   |
      | Charge for new yearly subscription            | <%=@partner.billing_info.billing[:total_str]%>  |
      | Total amount to be charged                    | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:total].to_f - @previous_period_partner.billing_info.billing[:total].to_f)%>  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period          | Date         | Amount                                |
      | Yearly (change) | after 1 year | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15384 @bus @change_period @regression @core_function
  Scenario: 15384 Verify MozyPro confirmation message when change period to biennially
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to biennial billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of monthly subscription  | <%=@previous_period_partner.billing_info.billing[:total_str]%>   |
      | Charge for new biennial subscription          | <%=@partner.billing_info.billing[:total_str]%>  |
      | Total amount to be charged                    | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:total].to_f - @previous_period_partner.billing_info.billing[:total].to_f)%>  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                |
      | Biennial (change) | after 2 years | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15385 @bus @change_period @regression @core_function
  Scenario: 15385 Verify MozyEnterprise confirmation message when change period to 3 years
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to 3-year billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from yearly to 3-year billing?
      If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new 3-year subscription beginning today.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount   |
      | Credit for remainder of yearly subscription   | $95.00   |
      | Charge for new 3-year subscription            | $259.00  |
      | Total amount to be charged                    | $164.00  |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    Then Next renewal info table should be:
      | Period          | Date          | Amount                                |
      | 3-year (change) | after 3 years | $259.00 (Without taxes or discounts)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.124561 @bus @change_period @regression @core_function
  Scenario: 124561 Reseller UK - Change Period from Yearly to Monthly - CC
    When I add a new Reseller partner:
      | period | create under | country        | reseller type | reseller quota | cc number        |
      | 12     | MozyPro UK   | United Kingdom | Gold          | 800            | 4916783606275713 |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                                                                                                                         | Payment Type                  |
      | Yearly (change)   | after 1 year | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   | Visa ending in @XXXX (change) |
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Monthly (change)  | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%>        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Monthly    |
      | Next Charge:    | after 1 year |                 |            |
    And I search and delete partner account by newly created partner company name


  @TC.124562 @bus @change_period @regression @core_function
  Scenario: 124562 Reseller DE - Change Period from Monthly to Yearly - Net Terms
    When I add a new Reseller partner:
      | period | create under    | country | reseller type | reseller quota | server plan | net terms |
      | 1      | MozyPro Germany | Germany | Silver        | 800            |     yes     |    yes    |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                                                                                                                         |
      | Monthly (change)  | after 1 month | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   |
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Yearly (change)   | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30 | Current Period: | Yearly  |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>      | Collect On:     | N/A     |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I search and delete partner account by newly created partner company name


  @TC.124709 @TC.124563 @bus @change_period @regression @core_function
  Scenario: 124709 124563 Reseller FR - Change Period from Monthly to Yearly - VAT - CC
    When I add a new Reseller partner:
      | period | create under   | country | reseller type | reseller quota | server plan |    vat number   | cc number        |
      | 1      | MozyPro France | France  | Platinum      | 800            |     yes     |   FR08410091490 | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                                                                                                                         | Payment Type                  |
      | Monthly (change)  | after 1 month | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   | Visa ending in @XXXX (change) |
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Yearly (change)   | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I search and delete partner account by newly created partner company name

  @TC.124564 @bus @change_period @regression @core_function
  Scenario: 124564 Reseller BE - Change Period from Yearly to Monthly - VAT - Net Terms
    When I add a new Reseller partner:
      | period | create under    | country | reseller type | reseller quota | server plan |    vat number   |  net terms |
      | 12     | MozyPro Ireland | France | Platinum      | 800            |     yes     |   FR08410091490 |     yes    |
#      | 12     | MozyPro Ireland | Belgium | Platinum      | 800            |     yes     |   BE0883236072 |     yes    |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                                                                                                                         |
      | Yearly (change)   | after 1 year  | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   |
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Monthly (change)  | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30 | Current Period: | Yearly  |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>      | Collect On:     | N/A     |
      | Renewal Date:   | after 1 year | Renewal Period: | Monthly |
      | Next Charge:    | after 1 year |                 |         |
    And I search and delete partner account by newly created partner company name



  @TC.124565 @bus @change_period @regression @core_function
  Scenario: 124565 MozyPro FR - Change Period from Monthly to Yearly - VAT - CC
    When I add a new MozyPro partner:
      | period | create under   | country | base plan | server plan |    vat number   | cc number        |
      | 1      | MozyPro France | France  | 50 GB     |     yes     |   FR08410091490 | 4485393141463880 |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                                                                                                                         | Payment Type                  |
      | Monthly (change)  | after 1 month | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   | Visa ending in @XXXX (change) |
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Yearly (change)   | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:zero]%> | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I search and delete partner account by newly created partner company name

  @TC.124710 @TC.124566 @bus @change_period @regression @core_function
  Scenario: 124710 124566 MozyPro IT - Change Period from Yearly to Monthly - VAT - Net Terms
    When I add a new MozyPro partner:
      | period | create under    | country | base plan | server plan |    vat number   |  net terms |
      | 12     | MozyPro Germany | Italy   | 50 GB     |     yes     |   IT03018900245 |     yes    |
    And the sub-total before taxes or discounts should be correct
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period            | Date          | Amount                                                                                                                                         |
      | Yearly (change)   | after 1 year  | <%=format_price(@partner.billing_info.billing[:currency],@partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>   |
    And I change account subscription to monthly billing period!
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    Then Next renewal info table should be:
      | Period            | Date         | Amount                                |
      | Monthly (change)  | after 1 year | <%=format_price(@next_period_partner.billing_info.billing[:currency],@next_period_partner.billing_info.billing[:pre_all_subtotal])+" (Without taxes or discounts)"%>  |
    When I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then New Partner internal billing should be:
      | Account Type:   | Net Terms 30 | Current Period: | Yearly  |
      | Unpaid Balance: | <%=@partner.billing_info.billing[:total_str]%>      | Collect On:     | N/A     |
      | Renewal Date:   | after 1 year | Renewal Period: | Monthly |
      | Next Charge:    | after 1 year |                 |         |
    And I search and delete partner account by newly created partner company name
