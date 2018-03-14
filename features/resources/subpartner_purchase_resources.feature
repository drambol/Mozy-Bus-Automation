Feature: Sub partners can purchase resources

  # Limitations:
  #  Test accounts have been created on QA6 for existing partners cases
  #
  Background:
    Given I log in bus admin console as administrator

  @TC.19864 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression @core_function
  Scenario: 19864 Existing OEM partner with sub partners whose sub partners can purchase resources
    When I act as partner by:
      | email                          | filter |
      | qa1+tc+19867+reserved@mozy.com | OEMs   |
    And I act as partner by:
      | email                          |
      | qa1+tc+19811+admin1@mozy.com   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |

  @TC.19865 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression @core_function
  Scenario: 19865 Existing OEM partner with sub partners whose OEM partner can purchase resources
    When I act as partner by:
      | email                          | filter |
      | qa1+tc+19867+reserved@mozy.com | OEMs   |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | user group         | desktop license | desktop quota | server license | server quota |
      | default user group | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19867 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression @core_function
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
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19869 @bus @subpartner_purchase_resources @regression @core_function
  Scenario: 19869 New MozyPro bundle partner without sub partner can purchase resource
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | yes         |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19870 @bus @subpartner_purchase_resources @regression @core_function
  Scenario: 19870 New Reseller Metallic partner without sub partner can purchase resources
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan | storage add-on |
      | yes         | 2              |
    And the Reseller account plan should be changed
    And MozyPro new plan should be:
      | server plan | storage add-on |
      | yes         | 2              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19873 @bus @subpartner_purchase_resources @regression @core_function
  Scenario: 19873 New Enterprise partner without subpartner can purchase resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyEnterprise account plan to:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    Then the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 100 GB      | 5             |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19953 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression @core_function_remove
  Scenario: 19953 Existing MozyPro bundle partner without sub partner can purchase resource
    When I act as partner by:
      | email                          |
      | qa1+tc+19953+reserved@mozy.com |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I refresh Change Plan section
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 50 GB     | no          |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | no          |

  @TC.19954 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression @core_function
  Scenario: 19954 Existing Reseller Metallic partner without sub partner can purchase resource
    When I act as partner by:
      | email                          |
      | qa1+tc+19954+reserved@mozy.com |
    And I change Reseller account plan to:
      | storage add-on |
      | 10             |
    Then the Reseller account plan should be changed
    And Reseller new plan should be:
      | storage add-on | server plan |
      | 10             | yes         |
    When I refresh Change Plan section
    And I change Reseller account plan to:
      | storage add-on |
      | 5              |
    Then the Reseller account plan should be changed
    And Reseller new plan should be:
      | storage add-on | server plan |
      | 5              | yes         |

  @TC.19871 @need_test_account @not_implemented  @bus @subpartner_purchase_resources @env_dependent @tasks_p3 @regression
  Scenario: 19871 Reseller Metallic partner with subparnter whose subparnter buy resources will raise error message
    When I act as partner by:
      | email                          |
      | qa1+tc+19871+reserved@mozy.com |
    When I act as partner by:
      | email                          |
      | qa1+sub+admin+19871@mozy.com   |
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | generic quota |
      | 0             |
    Then the storage error message of purchase resource section should be: Please specify a quantity of resources to purchase.
    # Suppose to check resource NOT purchased message, but not implemented yet, refactor later

  @TC.19868 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19868 Existing Reseller itemized partner without subpartners can purchase resources
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized Reseller partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 10              | 250          | 10               | 250           |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type              |
      | @company_name | Reseller Itemized |
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Change Plan section from bus admin console page
    And I increase Itemized account plan by:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then the Itemized account plan should be changed
    And Current itemized resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  # need to find another account, this one will meet billing system error
  @TC.19872 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19872 Existing MozyPro itemized partner without subpartners can purchase resources
    When I log in to legacy bus01 as administrator
    And I successfully add an itemized MozyPro partner:
      | period | server licenses | server quota | desktop licenses | desktop quota |
      | 12     | 5               | 50           | 5                | 50            |
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get the partner_id
    And I migrate the partner to aria
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And Partner search results should be:
      | Partner       | Type             |
      | @company_name | MozyPro Itemized |
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Change Plan section from bus admin console page
    And I increase Itemized account plan by:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then the Itemized account plan should be changed
    And Current itemized resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |

  @TC.19370 @need_test_account @bus @subpartner_purchase_resources @env_dependent @regression
  Scenario: 19370 Existing Reseller itemized partner with subpartners whose subpartner can purchase resources
    When I act as partner by:
      | email                           |
      | mozyautotest+ona1s8qlqt@emc.com |
    And I act as partner by:
      | email                             |
      | mozyautotest+kysdtufbkj9x@emc.com |
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 1               | 10            | 1              | 5            |


  @TC.21281 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: 21281 Enterprise sub partner is able to purchase resources
    When I add a new MozyEnterprise partner:
      | company name           | period | users |  server plan | root role  |
      |TC.21281_mozyent_partner| 12     | 15    |  10 GB       | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name                   | Pricing Plan | Admin Name |
      | TC.21281_mozyent_sub_partner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 25            | 10             | 10           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 25            | 10             | 10           |
    When I refresh purchase resource section
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 360           | 200            | 10           |
    Then the storage error message of purchase resource section should be: Insufficient resources available on parent
    #bugs #144887
    And I stop masquerading as sub partner
    When I stop masquerading
    And I search and delete partner account by TC.21281_mozyent_sub_partner
    And I search and delete partner account by TC.21281_mozyent_partner


  @TC.21286 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: 21286 MozyPro Itemized sub partner is able to purchase resources
    When I act as partner by:
      |email|
      |qa1+tc+19872+reserved@mozy.com|
    And I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.21286_sub_partner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license| desktop quota| server license| server quota|
      | 1              | 1            | 1             | 1           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license| desktop quota| server license| server quota|
      | 1              | 1            | 1             | 1           |
    When I refresh purchase resource section
    And I purchase resources:
      | desktop license | desktop quota  | server license| server quota  |
      | 40              | 400            | 40            | 400           |
    Then Resources should be purchased
    And I stop masquerading as sub partner
    When I stop masquerading
    And I search and delete partner account by TC.21286_sub_partner

  @TC.21285 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: 21285 Metallic Reseller Enterprise sub partner is able to purchase resources
    When I add a new Reseller partner:
      | company name              | period | reseller type | reseller quota |
      | TC.21285_reseller_partner | 12     | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I stop masquerading
    When I act as partner by:
      | name     |
      |TC.21285_reseller_partner|
    When I add a new sub partner:
      | Company Name                  |
      | TC.21285_reseller_sub_partner |
    And New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | generic quota   |
      | 50              |
    Then Resources should be purchased
    When I refresh purchase resource section
    And I purchase resources:
      | generic quota   |
      | 100             |
    Then the storage error message of purchase resource section should be: There are not enough available resources. Please contact your System Administrator.
    And I stop masquerading as sub partner
    When I stop masquerading
    And I search and delete partner account by TC.21285_reseller_sub_partner
    And I search and delete partner account by TC.21285_reseller_partner

  @TC.334 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: 334 Purchase resources ensure that displayed value is correct
    When I add a new OEM partner:
      | Company Name       | Root role         | Security | Company Type     |
      | TC.334_oem_partner | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by TC.334_oem_partner
    And I view partner details by TC.334_oem_partner
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    When I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 200             | 200           | 200            | 200          |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 200             | 200           | 200            | 200          |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server key volume|Server key discount|Server Price per gigabyte | Server Min gigabytes | Server quota volume|Server quota discount|Desktop Price per key | Desktop Min keys | Desktop key volume|Desktop key discount|Desktop Price per gigabyte | Desktop Min gigabytes |Desktop quota volume|Desktop quota discount| Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 6.95                 | 1               |        100       | 50                |1.75                      | 1                    |    100             |       50            |3.95                  | 1                |   100             |       50           |0.5                        | 1                     |     100            |    50                |               1             | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.334_oem_subpartner  | subplan      | subadmin1  |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new user group for an itemized partner:
      | name | server_assigned_quota | desktop_assigned_quota |
      | test | 2                     | 2                      |
    Then Itemized partner user group test should be created
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |user group|
      | 120             | 120           | 110            | 110          |test      |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 120             | 120           | 110            | 110          |
    # should check discount, There is a bug here, Current Resources: Server Keys: xx @ $xx each
    # Desktop Keys: xx @ $xx each;Server Storage: xx GB @ $xx / GB; Desktop Storage: xx GB @ $xx / GB

  @TC.132196 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: Mozy-132196:Pooled business subpartner purchase resources from Pooled root partner
    When I add a new OEM partner:
      | company name       | Root role      | Company Type     |
      | TC.132196_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I get the subpartner_id
    Then I migrate the partner to pooled storage
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 99              | 99            | 99             | 99           |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |pooled|
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |yes   |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.132196_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.132196_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.132196_partner


  @TC.132192 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: Mozy-132192:Pooled OEM partner with Pooled business subpartner purchase resources from mozyoem
    When I add a new OEM partner:
      | company name       | Root role      | Company Type     |
      | TC.132192_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |1                           |1                       |1                                 |1                            |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.132192_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I stop masquerading as sub partner
    And I stop masquerading as sub partner
    When I act as partner by:
      |name             |
      |TC.132192_partner|
    Then I migrate the partner to pooled storage
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    Then Resources should be purchased
    And Current purchased resources should increase:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 10           |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.132192_sub_partner
    And I search and delete partner account by TC.132192_partner


  @TC.133999 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: Mozy-133999:Pooled business subpartner purchase more resource than parent pooled OEM partner
    When I add a new OEM partner:
      | company name       | Root role      | Company Type     |
      | TC.133999_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I get the subpartner_id
    Then I migrate the partner to pooled storage
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |pooled|
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |yes   |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.133999_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 100             | 100           | 100            | 100          |
    Then the pay error message of purchase resource section should be: Insufficient resources available on parent
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.133999_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.133999_partner

  @TC.133375 @bus @subpartner_purchase_resources @tasks_p3 @regression
  Scenario: Mozy-133375:MozyOEM partner with subpartner whose subpartner buy resource will raise error message
    When I add a new OEM partner:
      | company name       | Root role      | Company Type     |
      | TC.133375_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |1                           |1                       |1                                 |1                            |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.133375_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 0               | 0             | 0              | 0            |
    Then the storage error message of purchase resource section should be: Please specify a quantity of resources to purchase.
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.133375_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.133375_partner
