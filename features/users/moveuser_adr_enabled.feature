Feature: Move a user between two groups or partners when ADR is enabled/disabled
  As a Mozy Administrator. I move user between two groups or two partner when ADR is enabled/disbaled.

  Background:
    Given I log in bus admin console as administrator

  @TC.133734 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133734 - Move user to a new user group, 1Y -> Null but which inherits the default policy from the partner.
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC.133734    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step2: act as partner=====
    Then I act as newly created partner account
    #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step4: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step5: reassign user to another user group having no adr policy======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I wait for 300 seconds
    And the user's user group should be ug1
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy6Month_monthly
    #And Show error: The user has enabled Data Retention policy. Can not move to the user group without policy.
    And I stop masquerading
    #======step6: delete partner======
    #When I search partner by:
      #| name      |
      #| TC.133734 |
    #Then I view partner details by TC.133734
    #And I delete partner account


  @TC.133735 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133735 - Move user to empty policy group cross partners. 1Y -> Null but which inherits the default policy from the partner.
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133735    |   1    |  500 GB    | yes         | yes       |
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
    #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133735_PA |
    Then New partner should be created
    #======step6: act as partner======
    Then I act as newly created partner account
    #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step8: set adr policy at subpartner layer1 PA (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step9: stop masquerading, go back to the partner partner======
    But I stop masquerading from subpartner
    #======step10: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133735_PB |
    Then New partner should be created
    #======step11: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133735_PB
    #And Show error: The user has enabled Data Retention policy. Can not move to the user group without policy.
    And I wait for 300 seconds
    And the user's user group should be sub_partner_133735_PB
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy6Month_monthly
    #======step12: stop masquerading, return to the root level======
    And I stop masquerading
    #======step13: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133735_PB |
    #Then I view partner details by sub_partner_133735_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133735_PA |
    #Then I view partner details by sub_partner_133735_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133735 |
    #Then I view partner details by TC_133735
    #And I delete partner account

  @TC.133736 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133736 - Move user to empty policy group cross partners. 1Y -> Null but has default policy at ug's partner
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133736    |   1    |  500 GB    | yes         | yes       |
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
    #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133736_PA |
    Then New partner should be created
    #======step6: act as partner======
    Then I act as newly created partner account
    #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 1 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step8: set adr policy at subpartner layer1 PA (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step9: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step10: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133736_PB |
    Then New partner should be created
    #======step11: act as partner======
    Then I act as newly created partner account
    #======step12: set adr policy at subpartner layer1 PB (partner)======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step13: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step14: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133736_PB
    And I wait for 300 seconds
    #And the user's user group should be sub_partner_133736_PB
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Year_quarterly
    #And Show error: The user has enabled Data Retention policy. Can not move to the user group without policy.
    #======step12: stop masquerading, return to the root level======
    And I stop masquerading
    #======step13: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133736_PB |
    #Then I view partner details by sub_partner_133736_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133736_PA |
    #Then I view partner details by sub_partner_133736_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133736 |
    #Then I view partner details by TC_133736
    #And I delete partner account

  @TC.133737 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133737 - Move user to same policy group under the same partner. 1Y -> 1Y
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133737    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
    #======step2: act as partner=====
    Then I act as newly created partner account
    #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
    #======step4: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step5: set policy for ug1======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug1 adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step6: reassign user to ug1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    #======step7: verify user's user group after reassigning======
    And I wait for 300 seconds
    And the user's user group should be ug1
    #======step8: query user machine's vc policy in demeter======
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
    #======step9: stop masquerading, return to root level======
    And I stop masquerading
    #======step10: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133737 |
    #Then I view partner details by TC_133737
    #And I delete partner account

  @TC.133738 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133738 - Move user to same policy group but crossing partners. 1Y -> 1Y
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133738    |   1    |  500 GB    | yes         | yes       |
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
    #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133738_PA |
    Then New partner should be created
    #======step6: act as partner======
    Then I act as newly created partner account
    #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
    #======step8: set adr policy at subpartner layer1 PA (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step9: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step10: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133738_PB |
    Then New partner should be created
    #======step11: act as partner======
    Then I act as newly created partner account
    #======step12: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
     #======step13: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
     #======step14: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133738_PB
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
    Then ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy1Year_monthly
    #======step15: stop masquerading, return to the root level======
    And I stop masquerading
    #======step16: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133738_PB |
    #Then I view partner details by sub_partner_133738_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133738_PA |
    #Then I view partner details by sub_partner_133738_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133738 |
    #Then I view partner details by TC_133738
    #And I delete partner account

  @TC.133739 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133739 - Move empty policy group user to A policy group under same partner. Null -> 1Y
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133739    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
  #======step2: act as partner=====
    Then I act as newly created partner account
  #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
    #======step4: set policy for ug1======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug1 adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step5: reassign user to ug1======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    #======step6: check moved user's machine vc policy in demeter db======
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Year_quarterly
    Then ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy3Year_quarterly
    #======step8: stop masquerading, return to root layer======
    And I stop masquerading
    #======step9: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133739 |
    #Then I view partner details by TC_133739
    #And I delete partner account

  @TC.133740 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133740 - Move empty policy group user to A policy group 1 cross partners. Null -> 1Y
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133740    |   1    |  500 GB    | yes         | yes       |
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
    #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133740_PA |
    Then New partner should be created
    #======step6: act as partner======
    Then I act as newly created partner account
    #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
    #======step8: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step9: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133740_PB |
    Then New partner should be created
    #======step10: act as partner======
    Then I act as newly created partner account
    #======step11: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 7 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 120 seconds
    #======step12: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step13: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133740_PB
    And I wait for 420 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy7Year_quarterly
    Then ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy7Year_quarterly
    #======step14: stop masquerading, return to the root level======
    And I stop masquerading
    #======step15: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133740_PB |
    #Then I view partner details by sub_partner_133740_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133740_PA |
    #Then I view partner details by sub_partner_133740_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133740 |
    #Then I view partner details by TC_133740
    #And I delete partner account

  @TC.133741 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133741 - Move empty but inheritting default policy group user to A policy group under the same partner, case1
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133741    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
  #======step2: act as partner=====
    Then I act as newly created partner account
  #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
  #======step4: set default adr policy======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step5: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step6: reassign user to another user group having no adr policy======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
  #======step7: stop masquerading, return to root layer======
    And I stop masquerading
  #======step8: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133741 |
    #Then I view partner details by TC_133741
    #And I delete partner account

  @TC.133742 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133742 - Move empty but inheritting default policy group user to A policy group under the same partner, case2
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133742    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
  #======step2: act as partner=====
    Then I act as newly created partner account
  #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
  #======step4: set default adr policy======
    Given I navigate to Data Retention section from bus admin console page
    When I click partner adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step5: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step6: reassign user to another user group having no adr policy======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
  #======step7: stop masquerading, return to root layer======
    And I stop masquerading
  #======step8: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133742 |
    #Then I view partner details by TC_133742
    #And I delete partner account

  @TC.133743 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133743 - Move A policy group user to B policy group under same parnter. 1Y -> 3Y
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133743    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
  #======step2: act as partner=====
    Then I act as newly created partner account
  #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  1      | Yes          |
  #======step4: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step5: set policy for ug1======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug1 adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step6: reassign user to another user group having no adr policy======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Year_quarterly
  #======step7: stop masquerading, return to root layer======
    And I stop masquerading
  #======step8: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133743 |
    #Then I view partner details by TC_133743
    #And I delete partner account

  @TC.133744 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133744 - Move A policy group user to B policy group 1 cross partners. 1M -> 1Y
    #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133744    |   1    |  500 GB    | yes         | yes       |
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
    #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133744_PA |
    Then New partner should be created
    #======step6: act as partner======
    Then I act as newly created partner account
    #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
    #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
    #======step8: set policy at PA's (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step9: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step10: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133744_PB |
    Then New partner should be created
    #======step11: act as partner======
    Then I act as newly created partner account
    #======step12: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
    #======step13: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
    #======step14: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133744_PB
    And I wait for 300 seconds
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
    Then ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy1Year_monthly
    #======step15: stop masquerading, return to the root level======
    And I stop masquerading
    #======step16: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133744_PB |
    #Then I view partner details by sub_partner_133744_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133744_PA |
    #Then I view partner details by sub_partner_133744_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133744 |
    #Then I view partner details by TC_133744
    #And I delete partner account

  @TC.133760 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133760 - Move multiple A policy group users to C policy group, all in same partner. 1M -> 1Y
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133760    |   1    |  50 GB     | yes         | yes       |
    And I get the partner_id
    And I change root role to FedID role
    And I get the admin id from partner details
  #======step2: act as partner=====
    Then I act as newly created partner account
  #======step3: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash | server_support |
      | ug1  | Shared       | qa                      | yes          | yes            |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
      | ugdf_user2 | (default user group) |  Desktop     |  1            |  2      | Yes          |
  #======step4: set policy for (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step5: set policy for ug1======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug1 adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step6: reassign users to another user group having no adr policy======
    When I navigate to Search / List Users section from bus admin console page
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I close user details section
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    Then I reassign the user to user group ug1
    And I close user details section
  #======step7: check the vc policy name in demeter db======
    Given I wait for 300 seconds
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy1Year_monthly
    And ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy1Year_monthly
    And I close user details section
    When I search user by:
      | keywords   |
      | ugdf_user2 |
    And I view user details by ugdf_user2
    When I get the user id
    Then ADR policy in DB for existing device ugdf_user2_machine_1 is Mozy1Year_monthly
    And ADR policy in DB for existing device ugdf_user2_machine_2 is Mozy1Year_monthly
    And I close user details section
  #======step8: stop masquerading, return to root layer======
    And I stop masquerading
  #======step9: delete partner======
    #When I search partner by:
      #| name      |
      #| TC_133760 |
    #Then I view partner details by TC_133760
    #And I delete partner account

  @TC.133761 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133761 - Move multiple different policy group users to C policy group, no two of which are in same partner. 1M/2M -> 1Y
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133761    |   1    |  500 GB    | yes         | yes       |
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
  #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133761_PA |
    Then New partner should be created
  #======step6: act as partner======
    Then I act as newly created partner account
  #======step6: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
  #======step7: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | pa_ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
  #======step8: set policy at PA's (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Month (daily)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step9: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
  #======step10: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133761_PB |
    Then New partner should be created
  #======step11: act as partner======
    Then I act as newly created partner account
  #======step12: purchase resource for sub partner layer1 PB======
    And I purchase resources:
      | generic quota |
      | 50            |
  #======step13: create multiple users with backup deivces======
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | pb_ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
  #======step14: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 2 Months (weekly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step15: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
  #======step16: create the 3rd sub partner laywer1 PC======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133761_PC |
    Then New partner should be created
  #======step17: act as partner======
    Then I act as newly created partner account
  #======step18: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step19: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
  #======step20: at partner partner level, reassign user from PA to PC======
    When I search user by:
      | keywords   |
      | pa_ugdf_user1 |
    And I view user details by pa_ugdf_user1
    Then I reassign the user to partner sub_partner_133761_PC
    And I wait for 60 seconds
    And I close User Details section
  #======step21: at partner partner level, reassign user from PB to PC======
    When I search user by:
      | keywords   |
      | pb_ugdf_user1 |
    And I view user details by pb_ugdf_user1
    Then I reassign the user to partner sub_partner_133761_PC
    And I wait for 300 seconds
    And I close User Details section
  #======step22: check vc policy in detmer db======
    When I search user by:
      | keywords   |
      | pa_ugdf_user1 |
    And I view user details by pa_ugdf_user1
    Then I get the user id
    And ADR policy in DB for existing device pa_ugdf_user1_machine_1 is Mozy1Year_monthly
    And ADR policy in DB for existing device pa_ugdf_user1_machine_2 is Mozy1Year_monthly
    And I close User Details section
    When I search user by:
      | keywords   |
      | pb_ugdf_user1 |
    And I view user details by pb_ugdf_user1
    Then I get the user id
    And ADR policy in DB for existing device pb_ugdf_user1_machine_1 is Mozy1Year_monthly
    And ADR policy in DB for existing device pb_ugdf_user1_machine_2 is Mozy1Year_monthly
    And I close User Details section
  #======step23: stop masquerading, return to the root level======
    And I stop masquerading
  #======step24: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133761_PC |
    #Then I view partner details by sub_partner_133761_PC
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133761_PB |
    #Then I view partner details by sub_partner_133761_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133761_PA |
    #Then I view partner details by sub_partner_133761_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133761 |
    #Then I view partner details by TC_133761
    #And I delete partner account


  @TC.133768 @bus @data_retention @user @bus2.29 @P1 @qa12
  Scenario: 133768 - Move a user twice, all groups at "Done" status.
  #======step1: create a MozyPro partner======
    When I add a new MozyPro partner:
      | company name | period |  base plan | server plan | net terms |
      | TC_133768    |   1    |  500 GB    | yes         | yes       |
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
  #======step5: create a new sub partner layer1 PA======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133768_PA |
    Then New partner should be created
  #======step6: act as partner======
    Then I act as newly created partner account
  #======step7: purchase resource for sub partner layer1 PA======
    And I purchase resources:
      | generic quota |
      | 50            |
  #======step8: create multiple users with backup deivces======
    When I add a new Bundled user group:
      | name | storage_type | install_region_override | enable_stash |
      | ug1  | Shared       | qa                      | yes          |
    Then Bundled user group should be created
    When I act as MozyPro and create multiple users with 2 device on each user by selecting nil on partner filter:
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | ugdf_user1 | (default user group) |  Desktop     |  1            |  2      | Yes          |
  #======step9: set policy at PA's (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 1 Year (monthly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step10: set policy at PA's ug1======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group ug1 adr policy
    And I set adr policy to 2 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step11: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
  #======step12: create another sub partner laywer1 PB======
    When I add a new sub partner:
      | Company Name          |
      | sub_partner_133768_PB |
    Then New partner should be created
  #======step13: act as partner======
    Then I act as newly created partner account
  #======step14: purchase resource for sub partner layer1 PB======
    And I purchase resources:
      | generic quota |
      | 50            |
  #======step15: set adr policy at subpartner layer1 PB (partner)'s user group (default user group)======
    Given I navigate to Data Retention section from bus admin console page
    When I click user group (default user group) adr policy
    And I set adr policy to 3 Years (quarterly)
    Then I refresh Data Retention section
    And I close opened data retention section
    And I wait for 60 seconds
  #======step15: stop masquerading, go back to the partner partner======
    And I stop masquerading from subpartner
  #======step16: at partner partner level, reassign user from (default user group) to ug1======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to user group ug1
    And I wait for 180 seconds
    And I close User Details section
  #======step17: at partner partner level, reassign user from PA to PB======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I reassign the user to partner sub_partner_133768_PB
    And I wait for 180 seconds
    And I close User Details section
  #======step18: check vc policy in detmer db======
    When I search user by:
      | keywords   |
      | ugdf_user1 |
    And I view user details by ugdf_user1
    Then I get the user id
    And ADR policy in DB for existing device ugdf_user1_machine_1 is Mozy3Year_quarterly
    And ADR policy in DB for existing device ugdf_user1_machine_2 is Mozy3Year_quarterly
    And I close User Details section
  #======step19: stop masquerading, return to the root level======
    And I stop masquerading
  #======step20: delete all partners=======
    #When I search partner by:
      #| name                  |
      #| sub_partner_133768_PB |
    #Then I view partner details by sub_partner_133768_PB
    #And I delete partner account
    #When I search partner by:
      #| name                  |
      #| sub_partner_133768_PA |
    #Then I view partner details by sub_partner_133768_PA
    #And I delete partner account
    #When I search partner by:
      #| name      |
      #| TC_133768 |
    #Then I view partner details by TC_133768
    #And I delete partner account