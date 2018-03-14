Feature: Manage Pending Deletes in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.121739 @bus @ldap_connectors @tasks_p3
  Scenario: 121739: Add New Version of LDAP Connector successfully
    When I navigate to Manage LDAP Connectors section from bus admin console page
    And I would like to add a new version:
      | version | platform | OS Architecture | status | file name         |
      | 1.0.1   | windows  | 32              | active | FakeWinClient.exe |
    And I should see the new added client version
    And I delete the new added LDAP Connector version
    Then the new added version should be removed
    And I would like to add a new version:
      | version  | platform | OS Architecture | status | file name             |
      | 1.4.1.57 | windows  | 32              | active | FakeWinSyncClient.exe |
    And I should see the new added client version
    And I delete the new added LDAP Connector version
    Then the new added version should be removed
    And I would like to add a new version:
      | version | platform | OS Architecture | status | file name             |
      | ~-_     | windows  | 32              | active | FakeWinSyncClient.exe |
    And I should see the new added client version
    And I delete the new added LDAP Connector version
    Then the new added version should be removed

  @TC.121740 @bus @ldap_connectors @tasks_p3
  Scenario: 121740: Update LDAP Connector version with a new Installation File successfully
    When I navigate to Manage LDAP Connectors section from bus admin console page
    And I would like to add a new version:
      | version | platform | OS Architecture | status | file name         |
      | 1.0.2   | windows  | 32              | active | FakeWinClient.exe |
    And I should see the new added client version
    Then I edit the client installation file:
      | file name         |
      | FakeMacClient.dmg |
    And I should see the installation file is updated successfully
    Then I delete the new added LDAP Connector version
    And the new added version should be removed

  @TC.121741 @bus @ldap_connectors @tasks_p3
  Scenario: 121741: Update LDAP Connector version from active to to-be-deprecated and vise versa
    When I navigate to Manage LDAP Connectors section from bus admin console page
    And I would like to add a new version:
      | version | platform | OS Architecture | status | file name         |
      | 1.0.3   | windows  | 32              | active | FakeWinClient.exe |
    And I should see the new added client version
    Then I edit the client status:
      | status           |
      | to-be-deprecated |
    And I should see the new client version status is updated successfully
    Then I edit the client status:
      | status |
      | active |
    And I should see the new client version status is updated successfully
    Then I delete the new added LDAP Connector version
    And the new added version should be removed

