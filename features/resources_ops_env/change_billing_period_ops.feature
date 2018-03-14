Feature: Change subscription period, running on ops env (pantheon / staging)

  Subscription:
   - As a Mozy Administrator
   - I want to change my subscription period longer
   - so that I can save money on my Mozy subscription and be billed less frequently.

  Background:
    Given I log in bus admin console as administrator

  # This case will fail due to #108559 session is wriong when I stop masqerading
  @TC.15231 @ops_env
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

  @TC.15232 @ops_env
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


  @TC.15241 @ops_env
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


  @TC.124565 @ops_env
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