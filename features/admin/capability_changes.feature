Feature: Manage admin capability change

  As an Mozy administrator
  I can manage admin's capabilities

  Background:
    Given I log in bus admin console as administrator

  @TC.700 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 700 Check partners list/view check to make sure you can't change the name
#    When I navigate to List Roles section from bus admin console page
#    And I clean all roles with name which started with "$AUTOTEST$"
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I cannot change partner name
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @TC.699 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 699 Check Delete a partner with invalid password
    When I navigate to List Roles section from bus admin console page
    And I clean all roles with name which started with "$AUTOTEST$"
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And Add New Admin success message should be displayed
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I delete partner account with password xxx
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @TC.698 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 698 Check Delete a partner works
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I delete partner account
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @TC.697 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 697 Check partners Delete, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: delete    |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can delete partner
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @TC.696 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 696 Check partners Edit, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: edit      |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I can change partner name
    And I can change fields:
      | fields       |
      | External ID: |
      | Root Role:   |
    Then I can edit partner details fields:
      | fields          |
      | Phone:          |
      | Industry:       |
      | # of employees: |
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @TC.695 @bus @admin @partner_capability_changes @regression @core_function
  Scenario: 695 Check partners Add, List/View capability
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: add       |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
      | Add New Partner        |
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name
