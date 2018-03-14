Feature: VMBU On Boarding admin console

  Background:
    Given I log in bus admin console as administrator

  @TC.130707 @vmbu @tasks_p2 @bus
  Scenario: 130707 VMBU Tooltip MozyPro
    When I set initial purchase and base plan for specified company type
      | company type | period | base plan |
      | MozyPro      | 12     | 1 TB      |
    Then MozyPro VMBU tool tip should appear next to the Server Add Ons

  @TC.130708 @vmbu @tasks_p2 @bus
  Scenario: 130708 VMBU Tooltip MozyEnterprise
    When I set initial purchase and base plan for specified company type
      | company type    | period | server plan | users |
      | MozyEnterprise  | 36     | 2 TB        | 100   |
    Then MozyEnterprise VMBU tool tip should appear next to the Server Add Ons

  @TC.130706 @vmbu @tasks_p2 @bus
  Scenario: 130706 VMBU: Account Creation Language
    When I add a new MozyEnterprise partner:
      | period | server plan  | users | net terms |
      | 24     | 500 GB       | 18    | yes       |
    Then New partner should be created
    And I add partner settings
      | Name             | Value     |
      | enable_vmbu_beta | t         |
    And I act as newly created partner account
    And I navigate to Client Configuration section from bus admin console page
    Then client configuration section warning should be Client configurations only apply to physical machines.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name




