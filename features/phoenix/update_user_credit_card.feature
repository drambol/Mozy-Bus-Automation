Feature: MozyHome user update credit card in phoenix

  As a private citizen
  I want to update my credit card through phoenix


  @TC.131678 @regression_test @phoenix
  Scenario: 131678 update credit card - us to us in change_credit_card page
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4111111111111111 |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 5555555555554444 | MasterCard  |
    And user credit card updated successfully

    # American Express card requires 4 digit cvv
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type      | cvv  |
      | 378282246310005  | American Express | 8372 |
    And user credit card updated successfully

    # update cvv to 3 digits so that Discover and Visa use the 3 digits cvv
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | cvv  |
      | 6011111111111117 | Discover    | 736  |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 4018121111111122 | Visa        |
    And user credit card updated successfully

  @TC.131705 @TC.131758 @regression_test @phoenix @ip_country=INV
  Scenario: 131705 update credit card - us to uk to fr in change_credit_card_and_country page
  When I am at dom selection point:
  And I add a phoenix Home user:
    | period | base plan | country       | billing country | cc number        |
    | 1      | 50 GB     | United States | United States   | 4018121111111122 |
  Then the billing summary looks like:
    | Description                           | Price | Quantity | Amount |
    | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
    | Total Charge                          |       |          | $5.99  |
  Then the user is successfully added.
  And the user has activated their account
  When I login as the user on the account.

  And I change my profile attributes to:
    | new_cc_num       |
    | 4916783606275713 |
  Then billing details page error message should be:
  """
   The billing country you provided does not match the country of the bank which issued your credit card.
  """

  And I change my profile attributes to:
    | new_cc_num       | billing country |
    | 4916783606275713 | United Kingdom  |
  Then billing details page error message should be:
  """
   The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence. Click here to update your country of residence
  """

  And I change credit card and country from bin country not match error link:
    | profile country | billing country | cc number        | new_cc_type |
    | United Kingdom  | United Kingdom  | 4916783606275713 | Visa        |
  And user credit card updated successfully

  And I change my profile attributes to:
    | new_cc_num       |
    | 4485393141463880 |
  Then billing details page error message should be:
  """
   The billing country you provided does not match the country of the bank which issued your credit card.
  """

  And I change my profile attributes to:
    | new_cc_num       | billing country |
    | 4485393141463880 | France          |
  Then billing details page error message should be:
  """
   The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence. Click here to update your country of residence
  """

  And I change my profile attributes to:
    | new_profile_country |
    | France              |

  And user profile page error message should be:
  """
   The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence. Click here to update your country of residence
  """

  And I change credit card and country from bin country not match error link:
    | profile country | billing country | cc number        | new_cc_type |
    | France          | France          | 4485393141463880 | Visa        |
  And user credit card updated successfully

  @TC.131771 @regression_test @phoenix
  Scenario: 131771 update credit card - uk to uk in change_credit_card page
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        | type       |
      | 12     | 50 GB     | United Kingdom | United Kingdom  | 6759411100000008 | Maestro UK |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price              | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual  | £54.89\n(inc. VAT) | 1        | £54.89 |
      | Subscription Price                    |                    |          | £45.74 |
      | VAT Rate (20%)                        |                    |          | £9.15  |
      | Total Charge                          |                    |          | £54.89 |
    Then the user is successfully added.
    And the user has activated their account
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 4916783606275713 | Visa        |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num          | new_cc_type |
      | 6759560045005727054 | Maestro UK  |
    And user credit card updated successfully

    And I change my profile attributes to:
      | new_cc_num       | new_cc_type |
      | 5641821111166669 | Maestro UK  |
    And user credit card updated successfully

