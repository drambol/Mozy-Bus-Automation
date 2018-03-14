Feature: Add a new partner alert


  Background:
    Given I log in bus admin console as administrator

  @TC.120167 @bus @regression @core_function
  Scenario: 120167 Error will occur if no 'Security' option is selected during partner creation
    When I add a new MozyPro partner:
      | period | security |
      | 12     |          |
    Then Add New Partner error message should be:
      """
      Security field cannot be blank
      """
    Then I add a new OEM partner:
      | company_name  | security |
      | TC.120167.OEM |          |
    Then Add New Partner error message should be:
      """
      Security field cannot be blank
      """

  @TC.21339 @bus @2.5 @add_new_partner @existing_email @regression @core_function
  Scenario: 21339 : Add New Partner With Non Unique Admin Email
    When I get an admin email from the database
    And I add a new MozyPro partner:
      | period | admin email           |
      | 1      | @existing_admin_email |
    Then Add New Partner error message should be:
    """
    An account with that email address already exists
    """

  @TC.21343 @bus @2.5 @add_new_partner @existing_email @regression @core_function
  Scenario: 21343:Add New Partner with Existing User Email as Admin Email
    When I get a user email from the database
    And I add a new MozyPro partner:
      | period | base plan | admin email          |
      | 1      | 10 GB     | @existing_user_email |
    Then New partner should be created
    And I delete partner account

  @TC.13026 @bus @partner_alert @tasks_p3
  Scenario: 13026: Create new US partner (business) with invalid credit card number
    When I add a new MozyPro partner:
      | period | base plan | cc number        |
      | 24     | 50 GB     | 4485393141463880 |
    And Aria payment error message should be Could not validate payment information.

  @TC.13028 @bus @partner_alert @tasks_p3
  Scenario: 13028: Create new US Partner (business) with invalid expire date
    When I add a new MozyPro partner:
      | period | base plan | expire month | expire year |
      | 24     | 50 GB     | 1            | 17          |
    And Aria payment error message should be Credit card has expired.

  @TC.13029 @bus @partner_alert @tasks_p3
  Scenario: 13029: Create new US Partner (business) with invalid admin email
    When I add a new MozyPro partner:
      | period | base plan | admin email |
      | 24     | 50 GB     | test123     |
    And Add account error message should be Please enter a valid email address

  @TC.13030 @bus @partner_alert @tasks_p3
  Scenario: 13030: Create new US Partner (business) with no phone number
    When I add a new MozyPro partner:
      | period | base plan | phone |
      | 24     | 50 GB     | empty |
    And Add account error message should be Phone number cannot be blank

  @TC.13047 @bus @partner_alert @tasks_p3
  Scenario: 13047: Create new US partner (business) - cvv2 what is this link
    When I add a new MozyPro partner:
      | period | base plan | check cvv2 |
      | 12     | 50 GB     | true       |
    Then New partner should be created
    And I delete partner account
