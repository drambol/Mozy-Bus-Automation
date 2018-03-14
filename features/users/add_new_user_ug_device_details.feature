Feature: Add new user, user group device details

  As an admin,
  when I provision a user,
  I can see how many devices are available to assign to a user after I select the User Group
  so that I can make a decision if I need to purchase more or not.

  Success Criteria:
  I can see how many desktop devices are available
  I can see how many server devices are available
  If MP direct and no UGs available (only 1 UG), the available devices are automatically shown

  Background:
    Given I log in bus admin console as administrator

  @TC.19932 @bus @2.5 @user_centric_storage @add_new_user @devices @regression @core_function
  Scenario: 19932 Devices Add New User (Single UG) Bundled
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 50 GB     | yes         | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19978 @bus @2.5 @user_centric_storage @add_new_user @devices @regression @core_function
  Scenario: 19978 Devices Add New User (Mult UG) Bundled
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 50 GB     | yes         | yes       |
    Then New partner should be created
    When I change root role to Bundle Pro Partner Root
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19934 @bus @2.5 @user_centric_storage @add_new_user @devices @metallic @regression @core_function
  Scenario: 19934 Devices Add New User (Single UG) Metallic Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 10             | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 10 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19944 @bus @2.5 @user_centric_storage @add_new_user @devices @metallic @regression @core_function
    Scenario: Mozy-19944:Devices Add New User (Mult UG) Metallic Reseller
      Given I log in bus admin console as administrator
      When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan |
        | 1      | Silver        | 15             | yes         |
      Then New partner should be created
      When I enable stash for the partner
      And I act as newly created partner account
      And I add a new Bundled user group:
        | name       | storage_type |
        | Shared UG  | Shared       |
      Then Shared UG user group should be created
      When I add a new Bundled user group:
        | name       | storage_type | limited_quota |
        | Limited UG | Limited      | 1             |
      Then Limited UG user group should be created
      When I add a new Bundled user group:
        | name        | storage_type | assigned_quota |
        | Assigned UG | Assigned     | 2              |
      Then Assigned UG user group should be created
      And I navigate to Add New User section from bus admin console page
      And I choose Shared UG from Choose a Group
      Then User group storage details table should be:
        | Storage(GB) | 13 |
      And I choose Assigned UG from Choose a Group
      Then User group storage details table should be:
        | Storage(GB) | 2 |
      And I choose Limited UG from Choose a Group
      Then User group storage details table should be:
        | Storage(GB) | 1 |
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.19935 @bus @env_dependent @regression @core_function
    Scenario: Mozy-19935:Devices Add New User (Single UG) Reseller Itemized
      When I act as partner by:
        | email                                 |
        | redacted-303@notarealdomain.mozy.com  |
      And I navigate to Add New User section from bus admin console page
      Then I note the desktop and server amounts in Add New User module for user group (default user group)

  @TC.19937 @bus @2.5 @user_centric_storage @add_new_user @devices @enterprise @regression @core_function
  Scenario: 19937 Devices Add New User (Single UG) Enterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 250  |
      | Server Storage (GB)  | 100  |
      | Desktop Devices      | 10   |
      | Server Devices       | 200  |
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 250 GB      |
    Then the MozyEnterprise account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 375  |
      | Server Storage (GB)  | 250  |
      | Desktop Devices      | 15   |
      | Server Devices       | 200  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19938 @bus @2.5 @user_centric_storage @add_new_user @devices @IE @bundled @emea @regression @core_function
  Scenario: 19938 Devices Add New User (Single UG) Bundled Ireland
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under    | net terms |
      | 1      | 50 GB     | yes         | Ireland | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    Then User group storage details table should be:
      | Storage(GB) | 50 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19939 @bus @2.5 @user_centric_storage @add_new_user @devices @UK @emea @enterprise @regression @core_function
  Scenario: 19939 Change Plan after Add New User (Single UG) Enterprise UK
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | net terms |
      | 12     | 10    | 100 GB      | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 250  |
      | Server Storage (GB)  | 100  |
      | Desktop Devices      | 10   |
      | Server Devices       | 200  |
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 15    | 250 GB      |
    Then the MozyEnterprise account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Desktop Storage (GB) | 375  |
      | Server Storage (GB)  | 250  |
      | Desktop Devices      | 15   |
      | Server Devices       | 200  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.19962 @bus @2.5 @user_centric_storage @add_new_user @devices @emea @FR @metallic @regression @core_function
  Scenario: 19962 Change Plan after Add New User (Multiple UG) French Reseller
    Given I log in bus admin console as administrator
    When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | country | create under   | cc number        |
        | 1      | Silver        | 100            | yes         | France  | MozyPro France | 4485393141463880 |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 100 |
    When I change Reseller account plan to:
      | storage add-on |
      | 10             |
    And the Reseller account plan should be changed
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 300  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
