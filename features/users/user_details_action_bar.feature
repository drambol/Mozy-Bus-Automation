Feature: User Details

  Background:
    Given I log in bus admin console as administrator

  @TC.821 @bus @tasks_p2
  Scenario: Mozy-821:Change a user password
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I get the partner_id
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.821.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to 中文!@#$%^&*()abc
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123409 | <%=@new_users.first.email%> | Desktop      |
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password          |
      | <%=@new_users[0].email%> | 中文!@#$%^&*()abc |
    And the user log out bus
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.822 @bus @tasks_p2
  Scenario: Mozy-822:Change a user email address
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.822.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And edit user details:
      | email           |
      | @new_user_email |
    Then edit user email success message to newly created user email should be displayed
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      |User                        | Name        | User Group            | Sync     | Storage         |
      |<%=@new_users.first.email%> | TC.822.User | (default user group)  | Disabled | 100 GB (Limited) |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.823 @bus @tasks_p2
  Scenario: Mozy-823:Log in as User under through an admin account
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.823.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I Log in as the user
    Then the user log out bus
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.12454 @bus @tasks_p2
  Scenario: Mozy-12454:Login Admin doesn't change password of an user successfully
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.12454.User | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.12454.User
    Then I update user password to incorrect password test and get the error message:
    """
    Please enter a password at least 8 characters long
    """
    Then I check the records of model_audits table is 0
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.123477 @bus @tasks_p2
  Scenario: Mozy-123477:Login Admin log in as user and doesn't change user password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | security |
      | 12     | 10    | 250 GB      | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123477.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123415 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    Then I update user password to incorrect password test1234 and get the error message:
    """
    Passwords must contain at least 3 of the following types of characters: numbers, lowercase letters, special characters, capital letters
    """
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                             |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %>  |
    Then Login page error message should be Incorrect email or password.
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%>  |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125697 @bus @tasks_p2 @VMBU @qa12 @env_dependent
  Scenario: Mozy-125697:VMBU user has Restore icon when login as user from BUS
    When I search user by:
      | keywords                 |
      | vmbu_freyja_ent1@emc.com |
    And I view user details by vmbu_freyja_ent1@emc.com
    Then I Log in as the user
    Then I navigate to new window
    Then I check restore icon with hints message Restore VMs under user login bus
    And I access freyja from restore vms from bus admin
    Then I navigate to new window
    And I select options menu
    And I logout freyja
    Then I navigate to old window
    Then I close new window

  @TC.125698 @bus @tasks_p2 @VMBU @qa12 @env_dependent
  Scenario: Mozy-125698:VMBU contrainer has restore icon when list machine details in BUS
    When I search user by:
      | keywords                 |
      | vmbu_freyja_ent1@emc.com |
    And I view user details by vmbu_freyja_ent1@emc.com
    Then I view machine sh-loki4.mozy.lab.emc.com details from user details section
    And I click Restore VMs from machines details section
    Then I navigate to new window
    And I select options menu
    And I logout freyja
    Then I close new window

  @TC.125699 @bus @tasks_p2 @VMBU @qa12 @env_dependent
  Scenario: Mozy-125699:VMBU user has Restore icon after user login from BUS
    When I search partner by VMBU Enterprise_DONOT_EDIT
    Then I get current partner type
    Then I view partner details by VMBU Enterprise_DONOT_EDIT
    And I get the partner_id
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | vmbu_freyja_ent1@emc.com | <%=CONFIGS['global']['test_pwd'] %> |
    Then I check restore icon with hints message Restore VMs under user login bus
    And I access freyja from restore vms from bus admin
    Then I navigate to new window
    And I select options menu
    And I logout freyja
    Then I close new window

  @TC.125700 @bus @tasks_p2 @VMBU @qa12 @env_dependent
  Scenario: Mozy-125700:VMBU user has Restore icon when list user details in BUS
    When I search user by:
      | keywords                 |
      | vmbu_freyja_ent1@emc.com |
    And I view user details by vmbu_freyja_ent1@emc.com
    Then I check restore icon with hints message Restore VMs under user details
    And I access freyja from restore vms from bus admin
    Then I navigate to new window
    And I select options menu
    And I logout freyja
    Then I close new window


  @TC.121960 @bus @tasks_p2 @ldap_sequence
  Scenario: Mozy-121960:Change User Password/Activation link is not available for Pull users
    Given I delete a user dev-121960-test1@test.com in the demeter db
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I input server connection settings
      | Server Host  | Protocol   | SSL Cert | Port   | Base DN  | Bind Username   | Bind Password   |
      | @server_host | @protocol  |          | @port  | @base_dn | @bind_user      | @bind_password  |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule                | group |
      | cn=dev-121960-test* | dev   |
    And I click the sync now button
    And I wait for 240 seconds
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)                    |
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0 Blocked Deprovision |
    And I search user by:
      | keywords   |
      | dev-121960-test1@test.com |
    And I view user details by dev-121960-test1@test.com
    Then I will not see the Change User Password link
    Then I will not see the Send activation email again link
    Then I will not see the awaiting re-activation link
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule                | action |
      | cn=dev-121960-test* | Delete |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)  |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 1 succeeded, 0 failed |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123813 @bus @tasks_p2
  Scenario: Mozy-123813:User doesn't have permission to set password when partner authentication changed from Mozy to FedID
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      | 12     | 18    | 100 GB      | FedID role | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123813.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123813.User
    Then I will see the Change User Password link
    Then I stop masquerading
    Then I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123813.User
    Then I will not see the Change User Password link
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123825 @bus @tasks_p2
  Scenario: Mozy-123825:User need to set password when partner authentication changed from FedId to Mozy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      | 12     | 18    | 100 GB      | FedID role | yes       |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123825.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123825.User
    And I update the user password to reset password
    Then I stop masquerading
    Then I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123825.User
    Then I will not see the Change User Password link
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123825.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

