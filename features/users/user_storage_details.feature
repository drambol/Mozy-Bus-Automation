Feature: User Resources

  As an admin,
  I can drill down to the user and see what storage he is using as well as his storage allocation
  so that I can quickly understand if I need to make a storage adjustment.

  @TC.19640 @bus @user_storage_details @bundled @desktop @regression @core_function
  Scenario: Mozy-19640:Access Partner as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | storage_type | devices |
      | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
      | @user_email | @user_name   | 0 	      | Shared  | None  	   | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 50 GB Available | Desktop: 0 Used / 1 Available Edit  |
    And I log out bus admin console
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.19646 @bus @user_storage_details @metallic_resellers @desktop @regression @core_function
Scenario: Mozy-19646:Access Partner as Bus Admin
  Given I log in bus admin console as administrator
  When I add a new Reseller partner:
    | period | reseller type | reseller quota |
    | 1      | Silver        | 10             |
  Then New partner should be created
  When I act as newly created partner account
  And I add new user(s):
    | user_group           | storage_type | devices |
    | (default user group) | Desktop      | 1       |
  Then 1 new user should be created
  When I search user by:
    | keywords   |
    | @user_name |
  Then User search results should be:
    | External ID | User        | Name       | User Group           | Machines | Storage | Storage Used | Created  | Backed Up |
    |             | @user_email | @user_name | (default user group) | 0        | Shared  | None         | today    | never     |
  When I view user details by newly created user email
  Then user details should be:
    | ID:        | External ID: | Name:                           |
    | @xxxxxxxxx | (change)     | <%=@users.first.name%> (change) |
  And user resources details rows should be:
    | Storage                  | Devices                             |
    | 0 Used / 10 GB Available | Desktop: 0 Used / 1 Available Edit  |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

  @TC.19839 @bus @user_storage_details @itemized @reseller @desktop @env_dependent @regression @core_function_remove
  Scenario: Mozy-19839:Access Reseller Itemized Partner as Partner Admin
  #    Given I navigate to bus admin console login page
  #    When I log in to legacy bus01 as administrator
  #    And I successfully add an itemized Reseller partner:
  #      | period | desktop licenses | desktop quota |
  #      | 12     | 2                | 2             |
  #    And I log in bus admin console as administrator
  #    And I search partner by:
  #      | name          | filter |
  #      | @company_name | None   |
  #    And I view partner details by newly created partner company name
  #    And I get the partner_id
  #    And I migrate the partner to aria
  #    And I migrate the partner to pooled storage
  #    And I act as newly created partner
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                    |
      | qa1+sam_evans@decho.com  |
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |   user type |
      | @user_name |  Itemized Reseller 750GB BS (Migrate)DONOT_delete_TC19839 Users|
    Then User search results should be:
      | User        | Name         | User Group           | Machines  | Storage          | Storage Used  | Created  | Backed Up |
      | @user_email | @user_name   | (default user group) | 0         | Desktop: Shared  | Desktop: None | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                          | Devices                            |
      | Desktop: 0 Used / 2 GB Available | Desktop: 0 Used / 1 Available Edit |
    When I delete user

  @TC.19841 @bus @user_storage_details @mozypro @itemized @desktop @env_dependent @regression @core_function_remove
  Scenario: Mozy-19841: Access an MozyPro Itemized Partner's User's details as Bus Admin
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized MozyPro partner:
#      | period | desktop licenses | desktop quota |
#      | 12     | 2                | 2             |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I migrate the partner to pooled storage
#    And I act as newly created partner
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                           |
      | qa1+itmadm0106141255@decho.com  |
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | External ID | User        | Name         | User Group           | Machines | Storage         | Storage Used  | Created  | Backed Up |
      |             | @user_email | @user_name   | (default user group) | 0  	   | Desktop: Shared | Desktop: None | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                            | Devices                            |
      | Desktop: 0 Used / 100 GB Available | Desktop: 0 Used / 1 Available Edit |
    When I delete user

  @TC.19844 @bus @user_storage_details @enterprise @server @regression
  Scenario: Mozy-19844: Access an Enterprise Partner's User's details as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 2     | 10 GB       |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage         | Storage Used   | Created  | Backed Up |
      | @user_email | @user_name   | 0 	    | Server: Shared  | Server: None   | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                          | Devices                            |
      | Server: 0 Used / 10 GB Available | Server: 0 Used / 1 Available Edit  |
    And I log out bus admin console
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.19850 @bus @user_storage_details @emea @IE @bundled @server @regression
  Scenario: Mozy-19850: Access an Irish Partner's User's details as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under    | cc number        |
      | 1      | 50 GB     | yes         | Ireland | MozyPro Ireland | 4319402211111113 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | storage_type | devices |
      | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines | Storage  | Storage Used | Created  | Backed Up |
      | @user_email | @user_name   | 0 	    | Shared   | None         | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                  | Devices                            |
      | 0 Used / 50 GB Available | Server: 0 Used / 1 Available Edit  |
    And I log out bus admin console
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.19853 @bus @user_storage_details @emea @UK @enterprise @stash @regression
  Scenario: Mozy-19853: Access an United Kingdom Partner's User's details as Partner Admin
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users | country        | cc number        |
      | 12     | 2     | United Kingdom | 4916783606275713 |
    Then New partner should be created
    And I enable stash for the partner
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | user_group           | storage_type | devices | enable_stash |
      | (default user group) | Desktop      | 1       | yes          |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | User        | Name         | Machines   | Storage         | Storage Used     | Created  | Backed Up |
      | @user_email | @user_name   | 0 	      | Desktop: Shared | Desktop: None    | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                           | Devices                            |
      | Desktop: 0 Used / 50 GB Available | Desktop: 0 Used / 1 Available Edit |
    And I log out bus admin console
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.19856 @bus @user_storage_details @emea @FR @metallic_reseller @server @regression
    Scenario: Mozy-19856:Access French Reseller's User's details as Bus Admin
      Given I log in bus admin console as administrator
      When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan |country | create under   | cc number        |
        | 1      | Silver        | 10             | yes         | France | MozyPro France | 4485393141463880 |
      Then New partner should be created
      And I enable stash for the partner
      When I act as newly created partner account
      And I add new user(s):
        | user_group           | storage_type | devices |
        | (default user group) | Server       | 1       |
      Then 1 new user should be created
      When I search user by:
        | keywords   |
        | @user_name |
      Then User search results should be:
        | User        | Name         | Machines | Storage | Storage Used | Created  | Backed Up |
        | @user_email | @user_name   | 0 	      | Shared  | None  	   | today    | never     |
      When I view user details by newly created user email
      Then user details should be:
        | ID:        | External ID: | Name:                           |
        | @xxxxxxxxx | (change)     | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                  | Devices                           |
      | 0 Used / 10 GB Available | Server: 0 Used / 1 Available Edit |
      When I stop masquerading
      Then I search and delete partner account by newly created partner company name

  @TC.19859 @bus @user_storage_details @emea @DE @mozypro @itemized @server @env_dependent @regression @core_function_remove
Scenario: Mozy-19859:Access German Partner's User's details as Bus Admin
#  When I log in to legacy bus01 as administrator
#  And I successfully add an itemized MozyPro partner:
#    | period | server licenses | server quota |
#    | 12     | 2               | 2            |
#  And I log in bus admin console as administrator
#  And I search partner by:
#    | name          | filter |
#    | @company_name | None   |
#  And I view partner details by newly created partner company name
#  And I get the partner_id
#  And I migrate the partner to aria
#  And I migrate the partner to pooled storage
#  And I act as newly created partner
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                           |
      | qa1+itmadm0106141255@decho.com  |
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    Then User search results should be:
      | External ID | User        | Name         | User Group           | Machines | Storage         | Storage Used  | Created  | Backed Up |
      |             | @user_email | @user_name   | (default user group) | 0  	   | Desktop: Shared | Desktop: None | today    | never     |
    When I view user details by newly created user email
    Then user details should be:
      | Name:                           |
      | <%=@users.first.name%> (change) |
    And user resources details rows should be:
      | Storage                            | Devices                            |
      | Desktop: 0 Used / 100 GB Available | Desktop: 0 Used / 1 Available Edit |
    When I delete user

  @TC.19862 @bus @tasks_p3 @user_storage_details
  Scenario: Mozy-19862:[Bundled] Verify Used Column Updates After Client Backup
    Given I log in bus admin console as administrator
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.19862_UG | Shared       |
    Then TC.19862_UG user group should be created
    And I add new user(s):
      | name          | user_group  | storage_type | storage_limit | devices |
      | TC.19862.User | TC.19862_UG | Desktop      | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_19862 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 2  |
    Then tds returns successful upload
    When I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit | Last Update    |
      | Machine1_19862 | 2 GB / 8 GB    | Set                  | < a minute ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
