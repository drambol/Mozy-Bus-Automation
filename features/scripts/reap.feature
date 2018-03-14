Feature: Reap Script Verification
  As a Mozy employee, I verify the reap script is working

  @TC.10491 @bus @reap @email @env_dependent @regression @ROR_smoke @core_function_remove
  Scenario: 10491:MozyHome delinquent payment.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
     | keywords       |
     | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    Then I run third notification reap script
    Then I run fourth notification reap script
    Then I run fifth notification reap script
    Then I run final notification reap script
    Then I run deletion reap script
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username

  @TC.22019 @bus @reap @z-date @email @env_dependent @regression @core_function_remove
  Scenario: Mozy-22019:Long delinquent account z date set
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script with z-dates
    Then I run first notification reap script with z-dates
    Then I run second notification reap script with z-dates
    Then I run third notification reap script with z-dates
    Then I run fourth notification reap script with z-dates
    Then I run fifth notification reap script with z-dates
    Then I run sixth notification reap script with z-dates
    Then I run seventh notification reap script with z-dates
    Then I run final notification reap script with z-dates
    Then I run deletion reap script with z-dates
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username


  @TC.22013 @bus @reap @tasks_p3 @regression
  Scenario:  Mozy-22013:Delinquent fixes account after 2nd notice.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4707588795547209 | Visa        |  United States  |
    Then user credit card updated successfully
    When I search emails by keywords:
      | to               | subject                                           |
      | @new_admin_email | Attention! Your files are scheduled to be deleted |
    Then I should see 2 email(s)

  @TC.22017 @bus @reap @tasks_p3 @regression
  Scenario:  Mozy-22017:Delinquent fixes account after 6th notice.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country       |
      | 12      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    Then I run third notification reap script
    Then I run fourth notification reap script
    Then I run fifth notification reap script
    Then I run final notification reap script
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4707588795547209 | Visa        |  United States  |
    Then user credit card updated successfully
    When I search emails by keywords:
      | to               | subject                                           |
      | @new_admin_email | Attention! Your files are scheduled to be deleted |
    Then I should see 5 email(s)
    When I search emails by keywords:
      | to               | subject                                               |
      | @new_admin_email | Final Notice! Your files are scheduled to be deleted  |
    Then I should see 1 email(s)

  @TC.22270 @bus @reap @tasks_p3 @regression
  Scenario: Mozy-22270:MozyHome delinquent payment multiple machines.
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan  | country       |
      | 1      | 125 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    And activate the mozyhome user's Desktop device with the default password
    And activate the mozyhome user's Desktop device with the default password
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script
    Then I run first notification reap script
    Then I run second notification reap script
    Then I run third notification reap script
    Then I run fourth notification reap script
    Then I run fifth notification reap script
    Then I run final notification reap script
    Then I run deletion reap script
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username

  @TC.22291 @bus @reap @tasks_p3 @regression
  Scenario:  Mozy-22291:Delinquent fixes account after 1st notice zdate
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script with z-dates
    Then I run first notification reap script with z-dates
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4707588795547209 | Visa        |  United States  |
    Then user credit card updated successfully
    When I search emails by keywords:
      | to               | subject                                           |
      | @new_admin_email | Attention! Your files are scheduled to be deleted |
    Then I should see 1 email(s)


  @TC.22294 @bus @reap @tasks_p3 @regression
  Scenario:  Mozy-22294:Delinquent fixes account after 4th notice zdate
    Given I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    Then I force current MozyHome account to delinquent state
    Then I run identification reap script with z-dates
    Then I run first notification reap script with z-dates
    Then I run second notification reap script with z-dates
    Then I run third notification reap script with z-dates
    Then I run fourth notification reap script with z-dates
    And I login as the user on the account.
    And I change my profile attributes to:
      | new_cc_num       | new_cc_type | billing country |
      | 4707588795547209 | Visa        |  United States  |
    Then user credit card updated successfully
    When I search emails by keywords:
      | to               | subject                                           |
      | @new_admin_email | Attention! Your files are scheduled to be deleted |
    Then I should see 4 email(s)

  @TC.10488 @bus @reap @tasks_p3 @regression
  Scenario: Mozy-10488:MozyHome free user inactive 90 days.
    #BUS-9657 bug
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    And I save the partner info
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    And activate the mozyhome user's Desktop device with the default password
    And I force current MozyHome account to inactive state
    Then I run first notification reap script for mozyhome free
    Then I run first notification reap script for mozyhome free
    Then I run second notification reap script for mozyhome free
    Then I run third notification reap script for mozyhome free
    Then I run fourth notification reap script for mozyhome free
    Then I run fifth notification reap script for mozyhome free
    Then I run final notification reap script for mozyhome free
    Then I run deletion reap script for mozyhome free
    Then I close user details section
    And I search user by:
      | keywords         | filter          |
      | @mh_user_email   | Deleted Users   |
    And I view user details by newly created MozyHome username

  @TC.22079 @bus @reap @tasks_p3 @regression
  Scenario: Mozy-22079:Free inactive fixes account after final notice
    #BUS-9657 bug
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    And I save the partner info
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    And activate the mozyhome user's Desktop device with the default password
    And I force current MozyHome account to inactive state
    Then I run first notification reap script for mozyhome free
    Then I run second notification reap script for mozyhome free
    Then I run third notification reap script for mozyhome free
    Then I run fourth notification reap script for mozyhome free
    Then I run fifth notification reap script for mozyhome free
    Then I run final notification reap script for mozyhome free
    And activate the mozyhome user's Desktop device with the default password
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username

  @TC.22303 @bus @reap @tasks_p3 @regression
  Scenario: Mozy-22303:Free inactive fixes account after 3rd notice zdate
    #BUS-9657 bug
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    And I save the partner info
    Then the user is successfully added.
    And the user has activated their account
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then I get the user id
    And activate the mozyhome user's Desktop device with the default password
    And I force current MozyHome account to inactive state
    Then I run identification reap script for mozyhome free with z-dates
    Then I run first notification reap script for mozyhome free with z-dates
    Then I run second notification reap script for mozyhome free with z-dates
    Then I run third notification reap script for mozyhome free with z-dates
    And activate the mozyhome user's Desktop device with the default password
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username


