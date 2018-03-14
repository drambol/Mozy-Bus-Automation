Feature: BUS smoke test 3
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04' related scenarios ===================
  @bus_us @TC.125954 @qa @ROR_smoke
  Scenario: Test Case Mozy-125954: BUS US -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                                                     | period | base plan | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04 | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | user with machine | (default user group) | Desktop      | 5             | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5     |
    Then Data shuttle order should be created

  @bus_us @TC.125955 @qa @ROR_smoke
  Scenario: Test Case Mozy-125955: BUS US -- Update Data Shuttle - Precondition:@TC.125954
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    When I cancel the latest data shuttle order for Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    Then The order should be Cancelled

  @bus_us @TC.125954 @std
  Scenario: Test Case Mozy-125954: BUS US -- Order Data Shuttle
    When I order data shuttle for Internal Mozy - DoNotEdit - MozyPro for US Data Shuttle
      | power adapter     | key from  |
      | Data Shuttle EMEA | available |
    Then Data shuttle order should be created

  @bus_us @TC.125955 @std
  Scenario: Test Case Mozy-125955: BUS US -- Update Data Shuttle - Precondition:@TC.125954
    When I search order in view data shuttle orders section by Internal Mozy - DoNotEdit - MozyPro for US Data Shuttle
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    When I cancel the latest data shuttle order for Internal Mozy - DoNotEdit - MozyPro for US Data Shuttle
    Then The order should be Cancelled

  #=====================================
  @bus_us @TC.125958
  Scenario: Test Case Mozy-125958: BUS US -- Delete test partner and validate they are in Pending Delete state
    When I add a new MozyPro partner:
      | company name                                        | period | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Test 5958-2015-10 | 24     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I delete partner and verify pending delete

  #=====================================
  @bus_us @TC.125959
  Scenario: Test Case Mozy-125959: BUS US -- Create a Pro partner (reseller) and verify Partner creation in BUS and Aria
    When I add a new Reseller partner:
      | company name                                         | period | base plan | coupon                | net terms | server plan |
      | Internal Mozy - Reseller BUS Smoke Test 5959-3026-41 | 1      | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner
    And I delete partner account

  #================== partner 'Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83' related scenarios ===================
  @bus_us @TC.125960 @ROR_smoke
  Scenario: Test Case Mozy-125960: BUS US -- Create a Enterprise partner and verify Partner creation in BUS and Aria
    When I add a new MozyEnterprise partner:
      | company name                                               | period | users  | coupon                |  server plan | net terms |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 | 36     | 180     | <%=QA_ENV['coupon']%> |  250 GB      | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner

  #================== partner 'Internal Mozy - Fortress BUS Smoke Test 2940-4826-39' related scenarios ===================
  @bus_us @TC.125961
  Scenario: Test Case Mozy-125961: BUS US -- Create a new Fortress partner and verify Partner creation in BUS and Aria
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                                         |
      | Internal Mozy - Fortress BUS Smoke Test 2940-4826-39 |
    Then New partner should be created
    When I stop masquerading
    And I search partner by Internal Mozy - Fortress BUS Smoke Test 2940-4826-39
    And I view partner details by Internal Mozy - Fortress BUS Smoke Test 2940-4826-39
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I delete partner account

  @bus_us @TC.125983 @qa @ROR_smoke
  Scenario: Test Case Mozy-125983: LDAP Pull - Precondition:@TC.125960
    When I search partner by:
      | name                                                       |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 |
    And I view partner details by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol   | SSL Cert | Port   | Base DN  | Bind Username   | Bind Password   |
      | @server_host | @protocol  |          | @port  | @base_dn | @bind_user      | @bind_password  |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule               | group |
      | cn=dev-17538-test* | dev   |
    And I save the changes
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
  #    Then User search results should be:
  #      | User                     | Name            | User Group |
  #      | dev-17538-test3@test.com | dev-17538-test3 | dev        |
  #      | dev-17538-test2@test.com | dev-17538-test2 | dev        |
  #      | dev-17538-test1@test.com | dev-17538-test1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule               | action |
      | cn=dev-17538-test* | Delete |
    And I save the changes
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

  # precondition:  4 users (matched pullpostqa*) has been created in production ADFS server. Run ruby script/add_new_ldap_user.rb if user not created yet
  @bus_us @TC.125983 @std
  Scenario: Test Case Mozy-125983: LDAP Pull - Precondition:@TC.125960
    When I search partner by:
      | name                                                       |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 |
    And I view partner details by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol   | SSL Cert | Port   | Base DN  | Bind Username   | Bind Password   |
      | @server_host | @protocol  |          | @port  | @base_dn | @bind_user      | @bind_password  |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule           | group |
      | cn=pullpostqa* | dev   |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 4 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
  #    Then User search results should be:
  #      | User                     | Name        | User Group |
  #      | pullpostqa4@aws.mozy.com | pullpostqa4 | dev        |
  #      | pullpostqa3@aws.mozy.com | pullpostqa3 | dev        |
  #      | pullpostqa2@aws.mozy.com | pullpostqa2 | dev        |
  #      | pullpostqa1@aws.mozy.com | pullpostqa1 | dev        |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule           | action |
      | cn=pullpostqa* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 4 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  # precondition:  pullpostqa4@adfs.mozy.com has been created in production ADFS server. Run ruby script/add_new_ldap_user.rb if user not created yet
  @bus_us @TC.125983 @prod
  Scenario: Test Case Mozy-125983: LDAP Pull
    When I act as partner by:
      | name                   |
      | FedID pull PostQA Test |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol   | SSL Cert | Port   | Base DN  | Bind Username   | Bind Password   |
      | @server_host | @protocol  |          | @port  | @base_dn | @bind_user      | @bind_password  |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule            | group |
      | cn=pullpostqa4* | qa    |
    And I click the sync now button
    And I wait for 120 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                  |
      | pullpostqa4@adfs.mozy.com |
    Then User search results should be:
      | User                     | Name        | User Group |
      | pullpostqa4@adfs.mozy.com | pullpostqa4 | qa         |
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule            | action |
      | cn=pullpostqa4* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                  |
      | pullpostqa4@adfs.mozy.com |
    Then The users table should be empty