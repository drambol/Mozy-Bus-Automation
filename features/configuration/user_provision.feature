# If you want to run these testcases in other environment other than QA5, You need to prepare these data
# To do: I will add a new feature to prepare these data automately
# AD server is needed in the environment
# (1). Add some partners with the following partner name and admin if not exist
# | partner name                      | admin                                    | usage                               |
# | Never Synced Test                 | user_sync_never_synced@auto.com          | the partner never synced            |
# | User Sync Automation              | user_sync_automation@auto.com            | general, mainly for the ui          |
# | Fed ID Partner                    | dvg@dvg.dvg                      | users in this partner can login     |
# | Machine Migration for TC16273     | user_sync_add_delete@auto.com            | add/delete users in the AD          |
# | Partner that has subpartner       | usrsync@test.com                         | scheduled sync                      |
# (2). add 3 groups to each partner: dev, qa, pm
# (3). add 9 users to AD server:
# dev_test1/dev_test1@test.com, dev_test2, dev_test3,
# qa_test1/qa_test1@test.com, qa_test2, qa_test3
# pm_test1/pm_test1@test.com, pm_test2, pm_test3
# (4). Update the following files: db_helper.rb, ldap_helper.rb
# configure the db, ldap to match the specified environment

Feature: User sync

  As an Mozy administrator
  I want to sync users from AD
  So that the partner admin can manage their users easily

  Background:
    Given I log in bus admin console as administrator

  @TC.17519 @ui @bus @2.1 @direct_ldap_integration @use_provision @regression @core_function
  Scenario: 17519 Sync Now
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
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
    And I click Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I click the sync now button
    And I wait for 90 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                |
      | Next Sync   | Not Scheduled(Set)                                            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17518 @ui @bus @2.1 @direct_ldap_integration @use_provision @regression @core_function
  Scenario: 17518 17529 17530 17531 17532 17534 17535 17536 Check the user sync UI
    # Scenario: 17518 Check the UI when the partner has never synced(all the UI check)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | pm   | Shared               | 5               | Shared              | 10             |
    Then pm user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | qa   | Shared               | 5               | Shared              | 10             |
    Then qa user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
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
    When I click Connection Settings tab
    Then The sync status result should be:
      | Sync Status | Never Run          |
      | Sync Result |                    |
      | Next Sync   | Not Scheduled(Set) |
    # Scenario: 17529 Check the Attribute mapping UI
    When I click Attribute Mapping tab
    Then The layout of attribute should:
      | Mozy              | Username:      | Name:      |Fixed Attribute |
      | Directory Service | mail           |  cn        |                |
    When I save the changes
    Then Authentication Policy has been updated successfully
    # Scenario: 17530 Local groups dropdown list check
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule         | group|
      | cn=dev_test* |      |
    Then There should be 4 provision items:
      | (default user group) | dev | pm | qa |
    And I delete all the rules
    # Scenario: 17531 User provision - Rules ordering interaction
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
    Then The provision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the provision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new provision rules order should be:
      | rule         | group|
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
      | cn=dev_test* | dev  |
    When I save the changes
    Then Authentication Policy has been updated successfully
    And I delete 3 provision rules
    And I save the changes
    # Scenario: 17532 User provision - Delete rules
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | dev  |
      | cn=qa_test*  | dev  |
    And I delete 1 provision rules
    And I save the changes
    Then The provision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 provision rules
    And I save the changes
    Then The provision rule number is 0
    And Authentication Policy has been updated successfully
    # Scenario: 17534 UserDestruction - UI Components check
    When I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      | cn=dev_test* |        |
    Then There should be 3 deprovision items:
      | Take no action | Suspend | Delete |
    And The selected deprovision option is Take no action
    And I delete all the rules
    # Scenario: 17535 UserDestruction - Rules ordering interaction
    When I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action  |
      | cn=dev_test* | Delete  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
    Then The deprovision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the deprovision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new deprovision rules order should be:
      | rule         | action  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
      | cn=dev_test* | Delete  |
    When I save the changes
    Then Authentication Policy has been updated successfully
    And I delete 3 deprovision rules
    And I save the changes
    # Scenario: 17536 UserDestruction - Rules deletion
    When I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action |
      | cn=dev_test* | Delete |
      | cn=pm_test*  | Delete |
      | cn=qa_test*  | Delete |
    And I delete 1 deprovision rules
    When I save the changes
    Then The deprovision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 deprovision rules
    And I save the changes
    Then The deprovision rule number is 0
    And Authentication Policy has been updated successfully
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17538  @smoke @function @bus @2.1 @direct_ldap_integration @use_provision @user_deconstruction @regression @core_function
  Scenario: 17538 17551 Provision and Deprovision Users with One Rule/Match All/Multiple
    Given I delete a user %17538-test% in the demeter db
    # Scenario: 17538 17551 One Rule/Match All/Multiple Users
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
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
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17538-test* | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 3 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17538-test3@test.com | dev-17538-test3 | dev        |
      | dev-17538-test2@test.com | dev-17538-test2 | dev        |
      | dev-17538-test1@test.com | dev-17538-test1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule               | action |
      | cn=dev-17538-test* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 3 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17540 @TC.17552 @TC.17542 @TC.17554 @TC.17543 @TC.17557  @function @bus @2.1 @direct_ldap_integration @use_provision @user_deconstruction @regression @core_function
  Scenario: 17540 17552 17542 17554 17543 17557 17554 User sync with different conditions
    Given I delete a user %17540-test% in the demeter db
    # Scenario: 17540 One Rule/Multiple Rules
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | pm   | Shared               | 5               | Shared              | 10             |
    Then pm user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | qa   | Shared               | 5               | Shared              | 10             |
    Then qa user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
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
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                                                                                    | group |
      | (&(objectClass=user)(\|(\|(cn=dev-17540-test*)(cn=pm-17540-test*))(cn=qa-17540-test*))) | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 9 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | qa-17540-test3@test.com  | qa-17540-test3  | dev        |
      | qa-17540-test2@test.com  | qa-17540-test2  | dev        |
      | qa-17540-test1@test.com  | qa-17540-test1  | dev        |
      | pm-17540-test3@test.com  | pm-17540-test3  | dev        |
      | pm-17540-test2@test.com  | pm-17540-test2  | dev        |
      | pm-17540-test1@test.com  | pm-17540-test1  | dev        |
      | dev-17540-test3@test.com | dev-17540-test3 | dev        |
      | dev-17540-test2@test.com | dev-17540-test2 | dev        |
      | dev-17540-test1@test.com | dev-17540-test1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule                                                                  | action  |
      | (&(objectClass=user)(\|(\|(cn=dev-17540-test*)(cn=pm-17540-test*))(cn=qa-17540-test*))) | Delete  |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 9 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    # Scenario: 17542 17554 Multiple Ruls/Multiple Users
    Given I delete a user %17542-test% in the demeter db
    When I navigate to Authentication Policy section from bus admin console page
    And I click Sync Rules tab
    And I add 3 new provision rules:
      | rule               | group |
      | cn=dev-17542-test* | dev   |
      | cn=pm-17542-test*  | pm    |
      | cn=qa-17542-test*  | qa    |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 9 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     |   Name              | User Group  |
      | qa-17542-test3@test.com  |   qa-17542-test3    | qa          |
      | qa-17542-test2@test.com  |   qa-17542-test2    | qa          |
      | qa-17542-test1@test.com  |   qa-17542-test1    | qa          |
      | pm-17542-test3@test.com  |   pm-17542-test3    | pm          |
      | pm-17542-test2@test.com  |   pm-17542-test2    | pm          |
      | pm-17542-test1@test.com  |   pm-17542-test1    | pm          |
      | dev-17542-test3@test.com |   dev-17542-test3   | dev         |
      | dev-17542-test2@test.com |   dev-17542-test2   | dev         |
      | dev-17542-test1@test.com |   dev-17542-test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule               | action   |
      | cn=dev-17542-test* | Delete   |
      | cn=pm-17542-test*  | Delete   |
      | cn=qa-17542-test*  | Delete   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 9 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    # Scenario: 17543 17557 17558 Multiple Ruls/Multiple Users/Rule order matters
    Given I delete a user %17543-test% in the demeter db
    When I navigate to Authentication Policy section from bus admin console page
    And I click Sync Rules tab
    And I add 4 new provision rules:
      | rule               | group |
      | cn=dev-17543-test* | dev   |
      | cn=pm-17543-test*  | dev   |
      | cn=pm-17543-test*  | pm    |
      | cn=qa-17543-test*  | qa    |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 4 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 9 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     |   Name              | User Group  |
      | qa-17543-test3@test.com  |   qa-17543-test3    | qa          |
      | qa-17543-test2@test.com  |   qa-17543-test2    | qa          |
      | qa-17543-test1@test.com  |   qa-17543-test1    | qa          |
      | pm-17543-test3@test.com  |   pm-17543-test3    | dev         |
      | pm-17543-test2@test.com  |   pm-17543-test2    | dev         |
      | pm-17543-test1@test.com  |   pm-17543-test1    | dev         |
      | dev-17543-test3@test.com |   dev-17543-test3   | dev         |
      | dev-17543-test2@test.com |   dev-17543-test2   | dev         |
      | dev-17543-test1@test.com |   dev-17543-test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 2 new deprovision rules:
      | rule               | action         |
      | cn=dev-17543-test* | Take no action |
      | cn=dev-17543-test* | Delete         |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 2 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 3 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     |   Name               | User Group  |
      | qa-17543-test3@test.com  |   qa-17543-test3    | qa          |
      | qa-17543-test2@test.com  |   qa-17543-test2    | qa          |
      | qa-17543-test1@test.com  |   qa-17543-test1    | qa          |
      | pm-17543-test3@test.com  |   pm-17543-test3    | dev         |
      | pm-17543-test2@test.com  |   pm-17543-test2    | dev         |
      | pm-17543-test1@test.com  |   pm-17543-test1    | dev         |
      | dev-17543-test3@test.com |   dev-17543-test3   | dev         |
      | dev-17543-test2@test.com |   dev-17543-test2   | dev         |
      | dev-17543-test1@test.com |   dev-17543-test1   | dev         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule               | action   |
      | cn=dev-17543-test* | Delete   |
      | cn=pm-17543-test*  | Delete   |
      | cn=qa-17543-test*  | Delete   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 9 succeeded, 0 failed |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    # Scenario: 17544 UserProvision - Multiple Ruls/Multiple Users/Change Rules
    Given I delete a user %17544-test% in the demeter db
    When I navigate to Authentication Policy section from bus admin console page
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group |
      | cn=dev-17544-test* | dev   |
      | cn=pm-17544-test*  | pm    |
      | cn=qa-17544-test*  | qa    |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 9 succeeded, 0 failed \| Users Deprovisioned: 0 |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User               |      Name     | User Group |
      | qa-17544-test3@test.com  |   qa-17544-test3    | qa         |
      | qa-17544-test2@test.com  |   qa-17544-test2    | qa         |
      | qa-17544-test1@test.com  |   qa-17544-test1    | qa         |
      | pm-17544-test3@test.com  |   pm-17544-test3    | pm         |
      | pm-17544-test2@test.com  |   pm-17544-test2    | pm         |
      | pm-17544-test1@test.com  |   pm-17544-test1    | pm         |
      | dev-17544-test3@test.com |   dev-17544-test3   | dev        |
      | dev-17544-test2@test.com |   dev-17544-test2   | dev        |
      | dev-17544-test1@test.com |   dev-17544-test1   | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group |
      | cn=dev-17544-test* | (default user group)   |
      | cn=pm-17544-test*  | (default user group)   |
      | cn=qa-17544-test*  | (default user group)   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 9 succeeded, 0 failed \| Users Deprovisioned: 0 |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User               |      Name     | User Group  |
      | qa-17544-test3@test.com  |   qa-17544-test3    | (default user group)        |
      | qa-17544-test2@test.com  |   qa-17544-test2    | (default user group)        |
      | qa-17544-test1@test.com  |   qa-17544-test1    | (default user group)        |
      | pm-17544-test3@test.com  |   pm-17544-test3    | (default user group)        |
      | pm-17544-test2@test.com  |   pm-17544-test2    | (default user group)        |
      | pm-17544-test1@test.com  |   pm-17544-test1    | (default user group)        |
      | dev-17544-test3@test.com |   dev-17544-test3   | (default user group)        |
      | dev-17544-test2@test.com |   dev-17544-test2   | (default user group)        |
      | dev-17544-test1@test.com |   dev-17544-test1   | (default user group)        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action   |
      | cn=dev-17544-test* | Delete   |
      | cn=pm-17544-test*  | Delete   |
      | cn=qa-17544-test*  | Delete   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 3 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 9 succeeded, 0 failed |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17559 @function @bus @2.1 @direct_ldap_integration @user_deconstruction @regression @core_function
  Scenario: 17559 17560 Error cases for user sync
    # Scenario: 17559 Empty rules will be filtered
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Connection Settings tab
    When I Test Connection for AD
    Then test connection message should be Test passed
    When I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      |              |        |
    And I save the changes
    Then Authentication Policy has been updated successfully
    # Scenario: 17560 Unknown query string
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      | abcd         |        |
    And I save the changes
    Then The save error message should be:
      | Save failed                          |
      | 400 Invalid LDAP queries: abcd       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17592 @firefox_profile @bus @2.1 @direct_ldap_integration @use_provision @qa8 @regression @core_function @subdomain @ROR_smoke
  Scenario: 17592 UserProvision - Deleted users in BUS can be resumed
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    Then The user status should be Active
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name <%=CONFIGS['fedid']['user_email']%> and password QAP@SSw0rd
    Then I will see the user account page

    When I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule     | action |
      | cn=auto1 | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter |
      | <%=CONFIGS['fedid']['user_email']%> | None   |
    Then The users table should be empty
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the Authentication Failed page

    When I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 60 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group  |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev         |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    Then The user status should be Active
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the user account page
    ## clear data
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule     | action |
      | cn=auto1 | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes

  @TC.17593 @firefox_profile  @bus @2.1 @direct_ldap_integration @use_provision @qa8 @regression @core_function @subdomain
  Scenario: 17593 UserProvision - Suspended users in BUS can't be resumed
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    Then The user status should be Active
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name <%=CONFIGS['fedid']['user_email']%> and password QAP@SSw0rd
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule     | action  |
      | cn=auto1 | Suspend |
    And I click the sync now button
    And I wait for 60 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    And The user status should be Suspended
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the Authentication Failed page

    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 60 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                 | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%>  | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    Then The user status should be Suspended
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the Authentication Failed page

    And I log in bus admin console as administrator
    And I act as partner by:
      | email                       |
      |qa8+saml+test+admin@mozy.com |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    And I view user details by <%=CONFIGS['fedid']['user_email']%>
    And I activate the user
     ## clear data
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule     | action |
      | cn=auto1 | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes

  @TC.17594 @firefox_profile @bus @2.1 @direct_ldap_integration @use_provision @qa8 @regression @core_function @subdomain
  Scenario: 17594 UserProvision - Delete user after several days of not synced
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    And I get the user id
    And I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name <%=CONFIGS['fedid']['user_email']%> and password QAP@SSw0rd
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I Choose to delete users if missing from LDAP for 60 days
    And I change the user last sync field in the db to be 60 days earlier
    And I click the sync now button
    And I wait for 100 seconds
    And I clear the user sync information
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                      |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter |
      | <%=CONFIGS['fedid']['user_email']%> | None   |
    Then The users table should be empty
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the Authentication Failed page

  @TC.17595 @firefox_profile @bus @2.1 @direct_ldap_integration @use_provision @qa8 @regression @core_function @subdomain
  Scenario: 17595 UserProvision - Suspend user after several days of not synced
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule     | group |
      | cn=auto1 | dev   |
    And I click the sync now button
    And I wait for 60 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    And I get the user id
    And I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name <%=CONFIGS['fedid']['user_email']%> and password QAP@SSw0rd
    Then I will see the user account page

    When I log in bus admin console as administrator
    And I act as partner by:
      | email                       |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I Choose to suspend users if missing from LDAP for 60 days
    And I change the user last sync field in the db to be 60 days earlier
    And I click the sync now button
    And I wait for 60 seconds
    And I clear the user sync information
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                      |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    Then User search results should be:
      | User                                | Name                               | User Group |
      | <%=CONFIGS['fedid']['user_email']%> | <%=CONFIGS['fedid']['user_name']%> | dev        |
    When I view user details by <%=CONFIGS['fedid']['user_email']%>
    Then The user status should be Suspended
    When I login the subdomain <%=CONFIGS['fedid']['subdomain']%>
    Then I will see the Authentication Failed page

    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                            | filter | user type                  |
      | <%=CONFIGS['fedid']['user_email']%> | None   | <%=@current_partner_name%> |
    And I view user details by <%=CONFIGS['fedid']['user_email']%>
    And I activate the user
    # clear data
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule     | action |
      | cn=auto1 | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes

  @TC.17546 @bus @2.1 @direct_ldap_integration @use_provision @regression @core_function
  Scenario: 17546 17548 17549 18723 UserProvision/Sync - Add(Delete, Modify) a new user in AD
    Given I delete a user %17546-test% in the demeter db
    # Scenario: 17546 UserProvision/Sync - Add(Delete, Modify) a new user in AD
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | pm   | Shared               | 5               | Shared              | 10             |
    Then pm user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | qa   | Shared               | 5               | Shared              | 10             |
    Then qa user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I delete a user dev-17546-test2 in the AD
    And I delete a user dev-17546-test3 in the AD
    And I click Connection Settings tab
    When I Test Connection for AD
    Then test connection message should be Test passed
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 130 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add a user dev-17546-test2 to the AD
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 2 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test2@test.com | dev-17546-test2 | dev        |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I modify the username from dev-17546-test2 to dev-17546-test3 for user dev-17546-test2@test.com in the AD
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 2 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test2@test.com | dev-17546-test3 | dev        |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I modify the username from dev-17546-test3 to dev-17546-test2 for user dev-17546-test2@test.com in the AD
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 2 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test2@test.com | dev-17546-test2 | dev        |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule               | action |
      | cn=dev-17546-test* | Delete |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 2 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
    And I delete a user dev-17546-test2 in the AD

    # Scenario: 18723 UserProvision-Fixed Attribute
    And I wait for 300 seconds
    And I navigate to Authentication Policy section from bus admin console page
    And I click Attribute Mapping tab
    And I set the fixed attribute to uid
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add a user dev-17546-test2 to the AD
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 2 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test2@test.com | dev-17546-test2 | dev        |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I update a user in the AD:
      | username        | attribute | value                    |
      | dev-17546-test2 | mail      | dev-17546-test0@test.com |
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17546-test* | dev   |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 2 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                     | Name            | User Group |
      | dev-17546-test0@test.com | dev-17546-test2 | dev        |
      | dev-17546-test1@test.com | dev-17546-test1 | dev        |

    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule               | action |
      | cn=dev-17546-test* | Delete |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 deprovision rules
    And I click Attribute Mapping tab
    And I clear the fixed attribute
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 2 succeeded, 0 failed |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

    And I delete a user dev-17546-test2 in the AD
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.17521 @scheduled_sync  @bus @2.1 @direct_ldap_integration @use_provision @regression @core_function
  Scenario: 17521 17522 17523 17520 Scheduled Sync (UI, cancel)
    # Scenario: 17521 Scheduled Sync (UI, cancel)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
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
    And I choose to daily sync at 0 GMT
    And I click the sync now button
    And I wait for 80 seconds
    Then The daily sync time should be 0 GMT
    When I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                      |
      | Next Sync   | 0                                                                   |
    And I click Sync Rules tab
    And I clear the daily sync information
    And I click the sync now button
    And I wait for 80 seconds
    Then The daily sync time should be empty
    When I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                      |
      | Next Sync   | Not Scheduled(Set)                                                  |
    # Scenario: 17520 Scheduled Sync
    When I click Sync Rules tab
    And I choose to sync daily at the nearest sharp time
    And I save the changes
    And I wait until the sharp time
    And I wait for 80 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0                      |
      | Next Sync   | @next_sync_time                                                     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.121745 @firefox @direct_ldap_integration @qa8 @bus @env_dependent @regression @core_function
  Scenario: 121745 Error during ssosync will reflect in the UI
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.99.123 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 110 seconds
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Failed at %m/%d/%y %H:%M %:z \(duration about (\d+\.\d+ seconds*\|\d+ minutes*)\) |
      | Sync Result | Cannot connect to the LDAP server. Blocked Deprovision                            |
      | Next Sync   | Not Scheduled(Set)                                                                |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.121744 @firefox @direct_ldap_integration @qa8 @bus @env_dependent @regression @core_function
  Scenario: 121744 non-ASCII in cn can be synced
    Given I delete a user %fedid_encoding% in the demeter db
    When I act as partner by:
      | email                   |
      | encoding_fedid@auto.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                 | group                |
      | mail=fedid_encoding* | (default user group) |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 15 succeeded, 0 failed \| Users Deprovisioned: 0 |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                           | Name                     | User Group           |
      | fedid_encoding10@mtdev.mozy... | ИЙКЛ                     | (default user group) |
      | fedid_encoding11@mtdev.mozy... | 刘某                     | (default user group) |
      | fedid_encoding12@mtdev.mozy... | \x{E4BD}\x{A0E4}\x{BBAC} | (default user group) |
      | fedid_encoding13@mtdev.mozy... | ∏                        | (default user group) |
      | fedid_encoding14@mtdev.mozy... | ‰                        | (default user group) |
      | fedid_encoding15@mtdev.mozy... | fedid_encoding15         | (default user group) |
      | fedid_encoding1@mtdev.mozyp... | Ä                        | (default user group) |
      | fedid_encoding2@mtdev.mozyp... | Español                  | (default user group) |
      | fedid_encoding3@mtdev.mozyp... | Français                 | (default user group) |
      | fedid_encoding4@mtdev.mozyp... | abc%123                  | (default user group) |
      | fedid_encoding5@mtdev.mozyp... | Italiano                 | (default user group) |
      | fedid_encoding6@mtdev.mozyp... | 日本語                   | (default user group) |
      | fedid_encoding7@mtdev.mozyp... | ɣ                        | (default user group) |
      | fedid_encoding8@mtdev.mozyp... | Português                | (default user group) |
      | fedid_encoding9@mtdev.mozyp... | العربية                  | (default user group) |
    And I navigate to Authentication Policy section from bus admin console page
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule    | group |
      | cn=刘某 | Test  |
    And I click the sync now button
    And I wait for 60 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0 |
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule    | action |
      | cn=ИЙКЛ | Delete |
    And I click the sync now button
    And I wait for 50 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed |
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule                 | action |
      | mail=fedid_encoding* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 15 succeeded, 0 failed |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty
