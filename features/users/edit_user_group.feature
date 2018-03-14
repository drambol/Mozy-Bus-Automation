Feature: Edit existing user group

  Background:
    Given I log in bus admin console as administrator

  @TC.20894 @bus @2.5 @manage_storage @edit_existing_group @bundled @regression
  Scenario: 20894 [Bundled] Edit User Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name              |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Edit User Group |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner
    When I edit (default user group) Bundled user group:
      | storage_type |
      | Shared       |
    Then (default user group) user group should be updated
    When I edit (default user group) Bundled user group:
      | storage_type | limited_quota | enable_stash | server_support |
      | Limited      | 100           | yes          | yes            |
    Then (default user group) user group should be updated
    When I edit (default user group) Bundled user group:
      | storage_type | assigned_quota | enable_stash | server_support |
      | Assigned     | 50             | yes          | no             |
    Then (default user group) user group should be updated
    Then I close edit user group section
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20894 UG | Shared       |
    Then TC.20894 UG user group should be created
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type |
      | TC.20894 UG | Shared       |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type | assigned_quota | enable_stash | server_support |
      | TC.20894 UG | Assigned     | 50             | yes          | yes            |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name        | storage_type  | limited_quota | enable_stash | server_support |
      | TC.20894 UG | Limited       | 100           | no           | yes            |
    Then TC.20894 UG user group should be updated
    When I edit TC.20894 UG Bundled user group:
      | name            |
      | TC.20894 UG New |
    Then TC.20894 UG New user group should be updated
    When I navigate to User Group List section from bus admin console page
  # User group table has an irregular headers, therefore headers verification will be ignored.
    And Bundled user groups table should be:
      | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group)  | true  | false  | Assigned     | 50 GB      | 0            | 0            |
      | TC.20894 UG New       | false | true   | Limited      | 100 GB     | 0            | 0            |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20818 @bus @2.5 @manage_storage @edit_existing_group @itemized @regression
  Scenario: 20818 [Itemized] Edit User Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name               |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Edit User Group |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | server_storage_type |
      | Shared               | Shared              |
    Then (default user group) user group should be updated
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | desktop_limited_quota | enable_stash | server_storage_type | server_limited_quota |
      | Limited              | 250                   | yes          | Limited             | 100                  |
    Then (default user group) user group should be updated
    When I edit (default user group) Itemized user group:
      | desktop_storage_type | desktop_assigned_quota | enable_stash | server_storage_type | server_assigned_quota |
      | Assigned             | 150                    | no           | Assigned            | 50                    |
    Then (default user group) user group should be updated
    Then I close edit user group section
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 5                      | 4               | Assigned            | 10                    | 4              |
    Then TC.20818 UG user group should be created
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | server_storage_type |
      | TC.20818 UG | Shared               | Shared              |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20818 UG | Limited              | 250                   | 4               | Limited             | 100                  | 4              |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 50                     | 4               | yes          | Assigned            | 50                    | 4              |
    Then TC.20818 UG user group should be updated
    When I edit TC.20818 UG Itemized user group:
      | name            |
      | TC.20818 UG New |
    Then TC.20818 UG New user group should be updated
    When I navigate to User Group List section from bus admin console page
    # User group table has an irregular headers, therefore headers verification will be ignored.
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | false | Assigned             | 150 GB             | 0                    | 0                    | 6                     | Assigned            | 50 GB             | 0                   | 0                   | 196                  |
      | TC.20818 UG New      | true  | Assigned             | 50 GB              | 0                    | 0                    | 4                     | Assigned            | 50 GB             | 0                   | 0                   | 4                    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20881  @bus @2.5 @manage_storage @edit_existing_group @bundled @negatice @regression
  Scenario: 20881 [Bundled][Negative] Edit User Group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                        |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Negative] Edit User Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20881 UG | Shared       |
    Then TC.20881 UG user group should be created
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | 101            |
    Then Edit user group error messages should be:
      """
      storage can only be assigned between 0 and 100 GB.
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     |                |
    Then Edit user group error messages should be:
      """
      Assigned Storage Required
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | assigned_quota |
      | TC.20881 UG | Assigned     | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Assigned Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.20881 UG | Limited      | 101           |
    Then Edit user group error messages should be:
      """
      Use between 0 and 100 GB for limited storage.
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.20881 UG | Limited      |               |
    Then Edit user group error messages should be:
      """
      Limited Storage required
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.20881 UG | Limited      | -1            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type | limited_quota |
      | TC.20881 UG | Limited      | 1.5           |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name        | storage_type    | limited_quota |
      | TC.20881 UG | Limited         | hello         |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Limited Storage
      """
    When I edit TC.20881 UG Bundled user group:
      | name | storage_type | limited_quota |
      |      | Limited      | 10            |
    Then Edit user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  # Error messages are not final version, they will be change in the future
  @TC.20829 @bus @2.5 @manage_storage @edit_existing_group @itemized @negative @regression
  Scenario: 20829 [Itemized][Negative] Edit User Group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                       |
      | 12     | 10    | 100 GB      | yes       | [Itemized][Negative] Add New Group |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 2               | Shared              | 2             |
    Then TC.20829 UG  user group should be created
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 11              | Shared              | 201            |
    Then Edit user group error messages should be:
      """
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               |                 | Shared              |                |
    Then Edit user group error messages should be:
      """
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | -1              | Shared              | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | hello           | Shared              | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.20829 UG | Shared               | 1.5             | Shared              | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20829 UG | Limited              | 251                   | 11              | Limited             | 101                  | 201            |
    Then Edit user group error messages should be:
      """
      Use between 0 and 100 GB for Server limited storage.
      Use between 0 and 250 GB for Desktop limited storage.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20818 UG | Limited              |                       |                 | Limited             |                      |                |
    Then Edit user group error messages should be:
      """
      Server Limited Storage required
      Desktop Limited Storage required
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20818 UG | Limited              | -1                    | -1              | Limited             | -1                   | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20818 UG | Limited              | hello                 | hello           | Limited             | hello                | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota | desktop_devices | server_storage_type | server_limited_quota | server_devices |
      | TC.20818 UG | Limited              | 1.5                   | 1.5             | Limited             | 1.5                  | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Limited Storage
      Whole positive integer required for Desktop Limited Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 251                    | 11              | Assigned            | 101                   | 201            |
    Then Edit user group error messages should be:
      """
      Server storage can only be assigned between 0 and 100 GB.
      Desktop storage can only be assigned between 0 and 250 GB.
      Not enough Desktop devices available
      Not enough Server devices available
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             |                        |                 | Assigned            |                       |                |
    Then Edit user group error messages should be:
      """
      Server Assigned Storage Required
      Desktop Assigned Storage Required
      Desktop device count required
      Server device count required
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | -1                     | -1              | Assigned            | -1                    | -1             |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | hello                  | hello           | Assigned            | hello                 | hello          |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | TC.20818 UG | Assigned             | 1.5                    | 1.5             | Assigned            | 1.5                   | 1.5            |
    Then Edit user group error messages should be:
      """
      Whole positive integer required for Server Assigned Storage
      Whole positive integer required for Desktop Assigned Storage
      Whole positive integer required for Desktop device count
      Whole positive integer required for Server device count
      """
    When I edit TC.20829 UG Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      |      | Shared               | 1               | Shared              | 1              |
    Then Edit user group error messages should be:
      """
      Please enter a name
      """
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
