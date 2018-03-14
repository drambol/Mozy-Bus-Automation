Feature: User Details Section_ID etc

  Background:
    Given I log in bus admin console as administrator

  @TC.2784 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-2784:Change the user group of a user
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.2784_UG | Shared               | 1               |
    Then Itemized user group should be created
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.2784_User1 | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I reassign the user to user group TC.2784_UG
    Then the user's user group should be TC.2784_UG
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.819 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-819:Change the user group that a user is assigned to
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.819_UG1 | Shared               | 1               |
    Then Itemized user group should be created
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.819_UG2 | Shared               | 2               |
    Then Itemized user group should be created
    And I add new user(s):
      | name         | user_group | storage_type | storage_limit | devices |
      | TC.819_User1 | TC.819_UG1 | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I reassign the user to user group TC.819_UG2
    Then the user's user group should be TC.819_UG2
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20736 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-20736:Move a user from one partner to another
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 2 TB        | 40            |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.20736_sub_partner1 |
    Then New partner should be created
    When I add a new sub partner:
      | Company Name          |
      | TC.20736_sub_partner2 |
    Then New partner should be created
    When I act as newly created subpartner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 100           | 10             | 100          |
    Then Resources should be purchased
    And I add new user(s):
      | user_group           | name              | storage_type | storage_limit | devices |
      | (default user group) | TC.20736_sub_user | Desktop      | 1             | 2       |
    Then I stop masquerading as sub partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I reassign the user to partner TC.20736_sub_partner2
    Then the user's partner should be TC.20736_sub_partner2
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20737 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-20737:Attempt to move a user to the parnter that they already are in
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 2 TB        | 40            |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.20737_sub_partner1 |
    Then New partner should be created
    When I add a new sub partner:
      | Company Name          |
      | TC.20737_sub_partner2 |
    Then New partner should be created
    When I act as newly created subpartner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 100           | 10             | 100          |
    Then Resources should be purchased
    And I add new user(s):
      | user_group           | name              | storage_type | storage_limit | devices |
      | (default user group) | TC.20737_sub_user | Desktop      | 1             | 2       |
    Then I stop masquerading as sub partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I reassign the user to partner TC.20737_sub_partner1
    Then the user's partner should be TC.20737_sub_partner1
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.20738 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-20738:Validate valid partner show up in the parnter list when you search
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 12     | 10    | 2 TB        | 40            |
    Then New partner should be created
    When I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.20738_sub_partner1 |
    Then New partner should be created
    When I add a new sub partner:
      | Company Name          |
      | TC.20738_sub_partner2 |
    Then New partner should be created
    When I act as newly created subpartner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 100           | 10             | 100          |
    Then Resources should be purchased
    And I add new user(s):
      | user_group           | name              | storage_type | storage_limit | devices |
      | (default user group) | TC.20738_sub_user | Desktop      | 1             | 2       |
    Then I stop masquerading as sub partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then Partner count shows up with TC.20738_sub_partner should be 2
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.818 @bus @tasks_p3 @change_user_group
  Scenario: Mozy-818:Change a name on a users account
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.818_UG1 | Shared               | 1               |
    Then Itemized user group should be created
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.818_UG2 | Shared               | 2               |
    Then Itemized user group should be created
    And I add new user(s):
      | name         | user_group | storage_type | storage_limit | devices |
      | TC.818_User1 | TC.818_UG1 | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And edit user details:
      | name         |
      | TC.818_User2 |
    Then the user's user name should be TC.818_User2 (change)
    And I stop masquerading
    And I search and delete partner account by newly created partner company name