Feature: User group stash setting management

  As a Mozy customer admin
  I want to turn-on Sync for a new user group
  so that I can add Sync to the users within that group

  Background:
    Given I log in bus admin console as administrator

  @TC.19001 @BSA.2000 @bus @stash @regression @core_function
  Scenario: 19001 Add default stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19001 group | Shared               | 5               | yes          |
    Then TC.19001 group user group should be created
    And I add new user(s):
      | name            | user_group     | storage_type | devices |
      | TC.19001.1-user | TC.19001 group | Desktop      | 1       |
    Then 1 new user should be created
    When I view details of TC.19001.1-user's user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19004 @BSA.2000 @bus @stash @regression @core_function
  Scenario: 19004 Add custom stash storage for a new user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 10    | yes       |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19004 group | Shared               | 5               | yes          |
    Then TC.19004 group user group should be created
    And I add new user(s):
      | name            | user_group     | storage_type | devices |
      | TC.19004.1-user | TC.19004 group | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19004.1-user's user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19005 @BSA.2010 @bus @stash @regression @core_function
  Scenario: 19005 No Enable sync for all users settings in user group edit page when stash is disabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices |
      | TC.19005.1-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Bundled user group:
      | name | storage_type |
      | Test | Shared       |
    Then Test user group should be created
    When I view details of TC.19005.1-user's user group
    When I disable stash for the user group
    Then I should not see Enable sync for all users text on user group details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19006 @BSA.2010 @bus @stash @regression @core_function
  Scenario: 19006 Existing user groups are enabled when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | false  | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19007 @BSA.2010 @bus @stash @regression @core_function
  Scenario: 19007 22054 Modify default stash storage quota for a user group in user group edit page when stash is enabled for partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Platinum      | 100            |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19007.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add a new Bundled user group:
      | name | storage_type |
      | Test | Shared       |
    Then Test user group should be created
    When I view details of TC.19007.1-user's user group
    And I enable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19008 @BSA.2020 @bus @stash @regression @core_function
  Scenario: 19008 Disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19008.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    |
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19008.1-user's user group
    And I disable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | No (change)   |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | false | Shared               |                    | 0                    | 0                    | 5                     |
      | Test                 | false | Shared               |                    | 0                    | 0                    | 5                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19009 @BSA.2020 @bus @stash @regression @core_function
  Scenario: 19009 Cancel disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19009.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    |
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19009.1-user's user group
    And I cancel disable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 5                     |
      | Test                 | false | Shared               |                    | 0                    | 0                    | 5                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19010 @BSA.2020 @bus @stash @regression @core_function
  Scenario: 19010 User has not stash when disable stash for a user group in user group detail section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19010.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19010.1-user's user group
    And I disable stash for the user group
    And I refresh User Details section
    Then I should not see Enable Sync: setting on user details section
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19011 @BSA.2030 @bus @stash @regression @core_function
  Scenario: 19011 Add stash to all users for 0 user in the user group when stash is enabled for partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I try to add stash to all users for the partner
    Then Popup window message should be Nothing was changed. All users in this partner already have sync.
    And I click Close button on popup window
    And I search and delete partner account by newly created partner company name

  @TC.19012 @BSA.2030 @bus @stash @regression @core_function
  Scenario: 19012 A user is enabled with stash I can enable stash for other 2 users in the user group at once
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19012.1-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.19012.2-user | (default user group) | Desktop      | 1       | no           |
      | TC.19012.3-user | (default user group) | Desktop      | 1       | no           |
    Then 2 new user should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices |
      | Test | Shared               | 5               |
    Then Test user group should be created
    When I view details of TC.19012.1-user's user group
    And I enable stash for all users
#    Then Popup window message should be Do you want to enable sync for all 2 users?
#    When I click Yes button on popup window
    And I refresh User Group Details section
    Then User group users list details should be:
    | Name            | Sync    | Machines | Storage         | Storage Used  |
    | TC.19012.3-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    | TC.19012.2-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    | TC.19012.1-user | Enabled | 0        | Desktop: Shared | Desktop: None |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

