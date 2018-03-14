Feature: Bin Check

  Background:
    Given I log in bus admin console as administrator

  @TC.125418 @bin_check @tasks_p2 @bus
  Scenario: 125418 MozyPro BUS signup billing country Not same as credit card country us_fr
    When I add a new MozyPro partner:
      | period | base plan | country       | cc number        |
      | 12     | 20 TB     | United States | 4485393141463880 |
    Then Aria payment error message should be Could not validate payment information.

  @TC.125417 @bin_check @tasks_p2 @bus
  Scenario: 125417 MozyPro BUS signup billing country same as credit card country uk_uk
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan | cc number         |
      | 24     | 1 TB      | United Kingdom | yes         | 4916783606275713  |
    Then New partner should be created
    And I delete partner account

  @TC.125422 @bin_check @tasks_p2 @bus
  Scenario: 125422 MozyPro change credit card billing country same as credit card country us_us
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan |  cc number         |
      | 1      | 50 GB     | United States  | yes         |  4111111111111111  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name |4916655952145825  | 12           | 18          | 123 |
    And I save payment information changes with default password
    Then Payment information should be updated
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125427 @bin_check @tasks_p2 @bus
  Scenario: 125427 MozyPro change credit card billing country Not same as credit card country fr_uk
    When I add a new MozyPro partner:
      | period | base plan | country | storage add on |  cc number         |
      | 1      | 8 TB      | France  | 99             |  4485393141463880  |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4916783606275713 | 12           | 18          | 123 |
    And I save payment information changes with default password
    Then Modify credit card error messages should be Could not validate payment information.
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  # existing bug #130188
  @TC.125431 @bin_check @tasks_p2 @bus
  Scenario: 125431 BUS admin change credit card billing country same as credit card country uk_uk
    When I add a new MozyPro partner:
      | period | base plan | country | vat number    | cc number        |
      | 24     | 10 GB     | France  | FR08410091490 | 4485393141463880 |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | country          | state |
      | United Kingdom   | UKS   |
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4916783606275713 | 12           | 18          | 123 |
    And I save payment information changes with Standard password
    Then Payment information should be updated
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.125432 @bin_check @tasks_p2 @bus
  Scenario: 125432 BUS admin change credit card billing country Not same as credit card country us_fr
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 18    | 500 GB      |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4485393141463880 | 12           | 18          | 123 |
    And I save payment information changes with Standard password
    Then Modify credit card error messages should be Could not validate payment information.
    And I stop masquerading
    And I search and delete partner account by newly created partner company name





