Feature: Admin Has Unique Username

  As an admin,
  I want to be told when I create a new user if the name already exists,
  So that I can choose a unique one.

  As an admin,
  when I change a user email address (username) across MH, MP, ME, MEO, MCI want to be told if the name already exists,
  So that I can choose a unique one.

  @TC.21342 @bus @2.5 @existing_email @regression @core_function
  Scenario: 21342:Add New Admin Role with Existing Admin Email
    When I get an admin email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name       | Email                 | Roles |
      | First Last | @existing_admin_email | Sales |
    Then Add New Admin error message should be:
    """
    An account with that email address already exists
    """
  @TC.21341 @bus @2.5 @existing_email @regression @core_function
  Scenario: 21341:Add New Admin Role with Existing User Email
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name       | Email                | Roles |
      | First Last | @existing_user_email | Sales |
    Then Add New Admin success message should be displayed
    When I delete admin by:
      | email                |
      | @existing_user_email |

  @TC.21351 @bus @2.5 @existing_email @mozyhome @phoenix @regression @core_function
  Scenario: Mozy-21351:Edit Admin Email With Existing User Email(MH)
    When I get a Mozy Home user email from the database
    And I log in bus admin console as administrator
    And I view the partner info
    And I change the username to existing user email
    Then username changed success message should be displayed
    When I change the username to automation admin email
    Then username changed success message should be displayed

  @TC.21348 @bus @2.5 @existing_email @regression @core_function
  Scenario: 21348:Edit Sub Admin with Existing Admin Email
    When I get an admin email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Roles |
      | Sales |
    Then Add New Admin success message should be displayed
    When I view admin details by:
      | email        |
      | @admin_email |
    And edit admin details:
      | Email:                |
      | @existing_admin_email |
    Then edit sub admin personal information error message(s) should be:
    """
    An account with that email address already exists
    """
    When I delete admin by:
      | email        |
      | @admin_email |

  @TC.21340 @bus @2.5 @existing_email @regression @core_function
  Scenario: 21340:Edit Admin Email With Admin Email That Is Already in Use
    When I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Roles |
      | Sales |
    And I save the admin email as existing admin email
    And I view the partner info
    And I change the username to existing admin email
    Then Account Details error message should be:
    """
    An account with that email address already exists
    Email address unchanged. The email address you entered is invalid or already in use: An account with that email address already exists
    """
    And I delete admin by:
      | email                 |
      | @existing_admin_email |

  @TC.21346 @bus @2.5 @existing_email @regression @core_function
  Scenario:  21346:Edit Admin Email With User Email That Is Already in Use
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I view the partner info
    And I change the username to existing user email
    Then username changed success message should be displayed
    When I change the username to automation admin email
    Then username changed success message should be displayed

  @TC.21347 @bus @2.5 @existing_email @regression @core_function
  Scenario: 21347:Edit Sub Admin with Existing User Email
    When I get a user email from the database
    And I log in bus admin console as administrator
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Roles |
      | Sales |
    Then Add New Admin success message should be displayed
    When I view admin details by:
      | email        |
      | @admin_email |
    And edit admin details:
      | Email:               |
      | @existing_user_email |
    Then edit sub admin personal information success message should display
    When I delete admin by:
      | email                |
      | @existing_user_email |
