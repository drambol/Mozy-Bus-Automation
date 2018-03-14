Feature: BUS smoke test 1 with blue green env switch
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I switch hosts to blue

  @blue_green
  Scenario: Test Case Mozy-125935: BUS US -- Create a new partner
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I switch hosts to green
    And I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       | Root Admin   |
      | @company_name | @admin_email |

  @blue_green
  Scenario: Test Case Mozy-125936: BUS US -- Partner Details - License Keys - Precondition:@TC.125935
    When I search partner by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And I switch hosts to green
    When I search partner by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |

  @blue_green
  Scenario: Test Case Mozy-125940: BUS US -- Create a user group - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And I add a new Bundled user group:
      | name  | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to User Group List section from bus admin console page
    Then Bundled user groups table should be:
      | Group Name           | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group) | true  | true   | Shared       |            | 0            | 0            |
      | alpha                | false | false  | Shared       |            | 0            | 0            |

  @blue_green
  Scenario: Test Case Mozy-125941: BUS US -- Create a user - Precondition:@TC.125940
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add new user(s):
      | name               | user_group | storage_type |  devices |
      | user without stash | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    Then user details should be:
      | Name:                       |
      | user without stash (change) |

  @blue_green
  Scenario: Test Case Mozy-125942: BUS US -- Update a username & password - Precondition:@TC.125941
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    When edit user details:
      | email                         |
      | update_username_test@test.com |
    Then I update the user password to Test12345
    And I switch hosts to green without login bus
    And I navigate to bus admin console login page
    And I log in bus admin console with user name update_username_test@test.com and password Test12345

  @blue_green
  Scenario: Test Case Mozy-125943: BUS US -- Move the user from one user group to a different user group - Precondition:@TC.125941
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add a new Bundled user group:
      | name  | storage_type | limited_quota | enable_stash | server_support |
      | omega | Limited      | 5             | yes          | yes            |
    Then omega user group should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    But I reassign the user to user group omega
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    Then the user's user group should be omega
    When I close user details section

  @blue_green
  Scenario: Test Case Mozy-125944: BUS US -- User Details - Send Keys - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | user with stash | (default user group) | Desktop      | 2             | 3       | yes          |
    Then 1 new user should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user with stash
    Then user details should be:
      | Name:                    | Enable Sync:                |
      | user with stash (change) | Yes (Send Invitation Email) |
    And I view the user's product keys
    Then Number of Desktop activated keys should be 0
    And Number of Desktop unactivated keys should be 3
    When I click Send Keys button
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)

  @blue_green
  Scenario: Test Case Mozy-125947: BUS US -- Create an admin - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | User Group           | Roles                   |
      | sub admin | (default user group) | Bundle Pro Partner Root |
    Then Add New Admin success message should be displayed
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to List Admins section from bus admin console page
    Then Admin information in List Admins section should be correct
      | Name      | User Groups          | Role                    |
      | sub admin | (default user group) | Bundle Pro Partner Root |

  @blue_green
  Scenario: Test Case Mozy-125948: BUS US -- Create a role - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name     |
      | new role |
    And I check all the capabilities for the new role
    And I close the role details section
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name                | Roles    | User Group          |
      | admin with new role | new role |(default user group) |
    Then Add New Admin success message should be displayed
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to List Admins section from bus admin console page
    Then Admin information in List Admins section should be correct
      | Name                | User Groups          | Role                    |
      | admin with new role | (default user group) | new role                |
      | sub admin           | (default user group) | Bundle Pro Partner Root |

  @blue_green
  Scenario: Test Case Mozy-125950: BUS US -- Open all of the Resources header to open all of the modules - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page

  @blue_green
  Scenario: Test Case Mozy-125956: BUS US -- Delete test user - Precondition:@TC.125943
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add new user(s):
      | name           | user_group | storage_type |  devices |
      | user to delete | omega      | Server       |  1       |
    Then 1 new user should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user to delete
    Then user details should be:
      | Name:                   |
      | user to delete (change) |
    And I delete user

  @blue_green
  Scenario: Test Case Mozy-125957: BUS US -- Delete test user group - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add a new Bundled user group:
      | name  | storage_type | assigned_quota | enable_stash | server_support |
      | gamma | Assigned     | 3              | yes          | yes            |
    Then gamma user group should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: gamma
    Then gamma user group should be deleted

  @blue_green
  Scenario: Test Case Mozy-125938: BUS US -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                         | period | base plan | coupon                | net terms | server plan |
      | Internal Mozy - Reseller BUS Smoke Test 3849-7653-73 | 1      | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         |
    And New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I switch hosts to green
    And I search partner by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    And I view partner details by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    And I delete partner account

  @blue_green
  Scenario: Test Case Mozy-125945: BUS US -- User Details - Change Partners
    When I add a new OEM partner:
      | Company Name                                    | Root role         | Security | Company Type     |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    And I wait for 5 seconds
    And I stop masquerading
    And I search partner by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    And I view partner details by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I switch hosts to green
    When I act as partner by:
      | name                                            |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    And I switch hosts to blue
    When I act as partner by:
      | name                                            |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 |
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name                               | Pricing Plan | Admin Name |
      | Internal Mozy - subpartner1 8376-3615-73   | subplan      | subadmin1  |
    Then New partner should be created
    And I switch hosts to green
    And I search partner by Internal Mozy - subpartner1 8376-3615-73
    And I view partner details by Internal Mozy - subpartner1 8376-3615-73
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    And I add new itemized user(s):
      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
      | oem user | 1              | 10           | 1               | 10            |
    And new itemized user should be created
    And I switch hosts to blue
    When I act as partner by:
      | name                                            |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 |
    And I add a new sub partner:
      | Company Name                               | Pricing Plan | Admin Name |
      | Internal Mozy - subpartner2 4974-9147-43   | subplan      | subadmin2  |
    Then New partner should be created
    And I switch hosts to green
    And I search partner by Internal Mozy - subpartner2 4974-9147-43
    And I view partner details by Internal Mozy - subpartner2 4974-9147-43
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I switch hosts to blue
    When I act as partner by:
      | name                                            |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 |
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by oem user
    When I reassign the user to partner Internal Mozy - subpartner2 4974-9147-43
    Then I stop masquerading as sub partner
    And I search partner by Internal Mozy - subpartner1 8376-3615-73
    And I view partner details by Internal Mozy - subpartner1 8376-3615-73
    And I delete partner account
    And I search partner by Internal Mozy - subpartner2 4974-9147-43
    And I view partner details by Internal Mozy - subpartner2 4974-9147-43
    And I delete partner account
    And I search partner by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    And I view partner details by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    And I delete partner account

  @blue_green
  Scenario: Test Case Mozy-125951: BUS US -- Change plan for the partner
    When I add a new MozyPro partner:
      | company name                                                | period | base plan | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22 | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
#    Then Change plan charge summary should be:
#      | Description                   | Amount   |
#      | Credit for remainder of plans | -$293.58 |
#      | Charge for upgraded plans     | $566.58  |
#      |                               |          |
#      | Total amount to be charged    | $273.00  |
    And the MozyPro account plan should be changed
    Then MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | yes         |
    And I switch hosts to green
    And I search partner by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    Then I delete partner account

  @blue_green
  Scenario: Test Case Mozy-125952: BUS US -- Run a report
    When I add a new MozyEnterprise partner:
      | company name                                                      | period | users  | coupon                |  server plan | net terms |
      | Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02 | 12     | 10     | <%=QA_ENV['coupon']%> |  100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Scheduled Reports section from bus admin console page
    And Scheduled report list should be:
      | Name                | Type            | Schedule | Actions |
      | billing detail test | Billing Detail  | Daily    | Run     |
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | Server GB Purchased         | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop GB Purchased         | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
      | @name    | (default user group)  |              | N/A                | Shared                      | N/A                         | 0                      | 200                   | 0                     | 0                                      | Shared                       | N/A                          | 0                       | 10                     | 0                      | 0                                       |                                    |                                     | $0.36                  |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
      | Column A | Column B | Column C | Column D  |
      | Date     | Amount   | Card #   | Card Type |

  @blue_green
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
    And I switch hosts to green
    When I order data shuttle for Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 5     |
    Then Data shuttle order should be created

  @blue_green
  Scenario: Test Case Mozy-125955: BUS US -- Update Data Shuttle - Precondition:@TC.125954
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    And I switch hosts to green
    When I cancel the latest data shuttle order for Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    Then The order should be Cancelled

  @blue_green
  Scenario: Test Case Mozy-125960: BUS US -- Create a Enterprise partner and verify Partner creation in BUS and Aria
    When I add a new MozyEnterprise partner:
      | company name                                               | period | users  | coupon                |  server plan | net terms |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 | 36     | 180     | <%=QA_ENV['coupon']%> |  250 GB      | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    And I switch hosts to green
    And I search partner by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    And I view partner details by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    But I activate the partner

  @blue_green
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
    And I switch hosts to green
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 |
    And I navigate to Authentication Policy section from bus admin console page
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
    And I switch hosts to blue
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 |
    And I navigate to Authentication Policy section from bus admin console page
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
    And I switch hosts to green
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83 |
    And I navigate to Authentication Policy section from bus admin console page
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 3 succeeded, 0 failed  |
    When I navigate to Search / List Users section from bus admin console page
    Then The users table should be empty

  @blue_green
  Scenario: Test Case Mozy-125968: BUS EMEA -- Create a user group - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-1 | Shared       |
    Then test-group-1 user group should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should include:
      | Group Name            | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group)  | true  | true   | Shared       |            | 0            | 0            |
      | test-group-1          | false | false  | Shared       |            | 0            | 0            |

  @blue_green
  Scenario: Test Case Mozy-125969: BUS EMEA -- Create a user - Precondition:@TC.125968
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    And I add new user(s):
      | name        | user_group   | storage_type  | storage_limit | devices |
      | EMEA-user-1 | test-group-1 | Desktop       | 10            | 1       |
    Then 1 new user should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group    | Sync     | Storage         |
      | EMEA-user-1 | test-group-1  | Disabled | 10 GB (Limited) |

  @blue_green
  Scenario: Test Case Mozy-125973: BUS EMEA -- Run a report
    When I add a new MozyPro partner:
      | company name                                                      | period  | base plan | create under   | net terms | country | coupon                |
      | Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56 | 12      | 50 GB     | MozyPro France | yes       | France  | <%=QA_ENV['coupon']%> |
    Then New partner should be created
    Then I change root role to Business Root
    When I act as newly created partner account
    When I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Scheduled Reports section from bus admin console page
    And Scheduled report list should be:
      | Name                | Type            | Schedule | Actions |
      | billing detail test | Billing Detail  | Daily    | Run     |
    When I download billing detail test scheduled report
    Then Scheduled Billing Detail report csv file details should be:
      | Column A | Column B              | Column C     | Column D           | Column E             | Column F             | Column G        | Column H       | Column I       | Column J                        | Column Q                     | Column S               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | GB Purchased         | Quota Allocated (GB) | Quota Used (GB) | Keys Purchased | Keys Activated | Keys Assigned But Not Activated | Effective price per  license | Effective price per GB |
      | @name    | (default user group)  |              | Shared             | N/A                  | N/A                  | 0               | 0              | 0              | 0                               |                              | €0.32                  |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
      | Column A | Column B | Column C | Column D  |
      | Date     | Amount   | Card #   | Card Type |

  @blue_green
  Scenario: Test Case Mozy-125977: BUS EMEA -- Delete test user - Precondition:@TC.125969
    When I act as partner by:
      | name                                                        |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27  |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I switch hosts to green
    When I act as partner by:
      | name                                                        |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27  |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I delete user

  @blue_green
  Scenario: Test Case Mozy-125978: BUS EMEA -- Delete test user group - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-2 | Shared       |
    Then test-group-2 user group should be created
    And I switch hosts to green
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I navigate to User Group List section from bus admin console page
    Then Bundled user groups table should include:
      | Group Name            | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group)  | true  | true   | Shared       |            | 0            | 0            |
      | test-group-2          | false | false  | Shared       |            | 0            | 0            |
    When I delete user group details by name: test-group-2

  @blue_green
  Scenario: Test Case Mozy-125966: BUS EMEA -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                                 | period | base plan | create under    | server plan | net terms | country | coupon                |
      | Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90 | 12     | 10 GB     | MozyPro Ireland | yes         | yes       | Ireland | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully

  @blue_green
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                                                            | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07 | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 10    |
    Then Data shuttle order should be created

  @blue_green
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle - Precondition:@TC.125975
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    And I switch hosts to green
    When I cancel the latest data shuttle order for Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    Then The order should be Cancelled

  @blue_green
  Scenario: 21212 [Itemized]GET /client/user/resources API for desktop user with stash and machines
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21212.User | (default user group) | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 0      | 0      | 3       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21212 | Desktop      |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21212 | Desktop      |
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 2      | 0      | 3       |
    And I enable stash without send email in user details section
    Then Get client user resources api result should be
      | stash | backup | server | desktop |
      | 1     | 2      | 0      | 3       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 880 Edit the name on an account
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 50 GB     | yes       |
    Then New partner should be created
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    When I change the display name to auto test account
    Then display name changed success message should be displayed
    And I switch hosts to green and act as newly created partner
    Then I navigate to Account Details section from bus admin console page
    Then the display name should be auto test account
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 501 Delete client configuration
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |  net terms |
      |   1    |  Silver         | 1000           |      yes     |      yes   |
    Then New partner should be created
    And I act as newly created partner account
    When I create a new client config:
      | name                 |
      | TC.501_client_config |
    Then client configuration section message should be Your configuration was saved.
    And I switch hosts to green and act as newly created partner
    And I delete configuration TC.501_client_config
    Then client configuration section message should be Client config deleted successfully
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: check machine's adr_policy_name when no adr policy set
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133059    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
    #======step5: delete machine======
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    Then I view user details by ugdf_user2
    And I view machine ugdf_user2_machine_1 details from user details section
    When I delete device by name: ugdf_user2_machine_1
    And the popup message when delete device is Do you want to delete ugdf_user2_machine_1?
    And I refresh User Details section
    Then Device ugdf_user2_machine_1 should not show
    And I close User Details section
    #======step6: stop masquerading from partner======
    And I stop masquerading
    #======step7: search partner and change role to RefID======
    When I search partner by TC.133059
    And I view partner details by TC.133059
    And I get the partner_id
    And I change root role to FedID role
    #======step8: act as partner======
    And I switch hosts to blue and act as newly created partner
    #TC.133059 - check adr_policy_name if machine existed======
    #======step9: search device and get device id, get device's adr policy name from machine table======
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy6Month_monthly
    And I close machine details section
    And I clear machine search results
    #TC.133061 - check adr_policy_name if machine is a deleted one======
    #======step10: search deleted device and get device id, get device's adr policy name from machine table======
    And I switch hosts to green and act as newly created partner
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user2_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #======step11: stop masquerading from current partner======
    And I stop masquerading
    #TC.133060 - check adr_policy_name if it's new machine=======
    #======step12: search partner======
    When I search partner by TC.133059
    And I view partner details by TC.133059
    And I get the partner_id
    #And I change root role to FedID role
    #======step13: act as partner======
    And I switch hosts to blue and act as newly created partner
    #======step14: create a new user with backup machine======
    Given I get the partners name TC.133059 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) | Desktop      |  1            |  1      | Yes          |
    #======step15: search new backup device, get device id and check the adr policy name in db======
    Then I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy6Month_monthly
    And I close machine details section
    And I clear machine search results
    #TC.133062 - check adr_policy_name column when delete machine======
    #======step16: search backup machine and delete it======
    And I switch hosts to green and act as newly created partner
    When I search machine by:
      | machine_name         |
      | ugdf_user3_machine_1 |
    And I view machine details for ugdf_user3_machine_1
    Then I delete the machine
    #======step17: query adr policy name in db for the deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user3 |
    And I view user details by ugdf_user3
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133061 - check adr_policy_name column when replace machine======
    #=======step18: replace machine======
    And I switch hosts to blue and act as newly created partner
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    And I select ugdf_user1_machine_1 to be replaced
    #=======step19: query replace machine in db======
    When I search user by:
      | keywords   |
      | ugdf_user4 |
    And I view user details by ugdf_user4
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user4_machine_1 is Mozy6Month_monthly
    Then ADR policy in DB for existing device ugdf_user4_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #======step20: stop masquerading======
    And I stop masquerading
    #======step21: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133059 |
    #Then I view partner details by TC.133059
    #And I delete partner account

  @blue_green
  Scenario: 120809 Configurable Retention - MozyPro
    When I add a new MozyPro partner:
      | period |
      | 1      |
    Then New partner should be created
    #MozyPro partners default retention is 60 days
    And I get the partner_id
    And I switch hosts to green
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then I try all positive retention date for MozyPro Direct
    Then I try all negative retention date for MozyPro Direct
    #Delete partner when done with validating retention period
    Then I delete partner account

  @blue_green
  Scenario: 2826 2836 122224:Create Edit a new network domain click search button with nothing input
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 001 | Shared       |
    Then Group 001 user group should be created
    When I add a new Bundled user group:
      | name     | storage_type |
      | Group001 | Shared       |
    Then Group001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 001 Group | Shared       |
    Then 001 Group user group should be created
    And I add a new Bundled user group:
      | name          | storage_type |
      | Subgroup 0001 | Shared       |
    Then Subgroup 0001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | Group 100 | Shared       |
    Then Group 100 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 100 Group | Shared       |
    Then 100 Group user group should be created
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 0001 | Shared      |
    Then Group 0001 user group should be created
    When I add a new Bundled user group:
      | name        | storage_type |
      | Subgroup001 | Shared       |
    Then Subgroup001 user group should be created
    When I add a new Bundled user group:
      | name         | storage_type |
      | Subgroup 001 | Shared       |
    Then Subgroup 001 user group should be created
    And I add a new Bundled user group:
      | name       | storage_type |
      | Group 0011 | Shared       |
    Then Group 0011 user group should be created
    When I add a new Bundled user group:
      | name       | storage_type |
      | Group00101 | Shared       |
    Then Group00101 user group should be created
    When I add a new Bundled user group:
      | name    | storage_type |
      | Foo 001 | Shared       |
    Then Foo 001 user group should be created
    And I switch hosts to green and act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    And I add a network domain without saving
      | User Group |
      |            |
    Then user groups search result should be
      | user groups                                                                                                                                   |
      | (default user group);Foo 001;Group 001;Group001;001 Group;Subgroup 0001;Group 100;100 Group;Group 0001;Subgroup001;Subgroup 001;Group 0011;Group00101 |
    And I add a network domain
      | Domain GUID   | Alias   | OU   | User Group |
      | auto_generate | domain1 | unit | 001 Group  |
    Then user groups search result should be
      | user groups                                                                                          |
      | 001 Group;Group 0001;Group 001;Group 0011;Group001;Group00101;Subgroup 0001;Subgroup001;Subgroup 001 |
    Then Add network domain message will be Domain added successfully.
    And I switch hosts to blue and act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    And Existing network domain record should be
      | Alias   | Domain                     | OU   | User Group |
      | domain1 | <%=@network_domain.guid%>  | unit | 001 Group  |
    And I click edit network domain button
    And I update a network domain
      | Domain GUID   | Alias   | OU    | User Group |
      | auto_generate | domain2 | unit1 | 100 Group  |
    Then user groups search result should be
      | user groups         |
      | Group 100;100 Group |
    Then Edit network domain message will be Domain updated successfully.
    And I switch hosts to green and act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    And Existing network domain record should be
      | Alias   | Domain                    | OU    | User Group |
      | domain2 | <%=@network_domain.guid%> | unit1 | 100 Group  |
    And I remove the network domain record
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_gree
  Scenario: 131176 Regional User - Change
    When I add a new MozyPro partner:
      | period | base plan  | server plan | net terms |
      | 24     | 100 GB     | yes         | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I change user install override region to qa
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine1_131176 | <%=@new_users.last.email%> | Desktop      | qa          |
    And I upload data to device
      | machine_id                        | GB |
      | <%=@new_clients.last.machine_id%> | 2  |
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center: |
      | qa6          |
    And I refresh User Details section
    And I delete device by name: the newly created device name
    And I change user install override region to test_qa5
    And I close User Details section
    And I close machine details section
    Then I use keyless activation to activate devices
      | machine_name    | user_name                  | machine_type | user_region |
      | Machine2_131176 | <%=@new_users.last.email%> | Desktop      | test_qa5    |
    And I upload data to device
      | machine_id                         | GB |
      | <%=@new_clients.last.machine_id%>  | 2  |
    And I switch hosts to blue and act as newly created partner
    When I navigate to Search / List Machines section from bus admin console page
    And I refresh Search List Machines section
    And I view machine details for the newly created device name
    Then machine details should be:
      | Data Center:  |
      | qa5           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 120553 Setting up a Password policy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 3                     | Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    And I switch hosts to green and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 6          | 3                     | 0             | 1               | f                        | f                    |
    Then The user and admin password will contains at least 3 of the following types of charactors
      | lower | digit | special |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
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

    And I switch hosts to green
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

  @blue_green
  Scenario: 22221 MozyPro - Download Mozy Software link to the admin console download page
    #======step1: create a mozypro partner======
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    #======step2: verify the welcome_takeover_enabled setting parameter======
    And I verify partner settings
      | Name                     | Value | Locked | Inherited |
      | welcome_takeover_enabled | t     | false  | true      |
    #======step3: click act as linke to get welcome page(popup window)======
    And I switch hosts to green
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I act as partner to get welcome page
    Then get welcome page title What's New?
    #======step4: click Download Mozy Software link on welcome page and navigate to the download mozy software section======
    And click Download Mozy Software link on welcome page

  @blue_green
  Scenario: 122211 Add New Account Attribute Key
    #======step1: create a account attribute key======
    When I add a account attribute key:
      | key                    | data type | internal |
      | TEST_ROR_SHOULD_DELETE | string    | Yes      |
    #======step2: search the key and edit======
    When I search account attribute key TEST_ROR_SHOULD_DELETE
    Then I edit account attribute key:
      | component |
      | comp_test |
    #======step3: verify the key is updated successfully======
    And I switch hosts to green
    And I navigate to List Account Attribute Keys section from bus admin console page
    And I get account attribute key TEST_ROR_SHOULD_DELETE info:
      | key                    | data type | component | aria field | action |
      | TEST_ROR_SHOULD_DELETE | string    | comp_test |            | Delete |
    #======step4: delete the key======
    And I delete account attribute key TEST_ROR_SHOULD_DELETE

  @blue_green
  Scenario: 122197 Add New Promtion
#======prestep: delete promotion if already exists======
    Given I delete promo ror001 from plsql
#======step1 : create a promotion======
    When I add a new promotion:
      | description | promo code | discount type  | discount value | valid from | through    |
      | testing     | ror001     | Price Discount | 0.5000         | 2016-01-21 | 2022-01-21 |
    Then new promotion is created
#======step2: create a mozy home user with the created coupon code======
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | coupon |
      | 12     | 125 GB    | United States  | United States   | ror001 |
    Then the user is successfully added
    When I switch hosts to green
#======step3: search the user and verify the subscription table======
    When I search user by:
      | keywords       |
      | @mh_user_email |
  #| @partner.admin_info.email |
    And I view user details by newly created MozyHome username
    Then MozyHome user billing info should be:
      | Amount  |
      | $104.39 |
#======step4: delete the promotion======
    And I delete promo ror001 from plsql
    #When I search promition ror001 <-- time killer, delete promotion from plsql directly
    #Then I delete promotion

  @blue_green
  Scenario: 122198 122199 Edit Promtion
    #======prestep: delete promotion if already exists======
    Given I delete promo ror004 from plsql
    #======step1: create a promotion======
    When I add a new promotion:
      | description | promo code | discount type  | discount value | through    |
      | testing     | ror004     | Price Discount | 0.5000         | 2022-01-21 |
    Then new promotion is created
    #======step2: update promotion======
    When I switch hosts to green
    When I search promition ror004
    And I update an existing promotion:
      | discount value |
      | 0.12           |
    Then promotion is updated
    #======step3: create a new mozyhome user with updated promotion======
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | coupon |
      | 12     | 125 GB    | United States  | United States   | ror004 |
    Then the user is successfully added
    When I switch hosts to blue
    #======step4: search the user and verify the subscription table======
    When I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then MozyHome user billing info should be:
      | Amount  |
      | $108.58 |
    #======step5: delete promotion======
    And I delete promo ror004 from plsql
    #When I search promition ror004 <-- time killer, delete promotion from plsql directly
    #Then I delete promotion

  @blue_green
  Scenario: 122215 Migrate a partner
    When I add a new OEM partner:
      | Root role     | Security | Company Type  |
      | ITOK OEM Root | HIPAA    | Reseller      |
    Then New partner should be created
    And I get the subpartner_id
    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    And Partner general information should be:
      | Pooled Resource: |
      | No               |
    When I navigate to Manage Internal Jobs section from bus admin console page
    And I start job migrate to storage pooling for the partner
    When I switch hosts to green
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Pooled Resource: |
      | Yes              |
    And I delete partner account

  @blue_green
  Scenario: 119214:Verify that purged partners appear in the "Partners who have been purged" table
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    And I get the partner_id
    When I get partner aria id
    And I delete partner account
    And I switch hosts to green
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        |
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Days Pending |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | 1 minute     |
    And I purge partner by newly created partner company name
    And I switch hosts to green
    Then I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in who have been purged by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in who have been purged search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Date Purged |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | today       |
    Then I change to 60 days to purge account after delete

  @blue_green
  Scenario: 119255:MozyPro Metalic Reseller with Sub, Undelete
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | coupon              | country       | security |
      | 1      | Silver        | 780            | yes         |     10         | 10PERCENTOFFOUTLINE | United States | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I get partner aria id
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | test1   |
    And New partner should be created
    Then I stop masquerading as sub partner
    And I search and delete partner account by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    And I switch hosts to green
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  |

  @blue_green
  Scenario: 119257:Undelete MozyPro Partner
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
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    And I switch hosts to green
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I undelete partner in pending-delete not available to purge by newly created partner company name
    And I switch hosts to blue
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    And I view partner details by newly created partner company name
    Then Partner general information should be:
      | Status:         |
      | Active (change) |
    Then I act as partner by:
      | name          |
      | @company_name |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_20921  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 10 |
    Then tds returns successful upload

  @blue_green
  Scenario: 120569:Pending delete for Enterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 5     | yes       |
    Then New partner should be created
    When I get the partner_id
    And I get partner aria id
    And I delete partner account
    And I switch hosts to green
    When I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 65 days
    And I search partners in pending-delete not available to purge by:
      | email        |
      | @admin_email |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            | Request Date | Days Remaining |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  | today        | 2 months       |
    And I search partner by newly created partner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created partner company name
    Then Partner general information should be:
      | Pending | Root Admin: |
      | today   | @root_admin |

  @blue_green
  Scenario: 122196 Open Partner Signups
    #======step2: create a resller type partner======
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    #======step1: verify the header on Partner Signups Report table======
    And I switch hosts to green
    When I navigate to Partner Signups Report section from bus admin console page
    Then Partner Signups Report table header should be:
      | Name | Approved | Type | Initial Keys | Initial Quota |
    #======step2: search the new created partner and view details======
    When I search partner on partner signups report by:
      | name                            |
      | <%=@partner.company_info.name%> |
    Then I view parter details on signup partner report by newly created partner company name
    #======step3: click clear search underline button======
    And I click clear search
    #======step4: export pro partner and check the newly created partner in the csv======
    When I export partner signups report
    Then I find the partner newly created partner company name in downloaded csv

  @blue_green
  Scenario: 122195 Open Transaction Summary
#======step1: check the header on Transaction Summary table======
    Given I wait for 30 seconds
    When I navigate to Transaction Summary section from bus admin console page
    Then Transaction Summary table main header should be:
      | Date | Mozy Unlimited | MozyPro | DVD Orders | Data Shuttle Fees | Total |
    And Transaction Summary table sub header should be:
      | Biennial | Yearly | Monthly | Total |
#======step2: download revenue report======
    And I switch hosts to green
    When I navigate to Transaction Summary section from bus admin console page
    And I download revenue report

  @blue_green
  Scenario: 124714 Add a VAT Rate successfully
    When I add a VAT Rate:
      | Country  | Rate   | Effective Date |
      | Austria  | 0.2    | next week      |
    Then New VAT Rate should be created
    And I switch hosts to green
    When I navigate to Manage VAT/FX Rates section from bus admin console page
    Then I delete newly created VAT Rate and cancel this operation
    Then I delete newly created VAT Rate successfully

  @blue_green
  Scenario: 124725 Add a FX Rate successfully
    When I add a FX Rate:
      | From Currency | To Currency  | Rate | Effective Date  |
      | EUR           | USD          | 10.1 | tomorrow        |
    Then New FX Rate should be created
    And I switch hosts to green
    When I navigate to Manage VAT/FX Rates section from bus admin console page
    Then I delete newly created FX Rate and cancel this operation
    Then I delete newly created FX Rate successfully

  @blue_green
  Scenario: 129694 Undelete machine time limit
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.129694.User1 | (default user group) | Desktop      | 100           | 10      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name  | user_name                   | machine_type |
      | auto_generate | <%=@new_users.first.email%> | Desktop      |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for @client.machine_alias
    And I delete the machine
    And I stop masquerading
    And I switch hosts to green
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then device name should show with (deleted)
    And I view deleted machine details from user details section
    And I undelete the machine
    When I refresh User Details section
    Then device table in user details should be:
      | Device                     | Used/Available | Device Storage Limit | Last Update | Action |
      | <%=@client.machine_alias%> | 0 / 100 GB     | Set                  | N/A         |        |
    And I refresh Machine Details section
    And I delete the machine
    And I switch hosts to green
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then device name should show with (deleted)
    When I update the deleted at time to today minus global_undelete_value-1 days
    And I view deleted machine details from user details section
    Then I should see Undelete Machine link
    And I undelete the machine
    And I refresh Machine Details section
    And I delete the machine
    When I refresh User Details section
    Then device name should show with (deleted)
    When I update the deleted at time to today minus global_undelete_value days
    And I switch hosts to blue
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    And I view deleted machine details from user details section
    Then I shouldnot see Undelete Machine link
    And I update the deleted at time to today minus global_undelete_value+1 days
    When I refresh Machine Details section
    Then I shouldnot see Undelete Machine link
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 22022 MozyPro Partner Enable and Disable cycle by adding sync to all users
    When I add a new MozyPro partner:
      | period | base plan | net terms | root role |
      | 12     | 50 GB     | yes       | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22022 User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable sync  |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync    | Machines | Storage         | Storage Used |
      | <%=@new_users.first.email%> | TC.22022 User | Enabled | 0        | 10 GB (Limited) | None         |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.22022 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 10 GB          | Set                  | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    When I disable stash for the partner
    And I wait for 5 seconds
    And I switch hosts to green and act as newly created partner
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Machines | Storage         | Storage Used  |
      | <%=@new_users.first.email%> | TC.22022 User | 0        | 10 GB (Limited) | None          |
    When I view user details by newly created user email
    Then I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I enable stash for the partner
    And I add stash to all users for the partner
    And I wait for 5 seconds
    And I switch hosts to blue and act as newly created partner
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync   | Machines | Storage         | Storage Used  |
      | <%=@new_users.first.email%> | TC.22022 User | Enabled| 0        | 10 GB (Limited) | None          |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.22022 User (change) | Yes (Send Invitation Email) |
    When I delete stash container for the user
    And I wait for 5 seconds
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.22022 User (change) | No (Add Sync) |
    Then I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I delete partner account

  @blue_green
  Scenario: 22194 MozyEnterprise Partner Enable and Disable cycle by add sync with single user
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22194 User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I search emails by keywords:
      | to                          | subject      |
      | <%=@new_users.first.email%> | enable sync  |
    Then I should see 0 email(s)
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync    | Machines | Storage                  | Storage Used  |
      | <%=@new_users.first.email%> | TC.22194 User | Enabled | 0        | Desktop: 10 GB (Limited) | Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:               |
      | TC.22194 User (change) | Yes (Send Invitation Email)|
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 10 GB          | Set                  | N/A              |
    When I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner stash info should be:
      | Users:         | 1 |
      | Storage Usage: | 0 |
    When I disable stash for the partner
    And I wait for 5 seconds
    And I switch hosts to green and act as newly created partner
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Machines | Storage                 | Storage Used  |
      | <%=@new_users.first.email%> | TC.22194 User | 0        | Desktop: 10 GB (Limited)| Desktop: None |
    Then I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I enable stash for the partner
    And I wait for 5 seconds
    And I switch hosts to blue and act as newly created partner
    And I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                        | Name          | Sync     | Machines | Storage                  | Storage Used  |
      | <%=@new_users.first.email%> | TC.22194 User | Disabled | 0        | Desktop: 10 GB (Limited) | Desktop: None |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.22194 User (change) | No (Add Sync) |
    When I enable stash without send email in user details section
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.22194 User (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      |
      | Sync           | 0 / 10 GB          | Set                  | N/A              |
    Then I delete stash container for the user
    And I wait for 5 seconds
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:  |
      | TC.22194 User (change) | No (Add Sync) |
    Then I stop masquerading
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I delete partner account

  @blue_green
  Scenario: 18913 Root admin disable Sync for a new MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change) |
    When I disable stash for the partner
    And I switch hosts to green
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner general information should be:
      | Enable Sync: |
      | No (change)  |
    When I delete partner account

  @blue_green
  Scenario: 22080 MozyEnterprise(Fortress tree) admin view stash details in partner detail section
    When I act as partner by:
      | email                                   | including sub-partners |
      | redacted-36090@notarealdomain.mozy.com  | yes                    |
    And I add a new sub partner:
      | Company Name                          |
      | Fortress Test Enable Sync Sub Partner |
    Then New partner should be created
    And I switch hosts to green
    When I act as partner by:
      | email                                   | including sub-partners |
      | redacted-36090@notarealdomain.mozy.com  | yes                    |
    And I search partner by Fortress Test Enable Sync Sub Partner
    And I view partner details by Fortress Test Enable Sync Sub Partner
    Then Partner general information should be:
      | Status:         | Subdomain:              | Enable Autogrow: | Enable Sync: |  Default Sync Storage: |
      | Active (change) | (learn more and set up) | No               | Yes          |  2 GB                  |
    And Partner stash info should be:
      | Users:         | 0     |
      | Storage Usage: | 0 / 0 |
    Then I delete partner account

  @blue_green
  Scenario: 868 Replace a machine
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name         | user_group           | storage_type | storage_limit | devices |
      | TC.868.User1 | (default user group) | Desktop      | 100           | 10      |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name | user_name                   | machine_type |
      | Machine1_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine2_868 | <%=@new_users.first.email%> | Desktop      |
    And I update newly created machine encryption value to Default
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details fomemmer Machine1_868
    And I click on the replace machine link
    And I select Machine2_868 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I switch hosts to green and act as newly created partner
    And I search machine by:
      | machine_name |
      | Machine2_868 |
    Then I should not search out machine record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 19114 19115 Enterprise Partner View User storage usage
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 4     |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change) |
    When I act as newly created partner account
    And I add new user(s):
      | name                 | user_group           | storage_type | devices |
      | TC.19115.backup-user | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 10 GB      |
    And I refresh User Details section
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1 | 10 GB / 90 GB  | Set                  | < a minute ago |        |
    And I close User Details section
    When I add new user(s):
      | name                | user_group           | storage_type | devices | enable_stash |
      | TC.19115.stash-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update Sync used quota to 20 GB
    And I refresh User Details section
    Then user details should be:
      | Name:                        | Enable Sync:                |
      | TC.19115.stash-user (change) | Yes (Send Invitation Email) |
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update    | Action |
      | Sync           | 20 GB / 70 GB  | Set                  | < a minute ago |        |
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords   |
      | TC.19115   |
    Then User search results should be:
      | User                 | Name                 | Sync     | Machines | Storage         | Storage Used           | Created | Backed Up     |
      | <%=@users[1].email%> | TC.19115.stash-user  | Enabled  | 0        | Desktop: Shared | Desktop: 20 GB         | today   | 1 minute ago  |
      | <%=@users[0].email%> | TC.19115.backup-user | Disabled | 1        | Desktop: Shared | Desktop: 10 GB         | today   | 2 minutes ago |

  @blue_green
  Scenario: 19122 Add new user with stash enabled and send stash invite email
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    Then Partner general information should be:
      | Enable Sync: |
      | Yes (change) |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices | enable_stash |
      | TC.19121-user | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 250 GB         | Set                  | N/A              |        |
# no send email option when adding a new user with stash
#    When I search emails by keywords:
#      | to              | subject      |
#      | @new_user_email | enable stash |
#    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 21059 Verify retention period for MozyEnterprise UK
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | net terms |
      | 12     | 10    | 250 GB      | United Kingdom | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21059.User | (default user group) | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21059 | <%=@new_users.first.email%> | Server       |
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | linux    | deb-32 | MozyEnterprise | 0.0.0.2 |
    Then retention period should be 90 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 15728 BILL.9000 Autogrow may be enabled or disabled OEM
    When I add a new OEM partner:
      | company name        | Root role   |
      | TC.15728oem_partner | D-SaaS Root |
    Then New partner should be created
    And I stop masquerading as sub partner
    And I stop masquerading
    When I search partner by TC.15728oem_partner
    And I view partner details by TC.15728oem_partner
    And I Enable partner details autogrow
    And I switch hosts to green
    When I search partner by TC.15728oem_partner
    And I view partner details by TC.15728oem_partner
    Then Partner general information should be:
      | Enable Autogrow: |
      | Yes (change)     |
    And I Disable partner details autogrow
    And I switch hosts to blue
    When I search partner by TC.15728oem_partner
    And I view partner details by TC.15728oem_partner
    Then Partner general information should be:
      | Enable Autogrow: |
      | No (change)      |
    And I delete partner account

  @blue_green
  Scenario: 462 - Activate a partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    Then I suspend the partner
    And I log out bus admin console
    And I switch hosts to green without login bus
    And I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I switch hosts to blue without login bus
    And I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I activate the partner
    And I log out bus admin console
    And I switch hosts to green without login bus
    And I log in bus admin console as new partner admin
    Then the new partner admin should be logged in
    And I switch hosts to blue without login bus
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @blue_green
  Scenario: 122386 Edit a partners contact info
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 4 TB      | yes       |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country |
      | China   |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    And I expand contact info from partner details section
    When I change the partner contact information default password
      | Contact Address: | Contact Email:              | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    Then Partner contact information is changed
    And I switch hosts to green
    And I view partner details by newly created partner company name
    And Partner contact information should be:
      | Contact Address: | Contact Email:              | Contact Country:    | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | China               | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: Mozy-122226:Edit partner settings
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    And I switch hosts to green
    And I view partner details by newly created partner company name
    Then I verify partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    Then I delete partner account

  @blue_green
  Scenario: 644 Verify White List visibility for a Corp partner with an API Key
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And I Create an API key for current partner
    When I add a new ip whitelist 250.250.250.250
    And I wait for 5 seconds
    And I switch hosts to green
    And I view partner details by newly created partner company name
    Then Partner ip whitelist should be 250.250.250.250
    And I delete partner account

  @blue_green
  Scenario: 1980:Create New Daily Alert
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules                             | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups| <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    And I switch hosts to green and act as newly created partner
    Then I navigate to Email Alerts section from bus admin console page
    Then I view email alert details by email_alerts_test
    And The email alert details should be:
      | subject line       | frequency | report modules                               | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups  | <%=@partner.admin_info.full_name%> |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to               | content       |
      | @new_admin_email | Backup Summary|
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 15231 MozyPro US - Change Period from Monthly to Yearly - CC
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And I switch hosts to green
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner internal billing should be:
      | Account Type:   | Credit Card  | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00        | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year |                 |                    |
    And I delete partner account

  @blue_green
  Scenario: 15286 Change Payment Information With Credit Card
    When I add a new MozyEnterprise partner:
      | period | users |
      | 36     | 100   |
    Then New partner should be created
    And I get partner aria id
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address               | phone     |
      | This is a new address | 12345678  |
    And I update credit card information to:
      | cc name      | cc number        | expire month | expire year | cvv |
      | newcard name | 4018121111111122 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account billing info should be:
      | address               | phone    | contact name |
      | This is a new address | 12345678 | newcard name |
    And API* Aria account credit card info should be:
      | payment type | last four digits   | expire month | expire year |
      | Credit Card  | 1122               | 12           | 2018        |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 12924:Verify shipped orders
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 18    | 100 GB      |
    And New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      |  10           |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I get the data shuttle seed id for newly created partner company name
    And I set customcd order id to 24651 for just created data shuttle order
    And I switch hosts to green
    And I search order in view data shuttle orders section by newly created partner company name
    And I view data shuttle order details
    Then the shipping tracking table of data shuttle order should be
      | Drive # | Outbound     | Inbound       | Status   |
      | 1       | 797391637123 | 797391636848  | Shipped  |
    And I click outbound link of shipping tracking table
    And I navigate to new window
    Then the new url should contains /fedextrack/?action=track&tracknumbers=797391637123
    And I close new window
    And I click inbound link of shipping tracking table
    And I navigate to new window
    Then the new url should contains /fedextrack/?action=track&tracknumbers=797391636848
    And I close new window
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 18735 Verify unallocated storage auto refreshed when allocated storage changed
    When I act as partner by:
      | email                                     |
      | kalen.quam+qa6+marilyn+dean+1118@mozy.com |
    And I allocate 200 GB Desktop quota to MozyPro partner
    Then MozyPro resource quota should be changed
    And I switch hosts to green
    When I act as partner by:
      | email                                     |
      | kalen.quam+qa6+marilyn+dean+1118@mozy.com |
    When I navigate to Manage Resources section from bus admin console page
    And Partner resources general information should be:
      | Total Account Storage: | Unallocated Storage: | Server: |
      | 500 GB                 | 300 GB               | No      |
    # Bug 90677
    #And Partner total resources details table should be:
    #  |         | Active    | Assigned | Unassigned | Allocated       |
    #  | Desktop | 0 bytes   | 0 bytes  | 300 GB     | 200 GB   Change |

    # Restore partner status
    And I allocate 0 GB Desktop quota to MozyPro partner

  @blue_green
  Scenario: 12342 data_shuttle_ordered_active: (Data Shuttle ordered for activated machine phase III - to user)
    And I add a new Reseller partner:
      | company name    | period | reseller type | reseller quota | server plan | net terms |
      | tc12342 partner | 1      | Silver        | 50             | yes         | yes       |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    When I search emails by keywords:
      | subject                                                          | to                          |
      | Your Key @license_key for MozyPro Now Activated for Data Shuttle | <%=@new_users.first.email%> |
    Then I should see 1 email(s)
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 146 #7206 - returning resources from partner with custom license types results
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    Then Resources should be purchased
    And Current purchased resources should be:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    And I return resources:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    Then Resources should be returned
    And I switch hosts to green and act as newly created subpartner
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @blue_green
  Scenario: 428 Transfer Resources
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 10            | 10             | 10           |
    And I add a new user group for an itemized partner:
      | name      | server_assigned_quota | desktop_assigned_quota |
      | oem_group | 2                     | 2                     |
    Then Itemized partner user group oem_group should be created
    And I switch hosts to green and act as newly created subpartner
    When I transfer resources from user group (default user group) to partner the same partner and user group oem_group with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 2               | 3              | 2                | 3               |
    Then Resources should be transferred
    And I switch hosts to blue and act as newly created subpartner
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 8       | 0.0 (0.0 active) / 7.0  | 0 / 8        | 0.0 (0.0 active) / 7.0  |
      | oem_group              | 0     | 1      | 0 / 2       | 0.0 (0.0 active) / 3.0  | 0 / 2        | 0.0 (0.0 active) / 3.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @blue_green
  Scenario: 10491:MozyHome delinquent payment.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    Then I run third notification reap script
    Then I run fourth notification reap script
    Then I run fifth notification reap script
    Then I run final notification reap script
    Then I run deletion reap script
    Then I close user details section
    And I switch hosts to green
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username

  @blue_green
  Scenario: Mozy-20934:Activation email sent to newly created user
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 12     | 100 GB    | Bundle Pro Partner Root |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | send_email |
      | TC.20934.User  | (default user group) | Desktop      | 10            | 3       | Yes        |
    Then 1 new user should be created
    Then I retrieve email content by keywords:
      | to                       |
      | <%=@new_users[0].email%> |
    Then I check the mozy brand logo in email content is:http://www.mozypro.com/images/emails/mozy_logo.jpg
    Then I check the email content should include:
    """
    Your account administrator has created an account for you on Mozy, the world's leading backup service. To use this new account, just click on the link below and create a password to complete your account profile setup.
    """
    Then the user has activated the account with Hipaa password
    And I switch hosts to green without login bus
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password default password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I see Allow Re-Activation link is available
    And I switch hosts to blue
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 849 Add a new user group
    When I add a new OEM partner:
      | Company Name | Root role         | Security | Company Type     |
      | test_for_849 | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I switch hosts to green and act as newly created subpartner
    And I add a new user group for an itemized partner:
      | name                | server_assigned_quota | desktop_assigned_quota |
      | 849_user_group_test | 3                     | 3                      |
    Then Itemized partner user group 849_user_group_test should be created
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @blue_green
  Scenario: 16275 Import a valid CSV file in non-passive way
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name            | user_group           | storage_type | storage_limit | devices | machine_name |
      | Migration.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | Migration.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | Migration.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    And I switch hosts to green and act as newly created partner
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by adding new owners to the machines
    And I switch hosts to blue and act as newly created partner
    And I navigate to the machine mapping page
    When I upload the machine csv file
    Then There should be import message to inform that it is importing
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |3 machines moved to new users | 0 machines skipped (no new user specified) |

  @blue_green
  Scenario: 2168 Export to CSV
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 500 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | user_2168      | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by user_2168
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_2168   | <%=@new_users.first.email%> | Desktop      |
    And I clear user search results
    And I switch hosts to green and act as newly created partner
    And I navigate to Search / List Users section from bus admin console page
    And I export the users csv
    And I navigate to Search / List Machines section from bus admin console page
    And I export the machines csv
    Then users.csv and machines.csv are downloaded

  @blue_green
  Scenario: 21080 [MozyPro] Delete device
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21080-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M1
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I close user details section

    And I switch hosts to blue and act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21080-2 | Server       | 20            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server       | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M2
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: Mozy-847:Change the name on a user group
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name         | storage_type | server_support |
      | TC.847-group | Shared       | yes            |
    Then TC.847-group user group should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC.847-group
    Then I change user group name to TC.847-group-update
    And I switch hosts to green and act as newly created partner
    Then Bundled user groups table should be:
      | Group Name          | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      |(default user group) | true  | true   | Shared       |            | 0            | 0            |
      | TC.847-group-update | false | true   | Shared       |            | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 123409:New created activated admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I get the partner_id
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123409.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123409.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123409 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    And I switch hosts to green without login bus
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 121550 New JS popup window appears for delete admin
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 500            | Reseller Root |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group           | Roles         |
      | Admin_121550 | (default user group) | Reseller Root |
    Then Add New Admin success message should be displayed
    And I switch hosts to green and act as newly created partner
    And I search admin by:
      | name         |
      | Admin_121550 |
    And I view the admin details of Admin_121550
    When I delete admin then cancel, the confirm message on the popup will be
      """
        Really delete this admin? Any sub-admins will also be deleted.
      """
    And I search admin by:
      | name         |
      | Admin_121550 |
    Then I should can search out admin record
    When I delete admin with bus admin password
    And I search admin by:
      | name         |
      | Admin_121550 |
    Then I should not search out admin record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 121833 New LDAP login through LDAP process
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    And I add a user to the AD
      | user name        | mail              |
      | <%=@admin.name%> | <%=@admin.email%> |
    And I switch hosts to green without login bus
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password wrongpass12
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be Incorrect email or password.

    And I switch hosts to blue
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.

    And I switch hosts to green
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |
    And I delete a user @admin.name in the AD

  @blue_green
  Scenario: 12435 Standard Login admin change sub-admins password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name        | Roles      | User Group           |
      | Admin_12435 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I switch hosts to green without login bus
    And the partner has activated the sub-admin account with default password
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I view admin details by:
      | name        |
      | Admin_12435 |
    And I change admin password to Standard password
    Then I can change admin password successfully
    And I log out bus admin console
    And I log in bus admin console with user name @admin.email and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admin.email and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 15229 Verify Receive Mozy Account Statements set to Yes for new partner in Bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Account Details section from bus admin console page
    Then Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | Yes (change)      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 18752 Change plan will reflect the price schedule for a partner
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $9.99                     |
      | 50 GB, $19.99 (current purchase) |
      | 100 GB, $39.99                   |
      | 250 GB, $94.99                   |
      | 500 GB, $189.99                  |
      | 1 TB, $379.99                    |
      | 2 TB, $749.99                    |
      | 4 TB, $1,439.99                  |
      | 8 TB, $2,879.98                  |
      | 12 TB, $4,319.97                 |
      | 16 TB, $5,759.96                 |
      | 20 TB, $7,199.95                 |
      | 24 TB, $8,639.94                 |
      | 28 TB, $10,079.93                |
      | 32 TB, $11,519.92                |
    And Add-ons price should be Server Plan, $6.99
    When API* I change aria supplemental plan for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency |
      | MozyPro 50 GB Plan (Monthly)                   | Non-profit Discount | usd               |
      | MozyPro Server Add-on for 50 GB Plan (Monthly) | Non-profit Discount | usd               |
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                             |
      | 10 GB, $8.00                     |
      | 50 GB, $17.99 (current purchase) |
      | 100 GB, $35.99                   |
      | 250 GB, $85.49                   |
      | 500 GB, $170.99                  |
      | 1 TB, $341.99                    |
      | 2 TB, $674.99                    |
      | 4 TB, $1,295.99                  |
      | 8 TB, $2,591.98                  |
      | 12 TB, $3,887.97                 |
      | 16 TB, $5,183.96                 |
      | 20 TB, $6,479.96                 |
      | 24 TB, $7,775.95                 |
      | 28 TB, $9,071.94                 |
      | 32 TB, $10,367.93                |
    And Add-ons price should be Server Plan, $6.29
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 22130 Script Migrate - push channel to aria
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 4 TB      | yes       |
    Then New partner should be created
    And I get partner aria id
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy Inc. (US)
    When I switch hosts to green
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I expand contact info from partner details section
    And I change the partner contact information to:
      | Contact Country: |
      | France           |
    Then Partner contact information is changed
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy International Limited (Ireland)
    When I switch hosts to blue
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I expand contact info from partner details section
    And I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    When API* I get supplemental field Subsidiary for newly created partner aria id
    Then Supplemental field Subsidiary value should be Mozy Inc. (US)
    And I delete partner account

  @blue_green
  Scenario: 122460 create a new linux version in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
    And I switch hosts to green
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name              | platform | arch    | version number | notes                                              |
      | LinuxTestVersion  | linux    | deb-32  | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  @blue_green
  Scenario: 122465 Linux client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I should not see version 10.10.10.10 in version list
    And I switch hosts to green
    When I navigate to List Versions section from bus admin console page
    When I list versions for:
      | platform | show disabled |
      | linux    | true         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status   |
      | 10.10.10.10 | linux     | LinuxTestVersion | disabled |

  @blue_green
  Scenario: 123296 Linux client can be uploaded successfully for Mozy, Inc.
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeLinuxClient.deb for partner Mozy, Inc.
    And I upload executable FakeLinuxClient.deb for partner MozyPro
    And I upload executable FakeLinuxClient.deb for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And I switch hosts to green
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And the download link for partner Mozy, Inc. should be generated
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated

  @blue_green
  Scenario: 122462 Linux client version can be enabled
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    And I switch hosts to green
    When I navigate to List Versions section from bus admin console page
    When I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status  |
      | 10.10.10.10 | linux     | LinuxTestVersion | enabled |

  @blue_green
  Scenario: 122544 Create Auto upgrade rule for Linux client
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version LinuxTestVersion if it exists
    Then I add a new upgrade rule:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     |

    And I switch hosts to green
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To                       | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Linux - 32 bit .deb 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 |         |
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122544.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.122544.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_122544 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | linux    | deb-32 | mozypro  | 0.0.0.2 |
    And I delete user
    Then client config should contains:
      | update-url                                      |
      | /downloads/mozypro-deb-32-10_10_10_10-XXXXX.deb |

  @blue_green
  Scenario: 122553 Client Version Rules: Create Auto update client version rule for Linux client
    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists

    When I add a new rule in Edit Client Version:
      | Update To                       | Current Version >= | Current Version <= | Required |
      | Linux - 32 bit .deb 10.10.10.10 | 0.0.0.1            | 0.0.0.2            | No       |

    And I switch hosts to green without login bus
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page

    Then Client Version Rules should include rule:
      | Update To                       | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Linux - 32 bit .deb 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 | Remove  |

    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122553.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.122553.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_122553 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | linux    | deb-32 | MozyEnterprise | 0.0.0.2 |
    And I delete user
    Then client config should contains:
      | update-url                                             |
      | /downloads/MozyEnterprise-deb-32-10_10_10_10-XXXXX.deb |
    When I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists

  @blue_green
  Scenario: 123298 Linux client can be downloaded successfully for none product partner
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I switch hosts to green without login bus
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: MozyPro LinuxTestVersion |
    When I clear downloads folder
    And I click download link for MozyPro LinuxTestVersion
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @blue_green
  Scenario: clean up all linux test versions and rules
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists

  @blue_green
  Scenario: 122402 Add Custom Text
# existing partner is a OEM partner with subdomain_name 'osngbedo'
    When I use a existing partner:
      | company name                 | admin email                 | partner type | partner id |
      |  test_for_126029_DO_NOT_EDIT | mozybus+q0cusmjgv@gmail.com | OEM          | 3475729    |
    And I go to page https://osngbedo.mozypro.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then Navigation item Admin Console Branding should be available
# dashboard link text should be changed if set dashboard link text in Text Header
    When I navigate to Admin Console Branding section from bus admin console page
    And I click Text tab in Admin Console Branding section
    And I open admin console text setting for header
    And I set Dashboard Link Text to DELL-EMC-TEST
    And I refresh the page
    And I wait for 5 seconds
    And I switch hosts to green without login bus
    And I go to page https://osngbedo.mozypro.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then dashboard link text in global nav area should be DELL-EMC-TEST
# clear the header text, dashboard link text should be default value DASHBOARD
    When I navigate to Admin Console Branding section from bus admin console page
    And I click Text tab in Admin Console Branding section
    When I open admin console text setting for header
    And I clear text area of Dashboard Link Text
    And I refresh the page
    And I wait for 5 seconds
    And I switch hosts to blue without login bus
    And I go to page https://osngbedo.mozypro.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then dashboard link text in global nav area should be DASHBOARD

  @blue_green
  Scenario: 20915 Activate co-branding on a partner and verify it appears on subpartner
    When I clean up png files in downloads folder
    # create a Reseller partner
    And I add a new Reseller partner:
      | period | company name | reseller type | reseller quota | server plan | country       |
      | 12     | TC.20915     |Silver         | 100            | yes         | United States |
    And New partner should be created
    And I click admin name @partner.admin_info.full_name in partner details section
    And I active admin in admin details default password
    # add a subpartner under this reseller
    When I log in bus admin console as new partner admin
    Then Navigation item Co-Branding should be unavailable
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name        |
      | TC.20915_subpartner |
    And New partner should be created
    And I click admin name @subpartner.admin_name in partner details section
    And I active admin in admin details default password
    And I close the admin details section
    And I refresh the page
    # turning "Enable Co-branding" and "Require Ingredient:" to yes in partner details
    When I view the partner info
    And I enable co-branding for the partner
    And I enable require ingredient for the partner
    And I refresh the page
    Then Navigation item Co-Branding should be available
    And I switch hosts to green and act as newly created partner
    # upload a image for web portal and activate it
    When I navigate to Co-Branding section from bus admin console page
    And I upload image title.png for Web Portal for Co-Branding
    And I activate Co-branding
    # now the partner should see this upload image on left top side
    And I refresh the page
    And I wait for 5 seconds
    And I download the partner branding img as file new_partner_img.png on top left side of dashboard
    Then the downloaded top img new_partner_img.png should be same as the upload img title.png
    # then subpartner should see the inherited image on left top side
    When I log out bus admin console
    And I switch hosts to blue without login bus
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as TC.20915_subpartner admin successfully
    When I download the partner branding img as file new_sub_partner_img.png on top left side of dashboard
    Then the downloaded top img new_sub_partner_img.png should be same as the upload img title.png

  @blue_green
  Scenario: 122139 Add a dialect
    When I navigate to bus admin console login page
    And I use a existing partner:
      | company name             | admin email                              | partner type |
      |  TC.122139 [DO NOT EDIT] | mozyautotest+brandon+howard+1513@emc.com | Reseller     |
    And I get partner id by admin email from database
    And I delete dialects of current partner from database
    And I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I click start with the default link in List Dialects section
    Then dialects table should be:
      | Order | Description | Dialect | Enabled | Type           |
      | 0     | English     | en      | yes     | Admins & Users |
    # go to admin login page to verify that no other language can be selected
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    Then I should not see language select field
    # back to partner dialect list to add another dialect
    When I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I add a dialect:
      | Order | Code  | Enabled | Type           |
      | 1     | de    | Yes     | Users          |
    Then dialects table should be:
      | Order | Description | Dialect | Enabled | Type           |
      | 1     | German      | de      | yes     | Users          |
      | 0     | English     | en      | yes     | Admins & Users |
    And I switch hosts to green without login bus
    # go to user login page to verify that English and German language can be selected
    When I go to page QA_ENV['bus_host']/login/user?pid=@partner_id
    Then I should see language select field
    And language select filed should include option English
    And language select filed should include option Deutsch
    # back to partner dialect list to clean up dialect settings
    When I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I delete dialect of English
    And I delete dialect of German

  @blue_green
  Scenario: 122178 Add New SMTP Setting
    When I navigate to bus admin console login page
    And I use a existing partner:
      | company name             | admin email                              | partner type |
      |  TC.122139 [DO NOT EDIT] | mozyautotest+brandon+howard+1513@emc.com | Reseller     |
    And I log in bus admin console as new partner admin
    And I navigate to SMTP Settings section from bus admin console page
    Then I cleanup SMTP Setting
    And I input new SMTP Setting:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      | 127.0.0.1 | 25    | TLS        | LOGIN          | Mozy     | Test     |
    And I click SMTP Setting save changes button
    Then SMTP Settings change message should be: SMTP server settings were saved successfully.
    And I switch hosts to green without login bus
    And I log in bus admin console as new partner admin
    And I navigate to SMTP Settings section from bus admin console page
#    And I refresh SMTP Settings section
    Then SMTP Setting should be:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      | 127.0.0.1 | 25    | TLS        | LOGIN          | Mozy     | ****     |
    When I delete SMTP Setting
    Then SMTP Settings change message should be: SMTP server settings were deleted successfully.
    And SMTP Setting should be:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      |           | 25    | None       | None           |          |          |

  @blue_green
  Scenario: 792 Do a search on all deleted partners
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And I delete partner account
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should be:
      | Partner       |
      | @company_name |

  @blue_green
  Scenario: 16152 Verify account reinstate from active dunning 2 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I switch hosts to green and act as newly created partner
#    And I act as partner by:
#      | email        |
#      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 12
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I switch hosts to blue and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 20798 [Itemized with subpartner]The subpartner info shows
    When I act as partner by:
      | email                                                |
      | test_resource_summary_enterprise_subpartner@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    Then Itemized storage summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used  | All Subpartner | Desktop Subpartner | Server Subpartner |
      | 0            | 170 GB        | 10 GB       | 80 GB        | 240 GB    | 10 GB | 50 GB          | 30 GB              | 20 GB             |
    And I switch hosts to green
    When I act as partner by:
      | email                                                |
      | test_resource_summary_enterprise_subpartner@auto.com |
    And I navigate to Resource Summary section from bus admin console page
    And Itemized device summary should be:
      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used | All Subpartner | Desktop Subpartner | Server Subpartner |
      | 0            | 5             | 1           | 198          | 202       | 1    | 5              | 3                  | 2                 |

  @blue_green
  Scenario: 20947 [Itemized][Server License]Admin can send activated/unactived license keys
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 0       |
    Then 1 new user should be created
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then I can see Send Keys button is disable
    Then I close user details section
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
    Then 1 new user should be created
    And I switch hosts to blue and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 0
    And Number of Server unactivated keys should be 3
    When I click Send Keys button
    And I wait for 15 seconds
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I cannot find any Activated license key(s) from the mail
    And I can find 3 Unactivated Server license key(s) from the mail
    When I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 1
    And Number of Server unactivated keys should be 2
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content                                  |
      | <%=@activated_keys + @unactivated_keys%> |
    Then I should see 2 email(s)
    And I can find 1 Activated Server license key(s) from the mail
    And I can find 2 Unactivated Server license key(s) from the mail
    And Unactivated keys should show above activated in the mail
    When activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 3
    And Number of Server unactivated keys should be 0
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content              |
      | <%=@activated_keys%> |
    Then I should see 3 email(s)
    And I can find 3 Activated Server license key(s) from the mail
    And I cannot find any Unactivated license key(s) from the mail

  @blue_green
  Scenario: 12659 Delete a partner and verify the module updates correctly
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I delete partner account
    And I switch hosts to green
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty

  @blue_green
  Scenario: 15266 Verify Change Payment Information Contact Info
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 250 GB    | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    Then Payment billing information should be:
      | Billing Street Address: | Billing City: | Billing State/Province: | Billing Country: | Billing ZIP/Postal Code: | Billing Email    | Billing Phone: |
      | 3401 Hillview Ave       | Palo Alto     | CA                      | United States    | 94304                    | @new_admin_email | 1-877-486-9273 |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 1649 Set a partners subdomain
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I change the subdomain to @subdomain
    Then The subdomain is created with name https://@subdomain.mozypro.com/
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And The subdomain in BUS will be @subdomain
    And I delete partner account

  @blue_green
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    When  I edit user device quota to 2
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords |
      | User2    |
    And I view user details by User2
    And users' device status should be:
      | Used | Available | storage_type |
      |  0   | 38        | Server       |
    And I close user details section
    And I switch hosts to blue and act as newly created partner
    When I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And The range of device by tooltips should be:
      | Min | Max |
      | 0   | 12  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 791 Do a regular expression search for a partner
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I add a new partner external id
    And Partner general information should be:
      | External ID:          |
      | @external_id (change) |
    And I switch hosts to green
    When I search partner by newly created partner external id
    Then Partner search results should be:
      | External ID  | Partner       | Type    |
      | @external_id | @company_name | MozyPro |
    When I search partner by newly created partner admin email
    Then Partner search results should be:
      | External ID  | Partner       | Root Admin   |
      | @external_id | @company_name | @admin_email |
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 790 Do a search for all partners
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I switch hosts to green
    When I search partner by:
      | name                              |
      | Charter Business Trial - Reserved |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |
    When I search partner by:
      | name          |
      | @company_name |
    Then Partner search results should be:
      | Partner       | Created |
      | @company_name | today   |
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16263 Verify all credit card transactions from the creation of the partner to the current date
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I act as newly created partner account
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    And I switch hosts to green and act as newly created partner
    When I download Credit Card Transactions (CSV) quick report
    Then Quick report Credit Card Transactions csv file details should be:
      | Column A | Column B | Column C | Column D  |
      | Date     | Amount   | Card #   | Card Type |
      | @today   | $86.00   | @XXXX    | Visa      |
      | @today   | $95.00   | @XXXX    | Visa      |

  @blue_green
  Scenario: 12355 Add a new partner and verify it appears in the module
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I switch hosts to green
    When I navigate to Order Data Shuttle section from bus admin console page
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16151 Verify account reinstate from active dunning 1 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I switch hosts to green and act as newly created partner
#    And I act as partner by:
#      | email        |
#      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 11
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I switch hosts to blue and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 700 Check partners list/view check to make sure you can't change the name
#    When I navigate to List Roles section from bus admin console page
#    And I clean all roles with name which started with "$AUTOTEST$"
    When I navigate to Add New Role section from bus admin console page
    And I add a new role
    And I add capabilities for the new role:
      | Capabilities        |
      | Partners: list/view |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
    # Multiple roles can be specified as role1, role2, role3 (separated by comma)
      | Roles      |
      | @role_name |
    And I switch hosts to green
    And I act as latest created admin
    Then I should see capabilities in Admin Console panel
      | Capabilities           |
      | Search / List Partners |
    And I navigate to Search / List Partners section from bus admin console page
    And I list partner details for a partner in partner list
    And I cannot change partner name
    And I log in bus admin console as administrator
    And I delete lastest created admin
    And I delete role @role_name

  @blue_green
  Scenario: 795 Search for partners with the business type
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And I switch hosts to green
    When I search partner by:
      | name          | filter     |
      | @company_name | Businesses |
    Then Partner search results should be:
      | Partner       | Type    |
      | @company_name | MozyPro |
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16153 Verify account reinstate from active dunning 3 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I switch hosts to green and act as newly created partner
#    And I act as partner by:
#      | email        |
#      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 13
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I switch hosts to blue and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 796 Search for partners with the reseller type
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Platinum      | 500            | yes       |
    And New partner should be created
    And I switch hosts to green
    When I search partner by:
      | name          | filter   |
      | @company_name | Reseller |
    Then Partner search results should be:
      | Partner       | Type     |
      | @company_name | Reseller |
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 20946 [MozyPro] Delete device
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20946-1 | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    And I delete user
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20946-1 | Server       | 20            | 2       |
    Then 1 new user should be created
    And I switch hosts to blue and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I delete user
    And I refresh Search List User section
    Then The users table should be empty
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 21070 [Bundled][Reseller] Delete device
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                      |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled][Reseller] Delete device |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21070-1 | (default user group) | Desktop      | 25            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M1      | Desktop      | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 20 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M1
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I close user details section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21070-2 | (default user group) | Server       | 20            | 2       |
    Then 1 new user should be created
    And I switch hosts to green and act as newly created partner
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | TEST_M2      | Server       | @partner_name |
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Used/Available |
      | 5 GB / 15 GB   |
    When I view the user's product keys
    Then Number of activated keys should be 1
    And Number of unactivated keys should be 1
    When I delete device by name: TEST_M2
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of activated keys should be 0
    And Number of unactivated keys should be 2
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 120658 Standard admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Standard admin and Standard password
    And I log out bus admin console
    And I switch hosts to green without login bus
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Standard admin and Standard password
    And I log out bus admin console

  @blue_green
  Scenario: 17881 Verify billing statements when order a data shuttle
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    And I switch hosts to blue and act as newly created partner
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      #| today | $0.00   | $275.00    | $-275.00    |
      | today | $275.00 | $275.00    | $0.00       |
      | today | $190.00 | $190.00    | $0.00       |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: Mozy-19640:Access Partner as Partner Admin
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    And I switch hosts to green without login bus
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | storage_type | devices |
      | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
      | @user_email | @user_name   | 0 	      | Shared  | None  	   | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 50 GB Available | Desktop: 0 Used / 1 Available Edit  |
    And I switch hosts to blue
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16342 Manually change number of mac drives ordered
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 1 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 500           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | mac drivers | drive type     |
      | Data Shuttle US | available | 500   | 0           | 2           | 3.5" 2TB Drive |
    And The number of mac drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 12355 Add a new partner and verify it appears in the module
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I switch hosts to green
    When I navigate to Order Data Shuttle section from bus admin console page
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 17879 Ordering data shuttle over 1.8T for Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 2000          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 2000  | 3.5" 2TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 3.6 TB | 1        | $375.00 |
      | Total Price         |          | $375.00 |
    Then The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16340 Manually change number of windows drives ordered
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 1000        | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | drive type     |
      | Data Shuttle US | available | 1000  | 2           | 3.5" 2TB Drive |
    And The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Device   | Storage Type | Used/Available | Device Storage Limit | Last Update    | Action |
      | Machine1 | Desktop      | 10 GB / 40 GB  | Set                  | < a minute ago |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 120069 HIPAA for MozyPro US partner and sub-partners
    When I add a new MozyPro partner:
      | period | base plan | security | net terms |
      | 12     | 50 GB     |  HIPAA   |    yes    |
    Then Sub-total before taxes or discounts should be $219.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $219.89    | $219.89     |
      | Pre-tax Subtotal  |          |            | $219.89     |
      | Total Charges     |          |            | $219.89     |
    And New partner should be created
    And Partner general information should be:
      | Security: | Status:         | Root Admin:          | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
      | HIPAA     | Active (change) | @root_admin (act as) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
    And I change root role to Leong Test Role
    And I switch hosts to green and act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | TC.120069    |
    And New partner should be created
    And I switch hosts to blue and act as newly created partner
    And I search partner by TC.120069
    And I view partner details by TC.120069
    And Partner general information should be:
      | Security: |
      | HIPAA     |
    And I delete partner account
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 18897 Deletion is triggered by admins in the bus(Mozypro,business,yearly)
    When I add a new MozyPro partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 100 GB      | 1             |
    And New partner should be created
    And I get partner aria id
    And I switch hosts to green
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I delete partner account
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |

  @blue_green
  Scenario: 15275 Verify Credit Card Required Fields
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 10    |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name     | cc number        | expire month | expire year | cvv |
      |             | 4018121111111122 | 12           | 19          | 123 |
    And I save payment information changes
    Then Modify credit card error messages should be Please enter the name on your credit card.
    When I update credit card information to:
      | cc name     | cc number        | expire month | expire year | cvv |
      | new name    |                  | 12           | 19          | 123 |
    And I save payment information changes
    Then Modify credit card error messages should be You must enter a credit card number.
# Verification below is for Production only
# When I update credit card information to:
#   | cc name     | cc number        | expire month | expire year | cvv |
#   | new name    | 4111111111111111 | 12           | 19          |     |
# And I save payment information changes
# Then Modify credit card error messages should be Card security code missing.
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: Mozy-14116::Autogrow enabled billing
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I switch hosts to green and act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add a new Bundled user group:
      | name | storage_type | limited_quota | server_support |
      | UG 1 | Limited      | 1             | yes            |
    Then UG 1 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I upload data to device by batch
      | machine_id                  | GB  | upload_file |
      | <%=@clients[0].machine_id%> | 1.1 | false       |
    And I upload data to device by batch
      | machine_id                  | GB    | upload_file |
      | <%=@clients[0].machine_id%> | 0.001 | true        |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I add a new Bundled user group:
      | name | storage_type | server_support |
      | UG 2 | Shared       | yes            |
    Then UG 2 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 2       | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload 2 GB of data to device
    Then tds returns successful upload
    And I stop masquerading
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I search and delete partner account by newly created partner company name

  @blue_green
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Device          | Storage Type | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1        | Desktop      | 0 / 50 GB      | Set                  | N/A         |        |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16320 Ordering data shuttle over 3.6T for MozyPro
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 4 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 3800          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 3800  | 3.5" 2TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 5.4 TB | 1        | $475.00 |
      | Total Price         |          | $475.00 |
    Then The number of win drivers should be 3
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16323 Ordering data shuttle with 100% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount | drive type     |
      | Data Shuttle US | available | 10    | 100      | 3.5" 2TB Drive |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $0.00   |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 16324 Ordering data shuttle with 50% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I switch hosts to green
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount | drive type     |
      | Data Shuttle US | available | 10    | 50       | 3.5" 2TB Drive |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $137.50  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 120085 [OEM]Hippa admin cannot see the activate admin link in admin console
    When I add a new OEM partner:
      | Root role     | Security | Company Type     |
      | ITOK OEM Root | HIPAA    | Service Provider |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will see the activate admin link
    And I switch hosts to green and act as newly created subpartner
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles    |
      | ATC695 | ITOK OEM Root |
    When I view the admin details of ATC695
    Then I will not see the activate admin link
    And I close the admin details section
    And I switch hosts to blue and act as newly created subpartner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name | Type                          | Parent        |
      | role | <%=@subpartner.company_name%> | ITOK OEM Root |
    And I check all the capabilities for the new role
    And I close the role details section
    And I switch hosts to green and act as newly created subpartner
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles |
      | ATC696 | role  |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    And I close the admin details section

    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | ITOK OEM Root |
    And I check all the capabilities for the new role
    And I switch hosts to blue and act as newly created subpartner
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    When I view the newly created subpartner admin details
    Then I will not see the activate admin link
    And I switch hosts to green and act as newly created subpartner
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles   |
      | ATC696 | subrole |
    When I view the admin details of ATC696
    Then I will not see the activate admin link
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @blue_green
  Scenario: 17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    And I switch hosts to green
    And I act as partner by:
      | email        |
      | @admin_email |
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @blue_green
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
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

  @blue_green
  Scenario: 120659 Hipaa admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Hipaa admin and Hipaa password
    And I log out bus admin console
    And I switch hosts to green without login bus
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Hipaa admin and Hipaa password
    And I log out bus admin console

  @blue_green
  Scenario: 15272 Verify Modify Credit Card Checkbox
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    Then I should able to modify credit card information
    And I should able to view cvv help popup dialog
    And I should able to close cvv help popup dialog
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 17849 Verify report type drop down list values in scheduled report view
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Scheduled Reports section from bus admin console page
    Then I should see report filters are:
      | Report Type        |
      | None               |
      | Billing Summary    |
      | Billing Detail     |
      | Machine Watchlist  |
      | Machine Status     |
      | Outdated Clients   |
      | Resources Added    |
      | Machine Over Quota |

  @blue_green
  Scenario: 120661 Hipaa user log into BUS with upper/mixed case username
    When I navigate to Hipaa subdomain user login page
    Then I log into Hipaa subdomain with uppercase username Hipaa user and Hipaa password
    And I log out user
    And I switch hosts to green without login bus
    Then I log into Hipaa subdomain with mixed case username Hipaa user and Hipaa password
    And I log out user

  @blue_green
  Scenario: 19867 Existing OEM partner without subpartners can purchase resources
    When I act as partner by:
      | email                                   | filter |
      | redacted-374495@notarealdomain.mozy.com | OEMs   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And I switch hosts to green
    When I act as partner by:
      | email                                   | filter |
      | redacted-374495@notarealdomain.mozy.com | OEMs   |
    And I navigate to Purchase Resources section from bus admin console page
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @blue_green
  Scenario: 19194 [Test connection][UI][N]Test failed with 400 when I input invalid data
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I switch hosts to green and act as newly created partner
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.99    | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid hosts|
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
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
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then device table in user details should be:
      | Device          | Storage Type |Used/Available     | Device Storage Limit | Last Update      | Action |
      | Machine1        | Desktop      |10 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine2        | Desktop      |20 GB / 140 GB     | Set                  | < a minute ago   |        |
      | Machine3        | Desktop      |30 GB / 140 GB     | Set                  | < a minute ago   |        |
    Then stash device table in user details should be:
      | Sync Container | Used/Available     | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 140 GB         | Set                  | N/A              |        |

  @blue_green
  Scenario: Mozy-14115::Enable autogrow partner admin
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized Reseller partner:
#      | period | desktop licenses | desktop quota |
#      | 12     | 2                | 2             |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I Enable partner details autogrow
#    Then partner details message should be
#    """
#    Autogrow protection enabled.
#    """
#    And I migrate the partner to pooled storage
    When I search partner by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I view partner details by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I get the partner_id
    And I get the partners name Itemized_Reseller_DONOT_ChangePlan(Migrate) and type Reseller
    And I switch hosts to green
    When I act as partner by:
      | email                  |
      | qa1+ruby_gem@decho.com |
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Desktop      | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload data to device by batch
      | machine_id                  | GB  |
      | <%=@clients[0].machine_id%> | 0.8 |
    Then tds returns successful upload
    And I delete user

  @blue_green
  Scenario: 19196 [Test connection][UI][N]Test failed with 200 when I input valid data but meet with other failure
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I switch hosts to green and act as newly created partner
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password  |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | wrong password |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 15273 Change Payment Information Without Credit Card
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | address         | city     | state    | country | zip    | phone    | email         |
      | 333 Songhu Road | Shanghai | Shanghai | China   | 200433 | 12345678 | test@mozy.com |
    And I save payment information changes
    Then Payment information should be updated
    When I wait for 10 seconds
    Then API* Aria account should be:
      | billing_address1 | billing_city | billing_locality | billing_country | billing_zip | billing_intl_phone | billing_email |
      | 333 Songhu Road  | Shanghai     | Shanghai         | CN              | 200433      | 12345678           | test@mozy.com |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 12942 Suspended partner order data shuttle
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    And I suspend the partner
    And I switch hosts to green
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty
    Then I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 2187 Prevent Session Fixation
    When I navigate to bus admin console login page
    And I save login page cookies _session_id value
    And I switch hosts to green without login bus
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I save admin console page cookies _session_id value
    Then Two cookies value should be different
    When I search partner by:
      | name  |
      | mozy  |
    And Admin console page cookies _session_id value should not changed

  @blue_green
  Scenario: 15458 Verify Only the Last Four Digits of Credit Card Number Visible
    When I add a new MozyPro partner:
      | period | base plan | cc number        |
      | 12     | 10 GB     | 4018121111111122 |
    Then New partner should be created
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Payment Information section from bus admin console page
    Then Credit card number should be XXXX XXXX XXXX 1122
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @blue_green
  Scenario: 789 Search partner by company name
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I switch hosts to green
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    And I search and delete partner account by newly created partner company name
