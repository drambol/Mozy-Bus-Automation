Feature: Change Partner Status

  Background:
  Given I log in bus admin console as administrator

  @TC.461 @bus @partner @suspend @cancel @regression @core_function
  Scenario: 461 - Suspend a partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    Then I suspend the partner
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.462 @bus @partner @suspend @cancel @regression @core_function @ROR_smoke
  Scenario: 462 - Activate a partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    Then I suspend the partner
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I activate the partner
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then the new partner admin should be logged in
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account





