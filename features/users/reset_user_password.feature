Feature: reset user password

  Background:
    Given I log in bus admin console as administrator

  # forget password email in QA12 can not be received, need to investigate
  @TC.126029 @bus @user_login @tasks_p1
  Scenario: Mozy-126029:Reset Password from oem.partners.com
    When I act as partner by:
      | name                        |
      | test_for_126029_DO_NOT_EDIT |
    And I add new itemized user(s):
      | name     | devices_server | quota_server | devices_desktop | quota_desktop |
      | oem user | 1              | 10           | 1               | 10            |
    And new itemized user should be created
    Then I navigate to user login page with partner ID oem.partners.com
    And I click forget your password link
    And I input email @new_users[0].email in reset password panel to reset password
    Then I wait for 30 seconds
    When I search emails by keywords:
      | subject                | to                       |
      | Mozy password recovery | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please be sure to start Mozy Configuration on each computer on the account in order to enter the new password.
    Then I log in bus admin console with user name @new_users[0].email and password reset password
    And the user log out bus
    When I log in bus admin console as administrator
    And I search user by:
      | keywords    |
      | @user_email |
    Then I view user details by newly created user email
    And I delete user

  @TC.126030 @bus @user_login @tasks_p1
  Scenario: Mozy-126030:Reset Password from partners.mozy.com (Reseller)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    Then I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.126030.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.126030.User
    And I update the user password to default password
    Then I navigate to user login page with partner ID partners.mozy.com
    And I click forget your password link
    And I input email @new_users[0].email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                       |
      | MozyPro password recovery | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please be sure to start MozyPro Configuration on each computer on the account in order to enter the new password.
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.126031 @bus @user_login @tasks_p1 @ROR_smoke
  Scenario: 126031:Reset Password from secure.mozy.com
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    Then I navigate to phoenix login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                            |
      | MozyHome password recovery | <%=@partner.admin_info.email%>|
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please start MozyHome Configuration on each computer on the account in order to enter the new password.
    And I log into phoenix with username newly created MozyHome username and password reset password
    And I access freyja from phoenix
    And I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.126032 @bus @user_login @tasks_p1 @subdomain
  Scenario: 126032:Reset User Password from subdomain.mozypro.com
    Then I act as partner by:
      | name                      |
      | DO NOT CHANGE SUBDOMAIN   |
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.126032.User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I navigate to resetpassword user login page
    And I click forget your password link
    And I input email @new_users[0].email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                       |
      | MozyPro password recovery | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please be sure to start MozyPro Configuration on each computer on the account in order to enter the new password.
    Then I navigate to resetpassword user login page
    Then I log in bus admin console with user name @new_users[0].email and password reset password
    And the user log out bus
    When I log in bus admin console as administrator
    Then I act as partner by:
      | name                      |
      | DO NOT CHANGE SUBDOMAIN   |
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126032.User
    Then I delete user

  @TC.126034 @bus @user_login @tasks_p1
  Scenario: 126034:Reset User Password from www.mozypro.com
    When I add a new MozyPro partner:
      | period | base plan | security | net terms |
      | 12     | 50 GB     | Standard |    yes    |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.126034.User | (default user group) | Desktop      | 10            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.126034.User
    And I update the user password to default password
    Then I navigate to user login page with partner ID
    And I click forget your password link
    And I input email @new_users[0].email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                       |
      | MozyPro password recovery | <%=@new_users[0].email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please be sure to start MozyPro Configuration on each computer on the account in order to enter the new password.
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    And the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


