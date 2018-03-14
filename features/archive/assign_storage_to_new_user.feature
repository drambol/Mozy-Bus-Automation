Feature: Assign storage to a new user

  As an admin, I can assign storage for a new user 
  so that he is guaranteed a specific amount of storage.

  Background:

##add new user behavor changed, so the cases were no longer valid
#  @TC.19654 @bus @assign_storage_to_a_new_user @reseller @itemized
#  Scenario: 19654 - Create new user under Itemized Reseller as BUS Admin
#    Given I log in bus admin console as administrator
#    When I act as partner by:
#      | name                               |
#      | qa1+testResellerItem90211@mozy.com |
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 2                    | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created
#
#  @TC.19642 @bus @assign_storage_to_a_new_user @reseller @itemized
#  Scenario: 19642 - Create new user under Itemized Reseller as Partner Admin
#    Given I navigate to bus admin console login page
#    And I log in bus admin console with user name qa1+testResellerItem90211@mozy.com and password test1234
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | server licenses | user group           | user type          |
#      | 2                    | 1               | (default user group) | Server Backup Only |
#    Then New user should be created
#
#  @TC.19805 @bus @assign_storage_to_a_new_user @mozypro @itemized
#  Scenario: 19805 - Create new user under Itemized MozyPro as BUS Admin
#    Given I log in bus admin console as administrator
#    When I act as partner by:
#      | name                              |
#      | qa1+testProItemized90211@mozy.com |
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 2                    | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created
#
#  @TC.19806 @bus @assign_storage_to_a_new_user @mozypro @itemized
#  Scenario: 19806 - Create new user under Itemized MozyPro as Partner Admin
#    Given I navigate to bus admin console login page
#    And I log in bus admin console with user name qa1+testProItemized90211@mozy.com and password test1234
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | desktop licenses | user group           | user type          |
#      | 2                    | 1                | (default user group) | Desktop with Stash |
#    Then New user should be created
#
#  @TC.19656 @bus @assign_storage_to_a_new_user @bundled
#  Scenario: 19656 - Create new user under MozyPro as BUS Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyPro partner:
#      | period | base plan |
#      | 1      | 50 GB     |
#    Then New partner should be created
#    When I act as newly created partner account
#    When I add a new user to a MozyPro partner:
#      | desired_user_storage | device_count | user type           |
#      | 10                   | 1            | Desktop Backup Only |
#    Then New user should be created
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#
#  @TC.19651 @bus @assign_storage_to_a_new_user @bundled
#  Scenario: 19651 - Create new user as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyPro partner:
#      | period | base plan | server plan |
#      | 1      | 50 GB     | yes         |
#    Then New partner should be created
#    And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyPro partner:
#      | desired_user_storage | device_count | user type          |
#      | 10                   | 1            | Server Backup Only |
#    Then New user should be created
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner company name
#
#  @TC.19814 @bus @assign_storage_to_a_new_user @bundled @metallic @reseller
#  Scenario: 19814 - Create new user under Metallic Reseller as BUS Admin
#    Given I log in bus admin console as administrator
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota |
#      | 1      | Silver        | 100            |
#    Then New partner should be created
#    When I act as newly created partner account
#    When I add a new user to a Reseller partner:
#      | desired_user_storage | device_count | user group           | user type           |
#      | 10                   | 1            | (default user group) | Desktop Backup Only |
#    Then New user should be created
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#
#  @TC.19815 @bus @assign_storage_to_a_new_user @bundled @metallic @reseller
#  Scenario: 19815 - Create new user as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota | server plan |
#      | 1      | Silver        | 100            | yes         |
#    Then New partner should be created
#    And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a Reseller partner:
#      | desired_user_storage | device_count | user group           | user type          |
#      | 10                   | 1            | (default user group) | Server Backup Only |
#    Then New user should be created
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#    And I search and delete partner account by newly created partner company name
#
#  @TC.19658 @bus @assign_storage_to_a_new_user @enterprise
#  Scenario: 19658 - Create new user under Enterprise partner as BUS Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan |
#      | 12     | 10    | 250 GB      |
#    Then New partner should be created
#    When I act as newly created partner account
#    When I add a new user to a MozyEnterprise partner:
#      | desired_user_storage | desktop licenses | user group           | user type           |
#      | 10                   | 1                | (default user group) | Desktop Backup Only |
#    Then New user should be created
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#
#  @TC.19653 @bus @assign_storage_to_a_new_user @enterprise
#  Scenario: 19653 - Create new user as Partner Admin
#    Given I log in bus admin console as administrator
#    When I add a new MozyEnterprise partner:
#      | period | users | server plan |
#      | 12     | 10    | 250 GB      |
#    Then New partner should be created
#    And I activate new partner admin with default password
#    And I log out bus admin console
#    And I log in bus admin console as new partner admin
#    When I add a new user to a MozyEnterprise partner:
#      | desired_user_storage | server licenses | user group           | user type          |
#      | 10                   | 1               | (default user group) | Server Backup Only |
#    Then New user should be created
#    And I log out bus admin console
#    Then I log in bus admin console as administrator
#	And I search and delete partner account by newly created partner company name
#
#
#  @TC.19808 @bus @assign_storage_to_a_new_user @emea @DE
#  Scenario: 19808 - Create new user under German Itemized Partner as BUS Admin
#    Given I log in bus admin console as administrator
#    When I act as partner by:
#      | name                                    |
#      | qa1+testDEMozyProItemized90211@mozy.com |
#    And I add a new user to a Itemized partner:
#      | desktop licenses | desired_user_storage | user group           | user type           |
#      | 1                | 2                    | (default user group) | Desktop Backup Only |
#    Then New user should be created
#
#  @TC.19809 @bus @assign_storage_to_a_new_user @emea @FR
#  Scenario: 19809 - Create new user under French Itemized Partner as Partner Admin
#    Given I navigate to bus admin console login page
#    And I log in bus admin console with user name qa1+testFRMetallic90211@mozy.com and password test1234
#    And I add a new user to a Itemized partner:
#      | desired_user_storage | device_count | user group           | user type          |
#      | 2                    | 1            | (default user group) | Server Backup Only |
#    Then New user should be created
#
#  @TC.19810  @bus @assign_storage_to_a_new_user @emea @IE
#  Scenario: 19810 - Create new user under Irish MozyPro Bundled Partner
#    Given I log in bus admin console as administrator
#    When I add a new MozyPro partner:
#      | period | base plan | create under    | country |
#      | 1      | 50 GB     | MozyPro Ireland | Ireland |
#    Then New partner should be created
#    When I act as newly created partner account
#    When I add a new user to a MozyPro partner:
#      | desired_user_storage | device_count | user type           |
#      | 2                    | 1            | Desktop Backup Only |
#    Then New user should be created
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name
#
#  @TC.19811 @bus @assign_storage_to_a_new_user @emea @UK
#  Scenario: 19811 - Create new user under UK Enterprise Partner as Partner
#    Given I navigate to bus admin console login page
#    And I log in bus admin console with user name qa1+testUKEnterprise90211@mozy.com and password test1234
#    When I add a new user to a MozyEnterprise partner:
#      | desired_user_storage | server licenses | user group           | user type          |
#      | 2                    | 1               | (default user group) | Server Backup Only |
#    Then New user should be created
