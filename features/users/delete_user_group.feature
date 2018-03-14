Feature: Edit existing user group

  Background:
    Given I log in bus admin console as administrator

  @TC.21003 @bus @2.5 @manage_storage @delete_user_group @bundled @regression @core_function
  Scenario: 21003 [Bundled] Delete User Group with No users
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name              |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Delete User Group |
    Then New partner should be created
    And I act as newly created partner

    And Bundled user groups table should be:
      | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group)  | true | true   | Shared       |            | 0            | 0            |


    When I delete user group details by name: (default user group)
    Then Delete user group error messages should be:
      """
      At least one user group must exist.
      """

    And I add a new Bundled user group:
      | name              | storage_type |
      | TC.21003-Shared-1 | Shared       |
    Then TC.21003-Shared-1 user group should be created

    When I add a new Bundled user group:
      | name                | storage_type | assigned_quota |
      | TC.21003-Assigned-2 | Assigned     | 10             |
    Then TC.21003-Assigned-2 user group should be created


    And I add a new Bundled user group:
      | name               | storage_type | limited_quota |
      | TC.21003-Limited-3 | Limited      | 10            |
    Then TC.21003-Limited-3 user group should be created

    When I add a new Bundled user group:
      | name                | storage_type | assigned_quota |
      | TC.21003-Assigned-5 | Assigned     | 15             |
    Then TC.21003-Assigned-5 user group should be created

    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  |
      | 75 GB     | 25 GB |

    And I navigate to User Group List section from bus admin console page
    When I delete user group details by name: TC.21003-Shared-1
    Then TC.21003-Shared-1 user group should be deleted

    When I delete user group details by name: TC.21003-Assigned-2
    Then TC.21003-Assigned-2 user group should be deleted

    When I delete user group details by name: TC.21003-Limited-3
    Then TC.21003-Limited-3 user group should be deleted

    And I refresh Resource Summary section
    Then Bundled storage summary should be:
      | Available | Used  |
      | 85 GB     | 15 GB |

    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21007 @bus @2.5 @manage_storage @delete_user_group @bundled @regression @core_function
  Scenario: 21007 [Bundled] Delete User Group with users in it

    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name              |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Delete User Group |
    Then New partner should be created
    And I act as newly created partner

    And Bundled user groups table should be:
      | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group)  | true | true   | Shared       |            | 0            | 0            |

    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | (default user group) | TC.21007-1 | Desktop      | 10            | 1       |
    Then 1 new user should be created

    When I add a new Bundled user group:
      | name                | storage_type | assigned_quota | server_support |
      | TC.21007-Assigned-2 | Assigned     | 10             | yes            |
    Then TC.21007-Assigned-2 user group should be created

    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | TC.21007-Assigned-2  | TC.21007-2 | Server       | 10            | 1       |
    Then 1 new user should be created

    When I add a new Bundled user group:
      | name                | storage_type | limited_quota  | server_support |
      | TC.21007-Limited-3  | Limited      | 10             | yes            |
    Then TC.21007-Limited-3 user group should be created

    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | TC.21007-Limited-3   | TC.21007-3 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I refresh Add New User section

    And I navigate to User Group List section from bus admin console page


    When I delete user group details by name: TC.21007-Assigned-2
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """

    When I delete user group details by name: TC.21007-Limited-3
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """

    When I delete user group details by name: (default user group)
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """

    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.21008 @bus @2.5 @manage_storage @delete_user_group @itemized @regression @core_function
  Scenario: 21008 [Itemized] Delete User Group with No users
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                       |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Delete User Group |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner

    And I navigate to User Group List section from bus admin console page

    When I delete user group details by name: (default user group)
    Then Delete user group error messages should be:
      """
      At least one user group must exist.
      """

    And I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | TC.21008-Shared-1 | Shared               | 2               | Shared              | 2              | yes          |
    Then TC.21008-Shared-1 user group should be created

    And I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_devices | desktop_assigned_quota | server_storage_type | server_devices | server_assigned_quota |
      | TC.21008-Assigned-2 | Assigned             | 2               | 10                     | Assigned            | 2              | 10                    |
    Then TC.21008-Assigned-2 user group should be created

    And I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_devices | desktop_limited_quota | server_storage_type | server_devices | server_limited_quota |
      | TC.21008-Limited-3  | Limited              | 2               | 10                    | Limited             | 2              | 10                    |
    Then TC.21008-Limited-3 user group should be created

    And I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_devices | desktop_assigned_quota | server_storage_type | server_devices | server_assigned_quota |
      | TC.21008-Assigned-5 | Assigned             | 1               | 15                     | Assigned            | 1              | 15                    |
    Then TC.21008-Assigned-5 user group should be created

    And I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Used  | Available |
      | 25 GB        | 250 GB        | 25 GB       | 100 GB       | 50 GB | 300 GB    |


    And I navigate to User Group List section from bus admin console page
    When I delete user group details by name: TC.21008-Shared-1
    Then TC.21008-Shared-1 user group should be deleted

    When I delete user group details by name: TC.21008-Assigned-2
    Then TC.21008-Assigned-2 user group should be deleted

    When I delete user group details by name: TC.21008-Limited-3
    Then TC.21008-Limited-3 user group should be deleted

    Then I navigate to Resource Summary section from bus admin console page
    And I refresh Resource Summary section
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Used  | Available |
      | 15 GB        | 250 GB        | 15 GB       | 100 GB       | 30 GB | 320 GB    |

    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21009 @bus @2.5 @manage_storage @delete_user_group @itemized @regression @core_function
  Scenario: 21009 [Itemized] Delete User Group with users in it
      When I add a new MozyEnterprise partner:
        | period | users | server plan | net terms | company name                       |
        | 12     | 10    | 100 GB      | yes       | [Itemized] Delete User Group |
      Then New partner should be created
      And I enable stash for the partner
      And I act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    | Shared              |                   | 0                   | 0                   | 200                  |
    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | (default user group) | TC.21009-1 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_devices | desktop_assigned_quota | server_storage_type | server_devices | server_assigned_quota |
      | TC.21009-Assigned-2 | Assigned             | 2               | 10                     | Assigned            | 2              | 10                    |
    Then TC.21009-Assigned-2 user group should be created
    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | TC.21009-Assigned-2  | TC.21009-2 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_devices | desktop_limited_quota | server_storage_type | server_devices | server_limited_quota |
      | TC.21009-Limited-3  | Limited              | 2               | 10                    | Limited             | 2              | 10                    |
    Then TC.21009-Limited-3 user group should be created
    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | TC.21009-Limited-3   | TC.21009-3 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: TC.21009-Assigned-2
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """
    When I delete user group details by name: TC.21009-Limited-3
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """
    When I delete user group details by name: (default user group)
    Then Delete user group error messages should be:
      """
      All users must be removed from this user group before you can delete it.
      """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
