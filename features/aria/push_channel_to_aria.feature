Feature: Push Channel To Aria

  Background:
   Given I log in bus admin console as administrator

  @TC.22130 @bus @aria @tasks_p2 @ROR_smoke
  Scenario: 22130 Script Migrate - push channel to aria
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 4 TB      | yes       |
    Then New partner should be created
    And I get partner aria id
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy Inc. (US)
    When I expand contact info from partner details section
    And I change the partner contact information to:
      | Contact Country: |
      | France           |
    Then Partner contact information is changed
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy International Limited (Ireland)
    When I expand contact info from partner details section
    And I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy Inc. (US)
    And I delete partner account

