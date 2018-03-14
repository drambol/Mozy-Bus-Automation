Feature: Add a new user

  Background:
    Given I log in bus admin console as administrator

  @TC.20875 @bus @2.5 @manage_storage @add_new_user @regression @core_function
  Scenario: 20875 [Bundled] Add New User with default user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20875-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-2 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-3 | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-4 | (default user group) | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-5 | (default user group) | Desktop      |               | 2       |
      | TC.20875-6 | (default user group) | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20875-7 | (default user group) | Server       |               | 2       |
      | TC.20875-8 | (default user group) | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Sync     | Storage         |
      | TC.20875-1  | (default user group)  | Enabled  |  10 GB (Limited)|
      | TC.20875-2  | (default user group)  | Disabled |  Shared         |
      | TC.20875-3  | (default user group)  | Disabled |  10 GB (Limited)|
      | TC.20875-4  | (default user group)  | Disabled |  Shared         |
      | TC.20875-5  | (default user group)  | Disabled |  Shared         |
      | TC.20875-6  | (default user group)  | Disabled |  Shared         |
      | TC.20875-7  | (default user group)  | Disabled |  Shared         |
      | TC.20875-8  | (default user group)  | Disabled |  Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20910 @bus @2.5 @manage_storage @add_new_user @regression @core_function
  Scenario: 20910 [Bundled] Add New User with new user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    When I add a new Bundled user group:
      | name          | storage_type | server_support | enable_stash |
      | TC.20910 UG 1 | Shared       | yes            | yes          |
    Then TC.20910 UG 1 user group should be created
    When I add a new Bundled user group:
      | name          | storage_type | limited_quota | server_support | enable_stash |
      | TC.20910 UG 2 | Limited      | 50            | yes            | yes          |
    Then TC.20910 UG 2 user group should be created
    When I add a new Bundled user group:
      | name          | storage_type | assigned_quota | server_support | enable_stash |
      | TC.20910 UG 3 | Assigned     | 50             | yes            | yes          |
    Then TC.20910 UG 3 user group should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices | enable_stash |
      | TC.20910-1 | TC.20910 UG 1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-2 | TC.20910 UG 1 | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-3 | TC.20910 UG 2 | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-4 | TC.20910 UG 2 | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-5 | TC.20910 UG 3 | Desktop      |               | 2       |
      | TC.20910-6 | TC.20910 UG 3 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20910-7 | TC.20910 UG 3 | Server       |               | 2       |
      | TC.20910-8 | TC.20910 UG 3 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group     | Sync     | Storage         |
      | TC.20910-1  | TC.20910 UG 1  | Enabled  |  10 GB (Limited)|
      | TC.20910-2  | TC.20910 UG 1  | Disabled |  Shared         |
      | TC.20910-3  | TC.20910 UG 2  | Disabled |  10 GB (Limited)|
      | TC.20910-4  | TC.20910 UG 2  | Disabled |  Shared         |
      | TC.20910-5  | TC.20910 UG 3  | Disabled |  Shared         |
      | TC.20910-6  | TC.20910 UG 3  | Disabled |  Shared         |
      | TC.20910-7  | TC.20910 UG 3  | Disabled |  Shared         |
      | TC.20910-8  | TC.20910 UG 3  | Disabled |  Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20871 @bus @2.5 @manage_storage @add_new_user @regression @core_function
  Scenario: 20871 [Itemized] Add New User with default user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | company name            |
      | 12     | 10    | 100 GB      | [Itemized] Tooltips Test|
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20871-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-2 | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-3 | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-4 | (default user group) | Server       |               | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-5 | (default user group) | Desktop      |               | 2       |
      | TC.20871-6 | (default user group) | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.20871-7 | (default user group) | Server       |               | 2       |
      | TC.20871-8 | (default user group) | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Sync     | Storage                  |
      | TC.20871-1  | (default user group)  | Enabled  | Desktop: 10 GB (Limited) |
      | TC.20871-2  | (default user group)  | Disabled | Desktop: Shared          |
      | TC.20871-3  | (default user group)  | Disabled | Server: 10 GB (Limited)  |
      | TC.20871-4  | (default user group)  | Disabled | Server: Shared           |
      | TC.20871-5  | (default user group)  | Disabled | Desktop: Shared          |
      | TC.20871-6  | (default user group)  | Disabled | Desktop: Shared          |
      | TC.20871-7  | (default user group)  | Disabled | Server: Shared           |
      | TC.20871-8  | (default user group)  | Disabled | Server: Shared           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20906 @bus @2.5 @manage_storage @add_new_user @regression @core_function
  Scenario: 20906 [Itemized] Add New User with new user group
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices | enable_stash | server_storage_type | server_devices |
      | TC.20906 UG 1 | Shared               | 2               | yes          | Shared              | 2              |
    Then TC.20906 UG 1 user group should be created
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_limited_quota | desktop_devices | enable_stash | server_storage_type | server_limited_quota | server_devices |
      | TC.20906 UG 2 | Limited              | 50                    | 2               | yes          | Limited             | 50                   | 2              |
    Then TC.20906 UG 2 user group should be created
    When I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type | server_assigned_quota | server_devices |
      | TC.20906 UG 3 | Assigned             | 50                     | 4               | yes          | Assigned            | 50                    | 4              |
    Then TC.20906 UG 3 user group should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices | enable_stash |
      | TC.20906-1 | TC.20906 UG 1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-2 | TC.20906 UG 1 | Desktop      |               | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-3 | TC.20906 UG 2 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-4 | TC.20906 UG 2 | Server       |               | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-5 | TC.20906 UG 3 | Desktop      |               | 2       |
      | TC.20906-6 | TC.20906 UG 3 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | user_group    | storage_type | storage_limit | devices |
      | TC.20906-7 | TC.20906 UG 3 | Server       |               | 2       |
      | TC.20906-8 | TC.20906 UG 3 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group     | Sync     | Storage                  |
      | TC.20906-1  | TC.20906 UG 1  | Enabled  | Desktop: 10 GB (Limited) |
      | TC.20906-2  | TC.20906 UG 1  | Disabled | Desktop: Shared          |
      | TC.20906-3  | TC.20906 UG 2  | Disabled | Server: 10 GB (Limited)  |
      | TC.20906-4  | TC.20906 UG 2  | Disabled | Server: Shared           |
      | TC.20906-5  | TC.20906 UG 3  | Disabled | Desktop: Shared          |
      | TC.20906-6  | TC.20906 UG 3  | Disabled | Desktop: Shared          |
      | TC.20906-7  | TC.20906 UG 3  | Disabled | Server: Shared           |
      | TC.20906-8  | TC.20906 UG 3  | Disabled | Server: Shared           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20921 @bus @2.5 @manage_storage @add_new_user @regression @core_function
  Scenario: 20921 [MozyPro] Add New User
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.20921-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-2 | Desktop      |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-3 | Server       | 10            | 1       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-4 | Server       |               | 2       |
    Then 1 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-5 | Desktop      |               | 2       |
      | TC.20921-6 | Desktop      |               | 2       |
    Then 2 new user should be created
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20921-7 | Server       |               | 2       |
      | TC.20921-8 | Server       |               | 2       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | Sync     | Storage         |
      | TC.20921-1  | Enabled  |  10 GB (Limited)|
      | TC.20921-2  | Disabled |  Shared         |
      | TC.20921-3  | Disabled |  10 GB (Limited)|
      | TC.20921-4  | Disabled |  Shared         |
      | TC.20921-5  | Disabled |  Shared         |
      | TC.20921-6  | Disabled |  Shared         |
      | TC.20921-7  | Disabled |  Shared         |
      | TC.20921-8  | Disabled |  Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  Scenario: create a user with all caps
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name           | storage_type | storage_limit | devices |
      | JEFFY MCBURTON | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.465 @bus @tasks_p2
  Scenario: Mozy-465:Suspend a User
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.465.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I suspended the user
    And I use keyless activation to activate devices unsuccessful
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.466 @bus @tasks_p2
  Scenario: Mozy-466:Acivate a User
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.466.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I suspended the user
    And I use keyless activation to activate devices unsuccessful
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    Then I activate the user
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 10 |
    Then tds returns successful upload
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21218 @bus @tasks_p2
  Scenario: Mozy-21218:[Bundled] Verify Add New User input Tooltips
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    Then New partner should be created
    And I act as newly created partner
    Then I navigate to Add New User section from bus admin console page
    Then I check user group (default user group) with Desktop storage limit tooltips is Min: 0 GB, Max: 100 GB
    When I edit (default user group) Bundled user group:
      | storage_type | assigned_quota | enable_stash | server_support |
      | Assigned     | 50             | yes          | no             |
    Then I navigate to Add New User section from bus admin console page
    Then I check user group (default user group) with Desktop storage limit tooltips is Min: 0 GB, Max: 50 GB
    When I edit (default user group) Bundled user group:
      | storage_type | limited_quota | enable_stash | server_support |
      | Limited      | 50            | yes          | yes            |
    Then I navigate to Add New User section from bus admin console page
    Then I check user group (default user group) with Desktop storage limit tooltips is Min: 0 GB, Max: 50 GB
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122222 @bus @tasks_p2
  Scenario: Mozy-122222:Add a user with a domain in the dea_services table
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner
    Then I get mail domain from dea_services
    And I add new user(s):
      | name  | email                            |user_group           | storage_type | storage_limit | devices |
      | User1 | <%='test_122222@'+@domain_name%> |(default user group) | Desktop      |               | 1       |
    Then The error message beside email should be It looks like you're trying to sign up with an email address provided by one of those throw-away email address deals. Please read our NO SPAM policy if you're worried or something, then sign up with a real email account.
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
