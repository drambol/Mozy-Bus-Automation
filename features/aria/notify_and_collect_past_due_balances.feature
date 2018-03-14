Feature: Notify about and collect past-due balances

  As a Mozy sales or finance representative
  I want to provide ample notification when a customer is past-due
  so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @TC.16107 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @regression @core_function
  Scenario: 16107 MozyPro account deleted in bus but history will remain in aria
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I get partner aria id
    And I wait for 40 seconds
    When I delete partner account
    And I wait for 10 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |

  @TC.16108 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @regression @core_function
  Scenario: 16108 MozyPro account without server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I get partner aria id
    And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    And I act as partner by:
      | email        |
      | @admin_email |
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.17877 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @regression @core_function
  Scenario: 17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    And I act as partner by:
      | email        |
      | @admin_email |
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.16147 @TC.22129 @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @email @regression @core_function
  Scenario: 16147 Verify aria sends email when change MozyEnterprise account status to Active Dunning 1 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 11
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                          | after | content                             |
      | AccountManager@mozy.com | [Mozy] Your credit card payment was unsuccessful | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                                  |
      | Your account is past due - Please update your billing information to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.16148 @TC.22129 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @email @regression @core_function
  Scenario: 16148 Verify aria sends email when change Reseller account status to Active Dunning 2 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 12
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 2 |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds

    When I search emails by keywords:
      | from                    | subject                                                          | after | content                             |
      | AccountManager@mozy.com | [Mozy] SECOND NOTICE - Your credit card payment was unsuccessful | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                                  |
      | Your account is past due - Please update your billing information to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16149 @TC.22129 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @email @regression @core_function
  Scenario: 16149 Verify aria sends email when change MozyPro account status to Active Dunning 3 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 13
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 3 |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                         | after | content                              |
      | AccountManager@mozy.com | [Mozy] Your account will be suspended in 7 days | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                                  |
      | Your account is past due - Please update your billing information to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16243 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @email @regression @core_function
  Scenario: 16243 Verify aria sends email when MozyPro account status sets to suspended
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                   | after | content                             |
      | ar@mozy.com | Account Suspension Notice | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)
    Then I search and delete partner account by newly created partner company name

  @TC.16165 @TC.22129 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers @email @regression @core_function
  Scenario: 16165 Verify aria sends email when change MozyPro account status to Active Dunning 1 net terms 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new MozyPro partner:
    | period | base plan | net terms |
    | 1      | 50 GB     | yes       |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 11
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                          | after | content                             |
      | AccountManager@mozy.com | [Mozy] Your credit card payment was unsuccessful | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                               |
      | Your account is past due - Please pay your most recent invoice to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16166 @TC.22129 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers @email @regression @core_function
  Scenario: 16166 Verify aria sends email when change MozyEnterprise account status to Active Dunning 2 net terms 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new MozyEnterprise partner:
      | period | users    | net terms |
      | 12     | 1        | yes       |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 12
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 2 |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                                          | after | content                             |
      | AccountManager@mozy.com | [Mozy] SECOND NOTICE - Your credit card payment was unsuccessful | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                               |
      | Your account is past due - Please pay your most recent invoice to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16244 @TC.22129 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers @email @regression @core_function
  Scenario: 16244 Verify aria sends email when change Reseller account status to Active Dunning 3 net terms 22129 Partner with Aria Status Acitve Dunning 1-3 Will See Dunning Notification
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 100            | yes       |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 13
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 3 |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                         | after | content                             |
      | AccountManager@mozy.com | [Mozy] Your account will be suspended in 7 days | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status                                                                                               |
      | Your account is past due - Please pay your most recent invoice to avoid any interruption in service. |
    When I act as newly created partner account
    Then I should see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.17978 @slow @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @net_terms_customers @email @regression @core_function
  Scenario: 17978 Verify aria sends email when MozyPro account status sets to suspended net terms
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 50 GB     | yes       |
    Then New partner should be created
    And I get partner aria id
    #And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                   | after | content                            |
      | ar@mozy.com | Account Suspension Notice | today | <%=@partner.admin_info.full_name%> |
    Then I should see 1 email(s)
    Then I search and delete partner account by newly created partner company name

#  #@TC.16114 @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers
#  #Scenario: 16114 Verify update credit card in bus and a charge will be attempted for the entire balance
##    When I add a new MozyPro partner:
##    | period | base plan     |
##    | 1      | 50 GB, $19.99 |
##    Then New partner should be created
##    When I log in aria admin console as administrator
##    And I change the new partner account CAG to Fail Test CAG
##    Then CAG message should be Account group changes saved.
##    When I act as newly created partner account
##    And I change account subscription to MozyPro annual billing period!
##    Then Subscription changed message should be Your account has been changed to yearly billing.
##    When I visit aria admin console page
##    When I change the new partner account CAG to CyberSource Credit Card
##    Then CAG message should be Account group changes saved.
#    #When I act as newly created partner account
#    #And I navigate to Change Payment Information section from bus admin console page
#    #And I update partner credit card information with new test info
#    #Then Message displayed on change payment information view should match Your billing information has been successfully updated.

  @TC.16151 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @regression @core_function
  Scenario: 16151 Verify account reinstate from active dunning 1 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I wait for 10 seconds
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 11
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16152 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @regression @core_function
  Scenario: 16152 Verify account reinstate from active dunning 2 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I wait for 10 seconds
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 12
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16153 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @regression @core_function
  Scenario: 16153 Verify account reinstate from active dunning 3 state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I wait for 10 seconds
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And API* I change the Aria account status by newly created partner aria id to 13
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.120030 @BUG.113148 @firefox @bus @2.0 @notify_about_and_collect_past-due_balances @credit_card_customers @regression @core_function
  Scenario: 120030 Verify account reinstate from suspended state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 40 seconds
    And I get partner aria id
  #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    And I wait for 10 seconds
    And I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    And I stop masquerading
    And API* I change the Aria account status by newly created partner aria id to -1
  #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    And I wait for 10 seconds
    And I act as partner by:
      | email        |
      | @admin_email |
    And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 18          | 123 |
    And I save payment information changes
    Then Payment information should be updated
    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.22127 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: Mozy-22127:Partner with Aria Status Active Does Not See Dunning Notification
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 10 GB     |
    Then New partner should be created
    And I get partner aria id
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I click Billing Info link to show the details
    Then Account Status table should be:
      | Status |
      | Active |
    When the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I should not see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I log in bus admin console as administrator
    Then I search and delete partner account by newly created partner company name

  @TC.22132 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 16148 Sub Partners Cannot View Parents Dunning Notice
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota | net terms |
      | TC.22132_partner | 12     | Gold          | 500            | yes       |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.22132_sub_partner |
    Then New partner should be created
    And I stop masquerading
#    And I wait for 40 seconds
    And API* I change the Aria account status by newly created partner aria id to 11
#    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    When I act as partner by:
      | name             |
      | TC.22132_partner |
    #And I should see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    And I should see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    And I stop masquerading
    When I act as partner by:
      | name                 |
      | TC.22132_sub_partner |
    #And I should not see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    And I should not see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    When I stop masquerading
    And I search and delete partner account by TC.22132_sub_partner
    And I search and delete partner account by TC.22132_partner

  @TC.22133 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 22133 Admins Without Change Payment Capability Cannot View Dunning Notification
    When I add a new MozyEnterprise partner:
      | period | users    |
      | 24     | 2        |
    Then New partner should be created
    And I get partner aria id
    And API* I change the Aria account status by newly created partner aria id to 11
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    And I act as newly created partner account
    And I should see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name | Type                            | Parent     |
      | role | <%=@partner.company_info.name%> | Enterprise |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name   | Roles |
      | ATC696 | role  |
    When I view the admin details of ATC696
    And I act as latest created admin
    And I should not see message Your account is past due - Please update your billing information to avoid any interruption in service. on the top
    When I stop masquerading from subpartner
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16110 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 16110 BILL.111500 update credit card in bus when the account is suspended
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 500 GB    |
    Then New partner should be created
    #And I wait for 40 seconds
    When I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
    #And I wait for 10 seconds
    And I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then the MozyPro account plan should be changed
    # Added step - we need to stop masquerading and then re-act as
    And I stop masquerading
    And API* I change the Aria account status by newly created partner aria id to -1
    #And I wait for 10 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    # Added step - re act as the partner
    When I search partner by:
      | name          |
      | @company_name |
    When I view partner details by newly created partner company name
    Given I act as newly created partner account
    When I navigate to Change Payment Information section from bus admin console page
    Then Change payment information message should be Your account is backup-suspended. You will not be able to access your account until your credit card is billed.
    #Assign to CyberSource Credit Card
    And API* I assign the Aria account by newly created partner aria id to collections account group 10026095
    #And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 22          | 123 |
    And I save payment information changes
    Then Payment information should be updated
#    And I wait for 10 seconds
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16113 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 16113 BILL.111500 update credit card in aria and a charge will be attempted for the entire balance
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 500 GB    |
    Then New partner should be created
#    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
#    And I wait for 10 seconds
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then the MozyPro account plan should be changed
    And API* Aria account payment is Failed
    #Assign to CyberSource Credit Card
    When API* I assign the Aria account by newly created partner aria id to collections account group 10026095
#    And I wait for 10 seconds
    And API* I update payment information to:
      | payment method | cc number        | expire month | expire year |
      | 1              | 4111111111111111 | 12           | 2022        |
#    And I wait for 10 seconds
    And API* Aria account payment is Approved
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16114 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 16114 Verify update credit card in bus and a charge will be attempted for the entire balance
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 500 GB    |
    Then New partner should be created
#    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
#    And I wait for 10 seconds
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account payment is Failed
    #Assign to CyberSource Credit Card
    When API* I assign the Aria account by newly created partner aria id to collections account group 10026095
#    And I wait for 10 seconds
    And I navigate to Change Payment Information section from bus admin console page
    And I update credit card information to:
      | cc name       | cc number        | expire month | expire year | cvv |
      | new card name | 4111111111111111 | 12           | 22          | 123 |
    And I save payment information changes
    Then Payment information should be updated
#    And I wait for 10 seconds
    And API* Aria account payment is Approved
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.16150 @bus @notify_about_and_collect_past-due_balances @tasks_p3
  Scenario: 16150 BILL.115000 Verify account reinstate from suspended state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
#    And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
#    And I wait for 10 seconds
    When I act as newly created partner account
    And I change account subscription to annual billing period!
    Then Subscription changed message should be Your account has been changed to yearly billing.
    When API* I change the Aria account status by newly created partner aria id to -1
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | SUSPENDED    |
    #Assign to CyberSource Credit Card
    When API* I assign the Aria account by newly created partner aria id to collections account group 10026095
#    And I wait for 10 seconds
    And API* I update payment information to:
      | payment method | cc number        | expire month | expire year |
      | 1              | 4111111111111111 | 12           | 2022        |
#    And I wait for 10 seconds
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
