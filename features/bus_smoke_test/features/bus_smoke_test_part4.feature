Feature: BUS smoke test 4
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #=====================================
  @bus_emea @TC.125963
  Scenario: Test Case Mozy-125963: BUS EMEA -- Log into BUS
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27' related scenarios ===================
  @bus_emea @TC.125964
  Scenario: Test Case Mozy-125964: BUS EMEA -- Create a new partner (No VAT Number)
    When I add a new MozyPro partner:
      | company name                                               | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root

  @bus_emea @TC.125965
  Scenario: Test Case Mozy-125965: BUS EMEA -- Verify partner creation in Aria - Precondition:@TC.125964
    When I search partner by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27
    And I view partner details by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |

  @bus_emea @TC.125967
  Scenario: Test Case Mozy-125967: BUS EMEA -- Masquerade into the partner - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |

  @bus_emea @TC.125968 @ROR_smoke
  Scenario: Test Case Mozy-125968: BUS EMEA -- Create a user group - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-1 | Shared       |
    Then test-group-1 user group should be created

  @bus_emea @TC.125969 @ROR_smoke
  Scenario: Test Case Mozy-125969: BUS EMEA -- Create a user - Precondition:@TC.125968
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    And I add new user(s):
      | name        | user_group   | storage_type  | storage_limit | devices |
      | EMEA-user-1 | test-group-1 | Desktop       | 10            | 1       |
    Then 1 new user should be created

  @bus_emea @TC.125970
  Scenario: Test Case Mozy-125970: BUS EMEA -- Move the user from one user group to a different user group - Precondition:@TC.125969
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I reassign the user to user group (default user group)
    Then the user's user group should be (default user group)

  @bus_emea @TC.125971
  Scenario: Test Case Mozy-125971: BUS EMEA -- Create a client config - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I create a new client config:
      | name                | user group   | type   |
      | smoke_client_config | test-group-1 | Server |
    Then client configuration section message should be Your configuration was saved.

  @bus_emea @TC.125972
  Scenario: Test Case Mozy-125972: BUS EMEA -- Open all of the Resources header to open all of the modules - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page

  @bus_us @TC.125974 @support @ROR_smoke
  Scenario: Test Case Mozy-125974: BUS EMEA -- Check the support link - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I navigate to Contact section from bus admin console page
    And I click My Support on contact section
    Then I login my support successfully

  @bus_emea @TC.125977 @ROR_smoke
  Scenario: Test Case Mozy-125977: BUS EMEA -- Delete test user - Precondition:@TC.125969
    When I act as partner by:
      | name                                                        |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27  |
    And  I navigate to Search / List Users section from bus admin console page
    And I view user details by EMEA-user-1
    And I delete user

  @bus_emea @TC.125978 @ROR_smoke
  Scenario: Test Case Mozy-125978: BUS EMEA -- Delete test user group - Precondition:@TC.125964
    When I act as partner by:
      | name                                                       |
      | Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27 |
    When I add a new Bundled user group:
      | name         | storage_type |
      | test-group-2 | Shared       |
    Then test-group-2 user group should be created
    When I delete user group details by name: test-group-2

  #================== partner 'Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56' related scenarios ===================
  @bus_emea @TC.125973 @ROR_smoke
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
