Feature: Hipaa user Login

  Background:
    Given I log in bus admin console as administrator

  @TC.120660 @bus @log_in_screen @need_test_account @env_dependent @regression @core_function @subdomain
  Scenario: 120660 Hipaa user log into BUS with lower/mixed case username
    When I navigate to Hipaa subdomain user login page
    Then I log into Hipaa subdomain with lowercase username Hipaa user and Hipaa password
    And I log out user
    Then I log into Hipaa subdomain with mixed case username Hipaa user and Hipaa password
    And I log out user

  @TC.120661 @bus @log_in_screen @need_test_account @env_dependents @regression @core_function @subdomain
  Scenario: 120661 Hipaa user log into BUS with upper/mixed case username
    When I navigate to Hipaa subdomain user login page
    Then I log into Hipaa subdomain with uppercase username Hipaa user and Hipaa password
    And I log out user
    Then I log into Hipaa subdomain with mixed case username Hipaa user and Hipaa password
    And I log out user

  @TC.120074 @bus @user_login @tasks_p1
  Scenario: 120074:[Negative]Hipaa user can not log in bus & client with error or empty password
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with Hipaa password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.120074.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.120074.User
    And I update the user password to reset password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_120074 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                                  |
      | <%=@new_clients.first.machine_id%> | 30 | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then tds returns successful upload
    Then I Log in as the user
    Then I navigate to new window
    And I access freyja from bus admin
    And I select options menu
    Then I click Change password in freyja
    And I change password from default password to reset password in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password       |
      | <%=@new_users[0].email%> | error password |
    Then Login page error message should be Incorrect email or password.
    Then I log in bus pid console with:
      | username                 | password |
      | <%=@new_users[0].email%> |          |
    Then Login page error message should be Incorrect email or password.
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123689 @bus @user_login @tasks_p1 @smoke
  Scenario: 123689:As existing not activated Masquerade Hipaa admin update user password and log in as user
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | security |
      | 12     | Silver        | 100            | HIPAA    |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles         | User Group          |
      | ATC123689 | Reseller Root |(default user group) |
    Then I act as latest created admin
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123689.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123689.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123689 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123852 @bus @user_login @tasks_p1 @ldap_sequence
  Scenario: 123852:Hipaa user does not have permission to set password when partner authentication changed
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |security | net terms |
      | 12     | 18    | 100 GB      | FedID role |HIPAA    |yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123852.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123852.User
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
    And I view user details by TC.123852.User
    Then I will not see the Change User Password link
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123853 @bus @user_login @tasks_p1 @ldap_sequence
  Scenario: 123853:Hipaa user need to set password when partner authentication changed from FedId to Mozy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |security | net terms |
      | 12     | 18    | 100 GB      | FedID role |HIPAA    |yes       |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123853.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123853.User
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
    And I view user details by TC.123853.User
    Then I will not see the Change User Password link
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123853.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123414  @bus @user_login @tasks_p1
  Scenario: 123414:MozyPro user login bus and freyja after activating and change password
    When I add a new MozyPro partner:
      | period | base plan  | security | net terms |
      | 12     | 100 GB     |  HIPAA   |    yes    |
    And New partner should be created
    Then I change root role to FedID role
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123414.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123414.User
    And I click Send activation email again
    Then I wait for 30 seconds
    Then the user has activated the account with Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123414 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                     |
      | <%=@new_clients.first.machine_id%> | 30 |<%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%> |
    Then I change password from Hipaa password to reset password in user login bus page
    Then Change password should be successfully
    And I access freyja from bus admin
    And I select options menu
    Then I click Change password in freyja
    And I change password from reset password to test1234! in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password  |
      | <%=@new_users[0].email%> | test1234! |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123521  @bus @user_login @tasks_p1
  Scenario: 123521:New created Hipaa user can log in bus & freyja after changing password in freyja
    When I add a new MozyPro partner:
      | period | base plan  | security | net terms |
      | 12     | 100 GB     |  HIPAA   |    yes    |
    And New partner should be created
    Then I change root role to FedID role
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123521.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123521.User
    Then I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123521 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                       |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password'] %> |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                       |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password'] %> |
    And I access freyja from bus admin
    Then I select options menu
    Then I click Change password in freyja
    And I change password from Hipaa password to reset password in freyja
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                 |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %>|
    And I access freyja from bus admin
    Then I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123507 @bus @user_login @tasks_p1
  Scenario: 123507:MozyPro user login bus or freyja after changing password in bus
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | HIPAA    |
    And New partner should be created
    Then I change root role to FedID role
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123507.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123507.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123507 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                       |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password'] %> |
    Then tds returns successful upload
    Then I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123415 @bus @user_login @tasks_p1
  Scenario: 123415:MozyEnterprise user login bus and freyja after changing password
    When I add a new MozyEnterprise partner:
      | period | users | server plan | security |
      | 12     | 10    | 250 GB      | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123415.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123415.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123415 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                      |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    Then I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120066 @bus @user_login @tasks_p1
  Scenario: 120066:New Hipaa user can log in bus & client after activation
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.120066.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.120066.User
    Then I click Send activation email again
    Then I wait for 30 seconds
    Then the user has activated the account with Hipaa password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123691 @bus @user_login @tasks_p1
  Scenario: 123691:New created activated Hipaa admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | security |
      | 12     | Silver        | 100            | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I activate new partner admin with Hipaa password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123691.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123691.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123691 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password |
      | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password'] %> |
    Then tds returns successful upload
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner adminHipaa password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123693 @bus @user_login @tasks_p1
  Scenario: 123693:New created not activated sub-admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123693.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123693.User
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123693 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB | password                       |
      | <%=@new_clients.first.machine_id%> | 30 |  <%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles         | User Group          |
      | ATC123693 | Reseller Root |(default user group) |
    Then I act as latest created admin
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123693.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123509 @bus @user_login @tasks_p1
  Scenario: Mozy-123509:New created Hipaa user forget password and reset password on bus
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 100 GB    | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with Hipaa password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123509.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123509.User
    And I update the user password to Hipaa password
    Then I navigate to user login page with partner ID
    And I click forget your password link
    And I input email @new_users[0].email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                      |
      | MozyPro password recovery | <%=@new_users[0].email%>|
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    #And I will see reset password massage Your password has been changed.
    And I will see reset password massage Your password has been changed. Please be sure to start MozyPro Configuration on each computer on the account in order to enter the new password.
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
