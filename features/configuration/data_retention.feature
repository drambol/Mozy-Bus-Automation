Feature: Adjustable retention at the partner and user group level

  As a Mozy Administrator
  I want the ability to set the data retention time at the partner and/or user group level
  so that Sales can offer extended retention to customers.

  Background:
    Given I log in bus admin console as administrator

  @TC.143307_01 @bus @data_retention @qa12
  Scenario: click Data Retention, go to Data Retention section, check default info here. create data retention for partner with subpartner.
    When I add a new MozyEnterprise partner:
      | period | users | server plan  |
      | 12     | 200   | 12 TB        |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 4.9 TB    | 4.9 TB   | 0    | 200       | 200      |
      | Server  | 0    | 12 TB     | 12 TB    | 0    | 200       | 200      |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name      |
      | adr_sub_partner_1 |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 0         | 0        | 0    | 0         | 0        |
    Then the pooled resource section of subpartner should have edit link
    Then the Server and Desktop pooled resource should be editable for the subpartner
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 1 Year (monthly)   |
    And sub partner adr policy should be:
      | Name              | Policy             |
      | adr_sub_partner_1 | 1 Year (monthly)   |
    And ADR policy in DB for partner is Mozy1Year_monthly
    And ADR policy in DB for user group (default user group) is nil
    When I click partner adr policy
    Then adr policy name should be 1 Year (monthly)
    When I set adr policy to 2 Years (quarterly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    And adr policy name should be 2 Years (quarterly)
    When I refresh Data Retention section
    And partner adr policy should be 2 Years (quarterly)
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 2 Years (quarterly) |
    And sub partner adr policy should be:
      | Name              | Policy             |
      | adr_sub_partner_1 | 2 Years (quarterly) |
    And ADR policy in DB for partner is Mozy2Year_quarterly
    And ADR policy in DB for user group (default user group) is nil
    When I search partner by adr_sub_partner_1
    And I view partner details by adr_sub_partner_1
    When I get the partner_id
    And ADR policy in DB for partner is nil

  @TC.143307_02 @bus @data_retention @qa12
  Scenario: create data retention for partner with more than 1 user group
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 100   |
    And New partner should be created
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices |
      | qa-test-group | Shared               | 1               |
    Then Itemized user group should be created
    When I navigate to Data Retention section from bus admin console page
    Then partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 1 Year (monthly)   |
      | qa-test-group        | 1 Year (monthly)   |
    And I should see No results found. in sub partner adr policy list
    When I click partner adr policy
    And I set adr policy to 2 Years (quarterly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 2 Years (quarterly)
    And user group adr policy should be:
      | Name                 | Policy              |
      | (default user group) | 2 Years (quarterly) |
      | qa-test-group        | 2 Years (quarterly) |
    And I should see No results found. in sub partner adr policy list
    And ADR policy in DB for partner is Mozy2Year_quarterly
    And ADR policy in DB for all user groups are nil
    And ADR policy in DB for user group (default user group) is nil
    And ADR policy in DB for user group qa-test-group is nil

  @TC.143307_04 @bus @data_retention
  Scenario: create data retention for partner and then update
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 100   |
    And New partner should be created
    When I act as newly created partner account
    And I navigate to Data Retention section from bus admin console page
    And I click partner adr policy
    Then adr policy name should be 1 Year (monthly)
    And available adr policy names should be:
    | policy              |
    | 7 Days              |
    | 14 Days             |
    | 1 Month (daily)     |
    | 2 Months (weekly)   |
    | 3 Months (weekly)   |
    | 6 Months (monthly)  |
    | 1 Year (monthly)    |
    | 2 Years (quarterly) |
    | 3 Years (quarterly) |
    | 4 Years (quarterly) |
    | 5 Years (quarterly) |
    | 6 Years (quarterly) |
    | 7 Years (quarterly) |
    And available adr policy values should be:
      | policy              |
      | Mozy1Week_daily     |
      | Mozy2Week_daily     |
      | Mozy1Month_daily    |
      | Mozy2Month_weekly   |
      | Mozy3Month_weekly   |
      | Mozy6Month_monthly  |
      | Mozy1Year_monthly   |
      | Mozy2Year_quarterly |
      | Mozy3Year_quarterly |
      | Mozy4Year_quarterly |
      | Mozy5Year_quarterly |
      | Mozy6Year_quarterly |
      | Mozy7Year_quarterly |
    When I set adr policy to 1 Month (daily)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 1 Month (daily)
    And user group adr policy should be:
      | Name                 | Policy          |
      | (default user group) | 1 Month (daily) |
    And I should see No results found. in sub partner adr policy list
    And ADR policy in DB for partner is Mozy1Month_daily
    And ADR policy in DB for user group (default user group) is nil
    When I set adr policy to 2 Months (weekly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 2 Months (weekly)
    And user group adr policy should be:
      | Name                 | Policy            |
      | (default user group) | 2 Months (weekly) |
    And I should see No results found. in sub partner adr policy list
    And ADR policy in DB for partner is Mozy2Month_weekly
    And ADR policy in DB for user group (default user group) is nil

  @TC.143307_001 @bus @data_retention @qa12
  Scenario: click None to create ADR policy for user group, eg."qa-group-1"
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 100   |
    And New partner should be created
    When I act as newly created partner account
    And I navigate to Data Retention section from bus admin console page
    And I click user group (default user group) adr policy
    And I set adr policy to 7 Days
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | 7 Days |
    And I should see No results found. in sub partner adr policy list
    Then ADR policy in DB for user group (default user group) is Mozy1Week_daily
    And ADR policy in DB for partner is Mozy1Year_monthly
    When I get user group id for user group (default user group)
    And the record from adr_jobs table for main job user group should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy1Week_daily | today |  | IN_PROGRESS | 1 | today | today |  |  |
    And the record from adr_jobs table for sub job user group (default user group) should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy1Week_daily | today | <%=@main_job_id%> | IN_PROGRESS | 1 | today | today |  |  |
    And I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices |
      | qa-test-group | Shared               | 1               |
    Then Itemized user group should be created
    When I navigate to Data Retention section from bus admin console page
    And partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy |
      | (default user group) | 7 Days |
      | qa-test-group        | 1 Year (monthly) |
    And I should see No results found. in sub partner adr policy list
    When I click user group qa-test-group adr policy
    And I set adr policy to 14 Days
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 1 Year (monthly)
    And user group adr policy should be:
      | Name                 | Policy  |
      | (default user group) | 7 Days  |
      | qa-test-group        | 14 Days |
    And I should see No results found. in sub partner adr policy list
    Then ADR policy in DB for user group (default user group) is Mozy1Week_daily
    And ADR policy in DB for user group qa-test-group is Mozy2Week_daily
    And ADR policy in DB for partner is Mozy1Year_monthly
    When I get user group id for user group (default user group)
    And the record from adr_jobs table for main job user group should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy1Week_daily | today |  | IN_PROGRESS | 1 | today | today |  |  |
    When I get user group id for user group qa-test-group
    And the record from adr_jobs table for main job user group should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy2Week_daily | today |  | IN_PROGRESS | 1 | today | today |  |  |
    And the record from adr_jobs table for sub job user group qa-test-group should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy2Week_daily | today | <%=@main_job_id%> | IN_PROGRESS | 1 | today | today |  |  |

  @TC.143307_003 @bus @data_retention @qa12
  Scenario: adr jobs table check
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 100   |
    And New partner should be created
    When I act as newly created partner account
    And I navigate to Data Retention section from bus admin console page
    And I click partner adr policy
    And I set adr policy to 6 Months (monthly)
    Then Change ADR Policy section message should be Update data retention policy successfully.
    When I refresh Data Retention section
    And partner adr policy should be 6 Months (monthly)
    And user group adr policy should be:
      | Name                 | Policy             |
      | (default user group) | 6 Months (monthly) |
    And I should see No results found. in sub partner adr policy list
    And ADR policy in DB for partner is Mozy6Month_monthly
    And ADR policy in DB for user group (default user group) is nil
#    When I act as partner by:
#      | email                                        |
#      | mozyautotest+kathleen+gutierrez+1408@emc.com |
    And the record from adr_jobs table for main job partner should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | ProPartner  | <%=@partner_id%> | Mozy6Month_monthly | today |  | IN_PROGRESS | 1 | today | today |  |  |
    When I get user group id for user group (default user group)
    And the record from adr_jobs table for sub job user group (default user group) should be:
#      | id | object_type | object_id        | policy_name        | grace_period | main_job_id | status      | priority | created_at | updated_at | locked_at | progress |
      |  | UserGroup | <%=@user_group_id%> | Mozy6Month_monthly | today | <%=@main_job_id%> | IN_PROGRESS | 1 | today | today |  |  |

  @TC.143307_600 @bus @data_retention @qa12
  Scenario: create many machines here, to be done, refer to features/users/adhoc_tasks/add_multiple_machines.feature
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 0       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then I can see Send Keys button is disable
    Then I close user details section
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
    Then 1 new user should be created
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


  @TC.143307_500 @bus @data_retention @qa12
  Scenario: create many machines here, to be done, refer to features/users/adhoc_tasks/add_multiple_machines.feature
    When I add a new MozyEnterprise partner:
      | company name                  | period | users | server plan | net terms |
      | DONOT EDIT catherine adr test | 24     | 1000  | 500 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add multiple users:
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | test-sync-user | (default user group) | Desktop      | 10            | 2       | yes          |
    And I add multiple users:
      | name             | user_group           | storage_type | storage_limit | devices |
      | test-server-user | (default user group) | Server       | 10            | 2       |