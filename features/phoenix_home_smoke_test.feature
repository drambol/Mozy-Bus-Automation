Feature: Mozy Home Smoke Test via Phoenix

  As a private citizen, I want to create a fr4ee-user account through phoenix [##@PROD-53##]
    Afterwards, I want to do the following:
      1. log in to the account as its admin [##@PROD-54##]
      2. upgrade the acct to paid [##@PROD-58##]
      3. change profile data: billing address/credit card info, username & password [##@PROD-55,176##]
        a. verify change in password via log out and login
      4. change newly paid acct (upgrade)
      5. change the newly paid & recently upgraded acct billing interval (renewal)
        b. verify all changes to user within the bus admin console as root admin

  Background:
  # info to be added here: coverage matrix

  @TC.53 @TC.54 @TC.55 @TC.58 @bus @regression_test @phoenix @mozyhome @free @email
  Scenario: 53 54 55 58 Add a new US monthly free MozyHome user
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | base plan | period |
      | 50 GB     | 1      |
    Then upgrade from free to paid will be successful
    And I change my profile attributes to:
      | new_password | new_cc_num       | new_cc_type | last_four_digs | new_username_first | new_username_last | new_username_full |
      | Naich4yei8   | 5111991111111121 | MasterCard  | 1121           | TcUsrFirst         | Smith             | TcUsrFirst Smith  |
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 GB    | 2            |
    And I login under changed password on the account.
    And I change my user account to:
       | period |
       | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 2 x 20 GB = 40 GB |
      | Total Storage:      | 165 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $153.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 40 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $153.89         |
    And I logout of my user account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: | Name:               |
      | MozyHome (change) | @country | @user_name (change) |
    And MozyHome subscription details should be:
      | Subscription     |
      | MozyHome 125 GB, + 40 GB, 3 machines, yearly |
    And I delete user

  @TC.176 @bus @regression_test @phoenix @mozyhome @free @email
  Scenario: TC.176 Change MozyHome user email address
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I verify the user account.
    And I change email address to:
      | new email        | password |
      | @new_admin_email | test1234 |
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
    And I upgrade my free account to:
      | base plan | period |
      | 50 GB     | 1      |
    Then upgrade from free to paid will be successful
    And I verify the user account.

  @TC.52 @TC.56 @bus @regression_test @phoenix @mozypro @emea
  Scenario: TC.52 TC.56 Create a FR MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix  | Quantité | Montant |
      | 10 Go - Mensuel         | 7,99€ | 1        | 7,99€   |
      | Prix d'abonnement       | 7,99€ |          | 7,99€   |
      | TVA                     | 1,60€ |          | 1,60€   |
      | Montant total des frais | 9,59€ |          | 9,59€   |
    And the partner is successfully added.
    And I login as the user on the account.
    And I login as mozypro admin successfully
    When I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.52 @TC.56 @bus @mozypro @phoenix @us
  Scenario: 52,56 Create a US MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description     | Price  | Quantity | Amount |
      | 50 GB - Monthly | $19.99 | 1        | $19.99 |
      | Total Charge    | $19.99 |          | $19.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.51 @TC.57 @bus @regression_test @phoenix @mozyhome
  Scenario: TC.51 TC.57 Create a MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4018121111111122 |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    Then I check download links in download backup software and download mozy sync software page
    And I logout of my user account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user
