Feature: User Details

  Background:
    Given I log in bus admin console as administrator

  @TC.20986 @bus @2.5 @user_view @last_update @need_test_account @env_dependent @regression @core_function_remove
  Scenario: 20986 Last Update shows the time for the 3 device whose last backup time is 5 days ago
    When I act as partner by:
      | email                |
      | last_update@auto.com |
    When I search user by:
      | keywords             |
      | last_update@test.com |
    Then User search results should be:
      | User                 | Name        | Sync    | Machines | Storage | Storage Used |
      | last_update@test.com | last_update | Enabled | 3        | Shared  | 60 GB        |
      #| last_update@test.com | last_update | Enabled | 3        | 100 GB (Limited) | 60 GB        |
    When I view user details by last_update@test.com
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update      | Action |
      | machine1 | 0 / 40 GB      | Set                  | N/A              |        |
      | machine2 | 30 GB / 40 GB  | Set                  | 04/08/2013 03:51 |        |
      | machine3 | 30 GB / 40 GB  | Set                  | 03/01/2013 15:51 |        |
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update | Action |
      | Sync           | 0 / 40 GB      | Set                  | N/A         |        |

  @TC.20987 @bus @2.5 @user_view @last_update @dynamic_create @regression @core_function
  Scenario: 20987 "Last Update" shows "N/A" if never backup
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20987.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A         |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20988 @bus @2.5 @user_view @last_update @dynamic_create @regression @core_function
  Scenario: 20988 "Last Update" shows "< a minute ago" if last backup time is less than 1minutes
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20988.User | (default user group) | Desktop      |               | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name | machine_type |
      | Machine1     | Desktop      |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 10 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Device   | Storage Type | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1 | Desktop      | 10 GB / 40 GB  | Set                  | < a minute ago |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21020 @bus @2.5 @user_view @itemized @list_active_devices @regression @core_function
  Scenario: 21020 [Itemized]List all the active devices including stash
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized] User Detail   |
    Then New partner should be created
    And I enable stash for the partner
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash | send_email |
      | TC.21020.User | (default user group) | Desktop      |               | 4       |       yes    |    no      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 10 GB      |
      | Machine2     | Desktop      | 20 GB      |
      | Machine3     | Desktop      | 30 GB      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type |Used/Available     | Device Storage Limit | Last Update      | Action |
      | Machine1        | Desktop      |10 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine2        | Desktop      |20 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine3        | Desktop      |30 GB / 140 GB     | Set                  | < a minute ago   |        |
    Then stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 140 GB         | Set                  | N/A              |        |

  @TC.21096 @bus @2.5 @user_view @itemized @regression @core_function
  Scenario: 21096 [Itemized]Edit the number of Desktop Device
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]Edit Device    |
    Then New partner should be created
    And I enable stash for the partner
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices | enable_stash |
      | TC.21096.User | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota | machine_codename |
      | Machine1     | Desktop      | 0 GB       | MozyEnterprise   |
      | Machine2     | Desktop      | 0 GB       | MozyEnterprise   |
    And I refresh User Details section
    When I set device quota field to 4 and cancel
    Then users' device status should be:
      | Used | Available | storage_type |
      |  2   | 1         | Desktop      |
    When I edit user device quota to 4
    Then users' device status should be:
      | Used | Available | storage_type |
      | 2    | 2         | Desktop      |
    When I view the user's product keys
    Then Number of Desktop activated keys should be 2
    And Number of Desktop unactivated keys should be 2
    When I edit user device quota to 2
    When I view the user's product keys
    Then Number of Desktop activated keys should be 2
    And Number of Desktop unactivated keys should be 0

  @TC.21097 @bus @2.5 @itemized @user_view @list_active_devices @regression @core_function
  Scenario: 21097 [Itemized]Error shows when I add more Server devices than available in UG
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]No More Device |
    Then New partner should be created
    And I enable stash for the partner
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User1 | Test       | Server       | 50            | 3       |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User2 | Test       | Server       | 50            | 5       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I edit user device quota to 8
    Then Show error: Invalid number of Server devices

  @TC.21102 @bus @2.5 @user_view @list_active_devices @itemized @regression @core_function
  Scenario: 21102 [Bundled]Removed Device is returned to UG
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]Removed Device |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 50             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User1 | Test       | Server       | 50            | 3       |
    Then 1 new user should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User2 | Test       | Server       | 50            | 40      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    When  I edit user device quota to 2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 10  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    And I close user details section
    And I search user by:
      | keywords |
      | User2    |
    And I view user details by User2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 48  |
    When  I edit user device quota to 38
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 38        | Server       |
    And I close user details section
    When I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And The range of device by tooltips should be:
      | Min | Max |
      | 0   | 12  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21103 @bus @2.5 @user_view @list_active_devices @itemized @regression @core_function
  Scenario: 21103 [Bundled]Error shows when I remove more Desktop devices than not activated
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
      | Machine2     | Desktop      | 0 GB       |
    When  I edit user device quota to 1
    Then Show error: The number here should be great or equal than 2, which is the current used device count
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120019 @bus @edit_device_limit @regression @core_function
  Scenario: 120019:[Bundled]newly synced FedID users can edit device limit
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | server plan |
      | 12     | Silver        | 100            | yes       | yes         |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | limited_quota | server_support |
      | Test | Limited      | 50            | yes            |
    Then Test user group should be created
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User1 | Test       | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    When  I edit user Server device quota to 2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 20  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    When I stop masquerading
    And I view partner details by newly created partner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    When I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Connection Settings tab
    When I Test Connection for AD
    Then test connection message should be Test passed
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule            | group |
      | cn=120019-test1 | Test  |
    And I click the sync now button
    And I wait for 70 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0   |
      | Next Sync   | Not Scheduled(Set)                                                   |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                   | Name         | User Group |
      | 120019-test1@test.com  | 120019-test1 | Test       |
      | <%=@users[0].email%>   | User1        | Test       |
    And I view user details by 120019-test1
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | Unlimited | Server       |
    When I edit user Server device quota to 3
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 20  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 3         | Server       |
    And I close user details section
    When I view user details by User1
    Then users' device status should be:
      | Used | Available | storage_type |
      | 0    | 2         | Server       |
    When  I edit user Server device quota to 1
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 20  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 1         | Server       |
    And I navigate to Authentication Policy section from bus admin console page
    When I click Sync Rules tab
    And I delete all the rules
    And I add 1 new deprovision rules:
      | rule            | action |
      | cn=120019-test1 | Delete |
    And I click the sync now button
    And I wait for 70 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed   |
      | Next Sync   | Not Scheduled(Set)                                                   |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120020 @bus @edit_device_limit @regression @core_function
  Scenario: 120020 [Bundled]user moved from subpartner to partner can edit device limit
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Generic Storage |
      | 30              |
    And I act as newly created subpartner account
    And I add some new users and activate one machine for each
      | name             | user_group           | storage_type | storage_limit | devices | machine_name   |
      | subpartner.User1 | (default user group) | Desktop      | 10            | 3       | SubTestMachine |
    And I search user by:
      | keywords         |
      | subpartner.User1 |
    And I view user details by subpartner.User1
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 2         | Desktop      |
    Then I stop masquerading from subpartner
    And I search user by:
      | keywords         |
      | subpartner.User1 |
    And I view user details by subpartner.User1
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 2         | Desktop      |
    When I reassign the user to partner <%=@partner.company_info.name%>
    Then users' device status should be:
      | Used | Available | storage_type |
      | 1    | 0         | Desktop      |
    When  I edit user device quota to 4
    Then The range of device by tooltips should be:
      | Min | Max |
      | 1   | 20  |
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 3         | Desktop      |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120021 @bus @edit_device_limit @regression @core_function
  Scenario: 120021 [Enterprise]newly synced FedID users can edit device limit
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices |
      | User1 | Test       | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    When  I edit user device quota to 2
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 10  |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    When I stop masquerading
    And I view partner details by newly created partner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    When I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Connection Settings tab
    When I Test Connection for AD
    Then test connection message should be Test passed
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule            | group |
      | cn=120021-test1 | Test  |
    And I delete a user 120021-test1@test.com in the demeter db
    And I click the sync now button
    And I wait for 70 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0   |
      | Next Sync   | Not Scheduled(Set)                                                   |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                   | Name         | User Group |
      | 120021-test1@test.com  | 120021-test1 | Test       |
      | <%=@users[0].email%>   | User1        | Test       |
    And I view user details by 120021-test1
    And users' device status should be:
      | Used | Available | storage_type |
      | 0    | 8         | Server       |
      | 0    | 5         | Desktop      |
    When I edit user Server device quota to 3
    Then The range of Server device by tooltips should be:
      | Min | Max |
      | 0   | 8   |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 3         | Server       |
      | 0    | 5         | Desktop      |
    When I edit user Desktop device quota to 2
    Then The range of Desktop device by tooltips should be:
      | Min | Max |
      | 0   | 5   |
    And users' device status should be:
      | Used | Available | storage_type |
#      | 0    | 2         | Desktop      |
#      | 0    | 3         | Server       |
      | 0    | 3         | Server       |
      | 0    | 2         | Desktop      |
    And I close user details section
    When I view user details by User1
    Then users' device status should be:
      | Used | Available | storage_type |
      |  0   | 2         | Server       |
    When  I edit user device quota to 1
    Then The range of device by tooltips should be:
      | Min | Max |
      | 0   | 7   |
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 1         | Server       |
    And I navigate to Authentication Policy section from bus admin console page
    When I click Sync Rules tab
    And I delete all the rules
    And I add 1 new deprovision rules:
      | rule            | action |
      | cn=120021-test1 | Delete |
    And I click the sync now button
    And I wait for 70 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed   |
      | Next Sync   | Not Scheduled(Set)                                                   |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120022 @bus @edit_device_limit @env_dependent @regression @core_function
  Scenario: 120022 [Enterprisde]user moved from subpartner to partner can edit device limit
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 18    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Desktop Storage | Desktop Devices | Server Storage | Server Devices |
      | 30              | 3               | 50             | 5              |
    And I act as newly created subpartner account
    And I add some new users and activate one machine for each
      | name             | user_group           | storage_type | storage_limit | devices | machine_name   |
      | subpartner.User1 | (default user group) | Desktop      | 10            | 3       | SubTestMachine |
    And I search user by:
      | keywords         |
      | subpartner.User1 |
    And I view user details by subpartner.User1
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 2         | Desktop      |
    Then I stop masquerading from subpartner
    And I search user by:
      | keywords         |
      | subpartner.User1 |
    And I view user details by subpartner.User1
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 2         | Desktop      |
    When I reassign the user to partner <%=@partner.company_info.name%>
    Then users' device status should be:
      | Used | Available | storage_type |
      | 1    | 0         | Desktop      |
    When  I edit user device quota to 4
    Then The range of device by tooltips should be:
      | Min | Max |
      | 1   | 16  |
    And users' device status should be:
      | Used | Available | storage_type |
      | 1    | 3         | Desktop      |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122231 @bus @tasks_p1 @cbs_tls12
  Scenario: Mozy-122231:Refund MH User
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    When I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I refund the user with all amount
    Then I check the refund amount should be correct
    And I delete user

  @TC.22264 @bus @tasks_p1
  Scenario: Mozy-22264:verify that users can update payment info
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    When I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to billed
    And I wait for 5 seconds
    Then The current user should be billed
    Then I delete user


  @TC.21071 @bus @2.5 @user_view @max_at_machine @itemized @regression @core_function
  Scenario: 21071 [Itemized]Desktop machine and Sync can Set/Edit/Remove max
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | Set Max for Machine      |
    Then New partner should be created
    And I enable stash for the partner
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices | enable_stash |
      | TC.21071.User | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | Machine1     | Desktop      | @partner_name |
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    And stash device table in user details should be:
      | Sync Container | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Sync           | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    When I set machine max for Machine1
    And I input the machine max value for Machine1 to 10 GB
    And I cancel machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    When I set machine max for Machine1
    Then The range of machine max for Machine1 by tooltips should be:
      | Min | Max |
      | 0   | 50  |
    When I input the machine max value for Machine1 to 10 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine storage limit was set to 10 GB successfully
    """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 10 GB      | 10 GB Edit Remove    | N/A          |        |
    When I edit machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I cancel machine max for Machine1
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 10 GB      | 10 GB Edit Remove    | N/A          |        |
    When I edit machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    Then set max message should be:
    """
    Machine storage limit was set to 20 GB successfully
    """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 20 GB      | 20 GB Edit Remove    | N/A          |        |
    When I remove machine max for Machine1
    Then set max message should be:
    """
    Machine will share this user's storage
    """
    And device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update  | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A          |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131831 @bus @tasks_p2 @cbs_tls12
  Scenario: Mozy-131831:Refund Cybersource media restore
    When I add a new MozyEnterprise partner:
      | period | users | server plan | security |
      | 12     | 10    | 250 GB      | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices |
      | User1 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1 |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name  | user_name                   | machine_type |
      | Machine1      | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      | file_name    |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> | TC131831.txt |
    Then tds returns successful upload
    Then I refresh User Details section
    And I access freyja from bus admin
    Then I navigate to new window
    Then I have login freyja from BUS
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
      | restore_name         | restore_type |
      | archive_restore_file | media    |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I log in bus admin console as administrator
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then I refund the user with all amount
    Then I check the refund amount should be correct
    And I search and delete partner account by newly created partner company name



