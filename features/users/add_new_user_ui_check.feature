Feature: Add a new user

  Background:
    Given I log in bus admin console as administrator


  @TC.806 @bus @tasks_p2
  Scenario: Mozy-806:Create a new user
    When I add a new OEM partner:
      | Company Name    | Root role         | Company Type     |
      | test_for_839    | OEM Partner Admin | Service Provider |
    Then New partner should be created
    Then I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 20            | 10             |100           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
      | oem user | 5              | 10           | 5               | 2            |
    And new itemized user should be created
    When I navigate to Search / List Users section from bus admin console page
    And User search results should be:
      | External ID | User                          |Name        | User Group            | Machines     | Storage        | Storage Used | Created | Backed Up |
      |             | <%=@new_users.first.email%>   |oem user    |  (default user group) | 0            | 0              | None         | today   | never     |
    When I search emails by keywords:
      | subject                | to                       |
      | Mozy Activation Key    | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.19656 @bus @tasks_p2
  Scenario: Mozy-19656:Create new user as BUS Admin
    When I add a new MozyPro partner:
      | period | root role               | base plan  |
      | 1      | Bundle Pro Partner Root | 100 GB     |
    And New partner should be created
    And I act as newly created partner
    And I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | test          | 3       | yes          |
    And I add new user(s):
      | name   | email                     | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | test_for_tc.19656@emc.com | (default user group) | Desktop      | 10            | 3       | yes          |
      | User2  | XXX                       | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User2  | (default user group) | Desktop      | 10            | 3       | yes          |
      | User3  | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 2 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | External ID | User                     | Name  | Sync    | Machines | Storage           | Storage Used  | Created  | Backed Up |
      |             | <%=@new_users[1].email%> | User3 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      |             | <%=@new_users[0].email%> | User2 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      |             | test_for_tc.19656@emc.com| User1 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
    And I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 10 GB Available | Desktop: 0 Used / 3 Available Edit  |
    Then I delete user
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19815 @bus @tasks_p2
  Scenario:  Mozy-19815:Create new user as Partner Admin
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I activate new partner admin with Hipaa password
    Then I navigate to bus admin console login page
    And I log in bus admin console as new partner adminHipaa password
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 100 |
    And I check user group help message under add new user section should be:
    """
    If your account does not have user groups, Available Resources displays the resources you can assign to your new users.<br> <br> If your account has user groups, choose the group to display the Available Resources for the group. The users you are creating are added to the selected group. If no group is selected, the available resources list is empty.
    """
    And I check user type help message under add new user section should be:
    """
    Type of user: Desktop is for users who back up desktop computers and if sync is enabled, may synchronize their files to other computers linked to their accounts. Server is for users who are responsible for backing up server devices. It is recommended that you define a dedicated user account for server backups.<br> <br> Storage Limit: You may wish to define a storage limit for users. If you do not, users may use any storage space that is available in the group.<br> <br> Number of devices: Depending on the type of user selected, enter the number of desktops or servers the user can back up.
    """
    And I check enter user help message under add new user section should be:
    """
    Enter the Name and Email Address for each user you want to add. The users entered are added to the group selected in Step 1.
    """
    And I check send email help message under add new user section should be:
    """
    You can send a notification email to your users with instructions on how to download and install the software.
    """
    And I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | test          |3       | yes         |
    And I add new user(s):
      | name   | email                     | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | test_for_tc.19815@emc.com | (default user group) | Desktop      | 10            |3        | yes          |
      | User2  |  XXX                      | (default user group) | Desktop      | 10            |3        | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User2  | (default user group) | Desktop      | 10            | 3       | yes          |
      | User3  | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 2 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | User                     | Name  | Sync    | Machines | Storage           | Storage Used  | Created  | Backed Up |
      | <%=@new_users[1].email%> | User3 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | <%=@new_users[0].email%> | User2 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | test_for_tc.19815@emc.com| User1 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
    And I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 10 GB Available | Desktop: 0 Used / 3 Available Edit  |
    Then I delete user
    And I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name

  @TC.19658 @bus @tasks_p2
  Scenario: Mozy-19658:Create new user as BUS Admin
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    And New partner should be created
    Then I enable stash for the partner
    And I act as newly created partner
    And I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | test          | 3       | yes          |
    And I add new user(s):
      | name   | email                     | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User2  | XXX                       | (default user group) | Desktop      | 10            | 3       | yes          |
    Then The error message beside email should be Invalid Email
    And I add new user(s):
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 1 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | User                     | Name  | Sync    | Machines | Storage                    | Storage Used  | Created  | Backed Up |
      | <%=@new_users[0].email%> | User1 | Enabled |   0      | Desktop: 10 GB (Limited)   | Desktop: None | today    | never     |
    And I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And user resources details rows should be:
      | Storage                           | Devices                             |
      | Desktop: 0 Used / 10 GB Available | Desktop: 0 Used / 3 Available Edit  |
    Then I delete user
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19808 @bus @tasks_p2
  Scenario:  Mozy-19808:Create new user as BUS Admin
    When I add a new Reseller partner:
      | period |  reseller type  | country         | create under     | reseller quota | net terms |
      |   1    |  Silver         | Germany         | MozyPro Germany  | 100            | yes       |
    And New partner should be created
    And I act as newly created partner
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 100 |
    And I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | test          |3       | yes         |
    And I add new user(s):
      | name   | email                     | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | test_for_tc.19808@emc.com | (default user group) | Desktop      | 10            |3        | yes          |
      | User2  |  XXX                      | (default user group) | Desktop      | 10            |3        | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User2  | (default user group) | Desktop      | 10            | 3       | yes          |
      | User3  | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 2 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | User                     | Name  | Sync    | Machines | Storage           | Storage Used  | Created  | Backed Up |
      | <%=@new_users[1].email%> | User3 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | <%=@new_users[0].email%> | User2 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | test_for_tc.19808@emc.com| User1 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
    And I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 10 GB Available | Desktop: 0 Used / 3 Available Edit  |
    Then I delete user
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.19809 @bus @tasks_p2
  Scenario:Mozy-19809:Create new user as Partner Admin
    When I add a new MozyPro partner:
      | period | base plan |   create under    |  country  | net terms |
      | 1      | 100 GB     |  MozyPro France  |  France   | yes       |
    And New partner should be created
    Then I change root role to MozyPro Emea Root
    Then I activate new partner admin with Hipaa password
    Then I navigate to bus admin console login page
    And I log in bus admin console as new partner adminHipaa password
    And I navigate to Add New User section from bus admin console page
    And I choose (default user group) from Choose a Group
    Then User group storage details table should be:
      | Storage(GB) | 100 |
    And I add new user with error message User Storage must be entered in an amount greater than zero. unsuccessfully:
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | (default user group) | Desktop      | test          | 3       | yes         |
    And I add new user(s):
      | name   | email                     | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User1  | test_for_tc.19809@emc.com | (default user group) | Desktop      | 10            |3        | yes          |
      | User2  |  XXX                      | (default user group) | Desktop      | 10            |3        | yes          |
    Then 1 new user should be created
    And I add new user(s):
      | name   | user_group           | storage_type | storage_limit | devices | enable_stash |
      | User2  | (default user group) | Desktop      | 10            | 3       | yes          |
      | User3  | (default user group) | Desktop      | 10            | 3       | yes          |
    Then 2 new user should be created
    Then I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: (default user group)
    Then I open Users tab under user group details
    Then the Users table details under user group details should be:
      | User                     | Name  | Sync    | Machines | Storage           | Storage Used  | Created  | Backed Up |
      | <%=@new_users[1].email%> | User3 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | <%=@new_users[0].email%> | User2 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
      | test_for_tc.19809@emc.com| User1 | Enabled |   0      | 10 GB (Limited)   | None          | today    | never     |
    And I search user by:
      | keywords |
      | User1    |
    And I view user details by User1
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 10 GB Available | Desktop: 0 Used / 3 Available Edit  |
    Then I delete user
    And I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name

  @TC.22103 @bus @tasks_p3
  Scenario: Mozy-22103:Create a new user - Special Characters
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name                       | storage_type | storage_limit | devices | enable_stash |
      | test~!#$%^&*(){}[]:";'`<>? | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by @user_email
    And user resources details rows should be:
      | Storage                  | Devices                             |
      | 0 Used / 10 GB Available | Desktop: 0 Used / 1 Available Edit  |
    Then I delete user
    And I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name