Feature: Modify credit card information and billing contact information, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.15266 @ops_env
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

  @TC.15286 @ops_env
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


  @TC.131843 @ops_env
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


