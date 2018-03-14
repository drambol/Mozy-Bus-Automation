#Success Criteria:

#Machine detail view - I can set an optional max setting.
#I can remove the max setting for the machine
#The max setting can not be bigger than the one on user/user group/account.
#If the max is hit, then the machine will stop backing up. (refer to #94464)

Feature: Set/Remove Max at Machine

  As an Mozy administrator
  I want the ability to set a cap on a machine
  So that I can manage the machine

  Background:
    Given I log in bus admin console as administrator

  @TC.21074 @bus @2.5 @user_view @max_at_machine @itemized @regression @core_function
  Scenario: 21074 [Itemized]Desktop machine and stash stop backing up when max is hit
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes           |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    And I update the user password to default password
#    And I add stash for the user with:
#      | stash quota | send email |
#      | 5           | no         |
    And I set user stash quota to 5 GB
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I refresh User Details section
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 10 GB successfully
      """
    And The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I update Machine1 used quota to 10 GB
    And I update Sync used quota to 5 GB
    And The range of machine max for Sync by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    Then Available quota of Machine1 should be 0 GB
    And Available quota of Sync should be 0 GB
    When I refresh User Details section
    Then I change user stash quota to 6 GB
    Then Available quota of Sync should be 1 GB
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21075 @bus @2.5 @user_view @max_at_machine @bundled @regression @core_function
  Scenario: 21075 [Bundled]Server machine can Set/Edit/Remove max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | no           |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 0 GB       |
    When I refresh User Details section
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    |
      | Machine1 | 0 / 20 GB      | 20 GB Edit Remove    | < a minute ago |
    Then I edit machine max for Machine1
    And I input the machine max value for Machine1 to 30 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    |
      | Machine1 | 0 / 30 GB      | 30 GB Edit Remove    | < a minute ago |
    When I remove machine max for Machine1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    |
      | Machine1 | 0 / 50 GB      | Set                  | < a minute ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21078 @bus @2.5 @user_view @max_at_machine @bundled @regression @core_function
  Scenario: 21078 [Bundled]Desktop machine and stash stop backing up when max is hit
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 0 GB       |
    When I refresh User Details section
    And I set user stash quota to 5 GB
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
      """
      Machine storage limit was set to 10 GB successfully
      """
    And The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    And The range of machine max for Sync by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I update Machine1 used quota to 10 GB
    Then The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    And I update Sync used quota to 5 GB
    Then The range of machine max for Sync by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    Then Available quota of Machine1 should be 0 GB
    And Available quota of Sync should be 0 GB
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21073 @bus @tasks_p2
  Scenario: Mozy-21073:[Itemized]Desktop machine and stash set max cannot be bigger than that of user/ug/account
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test Server | Shared               | 5               | Shared              | 5             | yes          |
    Then Itemized user group should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    And I refresh User Details section
    And I set user stash quota to 51 GB
    Then set max message should be:
    """
    The Sync Storage limit cannot be more than what is available for this user.
    """
    When I edit Test Server Itemized user group:
      | name        | desktop_storage_type | desktop_limited_quota |
      | Test Server | Limited              | 100                   |
    Then Test Server user group should be updated
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 51 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine Storage limit cannot be set to 51 GB, out of resources.
    """
    Then I remove user max for User1
    And I set user stash quota to 101 GB
    Then set max message should be:
    """
    The Sync Storage limit cannot be more than what is available for this user.
    """
    Then stash device table in user details should be:
      | Sync Container | Used/Available    | Device Storage Limit | Last Update      |
      | Sync           | 0 / 99 GB         |  Set                 | N/A              |
    When I edit Test Server Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota |
      | Test Server | Assigned             | 150                    |
    Then Test Server user group should be updated
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    And I set user stash quota to 151 GB
    Then set max message should be:
    """
    The Sync Storage limit cannot be more than what is available for this user.
    """
    When I edit Test Server Itemized user group:
      | name        | desktop_storage_type |
      | Test Server | Shared               |
    Then Test Server user group should be updated
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 151 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine storage limit was set to 151 GB successfully
    """
    Then I edit machine max for Machine1
    And I input the machine max value for Machine1 to 201 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine Storage limit cannot be set to 201 GB, out of resources.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21076 @bus @tasks_p2
  Scenario: Mozy-21076:[Bundled Reseller]Desktop machine with stash set max cannot be bigger than that of user/ug/account
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    When I refresh User Details section
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update |
      | Machine1 | 1 GB / 19 GB   | 20 GB Edit Remove    | < a minute ago |
    Then I edit machine max for Machine1
    And I input the machine max value for Machine1 to 51 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine Storage limit cannot be set to 51 GB, out of resources.
    """
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update |
      | Machine1 | 1 GB / 19 GB   | 20 GB Edit Remove    | < a minute ago |
    When I edit Test Bundled user group:
      | name | storage_type | limited_quota |
      | Test | Limited      | 100           |
    Then Test user group should be updated
    When I search user by:
      | keywords   |
      | User1      |
    Then I view user details by User1
    And I set user stash quota to 101 GB
    Then set max message should be:
    """
    The Sync Storage limit cannot be more than what is available for this user.
    """
    And I set user stash quota to 20 GB
    Then stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 20 GB          | 20 GB Edit Remove    | N/A              |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21077 @bus @tasks_p2
  Scenario: Mozy-21077:[Bundled Mozypro]Server machine set max cannot be bigger than that of account
    When I add a new MozyPro partner:
      | period | base plan | root role               | server plan | storage add on 50 gb |
      | 12     | 100 GB    | Bundle Pro Partner Root | yes         | 2                    |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name  | user_group            | storage_type | storage_limit | devices |
      | User1 | (default user group)  | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Server       |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    When I refresh User Details section
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update |
      | Machine1 | 1 GB / 19 GB   | 20 GB Edit Remove    | < a minute ago |
    Then I edit machine max for Machine1
    And I input the machine max value for Machine1 to 101 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine Storage limit cannot be set to 101 GB, out of resources.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21021 @bus @tasks_p2
  Scenario:  Mozy-21021:[Bundled]List all the active devices including stash
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    And I add new user(s):
      | name  | user_group           | storage_type | devices | enable_stash |
      | User1 | (default user group) | Desktop      | 10      | yes           |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I update Sync used quota to 20 GB
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 10 |
    Then tds returns successful upload
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine2     | Desktop      |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 20 |
    Then tds returns successful upload
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine3     | Desktop      |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    When I refresh User Details section
    Then I delete device by name: Machine3
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update |
      | Machine1 | 10 GB / 150 GB | Set                  | 1 minute ago |
      | Machine2 | 20 GB / 150 GB | Set                  | 1 minute ago |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 20 GB / 150 GB     | Set                  | 1 minute ago     |
    Then I close User Details section
    And I add new user(s):
      | name  | user_group           | storage_type | devices |
      | User2 | (default user group) | Server       | 10      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User2      |
    And I view user details by User2
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine4     | Server       |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 10 |
    Then tds returns successful upload
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine5     | Server       |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 20 |
    Then tds returns successful upload
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine6     | Server       |
    And I upload data to device by batch
      | machine_id                      | GB |
      | <%=@new_clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    When I refresh User Details section
    Then I delete device by name: Machine6
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update |
      | Machine4 | 10 GB / 120 GB | Set                  | 1 minute ago |
      | Machine5 | 20 GB / 120 GB | Set                  | 1 minute ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21100 @bus @tasks_p2
  Scenario: Mozy-21100:[Bundled]Edit the number of Desktop Device
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    Then I edit user Desktop device quota to -1
    And Show error: Whole positive integer required for device count
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    Then I refresh User Details section
    And user resources details rows should be:
      | Storage                     | Devices                             |
      | 2 GB Used / 48 GB Available | Desktop: 2 Used / 1 Available Edit  |
    Then I edit user Desktop device quota to 4
    And user resources details rows should be:
      | Storage                     | Devices                             |
      | 2 GB Used / 48 GB Available | Desktop: 2 Used / 2 Available Edit  |
    Then I view the user's product keys
    Then Number of Desktop activated keys should be 2
    And Number of Desktop unactivated keys should be 2
    Then I edit user Desktop device quota to 2
    And user resources details rows should be:
      | Storage                     | Devices                             |
      | 2 GB Used / 48 GB Available | Desktop: 2 Used / 0 Available Edit  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21121 @bus @tasks_p2
  Scenario: Mozy-21121:[Bundled]Stash container is listed besides device list table
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | enable_stash |
      | Test | Shared       | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I update Sync used quota to 3 GB
    Then I refresh User Details section
    And user resources details rows should be:
      | Storage                     | Devices                             |
      | 3 GB Used / 47 GB Available | Desktop: 0 Used / 3 Available Edit  |
    And stash device table in user details should be:
      | Sync Container | Used/Available   | Device Storage Limit | Last Update      |
      | Sync           | 3 GB / 47 GB     | Set                  | < a minute ago   |
    Then I delete sync container
    Then I refresh User Details section
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21010 @bus @tasks_p2
  Scenario: Mozy-21010:"Last Update" shows "30 minutes ago" if last backup time is 30 minutes ago
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1 | (default user group) | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then tds returns successful upload
    Then I update <%=@new_clients.first.machine_id%> last backup time to 30 minutes ago
    Then I refresh User Details section
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    |
      | Machine1 | 1 GB / 49 GB   | Set                  | 30 minutes ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21101 @bus @tasks_p2
  Scenario: Mozy-21101:[Bundled]Error shows when I add more devices than available in UG
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    Then I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User2 | Test       | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords  |
      | User2     |
    And I view user details by User2
    Then I edit user Server device quota to 17
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 50 GB Available | Server: 0 Used / 17 Available Edit  |
    Then I edit user Server device quota to 21
    And Show error: Invalid number of Server devices
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21344 @bus @tasks_p2
  Scenario: Mozy-21344:[Bundled Reseller with storage pool]device number to any natural number when add and edit user
#    When I act as partner by:
#      | email                                 | include_sub_partners |
#      | redacted-4164@notarealdomain.mozy.com | false                |
#    Then I navigate to Add New Role section from bus admin console page
#    And I add a new role:
#      | Name          | Type          |
#      | Internal_Test | Partner admin |
#    Then I check all the capabilities for the new role
#    Then I stop masquerading
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     | server plan |
      | 12     | Silver        | 100            | Internal_Test | yes         |
    Then New partner should be created
    Then I change root role to Internal_Test
    And I search partner by newly created partner admin email
    Then Partner search results should be:
      | Partner       | Created | Type     | Keys      |
      | @company_name | today   | Reseller | Unlimited |
    And I view partner details by newly created partner admin email
    And Partner pooled storage information should be:
      | Used | Available   | Assigned   | Used | Available | Assigned |
      | 0    | 100 GB      | 100 G B    | 0    | Unlimited | Unlimited|
    And I act as newly created partner account
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 1             | 150     |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User2 | (default user group) | Desktop      | 1             | 150     |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User3 | (default user group) | Desktop      | 1             | 101     |
    Then 1 new user should be created
    And I search user by:
      | keywords  |
      | User3     |
    And I view user details by User3
    Then I edit user Desktop device quota to 102
    And user resources details rows should be:
      | Storage                  | Devices                              |
      | 0 Used / 1 GB Available  | Desktop: 0 Used / 102 Available Edit |
    Then I edit user Desktop device quota to 0
    And user resources details rows should be:
      | Storage                  | Devices                            |
      | 0 Used / 1 GB Available  | Desktop: 0 Used / 0 Available Edit |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21345 @bus @tasks_p2
  Scenario: Mozy-21345:[Bundled Reseller without storage pool]device number still have limit
    When I add a new OEM partner:
      | Company Name    | Root role         | Security | Company Type     |
      | test_for_21345  | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    Then I migrate the partner to pooled storage
    Then I navigate to Add New User section from bus admin console page
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 1             | 1      |
    Then 1 new user should be created
    And I search user by:
      | keywords  |
      | User1     |
    And I view user details by User1
    Then I edit user Desktop device quota to 3
    And Show error: Invalid number of Desktop devices
    Then I edit user Desktop device quota to 0
    And user resources details rows should be:
      | Storage                          | Devices                            |
      |Desktop: 0 Used / 1 GB Available  | Desktop: 0 Used / 0 Available Edit |
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name




