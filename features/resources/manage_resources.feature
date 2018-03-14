Feature: Manage resources

  Background:
    Given I log in bus admin console as administrator

#  @reseller_manage_resources_example
#  Scenario: Reseller partner manage resources example
#    When I act as partner by:
#      | email                       |
#      | qa1+chris+fox+1111@mozy.com |
#    And I allocate 10 GB Desktop quota with (default user group) user group to Reseller partner
#    Then Reseller resource quota should be changed
#    # Bug 90676
##    And User group general information should be:
##      | Total Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
##      | 10 GB          | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
#    And User group resources details table should be:
#      |         | Active | Assigned | Unassigned     |
#      | Desktop | 0      | 0        | 10 GB   Change |
#      | Server  | 0      | 0        | 0   Change     |
#    And User group license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 0        | 0          |
#      | Server  | 0      | 0        | 0          |
#    When I create 5 new Desktop keys for Reseller partner
#    And I batch assign Reseller partner Desktop keys to (default user group) user group without send emails:
#      | email                                  | quota |
#      | qa1+reseller+assign+key+test1@mozy.com | 5     |
#      | qa1+reseller+assign+key+test2@mozy.com | 10    |
#    And I refresh Manage Resources section
#    # Bug 90676
##    Then Partner resources general information should be:
##      | Total Account Storage: | Unallocated Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
##      | 140 GB                 | 130 GB               | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
#    And Partner total resources details table should be:
#      |         | Active | Assigned | Unassigned | Allocated |
#      | Desktop | 0      | 15 GB    | 0          | 10 GB     |
#      | Server  | 0      | 0        | 0          | 0         |
#    And Partner total license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 2        | 3          |
#      | Server  | 0      | 0        | 0          |
#    And Partner user groups table should be:
#      | Name                 | Active Storage | Allocated Storage |
#      | (default user group) | 0 GB           | 10 GB             |
#
#    # Restore partner status
#    When I delete all inactive keys for (default user group) user group
#    Then All inactive keys should be deleted
#    When I allocate 0 GB Desktop quota with (default user group) user group to Reseller partner
#    Then Reseller resource quota should be changed
#
#  @mozypro_manage_resources_example
#  Scenario: MozyPro partner manage resources example
#    When I act as partner by:
#      | email                                    |
#      | kalen.quam+qa6+jerry+hayes+1417@mozy.com |
#    And I allocate 200 GB Server quota to MozyPro partner
#    Then MozyPro resource quota should be changed
#    And Partner resources general information should be:
#      | Total Account Storage: | Unallocated Storage: | Server Enabled: |
#      | 500 GB                 | 300 GB               | Yes             |
#    #And Partner total resources details table should be:
#    #  |         | Active    | Assigned | Unassigned | Allocated       |
#    #  | Desktop | 0 bytes   | 0 bytes  | 250 GB     | 250 GB   Change |
#    #  | Server  | 0 bytes   | 0 bytes  | 200 GB     | 200 GB   Change |
#    And Partner total license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 0        | 10         |
#      | Server  | 0      | 0        | 10         |
#    And I batch assign MozyPro partner Desktop keys with send emails:
#      | email                                 | quota |
#      | qa1+mozypro+assign+key+test1@mozy.com | 5     |
#      | qa1+mozypro+assign+key+test2@mozy.com | 10    |
#    When I refresh Manage Resources section
#    And Partner total license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 2        | 8          |
#      | Server  | 0      | 0        | 10         |
#    #And Partner total resources details table should be:
#    #  |         | Active    | Assigned | Unassigned | Allocated       |
#    #  | Desktop | 0 bytes   | 15 GB    | 235 GB     | 250 GB   Change |
#    #  | Server  | 0 bytes   | 0 bytes  | 200 GB     | 200 GB   Change |
#
#    # Restore partner status
#    When I delete all inactive keys for current MozyPro partner
#    And I create 10 new Server keys for MozyPro partner
#    And I create 10 new Desktop keys for MozyPro partner
#
#  @mozyenterprise_manage_resources_example @env_dependent
#  Scenario: MozyEnterprise partner manage resources example
#    When I act as partner by:
#      | email                                     |
#      | test_manage_resources_enterprise@auto.com |
#    And I batch assign MozyEnterprise partner Server keys to (default user group) user group without send emails:
#      | email                                        | quota |
#      | qa1+mozyenterprise+assign+key+test1@mozy.com | 5     |
#      | qa1+mozyenterprise+assign+key+test2@mozy.com | 10    |
#      | qa1+mozyenterprise+assign+key+test3@mozy.com | 15    |
#    And I refresh Manage User Group Resources section
#    # Bug 90676
#    #And User group general information should be:
#    #| Total Storage: | Desktop Storage: | Server Storage: | Server Enabled: | Total License Keys: | Desktop Licenses: | Server Licenses: |
#    #| 10 GB          | 10 GB            | 0 GB            | Yes             | 0                   | 0                 | 0                |
#    And User group resources details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 0        | 1.2 TB     |
#      | Server  | 0      | 30 GB    | 1.5 TB     |
#    And User group license details table should be:
#      |         | Active | Assigned | Unassigned |
#      | Desktop | 0      | 0        | 50         |
#      | Server  | 0      | 3        | 197        |
#
#    # Restore partner status
#    When I delete these keys for (default user group) user group in MozyEnterprise partner:
#      | email                                        |
#      | qa1+mozyenterprise+assign+key+test1@mozy.com |
#      | qa1+mozyenterprise+assign+key+test2@mozy.com |
#      | qa1+mozyenterprise+assign+key+test3@mozy.com |

  @TC.18735 @Bug.84691 @regression @bus @2.0 @manage_resources @need_test_account @ROR_smoke @core_function_remove
  Scenario: 18735 Verify unallocated storage auto refreshed when allocated storage changed
    When I act as partner by:
      | email                                     |
      | kalen.quam+qa6+marilyn+dean+1118@mozy.com |
    And I allocate 200 GB Desktop quota to MozyPro partner
    Then MozyPro resource quota should be changed
    And Partner resources general information should be:
      | Total Account Storage: | Unallocated Storage: | Server: |
      | 500 GB                 | 300 GB               | No      |
    # Bug 90677
    #And Partner total resources details table should be:
    #  |         | Active    | Assigned | Unassigned | Allocated       |
    #  | Desktop | 0 bytes   | 0 bytes  | 300 GB     | 200 GB   Change |

    # Restore partner status
    And I allocate 0 GB Desktop quota to MozyPro partner

  @TC.19165 @BSA.3010 @bus @2.5 @user_stories @stash @need_test_account @env_dependent @regression @core_function_remove
  Scenario: 19165 US Pro admin can see stash details in manage resources
    When I act as partner by:
      | email                 |
      | test_bsa3040@auto.com |
    When I navigate to Manage Resources section from bus admin console page
    Then Partner resources general information should be:
      | Users: | Storage Usage: |
      | 1      | 5 MB / 2 GB    |
