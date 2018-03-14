Feature: Add a new user

  Background:
    Given I log in bus admin console as administrator

  @TC.20934 @bus @active_user @tasks_p2 @ROR_smoke
  Scenario: Mozy-20934:Activation email sent to newly created user
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 12     | 100 GB    | Bundle Pro Partner Root |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | send_email |
      | TC.20934.User  | (default user group) | Desktop      | 10            | 3       | Yes        |
    Then 1 new user should be created
    Then I retrieve email content by keywords:
      | to                       |
      | <%=@new_users[0].email%> |
    Then I check the mozy brand logo in email content is:http://www.mozypro.com/images/emails/mozy_logo.jpg
    Then I check the email content should include:
    """
    Your account administrator has created an account for you on Mozy, the world's leading backup service. To use this new account, just click on the link below and create a password to complete your account profile setup.
    """
    Then the user has activated the account with Hipaa password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password default password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I see Allow Re-Activation link is available
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123502 @bus @active_user @tasks_p2
  Scenario: Mozy-123502:Activation email sent to newly created mozypro user
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    Then I get the partner_id
    And I activate new partner admin with default password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | send_email |
      | TC.123502.User | (default user group) | Desktop      | 100           | 3       | Yes        |
    Then 1 new user should be created
    Then the user has activated the account with Hipaa password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_123502 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      |user_email                   | machine_id                         | GB | password                     |
      | <%=@new_users.first.email%> | <%=@new_clients.first.machine_id%> | 10 |<%=QA_ENV['hipaa_password']%> |
    Then tds returns successful upload
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                      |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password']%> |
    And I access freyja from bus admin
    And I select options menu
    And I logout freyja
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123503 @bus @active_user @tasks_p2
  Scenario: Mozy-123503:Activation email sent to newly created mozyhome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And I log into phoenix with username newly created MozyHome username and password default password
    Then user log in phoenix failed
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    And I access freyja from phoenix
    And I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.123843  @bus @tasks_p2
  Scenario: Mozy-123843:Verify the existing not activated mozyhome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 50 GB     | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the user is successfully added.
    When I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I verify the user
    And I log into phoenix with username newly created MozyHome username and password default password
    And I access freyja from phoenix
    And I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.123841 @bus @user_login @tasks_p2
  Scenario: Mozy-123841:Reactivate existing mozyenterprise user
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role   | net terms |
      | 12     | 18    | 100 GB      | Enterprise  | yes       |
    Then New partner should be created
    Then I get the partner_id
    And I activate new partner admin with default password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123841.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    Then the user has activated the account with default password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then the user log out bus
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password default password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I click allow re-activate
    Then I click Send activation email again
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Incorrect email or password.
    Then I wait for 30 seconds
    Then the user has activated the account with reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123857 @bus @user_login @tasks_p2
  Scenario:Mozy-123857:Reactivate existing hipaa mozyenterprise user
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |security | net terms |
      | 12     | 18    | 100 GB      | Enterprise |HIPAA    |yes       |
    Then New partner should be created
    Then I get the partner_id
    And I activate new partner admin with Hipaa password
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password Hipaa password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.123857.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    Then the user has activated the account with Hipaa password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                       |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password'] %> |
    Then the user log out bus
    Then I navigate to bus admin console login page
    When I log in bus admin console with user name newly created partner admin email and password Hipaa password
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I click allow re-activate
    Then I click Send activation email again
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                       |
      | <%=@new_users[0].email%> | <%=QA_ENV['hipaa_password'] %> |
    Then Login page error message should be Incorrect email or password.
    Then I wait for 30 seconds
    Then the user has activated the account with reset password
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                                  |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_hipaa_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123842 @bus @user_login @tasks_p2
  Scenario: Mozy-123842:Reactivate existing mozyhome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    When I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I click allow re-activate
    And User details changed message should be The machine now needs to be re-activated with MozyHome.
    And I log into phoenix with username newly created MozyHome username and password default password
    And user log in failed, error message is:
    """
     Incorrect email or password.
    """
    # bug 143460
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    And I access freyja from phoenix
    And I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user
