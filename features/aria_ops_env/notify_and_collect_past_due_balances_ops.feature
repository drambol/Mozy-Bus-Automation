Feature: Notify about and collect past-due balances, running on ops env (pantheon / staging)

  Subscription:
    - As a Mozy sales or finance representative
    - I want to provide ample notification when a customer is past-due
    - so that customers have as much opportunity as possible to make their account current before Mozy disables and eventually removes their service.

  Background:
    Given I log in bus admin console as administrator

  @TC.16107 @ops_env
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


  @TC.17877 @ops_env
  Scenario: 17877 MozyPro account with server plan suspended in aria should be backup-suspended in bus
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    And I wait for 20 seconds
    And API* I change the Aria account status by newly created partner aria id to -1
    And I wait for 20 seconds
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


  @TC.16165 @ops_env
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
      | from                    | subject                               | after | content                             |
      | AccountManager@mozy.com | [Mozy] Mozy invoice, due upon receipt | today | <%=@partner.admin_info.first_name%> |
    Then I should see 1 email(s)
    # workaround - act as the partner first. Can't see billing info by clicking the link on partner details directly
    #When I click Billing Info link to show the details
    When I act as newly created partner account
    Then I should see message Your account is past due - Please pay your most recent invoice to avoid any interruption in service. on the top
    And I navigate to Billing Information section from bus admin console page
    Then Account Status table should be:
      | Status                                                                                               |
      | Your account is past due - Please pay your most recent invoice to avoid any interruption in service. |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.22132 @ops_env
  Scenario: 22132 Sub Partners Cannot View Parents Dunning Notice
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


  @TC.16113 @ops_env
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


  @TC.16150 @ops_env
  Scenario: 16150 BILL.115000 Verify account reinstate from suspended state if charge goes through
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
#   And I wait for 40 seconds
    And I get partner aria id
    #Assign to Fail Test CAG
    And API* I assign the Aria account by newly created partner aria id to collections account group 10030097
#   And I wait for 10 seconds
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
#   And I wait for 10 seconds
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
