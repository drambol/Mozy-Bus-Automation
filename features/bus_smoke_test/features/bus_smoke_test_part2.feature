Feature: BUS smoke test 2
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - Reseller BUS Smoke Test 3849-7653-73' related scenarios ===================
  @bus_us @TC.125938 @ROR_smoke
  Scenario: Test Case Mozy-125938: BUS US -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                         | period | base plan | coupon                | net terms | server plan |
      | Internal Mozy - Reseller BUS Smoke Test 3849-7653-73 | 1      | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         |
    And New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    Given I log in bus admin console as administrator
    And I search partner by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    And I view partner details by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    And I delete partner account

  #================== partner 'Internal Mozy - OEM BUS Smoke Test 4863-2704-60' related scenarios ===================
  @bus_us @TC.125945 @ROR_smoke
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
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name                               | Pricing Plan | Admin Name |
      | Internal Mozy - subpartner1 8376-3615-73   | subplan      | subadmin1  |
    Then New partner should be created
    And I stop masquerading
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
    When I stop masquerading from subpartner
    When I act as partner by:
      | name                                            |
      | Internal Mozy - OEM BUS Smoke Test 4863-2704-60 |
    And I add a new sub partner:
      | Company Name                               | Pricing Plan | Admin Name |
      | Internal Mozy - subpartner2 4974-9147-43   | subplan      | subadmin2  |
    Then New partner should be created
    And I stop masquerading
    And I search partner by Internal Mozy - subpartner2 4974-9147-43
    And I view partner details by Internal Mozy - subpartner2 4974-9147-43
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
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

  #================== partner 'Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22' related scenarios ===================
  @bus_us @TC.125951 @ROR_smoke
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
    Then I stop masquerading
    And I search partner by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    And I view partner details by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    Then I delete partner account

  #================== partner 'Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02' related scenarios ===================
  @bus_us @TC.125952 @ROR_smoke
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

  #================== partner 'Internal Mozy - MozyPro BUS Smoke Test 0709-1754-57' related scenarios ===================
  @bus_us @TC.131996 @qa_std
  Scenario: Test Case Mozy-131996: BUS US -- Create a new partner with credit card
    When I add a new MozyPro partner:
      | company name                                                    | period | base plan | coupon                | cc number        |
      | Internal Mozy - MozyPro BUS Smoke Test Credit Card 0709-1754-57 | 1      | 10 GB     | <%=QA_ENV['coupon']%> | 4485467443715872 |
    Then New partner should be created

  #================== partner 'Internal Mozy - MozyPro France BUS Smoke Test 0709-1802-56' related scenarios ===================
  @bus_emea @TC.131997 @qa_std
  Scenario: Test Case Mozy-131997: BUS EMEA -- Create a new partner with credit card
    When I add a new MozyPro partner:
      | company name                                                           | period | base plan | create under   | vat number    | coupon                | country | address           | city      | state | zip   | phone          | cc number        |
      | Internal Mozy - MozyPro France BUS Smoke Test Credit Card 0709-1802-56 | 1      | 10 GB     | MozyPro France | FR08410091490 | <%=QA_ENV['coupon']%> | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4485393141463880 |
    Then New partner should be created
