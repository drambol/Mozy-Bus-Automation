Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
  # info to be added here: coverage matrix

  #
  # 50 GB Cases
  #
  @TC.13462  @regression_test @phoenix @mozyhome @email
  Scenario: 13462 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    #steps for email-verification & account-access
    And the user has activated their account
    And I login as the user on the account.
    And I verify the user account.
    #step to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly | 50 GB       | $5.99      |
    And I delete user

    #steps for email-verification & account-access
    #And the user has activated their account
    #And I login as the user on the account.
    #And I verify the user account.

@TC.13463  @regression_test @phoenix @mozyhome @email
  Scenario: 13463 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual  | $65.89 | 1        | $65.89 |
      | Total Charge                          |        |          | $65.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #step to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                               | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, yearly | 50 GB       | $65.89     |
    And I delete user

  @TC.13464  @regression_test @phoenix @mozyhome @email
  Scenario: 13464 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, biennial | 50 GB       | $125.79    |
    And I delete user

  @TC.13468  @regression_test @phoenix @mozyhome @email
  Scenario: 13468 Add a new IE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                           | Price             | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | €4.99\n(inc. VAT) | 1        | €4.99  |
      | Subscription Price                    |                   |          | €4.06  |
      | VAT Rate (23%)                        |                   |          | €0.93  |
      | Total Charge                          |                   |          | €4.99  |
    Then the user is successfully added.
  #steps for email-verification & account-access
    And the user has activated their account
    And I login as the user on the account.
    And I verify the user account.
  #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly | 50 GB       | €4.99      |
    And I delete user

  @TC.13469  @regression_test @phoenix @mozyhome @email
  Scenario: 13469 Add a new IE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 12      | 50 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                          | Price              | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | €54.89\n(inc. VAT) | 1        | €54.89 |
      | Subscription Price                   |                    |          | €44.63 |
      | VAT Rate (23%)                       |                    |          | €10.26 |
      | Total Charge                         |                    |          | €54.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                               | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, yearly | 50 GB       | €54.89     |
    And I delete user

  @TC.13470  @regression_test @phoenix @mozyhome @email
  Scenario: 13470 Add a new IE biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 50 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                            | Price               | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | €104.79\n(inc. VAT) | 1        | €104.79 |
      | Subscription Price                     |                     |          | €85.20  |
      | VAT Rate (23%)                         |                     |          | €19.59  |
      | Total Charge                           |                     |          | €104.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, biennial | 50 GB       | €104.79    |
    And I delete user

  @TC.13467  @regression_test @phoenix @mozyhome @email
  Scenario: 13467 Add a new UK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 50 GB     | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                           | Price             | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | £4.99\n(inc. VAT) | 1        | £4.99  |
      | Subscription Price                    |                   |          | £4.16  |
      | VAT Rate (20%)                        |                   |          | £0.83  |
      | Total Charge                          |                   |          | £4.99  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly | 50 GB       | £4.99      |
    And I delete user

  @TC.13471  @regression_test @phoenix @mozyhome @email
  Scenario: 13471 Add a new UK yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 50 GB     | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                          | Price              | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Annual | £54.89\n(inc. VAT) | 1        | £54.89 |
      | Subscription Price                   |                    |          | £45.74 |
      | VAT Rate (20%)                       |                    |          | £9.15  |
      | Total Charge                         |                    |          | £54.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                               | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, yearly | 50 GB       | £54.89     |
    And I delete user

  @TC.13472  @regression_test @phoenix @mozyhome @email
  Scenario: 13472 Add a new UK biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 24     | 50 GB     | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                            | Price               | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | £104.79\n(inc. VAT) | 1        | £104.79 |
      | Subscription Price                     |                     |          | £87.32  |
      | VAT Rate (20%)                         |                     |          | £17.47  |
      | Total Charge                           |                     |          | £104.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, biennial | 50 GB       | £104.79    |
    And I delete user

  @TC.13465  @regression_test @phoenix @mozyhome @email
  Scenario: 13465 Add a new DE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 GB     | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                            | Preis             | Menge | Betrag |
      | MozyHome 50 GB (1 Computer) - Monatlich | 4,99€\n(inc. VAT) | 1     | 4,99€  |
      | Abonnementpreis                         |                   |       | 4,19€  |
      | Umsatzsteuersatz (19%)                  |                   |       | 0,80€  |
      | Gesamtbelastung                         |                   |       | 4,99€  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, monthly | 50 GB       | €4.99      |
    And I delete user

  @TC.13476  @regression_test @phoenix @mozyhome @email
  Scenario: 13476 Add a new DE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 12      | 50 GB     | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                           | Preis              | Menge | Betrag |
      | MozyHome 50 GB (1 Computer) - jährlich | 54,89€\n(inc. VAT) | 1     | 54,89€ |
      | Abonnementpreis                        |                    |       | 46,13€ |
      | Umsatzsteuersatz (19%)                 |                    |       | 8,76€  |
      | Gesamtbelastung                        |                    |       | 54,89€ |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      # as this is on EN-US dom, will show as EN amount representation
      | Subscription                               | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, yearly | 50 GB       | €54.89     |
    And I delete user

  @TC.13475  @regression_test @phoenix @mozyhome @email
  Scenario: 13475 Add a new DE biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 50 GB     | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                          | Preis               | Menge | Betrag  |
      | MozyHome 50 GB (1 Computer) - 2-Jahre | 104,79€\n(inc. VAT) | 1     | 104,79€ |
      | Abonnementpreis                       |                     |       | 88,06€  |
      | Umsatzsteuersatz (19%)                |                     |       | 16,73€  |
      | Gesamtbelastung                       |                     |       | 104,79€ |
    Then the user is successfully added.
  #steps for email-verification & account-access
    And the user has activated their account
    And I login as the user on the account.
    And I verify the user account.
  #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 50 GB, + 0 GB, 1 machines, biennial | 50 GB       | €104.79    |
    And I delete user

  @TC.13466  @regression_test @phoenix @mozyhome @email
  Scenario: 13466 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | Prix              | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT) | 1        | 4,99€   |
      | Prix d'abonnement                       |                   |          | 4,16€   |
      | Taux de TVA (20%)                       |                   |          | 0,83€   |
      | Montant total des frais                 |                   |          | 4,99€   |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 Go, + 0 GB, 1 machines, monthly | 50 GB       | €4.99      |
    And I delete user

  @TC.13474  @regression_test @phoenix @mozyhome @email
  Scenario: 13474 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 12      | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | Prix               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                      |                    |          | 45,74€  |
      | Taux de TVA (20%)                      |                    |          | 9,15€   |
      | Montant total des frais                |                    |          | 54,89€  |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                               | Total Quota | Total Cost |
      | MozyHome 50 Go, + 0 GB, 1 machines, yearly | 50 GB       | €54.89     |
    And I delete user

  @TC.13473  @regression_test @phoenix @mozyhome @email
  Scenario: 13473 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 50 Go, + 0 GB, 1 machines, biennial | 50 GB       | €104.79    |
    And I delete user

#
# 125 GB Cases
#
  @TC.13477  @regression_test @phoenix @mozyhome @email
  Scenario: 13477 Add a new US monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                   | Price | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99 | 1        | $9.99  |
      | Total Charge                                  |       |          | $9.99  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, monthly | 125 GB      | $9.99      |
    And I delete user

  @TC.13483  @regression_test @phoenix @mozyhome @email
  Scenario: 13483 Add a new US yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 12     | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, yearly | 125 GB      | $109.89    |
    And I delete user

  @TC.13482  @regression_test @phoenix @mozyhome @email
  Scenario: 13482 Add a new US biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 24     | 125 GB    | United States |
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | Total Charge                                   |         |          | $209.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                  | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, biennial | 125 GB      | $209.79    |
    And I delete user

  @TC.13478  @regression_test @phoenix @mozyhome @email
  Scenario: 13478 Add a new IE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan  | country | billing country | cc number        |
      | 1      | 125 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                                   | Price             | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | €8.99\n(inc. VAT) | 1        | €8.99  |
      | Subscription Price                            |                   |          | €7.31  |
      | VAT Rate (23%)                                |                   |          | €1.68  |
      | Total Charge                                  |                   |          | €8.99  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, monthly | 125 GB      | €8.99      |
    And I delete user

  @TC.13485  @regression_test @phoenix @mozyhome @email
  Scenario: 13485 Add a new IE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan  | country | billing country | cc number        |
      | 12      | 125 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                                  | Price              | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Annual | €98.89\n(inc. VAT) | 1        | €98.89 |
      | Subscription Price                           |                    |          | €80.40 |
      | VAT Rate (23%)                               |                    |          | €18.49 |
      | Total Charge                                 |                    |          | €98.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, yearly | 125 GB      | €98.89     |
    And I delete user

  @TC.13484  @regression_test @phoenix @mozyhome @email
  Scenario: 13484 Add a new IE biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan  | country | billing country | cc number        |
      | 24      | 125 GB     | Ireland | Ireland         | 4319402211111113 |
    Then the billing summary looks like:
      | Description                                    | Price               | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | €188.79\n(inc. VAT) | 1        | €188.79 |
      | Subscription Price                             |                     |          | €153.49 |
      | VAT Rate (23%)                                 |                     |          | €35.30  |
      | Total Charge                                   |                     |          | €188.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                  | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, biennial | 125 GB      | €188.79    |
    And I delete user

  @TC.13479  @regression_test @phoenix @mozyhome @email
  Scenario: 13479 Add a new UK monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 125 GB    | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                   | Price             | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | £7.99\n(inc. VAT) | 1        | £7.99  |
      | Subscription Price                            |                   |          | £6.66  |
      | VAT Rate (20%)                                |                   |          | £1.33  |
      | Total Charge                                  |                   |          | £7.99  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, monthly | 125 GB      | £7.99      |
    And I delete user

  @TC.13487  @regression_test @phoenix @mozyhome @email
  Scenario: 13487 Add a new UK yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 125 GB    | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                  | Price              | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Annual | £87.89\n(inc. VAT) | 1        | £87.89 |
      | Subscription Price                           |                    |          | £73.24 |
      | VAT Rate (20%)                               |                    |          | £14.65 |
      | Total Charge                                 |                    |          | £87.89 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, yearly | 125 GB      | £87.89     |
    And I delete user

  @TC.13486  @regression_test @phoenix @mozyhome @email
  Scenario: 13486 Add a new UK biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 24     | 125 GB    | United Kingdom | United Kingdom  | 4916783606275713 |
    Then the billing summary looks like:
      | Description                                    | Price               | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | £167.79\n(inc. VAT) | 1        | £167.79 |
      | Subscription Price                             |                     |          | £139.82 |
      | VAT Rate (20%)                                 |                     |          | £27.97  |
      | Total Charge                                   |                     |          | £167.79 |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
      | Subscription                                  | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, biennial | 125 GB      | £167.79    |
    And I delete user

  @TC.13481  @regression_test @phoenix @mozyhome @email
  Scenario: 13481 Add a new DE monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                                    | Preis             | Menge | Betrag |
      | MozyHome 125 GB (Bis zu 3 Computer) - Monatlich | 8,99€\n(inc. VAT) | 1     | 8,99€  |
      | Abonnementpreis                                 |                   |       | 7,55€  |
      | Umsatzsteuersatz (19%)                          |                   |       | 1,44€  |
      | Gesamtbelastung                                 |                   |       | 8,99€  |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, monthly | 125 GB      | €8.99      |
    And I delete user

  @TC.13491  @regression_test @phoenix @mozyhome @email
  Scenario: 13491 Add a new DE yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 12      | 125 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                                   | Preis              | Menge | Betrag |
      | MozyHome 125 GB (Bis zu 3 Computer) - jährlich | 98,89€\n(inc. VAT) | 1     | 98,89€ |
      | Abonnementpreis                                |                    |       | 83,10€ |
      | Umsatzsteuersatz (19%)                         |                    |       | 15,79€ |
      | Gesamtbelastung                                |                    |       | 98,89€ |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, yearly | 125 GB      | €98.89     |
    And I delete user

  @TC.13492  @regression_test @phoenix @mozyhome @email
  Scenario: 13492 Add a new DE biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 125 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the billing summary looks like:
      | Beschreibung                                  | Preis               | Menge | Betrag  |
      | MozyHome 125 GB (Bis zu 3 Computer) - 2-Jahre | 188,79€\n(inc. VAT) | 1     | 188,79€ |
      | Abonnementpreis                               |                     |       | 158,65€ |
      | Umsatzsteuersatz (19%)                        |                     |       | 30,14€  |
      | Gesamtbelastung                               |                     |       | 188,79€ |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                  | Total Quota | Total Cost |
      | MozyHome 125 GB, + 0 GB, 3 machines, biennial | 125 GB      | €188.79    |
    And I delete user

  @TC.13480  @regression_test @phoenix @mozyhome @email
  Scenario: 13480 Add a new FR monthly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | Prix              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | Prix d'abonnement                                 |                   |          | 7,49€   |
      | Taux de TVA (20%)                                 |                   |          | 1,50€   |
      | Montant total des frais                           |                   |          | 8,99€   |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 Go, + 0 GB, 3 machines, monthly | 125 GB      | €8.99      |
    And I delete user

  @TC.13488  @regression_test @phoenix @mozyhome @email
  Scenario: 13488 Add a new FR yearly basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 12      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | Prix               | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€\n(inc. VAT) | 1        | 98,89€  |
      | Prix d'abonnement                                |                    |          | 82,41€  |
      | Taux de TVA (20%)                                |                    |          | 16,48€  |
      | Montant total des frais                          |                    |          | 98,89€  |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                | Total Quota | Total Cost |
      | MozyHome 125 Go, + 0 GB, 3 machines, yearly | 125 GB      | €98.89     |
    And I delete user

  @TC.13489  @regression_test @phoenix @mozyhome @email
  Scenario: 13489 Add a new FR biennial basic MozyHome user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period  | base plan | country | billing country | cc number        |
      | 24      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                         | Prix                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                   |                     |          | 157,32€ |
      | Taux de TVA (20%)                                   |                     |          | 31,47€  |
      | Montant total des frais                             |                     |          | 188,79€ |
    And the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #steps to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          | Country: |
      | @partner (change) | @country |
    And MozyHome subscription details should be:
    # as this is on EN-US dom, will show as EN amount representation
      | Subscription                                 | Total Quota | Total Cost |
      | MozyHome 125 Go, + 0 GB, 3 machines, biennial | 125 GB      | €188.79    |
    And I delete user

  #-- FREE ACCT SIGNUP --
  #--technically we have only one case for this (us)
  @TC.3573  @regression_test @phoenix @mozyhome @free @email
  Scenario: 3573 Add a new US monthly free MozyHome user
    When I am at dom selection point:
    And I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    #steps for email-verification & account-access
      And the user has activated their account
      And I login as the user on the account.
      And I verify the user account.
    #step to verify in bus admin console
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And MozyHome user details should be:
      | Partner:          |
      | @partner (change) |
    And MozyHome subscription details should be:
      | Subscription     |
      | No subscriptions |
    And I delete user
