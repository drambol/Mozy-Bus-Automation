Feature: data retention machines

  As a Mozy Administrator. I have the ability to enable/disable the data retention capability to different Roles.

  Background:
    Given I log in bus admin console as administrator

  @TC.133059 @TC.133060 @TC.133061 @TC.133062 @TC.133063 @TC.133064 @bus @data_retention @bus2.27 @P1 @ROR_smoke @qa12
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
    Then I act as newly created partner
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
    Then I act as newly created partner
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


  @TC.133058 @TC.133059 @TC.133065 @TC.133066 @TC.133067 @TC.133068 @TC.133069 @TC.133070 @TC.133071 @133072 @bus @data_retention @bus2.27 @P1 @qa12
  Scenario: create policy at user group level only
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133065    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug2  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug3  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug2_user1  | ug2                  |  Desktop     |  1            |  1      | Yes          |
      | ug3_user1  | ug3                  |  Desktop     |  1            |  1      | Yes          |
    #======step5: delete machine ugdf_user2_machine_1======
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
    #======step6: delete machine ugdf_user2_machine_1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ug1_user2  |
    Then I view user details by ug1_user2
    And I view machine ug1_user2_machine_1 details from user details section
    When I delete device by name: ug1_user2_machine_1
    And the popup message when delete device is Do you want to delete ug1_user2_machine_1?
    And I refresh User Details section
    Then Device ug1_user2_machine_1 should not show
    And I close User Details section
    #======step7: stop masquerading from partner======
    And I stop masquerading
    #======step8: search partner and change role to RefID======
    When I search partner by TC.133065
    And I view partner details by TC.133065
    And I get the partner_id
    #And I change root role to FedID role
    #TC.133065 - create policy at user group level only======
    #======step9: act as partner======
    Then I act as newly created partner account
    #======step10: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step11: set policy for ug2======
    When I click user group ug2 adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step12: set policy for ug3======
    When I click user group ug3 adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step13: check adr job created in db for user group, adr policy name is set in db======
    Given I navigate to User Group List section from bus admin console page
    When I get user group's (default user group) adr job id
    Then adr job is not empty
    And ADR policy in DB for user group (default user group) is Mozy3Month_weekly
    #TC.133065 - check adr_policy_name column for existing machine under user group======
    #======step14: check vc policy name in db for a existing machine======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then device ugdf_user1_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user1_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133066 - check adr_policy_name colume for new machine under this user group======
    #======step15: create a new user with backup machine======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step16: check vc policy name in db for new machine======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    Then device ugdf_user5_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user5_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133067 - check adr_policy_name colume for deleted machine under this user group======
    #======step17: check vc policy name in db for deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    Then device ugdf_user2_machine_1 detail info in db should be:
      | alias                | vc_policy_name     |
      | ugdf_user2_machine_1 | Mozy6Month_monthly |
    And I close User Details section
    And I clear user search results
    #TC.133068 - check adr_policy_name colume when delete machine under this user group======
    #======step18: delete machine ugdf_user3_machine_1======
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
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133069 - replace machine with a machine in the same user group======
    #======step19: search machine and do replacement======
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    And I select ugdf_user1_machine_1 to be replaced
    #=======step20: query replace machine in db======
    When I search user by:
      | keywords   |
      | ugdf_user4 |
    And I view user details by ugdf_user4
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user4_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user4_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133070 - replace machine with a machine in another user group
    #======step21: search machine and do replacement, empty policy======
    When I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #======step22: search machine and do replacement, different policies======
    And I select ug3_user1_machine_1 to be replaced
    #======step23: search machine and do replacement, same policies======
    And I select ug2_user1_machine_1 to be replaced
    #======step24: query replace machine in db======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user5_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user5_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133071 - replace machine under other user group with machine in this user group
    #======step25: create users and machines under user groups (same policy)======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_user100  | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user100  | ug2                  |  Desktop     |  1            |  1      | Yes          |
    #======step26: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step27: get user details by clicking user link, and close user group details section======
    And I click user ug_user100 on user group list section's user table
    Then I close the user group detail page
    #======step28: get user id for query purpose=====
    And I get the user id
    #======step29: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user100_machine_1 link
    Then I close the user detail page
    #======step30: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user100_machine_1 to be replaced
    #======step31: check the vc_policy in db for the machine and close the machine details section=====
    And ADR policy in DB for deleted device ug_user100_machine_1 is Mozy3Month_weekly
    #======step32: create users and machines under user groups (different policy)======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_user201  | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user201  | ug3                  |  Desktop     |  1            |  1      | Yes          |
    #======step33: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step34: get user details by clicking user link, and close user group details section======
    And I click user ug_user201 on user group list section's user table
    Then I close the user group detail page
    #======step35: get user id for query purpose=====
    And I get the user id
    #======step36: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user201_machine_1 link
    Then I close the user detail page
    #======step37: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user201_machine_1 to be replaced
    #======step38: check the vc_policy in db for the machine and close the machine details section=====
    And ADR policy in DB for existing device ug_user201_machine_1 is Mozy3Month_weekly
    #TC.133072 - delete user owns the machine
    #======step39: create a new user with backup machine======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_delete   | (default user group) |  Desktop     |  1            |  1      | Yes          |
    When I search user by:
      | keywords  |
      | ug_delete |
    Then I view user details by ug_delete
    And I get the user id
    #======step40: delete user======
    When I delete user
    #======step41: check machine's vc policy in db belonging to the deleted user======
    And ADR policy in DB for deleted device ug_delete_machine_1 is Mozy3Month_weekly
    #======step42: stop masquerading from current partner======
    And I stop masquerading
    #======step43: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133065 |
    #Then I view partner details by TC.133065
    #And I delete partner account


  # Testing data -
  # partner(mozypro) - Mozy 6 Months (monthly)
  #   - default user group (ADR=3 Months (weekly))
  #         ugdf_user1
  #   - ug1
  #         ug1_user1
  #         ug1_user2 (machine=ug1_user2_machine_1:deleted, before ADR assigned on ug1 user group)
  #         ug1_user3
  #         ug1_user4
  #         ug1_user5 (new user)
  #   - ug2 (ADR=3 Months (weekly))
  #         ug2_user1
  #         ug2_user2
  #   - ug3 (ADR=3 Years (quarterly))
  #         ug3_user1
  @TC.133073 @TC.133074-x @TC.133080 @TC.133081 @bus @data_retention @bus2.27 @P1 @qa12
  Scenario: existing machine under other user group
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133073    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug2  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug3  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user3  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user4  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug2_user1  | ug2                  |  Desktop     |  1            |  1      | Yes          |
      | ug2_user2  | ug2                  |  Desktop     |  1            |  1      | Yes          |
      | ug3_user1  | ug3                  |  Desktop     |  1            |  1      | Yes          |
    #======step6: delete machine ugdf_user2_machine_1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ug1_user2  |
    Then I view user details by ug1_user2
    And I view machine ug1_user2_machine_1 details from user details section
    When I delete device by name: ug1_user2_machine_1
    And the popup message when delete device is Do you want to delete ug1_user2_machine_1?
    And I refresh User Details section
    Then Device ug1_user2_machine_1 should not show
    And I close User Details section
    #======step7: stop masquerading from partner======
    And I stop masquerading
    #======step8: search partner and change role to RefID======
    When I search partner by TC.133073
    And I view partner details by TC.133073
    And I get the partner_id
    #And I change root role to FedID role
    #TC.133065 - create policy at user group level only======
    #======step9: act as partner======
    Then I act as newly created partner account
    #======step10: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step11: set policy for ug2======
    When I click user group ug2 adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step12: set policy for ug3======
    When I click user group ug3 adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #TC.133073 - check adr_policy_name column for existing machine under other user group
    #======step13: check existing machine's vc policy name in db======
    When I search user by:
      | keywords  |
      | ug1_user1 |
    And I view user details by ug1_user1
    And I get the user id
    Then ADR policy in DB for existing device ug1_user1_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133075 - check adr_policy_name colume for new machine under other user group
    #======step14: create new user with backup machine======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name      | user_group | storage_type | storage_limit | devices | enable_stash |
      | ug1_user5 | ug1        |  Desktop     |  1            |  1      | Yes          |
    #======step15: check vc policy name in db for new machine======
    When I search user by:
      | keywords  |
      | ug1_user5 |
    And I view user details by ug1_user5
    Then device ug1_user5_machine_1 detail info in db should be:
      | alias               | vc_policy_name     |
      | ug1_user5_machine_1 | Mozy6Month_monthly |
    And I close User Details section
    And I clear user search results
    #TC.13306 - check adr_policy_name colume for deleted machine under other user group
    #======step16: check deleted machine's vc ploicy in db======
    When I search user by:
      | keywords  |
      | ug1_user2 |
    And I view user details by ug1_user2
    And I get the user id
    Then ADR policy in DB for deleted device ug1_user2_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133017 - check adr_policy_name colume when delete machine under other user group
    #======step17: create new machine with backup machine======
    #======step18: search user and view machine details======
    When I search user by:
      | keywords  |
      | ug1_user4 |
    And I view user details by ug1_user4
    And I get the user id
    #======step19: delete machine======
    And I view machine ug1_user4_machine_1 details from user details section
    When I delete device by name: ug1_user4_machine_1
    And the popup message when delete device is Do you want to delete ug1_user4_machine_1?
    And I refresh User Details section
    Then Device ug1_user4_machine_1 should not show
    And I close User Details section
    #======step20: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user4_machine_1 is Mozy6Month_monthly
    #TC.133078 - replace machine with a machine in the same user group
    #======step21: search machine and do replacement, empty policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name        |
      | ug1_user1_machine_1 |
    And I view machine details for ug1_user1_machine_1
    And I click on the replace machine link
    Then I select ug1_user3_machine_1 to be replaced
    #======step22: search machine and check its vc policy in db======
    When I search user by:
      | keywords  |
      | ug1_user1 |
    And I view user details by ug1_user1
    And I get the user id
    Then ADR policy in DB for deleted device ug1_user1_machine_1 is Mozy6Month_monthly
    Then ADR policy in DB for existing device ug1_user1_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133079 - replace machine with a machine in this user group
    #======step23: search machine and do replacement, another group having policy set======
    When I search machine by:
      | machine_name        |
      | ug1_user1_machine_1 |
    And I view machine details for ug1_user1_machine_1
    And I click on the replace machine link
    Then I select ug2_user2_machine_1 to be replaced
    #TC.133081 - delete user owns the machine======
    #======step24: create a new user with backup machine======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group | storage_type | storage_limit | devices | enable_stash |
      | ug1_delete | ug1        |  Desktop     |  1            |  1      | Yes          |
    #======step55: search user and get user id======
    When I search user by:
      | keywords   |
      | ug1_delete |
    And I view user details by ug1_delete
    And I get the user id
    #======step25: delete user======
    When I delete user
    #======step26: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_delete_machine_1 is Mozy6Month_monthly
    And I clear user search results
    #======step27: stop masquerading from current partner======
    #And I stop masquerading
    #======step28: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133073 |
    #Then I view partner details by TC.133073
    #And I delete partner account


  @TC.133082 @TC.133084 @TC.133085 @TC.133086 @TC.133087 @TC.133088 @TC.133089 @TC.133090 @bus @data_retention @bus2.27 @P1 @qa12
  Scenario: create policy at partner level only
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133082    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
   #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user3  | ug1                  |  Desktop     |  2            |  1      | Yes          |
    #======step5: delete machine ugdf_user2_machine_1======
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
    #======step6: delete machine ugdf_user2_machine_1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ug1_user2  |
    Then I view user details by ug1_user2
    And I view machine ug1_user2_machine_1 details from user details section
    When I delete device by name: ug1_user2_machine_1
    And the popup message when delete device is Do you want to delete ug1_user2_machine_1?
    And I refresh User Details section
    Then Device ug1_user2_machine_1 should not show
    And I close User Details section
    #TC.133082 - create policy at partner level only
    #======step8: set policy at partner level======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 120 seconds
    #======step9: check partner policy in db======
    And ADR policy in DB for partner is Mozy3Month_weekly
    And ADR policy in DB for user group (default user group) is nil
    And ADR policy in DB for user group ug1 is nil
    #TC.133083 - check adr_policy_name colume for existing machine under any user group
    #======step10: check existing machine's vc policy in db======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133084 - check adr_policy_name colume for new machine under any user group
    #======step11: create a new user with backup device======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step12: check vc policy name in db for new machine======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    Then device ugdf_user5_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user5_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133085 - check adr_policy_name colume for deleted machine under any user group
    #======step12: check vc policy name in db for deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    Then device ugdf_user2_machine_1 detail info in db should be:
      | alias                | vc_policy_name |
      | ugdf_user2_machine_1 | Mozy6Month_monthly  |
    And I close User Details section
    And I clear user search results
    #TC.133086 - check adr_policy_name colume when delete machine under any user grou
    #======step13: search user======
    When I search user by:
      | keywords   |
      | ugdf_user3 |
    And I view user details by ugdf_user3
    And I get the user id
    #======step14: delete machine======
    And I view machine ugdf_user3_machine_1 details from user details section
    When I delete device by name: ugdf_user3_machine_1
    And the popup message when delete device is Do you want to delete ugdf_user3_machine_1?
    And I refresh User Details section
    Then Device ugdf_user3_machine_1 should not show
    And I close User Details section
    #======step15: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is Mozy3Month_weekly
    #TC.133087 - replace machine with a machine in the same user group
    #======step16: search machine and do replacement, empty policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    And I click on the replace machine link
    Then I select ugdf_user4_machine_1 to be replaced
    #======step17: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user1_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133088 - replace machine with a machine in another user group
    #======step18: search machine and replace it with one in another user group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #======step19: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user5_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user5_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133089 - replace machine under other user group with machine in this user group
    #======step20: create users and machines under user groups (same policy)======
    Given I get the partners name TC.133082 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_user100  | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user100  | ug1                  |  Desktop     |  1            |  1      | Yes          |
    #======step21: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step22: get user details by clicking user link, and close user group details section======
    And I click user ug_user100 on user group list section's user table
    Then I close the user group detail page
    #======step23: get user id for query purpose=====
    And I get the user id
    #======step24: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user100_machine_1 link
    Then I close the user detail page
    #======step25: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user100_machine_1 to be replaced
    #======step26: check the vc_policy in db for the machine and close the machine details section=====
    And ADR policy in DB for deleted device ug_user100_machine_1 is Mozy3Month_weekly
    #TC.133090 - delete user owns the machine======
    #======step27: search user======
    When I search user by:
      | keywords  |
      | ug1_user3 |
    And I view user details by ug1_user3
    And I get the user id
    #======step28: delete user======
    When I delete user
    #======step29: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user3_machine_1 is Mozy3Month_weekly
    And I clear user search results
    #======step30: stop masquerading from current partner======
    #And I stop masquerading
    #======step31: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133082 |
    #Then I view partner details by TC.133082
    #And I delete partner account


  @TC.133091 @TC.133092 @TC.133093 @TC.133094 @TC.133095 @TC.133096 @TC.133097 @TC.133098 @TC.133099 @bus @data_retention @bus2.27 @P1 @qa12
  Scenario: update policy at partner level to user group level
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133091    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
   #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user3  | ug1                  |  Desktop     |  2            |  1      | Yes          |
    #======step5: set policy at partner level======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step6: check partner/user group policy in db======
    And ADR policy in DB for partner is Mozy3Month_weekly
    And ADR policy in DB for user group (default user group) is nil
    And ADR policy in DB for user group ug1 is nil
    #======step7: after creating policy at partner level, delete machine ugdf_user2_machine_1======
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
    #TC.133091 - update policy at partner level to user group level
    #======step10: update partner policy======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 120 seconds
    #======step11: check partner/user group policy in db======
    And ADR policy in DB for partner is Mozy1Month_daily
    And ADR policy in DB for user group (default user group) is nil
    And ADR policy in DB for user group ug1 is nil
    #TC.133092 - check adr_policy_name colume for existing machine under updated user group
    #======step12: check existing machine's vc policy in db======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133093 - check adr_policy_name colume for new machine under updated user group
    #======step13: create a new user with backup device======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step14: check vc policy name in db for new machine======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    Then device ugdf_user5_machine_1 detail info in db should be:
      | alias                | vc_policy_name   |
      | ugdf_user5_machine_1 | Mozy1Month_daily |
    And I close User Details section
    And I clear user search results
    #TC.133094 - check adr_policy_name colume for deleted machine under updated user group
    #======step15: check vc policy name in db for deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    Then device ugdf_user2_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user2_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133095 - check adr_policy_name colume when delete machine under updated user grou
    #======step16: search user======
    When I search user by:
      | keywords   |
      | ugdf_user3 |
    And I view user details by ugdf_user3
    And I get the user id
    #======step17: delete machine======
    And I view machine ugdf_user3_machine_1 details from user details section
    When I delete device by name: ugdf_user3_machine_1
    And the popup message when delete device is Do you want to delete ugdf_user3_machine_1?
    And I refresh User Details section
    Then Device ugdf_user3_machine_1 should not show
    And I close User Details section
    #======step18: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is Mozy1Month_daily
    #TC.133096 - replace machine with a machine in the same user group
    #======step19: search machine and do replacement, empty policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    And I click on the replace machine link
    Then I select ugdf_user4_machine_1 to be replaced
    #======step20: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user1_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133097 - replace machine with a machine in another user group
    #======step21: search machine and replace it with one in another user group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #======step22: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user5_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ugdf_user5_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133098 - replace machine under other user group with machine in this user group
    #======step23: create users and machines under user groups (same policy)======
    Given I get the partners name TC.133082 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_user100  | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user100  | ug1                  |  Desktop     |  1            |  1      | Yes          |
    #======step24: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step25: get user details by clicking user link, and close user group details section======
    And I click user ug_user100 on user group list section's user table
    Then I close the user group detail page
    #======step26: get user id for query purpose=====
    And I get the user id
    #======step27: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user100_machine_1 link
    Then I close the user detail page
    #======step28: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user100_machine_1 to be replaced
    #======step29: check the vc_policy in db for the machine and close the machine details section=====
    And ADR policy in DB for deleted device ug_user100_machine_1 is Mozy1Month_daily
    #TC.133099 - delete user owns the machine======
    #======step30: search user======
    When I search user by:
      | keywords  |
      | ug1_user3 |
    And I view user details by ug1_user3
    And I get the user id
    #======step31: delete user======
    When I delete user
    #======step32: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user3_machine_1 is Mozy1Month_daily
    #And I clear user search results
    #======step33: stop masquerading from current partner======
    #And I stop masquerading
    #======step34: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133091 |
    #Then I view partner details by TC.133091
    #And I delete partner account


  @TC.133100 @TC.133101 @TC.133102 @TC.133103 @TC.133145 @TC.133146 @TC.133147 @TC.133148 @133149 @bus @data_retention @bus2.27 @P2 @qa12
  Scenario: update policy at user group level to partner level
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133100    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
   #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user3  | ug1                  |  Desktop     |  2            |  1      | Yes          |
    #TC.133100 - update policy at user group level to partner level
    #======step5: set policy at user group level======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step6: set policy at partner level======
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step7: check adr policy in db for partner and user group======
    And ADR policy in DB for partner is Mozy3Month_weekly
    And ADR policy in DB for user group (default user group) is Mozy1Month_daily
    And ADR policy in DB for user group ug1 is nil
    #TC.133101 - check adr_policy_name colume for existing machine under this user group
    #======step8: check existing machine's vc policy in db======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133102 - check adr_policy_name colume for new machine under this user group
    #======step9: create a new user with backup device======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step10: check vc policy name in db for new machine======
    When I search user by:
      | keywords   |
      | ugdf_user5 |
    And I view user details by ugdf_user5
    Then device ugdf_user5_machine_1 detail info in db should be:
      | alias                | vc_policy_name   |
      | ugdf_user5_machine_1 | Mozy1Month_daily |
    And I close User Details section
    And I clear user search results
    #TC.133103 - check adr_policy_name colume for deleted machine under this user group
    #======step11: check vc policy name in db for deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    Then device ugdf_user2_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user2_machine_1 | Mozy1Month_daily |
    And I close User Details section
    And I clear user search results
    #TC.133145 - check adr_policy_name colume when delete machine under updated user group
    #======step12: search user======
    When I search user by:
      | keywords  |
      | ug1_user2 |
    And I view user details by ug1_user2
    And I get the user id
    #======step13: delete machine======
    And I view machine ug1_user2_machine_1 details from user details section
    When I delete device by name: ug1_user2_machine_1
    And the popup message when delete device is Do you want to delete ug1_user2_machine_1?
    And I refresh User Details section
    Then Device ug1_user2_machine_1 should not show
    And I close User Details section
    #======step14: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user2_machine_1 is Mozy3Month_weekly
    #TC.133146 - replace machine with a machine in the same user group
    #======step15: search machine and do replacement, empty policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    And I click on the replace machine link
    Then I select ugdf_user4_machine_1 to be replaced
    #======step16: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user1_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133147 - replace machine with a machine in another user group
    #======step17: search machine and replace it with one in another user group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user5_machine_1 |
    And I view machine details for ugdf_user5_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #TC.133148 - replace machine under other user group with machine in this user group
    #======step18: create users and machines under user groups (same policy)======
    Given I get the partners name TC.133082 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name        | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ug_user100  | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user100  | ug1                  |  Desktop     |  1            |  1      | Yes          |
    #======step19: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step20: get user details by clicking user link, and close user group details section======
    And I click user ug_user100 on user group list section's user table
    Then I close the user group detail page
    #======step21: get user id for query purpose=====
    And I get the user id
    #======step22: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user100_machine_1 link
    Then I close the user detail page
    #======step23: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user100_machine_1 to be replaced
    #TC.133149 - delete user owns the machine======
    #======step24: search user======
    When I search user by:
      | keywords  |
      | ug1_user3 |
    And I view user details by ug1_user3
    And I get the user id
    #======step25: delete user======
    When I delete user
    #======step26: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user3_machine_1 is Mozy3Month_weekly
    And I clear user search results
    #======step27: stop masquerading from current partner======
    And I stop masquerading
    #======step28: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133100 |
    #Then I view partner details by TC.133100
    #And I delete partner account


  @TC.133161 @TC.133162 @TC.133163 @TC.133164 @TC.133165 @TC.133166 @TC.133167 @bus @data_retention @bus2.27 @P2 @qa12
  Scenario: update policy at user group level to partner level
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133161    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
   #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug1_user2  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user3  | ug1                  |  Desktop     |  2            |  1      | Yes          |
      | ug1_user4  | ug1                  |  Desktop     |  2            |  1      | Yes          |
    #======step5: delete machine ug1_user2_machine_1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords  |
      | ug1_user2 |
    Then I view user details by ug1_user2
    And I view machine ug1_user2_machine_1 details from user details section
    When I delete device by name: ug1_user2_machine_1
    And the popup message when delete device is Do you want to delete ug1_user2_machine_1?
    And I refresh User Details section
    Then Device ug1_user2_machine_1 should not show
    And I close User Details section
    #======step6: set policy at user group level======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step7: set policy at partner level======
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 240 seconds
    #======step8: check adr policy in db for partner and user group======
    And ADR policy in DB for partner is Mozy3Month_weekly
    And ADR policy in DB for user group (default user group) is Mozy1Month_daily
    And ADR policy in DB for user group ug1 is nil
    #TC.133161 - check adr_policy_name column for existing machine under other user group
    #======step9: check existing machine's vc policy in db======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords  |
      | ug1_user1 |
    And I view user details by ug1_user1
    And I get the user id
    Then ADR policy in DB for existing device ug1_user1_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133162 - check adr_policy_name colume for new machine under other user group
    #======step10: create a new user with backup device======
    Given I get the partners name TC.133065 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name      | user_group | storage_type | storage_limit | devices | enable_stash |
      | ug1_user5 | ug1        |  Desktop     |  1            |  1      | Yes          |
    #======step11: check vc policy name in db for new machine======
    When I search user by:
      | keywords  |
      | ug1_user5 |
    And I view user details by ug1_user5
    Then device ug1_user5_machine_1 detail info in db should be:
      | alias               | vc_policy_name   |
      | ug1_user5_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133163 - check adr_policy_name colume for deleted machine under other user group
    #======step12: check vc policy name in db for deleted machine======
    When I search user by:
      | keywords  |
      | ug1_user2 |
    And I view user details by ug1_user2
    Then device ug1_user2_machine_1 detail info in db should be:
      | alias               | vc_policy_name |
      | ug1_user2_machine_1 | Mozy6Month_monthly |
    And I close User Details section
    And I clear user search results
    #TC.133164 - check adr_policy_name colume when delete machine under other user group
    #======step13: search user======
    When I search user by:
      | keywords  |
      | ug1_user3 |
    And I view user details by ug1_user3
    And I get the user id
    #======step13: delete machine======
    And I view machine ug1_user3_machine_1 details from user details section
    When I delete device by name: ug1_user3_machine_1
    And the popup message when delete device is Do you want to delete ug1_user3_machine_1?
    And I refresh User Details section
    Then Device ug1_user3_machine_1 should not show
    And I close User Details section
    #======step14: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user3_machine_1 is Mozy3Month_weekly
    #TC.133165 - replace machine with a machine in the same user group
    #======step14: search machine and do replacement, empty policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name        |
      | ug1_user1_machine_1 |
    And I view machine details for ug1_user1_machine_1
    And I click on the replace machine link
    Then I select ug1_user4_machine_1 to be replaced
    #======step15: search machine and check its vc policy in db======
    When I search user by:
      | keywords  |
      | ug1_user1 |
    And I view user details by ug1_user1
    And I get the user id
    Then ADR policy in DB for deleted device ug1_user1_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ug1_user1_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133166 - replace machine with a machine in this user group
    #======step16: search machine and replace it with one in another user group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name        |
      | ug1_user5_machine_1 |
    And I view machine details for ug1_user5_machine_1
    And I click on the replace machine link
    Then I select ugdf_user1_machine_1 to be replaced
    #TC.133167 - delete user owns the machine
    #======step17: search user======
    When I search user by:
      | keywords  |
      | ug1_user5 |
    And I view user details by ug1_user5
    And I get the user id
    #======step25: delete user======
    When I delete user
    #======step26: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug1_user5_machine_1 is Mozy3Month_weekly
    And I clear user search results
    #======step27: stop masquerading from current partner======
    #And I stop masquerading
    #======step28: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133161 |
    #Then I view partner details by TC.133161
    #And I delete partner account


  @TC.133170 @TC.133171 @TC.133172 @TC.133173 @TC.133174 @TC.133175 @TC.133176 @TC.133177 @TC.133178 @bus @data_retention @bus2.27 @P2 @qa12
  Scenario: create adr policy by vc util at machine level
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133170    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug2  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug3  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user    | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_del   | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug_user    | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug2_user2  | ug2                  |  Desktop     |  2            |  1      | Yes          |
      | ug3_user1  | ug3                  |  Desktop     |  2            |  1      | Yes          |
    #TC.133172 - delete machine======
    #======step5: delete machine and check vc policy name in db======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords |
      | ugdf_del |
    Then I view user details by ugdf_del
    And I view machine ugdf_del_machine_1 details from user details section
    When I delete device by name: ugdf_del_machine_1
    And the popup message when delete device is Do you want to delete ugdf_del_machine_1?
    And I refresh User Details section
    Then Device ugdf_del_machine_1 should not show
    And I close User Details section
    #======step6: check the vc policy name of the deleted machine=====
    When I search user by:
      | keywords |
      | ugdf_del |
    And I view user details by ugdf_del
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_del_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133170 - update adr policy for the machine's user group
    #======step7: set/update adr policy at (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step8: set policy at user group ug1======
    When I click user group ug1 adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step9: set policy at user group ug2======
    When I click user group ug2 adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 240 seconds
    #======step10: check the machine vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    And I get the user id
    Then ADR policy in DB for existing device ugdf_user2_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133173 - delete machine after adr policy updated at user group level
    #======step11: delete machine======
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
    #======step12: check the vc policy name of the deleted machine=====
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user2_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133175 - replace machine with a machine in the same group
    #======step13: replace machine in same group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user1_machine_1 |
    And I view machine details for ugdf_user1_machine_1
    And I click on the replace machine link
    Then I select ugdf_user3_machine_1 to be replaced
    #======step14: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user1_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133176 - replace machine with a machine in another group
    #======step15: replace machine with one from another user group, different policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    Then I select ug2_user2_machine_1 to be replaced
    #======step16: replace machine with one from another user group, same policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #======step17: check the vc plicy in db======
    When I search user by:
      | keywords   |
      | ugdf_user4 |
    And I view user details by ugdf_user4
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user4_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ugdf_user4_machine_1 is Mozy1Month_daily
    And I clear user search results
    And I close User Details section
    #TC.133177 - replace machine under other user group with this machine
    #======step18: get user group details by clicking user group link======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step19: get user details by clicking user link, and close user group details section======
    And I click user ug_user on user group list section's user table
    Then I close the user group detail page
    #======step20: get user id for query purpose=====
    And I get the user id
    #======step21: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user_machine_1 link
    Then I close the user detail page
    #======step22: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user_machine_1 to be replaced
    #======step23: check vc policy in db
    Then ADR policy in DB for deleted device ug_user_machine_1 is Mozy1Month_daily
    Then ADR policy in DB for existing device ug_user_machine_1 is Mozy1Month_daily
    #TC.133171 - update adr policy for the machine's partner
    #======step24: update policy at partner level======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step25: check vc policy in db======
    When I search user by:
      | keywords  |
      | ug3_user1 |
    And I view user details by ug3_user1
    And I get the user id
    Then ADR policy in DB for existing device ug3_user1_machine_1 is Mozy1Year_monthly
    And I clear user search results
    And I close User Details section
    #TC.133174 - delete machine after adr policy updated at partner level
    #======step26: delete machine======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords  |
      | ug3_user1 |
    Then I view user details by ug3_user1
    And I view machine ug3_user1_machine_1 details from user details section
    When I delete device by name: ug3_user1_machine_1
    And the popup message when delete device is Do you want to delete ug3_user1_machine_1?
    And I refresh User Details section
    Then Device ug3_user1_machine_1 should not show
    And I close User Details section
    #======step27: check the vc policy name of the deleted machine=====
    When I search user by:
      | keywords   |
      | ug3_user1 |
    And I view user details by ug3_user1
    And I get the user id
    Then ADR policy in DB for deleted device ug3_user1_machine_1 is Mozy1Year_monthly
    And I clear user search results
    And I close User Details section
    #TC.133178 - delete user owns the machine
    #======step28: search user======
    When I search user by:
      | keywords  |
      | ug2_user2 |
    And I view user details by ug2_user2
    And I get the user id
    #======step29: delete user======
    When I delete user
    #======step30: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ug2_user2_machine_1 is Mozy3Month_weekly
    #And I clear user search results
    #======step31: stop masquerading from current partner======
    #And I stop masquerading
    #======step28: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133170 |
    #Then I view partner details by TC.133170
    #And I delete partner account


  @TC.133109 @TC.133183 @TC.133184 @TC.133185 @TC.133186 @TC.133187 @TC.133188 @TC.133189 @TC.133190 @bus @data_retention @bus2.27 @P2 @qa12
  Scenario: create policy at layer 1 sub-partner level
    #======step1: create MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133109    |   1    |  500 GB    | yes         | yes       |
    #======step2: update role to Business Root which has adr disabled======
    Then I change root role to Business Root
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step3: act as partner=====
    Then I act as newly created partner account
    #======step4: create subrole and subplan======
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======step5: create a new sub partner layer 1======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133109_layer1 |
    Then New partner should be created
    #======step6: stop masquerading======
    But I stop masquerading
    #======step7: log in as subpartner layer1, purchase resource======
    Given I navigate to Search / List Partners section from bus admin console page
    When I search partner by:
      | name                      |
      | sub_partner_133109_layer1 |
    Then I view partner details by sub_partner_133109_layer1
    And I act as newly created partner
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step8: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash |
      | ug1  | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash |
      | ug2  | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  2            |  1      | Yes          |
      | ugdf_user3 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user4 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ugdf_user5 | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug_user    | (default user group) |  Desktop     |  1            |  1      | Yes          |
      | ug1_user1  | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug_user    | ug1                  |  Desktop     |  1            |  1      | Yes          |
      | ug2_user1  | ug2                  |  Desktop     |  2            |  1      | Yes          |
    #======step9: delete machine======
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
    #TC.133109 - create policy at layer 1 sub-partner level
    #======step10: set adr policy at subpartner layer======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 3 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 240 seconds
    #TC.133183 - check adr_policy_name colume for existing machine under any user group
    #======step11: check vc policy name in db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133184 - check adr_policy_name colume for new machine under any user group
    #======step12: create a new user with backup device======
    Given I get the partners name sub_partner_133109_layer1 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user6 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step13: check vc policy name in db for new machine======
    When I search user by:
      | keywords   |
      | ugdf_user6 |
    And I view user details by ugdf_user6
    Then device ugdf_user6_machine_1 detail info in db should be:
      | alias                | vc_policy_name    |
      | ugdf_user6_machine_1 | Mozy3Month_weekly |
    And I close User Details section
    And I clear user search results
    #TC.133185 - check adr_policy_name colume for deleted machine under any user group
    #======step14: check vc policy for the deleted machine======
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user2_machine_1 is Mozy6Month_monthly
    And I clear user search results
    And I close User Details section
    #TC.133186 - check adr_policy_name colume when delete machine under any user group
    #======step15: search user======
    When I search user by:
      | keywords   |
      | ugdf_user3 |
    And I view user details by ugdf_user3
    And I get the user id
    #======step16: delete machine======
    And I view machine ugdf_user3_machine_1 details from user details section
    When I delete device by name: ugdf_user3_machine_1
    And the popup message when delete device is Do you want to delete ugdf_user3_machine_1?
    And I refresh User Details section
    Then Device ugdf_user3_machine_1 should not show
    And I close User Details section
    #======step17: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ugdf_user3_machine_1 is Mozy3Month_weekly
    #TC.133187 - replace machine with a machine in the same user group
    #======step18: replace machine in same group======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user4_machine_1 |
    And I view machine details for ugdf_user4_machine_1
    And I click on the replace machine link
    Then I select ugdf_user5_machine_1 to be replaced
    #======step19: search machine and check its vc policy in db======
    When I search user by:
      | keywords   |
      | ugdf_user4 |
    And I view user details by ugdf_user4
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user4_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user4_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133188 - replace machine with a machine in another user group
    #======step20: set different policy on user group ug2======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug2 adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 180 seconds
    #======step21: replace machine, different policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user6_machine_1 |
    And I view machine details for ugdf_user6_machine_1
    And I click on the replace machine link
    Then I select ug2_user1_machine_1 to be replaced
    #======step22: replace machine, same policy======
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Search / List Machines section from bus admin console page
    When I search machine by:
      | machine_name         |
      | ugdf_user6_machine_1 |
    And I view machine details for ugdf_user6_machine_1
    And I click on the replace machine link
    Then I select ug1_user1_machine_1 to be replaced
    #======step23: check vc polivy in db======
    When I search user by:
      | keywords   |
      | ugdf_user6 |
    And I view user details by ugdf_user6
    And I get the user id
    Then ADR policy in DB for deleted device ugdf_user6_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ugdf_user6_machine_1 is Mozy3Month_weekly
    And I clear user search results
    And I close User Details section
    #TC.133189 - replace machine under other user group with machine in this user group
    #======step24: replae same machine belonging two groups======
    Given I navigate to User Group List section from bus admin console page
    When I view user group details by name: (default user group)
    #======step25: get user details by clicking user link, and close user group details section======
    And I click user ug_user on user group list section's user table
    Then I close the user group detail page
    #======step26: get user id for query purpose=====
    And I get the user id
    #======step27: get machine details by clicking machine link, and close user detail section======
    When I click device ug_user_machine_1 link
    Then I close the user detail page
    #======step28: replace machine with the same machine under other group======
    And I click on the replace machine link
    Then I select ug_user_machine_1 to be replaced
    #======step29: check vc policy in db
    Then ADR policy in DB for deleted device ug_user_machine_1 is Mozy3Month_weekly
    Then ADR policy in DB for existing device ug_user_machine_1 is Mozy3Month_weekly
    #TC.133190 - delete user owns the machine
    #======step30: search user======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    And I get the user id
    #======step31: delete user======
    When I delete user
    #======step30: check machine's vc policy in db belonging to the deleted user======
    Then ADR policy in DB for deleted device ugdf_user1_machine_1 is Mozy3Month_weekly
    #And I clear user search results
    #======step31: stop masquerading from current partner======
    #And I stop masquerading
    #======step32: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133109 |
    #Then I view partner details by TC.133109
    #And I delete partner account
    #======step33: delete sub partner======
    #When I search partner by:
      #| name                      |
      #| sub_partner_133109_layer1 |
    #Then I view partner details by sub_partner_133109_layer1
    #And I delete partner account


  @TC.133222 @TC.133223 @TC.133224 @TC.133225 @TC.133226 @TC.133227 @TC.133228 @TC.133229 @TC.133230 @TC.133231 @TC.133232 @TC.133233 @TC.133234 @bus @data_retention @bus2.27 @qa12
  Scenario: 133222 update policy at layer 2 sub-partner level to grandpa's partner level
  #======Create Partner======
    When I add a new MozyPro partner:
      | company name      | period |  base plan | server plan | net terms |
      | TC.133222_partner | 1      |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======Create Role and Plan======
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======Create Sub-Partner Level 1======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133222_level1 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 80              |
    But I stop masquerading
    #======Create Role and Plan for Sub-Partner Level 1======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_133222_level1 |
    Then I view partner details by sub_partner_133222_level1
    And I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name        | Type          | Parent  |
      | subrole2    | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role  | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole2   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======Create Sub-Partner Level 2======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133222_level2_partner1 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 10              |
    When I search partner by sub_partner_133222_level2_partner1
    And I view partner details by sub_partner_133222_level2_partner1
    And I get the partner_id
    Then I act as newly created partner
    #======Create 1 user with 2 machines under Sub-Partner Level 2======
    Given I get the partners name sub_partner_133222_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133222_level2_user1 | (default user group) | Desktop      | 1             | 2       | Yes          |
    Then I stop masquerading from subpartner
    Then I stop masquerading
    #======Setup ADR Policy for Parent Partner======
    When I act as partner by:
      | name              |
      | TC.133222_partner |
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Month (daily)
    #======Delete 1 machine under Sub-Partner level 2======
    Then I stop masquerading
    When I act as partner by:
      | name                               |
      | sub_partner_133222_level2_partner1 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133222_level2_user1
    Then I view machine 133222_level2_user1_machine_2 details from user details section
    Then I delete device by name: 133222_level2_user1_machine_2
    And I close User Details section
    #======Setup ADR Policy for Sub-Partner level 2======
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 2 Months (weekly)
    And I wait for 300 seconds
    #======Checkpoints for existing machine======
    Then I search machine by:
      | machine_name                  |
      | 133222_level2_user1_machine_1 |
    And I view machine details for 133222_level2_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Checkpoints for deleted machine======
    And ADR policy in DB for deleted device 133222_level2_user1_machine_2 is Mozy1Month_daily
    #======Checkpoints for new machine======
    Then I use keyless activation to activate devices newly
      | machine_name                  | user_name                   | machine_type |
      | 133222_level2_user1_machine_3 | <%=@new_users.first.email%> | Desktop      |
    Then I search machine by:
      | machine_name                  |
      | 133222_level2_user1_machine_3 |
    And I view machine details for 133222_level2_user1_machine_3
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Delete the new machine and check its vc_policy_name======
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133222_level2_user1
    Then I view machine 133222_level2_user1_machine_3 details from user details section
    Then I delete device by name: 133222_level2_user1_machine_3
    And ADR policy in DB for deleted device 133222_level2_user1_machine_3 is Mozy2Month_weekly
    #======Create a machine to be replaced within the same sub-partner, then replace machines======
    Then I stop masquerading
    And I act as partner by:
      | name                               |
      | sub_partner_133222_level2_partner1 |
    Given I get the partners name sub_partner_133222_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133222_level2_user2 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133222_level2_user1_machine_1
    And I click on the replace machine link
    And I select 133222_level2_user2_machine_1 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    Then I search machine by:
      | machine_name                  |
      | 133222_level2_user1_machine_1 |
    And I view machine details for 133222_level2_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Create a machine to be replaced in the parent partner, then replace machines======
    Then I stop masquerading
    And I act as partner by:
      | name                      |
      | sub_partner_133222_level1 |
    Given I get the partners name sub_partner_133222_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting sub_partner_133222_level1 Users on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133222_level1_user1 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133222_level1_user1_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Create a machine to be replaced in another sub-partner, then replace machines======
    When I add a new sub partner:
      | Company Name                       |
      | sub_partner_133222_level2_partner2 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 10              |
    When I search partner by sub_partner_133222_level2_partner2
    And I view partner details by sub_partner_133222_level2_partner2
    And I get the partner_id
    Then I act as newly created partner
    Given I get the partners name sub_partner_133222_level2_partner2 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133222_level2_user3 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133222_level2_user3_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Delete the partners======
    #And I stop masquerading from subpartner
    #Then I stop masquerading
    #And I search and delete partner account by TC.133222_partner
    #And I search and delete partner account by sub_partner_133222_level1

  @TC.133200 @TC.133201 @TC.133202 @TC.133203 @TC.133204 @TC.133205 @TC.133206 @TC.133207 @TC.133208 @bus @data_retention @bus2.27 @qa12
  Scenario: 133200 update policy at layer 2 sub-partner level to grandpa's partner level
  #======Create Partner======
    When I add a new MozyPro partner:
      | company name      | period |  base plan | server plan | net terms |
      | TC.133200_partner | 1      |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======Create Role and Plan======
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======Create Sub-Partner Level 1======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133200_level1 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 80              |
    But I stop masquerading
    #======Create Role and Plan for Sub-Partner Level 1======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                      |
      | sub_partner_133200_level1 |
    Then I view partner details by sub_partner_133200_level1
    And I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name        | Type          | Parent  |
      | subrole2    | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role  | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole2   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======Create Sub-Partner Level 2======
    When I add a new sub partner:
      | Company Name              |
      | sub_partner_133200_level2_partner1 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 10              |
    When I search partner by sub_partner_133200_level2_partner1
    And I view partner details by sub_partner_133200_level2_partner1
    And I get the partner_id
    Then I act as newly created partner
    #======Create 1 user with 2 machines under Sub-Partner Level 2======
    Given I get the partners name sub_partner_133200_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133200_level2_user1 | (default user group) | Desktop      | 1             | 2       | Yes          |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133200_level2_user1
    Then I view machine 133200_level2_user1_machine_2 details from user details section
    Then I delete device by name: 133200_level2_user1_machine_2
    And I close User Details section
    #======Setup ADR Policy for Sub-Partner level 2======
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 14 Days
    And I wait for 300 seconds
    #======Checkpoints for existing machine======
    Then I search machine by:
      | machine_name                  |
      | 133200_level2_user1_machine_1 |
    And I view machine details for 133200_level2_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Week_daily
    #======Checkpoints for deleted machine======
    And ADR policy in DB for deleted device 133200_level2_user1_machine_2 is Mozy6Month_monthly
    #======Checkpoints for new machine======
    Then I use keyless activation to activate devices newly
      | machine_name                  | user_name                   | machine_type |
      | 133200_level2_user1_machine_3 | <%=@new_users.first.email%> | Desktop      |
    Then I search machine by:
      | machine_name                  |
      | 133200_level2_user1_machine_3 |
    And I view machine details for 133200_level2_user1_machine_3
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Week_daily
    #======Delete the new machine and check its vc_policy_name======
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133200_level2_user1
    Then I view machine 133200_level2_user1_machine_3 details from user details section
    Then I delete device by name: 133200_level2_user1_machine_3
    And ADR policy in DB for deleted device 133200_level2_user1_machine_3 is Mozy2Week_daily
    #======Create a machine to be replaced within the same sub-partner, then replace machines======
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I act as partner by:
      | name                               |
      | sub_partner_133200_level2_partner1 |
    Given I get the partners name sub_partner_133200_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133200_level2_user2 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133200_level2_user1_machine_1
    And I click on the replace machine link
    And I select 133200_level2_user2_machine_1 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    Then I search machine by:
      | machine_name                  |
      | 133200_level2_user1_machine_1 |
    And I view machine details for 133200_level2_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Week_daily
    #======Create a machine to be replaced in the parent partner, then replace machines======
    Then I stop masquerading
    And I act as partner by:
      | name                      |
      | sub_partner_133200_level1 |
    Given I get the partners name sub_partner_133200_level2_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting sub_partner_133200_level1 Users on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133200_level1_user1 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133200_level1_user1_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Create a machine to be replaced in another sub-partner, then replace machines======
    When I add a new sub partner:
      | Company Name                       |
      | sub_partner_133200_level2_partner2 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 10              |
    When I search partner by sub_partner_133200_level2_partner2
    And I view partner details by sub_partner_133200_level2_partner2
    And I get the partner_id
    Then I act as newly created partner
    Given I get the partners name sub_partner_133200_level2_partner2 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133200_level2_user3 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133200_level2_user3_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Delete the partners======
    #And I stop masquerading from subpartner
    #Then I stop masquerading
    #And I search and delete partner account by TC.133200_partner
    #And I search and delete partner account by sub_partner_133200_level1


  @TC.133209 @TC.133210 @TC.133211 @TC.133212 @TC.133213 @TC.133214 @TC.133215 @TC.133216 @TC.133217 @TC.133218 @TC.133219 @TC.133220 @TC.133221 @bus @data_retention @bus-2.27
  Scenario: 133209 update policy at layer 2 sub-partner level to grandpa's partner level
    #======Create Partner======
    When I add a new MozyPro partner:
      | company name      | period |  base plan | server plan | net terms |
      | TC.133209_partner | 1      |  100 GB    | yes         | yes       |
    And I change root role to FedID role
    And I get the partner_id
    And I get the admin id from partner details
    #======Create Role and Plan======
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Perisods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly   | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #======Create Sub-Partner Level 1======
    When I add a new sub partner:
      | Company Name                       |
      | sub_partner_133209_level1_partner1 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 80              |
    But I stop masquerading
    #======Create Role and Plan for Sub-Partner Level 1======
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by:
      | name                               |
      | sub_partner_133209_level1_partner1 |
    Then I view partner details by sub_partner_133209_level1_partner1
    And I act as newly created partner
    #======Create 1 user with 2 machines under Sub-Partner Level 2======
    Given I get the partners name sub_partner_133209_level1_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133209_level1_user1 | (default user group) | Desktop      | 1             | 2       | Yes          |
#    Then I stop masquerading from subpartner
    Then I stop masquerading
      #======Setup ADR Policy for Parent Partner======
    When I act as partner by:
      | name              |
      | TC.133209_partner |
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Month (daily)
    #======Delete 1 machine under Sub-Partner level 1======
    Then I stop masquerading
    When I act as partner by:
      | name                               |
      | sub_partner_133209_level1_partner1 |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133209_level1_user1
    Then I view machine 133209_level1_user1_machine_2 details from user details section
    Then I delete device by name: 133209_level1_user1_machine_2
    And I close User Details section
    #======Setup ADR Policy for Sub-Partner level 1======
    And I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 2 Months (weekly)
    And I wait for 300 seconds
    #======Checkpoints for existing machine======
    Then I search machine by:
      | machine_name                  |
      | 133209_level1_user1_machine_1 |
    And I view machine details for 133209_level1_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Checkpoints for deleted machine======
    And ADR policy in DB for deleted device 133209_level1_user1_machine_2 is Mozy1Month_daily
    #======Checkpoints for new machine======
    Then I use keyless activation to activate devices newly
      | machine_name                  | user_name                   | machine_type |
      | 133209_level1_user1_machine_3 | <%=@new_users.first.email%> | Desktop      |
    Then I search machine by:
      | machine_name                  |
      | 133209_level1_user1_machine_3 |
    And I view machine details for 133209_level1_user1_machine_3
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Delete the new machine and check its vc_policy_name======
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by 133209_level1_user1
    Then I view machine 133209_level1_user1_machine_3 details from user details section
    Then I delete device by name: 133209_level1_user1_machine_3
    And ADR policy in DB for deleted device 133209_level1_user1_machine_3 is Mozy2Month_weekly
    #======Create a machine to be replaced within the same sub-partner, then replace machines======
    Then I stop masquerading
    And I act as partner by:
      | name                               |
      | sub_partner_133209_level1_partner1 |
    Given I get the partners name sub_partner_133209_level1_partner1 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133209_level1_user2 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133209_level1_user1_machine_1
    And I click on the replace machine link
    And I select 133209_level1_user2_machine_1 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    Then I search machine by:
      | machine_name                  |
      | 133209_level1_user1_machine_1 |
    And I view machine details for 133209_level1_user1_machine_1
    Then I get machine details info
    And ADR policy in DB for device is Mozy2Month_weekly
    #======Create a machine to be replaced in the parent partner, then replace machines======
    Then I stop masquerading
    And I act as partner by:
      | name              |
      | TC.133209_partner |
    Given I get the partners name TC.133209_partner and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting TC.133209_partner Users on partner filter:
      | name         | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133209_user1 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133209_user1_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Create a machine to be replaced in another sub-partner, then replace machines======
    When I add a new sub partner:
      | Company Name                       |
      | sub_partner_133209_level1_partner2 |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 10              |
    When I search partner by sub_partner_133209_level1_partner2
    And I view partner details by sub_partner_133209_level1_partner2
    And I get the partner_id
    Then I act as newly created partner
    Given I get the partners name sub_partner_133209_level1_partner2 and type MozyPro
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name                | user_group           | storage_type | storage_limit | devices | enable_stash |
      | 133209_level1_user3 | (default user group) | Desktop      | 1             | 1       | Yes          |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for 133209_level1_user3_machine_1
    And I click on the replace machine link
    And Error message for replace machine should be Error: There are no eligible source machines to choose from.
    #======Delete the partners======
    #And I stop masquerading from subpartner
    #Then I stop masquerading
    #And I search and delete partner account by TC.133209_partner
    #And I search and delete partner account by sub_partner_133209_level1_partner1
    #And I search and delete partner account by sub_partner_133209_level1_partner2