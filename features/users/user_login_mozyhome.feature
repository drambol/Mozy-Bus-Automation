Feature: Mozyhome User Login

  Background:

  @TC.123520 @bus @user_login @tasks_p1
  Scenario: 123520:New created MozyHome user and update password
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    When I navigate to My Profile section in Phoenix
    And I change password in Phoenix from default password to reset password
    And I access freyja from phoenix
    And I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.123708 @bus @user_login @tasks_p1
  Scenario: 123708:New created standard Mozyhome user can log in bus & freyja after changing password in freyja
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    And I access freyja from phoenix
    And I select options menu
    Then I click Change password in freyja
    And I change password from default password to reset password in freyja
    And I log into phoenix with username newly created MozyHome username and password reset password
    And I access freyja from phoenix
    When I select options menu
    And I logout freyja
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.123501 @bus @user_login @tasks_p1 @smoke
  Scenario: 123501:Free MozyHome user login bus or phoenix or freyja after changing password in phoenix
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    When I navigate to My Profile section in Phoenix
    And I change password in Phoenix from default password to reset password
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

  @TC.123504 @bus @user_login @tasks_p1
  Scenario: 123504:Paid MozyHome user login bus or phoenix or freyja after changing password in phoenix
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log into phoenix with username newly created MozyHome username and password default password
    When I navigate to My Profile section in Phoenix
    And I change password in Phoenix from default password to reset password
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

  @TC.123419  @bus @user_login @tasks_p1
  Scenario: 123419 MozyHome user login phoenix after activating and changing password
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
    When I navigate to My Profile section in Phoenix
    And I change password in Phoenix from default password to reset password
    And I log into phoenix with username newly created MozyHome username and password reset password
    And I access freyja from phoenix
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.123856 @bus @user_login @tasks_p1
  Scenario: 123856:MozyHome user password would expire
    When I log in bus admin console as administrator
    Then I act as partner by:
      | email                                 |
      | redacted-4165@notarealdomain.mozy.com |
    Then I navigate to Password Policy section from bus admin console page
    Then I update Max age to 1 days
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    Then I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I update user passwords expires at yesterday
    Then I log into phoenix with username newly created MozyHome username and password default password
    And user log in failed, error message is:
    """
     Your Mozy password has expired. Please enter a new one now.
    """
    Then I set a new password hipaa password
    Then I log into phoenix with username newly created MozyHome username and password hipaa password
    When I log in bus admin console as administrator
    Then I act as partner by:
      | email                                 |
      | redacted-4165@notarealdomain.mozy.com |
    Then I navigate to Password Policy section from bus admin console page
    Then I update Max age to unlimited days

  @TC.122209  @bus @tasks_p1
  Scenario: 122209:MozyHome Edit Plan (Downgrade Only)
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan  | country       |
      | 1      | 125 GB     | United States |
    Then the user is successfully added.
    When I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I downgrade mozyhome user to Free
    Then I verify mozyhome user plan is Free after downgrade
    And I delete user

  @TC.123512 @bus @user_login @tasks_p1
  Scenario: 123512:New created MozyHome user forget password and reset password on phoenix
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
    #And I will see reset password massage Your password has been changed.
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



