Feature: MozyHome user upgrades from free to paid through phoenix

  As a MozyHome free user
  I want to upgrade from free to paid
  So that I can have more storage and computers for backup

  Background:
   Given I am at dom selection point:

  #
  # FR VAT applied
  #
  @TC.124184 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.124184 Upgrade FR MozyHome free user to paid with 50 GB Monthly additional storage
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country | cc number        |
      | 1       | 50 Go     | 1            | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                             | Prix              | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT) | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT) | 1        | 2,00€   |
      | Prix d'abonnement                       |                   |          | 5,82€   |
      | Taux de TVA (20%)                       |                   |          | 1,17€   |
      | Montant total des frais                 |                   |          | 6,99€   |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 20 Go             |
      | Ordinateurs :                      | 1                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant:                           | 5,82€             |
      | Taux de TVA (20%):                 | 1,17€             |
      | Total :                            | 6,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124185 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.124185 Upgrade FR MozyHome free user to paid with 50 GB Yearly
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country | cc number        |
      | 12      | 50 Go     | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Prix               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                      |                    |          | 45,74€  |
      | Taux de TVA (20%)                      |                    |          | 9,15€   |
      | Montant total des frais                |                    |          | 54,89€  |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go   |
      | Espace de stockage supplémentaire :| 0 Go             |
      | Ordinateurs :                      | 1                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant:                           | 45,74€           |
      | Taux de TVA (20%):                 | 9,15€            |
      | Total :                            | 54,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124186 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.124186 Upgrade FR MozyHome free user to paid with 125 GB Biennial additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country | cc number        |
      | 24      | 125 Go    | 2              | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                         | Prix                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Ordinateurs supplémentaires - Bisannuel             | 42,00€\n(inc. VAT)  | 2        | 84,00€  |
      | Prix d'abonnement                                   |                     |          | 227,32€ |
      | Taux de TVA (20%)                                   |                     |          | 45,47€  |
      | Montant total des frais                             |                     |          | 272,79€ |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant:                           | 227,32€           |
      | Taux de TVA (20%):                 | 45,47€            |
      | Total :                            | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124187 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: TC.124187 Upgrade FR MozyHome free user to paid with 50 GB Yearly additional storage promotional code
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | coupon       | billing country | cc number        |
      | 12      | 50 Go     |  10          | 10percentoff | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT)  | 1        | 54,89€  |
      | 20 Stockage supplémentaire - Annuel    | 22,00€\n(inc. VAT)  | 10       | 220,00€ |
      | 12 mois à 10.0 % de réduction          | -27,48€\n(inc. VAT) |          | -27,48€ |
      | Prix d'abonnement                      |                     |          | 206,17€ |
      | Taux de TVA (20%)                      |                     |          | 41,24€  |
      | Montant total des frais                |                     |          | 247,41€ |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go   |
      | Espace de stockage supplémentaire :| 200 Go           |
      | Ordinateurs :                      | 1                |
      | Abonnement :                       | Annuel           |
      | Remise : 	                       | 1 mois gratuit   |
      | Prochaine facture :                | @1 year from now |
      | Montant:                           | 229,07€          |
      | Taux de TVA (20%):                 | 45,82€           |
      | Total :                            | 274,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124188 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: TC.124188 Upgrade FR MozyHome free user to paid with 50 GB Biennial
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country | cc number        |
      | 24      | 50 Go     | Royaume-Uni     | 4916783606275713 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                               | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 1                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant:                           | 87,32€            |
      | Taux de TVA (20%):                 | 17,47€            |
      | Total :                            | 104,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124189 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: TC.124189 Upgrade FR MozyHome free user to paid with 125 GB Monthly additional Storage computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country | cc number        |
      | 1       | 125 Go    | 1            | 1              | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                       | Prix              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | 20 Stockage supplémentaire - Mensuel              | 2,00€\n(inc. VAT) | 1        | 2,00€   |
      | Ordinateurs supplémentaires - Mensuel             | 2,00€\n(inc. VAT) | 1        | 2,00€   |
      | Prix d'abonnement                                 |                   |          | 10,82€  |
      | Taux de TVA (20%)                                 |                   |          | 2,17€   |
      | Montant total des frais                           |                   |          | 12,99€  |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 20 Go             |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant:                           | 10,82€            |
      | Taux de TVA (20%):                 | 2,17€             |
      | Total :                            | 12,99€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124190 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: TC.124190 Upgrade FR MozyHome free user to paid with 50 GB Biennial additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country | cc number        |
      | 24      | 50 Go     |  4             | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel  | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Ordinateurs supplémentaires - Bisannuel    | 42,00€\n(inc. VAT)  | 4        | 168,00€ |
      | Prix d'abonnement                          |                     |          | 227,32€ |
      | Taux de TVA (20%)                          |                     |          | 45,47€  |
      | Montant total des frais                    |                     |          | 272,79€ |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 50 Go    |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Remise : 	                       | 3 mois gratuits   |
      | Prochaine facture :                | @2 years from now |
      | Montant:                           | 227,32€           |
      | Taux de TVA (20%):                 | 45,47€            |
      | Total :                            | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124191 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: TC.124191 Upgrade FR MozyHome free user to paid with 125 GB Monthly
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country | cc number        |
      | 1       |  125 Go   | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                       | Prix              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | Prix d'abonnement                                 |                   |          | 7,49€   |
      | Taux de TVA (20%)                                 |                   |          | 1,50€   |
      | Montant total des frais                           |                   |          | 8,99€   |
    And the current plan summary looks like:
      | Plan de base :                     | MozyHome 125 Go   |
      | Espace de stockage supplémentaire :| 0 Go              |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant:                           | 7,49€             |
      | Taux de TVA (20%):                 | 1,50€             |
      | Total :                            | 8,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

    @TC.124192 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent
    Scenario: TC.124192 Upgrade FR MozyHome free user to paid with 125 GB Yearly additional Storage computers promotional code
      When I add a phoenix Free user:
        | base plan | country |
        | free      | France  |
      Then the user is successfully added.
      And the user has activated their account
      And I login as the user on the account.
      And I upgrade my free account to:
        | period  | base plan | addl storage | addl computers | coupon       | billing country | cc number        |
        | 12      | 125 Go    | 5            | 2              | 10percentoff | France          | 4485393141463880 |
      Then upgrade from free to paid will be successful
      Then the billing summary looks like:
        | Description                                      | Prix                | Quantité | Montant |
        | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€\n(inc. VAT)  | 1        |  98,89€ |
        | 20 Stockage supplémentaire - Annuel              | 22,00€\n(inc. VAT)  | 5        | 110,00€ |
        | Ordinateurs supplémentaires - Annuel             | 22,00€\n(inc. VAT)  | 2        |  44,00€ |
        | 12 mois à 10.0 % de réduction                    | -25,28€\n(inc. VAT) |          | -25,28€ |
        | Prix d'abonnement                                |                     |          | 189,67€ |
        | Taux de TVA (20%)                                |                     |          | 37,94€  |
        | Montant total des frais                          |                     |          | 227,61€ |
      And the current plan summary looks like:
        | Plan de base :                     | MozyHome 125 Go  |
        | Espace de stockage supplémentaire :| 100 Go           |
        | Ordinateurs :                      | 5                |
        | Abonnement :                       | Annuel           |
        | Remise : 	                         | 1 mois gratuit   |
        | Prochaine facture :                | @1 year from now |
        | Montant:                           | 210,74€          |
        | Taux de TVA (20%):                 | 42,15€           |
        | Total :                            | 252,89€          |
      And the renewal plan summary is Same as current plan
      And I log in bus admin console as administrator
      And I search user by:
        | keywords       |
        | @mh_user_email |
      And I view user details by newly created MozyHome username
      And I delete user

  @TC.124193 @phoenix @mozyhome @profile_country=de @ip_country=de @billing_country=de
  Scenario: TC.124193 Upgrade DE MozyHome free user to paid with 50GB Yearly additional computers
    When I add a phoenix Free user:
      | base plan | country |
      | free      | Germany |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | country     | billing country | cc number        |
      | 12      | 50 GB     | 2              | Deutschland | Deutschland     | 4188181111111112 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Beschreibung                           | Preis              | Menge | Betrag |
      | MozyHome 50 GB (1 Computer) - jährlich | 54,89€\n(inc. VAT) | 1     | 54,89€ |
      | Zusätzliche Computer - jährlich        | 22,00€\n(inc. VAT) | 2     | 44,00€ |
      | Abonnementpreis                        |                    |       | 83,10€ |
      | Umsatzsteuersatz (19%)                 |                    |       | 15,79€ |
      | Gesamtbelastung                        |                    |       | 98,89€ |
    And the current plan summary looks like:
      | Basistarif: 	            | MozyHome 50 GB   |
      | Zusätzlicher Speicherplatz: | 0 GB             |
      | Computer:                   | 3                |
      | Abonnement: 	            | Jährlich         |
      | Laufzeit Rabatt: 	        | 1 Monat gratis   |
      | Nächste Rechnungsstellung:  | @1 year from now |
      | Betrag:                     | 83,10€           |
      | Umsatzsteuersatz (19%):     | 15,79€           |
      | Gesamt: 	                | 98,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124195 @phoenix @mozyhome @profile_country=uk @ip_country=de @billing_country=uk
  Scenario: TC.124195 Upgrade UK MozyHome free user to paid with 125 GB Yearly additional storage computers
    When I add a phoenix Free user:
      | base plan | country        |
      | free      | United Kingdom |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country | cc number        |
      | 12      | 125 GB    | 2            | 2              | United Kingdom  | 4916783606275713 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price              | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | £87.89\n(inc. VAT) | 1        | £87.89  |
      | 20 Additional Storage - Annual               | £19.25\n(inc. VAT) | 2        | £38.50  |
      | Additional Computers - Annual                | £19.25\n(inc. VAT) | 2        | £38.50  |
      | Subscription Price                           |                    |          | £137.41 |
      | VAT Rate (20%)                               |                    |          | £27.48  |
      | Total Charge                                 |                    |          | £164.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 40 GB            |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Amount:             | £137.41          |
      | VAT Rate (20%):     | £27.48           |
      | Total:              | £164.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # VAT not applicable
  #
  @TC.124196 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: TC.124196 Upgrade US MozyHome free user to paid with 50GB Two Year additional Storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 24      | 50 GB     | 5            | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | 20 Additional Storage - Biennial       | $42.00  | 5        | $210.00 |
      | Total Charge                           |         |          | $335.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 100 GB            |
      | Computers:          | 1                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $335.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124197 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: TC.124197 Upgrade US MozyHome free user to paid with 125GB Monthly promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | coupon       | billing country |
      | 1       | 125 GB    | 10percentoff | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | Subscription Price                            | $9.99  |          | $9.99  |
      | 1 month at 10.0% off                          | $-0.99 |          | $-0.99 |
      | Total Charge                                  |        |          | $9.00  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 0 GB              |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $9.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124198 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: TC.124198 Upgrade US MozyHome free user to paid with 125 GB Yearly additional computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country |
      | 12      | 125 GB    | 2              | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 |         |          | $153.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124199 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: TC.124199 Upgrade US MozyHome free user to paid with 50 GB Monthly additional storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country |
      | 1       | 50 GB     | 2            | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly  | $5.99 | 1        | $5.99  |
      | 20 Additional Storage - Monthly        | $2.00 | 2        | $4.00  |
      | Total Charge                           |       |          | $9.99  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 40 GB             |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $9.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124200 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: TC.124200 Upgrade US MozyHome free user to paid with 125 GB Yearly
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country |
      | 12      | 125 GB    | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | Total Charge                                 |         |          | $109.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 0 GB             |
      | Computers:          | 3                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $109.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124201 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us
  Scenario: TC.124201 Upgrade US MozyHome free user to paid with 125 GB Two Year additional storage computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | billing country |
      | 24      | 125 GB    | 3            | 1              | United States   |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 3        | $126.00 |
      | Additional Computers - Biennial                | $42.00  | 1        | $42.00  |
      | Total Charge                                   |         |          | $377.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 60 GB             |
      | Computers:          | 4                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $377.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124202 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @qa6_dependent
  Scenario: TC.124202 Upgrade US MozyHome free user to paid with 50 GB Yearly additional computer promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | coupon       |
      | 12      | 50 GB     | 3              | 10percentoff |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 3        | $66.00  |
      | Subscription Price                   | $131.89 |          | $131.89 |
      | 12 months at 10.0% off               | $-13.18 |          | $-13.18 |
      | Total Charge                         |         |          | $118.71 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 4                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $131.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124203 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us
  Scenario: TC.124203 Upgrade US MozyHome free user to paid with 125 GB Monthly additional storage computers
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers |
      | 1       | 125 GB    | 30           | 2              |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 30       | $60.00 |
      | Additional Computers - Monthly                | $2.00  | 2        | $4.00  |
      | Total Charge                                  |        |          | $73.99 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 600 GB            |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $73.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124205 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn @qa6_dependent
  Scenario: TC.124205 Upgrade US MozyHome free user to paid with 50 GB Monthly additional Storage promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country | coupon       | cc number        |
      | 1       | 50 GB     | 1            | China           | 10percentoff | 4357441111111222 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price  | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly  | $5.99  | 1        | $5.99  |
      | 20 Additional Storage - Monthly        | $2.00  | 1        | $2.00  |
      | Subscription Price                     | $7.99  |          | $7.99  |
      | 1 month at 10.0% off                   | $-0.79 |          | $-0.79 |
      | Total Charge                           |        |          | $7.20  |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB    |
      | Additional Storage: | 20 GB             |
      | Computers:          | 1                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $7.99             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124206 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
  Scenario: TC.124206 Upgrade US MozyHome free user to paid with 50 GB Yearly additional computer us jp cn
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country | cc number        |
      | 12      | 50 GB     | 4              | China           | 4357441111111222 |
   Then upgrade from free to paid will be successful
   Then the billing summary looks like:
      | Description                          | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89  | 1        | $65.89  |
      | Additional Computers - Annual        | $22.00  | 4        | $88.00  |
      | Total Charge                         |         |          | $153.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 0 GB             |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $153.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

   @TC.124207 @phoenix @mozyhome @profile_country=us @ip_country=jp @billing_country=cn
   Scenario: TC.124207 Upgrade US MozyHome free user to paid with 125 GB Two Year additional Storage
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country | cc number        |
      | 24      | 125 GB    | 11           | China           | 4357441111111222 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                    | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Biennial | $209.79 | 1        | $209.79 |
      | 20 Additional Storage - Biennial               | $42.00  | 11       | $462.00 |
      | Total Charge                                   |         |          | $671.79 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 220 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Biennial          |
      | Term Discount:      | 3 months free     |
      | Next Billing:       | @2 years from now |
      | Total:              | $671.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124208 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: TC.124208 Upgrade US MozyHome free user to paid with 50 GB Two Year
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country | cc number        |
      | 24      | 50 GB     | China           | 4357441111111222 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Biennial | $125.79 | 1        | $125.79 |
      | Total Charge                           |         |          | $125.79 |
    And the current plan summary looks like:
      | Base Plan:         | MozyHome 50 GB    |
      | Additional Storage:| 0 GB              |
      | Computers:         | 1                 |
      | Subscription:      | Biennial          |
      | Term Discount:     | 3 months free     |
      | Next Billing:      | @2 years from now |
      | Total:             | $125.79           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124209 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn @qa6_dependent
  Scenario: TC.124209 Upgrade US MozyHome free user to paid with 125 GB Monthly additional storage promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | coupon       | billing country | cc number        |
      | 1       | 125 GB    |  7           | 10percentoff | China           | 4357441111111222 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price  | Quantity | Amount |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99  | 1        | $9.99  |
      | 20 Additional Storage - Monthly               | $2.00  | 7        | $14.00 |
      | Subscription Price                            | $23.99 |          | $23.99 |
      | 1 month at 10.0% off                          | $-2.39 |          | $-2.39 |
      | Total Charge                                  |        |          | $21.60 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 140 GB            |
      | Computers:          | 3                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $23.99            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124210 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=cn
  Scenario: TC.124210 Upgrade US MozyHome free user to paid with 125 GB Yearly additional Computers storage us fr cn
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | addl storage | billing country | cc number        |
      | 12      | 125 GB    | 2              | 2            | China           | 4357441111111222 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                  | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Annual | $109.89 | 1        | $109.89 |
      | 20 Additional Storage - Annual               | $22.00  | 2        | $44.00  |
      | Additional Computers - Annual                | $22.00  | 2        | $44.00  |
      | Total Charge                                 |         |          | $197.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB  |
      | Additional Storage: | 40 GB            |
      | Computers:          | 5                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $197.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124211 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us
  Scenario: TC.124211 Upgrade US MozyHome free user to paid with 50 GB Two Year addl storage computer
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers |
      | 12      | 50 GB     | 1            | 1              |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                            | Price   | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual   | $65.89  | 1        | $65.89  |
      | 20 Additional Storage - Annual         | $22.00  | 1        | $22.00  |
      | Additional Computers - Annual          | $22.00  | 1        | $22.00  |
      | Total Charge                           |         |          | $109.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 20 GB            |
      | Computers:          | 2                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Total:              | $109.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124212 @phoenix @mozyhome @profile_country=us @ip_country=cn @billing_country=us @qa6_dependent
  Scenario: TC.124212 Upgrade US MozyHome free user to paid with 125 GB Monthly addl storage pc promotional code
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | addl computers | coupon       |
      | 1       | 125 GB    |  99          | 2              | 10percentoff |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                                   | Price   | Quantity | Amount  |
      | MozyHome 125 GB (Up to 3 computers) - Monthly | $9.99   | 1        | $9.99   |
      | 20 Additional Storage - Monthly               | $2.00   | 99       | $198.00 |
      | Additional Computers - Monthly                | $2.00   | 2        | $4.00   |
      | Subscription Price                            | $211.99 |          | $211.99 |
      | 1 month at 10.0% off                          | $-21.19 |          | $-21.19  |
      |Total Charge                                   |         |          | $190.80 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 125 GB   |
      | Additional Storage: | 1.9 TB            |
      | Computers:          | 5                 |
      | Subscription:       | Monthly           |
      | Next Billing:       | @1 month from now |
      | Total:              | $211.99           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # negative test case failed to upgrade from free to paid
  #
  @TC.124214 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=uk
  Scenario: TC.124214 Upgrade FR MozyHome free user to paid failed fr uk uk
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | addl storage | billing country | cc number        |
      | 1       | 125 Go    | 2              | 2            | Royaume-Uni     | 4916783606275713 |
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence. Cliquez ici pour changer votre pays de résidence

    """

@TC.124215 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=it
  Scenario: TC.124215 Upgrade FR MozyHome free user to paid failed fr uk it
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | billing country | cc number        |
      | 12      | 125 Go    | Italie          | 4916921703777575 |
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence. Cliquez ici pour changer votre pays de résidence

    """

 @TC.124216 @phoenix @mozyhome @profile_country=fr @ip_country=us @billing_country=us
  Scenario: TC.124216 Upgrade FR mozyhome free user to paid failed fr us us
    When I add a phoenix Free user:
      | base plan | country |
      | free      | France  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl computers | billing country | cc number        |
      | 24      | 50 Go     | 2              | États-Unis      | 4018121111111122 |
   Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence. Cliquez ici pour changer votre pays de résidence

    """

  @TC.124217 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=fr
  Scenario: TC.124217 Upgrade US MozyHome free user to paid failed us fr fr
    When I add a phoenix Free user:
      | base plan | country       |
      | free      | United States |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period  | base plan | addl storage | billing country | cc number        |
      | 12      | 50  GB    | 20           | France          | 4485393141463880 |
    Then billing details page error message should be:
    """
      The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence. Click here to update your country of residence
    """
    And I update profile country from link in billing page and upgrade again
      | profile country | billing country | cc number        |
      | France          | France          | 4485393141463880 |
    Then upgrade from free to paid will be successful
    Then the billing summary looks like:
      | Description                          | Price               | Quantity | Amount  |
      | MozyHome 50 GB (1 computer) - Annual | $65.89\n(inc. VAT)  | 1 	      | $65.89  |
      | 20 Additional Storage - Annual 	     | $22.00\n(inc. VAT)  | 20       | $440.00 |
      | Subscription Price                   |                     |          | $421.57 |
      | VAT Rate (20%)                       |                     |          | $84.32  |
      | Total Charge  	                     |                     |	      | $505.89 |
    And the current plan summary looks like:
      | Base Plan:          | MozyHome 50 GB   |
      | Additional Storage: | 400 GB           |
      | Computers:          | 1                |
      | Subscription:       | Yearly           |
      | Term Discount:      | 1 month free     |
      | Next Billing:       | @1 year from now |
      | Amount:             | $421.57          |
      | VAT Rate (20%):     | $84.32           |
      | Total: 	            | $505.89          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124218 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=it
  Scenario: TC.124218 Upgrade US MozyHome free user to paid failed us fr it
    When I add a phoenix Free user:
      | base plan | country        |
      | free      | United States  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my free account to:
      | period | base plan | billing country | cc number        |
      | 1      | 50 GB     | Italy           | 4916921703777575 |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence. Click here to update your country of residence
    """