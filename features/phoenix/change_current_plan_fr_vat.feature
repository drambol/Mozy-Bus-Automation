Feature: MozyHome user changes current plan in phoenix

  As a private citizen
  I want to create current plan through phoenix

  #Background:
  # info to be added here: coverage matrix

#---------------------------------------------------------------------------------
# precondition
# ssh root@phoenix01.qa6.mozyops.com  QAP@SSw0rd
# /var/www/phoenix/app/controllers/account_controller.rb
# /var/www/phoenix/app/controllers/registration_controller.rb
# IpCountry.country_with_ip(request.remote_ip)
# set to 'FR' if @ip_country=fr
# restart: /etc/init.d/apache2 restart
#---------------------------------------------------------------------------------

  #
  #  50 Go Cases
  #

  @TC.124539 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124539 Add FR 50 GB monthly MozyHome user change to 125 GB
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX              | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT) | 1        | 4,99€   |
      | Prix d'abonnement                       |                   |          | 4,16€   |
      | Taux de TVA (20%)                       |                   |          | 0,83€   |
      | Montant total des frais                 |                   |          | 4,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 Go    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 7,49€             |
      | Taux de TVA (20%):                 | 1,50€             |
      | Total : 	                       | 8,99€             |
      | Coût au pro rata: 	               | 3,33€             |
      | Taux de TVA (20%):                 | 0,67€             |
      | Total : 	                       | 4,00€             |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 7,49€             |
      | Taux de TVA (20%):   	            | 1,50€             |
      | Total :                             | 8,99€             |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124540 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124540 Add FR 50 GB yearly MozyHome user change to 125 GB
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | Taux de TVA (20%)                       |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 Go    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 125 Go           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 82,41€           |
      | Taux de TVA (20%):                 | 16,48€           |
      | Total : 	                       | 98,89€           |
      | Coût au pro rata: 	               | 36,67€           |
      | Taux de TVA (20%):                 | 7,33€            |
      | Total : 	                       | 44,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 82,41€           |
      | Taux de TVA (20%):   	            | 16,48€           |
      | Total :                             | 98,89€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124541 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124541 Add FR 50 GB biennial MozyHome user change to addl PC storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 5              | 2            |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go             |
      | Espace de stockage supplémentaire :| 2 x 20 Go         |
      | Espace total de stockage :         | 90 Go             |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 297,32€           |
      | Taux de TVA (20%):                 | 59,47€            |
      | Total : 	                       | 356,79€           |
      | Coût au pro rata: 	               | 210,00€           |
      | Taux de TVA (20%):                 | 42,00€            |
      | Total : 	                       | 252,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 40 Go             |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 297,32€           |
      | Taux de TVA (20%):   	            | 59,47€            |
      | Total :                             | 356,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.124542 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124542 Add FR 125 GB monthly MozyHome user change to addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1          | 8,99€   |
      | Prix d'abonnement                                 |                     |          | 7,49€   |
      | Taux de TVA (20%)                                 |                     |          | 1,50€   |
      | Montant total des frais                           |                     |          | 8,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 99           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 99 x 20 Go        |
      | Espace total de stockage :         | 2,1 To            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 172,49€           |
      | Taux de TVA (20%):                 | 34,50€            |
      | Total : 	                       | 206,99€           |
      | Coût au pro rata: 	               | 165,00€           |
      | Taux de TVA (20%):                 | 33,00€            |
      | Total : 	                       | 198,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 1,9 To            |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 172,49€           |
      | Taux de TVA (20%):   	            | 34,50€            |
      | Total :                             | 206,99€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124543 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124543 Add FR 125 GB yearly MozyHome user change to addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT)  | 1        | 98,89€  |
      | Prix d'abonnement                                 |                     |          | 82,41€  |
      | Taux de TVA (20%)                                 |                     |          | 16,48€  |
      | Montant total des frais                           |                     |          | 98,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 125 Go           |
      | Ordinateurs :                      | 4                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 100,74€          |
      | Taux de TVA (20%):                 | 20,15€           |
      | Total : 	                       | 120,89€          |
      | Coût au pro rata: 	               | 18,33€           |
      | Taux de TVA (20%):                 | 3,67€            |
      | Total : 	                       | 22,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 4                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 100,74€          |
      | Taux de TVA (20%):   	            | 20,15€           |
      | Total :                             | 120,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124544 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124544 Add FR 125 GB biennial MozyHome user change to addl PC storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                          | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel  | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                    |                     |          | 157,32€ |
      | Taux de TVA (20%)                                    |                     |          | 31,47€  |
      | Montant total des frais                              |                     |          | 188,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers | addl storage |
      | 5              | 5            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 5 x 20 Go         |
      | Espace total de stockage :         | 225 Go            |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 402,32€           |
      | Taux de TVA (20%):                 | 80,47€            |
      | Total : 	                       | 482,79€           |
      | Coût au pro rata: 	               | 245,00€           |
      | Taux de TVA (20%):                 | 49,00€            |
      | Total : 	                       | 294,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 100 Go            |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 402,32€           |
      | Taux de TVA (20%):   	            | 80,47€            |
      | Total :                             | 482,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.124545 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124545 Add FR 50 GB addl storage monthly MozyHome user change to 125 GB addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | cc number        |
      | 1      | 50 Go     | France  | France          | 1            | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 1        | 2,00€   |
      | Prix d'abonnement                       |                     |          | 5,82€   |
      | Taux de TVA (20%)                       |                     |          | 1,17€   |
      | Montant total des frais                 |                     |          | 6,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 Go    | 2            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 2 x 20 Go         |
      | Espace total de stockage :         | 165 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 10,82€            |
      | Taux de TVA (20%):                 | 2,17€             |
      | Total : 	                       | 12,99€            |
      | Coût au pro rata: 	               | 5,00€             |
      | Taux de TVA (20%):                 | 1,00€             |
      | Total : 	                       | 6,00€             |
    And the current plan summary looks like:
      | Plan de base :                    	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 40 Go             |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 10,82€            |
      | Taux de TVA (20%):   	            | 2,17€             |
      | Total :                             | 12,99€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124546 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124546 Add FR 50 GB addl PC yearly MozyHome user change to addl pc
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | cc number        |
      | 12     | 50 Go     | France  | France          | 1              | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Ordinateurs supplémentaires - Annuel   | 22,00€\n(inc. VAT) | 1        | 22,00€  |
      | Prix d'abonnement                      |                    |          | 64,07€  |
      | Taux de TVA (20%)                      |                    |          | 12,82€  |
      | Montant total des frais                |                    |          | 76,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go        |
      | Espace total de stockage :         | 50 Go            |
      | Ordinateurs :                      | 5                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 119,07€          |
      | Taux de TVA (20%):                 | 23,82€           |
      | Total : 	                       | 142,89€          |
      | Coût au pro rata: 	               | 55,00€           |
      | Taux de TVA (20%):                 | 11,00€           |
      | Total : 	                       | 66,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 0 Go             |
      | Ordinateurs : 	                    | 5                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 119,07€          |
      | Taux de TVA (20%): 	                | 23,82€           |
      | Total :                             | 142,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124547 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent @change_plan
  Scenario: 124547 Add FR 50 GB coupon biennial MozyHome user change to 125 GB
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon       | cc number        |
      | 24     | 50 Go     | France  | France          | 10percentoff | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | 24 mois à 10.0 % de réduction             | -10,47€\n(inc. VAT) |          | -10,47€ |
      | Prix d'abonnement                         |                     |          | 78,60€  |
      | Taux de TVA (20%)                         |                     |          | 15,72€  |
      | Montant total des frais                   |                     |          | 94,32€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan |
      | 125 Go    |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 3                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 157,32€           |
      | Taux de TVA (20%):                 | 31,47€            |
      | Total : 	                       | 188,79€           |
      | Coût au pro rata: 	               | 70,00€            |
      | Taux de TVA (20%):                 | 14,00€            |
      | Total : 	                       | 84,00€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 3                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 157,32€           |
      | Taux de TVA (20%):   	            | 31,47€            |
      | Total :                             | 188,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.124548 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 124548 Add FR 125 GB addl storage PC monthly MozyHome user change to addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | cc number        |
      | 1      | 125 Go    | France  | France          | 2            | 2              | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | PriX              | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | 20 Stockage supplémentaire - Mensuel              | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Ordinateurs supplémentaires - Mensuel             | 2,00€\n(inc. VAT) |   2      | 4,00€   |
      | Prix d'abonnement                                 |                   |          | 14,16€  |
      | Taux de TVA (20%)                                 |                   |          | 2,83€   |
      | Montant total des frais                           |                   |          | 16,99€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 10           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 10 x 20 Go        |
      | Espace total de stockage :         | 325 Go            |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 27,49€            |
      | Taux de TVA (20%):                 | 5,50€             |
      | Total : 	                       | 32,99€            |
      | Coût au pro rata: 	               | 13,33€            |
      | Taux de TVA (20%):                 | 2,67€             |
      | Total : 	                       | 16,00€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 200 Go            |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 27,49€            |
      | Taux de TVA (20%):   	            | 5,50€             |
      | Total :                             | 32,99€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124549 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent @change_plan
  Scenario: 124549 Add FR 125 GB addl storage yearly MozyHome user change to addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon       | cc number        |
      | 12     | 125 Go    | France  | France          | 98           | 10percentoff | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | PriX                 | Quantité | Montant   |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel | 98,89€\n(inc. VAT)   | 1        | 98,89€    |
      | 20 Stockage supplémentaire - Annuel              | 22,00€\n(inc. VAT)   | 98       | 2 156,00€ |
      | 12 mois à 10.0 % de réduction                    | -225,48€\n(inc. VAT) |          | -225,48€  |
      | Prix d'abonnement                                |                      |          | 1 691,17€ |
      | Taux de TVA (20%)                                |                      |          | 338,24€   |
      | Montant total des frais                          |                      |          | 2 029,41€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 5              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 98 x 20 Go       |
      | Espace total de stockage :         | 2 To             |
      | Ordinateurs :                      | 5                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 1 915,74€        |
      | Taux de TVA (20%):                 | 383,15€          |
      | Total : 	                       | 2 298,89€        |
      | Coût au pro rata: 	               | 36,67€           |
      | Taux de TVA (20%):                 | 7,33€            |
      | Total : 	                       | 44,00€           |
    And the current plan summary looks like:
      | Plan de base :                  	| MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 1,9 To           |
      | Ordinateurs : 	                    | 5                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 1 915,74€        |
      | Taux de TVA (20%):   	            | 383,15€          |
      | Total :                             | 2 298,89€        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124550 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent @change_plan
  Scenario: 124550 Add FR 125 GB addl PC coupon biennial MozyHome user change to addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl computers | coupon       | cc number        |
      | 24     | 125 Go    | France  | France          | 1              | 10percentoff | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Ordinateurs supplémentaires - Bisannuel             | 42,00€\n(inc. VAT)  | 1        | 42,00€  |
      | 24 mois à 10.0 % de réduction                       | -23,07€\n(inc. VAT) |          | -23,07€ |
      | Prix d'abonnement                                   |                     |          | 173,10€ |
      | Taux de TVA (20%)                                   |                     |          | 34,62€  |
      | Montant total des frais                             |                     |          | 207,72€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 1            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 1 x 20 Go         |
      | Espace total de stockage :         | 145 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 227,32€           |
      | Taux de TVA (20%):                 | 45,47€            |
      | Total : 	                       | 272,79€           |
      | Coût au pro rata: 	               | 35,00€            |
      | Taux de TVA (20%):                 | 7,00€             |
      | Total : 	                       | 42,00€            |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 20 Go             |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 227,32€           |
      | Taux de TVA (20%):   	            | 45,47€            |
      | Total :                             | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.124551 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @qa6_dependent @change_plan
  Scenario: 124551 Add FR 50 GB addl storage PC coupon monthly basic MozyHome user to addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | addl computers | coupon       | cc number        |
      | 1      | 50 Go     | France  | France          | 99           | 2              | 10percentoff | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 20 Stockage supplémentaire - Mensuel    | 2,00€\n(inc. VAT)   | 99       | 198,00€ |
      | Ordinateurs supplémentaires - Mensuel   | 2,00€\n(inc. VAT)   | 2        | 4,00€   |
      | 1 mois à 10.0 % de réduction            | -20,69€\n(inc. VAT) |          | -20,69€ |
      | Prix d'abonnement                       |                     |          | 155,25€ |
      | Taux de TVA (20%)                       |                     |          | 31,05€  |
      | Montant total des frais                 |                     |          | 186,30€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Plan de base :                     | 50 Go             |
      | Espace de stockage supplémentaire :| 99 x 20 Go        |
      | Espace total de stockage :         | 2 To              |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 174,16€           |
      | Taux de TVA (20%):                 | 34,83€            |
      | Total : 	                       | 208,99€           |
      | Coût au pro rata: 	               | 1,67€             |
      | Taux de TVA (20%):                 | 0,33€             |
      | Total : 	                       | 2,00€             |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 50 Go    |
      | Espace de stockage supplémentaire : | 1,9 To            |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 174,16€           |
      | Taux de TVA (20%):   	            | 34,83€            |
      | Total :                             | 208,99€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124552 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @change_plan
  Scenario: 124552 Add FR 50 GB yearly MozyHome user change to 125 GB addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel  | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | Prix d'abonnement                       |                    |          | 45,74€  |
      | Taux de TVA (20%)                       |                    |          | 9,15€   |
      | Montant total des frais                 |                    |          | 54,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 Go    | 98           |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 98 x 20 Go       |
      | Espace total de stockage :         | 2 To             |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 1 879,07€        |
      | Taux de TVA (20%):                 | 375,82€          |
      | Total : 	                       | 2 254,89€        |
      | Coût au pro rata: 	               | 1 833,33€        |
      | Taux de TVA (20%):                 | 366,67€          |
      | Total : 	                       | 2 200,00€        |
    And the current plan summary looks like:
      | Plan de base :                      | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 1,9 To           |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 1 879,07€        |
      | Taux de TVA (20%):   	            | 375,82€          |
      | Total :                             | 2 254,89€        |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124553 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @change_plan
  Scenario: 124553 Add FR 50 GB biennial MozyHome user change to 125 GB addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | Prix d'abonnement                         |                     |          | 87,32€  |
      | Taux de TVA (20%)                         |                     |          | 17,47€  |
      | Montant total des frais                   |                     |          | 104,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl computers |
      | 125 Go    | 5             |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 5                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 227,32€           |
      | Taux de TVA (20%):                 | 45,47€            |
      | Total : 	                       | 272,79€           |
      | Coût au pro rata: 	               | 140,00€           |
      | Taux de TVA (20%):                 | 28,00€            |
      | Total : 	                       | 168,00€           |
    And the current plan summary looks like:
      | Plan de base :                   	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 5                 |
      | Abonnement : 	                    | Bisannuel          |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 227,32€           |
      | Taux de TVA (20%):   	            | 45,47€            |
      | Total :                             | 272,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 125 Go Cases
  #
  @TC.124554 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @change_plan
  Scenario: 124554 Add FR 125 GB monthly MozyHome user change to addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 1      | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | PriX              | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT) | 1        | 8,99€   |
      | Prix d'abonnement                                |                   |          | 7,49€   |
      | Taux de TVA (20%)                                |                   |          | 1,50€   |
      | Montant total des frais                          |                   |          | 8,99€   |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Mensuel           |
      | Prochaine facture :                | @1 month from now |
      | Montant: 	                       | 9,16€             |
      | Taux de TVA (20%):                 | 1,83€             |
      | Total : 	                       | 10,99€            |
      | Coût au pro rata: 	               | 1,67€             |
      | Taux de TVA (20%):                 | 0,33€             |
      | Total : 	                       | 2,00€             |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Mensuel           |
      | Prochaine facture :                 | @1 month from now |
      | Montant: 	                        | 9,16€             |
      | Taux de TVA (20%):   	            | 1,83€             |
      | Total :                             | 10,99€            |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124555 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @change_plan
  Scenario: 124555 Add FR 125 GB yearly MozyHome user change to addl storage
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                      | PriX               | Quantité | Montant |
      |MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Annuel  | 98,89€\n(inc. VAT) | 1        | 98,89€  |
      | Prix d'abonnement                                |                    |          | 82,41€  |
      | Taux de TVA (20%)                                |                    |          | 16,48€  |
      | Montant total des frais                          |                    |          | 98,89€  |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl storage |
      | 1            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 1 x 20 Go        |
      | Espace total de stockage :         | 145 Go           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant: 	                       | 100,74€          |
      | Taux de TVA (20%):                 | 20,15€           |
      | Total : 	                       | 120,89€          |
      | Coût au pro rata: 	               | 18,33€           |
      | Taux de TVA (20%):                 | 3,67€            |
      | Total : 	                       | 22,00€           |
    And the current plan summary looks like:
      | Plan de base : 	                    | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 20 Go            |
      | Ordinateurs : 	                    | 3                |
      | Abonnement : 	                    | Annuel           |
      | Remise : 	                        | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant: 	                        | 100,74€          |
      | Taux de TVA (20%):   	            | 20,15€           |
      | Total :                             | 120,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.124556 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=fr @change_plan
  Scenario: 124556 Add FR 125 GB biennial MozyHome user change to addl PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 24     | 125 Go    | France  | France          | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                         | PriX                | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Bisannuel | 188,79€\n(inc. VAT) | 1        | 188,79€ |
      | Prix d'abonnement                                   |                     |          | 157,32€ |
      | Taux de TVA (20%)                                   |                     |          | 31,47€  |
      | Montant total des frais                             |                     |          | 188,79€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | addl computers |
      | 4              |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go            |
      | Espace de stockage supplémentaire :| 0 x 20 Go         |
      | Espace total de stockage :         | 125 Go            |
      | Ordinateurs :                      | 4                 |
      | Abonnement :                       | Bisannuel         |
      | Prochaine facture :                | @2 years from now |
      | Montant: 	                       | 192,32€           |
      | Taux de TVA (20%):                 | 38,47€            |
      | Total : 	                       | 230,79€           |
      | Coût au pro rata: 	               | 35,00€            |
      | Taux de TVA (20%):                 | 7,00€             |
      | Total : 	                       | 42,00€            |
    And the current plan summary looks like:
      | Plan de base : 	| MozyHome 125 Go   |
      | Espace de stockage supplémentaire : | 0 Go              |
      | Ordinateurs : 	                    | 4                 |
      | Abonnement : 	                    | Bisannuel         |
      | Remise : 	                        | 3 mois gratuits   |
      | Prochaine facture :                 | @2 years from now |
      | Montant: 	                        | 192,32€           |
      | Taux de TVA (20%): 	                | 38,47€            |
      | Total :                             | 230,79€           |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  #
  # 50 Go Cases
  #
  @TC.124557 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 124557 Add a new FR 50 GB monthly MozyHome user with price coupon
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  | cc number        |
      | 1      | 50 Go     | France  | France          | 1dollaroffwithoutdollar | 4485393141463880 |
    Then the billing summary looks like:
      | Description                             | PriX                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Mensuel | 4,99€\n(inc. VAT)   | 1        | 4,99€   |
      | 1 mois, avec 1,00€ de remise            | -1,00€\n(inc. VAT)  |          | -1,00€  |
      | Prix d'abonnement                       |                     |          | 3,32€   |
      | Taux de TVA (20%)                       |                     |          | 0,67€   |
      | Montant total des frais                 |                     |          | 3,99€   |
    Then the user is successfully added.

  @TC.124558 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 124558 Add a new FR 50 GB yearly MozyHome user with price coupon
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  | cc number        |
      | 12     | 50 Go     | France  | France          | 1dollaroffwithoutdollar | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT)  | 1        | 54,89€  |
      | 12 mois, avec 1,00€ de remise par mois | -11,00€\n(inc. VAT) |          | -11,00€ |
      | Prix d'abonnement                      |                     |          | 36,57€  |
      | Taux de TVA (20%)                      |                     |          | 7,32€   |
      | Montant total des frais                |                     |          | 43,89€  |
     Then the user is successfully added.

  @TC.124559 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 124559 Add a new FR 50 GB biennial MozyHome user with price coupon
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  | cc number        |
      | 24     | 50 Go     | France  | France          | 1dollaroffwithoutdollar | 4485393141463880 |
    Then the billing summary looks like:
      | Description                               | Prix                | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Bisannuel | 104,79€\n(inc. VAT) | 1        | 104,79€ |
      | 24 mois, avec 1,00€ de remise par mois    | -21,00€\n(inc. VAT) |          | -21,00€ |
      | Prix d'abonnement                         |                     |          | 69,82€  |
      | Taux de TVA (20%)                         |                     |          | 13,97€  |
      | Montant total des frais                   |                     |          | 83,79€  |
    Then the user is successfully added.

  #
  # 125 Go Cases
  #
  @TC.124560 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @qa6_dependent
  Scenario: 124560 Add a new FR 125 GB monthly MozyHome user with price coupon
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | coupon                  | cc number        |
      | 1      | 125 Go    | France  | France          | 1dollaroffwithoutdollar | 4485393141463880 |
    Then the billing summary looks like:
      | Description                                       | Prix               | Quantité | Montant |
      | MozyHome 125 Go (Jusqu'à 3 ordinateurs) - Mensuel | 8,99€\n(inc. VAT)  | 1        | 8,99€   |
      | 1 mois, avec 1,00€ de remise                      | -1,00€\n(inc. VAT) |          | -1,00€  |
      | Prix d'abonnement                                 |                    |          | 6,66€   |
      | Taux de TVA (20%)                                 |                    |          | 1,33€   |
      | Montant total des frais                           |                    |          | 7,99€   |
    Then the user is successfully added.

  @TC.126160 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 126160 Update FR 50 GB + 60 GB 1 PC yearly MozyHome user to 125 GB +20 GB,3 PC
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | cc number        |
      | 12     | 50 Go     | France  | France          | 3            | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | 20 Stockage supplémentaire - Annuel    | 22,00€\n(inc. VAT) | 3        | 66,00€  |
      | Prix d'abonnement                      |                    |          | 100,74€ |
      | Taux de TVA (20%)                      |                    |          | 20,15€  |
      | Montant total des frais                |                    |          | 120,89€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I upgrade my user account to:
      | base plan | addl storage |
      | 125 Go    | 1            |
    And the payment details summary looks like:
      | Plan de base :                     | 125 Go           |
      | Espace de stockage supplémentaire :| 1 x 20 Go        |
      | Espace total de stockage :         | 145 Go           |
      | Ordinateurs :                      | 3                |
      | Abonnement :                       | Annuel           |
      | Prochaine facture :                | @1 year from now |
      | Montant:                           | 100,74€          |
      | Taux de TVA (20%):                 | 20,15€           |
      | Total :                            | 120,89€          |
      | Coût au pro rata:                  | 0,00€            |
      | Taux de TVA (20%):                 | 0,00€            |
      | Total :                            | 0,00€            |
    And the current plan summary looks like:
      | Plan de base :                      | MozyHome 125 Go  |
      | Espace de stockage supplémentaire : | 20 Go            |
      | Ordinateurs :                       | 3                |
      | Abonnement :                        | Annuel           |
      | Remise :                            | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant:                            | 100,74€          |
      | Taux de TVA (20%):                  | 20,15€           |
      | Total :                             | 120,89€          |
    And the renewal plan summary is Same as current plan
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user

  @TC.126165 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @change_plan
  Scenario: 126165 [Negative]Down grade MozyHome FR user
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | cc number        |
      | 12     | 50 Go     | France  | France          | 3            | 4485393141463880 |
    Then the billing summary looks like:
      | Description                            | PriX               | Quantité | Montant |
      | MozyHome 50 Go (1 ordinateur) - Annuel | 54,89€\n(inc. VAT) | 1        | 54,89€  |
      | 20 Stockage supplémentaire - Annuel    | 22,00€\n(inc. VAT) | 3        | 66,00€  |
      | Prix d'abonnement                      |                    |          | 100,74€ |
      | Taux de TVA (20%)                      |                    |          | 20,15€  |
      | Montant total des frais                |                    |          | 120,89€ |
    Then the user is successfully added.
    And the user has activated their account
    And I login as the user on the account.
    And I downgrade my user account to:
      | addl storage |
      | 1            |
    And Error message of Not allowed to decrease will show:
    """
     Vous n'êtes pas autorisé à réduire le quota dont vous disposez actuellement.
    """
    And I click cancel button during change current plan
    And the current plan summary looks like:
      | Plan de base :                      | MozyHome 50 Go   |
      | Espace de stockage supplémentaire : | 60 Go            |
      | Ordinateurs :                       | 1                |
      | Abonnement :                        | Annuel           |
      | Remise :                            | 1 mois gratuit   |
      | Prochaine facture :                 | @1 year from now |
      | Montant:                            | 100,74€          |
      | Taux de TVA (20%):                  | 20,15€           |
      | Total :                             | 120,89€          |
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I delete user
