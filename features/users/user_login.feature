Feature: User Login

  Background:
    Given I log in bus admin console as administrator

  @TC.123409 @bus @user_login @tasks_p1 @smoke @ROR_smoke @qa12
  Scenario: 123409:New created activated admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I get the partner_id
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123409.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123409.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123409 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
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

  @TC.123411 @bus @user_login @tasks_p1
  Scenario: 123411 New created activated sub-admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles         | User Group          |
      | ATC123411 | Reseller Root |(default user group) |
    When I view the admin details of ATC123411
    When I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123411.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123411.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123411 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123411.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
    | username               | password                                  |
    | <%=@users.last.email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123412 @bus @user_login @tasks_p1
  Scenario: 123412 New created not activated sub-admin update user password and log in as user to verify
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123412.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123412.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123412 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles         | User Group          |
      | ATC123412 | Reseller Root |(default user group) |
    Then I act as latest created admin
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.123412.User
    And I update the user password to reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                    | password                                  |
      | <%=@new_users.first.email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120559 @bus @user_login @tasks_p1
  Scenario: 120559:Log in as user and change password
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.120559.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.120559.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_120559 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                    | password                             |
      | <%=@new_users.first.email%> | <%=CONFIGS['global']['test_pwd'] %>  |
    Then I change password from default password to reset password in user login bus page
    Then Change password should be successfully
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120562 @bus @user_login @tasks_p1
  Scenario: 120562:Masquerade as user and change password
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.120562.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.120562.User
    And I update the user password to default password
    Then I Log in as the user
    And I navigate to new window
    Then I change password from default password to reset password in user login bus page
    Then Change password should be successfully
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name