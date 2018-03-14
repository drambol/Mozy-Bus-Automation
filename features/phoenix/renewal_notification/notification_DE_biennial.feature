Feature: Initial renewal notification email for Germany biennial home user

  As a Germany biennial home user, I will get notification email 30 days before my renewal

  @TC.133842  @regression_test @phoenix @mozyhome @email
  Scenario: initial notification email should not be received for yearly/biennial user >=31 or <=28 days before renewal date
    When I use a existing partner:
      | admin email                                     | partner type |
      | mozyautotest+germany+biennial+homeuser@emc.com  | MozyHome     |
    And I get the current user id from the database
    And I set current MozyHome account to be expired 365 days later
    And I run send_initial_renewal_notification for the user
    And I set current MozyHome account to be expired 31 days later
    And I run send_initial_renewal_notification for the user
    And I set current MozyHome account to be expired 28 days later
    And I run send_initial_renewal_notification for the user
    And I set current MozyHome account to be expired 0 days later
    And I run send_initial_renewal_notification for the user
    When I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)

  @TC.133843  @regression_test @phoenix @mozyhome @email
  Scenario: yearly/biennial user in grace period/deliquent state update credit card will not receive initial notification
    When I am at dom selection point:
    When I use a existing partner:
      | admin email                                     | partner type |
      | mozyautotest+germany+biennial+homeuser@emc.com  | MozyHome     |
    And I get the current user id from the database
    And I login as the user on the account.
    # update cc first in case user in grace period or delinquent state
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        | Germany         |
    And user credit card updated successfully
    And I force current MozyHome account to grace period
    And I run send_initial_renewal_notification for the user
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        |  Germany         |
    Then user credit card updated successfully
    When I force current MozyHome account to delinquent state
    And I run send_initial_renewal_notification for the user
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        |  Germany        |
    Then user credit card updated successfully

    When I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)

  @TC.133844  @regression_test @phoenix @mozyhome @email
  Scenario: yearly/biennial payjunction user in grace period/deliquent state update credit card will not receive initial notification
    When I am at dom selection point:
    When I use a existing partner:
      | admin email                                     | partner type |
      | mozyautotest+germany+biennial+homeuser@emc.com  | MozyHome     |
    And I get the current user id from the database
    And I login as the user on the account.
    # update cc first in case user in grace period or delinquent state
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        | Germany         |
    And user credit card updated successfully
    And I force current MozyHome account to grace period
    And I delete the current user_payment_infos from the database
    And I run send_initial_renewal_notification for the user
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        |  Germany         |
    Then user credit card updated successfully
    When I force current MozyHome account to delinquent state
    And I delete the current user_payment_infos from the database
    And I run send_initial_renewal_notification for the user
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        |  Germany        |
    Then user credit card updated successfully

    When I search emails by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I should see 0 email(s)


  @TC.133845  @regression_test @phoenix @mozyhome @email
  Scenario: initial notification email should be received for yearly/biennial user 30 days before renewal date
    When I am at dom selection point:
    When I use a existing partner:
      | admin email                                     | partner type |
      | mozyautotest+germany+biennial+homeuser@emc.com  | MozyHome     |
    And I get the current user id from the database
    And I login as the user on the account.
    # update cc first in case user in grace period or delinquent state
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        | Germany         |
    And user credit card updated successfully
    And I set current MozyHome account to be expired 30 days later
    And I run send_initial_renewal_notification for the user
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 125 GB biennial subscription will renew on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date + 30).strftime('%m/%d/%y')%>, and your credit card ending in 1112 will then be charged $209.79 to keep your MozyHome 125 GB subscription current.
    """
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I check the email content should include:
    """
    Your credit card ending in 1112 was billed $209.79 today for a biennial subscription to MozyHome 125 GB.
    """


  @TC.133846  @regression_test @phoenix @mozyhome @email
  Scenario: initial notification email should be received for yearly/biennial payjunction user 30 days before renewal date
    When I am at dom selection point:
    When I use a existing partner:
      | admin email                                     | partner type |
      | mozyautotest+germany+biennial+homeuser@emc.com  | MozyHome     |
    And I get the current user id from the database
    And I login as the user on the account.
    # update cc first in case user in grace period or delinquent state
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4188181111111112 | Visa        | Germany         |
    And user credit card updated successfully
    And I delete the current user_payment_infos from the database
    And I set current MozyHome account to be expired 30 days later
    And I run send_initial_renewal_notification for the user
    And I wait for 20 seconds
    When I retrieve email content by keywords:
      | to               | subject                               |
      | @new_admin_email | MozyHome Initial Renewal Notification |
    Then I check the email content should include:
    """
    Your MozyHome 125 GB biennial subscription will renew on <%=Chronic.parse(DateTime.now.new_offset('-07:00').to_date + 30).strftime('%m/%d/%y')%>, and your credit card ending in 1112 will then be charged $209.79 to keep your MozyHome 125 GB subscription current.
    """
    When I set current MozyHome account to be expired 0 days later
    And I run process_subscription script for the user
    And I wait for 20 seconds
    And I retrieve email content by keywords:
      | to               | subject                       |
      | @new_admin_email | MozyHome Payment Confirmation |
    Then I check the email content should include:
    """
    Your credit card ending in 1112 was billed $209.79 today for a biennial subscription to MozyHome 125 GB.
    """
