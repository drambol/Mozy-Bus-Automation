Feature: MozyHome user change renewal plan through phoenix

  As a MozyHome paid user
  I want to change renewal plan
  So that I can have new renewal plan


    #
  # 50 GB Cases
  #
  @TC.124831 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124831 Add US 50 GB addl PC monthly MozyHome to renewal plan addl PC us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       | billing country | cc number         |
      | 1      | 50 GB     | 4              | United States | United States   | 4018121111111122  |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99   |
      | Additional Computers - Monthly        | $2.00  | 4        | $8.00   |
      | Total Charge                          |        |          | $13.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | computers |
      | 1         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124832 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124832 Add US 50 GB yearly MozyHome to renewal plan 125 GB addl storage us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage |
      | 125 GB    | 3            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 3 x 20 GB = 60 GB |
      | Total Storage:      | 185 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $175.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 60 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $175.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124833 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124833 Add US 50 GB biennial MozyHome to renewal yearly us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 50 GB     | United States | United States   |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124834 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124834 Add US 125 GB monthly MozyHome to renewal plan biennial addl PC us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 1      | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $293.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 5               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $293.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124835 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124835 Add US 125 GB yearly MozyHome to renewal plan 50 GB us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 12     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124836 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124836 Add US 125 GB biennial MozyHome to renewal plan 50 GB yearly addl stor PC us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country |
      | 24     | 125 GB    | United States | United States   |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 50 GB     | 12      | 5        | 10           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $373.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 200 GB         |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $373.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.124837 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 124837 Add US 50 GB addl stor monthly MozyHome to renewal plan 125 GB us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 1      | 50 GB     | United States | United States   | 1            |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00 | 1        | $2.00  |
      | Total Charge                          |       |          | $7.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 GB    |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Total:              | $11.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 20 GB             |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Total:              | $11.99            |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124838 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 124838 Add US 50 GB yearly addl PC MozyHome to renewal plan biennial us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 12     | 50 GB     | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Additional Computers - Annual        | $22.00 | 1        | $22.00 |
      | Total Charge                         |        |          | $87.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $167.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $167.79        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user


  @TC.124839 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @qa6_dependent
  Scenario: 124839 Add US 50 GB biennial coupon MozyHome to renewal plan monthly us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | coupon       |
      | 24     | 50 GB     | United States | United States   | 10percentoff |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Subscription Price                     | $125.79 |          | $125.79 |
      | 24 months at 10.0% off                 | $-12.57 |          | $-12.57 |
      | Total Charge                           |         |          | $113.22 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 1      |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124840 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 124840 Add US 125 GB addl stor PC monthly MozyHome to renewal plan biennial us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage | addl computers |
      | 1      | 125 GB    | United States | United States   | 2            | 2              |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 2        | $4.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $17.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period |
      | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 2 x 20 GB = 40 GB |
      | Total Storage:      | 165 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $377.79           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 40 GB           |
      | Computers:          | 5               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $377.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124841 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 124841 Add US 125 GB addl stor yearly MozyHome to renewal plan 50 GB montly us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 12     | 125 GB    | United States | United States   | 98           |
    Then the billing summary looks like:
      | Description                                  | Price     | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89   | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00    | 98       | $2,156.00 |
      | Total Charge                                 |           |          | $2,265.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 GB     | 1      |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB        |
      | Additional Storage: | 98 x 20 GB = 1,960 GB |
      | Total Storage:      | 2,010 GB              |
      | Computers:          | 1                     |
      | Subscription:       | Monthly               |
      | Total:              | $201.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 1.9 TB         |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $201.99        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124842 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 124842 Add US 125 GB addl PC biennial MozyHome to renewal plan yearly addl stor PC us_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl computers |
      | 24     | 125 GB    | United States | United States   | 1              |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   |         |          | $251.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 5         | 5            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB    |
      | Additional Storage: | 5 x 20 GB = 100 GB |
      | Total Storage:      | 225 GB             |
      | Computers:          | 5                  |
      | Subscription:       | Yearly             |
      | Term Discount:      | 1 month free       |
      | Total:              | $263.89            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 100 GB          |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $263.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.124843 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124843 Add US 50 GB addl stor PC coupon monthly MozyHome to renewal plan 125 GB biennial us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | addl storage | addl computers | coupon       |
      | 1      | 50 GB     | United States | 99           | 2              | 10percentoff |
    Then the billing summary looks like:
      | Description                           | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99   | 1        | $5.99   |
      | 20 Additional Storage - Monthly       | $2.00   | 99       | $198.00 |
      | Additional Computers - Monthly        | $2.00   | 2        | $4.00   |
      | Subscription Price                    | $207.99 |          | $207.99 |
      | 1 month at 10.0% off                  | $-20.79 |          | $-20.79 |
      | Total Charge                          |         |          | $187.20 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 125 GB    | 24     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 99 x 20 GB = 1,980 GB |
      | Total Storage:      | 2,105 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Biennial              |
      | Term Discount:      | 3 months free         |
      | Total:              | $4,367.79             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB          |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $4,367.79       |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124844 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124844 Add US 50 GB yearly MozyHome to renewal plan 125 GB monthly addl stor us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 GB    | 1      | 99           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 99 x 20 GB = 1,980 GB |
      | Total Storage:      | 2,105 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Monthly               |
      | Total:              | $207.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB          |
      | Computers:          | 3               |
      | Subscription:       | Monthly         |
      | Total:              | $207.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124845 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124845 Add US 50 GB biennial addl PC MozyHome to renewal plan addl PC monthly us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       |
      | 24     | 50 GB     | 4              | United States |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Additional Computers - Biennial        | $42.00  | 4        | $168.00 |
      | Total Charge                           |         |          | $293.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Monthly          |
      | Total:              | $7.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Monthly        |
      | Total:              | $7.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124846 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124846 Add US 125 GB monthly addl stor PC MozyHome to renewal plan addl stor yearly us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | addl storage | country       |
      | 1      | 125 GB    | 2              | 10           | United States |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 10       | $20.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $33.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | addl storage |
      | 12     | 20           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB     |
      | Additional Storage: | 20 x 20 GB = 400 GB |
      | Total Storage:      | 525 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $593.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 400 GB          |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $593.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124847 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124847 Add US 125 GB addl stor PC yearly MozyHome to renewal plan addl stor PC us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       |
      | 12     | 125 GB    | 10           | 2              | United States |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 10       | $220.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 |         |          | $373.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 1            | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $131.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $131.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124848 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 124848 Add US 125 GB biennial MozyHome to renewal plan 50 GB monthly us_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | base plan |
      | 1      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.124849 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=jp
  Scenario: 124849 Add US 50 GB addl stor PC monthly MozyHome to renewal plan addl stor PC us_jp_jp
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 1      | 50 GB     | 30           | 2              | United States | Japan           | 4542465014608212 |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 30       | $60.00 |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          |        |          | $69.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 10           | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 2                   |
      | Subscription:       | Monthly             |
      | Total:              | $27.99              |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB  |
      | Additional Storage: | 200 GB          |
      | Computers:          | 2               |
      | Subscription:       | Monthly         |
      | Total:              | $27.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124850 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 124850 Add US 50 GB addl PC yearly MozyHome to renewal plan addl PC monthly us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | country       | billing country | cc number        |
      | 12     | 50 GB     | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 2        | $44.00  |
      | Total Charge                         |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 1      | 1         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124851 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 124851 Add US 50 GB biennial MozyHome to renewal plan 125 GB us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 125 GB    |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $209.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124852 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 124852 Add US 125 GB monthly addl PC stor MozyHome to renewal plan 50 GB addl stor PC us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 1      | 125 GB    | 4            | 2              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 4        | $8.00  |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $21.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage | computers |
      | 50 GB     | 3            | 4         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 3 x 20 GB = 60 GB |
      | Total Storage:      | 110 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Monthly           |
      | Total:              | $17.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 60 GB          |
      | Computers:          | 4              |
      | Subscription:       | Monthly        |
      | Total:              | $17.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124853 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @bin_country=jp
  Scenario: 124853 Add US 125 GB yearly addl stor PC MozyHome to renewal plan 50 GB monthly no addl stor PC us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 12     | 125 GB    | 99           | 2              | United States | China           | 4542465014608212 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount    |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89   |
      | 20 Additional Storage - Annual               | $22.00  | 99       | $2,178.00 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00    |
      | Total Charge                                 |         |          | $2,331.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage | addl computers |
      | 50 GB     | 1      | 0            | 1              |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124854 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: 124854 Add US 125 GB addl stor PC biennial MozyHome to renewal plan no addl stor PC us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       | billing country | cc number        |
      | 24     | 125 GB    | 1            | 1              | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 1        | $42.00  |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   |         |          | $293.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | addl storage | computers |
      | 0            | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $209.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124855 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 124855 Add US 50 GB monthly MozyHome to renewal plan addl PC stor yearly us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 5         | 5            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB     |
      | Additional Storage: | 5 x 20 GB = 100 GB |
      | Total Storage:      | 150 GB             |
      | Computers:          | 5                  |
      | Subscription:       | Yearly             |
      | Term Discount:      | 1 month free       |
      | Total:              | $263.89            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 100 GB         |
      | Computers:          | 5              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $263.89        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124856 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 124856 Add US 50 GB yearly MozyHome to renewal plan 125 GB addl PC us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89 |
      | Total Charge                         |        |          | $65.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | computers |
      | 125 GB    | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $153.89          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 5               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $153.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124857 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=jp
  Scenario: 124857 Add US 50 GB biennial MozyHome to renewal plan 125 GB addl stor monthly us_fr_jp
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | Japan           | 4542465014608212 |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | addl storage |
      | 125 GB    | 1      | 98           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB       |
      | Additional Storage: | 98 x 20 GB = 1,960 GB |
      | Total Storage:      | 2,085 GB              |
      | Computers:          | 3                     |
      | Subscription:       | Monthly               |
      | Total:              | $205.99               |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 1.9 TB          |
      | Computers:          | 3               |
      | Subscription:       | Monthly         |
      | Total:              | $205.99         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124858 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 124858 Add US 125 GB monthly MozyHome to renewal plan 50 GB us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 125 GB    | United States | China           | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan |
      | 50 GB     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Monthly          |
      | Total:              | $5.99            |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Monthly        |
      | Total:              | $5.99          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124859 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: 124859 Add US 125 GB yearly MozyHome to renewal plan addl PC stor biennial us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | United States   | 4357441111111222 |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 24     | 4         | 1            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $293.79           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 4               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $293.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124860 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @bin_country=jp
  Scenario: 124860 Add US 125 GB biennial MozyHome to renewal plan 50 GB addl PC yearly us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 125 GB    | United States | China           | 4542465014608212 |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 50 GB     | 12     | 2         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 2                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $87.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 2              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $87.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 GB Cases
  #
  @TC.124861 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124861 Add US 50 GB addl stor PC monthly MozyHome to renewal plan 125 GB addl stor PC yearly us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       |
      | 1      | 50 GB     | 3            | 2              | United States |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly       | $2.00  | 3        | $6.00  |
      | Additional Computers - Monthly        | $2.00  | 2        | $4.00  |
      | Total Charge                          |        |          | $15.99 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers | addl storage |
      | 125 GB    | 12     | 4         | 10           |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB     |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 325 GB              |
      | Computers:          | 4                   |
      | Subscription:       | Yearly              |
      | Term Discount:      | 1 month free        |
      | Total:              | $351.89             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 200 GB          |
      | Computers:          | 4               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $351.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124862 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124862 Add US 50 GB yearly addl stor PC MozyHome to renewal plan biennial addl PC us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | addl computers | country       |
      | 12     | 50 GB     | 10           | 2              | United States |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89  |
      | 20 Additional Storage - Annual       | $22.00 | 10       | $220.00 |
      | Additional Computers - Annual        | $22.00 | 2        | $44.00  |
      | Total Charge                         |        |          | $329.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers |
      | 24     | 5         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB      |
      | Additional Storage: | 10 x 20 GB = 200 GB |
      | Total Storage:      | 250 GB              |
      | Computers:          | 5                   |
      | Subscription:       | Biennial            |
      | Term Discount:      | 3 months free       |
      | Total:              | $713.79             |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 200 GB         |
      | Computers:          | 5              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $713.79        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124863 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124863 Add US 50 GB biennial addl stor MozyHome to renewal plan 125 GB no addl stor us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | country       |
      | 24     | 50 GB     | 99           | United States |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount    |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79   |
      | 20 Additional Storage - Biennial       | $42.00  | 99       | $4,158.00 |
      | Total Charge                           |         |          | $4,283.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage |
      | 125 GB    | 0            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 125 GB           |
      | Computers:          | 3                |
      | Subscription:       | Biennial         |
      | Term Discount:      | 3 months free    |
      | Total:              | $209.79          |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 0 GB            |
      | Computers:          | 3               |
      | Subscription:       | Biennial        |
      | Term Discount:      | 3 months free   |
      | Total:              | $209.79         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 GB Cases
  #
  @TC.124864 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124864 Add US 125 GB monthly MozyHome to renewal plan 50 GB yearly us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period |
      | 50 GB     | 12     |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 x 20 GB = 0 GB |
      | Total Storage:      | 50 GB            |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $65.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 0 GB           |
      | Computers:          | 1              |
      | Subscription:       | Yearly         |
      | Term Discount:      | 1 month free   |
      | Total:              | $65.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124865 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124865 Add US 125 GB addl stor yearly MozyHome to renewal plan 50 GB biennial addl PC us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl storage | country       |
      | 12     | 125 GB    | 4            | United States |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 4        | $88.00  |
      | Total Charge                                 |         |          | $197.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | period | computers |
      | 50 GB     | 24     | 3         |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 4 x 20 GB = 80 GB |
      | Total Storage:      | 130 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Total:              | $377.79           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 50 GB |
      | Additional Storage: | 80 GB          |
      | Computers:          | 3              |
      | Subscription:       | Biennial       |
      | Term Discount:      | 3 months free  |
      | Total:              | $377.79        |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124866 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: 124866 Add US 125 GB biennial addl stor PC MozyHome to renewal plan yearly addl stor us_cn_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | addl computers | addl storage | country       |
      | 24     | 125 GB    | 2              | 10           | United States |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 10       | $420.00 |
      | Additional Computers - Biennial                | $42.00  | 2        | $84.00  |
      | Total Charge                                   |         |          | $713.79 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | period | computers | addl storage |
      | 12     | 3         | 1            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $131.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB |
      | Additional Storage: | 20 GB           |
      | Computers:          | 3               |
      | Subscription:       | Yearly          |
      | Term Discount:      | 1 month free    |
      | Total:              | $131.89         |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.126162 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: 126162 Add US 50 GB + 60 GB 1 PC yearly MozyHome user to renewal plan 125 GB +20 GB,3 PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | addl storage |
      | 12     | 50 GB     | United States | United States   | 3            |
    Then the billing summary looks like:
      | Description                          | Price  | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89 | 1        | $65.89  |
      | 20 Additional Storage - Annual       | $22.00 | 3        | $66.00  |
      | Total Charge                         |        |          | $131.89 |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I change my user account to:
      | base plan | addl storage |
      | 125 GB    | 1            |
    And the renewal plan subscription looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1 x 20 GB = 20 GB |
      | Total Storage:      | 145 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Yearly            |
      | Term Discount:      | 1 month free      |
      | Total:              | $131.89           |
    And the renewal plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 20 GB            |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Total:              | $131.89          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user
