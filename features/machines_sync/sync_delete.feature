Feature: Sync Delete

  Background:
    Given I log in bus admin console as administrator

  @TC.123398 @bus @machines_sync @tasks_p1
  Scenario: 123398 Restore Sync Machine
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | devices | enable_stash |
      | TC.123398-user1 | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update Sync used quota to 20 GB
    When I click delete sync device icon for the user
    Then Popup window message should be Would you like to keep the data for this instance of Sync?
    And I click Yes button on popup window
    And I refresh User Details section
    Then The sync device should be deleted
    When I refresh User Details section
    And I enable stash without send email in user details section
    And I refresh User Details section
    Then user details should be:
      | Name:                    | Enable Sync:                |
      | TC.123398-user1 (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update    | Action |
      | Sync           | 0 / 100 GB     | Set                  | < a minute ago |        |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19065 @bus @machines_sync @tasks_p1
  Scenario: 19065 Reseller Partner Delete Stash container using the Delete link (Custom User Group Email)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    And I add a new Bundled user group:
      | name       | storage_type | enable_stash |
      | sync_group | Shared       | yes          |
    Then sync_group user group should be created
    And I add new user(s):
      | name           | user_group | storage_type | devices | enable_stash |
      | TC.19065-user1 | sync_group | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I click delete sync device icon for the user
    Then Popup window message should be Would you like to keep the data for this instance of Sync?
    And The button displayed on the pop up are Yes No Cancel
    And I click Cancel button on popup window
    And I refresh User Details section
    Then The sync device should not be deleted
    When I click delete sync device icon for the user
    And I click Yes button on popup window
    And I refresh User Details section
    Then The sync device should be deleted
    Then User search results should be:
      | User                   | Name           | Sync     | Machines | Storage | Storage Used | Created | Backed Up |
      | <%=@users.last.email%> | TC.19065-user1 | Disabled | 0        | Shared  | None         | today   | never     |
    When I refresh User Details section
    Then user details should be:
      | Name:                   | Enable Sync:  |
      | TC.19065-user1 (change) | No (Add Sync) |
    And I navigate to User Group List section from bus admin console page
    When I view user group details by clicking group name: sync_group
    Then User group users list details should be:
      | Name           | Sync     | Machines | Storage | Storage Used |
      | TC.19065-user1 | Disabled | 0        | Shared  | None         |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 0 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.18988 @bus @machines_sync @tasks_p1 @smoke
  Scenario: 18988 MozyPro partner delete stash container in user details section
    When I add a new MozyPro partner:
      | period | base plan | net terms | root role               |
      | 12     | 50 GB     | yes       | Bundle Pro Partner Root |
    Then New partner should be created
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 0 |
      | Storage Usage: | 0 |
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.18988_user | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.18988_user (change) | Yes (Send Invitation Email) |
    When I click delete sync device icon for the user
    Then Popup window message should be Would you like to keep the data for this instance of Sync?
    And The button displayed on the pop up are Yes No Cancel
    And I click Cancel button on popup window
    And I refresh User Details section
    Then The sync device should not be deleted
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 10 GB          | Set                  | N/A              |
    When I click delete sync device icon for the user
    And I click Yes button on popup window
    And I refresh User Details section
    Then The sync device should be deleted
    Then User search results should be:
      | User                   | Name          | Sync     | Machines | Storage         | Storage Used | Created | Backed Up |
      | <%=@users.last.email%> | TC.18988_user | Disabled | 0        | 10 GB (Limited) | None         | today   | never     |
    When I refresh User Details section
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.18988_user (change) | No (Add Sync) |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19108 @bus @machines_sync @tasks_p1
  Scenario: 19108 MozyEnterprise Partner Delete Stash container using the Delete link
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | enable_stash | server_storage_type |
      | TC.19108_UG | Shared               | 3               | yes          | Shared              |
    Then TC.19108_UG user group should be created
    And I add new user(s):
      | name           | user_group | storage_type | devices | enable_stash |
      | TC.19108-user1 | 19108_UG   | Desktop      | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I click delete sync device icon for the user
    Then Popup window message should be Would you like to keep the data for this instance of Sync?
    And The button displayed on the pop up are Yes No Cancel
    And I click Cancel button on popup window
    And I refresh User Details section
    Then The sync device should not be deleted
    When I click delete sync device icon for the user
    And I click Yes button on popup window
    And I refresh User Details section
    Then The sync device should be deleted
    Then User search results should be:
      | User                   | Name           | Sync     | Machines | Storage          | Storage Used  | Created | Backed Up |
      | <%=@users.last.email%> | TC.19108-user1 | Disabled | 0        | Desktop: Shared  | Desktop: None | today   | never     |
    When I refresh User Details section
    Then user details should be:
      | Name:                   | Enable Sync:  |
      | TC.19108-user1 (change) | No (Add Sync) |
    And I navigate to User Group List section from bus admin console page
    When I view user group details by clicking group name: TC.19108_UG
    Then User group users list details should be:
      | Name           | Sync     | Machines | Storage         | Storage Used  |
      | TC.19108-user1 | Disabled | 0        | Desktop: Shared | Desktop: None |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 0 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19020 @bus @machines_sync @tasks_p1
  Scenario: 19020 Delete sync container and storage will be allocated to the user
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    When I add a new Bundled user group:
      | name        | storage_type | limited_quota | enable_stash |
      | TC.19020_UG | Limited      | 50            | yes          |
    Then TC.19020_UG user group should be created
    When I add new user(s):
      | name           | user_group  | storage_type | storage_limit | devices | enable_stash |
      | TC.19020-user1 | TC.19020_UG | Desktop      | 50            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update Sync used quota to 20 GB
    When I refresh User Details section
    Then user resources details rows should be:
      | Storage                      |
      | 20 GB Used / 30 GB Available |
    When I click delete sync device icon for the user
    And I click Yes button on popup window
    When I refresh User Details section
    Then The sync device should be deleted
    And user resources details rows should be:
      | Storage                  |
      | 0 Used / 50 GB Available |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name