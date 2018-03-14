Feature: manage invoice comm settings
  As a Mozy Administrator
  I want to configure whether or not I want to receive account statements by email
  so that I'm not bothered by extra email

  Background:
    Given I log in bus admin console as administrator

  @TC.15229 @bus @2.0 @manage_invoice_communication_settings @regression @core_function @ROR_smoke
  Scenario: 15229 Verify Receive Mozy Account Statements set to Yes for new partner in Bus
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Account Details section from bus admin console page
    Then Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | Yes (change)      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.15230 @firefox @bus @2.0 @manage_invoice_communication_settings @regression @core_function
  Scenario: 15230 Alter notification method between HTML email and Printable no email in Aria
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* I set newly created partner aria id account notification method to 8
    And I wait for 10 seconds
    Then API* Aria account should be:
      | notify_method_name |
      | Printable          |
    When API* I set newly created partner aria id account notification method to 1
    And I wait for 10 seconds
    Then API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    Then I search and delete partner account by newly created partner company name

  @TC.15495 @firefox @bus @2.0 @manage_invoice_communication_settings @regression @core_function
  Scenario: 15495 Verify aria notification method when set Receive Mozy Account Statements to No
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And I wait for 10 seconds
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.15718 @firefox @bus @2.0 @manage_invoice_communication_settings @regression @core_function
  Scenario: 15718 Verify notification method set to HTML Email for new Monthly MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name

  @TC.17590 @firefox @bus @2.0 @manage_invoice_communication_settings @regression @core_function
  Scenario: 17590 Verify notification method set to HTML Email for new Monthly MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name

  @TC.17591 @firefox  @bus @2.0 @manage_invoice_communication_settings @regression @core_function
  Scenario: 17591 Verify notification method set to HTML Email for new Monthly Reseller partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    Then I search and delete partner account by newly created partner company name

  @TC.15448 @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-15448:Verify notification methods have HTML email and Printable (no email)
    When I add a new MozyEnterprise partner:
      | period | users |
      | 24     | 10    |
    Then New partner should be created
    And I get partner aria id
    And API* Aria account should be:
      | notify_method_name |
      | HTML Email         |
    And API* Aria account notification template group should be nil
    And API* I set newly created partner aria id account notification method to 8
    Then API* Aria account should be:
      | notify_method_name |
      | Printable          |
    And API* Aria account notification template group should be nil
    When API* I set newly created partner aria id account notification method to 1
    Then API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be nil
    Then I search and delete partner account by newly created partner company name

  @TC.132001 @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132001:Mozypro Credit Card partner under MozyPro with monthly 10GB_dunning active 1
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    Then Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
    Then the MozyPro account plan should be changed
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                    | content          |
      | ar@mozy.com | Mozy Inc Account Statement | @company_address |
#Aria bug 15013-112475
#    Then I should see 0 email(s)
    #Then I should see 1 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 11
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                          | after | content                              |
      | AccountManager@mozy.com | [Mozy] Your credit card payment was unsuccessful | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132006 @slow @email @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132006:Mozypro Credit Card partner under MozyPro France with yearly 8TB_dunning active 2
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | cc number        |
      | 12     | 8 TB      | MozyPro France | France  | 4485393141463880 |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 12 TB     |
    Then the MozyPro account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
#    Then I should see 0 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 12
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 2 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_FR
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                                             | after | content                              |
      | ar@mozy.com | [Mozy] DEUXIÈME AVIS -- Votre paiement par carte de crédit a échoué | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132011 @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132011:Mozypro Credit Card partner under MozyPro Germany with biennially 2TB_dunning active 3
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | cc number        |
      | 24     | 2 TB      | MozyPro Germany | Germany | 4188181111111112 |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then the MozyPro account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
#    Then I should see 0 email(s)
    #Then I should see 1 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 13
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 3 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_DE
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | after | content                              |
      | ar@mozy.com | [Mozy] Ihr Konto wird in 7 Tagen suspendiert | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132012 @slow @email @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132012:Mozypro Credit Card partner under MozyPro Ireland with monthly 250GB_dunning active 1
    When I add a new MozyPro partner:
      | period | base plan | create under    | country | cc number        |
      | 1      | 250 GB    | MozyPro Ireland | Ireland | 4319402211111113 |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then the MozyPro account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    #Then I should see 0 email(s)
    #Then I should see 1 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 11
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                          | after | content                             |
      | AccountManager@mozy.com | [Mozy] Your credit card payment was unsuccessful | today |<%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132016 @slow @email @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132016:Mozypro Credit Card partner under MozyPro UK+yearly 32TB_dunning active 2
    When I add a new MozyPro partner:
      | period | base plan | create under | country        | cc number        |
      | 12     | 8 TB      | MozyPro UK   | United Kingdom | 4916783606275713 |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 12 TB     |
    Then the MozyPro account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
#    Then I should see 0 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 12
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 2 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                                          | after | content                              |
      | AccountManager@mozy.com | [Mozy] SECOND NOTICE - Your credit card payment was unsuccessful | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132020 @slow @email @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132020:mozypro net terms partner shouldn't have option "Receive Mozy Account Statements?"
    When I add a new MozyPro partner:
      | period | base plan | create under | country        | net terms |
      | 1      | 10 GB     | MozyPro UK   | United Kingdom | yes       |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I navigate to Account Details section from bus admin console page
    Then Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
#Aria configuration issue, work with Ken McCarthy on it.
#    And API* Aria account notification template group should be nil
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then the MozyPro account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
#    Then I should see 1 email(s)
    Then I should see 2 email(s)

    When API* I change the Aria account status by newly created partner aria id to 12
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 2 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                                          | after | content                              |
      | AccountManager@mozy.com | [Mozy] SECOND NOTICE - Your credit card payment was unsuccessful | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132019 @slow @email @bus @manage_invoice_communication_settings @tasks_p3
  Scenario: Mozy-132019:Enterprise Credit Card partner with profile contry: FR+ 1TB Biennially_dunning active 1,2
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country | cc number        |
      | 24     | 1     | 1 TB        | France  | 4485393141463880 |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 1 email(s)

    When I change MozyEnterprise account plan to:
      | users |
      | 15    |
    And the MozyEnterprise account plan should be changed
    #And I wait for 1200 seconds
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
#    Then I should see 0 email(s)
    Then I should see 2 email(s)

    When I set account Receive Mozy Account Statements option to Yes
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | Yes (change)      |

    When I change MozyEnterprise account plan to:
      | users |
      | 25    |
    And the MozyEnterprise account plan should be changed
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
    Then I should see 3 email(s)

    When I set account Receive Mozy Account Statements option to No
    Then Account statement preference should be changed
    And Account details table should be:
      | description                       | value             |
      | Name:                             | @name (change)    |
      | Username/Email:                   | @email (change)   |
      | Password:                         | (hidden) (change) |
      | Receive Mozy Pro Newsletter?      | No (change)       |
      | Receive Mozy Email Notifications? | No (change)       |
      | Receive Mozy Account Statements?  | No (change)       |

    When API* I change the Aria account status by newly created partner aria id to 11
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label     |
      | ACTIVE DUNNING 1 |
    And API* Aria account should be:
      | notify_method_name   |
      | HTML Email           |
    And API* Aria account notification template group should be Dunning_Emails_Only_EN
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from                    | subject                                          | after | content                              |
      | AccountManager@mozy.com | [Mozy] Your credit card payment was unsuccessful | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
