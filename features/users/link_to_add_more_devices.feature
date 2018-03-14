Feature: Link to More Devices

  As an admin (without UG enabled),
  I want a path to purchase more devices (previously known as keys) if I'm running out,
  So that I have a easy way to manage my resource needs.

  Success Criteria:
  - Next to the available desktop and server devices the admin will have a link for "add More"
  - "add more" will redirect the admin to change plan page where they can add more devices to the account

  Background:
    Given I log in bus admin console as administrator

  @TC.19977 @bus @2.5 @user_centric_storage @bundled @1UG @regression @core_function
  Scenario: 19977 Bundled (1UG) Verify Buy More Link in Add New User
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

# No User group for Mozy Pro
#  @TC.19920
#  Scenario: 19920 Bundled (1UG) Verify Add More Link in Add New User(Bundled w\ UGs)
#    When I add a new MozyPro partner:
#        | period | base plan | server plan |
#        | 1      | 50 GB     | yes         |
#    Then New partner should be created
#    When I change root role to Bundle Pro Partner Root
#    When I act as newly created partner account
#    And I navigate to Add New User section from bus admin console page
#    And I choose (default user group) from Choose a Group
#    Then the Add More link should be visible
#    And the Add More link should open the Change Plan module
#    Then I stop masquerading
#    And I search and delete partner account by newly created partner company name

  @TC.19951 @bus @2.5 @user_centric_storage @1UG @metallic_reseller @regression @core_function
  Scenario: 19951 Metallic Reseller (1UG) Verify Buy More Link in Add New User
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 10             |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

# Test partner does not migrate to pooled storage partnerß
#  @TC.19949
#  Scenario: 19949 MozyPro Itemized (2UG), Verify Add More Link in Add New User
#    When I act as partner by:
#        | name                                         |
#        | qa1+TestMozyProItemizedMonthly92066@mozy.com |
#    And I navigate to Add New User section from bus admin console page
#    And I choose User Group 1 from Choose a Group
#    Then the Add More link should be visible
#    And the Add More link should open the Manage Resources module

  @TC.19948 @bus @2.5 @user_centric_storage @1UG @enterprise @regression @core_function
Scenario: 19948 Enterprise (2UG) Verify Buy More Link in Add New User
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I act as newly created partner
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_devices | server_storage_type |
      | TC.19948 UG | Shared               | 1               | None                |
    Then TC.19948 UG user group should be created
    And I navigate to Add New User section from bus admin console page
    And I choose TC.19948 UG from Choose a Group
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19947 @bus @2.5 @user_centric_storage @1UG @emea @IE @bundled @regression @core_function
Scenario: 19947 EMEA (1UG) Ireland Bundled Verify Buy More Link in Add New User
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under    | cc number        |
      | 1      | 50 GB     | yes         | Ireland | MozyPro Ireland | 4319402211111113 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19946 @bus @2.5 @user_centric_storage @1UG @emea @UK @enterprise @regression @core_function
Scenario: 19946 EMEA (1UG) UK Enterprise Verify Buy More Link in Add New User
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | cc number        |
      | 12     | 10    | 250 GB      | United Kingdom | 4916783606275713 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19945 @bus @2.5 @user_centric_storage @1UG @emea @FR @metallic_reseller @regression @core_function
Scenario: 19945 EMEA (1UG) France Metallic Reseller Verify Buy More Link in Add New User
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | country | create under   | cc number        |
      | 1      | Gold          | 10             | France  | MozyPro France | 4485393141463880|
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19952 @bus @2.5 @user_centric_storage @1UG @emea @DE @mozypro @itemzied @need_test_account @env_dependent @regression @core_function_remove
  Scenario: Mozy-19952:EMEA(1UG), Germany, MozyPro Itemized, Verify Add More Link in Add New User
    When I act as partner by:
      | email                                |
      | redacted-608@notarealdomain.mozy.com |
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then the Buy More link should be visible
    And the Buy More link should open the Change Plan module
