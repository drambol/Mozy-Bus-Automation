Feature: Modify credit card information and billing contact information

  Background:
    Given I log in bus admin console as administrator

  @TC.15266 @bus @2.5 @modify @cc @billing_contact_info @regression @core_function
  Scenario: 15266 Verify Change Payment Information Contact Info
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 250 GB    | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    Then Payment billing information should be:
    | Billing Street Address: | Billing City: | Billing State/Province: | Billing Country: | Billing ZIP/Postal Code: | Billing Email    | Billing Phone: |
    | 3401 Hillview Ave       | Palo Alto     | CA                      | United States    | 94304                    | @new_admin_email | 1-877-486-9273 |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15286 @bus @2.5 @modify @cc @billing_contact_info @regression @core_function @ROR_smoke
  Scenario: 15286 Change Payment Information With Credit Card
    When I add a new MozyEnterprise partner:
      | period | users |
      | 36     | 100   |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address               | phone     |
      | This is a new address | 12345678  |
    And I update credit card information to:
      | cc name      | cc number        | expire month | expire year | cvv |
      | newcard name | 4018121111111122 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account billing info should be:
      | address               | phone    | contact name |
      | This is a new address | 12345678 | newcard name |
    And API* Aria account credit card info should be:
      | payment type | last four digits   | expire month | expire year |
      | Credit Card  | 1122               | 12           | 2018        |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15272 @bus @2.5 @modify @cc @billing_contact_info @regression @core_function
  Scenario: 15272 Verify Modify Credit Card Checkbox
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    Then I should able to modify credit card information
    And I should able to view cvv help popup dialog
    And I should able to close cvv help popup dialog
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15273  @bus @2.5 @modify @cc @billing_contact_info @regression @core_function
  Scenario: 15273 Change Payment Information Without Credit Card
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address         | city     | state    | country | zip    | phone    | email         |
      | 333 Songhu Road | Shanghai | Shanghai | China   | 200433 | 12345678 | test@mozy.com |
    And I save payment information changes
    Then Payment information should be updated
    When I wait for 10 seconds
    Then API* Aria account should be:
      | billing_address1 | billing_city | billing_locality | billing_country | billing_zip | billing_intl_phone | billing_email |
      | 333 Songhu Road  | Shanghai     | Shanghai         | CN              | 200433      | 12345678           | test@mozy.com |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15275 @bus @2.5 @modify @cc @billing_contact_info @BUG.96359 @regression @core_function
  Scenario: 15275 Verify Credit Card Required Fields
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name     | cc number        | expire month | expire year | cvv |
      |             | 4018121111111122 | 12           | 19          | 123 |
    And I save payment information changes
    Then Modify credit card error messages should be Please enter the name on your credit card.
    When I update credit card information to:
      | cc name     | cc number        | expire month | expire year | cvv |
      | new name    |                  | 12           | 19          | 123 |
    And I save payment information changes
    Then Modify credit card error messages should be You must enter a credit card number.
    # Verification below is for Production only
    # When I update credit card information to:
    #   | cc name     | cc number        | expire month | expire year | cvv |
    #   | new name    | 4111111111111111 | 12           | 19          |     |
    # And I save payment information changes
    # Then Modify credit card error messages should be Card security code missing.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15459 @bus @2.5 @modify @cc @billing_contact_info @regression @core_function
  Scenario: 15459 Verify Net Terms Customers Cannot Enter a Credit Card Number
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    Then I should not see modify credit card section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15458 @bus @2.5 @modify @cc @billing_contact_info @regression @core_function
  Scenario: 15458 Verify Only the Last Four Digits of Credit Card Number Visible
    When I add a new MozyPro partner:
      | period | base plan | cc number        |
      | 12     | 10 GB     | 4018121111111122 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    Then Credit card number should be XXXX XXXX XXXX 1122
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15376 @bus @2.5 @modify @cc @billing_contact_info @need_test_account @regression @core_function
  Scenario: 15376 Verify OEM Do Not Keep Credit Card
    When I act as partner by:
      | name            | filter  |
      | Muskadel Backup | OEMs    |
    Then I should not see Change Payment Information link

  @TC.19276 @bus @2.5 @modify @cc @billing_contact_info @need_test_account @regression @core_function
  Scenario: 19276 Velocity Partner Do Not Keep Credit Card
    When I act as partner by:
      | name                |
      | Velocity Consulting |
    Then I should not see Change Payment Information link

  @TC.131843 @tasks_p1 @smoke @resources @bus @regression @core_function
  Scenario: 131843 Change credit card using credit card of Visa, MasterCard, American Express, Discover
    When I add a new MozyEnterprise partner:
      | period | users | server add on |
      | 24     | 112   | 39            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    # Visa
    And I update credit card information to:
      | cc name   | cc number        | expire month | expire year | cvv |
      | newcard a | 4018121111111122 | 12           | 32          | 824 |
    And I save payment information changes
    Then Payment information should be updated
    # MasterCard
    And I update credit card information to:
      | cc name   | cc number        | expire month | expire year | cvv |
      | newcard b | 5111991111111121 | 12           | 32          | 404 |
    And I save payment information changes
    Then Payment information should be updated
    # American EXpress
    And I update credit card information to:
      | cc name   | cc number        | expire month | expire year | cvv |
      | newcard c | 372478273181824  | 12           | 32          | 295 |
    And I save payment information changes
    Then Payment information should be updated
    # Discover
    And I update credit card information to:
      | cc name   | cc number         | expire month | expire year | cvv |
      | newcard d | 6011868815065127  | 12           | 32          | 731 |
    And I save payment information changes
    Then Payment information should be updated
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


