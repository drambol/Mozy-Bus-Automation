Feature: add edit delete view assign roles

  Background:
    Given I log in bus admin console as administrator

  ###############################################################################

  # List Admin Roles

  ################################################################################

  @TC.801 @TC.802 @TC.803 @TC.804 @bus @admin @tasks_p1
  Scenario: 801 802 803 804 Create a new admin Role and edit admin Role capabilities, add/remove an admin from/to admin role
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | cc number        |
      | 24     | 50 GB     | MozyPro France | France  | 4485393141463880 |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles      | User Group           |
      | Admin_801 | FedID role | (default user group) |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     | Type                            | Parent     |
      | role_801 | <%=@partner.company_info.name%> | FedID role |
    Then Add admin role message will be New role created
    And I navigate to List Roles section from bus admin console page
    Then I can find role role_801 in list roles section
    And I click role role_801 in list roles section to view details
    And I add capabilities for the new role:
      | Capabilities                 |
      | Admins: add/edit/delete      |
      | Backup Health                |
      | Edit billing information     |
      | Download client              |
      | Machines: create/edit/delete |
      | Users: list/view             |
    Then Edit admin role save message will be Changes saved successfully
    And I add admins to an admin role
      | admin     |
      | Admin_801 |
    Then Edit admin role save message will be Changes saved successfully
    And Admins listed in the tab of members of admin role will be
      | admin     |
      | Admin_801 |
    And I remove admins from an admin role
      | admin     |
      | Admin_801 |
    Then Edit admin role save message will be Changes saved successfully
    And Admins listed in the tab of members of admin role will be
      | admin |
      |       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.805 @bus @admin @tasks_p1
  Scenario: 805 Export the Admin Types list to CSV
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 10    | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     | Type                            | Parent     |
      | role_805 | <%=@partner.company_info.name%> | FedID role |
    Then Add admin role message will be New role created
    And I navigate to List Roles section from bus admin console page
    When I click export admin roles to excel button and download the report
    Then The exported admin roles csv file should be like
      | column 1     | column 2            | column 3     | column 4 | column 5 |
      | Name         | Type                | Capabilities | Members  | Partners |
      | FedID role * | @company.name admin | 82           | 1        | 1        |
      | role_805     | @company.name admin | 1            | 0        | 0        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  ###############################################################################

  # Add new role , edit role

  ################################################################################

  @TC.2850 @TC.2851 @TC.2854 @TC.2865 @bus @admin @tasks_p1
  Scenario: 2850 2851 2854 2865 Create and edit a new role - partner admin, Click the search button with nothing in search field
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
    When I navigate to Add New Role section from bus admin console page
    And I add a new role without saving:
      | Name     | Type          | User Group |
      | role_new | Partner admin |            |
    Then config groups search result should be
     | user groups                                                                                                                                   |
     | (default user group);Group 001;Group001;001 Group;Subgroup 0001;Group 100;100 Group;Group 0001;Subgroup001;Subgroup 001;Group 0011;Group00101 |
    And I add a new role:
      | Name     | Type          | User Group |
      | role_new | Partner admin | 001 Group  |
    Then config groups search result should be
      | user groups                                                                                          |
      | 001 Group;Group 0001;Group 001;Group 0011;Group001;Group00101;Subgroup 0001;Subgroup001;Subgroup 001 |
    Then Add admin role message will be New role created
    And The user group value is 001 Group
    And I edit a role without saving
      | User Group |
      |            |
    Then config groups search result should be
      | user groups                                                                                                                                           |
      | (default user group);Group 001;Group001;001 Group;Subgroup 0001;Group 100;100 Group;Group 0001;Subgroup001;Subgroup 001;Group 0011;Group00101;Foo 001 |
    And I edit a role
      | User Group |
      | Group 001  |
    Then config groups search result should be
      | user groups                                                                                          |
      | Group 001;Group001;001 Group;Subgroup 0001;Group 0001;Subgroup001;Subgroup 001;Group 0011;Group00101 |
    Then Edit admin role message will be Changes saved successfully
    And The user group value is Group 001
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2866 @bus @admin @tasks_p1 @smoke
  Scenario: 2866 Create a new role - non partner admin
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      | 12     | 10    | 2 TB        | FedID role | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices | server_storage_type |
      | TC.2866_UG | Shared               | 2               | Shared              |
    Then TC.2866_UG user group should be created
    When I navigate to Add New Role section from bus admin console page
    And I add a new role without saving:
      | Name      | Type                            |
      | role_2866 | <%=@partner.company_info.name%> |
    Then config group field should not be editable and can not do search
    And I save the role
    Then Add admin role message will be New role created
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
