Feature: Initial renewal notification email negative cases and user change plan cases

  Free, backup suspended, grace period, deleted home user and pro user should not receive
  initial renewal notification.
  For home user who has changed renewal plan, notification email will be sent according to current plan

  @TC.133858  @regression_test @phoenix @mozyhome @email
  Scenario: free user should not receive renewal notification email
    When I am at dom selection point:
    When I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    Then the user is successfully added.
    And the user has activated their account
    And I get the current user id from the database
    When I run send_initial_renewal_notification for the user
    And I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)

  @TC.133859  @regression_test @phoenix @mozyhome @email
  Scenario: deleted user should not receive renewal notification email
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 50 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the user is successfully added.
    And the user has activated their account
    And I get the current user id from the database
    And I set current MozyHome account to be expired 30 days later
    When I login as the user on the account.
    And I delete the user account with original password
    And I run send_initial_renewal_notification for the user
    And I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)

  @TC.133860  @regression_test @phoenix @mozyhome @email
  Scenario: mozypro user should not receive renewal notification email
    When I get a MP user username from the database
    And I use a existing partner:
      | admin email               | partner type |
      | <%=@existing_user_email%> | MozyHome     |
    And I get the current user id from the database
    And I run send_initial_renewal_notification for the user
    And I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)


  # legacy issue #145815
  @TC.133861  @regression_test @phoenix @mozyhome @email
  Scenario: Ireland user yearly to monthly, check initial notification will be sent 30 days before renewal
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 GB    | Ireland | Ireland         | 4319402211111113 |
    Then the user is successfully added.
    And the user has activated their account
    And I get the current user id from the database
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | submit change |
      | 125 GB    | 1      | yes           |
    When I set current MozyHome account to be expired 30 days later
    And I run send_initial_renewal_notification for the user
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 125 GB monthly subscription will renew on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date + 30).strftime('%m/%d/%y')%>, and your credit card ending in 1113 will then be charged €8.99 to keep your MozyHome 125 GB subscription current.
    """
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    # legacy issue #145815, next subscription is not updated according to real renewal data, so that expiration date of monthly subscription is still one year later
    Then I check the email content should include:
    """
    Your card will be automatically charged €8.99 on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date.next_month).strftime('%m/%d/%y')%> to keep your MozyHome 125 GB subscription current.
    """

  @TC.133862  @regression_test @phoenix @mozyhome @email
  Scenario: Ireland user monthly to biennial, check initial notification will not be sent 30 days before renewal/on renewal
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 GB    | Ireland | Ireland         | 4319402211111113 |
    Then the user is successfully added.
    And the user has activated their account
    And I get the current user id from the database
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | submit change |
      | 50 GB     | 24     | yes           |
    When I set current MozyHome account to be expired 30 days later
    And I run send_initial_renewal_notification for the user
    And I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I check the email content should include:
    """
    Your credit card ending in 1113 was billed €104.79 today for a biennial subscription to MozyHome 50 GB.
    """
    And I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)





