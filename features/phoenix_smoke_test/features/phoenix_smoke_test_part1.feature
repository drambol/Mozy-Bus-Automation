Feature: Phoenix smoke test

  As a business owner
  (1) I want to create a partner through phoenix
  (2) I want to create a mozyhome user and manage home user
  So that I can organize my business in a way that works for me

  @TC.126120 @bus @regression_test @phoenix @mozyhome @us @cbs_tls12
  Scenario: 126120 Create a MozyHome paid user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | admin name                                | billing country | cc number        | coupon                |
      | 1      | 50 GB     | United States | Internal Mozy - Phoenix smoke test - home | United States   | 4018121111111122 | <%=QA_ENV['coupon']%> |
    And I save the partner info
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account

  @TC.126132 @bus @regression_test @phoenix @mozyhome @us @cbs_tls12
  Scenario: 126132 Log into the MozyHome paid user - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I verify the user account.

  @TC.126139 @bus @regression_test @phoenix @mozyhome
  Scenario: 126139 update a profile info of home user - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_username_first                        | new_username_last | new_username_full                                      |
      | Internal Mozy - Phoenix smoke test - home | name changed      | Internal Mozy - Phoenix smoke test - home name changed |
    # Add change country, address, Add check point
    And I save the partner info

  @TC.126124 @bus @regression_test @phoenix @mozyhome @us @qa @cbs_tls12
    Scenario: 126124 Update Billing address of MozyHome user - Precondition:@TC.126120
      When I get previous partner info
      When I login as the user on the account.
      And I change my profile attributes to:
        | new_cc_num       | new_cc_type | last_four_digs |
        | 5111991111111121 | MasterCard  | 1121           |
      And I save the partner info

  @TC.126128 @bus @regression_test @phoenix @mozyhome @us @cbs_tls12
  Scenario: 126128 update a user name - Precondition:@TC.126120
    When I get previous partner info
    And I login as the user on the account.
    And I change email address to:
      | new email        | password                            |
      | @new_admin_email | <%=CONFIGS['global']['test_pwd'] %> |
    And I change email address successfully
    """
      Your email change request requires verification. We sent an email to @new_admin_email. Please open the email and click the verification link to confirm this change.
     """
    When I search emails by keywords:
      | subject                   | content                        |
      | Email Change Notification | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    And I retrieve email content by keywords:
      | to                | subject                    |
      | @new_admin_email  | Email Address Verification |
    And I get verify email address from email content for mozyhome change email address
    Then verify email address link should show success message
    And I log into phoenix with username @new_admin_email and password test1234
    And I save the partner info

  @TC.126133 @bus @regression_test @phoenix @mozyhome @us
  Scenario: 126133 Mozyhome user change password - Precondition:@TC.126120
    When I get previous partner info
    When I login as the user on the account.
    And I change my profile attributes to:
      | new_password |
      | Naich4yei8   |
    #And I logout of my user account
    And I login under changed password on the account.

  @TC.126131 @bus @regression_test @phoenix @mozyhome @us @qa
  Scenario: 126131 Mozyhome user forget password - Precondition:@TC.126120
    When I get previous partner info
    And I navigate to phoenix login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                    | to                            |
      | MozyHome password recovery | <%=@partner.admin_info.email%>|
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed. Please start MozyHome Configuration on each computer on the account in order to enter the new password.
    And I log into phoenix with username @new_admin_email and password reset password
    And I save the partner info

  @TC.126137 @bus @regression_test @phoenix @mozyhome @us @cbs_tls12
  Scenario: 126137 view home user detail in BUS - Precondition:@TC.126120,@TC.126124
    When I get previous partner info
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: | Name:               |
      | MozyHome (change) | @country | @user_name (change) |
    And MozyHome subscription details should be:
      | Subscription                                |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly |
    Then MozyHome user billing info should be:
      | ID   | Cause                                       | Date  | Amount | Card #    | Card Type  | Failure? | Captured? | Refunded?  | Payment Processor | Return Code |
      | @id  | User CC Update                              | today | $1.00  | XXXX-1121 | MasterCard | No       | No        | No         | Cybersource US    |             |
      | @id  | MozyHome 50 GB, + 0 GB, 1 machines, monthly | today | $5.99  | XXXX-1122 | Visa       | No       | Yes       | Refund now | Cybersource US    |             |


  @TC.126138 @bus @regression_test @phoenix @mozyhome @cbs_tls12
  Scenario: 126138 delete home user in BUS - Precondition:@TC.126120
    When I get previous partner info
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user









