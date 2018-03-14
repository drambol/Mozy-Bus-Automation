Feature: Add a new user group

  Background:
    Given I log in bus admin console as administrator

  @TC.849 @bus2.4 @tasks_p2 @ROR_smoke
  Scenario: 849 Add a new user group
    When I add a new OEM partner:
      | Company Name | Root role         | Security | Company Type     |
      | test_for_849 | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I add a new user group for an itemized partner:
      | name                | server_assigned_quota | desktop_assigned_quota |
      | 849_user_group_test | 3                     | 3                      |
    Then Itemized partner user group 849_user_group_test should be created
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.848 @bus2.4 @tasks_p2
  Scenario: 848 Delete a user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 10    | 100 GB      | FedID role |
    Then New partner should be created
    And I act as newly created partner
    When I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices | server_storage_type |
      | TC.848_group | Shared               | 1               | Shared              |
    Then Itemized user group should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.848_group
    And I delete the user group
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 10                    | Shared              |                   | 0                   | 0                   | 200                  |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20716 @bus @2.5 @manage_storage @add_user_group @bundled @regression @core_function
  Scenario: 20716 [Bundled] Add New Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name            |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Add New Group |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add a new Bundled user group:
      | name            | storage_type |
      | TC.20716-Shared | Shared       |
    Then TC.20716-Shared user group should be created
    When I add a new Bundled user group:
      | name             | storage_type | limited_quota |
      | TC.20716-Limited | Limited      | 50            |
    Then TC.20716-Limited user group should be created
    When I add a new Bundled user group:
      | name              | storage_type | assigned_quota |
      | TC.20716-Assigned | Assigned     | 50             |
    Then TC.20716-Assigned user group should be created
    When I add a new Bundled user group:
      | name              | storage_type | enable_stash | server_support |
      | TC.20716-Shared-1 | Shared       | yes          | yes            |
    Then TC.20716-Shared-1 user group should be created
    When I add a new Bundled user group:
      | name               | storage_type | limited_quota | enable_stash | server_support |
      | TC.20716-Limited-1 | Limited      | 50            | yes          | yes            |
    Then TC.20716-Limited-1 user group should be created
    When I add a new Bundled user group:
      | name                | storage_type | assigned_quota | enable_stash | server_support |
      | TC.20716-Assigned-1 | Assigned     | 50             | yes          | yes            |
    Then TC.20716-Assigned-1 user group should be created
    When I add a new Bundled user group:
      | name               | storage_type |
      | TC.20716%^^&&&%$$# | Shared       |
    Then TC.20716%^^&&&%$$# user group should be created
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Bundled user groups table should be:
    | Group Name           | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
    | (default user group) | true  | true   | Shared       |            | 0            | 0            |
    | TC.20716%^^&&&%$$#   | false | false  | Shared       |            | 0            | 0            |
    | TC.20716-Assigned    | false | false  | Assigned     | 50 GB      | 0            | 0            |
    | TC.20716-Assigned-1  | true  | true   | Assigned     | 50 GB      | 0            | 0            |
    | TC.20716-Limited     | false | false  | Limited      | 50 GB      | 0            | 0            |
    | TC.20716-Limited-1   | true  | true   | Limited      | 50 GB      | 0            | 0            |
    | TC.20716-Shared      | false | false  | Shared       |            | 0            | 0            |
    | TC.20716-Shared-1    | true  | true   | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20899  @bus @2.5 @manage_storage @add_user_group @itemized @regression @core_function
  Scenario: 20899 [Itemized] Add New Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Add New Group |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    When I add a new Itemized user group:
      | name            | desktop_storage_type | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Shared | Shared               | 1               | yes          | Shared              |
    Then TC.20899-Shared user group should be created
    When I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_limited_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Limited | Limited              | 5                     | 1               | yes          | Shared              |
    Then TC.20899-Limited user group should be created
    When I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.20899-Assigned | Assigned             | 5                      | 1               | yes          | Shared              |
    Then TC.20899-Assigned user group should be created
    When I add a new Itemized user group:
      | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20899-Shared-1 | Shared               | 1               | Shared              | 2              |
    Then TC.20899-Shared-1 user group should be created
    When I add a new Itemized user group:
      | name               | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20899-Limited-1 | Limited              | 5                     | 1               | Limited             | 10                   | 2              |
    Then TC.20899-Limited-1 user group should be created
    When I add a new Itemized user group:
      | name                | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20899-Assigned-1 | Assigned             | 5                      | 1               | Assigned            | 10                    | 2              |
    Then TC.20899-Assigned-1 user group should be created
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 0                    | 0                    | 4                     | Shared              |                   | 0                   | 0                   | 194                  |
      | TC.20899-Assigned    | true  | Assigned             | 5 GB               | 0                    | 0                    | 1                     | Shared              |                   | 0                   | 0                   | 0                    |
      | TC.20899-Assigned-1  | false | Assigned             | 5 GB               | 0                    | 0                    | 1                     | Assigned            | 10 GB             | 0                   | 0                   | 2                    |
      | TC.20899-Limited     | true  | Limited              | 5 GB               | 0                    | 0                    | 1                     | Shared              |                   | 0                   | 0                   | 0                    |
      | TC.20899-Limited-1   | false | Limited              | 5 GB               | 0                    | 0                    | 1                     | Limited             | 10 GB             | 0                   | 0                   | 2                    |
      | TC.20899-Shared      | true  | Shared               |                    | 0                    | 0                    | 1                     | Shared              |                   | 0                   | 0                   | 0                    |
      | TC.20899-Shared-1    | false | Shared               |                    | 0                    | 0                    | 1                     | Shared              |                   | 0                   | 0                   | 2                    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20898 @BUG.100010  @bus @2.5 @manage_storage @add_user_group @regression @core_function
  Scenario: 20898 [Bundled][Negative] Add New Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                      |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | 101            |
    Then Add user group error messages should be:
      """
      storage can only be assigned between 0 and 100 GB.
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     |                |
    Then Add user group error messages should be:
      """
      Assigned Storage Required
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | assigned_quota |
      | Assigned     | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | 101           |
    Then Add user group error messages should be:
      """
      Use between 0 and 100 GB for limited storage.
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      |               |
    Then Add user group error messages should be:
      """
      Limited Storage required
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | -1            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | 1.5           |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | storage_type | limited_quota |
      | Limited      | hello         |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I add a new Bundled user group:
      | name | storage_type |
      |      | Limited      |
    Then Add user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20900 @bus @2.5 @manage_storage @add_user_group @regression @core_function
  Scenario: 20900 [Itemized][Negative] Add New Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                       |
      | 12     | 10    | 100 GB      | yes       | [Itemized][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | 11              | Shared              | 201            |
    Then Add user group error messages should be:
      """
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               |                 | Shared              |                |
    Then Add user group error messages should be:
      """
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | -1              | Shared              | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | hello           | Shared              | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | Shared               | 1.5             | Shared              | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | 251                   | 11              | Limited             | 101                  | 201            |
    Then Add user group error messages should be:
      """
      Use between 0 and 100 GB for Server limited storage.
      Use between 0 and 250 GB for Desktop limited storage.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              |                       |                 | Limited             |                      |                |
    Then Add user group error messages should be:
      """
      Server Limited Storage required
      Desktop Limited Storage required
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | -1                    | -1              | Limited             | -1                   | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | hello                 | hello           | Limited             | hello                | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | Limited              | 1.5                   | 1.5             | Limited             | 1.5                  | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | 251                    | 11              | Assigned            | 101                   | 201            |
    Then Add user group error messages should be:
      """
      Server storage can only be assigned between 0 and 100 GB.
      Desktop storage can only be assigned between 0 and 250 GB.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             |                        |                 | Assigned            |                       |                |
    Then Add user group error messages should be:
      """
      Server Assigned Storage Required
      Desktop Assigned Storage Required
      Desktop device count required
      Server device count required
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | -1                     | -1              | Assigned            | -1                    | -1             |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | hello                  | hello           | Assigned            | hello                 | hello          |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | Assigned             | 1.5                    | 1.5             | Assigned            | 1.5                   | 1.5            |
    Then Add user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      |      | Shared               | 1               | Shared              | 1              |
    Then Add user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20713 @bus @2.5 @manage_storage @add_user_group @regression @core_function
  Scenario: 20713 [Bundled] Verify Add New Group UI
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | company name                      |
      | 12     | Silver        | 100            | yes       | [Bundled] Verify Add New Group UI |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes          | no             |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes          | no             |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes          | no             |
    When I change Reseller account plan to:
      | server plan |
      | yes         |
    And the Reseller account plan should be changed
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes          | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes          | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes          | yes            |
    When I stop masquerading
    And I view partner details by newly created partner company name
    And I disable stash for the partner
    And I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no           | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no           | yes            |
    Then I should see correct UI for Bundled user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no           | yes            |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20896 @bus @2.5 @manage_storage @add_user_group @regression @core_function
  Scenario: 20896 [Itemized] Verify Add New Group UI
    When I add a new MozyEnterprise partner:
      | period | users | net terms | company name                       |
      | 12     | 10    | yes       | [Itemized] Verify Add New Group UI |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes           | no             |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes           | no             |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes           | no             |
    When I change MozyEnterprise account plan to:
      | server plan |
      | 100 GB      |
    And the MozyEnterprise account plan should be changed
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | yes           | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | yes           | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | yes           | yes            |
    When I stop masquerading
    And I view partner details by newly created partner company name
    And I disable stash for the partner
    And I act as newly created partner
    And I navigate to Add User Group section
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Shared       | no          | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Limited      | no          | yes            |
    Then I should see correct UI for Itemized user group with:
      | storage_type | enable_stash | server_support |
      | Assigned     | no          | yes            |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name



