Feature: Configurations: Account Details


  Background:
    Given I log in bus admin console as administrator

  @TC.880 @tasks_p1 @smoke @account_details @bus @ROR_smoke
  Scenario: 880 Edit the name on an account
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 50 GB     | yes       |
    Then New partner should be created
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    When I change the display name to auto test account
    Then display name changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.881 @tasks_p1 @smoke @account_details @bus
  Scenario: 881 Change the username/email on an account
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    Then I change the username to auto generated email
    And username changed success message should be displayed
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password default password
    Then I login as mozypro admin successfully
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.882 @tasks_p1 @smoke @account_details @bus
  Scenario: 882 Change the password on an account (correct current password)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 24     | 28    | 50 GB       |  10           |
    Then New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    Then I change root admin password in Account Details from old password default password to Hipaa password
    And password changed success message should be displayed
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password Hipaa password
    Then I login as mozypro admin successfully
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password default password
    Then Login page error message should be Incorrect email or password.
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.883 @tasks_p1 @account_details @bus
  Scenario: 883 Change the password on an account (incorrect current password)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    Then I change root admin password in Account Details from old password wrongpass to Hipaa password
    Then Account Details error message should be:
    """
    Incorrect password
    """
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password Hipaa password
    Then Login page error message should be Incorrect email or password.
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password default password
    Then I login as mozypro admin successfully
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.131670 @tasks_p1 @account_details @bus
  Scenario: 131670 Changing HIPAA admin password in configuration (correct current password)
    When I add a new MozyPro partner:
      | period | base plan  | storage add on | server plan | security |
      | 24     | 1 TB       | 25             | yes         | HIPAA    |
    Then New partner should be created
    And Partner general information should be:
      | Security: |
      | HIPAA     |
    And I activate new partner admin with Hipaa password
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    Then I change root admin password in Account Details from old password Hipaa password to reset password
    And password changed success message should be displayed
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password Hipaa password
    Then Login page error message should be Incorrect email or password.
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123313 @tasks_p1 @account_details @bus
  Scenario: 123313 Changing HIPAA admin password in configuration(incorrect current password)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | security |
      | 12     | 18    | 1 TB        | 20            | HIPAA    |
    Then New partner should be created
    And Partner general information should be:
      | Security: |
      | HIPAA     |
    And I activate new partner admin with Hipaa password
    And I act as newly created partner account
    Then I navigate to Account Details section from bus admin console page
    Then I change root admin password in Account Details from old password wrongpass to reset password
    Then Account Details error message should be:
    """
    Incorrect password
    """
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password reset password
    Then Login page error message should be Incorrect email or password.
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password Hipaa password
    Then I login as mozypro admin successfully
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name







