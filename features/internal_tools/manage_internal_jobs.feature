Feature: Manage Internal Jobs in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122215 @bus @internal_tools @smoke @ROR @ROR_smoke
  Scenario: 122215 Migrate a partner
    When I add a new OEM partner:
      | Root role     | Security | Company Type  |
      | ITOK OEM Root | HIPAA    | Reseller      |
    Then New partner should be created
    And I get the subpartner_id
    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    And Partner general information should be:
      | Pooled Resource: |
      | No               |
    When I navigate to Manage Internal Jobs section from bus admin console page
    And I start job migrate to storage pooling for the partner
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Pooled Resource: |
      | Yes              |
    And I delete partner account
