Feature: partner manage

  As partner administrator
  I want to view a MozyPro or MozyEnterprise customers plan details
  so that I can find out how many users have Sync and how much quota has been Activated and Used by Sync

  Background:
    Given I log in bus admin console as administrator

  @TC.19045 @BSA.3000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19045 MozyEnterprise admin view stash details in list users section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | devices | enable_stash |
      | TC.19045 user1 | (default user group) | Desktop      | 1       | yes          |
      | TC.19045 user2 | (default user group) | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                     | Name           | Sync    | Machines | Storage         | Storage Used           | Created | Backed Up |
      | <%=@new_users[0].email%> | TC.19045 user1 | Enabled | 0        | Desktop: Shared | Desktop: None          | today   | never     |
      | <%=@new_users[1].email%> | TC.19045 user2 | Enabled | 0        | Desktop: Shared | Desktop: None          | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19057 @BSA.3000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19057 22011 MozyPro admin view stash details in list users section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | storage_type | devices | enable_stash |
      | TC.19057.1-user | Desktop      | 1       | yes          |
      | TC.19057.2-user | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                     | Name            | Sync    | Machines | Storage | Storage Used | Created | Backed Up |
      | <%=@new_users[0].email%> | TC.19057.1-user | Enabled | 0        | Shared  | None         | today   | never     |
      | <%=@new_users[1].email%> | TC.19057.2-user | Enabled | 0        | Shared  | None         | today   | never     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19738 @BSA.3000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19738 MozyEnterprise admin view stash details in partner details section
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name             | user_group           | storage_type | devices | enable_stash |
      | TC.19738.1-user1 | (default user group) | Desktop      | 1       | yes          |
      | TC.19738.2-user2 | (default user group) | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 2 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19739 @BSA.3000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19739 22010 MozyPro admin view stash details in partner details section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name            | storage_type | devices | enable_stash |
      | TC.19739.1-user | Desktop      | 1       | yes          |
      | TC.19739.2-user | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 2 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19740 @BSA.3000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19740 22023 Reseller admin view stash details in partner details section
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    #    And I allocate 50 GB Desktop quota with (default user group) user group to Reseller partner
    #Then Reseller resource quota should be changed
    And I add new user(s):
      | name           | user_group           | storage_type | devices | enable_stash |
      | TC.19740-user1 | (default user group) | Desktop      | 1       | yes          |
      | TC.19740-user2 | (default user group) | Desktop      | 1       | yes          |
    Then 2 new user should be created
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Sync Users:            | -1 |
      | Default Sync Storage:  |    |
    And Partner stash info should be:
      | Users:         | 2 |
      | Storage Usage: | 0 |
    And I delete partner account

  @TC.19169 @BSA.3050 @bus @stash @partner_manage @regression @core_function
  Scenario: 19169 MozyPro admin view stash details in manage resources section
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | devices | enable_stash |
      | TC.19169-user | Desktop      | 1       | yes          |
    Then 1 new user should be created
# no Manage Resource now
#    When I navigate to Manage Resources section from bus admin console page
#    And Partner resources general information should be:
#      | Users: | Storage Usage: |
#      | 1            | 0 bytes / 30 GB      |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19056 @BSA.4000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19056 MozyEnterprise admin disable stash in user group view
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.19056-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19056 group | Shared               | 5               | yes          |
    Then TC.19056 group user group should be created
    When I view details of TC.19056-user's user group
    And I disable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | No (change)   |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19123 @BSA.4000 @bus @stash @partner_manage @regression @core_function
  Scenario: 19123 MozyEnterprise admin change default stash quota in user group view
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.19123-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash |
      | TC.19123 group | Shared               | 5               | yes          |
    Then TC.19123 group user group should be created
    When I view details of TC.19123-user's user group
    And I enable stash for the user group
    Then User group details should be:
      | Enable Sync: |
      | Yes (change)  |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18913 @BSA.6000 @bus @stash @partner_manage @regression @core_function @ROR_smoke
  Scenario: 18913 Root admin disable Sync for a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change)  |
    When I disable stash for the partner
    Then Partner general information should be:
      | Enable Sync: |
      | No (change)   |
    When I delete partner account

  @TC.22080 @2.7 @bus @stash @partner_manage @need_test_account @env_dependent @regression @core_function @ROR_smoke
  Scenario: 22080 MozyEnterprise(Fortress tree) admin view stash details in partner detail section
    When I act as partner by:
      | email                                   | including sub-partners |
      | redacted-36090@notarealdomain.mozy.com  | yes                    |
    And I add a new sub partner:
      | Company Name                          |
      | Fortress Test Enable Sync Sub Partner |
    Then New partner should be created
    Then SubPartner general information should be:
      | Status:         | Subdomain:              | Enable Autogrow: | Enable Sync: |  Default Sync Storage: |
      | Active (change) | (learn more and set up) | No               | Yes          |  2 GB                  |
    And SubPartner stash info should be:
      | Users:         | 0     |
      | Storage Usage: | 0 / 0 |
    Then I delete subpartner account
