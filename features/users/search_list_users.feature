Feature: Search and list user

  Background:
    Given I log in bus admin console as administrator

  @TC.683 @need_test_account @bus @regression_test @users @search @env_dependent
  Scenario: 683 Search user
    And I act as partner by:
      | email                                    |
      | qa1+users+features+test+account@mozy.com |
    When I search user by:
      | keywords                  |
      | qa1+tc+683+user@decho.com |
    Then User search results should be:
      | User                      | Name        |
      | qa1+tc+683+user@decho.com | TC.683 User |

  #
  # Pooled Storage - Search/ List User view changes
  # Redmine: 98385
  # Base case, rest to follow in subsequent commit/submission
  # All partners are created w/ storage pooling feature turned on
  #   using a call to "contact" section in-lieu of refreshing section not functioning properly
  #   in refactor-to come, will change "And I navigate to Contact section from bus admin console page"
  #   to "And I refresh Add New User section"
  #
  @TC.21012 @bus @2.5 @pooled_storage @regression @core_function
  Scenario: 21012 Pooled Storage - User List View change - removal of assigned/used quota from Storage column
    And I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21012-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21012-2 | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    And User search results should be:
      | Name        | Sync     | Storage        |
      | TC.21012-1  | Enabled  | 10 GB (Limited)|
      | TC.21012-2  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  # adding cases for pro, reseller, enterprise user list view changes
  #   all references to contact section will be changed once refresh section is running properly
  #   this is also only partners through busclient04/2.5 instance - itemized need to still be done
  #
  @TC.21014 @bus @2.5 @pooled_storage @regression @core_function
  Scenario: 21014 Pooled Storage - Pro SMB - User List View - removal of assigned/used quota
    And I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-1 | Desktop      | 15            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21014-2 | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.21014-3 | Desktop      | 20            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-4 | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-5 | Server       | 25            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.21014-6 | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | Sync      | Storage        |
      | TC.21014-1  | Disabled  | 15 GB (Limited)|
      | TC.21014-2  | Enabled   | Shared         |
      | TC.21014-3  | Enabled   | 20 GB (Limited)|
      | TC.21014-4  | Disabled  | Shared         |
      | TC.21014-5  | Disabled  | 25 GB (Limited)|
      | TC.21014-6  | Disabled  | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21016 @bus @2.5 @pooled_storage @metallic @regression @core_function
  Scenario: 21016 Pool Storage - Reseller Metal - User List View change - removal of assigned/used quota
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 500            | yes         | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21016-1 | (default user group) | Desktop      | 15            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21016-2 | (default user group) | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-3 | (default user group) | Desktop      | 35            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-4 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-5 | (default user group) | Server       | 25            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    When I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21016-6 | (default user group) | Server       |               | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Sync     | Storage        |
      | TC.21016-1  | (default user group)  | Enabled  | 15 GB (Limited)|
      | TC.21016-2  | (default user group)  | Enabled  | Shared         |
      | TC.21016-3  | (default user group)  | Disabled | 35 GB (Limited)|
      | TC.21016-4  | (default user group)  | Disabled | Shared         |
      | TC.21016-5  | (default user group)  | Disabled | 25 GB (Limited)|
      | TC.21016-6  | (default user group)  | Disabled | Shared         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21015 @bus @2.5 @pooled_storage @enterprise @regression @core_function
  Scenario: 21015 - Pool Storage - Enterprise - User List View change - removal of assigned/used quota
    And I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21015-1 | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-2 | (default user group) | Desktop      |               | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.21015-3 | (default user group) | Desktop      |               | 2       | yes          |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-4 | (default user group) | Desktop      | 18            | 2       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-5 | (default user group) | Server       |               | 1       |
    Then 1 new user should be created
    And I refresh Add New User section
    And I add new user(s):
      | name       | user_group           | storage_type | storage_limit | devices |
      | TC.21015-6 | (default user group) | Server       | 22            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | Name        | User Group            | Sync     | Storage                 |
      | TC.21015-1  | (default user group)  | Enabled  | Desktop: 10 GB (Limited) |
      | TC.21015-2  | (default user group)  | Disabled | Desktop: Shared          |
      | TC.21015-3  | (default user group)  | Enabled  | Desktop: Shared          |
      | TC.21015-4  | (default user group)  | Disabled | Desktop: 18 GB (Limited) |
      | TC.21015-5  | (default user group)  | Disabled | Server: Shared           |
      | TC.21015-6  | (default user group)  | Disabled | Server: 22 GB (Limited)  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  # creation itemized (pro) partner to pooled storage w/ user
  #   & adding machine, quota to accts will be in future commits
  #   all as setup steps for verification of migration of itemized partners to pooled storage
  @TC.21013 @itemized @bus @2.5 @pooled_storage @env_dependent @regression @core_function
  Scenario: 21013 Pooled Storage - Pro Itemized - User List View - removal of assigned/used quota
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized MozyPro partner:
#      | period | server licenses | server quota | desktop licenses | desktop quota |
#      | 12     | 5               | 50           | 5                | 50            |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And Partner search results should be:
#      | Partner       | Type             |
#      | @company_name | MozyPro Itemized |
#    And I view partner details by newly created partner company name
#    And I act as newly created partner
#    And I add new itemized user(s):
#      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
#      | TC210131 | 1              | 10           | 1               | 10            |
#    And new itemized user should be created
#    And I navigate to Search / List Users section from bus admin console page
#    And I sort user search results by Name
#    And Itemized user search results should be:
#      | Name     | Machines | Storage | Storage Used |
#      | TC210131 | 0        | 0       | None         |
#    And I stop masquerading
#    And I migrate the partner to pooled storage
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I act as newly created partner
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                                 |
      | redacted-608@notarealdomain.mozy.com  |
    When I search user by:
      | keywords                                |
      | redacted-284778@notarealdomain.mozy.com |
    And Itemized user search results should be:
      | Name     | Machines | Storage                         | Storage Used                |
      | TC210131 | 0        | Desktop: Shared\nServer: Shared | Desktop: None\nServer: None |

  # creation itemized (reseller) partner to pooled storage w/ user
  #   & adding machine, quota to accts will be in future commits
  #   all as setup steps for verification of migration of itemized partners to pooled storage
  @TC.21017 @itemized @bus @2.5 @pooled_storage @env_dependent @regression @core_function_remove
  Scenario: 21017 Pooled Storage - Reseller Itemized - User List View - removal of assigned/used quota
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized Reseller partner:
#      | period | server licenses | server quota | desktop licenses | desktop quota |
#      | 12     | 10              | 250          | 10               | 250           |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And Partner search results should be:
#      | Partner       | Type              |
#      | @company_name | Reseller Itemized |
#    And I view partner details by newly created partner company name
#    And I act as newly created partner
#    And I add new itemized user(s):
#      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
#      | TC210171 | 1              | 10           | 1               | 10            |
#    And new itemized user should be created
#    And I navigate to Search / List Users section from bus admin console page
#    And I sort user search results by Name
#    And Itemized user search results should be:
#      | Name     | Machines | Storage | Storage Used |
#      | TC210171 | 0        | 0       | None         |
#    And I stop masquerading
#    And I migrate the partner to pooled storage
    When I log in bus admin console as administrator
    When I act as partner by:
      | email                                 |
      | redacted-303@notarealdomain.mozy.com  |
    When I search user by:
      | keywords                                |
      | redacted-899929@notarealdomain.mozy.com |
    And Itemized user search results should be:
      | Name     | Machines | Storage                         | Storage Used                |
      | TC210171 | 0        | Desktop: Shared\nServer: Shared | Desktop: None\nServer: None |

    #
    # user list view updates - via partner created through phoenix
    #   This is also the banner case for integration of pooled storage with phoenix
    #   Redmine: 98385
    #
    @TC.21317 @bus @phoenix @2.5 @pooled_storage @regression @core_function
    Scenario: 21317 - Pooled Storage - Pro SMB - Phoenix Integration - User List View - removal of assigned/used quota
      When I am at dom selection point:
      And I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 1      | 100 GB    | United States | yes         |
      And the partner is successfully added.
      And I log in bus admin console as administrator
      And I search partner by:
        | name          | filter |
        | @company_name | None   |
      And I view partner details by newly created partner company name
      And I enable stash for the partner
      And I act as newly created partner
      And I add new user(s):
        | name       | storage_type | storage_limit | devices | enable_stash |
        | TC.21012-1 | Desktop      | 10            | 1       | yes          |
      Then 1 new user should be created
      And I refresh Add New User section
      When I add new user(s):
        | name       | storage_type | storage_limit | devices |
        | TC.21012-2 | Desktop      |               | 2       |
      Then 1 new user should be created
      When I navigate to Search / List Users section from bus admin console page
      And I sort user search results by Name
      Then User search results should be:
        | Name        | Sync     | Storage        |
        | TC.21012-1  | Enabled  | 10 GB (Limited)|
        | TC.21012-2  | Disabled | Shared         |
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

  @TC.809 @bus @tasks_p2
  Scenario: Mozy-809:Export a list of users to Excel
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices | enable_stash |
      | user1 | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I export the users csv
    Then The exported users csv file should be like
      | Column A     | Column B                     | Column C | Column D             | Column E | Column F | Column G                 | Column H      | Column I | Column J |
      | External ID  | User                         | Name     | User Group           | Sync     | Machines | Storage                  | Storage Used  | Created  | Backed Up |
      |              | <%=@new_users.first.email%>  | user1    | (default user group) | Enabled  | 0        | Desktop: 10 GB (Limited) | Desktop: None | @today    | never     |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.808 @bus @tasks_p2
  Scenario: Mozy-808:Do a search for a valid user
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name  | user_group           | storage_type | storage_limit | devices | enable_stash |
      | user1 | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | External ID  | User                         | Name     | User Group           | Sync     | Machines | Storage                  | Storage Used  | Created  | Backed Up |
      |              | <%=@new_users.first.email%>  | user1    | (default user group) | Enabled  | 0        | Desktop: 10 GB (Limited) | Desktop: None | today    | never     |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.815 @bus @tasks_p2
  Scenario: Mozy-815:Do a search for all users that have backed up within the last 24 hours
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name | user_group           | storage_type | storage_limit | devices |
      | User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name  | user_name                   | machine_type |
      | Machine1      | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    When I update <%=@new_clients.first.machine_id%> last backup time to 30 minutes ago
    When I navigate to Search / List Users section from bus admin console page
    Then I search user by:
      | filter                    |
      | Backed up within 24 hours |
    Then User search results should be:
      | External ID | User                        | Name | User Group           | Sync     | Machines | Storage                   | Storage Used   | Created | Backed Up      |
      |             | <%=@new_users.first.email%> | User | (default user group) | Disabled | 1        | Desktop: 100 GB (Limited) | Desktop: 30 GB | today   | 30 minutes ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21940 @bus @tasks_p2
  Scenario:  Mozy-21940:Filter within 1 week include whin 24 hours in search list users view
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name | user_group           | storage_type | storage_limit | devices |
      | User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name  | user_name                   | machine_type |
      | Machine1      | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    When I update <%=@new_clients.first.machine_id%> last backup time to 30 minutes ago
    When I navigate to Search / List Users section from bus admin console page
    Then I search user by:
      | filter                    |
      | Backed up within 24 hours |
    Then User search results should be:
      | External ID | User                        | Name | User Group           | Sync     | Machines | Storage                   | Storage Used   | Created | Backed Up      |
      |             | <%=@new_users.first.email%> | User | (default user group) | Disabled | 1        | Desktop: 100 GB (Limited) | Desktop: 30 GB | today   | 30 minutes ago |
    When I update <%=@new_clients.first.machine_id%> last backup time to 30 minutes ago
    Then I search user by:
      | filter                  |
      | Backed up within 1 week |
    Then User search results should be:
      | External ID | User                        | Name | User Group           | Sync     | Machines | Storage                   | Storage Used   | Created | Backed Up      |
      |             | <%=@new_users.first.email%> | User | (default user group) | Disabled | 1        | Desktop: 100 GB (Limited) | Desktop: 30 GB | today   | 30 minutes ago |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2761 @bus @tasks_p2
  Scenario: Mozy-2761:Do a search for all EMC Gift users
    Then I search user by:
      | filter   |
      | EMC Gift   |
    And The users table should not be empty
