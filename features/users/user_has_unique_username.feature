Feature: User Has Unique Username

  As an admin,
  I want to be told when I create a new user if the name already exists,
  So that I can choose a unique one.

  As an admin,
  when I change a user email address (username) across MH, MP, ME, MEO, MCI want to be told if the name already exists,
  So that I can choose a unique one.

  As a user,
  I want to be told when I edit a user's username if the name already exists,
  So that I can choose a unique one.

  As a user,
  I want to be told when I create an account if the name already exists,
  So that I can choose a unique one.

  Success Criteria:
  - admin username's are able to be used as user username's
  - suspended user's usernames cannot be used in account creation or added to an exhisting user
  - deleted user's usernames can be used in account creation or added to an exhisting user
  - Newly entered emails (usernames) must be unique across MozyHome, MozyPro, MozyEnterprise, MozyEnterpriseOld, and MozyCorp
  - When I update the email address, I see a error if there is a conflict within the partner or Mozy products
  - Don't cause failures when updating other fields (for example, display name) for existing users with non-unique usernames
  - Don't cause failures when updating users in other products (for example, MozyOEM)

  @TC.21366 @bus @phoenix @2.5 @existing_username @mozyhome @email @regression @core_function
  Scenario:  21366:Update User(MH) With Existing Admin Username
    When I get an admin email from the database
    And I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    And the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    And the user is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords       | user type |
      | @mh_user_email | MozyHome  |
    And I view MozyHome user details by @user_name
    And edit user details:
      | email                 |
      | @existing_admin_email |
    And edit user email change confirmation message to existing admin email should be displayed
    And I wait for 20 seconds
    And I retrieve email content by keywords:
      | to                    | subject                    | date  |
      | @existing_admin_email | Email Address Verification | today |
    And I get verify email address from email content
    Then verify email address link should show success message
    When I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords              | user type      |
      | @existing_admin_email | MozyHome Users |
    And I view MozyHome user details by existing admin email
    And I delete user

  @TC.21365 @bus @phoenix @2.5 @existing_username @mozyhome @regression @core_function
  Scenario: Mozy-21365:Update User(MH) With Existing User Username
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    And the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    And the user is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords       | user type |
      | @mh_user_email | MozyHome  |
    And I view MozyHome user details by @user_name
    And edit user details:
      | email          |
      | @mh_user_email |
    Then edit user email error message should be:
    """
    The email address you entered matches your existing email. Please enter a different email address.
    """
    When I get a MP user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    When I get a ME user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
  #    When I get a MEO user username from the database
  #    And edit user details:
  #      | email                |
  #      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    When I get a MC user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I delete user

  @TC.21383 @bus @phoenix  @2.5 @mozyhome @suspened_username @regression @core_function
  Scenario: Mozy-21383:Update User(MH) With Suspended User Username
    When I get a suspended user email from the database
    And I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    And the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    And the user is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords       | user type |
      | @mh_user_email | MozyHome  |
    And I view MozyHome user details by @user_name
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I delete user

  @TC.21384 @bus @phoenix @2.5 @mozyhome @email @regression @core_function
  Scenario: Mozy-21384:Update User(MH) With Deleted User Username
    When I get a deleted user email from the database
    And I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    And the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    And the user is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords       | user type |
      | @mh_user_email | MozyHome  |
    And I view MozyHome user details by newly created MozyHome username
    And edit user details:
      | email                |
      | @existing_user_email |
    And edit user email change confirmation message to existing user email should be displayed
    And I retrieve email content by keywords:
      | to                   | subject                    | date  |
      | @existing_user_email | Email Address Verification | today |
    And I get verify email address from email content
    Then verify email address link should show success message
    When I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords             | user type |
      | @existing_user_email | MozyHome  |
    And I view MozyHome user details by existing user email
    And I delete user

  @TC.21800  @phoenix @2.5 @existing_username @mozyhome @regression @core_function
  Scenario: Mozy-21800:Web Sign Up - Add New User With Existing Admin Username
    When I get an admin email from the database
    And I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | admin email           |
      | 1      | 50 GB     | United States | @existing_admin_email |
    And the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    And the user is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name redacted-4165@notarealdomain.mozy.com and password default password
    And I search user by:
      | keywords       | user type |
      | @mh_user_email | MozyHome  |
    And I view MozyHome user details by newly created MozyHome username
    And I delete user

  @TC.21357 @BUG.99434 @BUG2.102097  @2.5 @mozyhome @existing_username @phoenix @regression @core_function
  Scenario: Mozy-21357:Web Sign Up - Add New User With Existing(Created) User Username(MH)
    When I am at dom selection point:
    And I get a MH user username from the database
    And I sign up a phoenix Home user:
      | period | base plan | country       | admin email          |
      | 1      | 50 GB     | United States | @existing_user_email |
    Then sign up page error message to existing user email should be displayed
    When I am at dom selection point:
    And I get a MP user username from the database
    And I sign up a phoenix Home user:
      | period | base plan | country       | admin email          |
      | 1      | 50 GB     | United States | @existing_user_email |
    Then sign up page error message to existing user email should be displayed
    When I get a ME user username from the database
    And I am at dom selection point:
    And I sign up a phoenix Home user:
      | period | base plan | country       | admin email          |
      | 1      | 50 GB     | United States | @existing_user_email |
    Then sign up page error message to existing user email should be displayed
#    When I am at dom selection point:
    And I get a MEO user username from the database
    And I sign up a phoenix Home user:
      | period | base plan | country       | admin email          |
      | 1      | 50 GB     | United States | @existing_user_email |
    Then sign up page error message to existing user email should be displayed
#    When I get a MC user username from the database
#    And I am at dom selection point:
#    And I sign up a phoenix Home user:
#      | period | base plan | country       | admin email          |
#      | 1      | 50 GB     | United States | @existing_user_email |
#    Then sign up page error message to existing user email should be displayed

  @TC.21809  @2.5 @existing_username @UK @mozyhome @phoenix @regression @core_function
  Scenario: Mozy-21809:Web Sign Up - Add New User With Existing(Created) User Username(MH-UK) under MH tree
    When I get a MH user username from the database
    And I am at dom selection point:
    And I sign up a phoenix Home user:
      | period | base plan | country        | admin email          | cc number        |
      | 1      | 50 GB     | United Kingdom | @existing_user_email | 4916783606275713 |
    Then sign up page error message should be:
    """
     An account with this email address already exists
    """

  @TC.21810  @2.5 @existing_username @IE @mozyhome @phoenix @regression @core_function
  Scenario: Mozy-21810:Web Sign Up - Add New User With Existing(Created) User Username(MH-IE) under MP tree
    When I get a MP user username from the database
    And I am at dom selection point:
    And I sign up a phoenix Home user:
      | period | base plan | country | admin email          | cc number        |
      | 1      | 50 GB     | Ireland | @existing_user_email | 4319402211111113 |
    Then sign up page error message should be:
    """
     An account with this email address already exists
    """

  @TC.21811  @2.5 @existing_username @FR @mozyhome @phoenix @regression @core_function
  Scenario: Mozy-21811:Web Sign Up - Add New User With Existing(Created) User Username(MH-FR) under ME tree
    When I get a ME user username from the database
    And I am at dom selection point:
    And I sign up a phoenix Home user:
      | period | base plan | country | admin email          | cc number        |
      | 1      | 50 GB     | France  | @existing_user_email | 4485393141463880 |
    Then sign up page error message should be:
    """
     Un compte avec cette adresse électronique existe déjà.
    """

  @TC.21812  @2.5 @existing_username @DE @mozyhome @phoenix @regression @core_function
  Scenario: Mozy-21812:Web Sign Up - Add New User With Existing(Created) User Username(MH-DE) under MEO tree
    When I get a MEO user username from the database
    And I am at dom selection point:
    And I sign up a phoenix Home user:
      | period | base plan | country | admin email          | cc number        |
      | 1      | 50 GB     | Germany | @existing_user_email | 4188181111111112 |
    Then sign up page error message should be:
    """
     Ein Konto mit dieser E-Mail-Adresse ist bereits vorhanden.
    """

  @TC.21878 @bus @2.5 @existing_username @mozypro @regression @core_function
  Scenario: Mozy-21878:Add New User(MP) With Existing User Username
    When I log in bus admin console as administrator
    And I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 20             |
    Then New partner should be created
    And I act as newly created partner
    And I get a MH user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a MP user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a ME user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
  #    And I get a MEO user username from the database
  #    And I add new user(s):
  #      | email                | user_group          | storage_type | storage_limit | devices |
  #      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
  #    Then Add new user error message should be:
  #    """
  #    Failed to create 1 user(s)
  #    """
#    And I get a MC user username from the database
#    And I add new user(s):
#      | email                | user_group          | storage_type | storage_limit | devices |
#      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
#    Then Add new user error message should be:
#    """
#    Failed to create 1 user(s)
#    """
    And I get a suspended user email from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a deleted user email from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21877 @bus @2.5 @existing_username @mozypro @regression @core_function
  Scenario: Mozy-21877:Add New User(MP) With Existing Admin Username
    When I log in bus admin console as administrator
    And I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 20             |
    And New partner should be created
    And I act as newly created partner
    And I get an admin email from the database
    And I add new user(s):
      | email                 | user_group           | storage_type | storage_limit | devices |
      | @existing_admin_email | (default user group) | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21872 @bus @2.5 @existing_username @mozypro @regression @core_function
  Scenario: Mozy-21872:Update User(MP) With Existing User Username
    When I log in bus admin console as administrator
    And I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I get a MH user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a MP user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a ME user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
  #    And I get a MEO user username from the database
  #      And edit user details:
  #        | email                 |
  #        | @existing_admin_email |
  #      Then edit user email error message to existing user email should be displayed
    And I get a MC user username from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a suspended user email from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a deleted user email from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    And edit user email success message to existing user email should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21869 @bus @2.5 @existing_username @mozypro @regression @core_function
  Scenario: Mozy-21869:Update User(MP) With Existing Admin Username
    When I log in bus admin console as administrator
    And I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I get an admin email from the database
    And edit user details:
      | email                 |
      | @existing_admin_email |
    Then edit user email success message to existing admin email should be displayed
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21880 @bus @2.5 @existing_username @enterprise @regression @core_function
  Scenario: Mozy-21880:Add New User(ME) With Existing User Username
    When I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    And I act as newly created partner
    And I get a MH user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a MP user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a ME user username from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
  #    And I get a MEO user username from the database
  #    And I add new user(s):
  #      | email                | user_group          | storage_type | storage_limit | devices |
  #      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
  #    Then Add new user error message should be:
  #    """
  #    Failed to create 1 user(s)
  #    """
#    And I get a MC user username from the database
#    And I add new user(s):
#      | email                | user_group          | storage_type | storage_limit | devices |
#      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
#    Then Add new user error message should be:
#    """
#    Failed to create 1 user(s)
#    """
    And I get a suspended user email from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then Add new user error message should be:
    """
    Failed to create 1 user(s)
    """
    And I get a deleted user email from the database
    And I add new user(s):
      | email                | user_group          | storage_type | storage_limit | devices |
      | @existing_user_email |(default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21876 @bus @2.5 @existing_username @enterprise @regression @core_function
  Scenario: Mozy-21876:Add New User(ME) With Existing Admin Username
    When I log in bus admin console as administrator
    And I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    And New partner should be created
    And I act as newly created partner
    And I get an admin email from the database
    And I add new user(s):
      | email                 | user_group           | storage_type | storage_limit | devices |
      | @existing_admin_email | (default user group) | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords              |
      | @existing_admin_email |
    And I view user details by newly created user email
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21873 @bus @2.5 @existing_username @enterprise @regression @core_function
  Scenario: Mozy-21873:Update User(ME) With Existing User Username
    When I log in bus admin console as administrator
    And I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I get a MH user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a MP user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a ME user username from the database
    And edit user details:
      | email                |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
  #    And I get a MEO user username from the database
  #      And edit user details:
  #        | email                 |
  #        | @existing_admin_email |
  #      Then edit user email error message to existing user email should be displayed
    And I get a MC user username from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a suspended user email from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    Then edit user email error message to existing user email should be displayed
    And I get a deleted user email from the database
    And edit user details:
      | email                 |
      | @existing_user_email |
    And edit user email success message to existing user email should be displayed
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21870 @bus @2.5 @existing_username @enterprise @regression @core_function
  Scenario: Mozy-21870:Update User(ME) With Existing Admin Username
    When I log in bus admin console as administrator
    And I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    And New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I get an admin email from the database
    And edit user details:
      | email                 |
      | @existing_admin_email |
    Then edit user email success message to existing admin email should be displayed
    And I delete user
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


