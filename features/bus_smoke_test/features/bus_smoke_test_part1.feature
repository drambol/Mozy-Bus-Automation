Feature: BUS smoke test 1
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  @bus_us @TC.125934
  Scenario: Test Case Mozy-125934: BUS US -- Log into BUS
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 ' related scenarios ===================
  @bus_us @TC.125935 @ROR_smoke
  Scenario: Test Case Mozy-125935: BUS US -- Create a new partner
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | coupon                | net terms | server plan | root role               |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created

  @bus_us @TC.125936 @ROR_smoke
  Scenario: Test Case Mozy-125936: BUS US -- Partner Details - License Keys - Precondition:@TC.125935
    When I search partner by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |

  @bus_us @TC.125937
  Scenario: Test Case Mozy-125937: BUS US -- Verify partner creation in Aria - Precondition:@TC.125935
    When I search partner by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |

  @bus_us @TC.125939
  Scenario: Test Case Mozy-125939: BUS US -- Masquerade into the partner - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |

  @bus_us @TC.125940 @ROR_smoke
  Scenario: Test Case Mozy-125940: BUS US -- Create a user group - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And I add a new Bundled user group:
      | name  | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created

  @bus_us @TC.125941 @ROR_smoke
  Scenario: Test Case Mozy-125941: BUS US -- Create a user - Precondition:@TC.125940
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add new user(s):
      | name               | user_group | storage_type |  devices |
      | user without stash | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    Then user details should be:
      | Name:                       |
      | user without stash (change) |

  @bus_us @TC.125942 @ROR_smoke
  Scenario: Test Case Mozy-125942: BUS US -- Update a username & password - Precondition:@TC.125941
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user without stash
    When edit user details:
      | email                  |
      | <%=create_user_email%> |
    Then I update the user password to Test1234

  @bus_us @TC.125943 @ROR_smoke
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
    Then the user's user group should be omega
    When I close user details section

  @bus_us @TC.125944 @ROR_smoke
  Scenario: Test Case Mozy-125944: BUS US -- User Details - Send Keys - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | user with stash | (default user group) | Desktop      | 2             | 3       | yes          |
    Then 1 new user should be created
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

  @bus_us @TC.125946
  Scenario: Test Case Mozy-125946: BUS US -- Create a machine, search list machine and view machine details - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Search / List Machines section from bus admin console page
    Then Search list machines section is opened

  @bus_us @TC.125947 @ROR_smoke
  Scenario: Test Case Mozy-125947: BUS US -- Create an admin - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | User Group           | Roles                   |
      | sub admin | (default user group) | Bundle Pro Partner Root |
    Then Add New Admin success message should be displayed

  @bus_us @TC.125948 @ROR_smoke
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
      | Name                | Roles    |
      | admin with new role | new role |
    Then Add New Admin success message should be displayed

  @bus_us @TC.125949
  Scenario: Test Case Mozy-125949: BUS US -- Create a client config - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I create a new client config:
      | name                 | type   |
      | deploy_client_config | Server |
    Then client configuration section message should be Your configuration was saved.

  @bus_us @TC.125950 @ROR_smoke
  Scenario: Test Case Mozy-125950: BUS US -- Open all of the Resources header to open all of the modules - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page

  @bus_us @TC.125953 @support @ROR_smoke
  Scenario: Test Case Mozy-125953: BUS US -- Check the support link - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I navigate to Contact section from bus admin console page
    And I click My Support on contact section
    Then I login my support successfully

  @bus_us @TC.125956 @ROR_smoke
  Scenario: Test Case Mozy-125956: BUS US -- Delete test user - Precondition:@TC.125943
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add new user(s):
      | name           | user_group | storage_type |  devices |
      | user to delete | omega      | Server       |  1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by user to delete
    Then user details should be:
      | Name:                   |
      | user to delete (change) |
    And I delete user

  @bus_us @TC.125957 @ROR_smoke
  Scenario: Test Case Mozy-125957: BUS US -- Delete test user group - Precondition:@TC.125935
    When I act as partner by:
      | name                                                |
      | Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32 |
    When I add a new Bundled user group:
      | name  | storage_type | assigned_quota | enable_stash | server_support |
      | gamma | Assigned     | 3              | yes          | yes            |
    Then gamma user group should be created
    When I navigate to User Group List section from bus admin console page
    And I delete user group details by name: gamma
    Then gamma user group should be deleted
