Feature: manage invoice comm settings, running on ops env (pantheon / staging)

    Subscription:
      - As a Mozy Administrator,
      - I want to configure whether or not I want to receive account statements by email,
      - so that I'm not bothered by extra email

  Background:
    Given I log in bus admin console as administrator


  @TC.132019 @ops_env
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
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
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


  @TC.132020 @ops_env
  Scenario: Mozy-132020: mozypro net terms partner shouldn't have option "Receive Mozy Account Statements?"
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
    # Aria configuration issue, work with Ken McCarthy on it.
    # And API* Aria account notification template group should be nil
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
    And I wait for 1200 seconds for email search if in outlook
    Given I identify the email is sent from aria
    And I wait for 10 seconds
    When I search emails by keywords:
      | from        | subject                                      | content          |
      | ar@mozy.com | Mozy International Limited Account Statement | @company_address |
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
      | from                    | subject                                  | after | content                              |
      | AccountManager@mozy.com | [Mozy] Mozy subscription invoice overdue | today | <%=@partner.credit_card.first_name%> |
    Then I should see 1 email(s)

    When I stop masquerading
    Then I search and delete partner account by newly created partner company name