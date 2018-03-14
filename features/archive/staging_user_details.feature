#Feature: Staging User Details

#  Background:
#    Given I log in bus admin console as administrator
#
#  @TC.120019 @bus @edit_device_limit
#  Scenario: 120019:[Bundled]newly synced FedID users can edit device limit
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota | net terms | server plan |
#      | 12     | Silver        | 100            | yes       | yes         |
#    Then New partner should be created
#    And I act as newly created partner account
#    When I add a new Bundled user group:
#      | name | storage_type | limited_quota | server_support |
#      | Test | Limited      | 50            | yes            |
#    Then Test user group should be created
#    And I add new user(s):
#      | name  | user_group | storage_type | storage_limit | devices |
#      | User1 | Test       | Server       | 50            | 3       |
#    Then 1 new user should be created
#    And I search user by:
#      | keywords   |
#      | User1      |
#    And I view user details by User1
#    When  I edit user Server device quota to 2
#    Then The range of device by tooltips should be:
#      | Min | Max |
#      | 0   | 20  |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 2         | Server       |
#    When I stop masquerading
#    And I view partner details by newly created partner company name
#    When I add partner settings
#      | Name                    | Value | Locked |
#      | allow_ad_authentication | t     | true   |
#    And I act as newly created partner account
#    And I navigate to Authentication Policy section from bus admin console page
#    And I use Directory Service as authentication provider
#    And I search user by:
#      | keywords   |
#      | User1      |
#    And I view user details by User1
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 2         | Server       |
#    And I navigate to Authentication Policy section from bus admin console page
#    When I click Connection Settings tab
#    And I input server connection settings
#      | Server Host  | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
#      | fedid.biz    | No SSL   |          | 389  | dc=fedid,dc=biz              | adfs\root                 | abc!@#123     |
#    And I save the changes
#    Then Authentication Policy has been updated successfully
#    When I Test Connection for AD
#    Then test connection message should be Test passed
#    When I click Sync Rules tab
#    And I add 1 new provision rules:
#      | rule            | group |
#      | cn=zhangjie2    | Test  |
#    And I click the sync now button
#    And I wait for 70 seconds
#    And I click Connection Settings tab
#    Then The sync status result should like:
#      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
#      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0   |
#      | Next Sync   | Not Scheduled(Set)                                                   |
#    When I navigate to Search / List Users section from bus admin console page
#    And I sort user search results by Name
#    Then User search results should be:
#      | User                   | Name         | User Group |
#      | <%=@users[0].email%>   | User1        | Test       |
#      | zhangjie2@fedid.biz    | zhangjie2    | Test       |
#    And I view user details by zhangjie2
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | Unlimited | Server       |
#    When I edit user Server device quota to 3
#    Then The range of device by tooltips should be:
#      | Min | Max |
#      | 0   | 20  |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 3         | Server       |
#    And I close user details section
#    When I view user details by User1
#    Then users' device status should be:
#      | Used | Available | storage_type |
#      | 0    | 2         | Server       |
#    When  I edit user Server device quota to 1
#    Then The range of device by tooltips should be:
#      | Min | Max |
#      | 0   | 20  |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 1         | Server       |
#    And I navigate to Authentication Policy section from bus admin console page
#    When I click Sync Rules tab
#    And I delete all the rules
#    And I add 1 new deprovision rules:
#      | rule            | action |
#      | cn=zhangjie2    | Delete |
#    And I click the sync now button
#    And I wait for 70 seconds
#    And I click Connection Settings tab
#    Then The sync status result should like:
#      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
#      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed   |
#      | Next Sync   | Not Scheduled(Set)                                                   |
#    When I stop masquerading
#    And I search and delete partner account by newly created partner company name
#
#  @TC.120021 @bus @edit_device_limit
#  Scenario: 120021 [Enterprise]newly synced FedID users can edit device limit
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan | net terms |
#      | 12     | 18    | 100 GB      | yes       |
#    Then New partner should be created
#    And I act as newly created partner account
#    And I add a new Itemized user group:
#      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
#      | Test | Shared               | 5               | Shared              | 10             | yes          |
#    And I add new user(s):
#      | name  | user_group | storage_type | storage_limit | devices |
#      | User1 | Test       | Server       | 50            | 3       |
#    Then 1 new user should be created
#    And I search user by:
#      | keywords   |
#      | User1      |
#    And I view user details by User1
#    When  I edit user device quota to 2
#    Then The range of device by tooltips should be:
#      | Min | Max |
#      | 0   | 10  |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 2         | Server       |
#    When I stop masquerading
#    And I view partner details by newly created partner company name
#    When I add partner settings
#      | Name                    | Value | Locked |
#      | allow_ad_authentication | t     | true   |
#    And I act as newly created partner account
#    And I navigate to Authentication Policy section from bus admin console page
#    And I use Directory Service as authentication provider
#    And I search user by:
#      | keywords   |
#      | User1      |
#    And I view user details by User1
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 2         | Server       |
#    And I navigate to Authentication Policy section from bus admin console page
#    When I click Connection Settings tab
#    And I input server connection settings
#      | Server Host  | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
#      | fedid.biz    | No SSL   |          | 389  | dc=fedid,dc=biz              | adfs\root                 | abc!@#123     |
#    And I save the changes
#    Then Authentication Policy has been updated successfully
#    When I Test Connection for AD
#    Then test connection message should be Test passed
#    When I click Sync Rules tab
#    And I add 1 new provision rules:
#      | rule            | group |
#      | cn=zhangjie2    | Test  |
#    And I click the sync now button
#    And I wait for 70 seconds
#    And I click Connection Settings tab
#    Then The sync status result should like:
#      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
#      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0   |
#      | Next Sync   | Not Scheduled(Set)                                                   |
#    When I navigate to Search / List Users section from bus admin console page
#    And I sort user search results by Name
#    Then User search results should be:
#      | User                   | Name         | User Group |
#      | <%=@users[0].email%>   | User1        | Test       |
#      | zhangjie2@fedid.biz    | zhangjie2    | Test       |
#    And I view user details by zhangjie2
#    And users' device status should be:
#      | Used | Available | storage_type |
#      | 0    | 8         | Server       |
#      | 0    | 5         | Desktop      |
#    When I edit user Server device quota to 3
#    Then The range of Server device by tooltips should be:
#      | Min | Max |
#      | 0   | 8   |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 3         | Server       |
#      | 0    | 5         | Desktop      |
#    When I edit user Desktop device quota to 2
#    Then The range of Desktop device by tooltips should be:
#      | Min | Max |
#      | 0   | 5   |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      | 0    | 3         | Server       |
#      | 0    | 2         | Desktop      |
#    And I close user details section
#    When I view user details by User1
#    Then users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 2         | Server       |
#    When  I edit user device quota to 1
#    Then The range of device by tooltips should be:
#      | Min | Max |
#      | 0   | 7   |
#    And users' device status should be:
#      | Used | Available | storage_type |
#      |  0   | 1         | Server       |
#    And I navigate to Authentication Policy section from bus admin console page
#    When I click Sync Rules tab
#    And I delete all the rules
#    And I add 1 new deprovision rules:
#      | rule            | action |
#      | cn=zhangjie2    | Delete |
#    And I click the sync now button
#    And I wait for 70 seconds
#    And I click Connection Settings tab
#    Then The sync status result should like:
#      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
#      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed   |
#      | Next Sync   | Not Scheduled(Set)                                                   |
#    When I stop masquerading
#    And I search and delete partner account by newly created partner company name