Feature: Initial renewal notification email for UK monthly home user

  As a UK monthly home user, I will get notification info inside payment confirmation email on
  renewal or get notification email when I update cc in grace period/delinquent state



  @TC.133847  @regression_test @phoenix @mozyhome @email
  Scenario: UK monthly home user will get email containing notification message on signup and renewal
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 50 GB     | United Kingdom | United Kingdom  | 4916783606275713 |
    And I save the partner info
    Then the user is successfully added.
    And I get the current user id from the database
    And the user has activated their account
    When I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Information  |
    Then I check the email content should include:
    """
    Your card will be automatically charged again on <%=Chronic.parse(Date.today.next_month).strftime('%d %B, %Y')%>
    """
    When I set current MozyHome account to be expired 30 days later
    And I run send_initial_renewal_notification for the user
    And I search emails by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I should see 0 email(s)
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I check the email content should include:
    """
    Your card will be automatically charged £4.99 on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date.next_month).strftime('%m/%d/%y')%> to keep your MozyHome 50 GB subscription current.
    """


  @TC.133848  @regression_test @phoenix @mozyhome @email
  Scenario: UK monthly user in grace period update credit card will get initial notification - Precondition:@TC.133848
    When I am at dom selection point:
    And I get previous partner info
    And I get the current user id from the database
    And I force current MozyHome account to grace period
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4916783606275713 | Visa        | United Kingdom  |
    Then user credit card updated successfully
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 50 GB monthly subscription will renew on <%=Chronic.parse(Date.today.next_month).strftime('%d/%m/%y')%>, and your credit card ending in 5713 will then be charged £4.99 to keep your MozyHome 50 GB subscription current.
    """

  @TC.133849  @regression_test @phoenix @mozyhome @email
  Scenario: UK monthly user in deliquent state update credit card will get initial notification - Precondition:@TC.133848
    When I am at dom selection point:
    And I get previous partner info
    And I get the current user id from the database
    And I force current MozyHome account to delinquent state
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4916783606275713 | Visa        | United Kingdom  |
    Then user credit card updated successfully
    And I wait for 30 seconds
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 50 GB monthly subscription will renew on <%=Chronic.parse(Date.today.next_month).strftime('%d/%m/%y')%>, and your credit card ending in 5713 will then be charged £4.99 to keep your MozyHome 50 GB subscription current.
    """

  @TC.133850  @regression_test @phoenix @mozyhome @email
  Scenario: UK montly payjunction user on renewal will receive payment confirmation email which contains auto renew info - Precondition:@TC.133848
    When I am at dom selection point:
    And I get previous partner info
    And I get the current user id from the database
    And I delete the current user_payment_infos from the database
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I wait for 20 seconds
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I check the email content should include:
    """
    Your card will be automatically charged £4.99 on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date.next_month).strftime('%m/%d/%y')%> to keep your MozyHome 50 GB subscription current.
    """


  @TC.133851  @regression_test @phoenix @mozyhome @email
  Scenario: UK montly payjunction user will receive initial notification when he update cc on grace period - Precondition:@TC.133848
    When I am at dom selection point:
    And I get previous partner info
    And I get the current user id from the database
    And I force current MozyHome account to grace period
    And I delete the current user_payment_infos from the database
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4916783606275713 | Visa        | United Kingdom  |
    Then user credit card updated successfully
    And I wait for 30 seconds
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 50 GB monthly subscription will renew on <%=Chronic.parse(Date.today.next_month).strftime('%d/%m/%y')%>, and your credit card ending in 5713 will then be charged £4.99 to keep your MozyHome 50 GB subscription current.
    """

  @TC.133852  @regression_test @phoenix @mozyhome @email
  Scenario: UK montly payjunction user will receive initial notification when he update cc on delinquent state - Precondition:@TC.133848
    When I am at dom selection point:
    And I get previous partner info
    And I get the current user id from the database
    And I force current MozyHome account to delinquent state
    And I delete the current user_payment_infos from the database
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4916783606275713 | Visa        | United Kingdom  |
    Then user credit card updated successfully
    And I wait for 30 seconds
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 50 GB monthly subscription will renew on <%=Chronic.parse(Date.today.next_month).strftime('%d/%m/%y')%>, and your credit card ending in 5713 will then be charged £4.99 to keep your MozyHome 50 GB subscription current.
    """


