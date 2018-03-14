Feature: network domain

  Background:
    Given I log in bus admin console as administrator

  @TC.2826 @TC.2836 @TC.122224 @bus @configurations @tasks_p2 @ROR_smoke
  Scenario: 2826 2836 122224:Create Edit a new network domain click search button with nothing input
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 001 | Shared       |
    Then Group 001 user group should be created
    When I add a new Bundled user group:
      | name     | storage_type |
      | Group001 | Shared       |
    Then Group001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 001 Group | Shared       |
    Then 001 Group user group should be created
    And I add a new Bundled user group:
      | name          | storage_type |
      | Subgroup 0001 | Shared       |
    Then Subgroup 0001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | Group 100 | Shared       |
    Then Group 100 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 100 Group | Shared       |
    Then 100 Group user group should be created
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 0001 | Shared      |
    Then Group 0001 user group should be created
    When I add a new Bundled user group:
      | name        | storage_type |
      | Subgroup001 | Shared       |
    Then Subgroup001 user group should be created
    When I add a new Bundled user group:
      | name         | storage_type |
      | Subgroup 001 | Shared       |
    Then Subgroup 001 user group should be created
    And I add a new Bundled user group:
      | name       | storage_type |
      | Group 0011 | Shared       |
    Then Group 0011 user group should be created
    When I add a new Bundled user group:
      | name       | storage_type |
      | Group00101 | Shared       |
    Then Group00101 user group should be created
    When I add a new Bundled user group:
      | name    | storage_type |
      | Foo 001 | Shared       |
    Then Foo 001 user group should be created
    When I navigate to Network Domains section from bus admin console page
    And I add a network domain without saving
      | User Group |
      |            |
    Then user groups search result should be
      | user groups                                                                                                                                   |
      | (default user group);Foo 001;Group 001;Group001;001 Group;Subgroup 0001;Group 100;100 Group;Group 0001;Subgroup001;Subgroup 001;Group 0011;Group00101 |
    And I add a network domain
      | Domain GUID   | Alias   | OU   | User Group |
      | auto_generate | domain1 | unit | 001 Group  |
    Then user groups search result should be
      | user groups                                                                                          |
      | 001 Group;Group 0001;Group 001;Group 0011;Group001;Group00101;Subgroup 0001;Subgroup001;Subgroup 001 |
    Then Add network domain message will be Domain added successfully.
    And Existing network domain record should be
      | Alias   | Domain                     | OU   | User Group |
      | domain1 | <%=@network_domain.guid%>  | unit | 001 Group  |
    And I click edit network domain button
    And I update a network domain
      | Domain GUID   | Alias   | OU    | User Group |
      | auto_generate | domain2 | unit1 | 100 Group  |
    Then user groups search result should be
      | user groups         |
      | Group 100;100 Group |
    Then Edit network domain message will be Domain updated successfully.
    And Existing network domain record should be
      | Alias   | Domain                    | OU    | User Group |
      | domain2 | <%=@network_domain.guid%> | unit1 | 100 Group  |
    And I remove the network domain record
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name