Feature: BUS prodcution env KPI testing without partner creation

  Subscription:
  1. This script amis the key action's perofrmance on production env.
  2. There is no partner creation. All scenarios use exsting "Internal Test" partner.
  3. Set ENV variable "num" between 1 to 5, e.g., export num=0


  Background:
    Given I log in bus admin console as administrator

  @bus_us @TC.KPI001 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - view partner details
    When I search partner by Internal Test - BUS KPI Partner <%=ENV['num']%>
    # in support_steps.rb, transform to exact name according to the ENV['num']
    And I view partner details by Internal Test - BUS KPI Partner <%=ENV['num']%>


  @bus_us @TC.KPI002 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - act as partner
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |


  @bus_us @TC.KPI003 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - create user group
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |
    # step: create a new ug
    And I add a new Bundled user group:
      | name          | storage_type |
      | bus_kpi_alpha | Shared       |
    Then bus_kpi_alpha user group should be created
    # step: view ug details
    And I view user group details by clicking group name: bus_kpi_alpha
    # step: delete ug
    And I delete the user group


  @bus_us @TC.KPI004 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - add new user / view user details / update password
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |
    # step: create new ug
    And I add a new Bundled user group:
      | name  | storage_type |
      | alpha | Shared       |
    # step: create new user
    When I add new user(s):
      | name               | user_group | storage_type |  devices |
      | user without stash | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    # step: view user detail
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    Then user details should be:
      | Name:                       |
      | user without stash (change) |
    # step: update user pwd
    And I update the user password to Test1234
    # step: delete user
    And I delete user
    # step: delete ug
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: alpha
    Then alpha user group should be deleted


  @bus_us @TC.KPI005 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - move user from ug A to ug B
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |
    # step: create two ugs
    When I add a new Bundled user group:
      | name  | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created
    And I add a new Bundled user group:
      | name  | storage_type | limited_quota | enable_stash |
      | omega | Limited      | 5             | yes          |
    Then omega user group should be created
    # step: create user
    When I add new user(s):
      | name               | user_group | storage_type |  devices |
      | user without stash | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    # step: move user from ugA to ugB
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    But I reassign the user to user group omega
    # step: verify user's ug
    Then the user's user group should be omega
    # step: delete user
    And I delete user
    # step: delete ugs
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: alpha
    Then alpha user group should be deleted
    And I delete user group details by name: omega
    Then omega user group should be deleted


  @bus_us @TC.KPI006 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - add new role / add new admin
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |
    # step: create role
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     |
      | new role |
    # step: add capability
    And I check all the capabilities for the new role
    And I close the role details section
    # step: create new admin
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name                | Roles    |
      | admin with new role | new role |
    Then Add New Admin success message should be displayed
    # step: delete admin
    When I search and delete admin admin with new role
    # step: delete role
    And I delete role new role

  @bus_us @TC.KPI007 @fixed_testing_data @prod @KPI
  Scenario: BUS KPI Behavior - create client config
    # step: act as an existing partner
    When I act as partner by:
      | name                                            |
      | Internal Test - BUS KPI Partner <%=ENV['num']%> |
    # step: create client config
    When I create a new client config:
      | name                 |
      | deploy_client_config |
    Then client configuration section message should be Your configuration was saved.
    # step: delete client config
    And I delete configuration deploy_client_config