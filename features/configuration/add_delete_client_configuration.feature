Feature: Add/Delete Client Configuration

  Background:
    Given I log in bus admin console as administrator

  @TC.123901 @tasks_p1 @client_configuration @bus
  Scenario: 123901 Add more user groups for the client configuration
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123901-group-1 | Shared       | yes            |
    Then TC123901-group-1 user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123901-group-2 | Shared       | yes            |
    Then TC123901-group-2 user group should be created
    When I create a new client config:
      | name                          | type   | user group                        |
      | TC123901-server-client-config | Server | TC123901-group-1,TC123901-group-2 |
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                           | type    | user group                         |
      | TC123901-desktop-client-config | Desktop | TC123901-group-1,TC123901-group-2  |
    Then client configuration section message should be Your configuration was saved.
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be TC123901-server-client-config
    Then Desktop client configuration should be TC123901-desktop-client-config
    And I close the user group detail page
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-2
    And I open Client Configuration tab under user group details
    Then Server client configuration should be TC123901-server-client-config
    Then Desktop client configuration should be TC123901-desktop-client-config
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123904 @tasks_p1 @client_configuration @bus
  Scenario: 123904 Remove more user groups for the client configuration
    When I add a new MozyPro partner:
      | period | base plan | server plan | root role               |
      | 1      | 500 GB    | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123904-group-1 | Shared       | yes            |
    Then TC123904-group-1 user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123904-group-2 | Shared       | yes            |
    Then TC123904-group-2 user group should be created
    When I create a new client config:
      | name                          | type   | user group                         |
      | TC123904-server-client-config | Server | TC123904-group-1,TC123904-group-2  |
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                           | type    | user group                        |
      | TC123904-desktop-client-config | Desktop | TC123904-group-1,TC123904-group-2 |
    Then client configuration section message should be Your configuration was saved.
    When I edit the new created config TC123904-server-client-config
    And I click tab User Groups
    Then I remove user group: TC123904-group-1 from the configuration
    And I remove user group: TC123904-group-2 from the configuration
    Then I save the client configuration changes
    When I edit the new created config TC123904-desktop-client-config
    And I click tab User Groups
    Then I remove user group: TC123904-group-1 from the configuration
    And I remove user group: TC123904-group-2 from the configuration
    Then I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123904-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be None (Inherited defaults from parent partner)
    Then Desktop client configuration should be None (Inherited defaults from parent partner)
    And I close the user group detail page
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123904-group-2
    And I open Client Configuration tab under user group details
    Then Server client configuration should be None (Inherited defaults from parent partner)
    Then Desktop client configuration should be None (Inherited defaults from parent partner)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1338 @tasks_p1 @integration @client_configuration @bus
  Scenario: 1338:Edit a client config (Desktop) scheduling
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan |
      | 24     | 10 GB     | yes       | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                         | type    | automatic max load | automatic min idle | automatic interval |
      | TC1338-desktop-client-config | Desktop | 10                 | 10                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1338-desktop-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load | automatic min idle | automatic interval |
      | 10                 | 10                 | 7:lock             |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1339 @tasks_p1 @integration @client_configuration @bus
  Scenario: 1339 Edit a client config (Server) scheduling
    When I add a new MozyPro partner:
      | period | base plan | storage add on | server plan |
      | 12     | 20 TB     | 35             | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type    | automatic max load | automatic min idle | automatic interval |
      | TC1339-server-client-config | Server  | 10                 | 10                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1339-server-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load | automatic min idle | automatic interval |
      | 10                 | 10                 | 7:lock             |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.489 @tasks_p1 @integration @client_configuration @bus
  Scenario: 489 Set a client config option to Cascade - scheduling tab
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan | net terms | root role  |
      | TC.489_partner    | 12     | 18    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                | type    | automatic max load |
      | TC489-client-config | Desktop | 10:cascade         |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC489-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load |
      | 10:cascade         |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name       |
      | TC.489_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                    | type    |
      | TC489-sub-client-config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC489-sub-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load  | automatic max load editable |
      | 10:cascade          | all disabled                |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.489_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.489_partner

  @TC.501 @tasks_p1 @smoke @client_configuration @bus @ROR_smoke
  Scenario: 501 Delete client configuration
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |  net terms |
      |   1    |  Silver         | 1000           |      yes     |      yes   |
    Then New partner should be created
    And I act as newly created partner account
    When I create a new client config:
      | name                 |
      | TC.501_client_config |
    Then client configuration section message should be Your configuration was saved.
    And I delete configuration TC.501_client_config
    Then client configuration section message should be Client config deleted successfully
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.129688 @tasks_p1 @client_configuration @bus
  Scenario: 129688 VMBU Client Configuration
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    And I add partner settings
      | Name             | Value | Locked |
      | enable_vmbu_beta | t     | false  |
    When I act as newly created partner account
    When I create a new client config:
      | name                     | type   |
      | TC129688-client-config   | Server |
    Then client configuration section message should be Your configuration was saved.
    Then client configuration section warning should be Client configurations only apply to physical machines.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.506 @tasks_p1 @client_configuration @bus
  Scenario: 506 Verify view/edit link at Mac Backup Sets functions properly
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 24     | 1 TB       | yes         |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                     | type   |
      | TC.506-client-config     | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.506-client-config
    And I click tab Mac Backup Sets
    And I create mac backup set
      | mac backup set name   |
      | TC.506_mac_backup_set |
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.506-client-config
    And I click tab Mac Backup Sets
    And I click edit link of mac backup set TC.506_mac_backup_set
    Then mac backup set TC.506_mac_backup_set should be opened
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.450 @tasks_p1 @integration @client_configuration @bus
  Scenario: 450 Create a new moble rule
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 500       | yes         |
    Then New partner should be created
    And I change root role to TestPasswordPolicy
    And I act as newly created partner account
    When I create a new client config:
      | name                 | type    |
      | TC.450_client_config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.450_client_config
    And I click tab Mobile Rules
    And I create mobile rules
      | mobile rules name  | mobile locking |
      | TC.450_mobile_rule | lock           |
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.450_client_config
    And I click tab Mobile Rules
    And I edit the new created mobile rule TC.450_mobile_rule
    Then mobile rules should be:
      | mobile locking |
      | lock           |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name















