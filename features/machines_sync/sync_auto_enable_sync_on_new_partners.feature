Feature: Machine and Sync


  Background:
    Given I log in bus admin console as administrator

  @TC.22021 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22021 Disable Stash of MozyPro Partner with singule user(MozyPro) (local execution = 9m~10m)
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms | root role               |
      | 1      | 10 GB     | yes         | yes       | Bundle Pro Partner Root |
    And New partner should be created
    Then I enable stash for the partner
    And I get the admin id from partner details
    When I act as newly created partner account
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | false                   | true                   |
    #======new user successfully======
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.19039-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    And I stop masquerading
    #======disable the sync at partner level======
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    But I disable stash for the partner
    And I act as newly created partner account
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_exist |
      | (default user group)  | false                 |
    And I stop masquerading


  @TC.22024 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22021 Enable Stash for New Reseller Partners to enable stash for new users(Reseller) (local execution = 4min~5min)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I enable stash for the partner
    Then I act as newly created partner account
    And the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | false                   | true                   |
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22024-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    #======check the sync device having sync enabled======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22024-1
    Then sync device info should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update |
      | Sync           | 0 / 10 GB      | Set                  |  N/A        |
    And I stop masquerading


  @TC.22028 @bus @machines_sync @tasks_p3
  Scenario: 22028 Enable Stash After Disable Stash Of Partner With Single User(Reseller) (local execution = 12min~13min)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I enable stash for the partner
    Then I act as newly created partner account
    #======create a user======
    And the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | false                   | true                   |
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22028-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    #=====view sync device detail======
    Given  I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22028-1
    Then sync device info should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update |
      | Sync           | 0 / 10 GB      | Set                  |  N/A        |
    And I stop masquerading
    #======Disable Sync at partner level======
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    But I disable stash for the partner
    And I act as newly created partner account
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_exist |
      | (default user group)  | false                 |
    And I stop masquerading
    #======Enable Sync at partner level======
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    But I enable stash for the partner
    And I act as newly created partner account
    #======<Enable Sync> checkbox doesn't exist when create a new user======
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_exist | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | true                  | false                   | true                   |
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22028-2 | (default user group) | Desktop      | 5             | 1       | yes          |
    Then 1 new user should be created
    #======create another new user======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22028-2
    #======sync device details======
    Then sync device info should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update |
      | Sync           | 0 / 5 GB       | Set                  |  N/A        |
    And I close User Details section
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22028-1
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I stop masquerading


  @TC.22110 @bus @machines_sync @tasks_p3
  Scenario: 22110 Add Stash to All Users in Partner Detail(MozyPro) (local execution = 6min~7min)
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms | root role               |
      | 1      | 10 GB     | yes         | yes       | Bundle Pro Partner Root |
    And New partner should be created
    Then I enable stash for the partner
    And I get the admin id from partner details
    When I act as newly created partner account
    Then the new MozyPro user's default values should be:
      | user_group            | enable_stash_cb_checked | send_emails_cb_checked |
      | (default user group)  | false                   | true                   |
    #======new user successfully======
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22110-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    And I stop masquerading
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    #======disable and then enable the sync at partner level======
    Then I disable stash for the partner
    And I enable stash for the partner
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then I act as newly created partner account
    #======new another user======
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22110-2 | (default user group) | Desktop      | 5             | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    #======check the user table======
    And Search / List Users table should be:
      | Name        | User Group            | Sync     | Storage Used  |
      | TC.22110-2  | (default user group)  | Enabled  | None          |
      | TC.22110-1  | (default user group)  | Disabled | None          |
    And I stop masquerading


  @TC.22153 @bus @machines_sync @tasks_p3
  Scenario: 22110 Add Stash to all users in user group detail with multiple user groups(Reseller) (local execution = 10min~11min)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I act as newly created partner account
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22153-1 | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I add a new Bundled user group:
      | name            | storage_type | enable_stash |
      | TC.22153-Shared | Shared       | yes          |
    Then TC.22153-Shared user group should be created
    When I add new user(s):
      | name       | user_group      | storage_type | storage_limit | devices | enable_stash |
      | TC.22153-2 | TC.22153-Shared | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
  #======delete sync device======
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.22153-1
    Then delete device Sync by without keeping data
    And I close User Details section
    When I view user details by TC.22153-2
    Then delete device Sync by without keeping data
    And I close User Details section
  #======check the sync is No at user level======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22153-1
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    When I view user details by TC.22153-2
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
   #======group1, enable sync for all users======
    #Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22153-2
    And I view details of TC.22153-2's user group
    Then I enable stash for all users
    And I close the user detail page
    And I close the user group detail page
    #======check the Enable Sync is Yes======
    When I view user details by TC.22153-2
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I close User Details section
    #======(default user group), enable sync for all users======
    #Given I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | Name        |
      | TC.22153-1  |
    And I view user details by TC.22153-1
    And I view details of TC.22153-1's user group
    Then I enable stash for all users
    And I close the user detail page
    And I close the user group detail page
    #======check the Enable Sync is Yes======
    #Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22153-1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I close User Details section
    And I stop masquerading


  @TC.22081 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22081 Enable stash for new users of MozyEnterprise(Fortress) partner (local execution = 7min~8min)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22081 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22081
    And I view partner details by Internal Mozy - Fortress 22081
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======purchase resource and create user======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22081_user1 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then new itemized user should be created
    #======check sync device <Enable Sync> checked or not======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22081_user1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    #======delete sync device and check the result======
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
    When I enable stash without send email in user details section
    And I refresh User Details section
    Then user details should be:
      | Name:                   | Enable Sync:                |
      | TC.22081_user1 (change) | Yes (Send Invitation Email) |
    And I close User Details section
    And I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22081
    And I view partner details by Internal Mozy - Fortress 22081
    Then I delete partner account


  @TC.22091 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22091 Disable stash of MozyEnterprise(Fortress) partner (local execution = 12min~13min)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22091 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22091
    And I view partner details by Internal Mozy - Fortress 22091
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======purchase resource and create user======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22091_user1 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then new itemized user should be created
    #======change stash quota to 1 GB======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22091_user1
    And I click change stash quota text box
    And I change itemized user stash quota to 1 GB
    And I stop masquerading
    #======disable sync at partner level======
    When I search partner by Internal Mozy - Fortress 22091
    And I view partner details by Internal Mozy - Fortress 22091
    And I disable stash for the partner
    Then I act as newly created partner
    #======After disabled the sync at partner level, check user detail device table======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22091_user1
    Then the message should be No computers when itemized user has sync disabled
    And sync checkbox should be invisible when creating a new itemized user
    And I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22091
    And I view partner details by Internal Mozy - Fortress 22091
    Then I delete partner account


  @TC.22092 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22092 Add Stash to All Users In User Group Detail of MozyEnterprise(Fortress) (local execution = 7min~8min)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22092 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22092
    And I view partner details by Internal Mozy - Fortress 22092
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======purchase resource and create multiple users======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 3               | 20            | 3              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22092_user1 | 1              | 5            | 1               | 5             | No           | No          |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22092_user2 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22092_user3 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    #======update the storage on user2 and user3======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22092_user2
    And I click change stash quota text box
    Then I change itemized user stash quota to 0 GB
    And I close User Details section
    When I view user details by TC.22092_user3
    And I click change stash quota text box
    Then I change itemized user stash quota to 2 GB
    And I close User Details section
    #======enable sync for all users at group level======
    Given I navigate to List User Groups section from bus admin console page
    When I view (default user group) user group details
    Then I enable stash for all users
    #======refresh the list user table and check Search / List User table======
    Given I navigate to Search / List Users section from bus admin console page
    When I refresh Search List User section
    And Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     | Storage |
      | TC.22092_user3  | (default user group)  | Enabled  | 2 GB    |
      | TC.22092_user2  | (default user group)  | Enabled  | 0       |
      | TC.22092_user1  | (default user group)  | Enabled  | 2 GB    |
    And I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22092
    And I view partner details by Internal Mozy - Fortress 22092
    Then I delete partner account


  @TC.22112 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22112 Enable Stash for New User Group of MozyEnterprise(Fortress) Partner (local execution = 7mins~8mins)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22112 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22112
    And I view partner details by Internal Mozy - Fortress 22112
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======create new user group1 and check the <Enable Sync> is checked======
    Given I navigate to Add New User Group section from bus admin console page
    When I add a new user group for an itemized partner:
      | name   |
      | group1 |
    Then I navigate to List User Groups section from bus admin console page
    And I view group1 user group details
    And User group details should be:
      | Enable Sync:  |
      | Yes           |
    When I purchase resources:
      | user group  | desktop license | desktop quota | server license | server quota |
      | group1      | 3               | 20            | 3              | 20           |
    #======Add a new user with <Enable Sync> and <Send invitation> checked successfully======
    And I add new itemized user(s):
      | user_group | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | group1     | TC.22112_user1 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then new itemized user should be created
    And I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22112
    And I view partner details by Internal Mozy - Fortress 22112
    Then I delete partner account


  @TC.22141 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22141 Enable Stash after disable stash(mozyEnterprise trial(Fortress)) (Local Execution = 10mins~11mins)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22141 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22141
    And I view partner details by Internal Mozy - Fortress 22141
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======pusrchase resource for (default user group) and create a user======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 3               | 20            | 3              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22141_user1 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then new itemized user should be created
    But I stop masquerading
    #======disable stash on partner level======
    When I search partner by Internal Mozy - Fortress 22141
    And I view partner details by Internal Mozy - Fortress 22141
    But I disable stash for the partner
    Then I act as newly created partner account
    #======After disabling <Sync Enable> at partner level, user device table is empty, no computer======
    Given I navigate to Search / List Users section from bus admin console page
    When I view user details by TC.22141_user1
    Then the message should be No computers when itemized user has sync disabled
    And I stop masquerading
    #======enable stash again at partner level======
    When I search partner by Internal Mozy - Fortress 22141
    And I view partner details by Internal Mozy - Fortress 22141
    But I enable stash for the partner
    Then I act as newly created partner account
    #======after acting as partner, create a new user with sync enabled======
    When I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22141_user2 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then new itemized user should be created
    And I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22141
    And I view partner details by Internal Mozy - Fortress 22141
    Then I delete partner account


  @TC.22143 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22143 Add Stash to all users in partner detail with single user group(mozyenterprise trial(fortress)) (Local Execution = 12min~13min)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22143 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22143
    And I view partner details by Internal Mozy - Fortress 22143
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
    #======purchase resource for (default user group) and create two users======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 3               | 20            | 3              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22143_user1 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash | send_invite |
      | TC.22143_user2 | 1              | 5            | 1               | 5             | Yes          | Yes         |
    Then I stop masquerading
    #======disable sync at partner level and check partner detail======
    When I search partner by Internal Mozy - Fortress 22143
    And I view partner details by Internal Mozy - Fortress 22143
    But I disable stash for the partner
    And I refresh the partner details section
    Then Partner general information should be:
      | Enable Sync:  |
      | No            |
    #======enable the sync again at partner level======
    When I enable stash for the partner
    And I act as newly created partner account
    #======check each user's sync status======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync      |
      | TC.22143_user2  | (default user group)  | Disabled  |
      | TC.22143_user1  | (default user group)  | Disabled  |
    When I view user details by TC.22143_user2
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    When I view user details by TC.22143_user1
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    Then I stop masquerading
    #======enable sync for all users at partner level======
    When I search partner by Internal Mozy - Fortress 22143
    And I view partner details by Internal Mozy - Fortress 22143
    Then I add stash to all users for the partner
    And I act as newly created partner account
    #======check each user's sync status======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22143_user2  | (default user group)  | Enabled  |
      | TC.22143_user1  | (default user group)  | Enabled  |
    When I view user details by TC.22143_user2
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I close User Details section
    When I view user details by TC.22143_user1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I close User Details section
    Then I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22143
    And I view partner details by Internal Mozy - Fortress 22143
    Then I delete partner account


  @TC.22191 @bus @machines_sync @tasks_p3 @regression
  Scenario: 22191 Enable and DIsable cycle by add stash to all users with single user(MozyEnterprise(Fortress)) (Local Execution = 14min~15min)
  #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22191 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22191
    And I view partner details by Internal Mozy - Fortress 22191
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
  #======purchase resource for (default user group) and create two users======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 3               | 20            | 3              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash |
      | TC.22191_user1 | 1              | 5            | 1               | 5             | Yes          |
    #======check the user table for sync======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22191_user1  | (default user group)  | Enabled  |
    When I view user details by TC.22191_user1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I stop masquerading
    #======disable the sync at partner level======
    When I search partner by Internal Mozy - Fortress 22191
    And I view partner details by Internal Mozy - Fortress 22191
    But I disable stash for the partner
    #======check the user detail for sync
    And I refresh the partner details section
    Then Partner general information should be:
      | Enable Sync:  |
      | No            |
    And I act as newly created partner account
    #======check each user's sync======
    When I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table header should be:
      | External ID | User | Name | User Group | Machines | Storage | Storage Used | Created | Backed Up |
    And I stop masquerading
    #======enable the sync again at partner level======
    When I search partner by Internal Mozy - Fortress 22191
    And I view partner details by Internal Mozy - Fortress 22191
    But I enable stash for the partner
    And I act as newly created partner account
    #======check each user's sync======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync      |
      | TC.22191_user1  | (default user group)  | Disabled  |
    When I view user details by TC.22191_user1
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    Then I stop masquerading
    #======enable sync for all users at partner level======
    When I search partner by Internal Mozy - Fortress 22191
    And I view partner details by Internal Mozy - Fortress 22191
    Then I add stash to all users for the partner
    And I act as newly created partner account
   #======check each user's sync======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22191_user1  | (default user group)  | Enabled  |
    When I view user details by TC.22191_user1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And sync device (itemized) info should be:
      | Computer | Encryption | Storage Used      | Last Update |
      | Sync     | Default    | 0 / 2 GB (change) |  N/A        |
    #======delete the sync device======
    When delete (itemized) device Sync by without keeping data
    And I refresh User Details section
    And I refresh Search List User section
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22191_user1  | (default user group)  | Disabled |
    And user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    Then I stop masquerading
    When I search partner by Internal Mozy - Fortress 22191
    And I view partner details by Internal Mozy - Fortress 22191
    Then I delete partner account


  @TC.22192 @bus @machines_sync @tasks_p3
  Scenario: 22192 Enable and Disable cycle by add stash with Single User(MozyEnterprise trial(fortress)) (Local Execution = 11min~12min)
    #======act as Fortress partner======
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | Yes                    |
  #======create a Fortress type partner======
    And I add a new sub partner:
      | Company Name                   |
      | Internal Mozy - Fortress 22192 |
    Then New partner should be created
    And I stop masquerading
    When I search partner by Internal Mozy - Fortress 22192
    And I view partner details by Internal Mozy - Fortress 22192
    And I enable stash for the partner
    And Partner general information should be:
      | Enable Sync: |  Default Sync Storage:  |
      | Yes          |  2 GB                   |
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I act as newly created partner account
  #======purchase resource for (default user group) and create two users======
    When I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 3               | 20            | 3              | 20           |
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop | enable_stash |
      | TC.22192_user1 | 1              | 5            | 1               | 5             | Yes          |
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users table should be:
      | Name            | User Group            | Sync     |
      | TC.22192_user1  | (default user group)  | Enabled  |
    When I view user details by TC.22192_user1
    Then user details should be:
      | Enable Sync:                |
      | Yes (Send Invitation Email) |
    And I stop masquerading
    #======disable the sync at partner level======
    When I search partner by Internal Mozy - Fortress 22192
    And I view partner details by Internal Mozy - Fortress 22192
    But I disable stash for the partner
    And I refresh the partner details section
    Then Partner general information should be:
      | Enable Sync:  |
      | No            |
    And I act as newly created partner account
    #======check each user's sync======
    When I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table header should be:
      | External ID | User | Name | User Group | Machines | Storage | Storage Used | Created | Backed Up |
    And I stop masquerading
    #======enable sync again at partner level======
    When I search partner by Internal Mozy - Fortress 22192
    And I view partner details by Internal Mozy - Fortress 22192
    But I enable stash for the partner
    And I act as newly created partner account
    #======check each user's sync======
    And I navigate to Search / List Users section from bus admin console page
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync      |
      | TC.22192_user1  | (default user group)  | Disabled  |
    When I view user details by TC.22192_user1
    Then user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    #======add sync for user======
    And I enable stash without send email in user details section
    And I refresh User Details section
    And I refresh Search List User section
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22192_user1  | (default user group)  | Enabled  |
    #======delete sync device and check user's detail======
    When delete (itemized) device Sync by without keeping data
    And I refresh User Details section
    And I refresh Search List User section
    Then Search / List Users (itemized) table should be:
      | Name            | User Group            | Sync     |
      | TC.22192_user1  | (default user group)  | Disabled |
    And user details should be:
      | Enable Sync:  |
      | No (Add Sync) |
    And I close User Details section
    Then I stop masquerading
    #======delete partner======
    When I search partner by Internal Mozy - Fortress 22192
    And I view partner details by Internal Mozy - Fortress 22192
    Then I delete partner account