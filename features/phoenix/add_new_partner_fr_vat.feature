Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
#---------------------------------------------------------------------------------
# base coverage section:
#   represents a balanced set of coverage
#----------------------------------------test matrix------------------------------
#	partner size:	10        | 50          | 100    | 250      | 500      | 1tb
#	monthly:		ie,sv,cp  | ie          | uk     | fr,sv    | de,sv,hp | us
#	yearly:			uk,sv     | de,sv,nv,cp | us,sv  | ie,nv,hp | fr       | fr,cp
#	biannual:		us,hp     | fr,nv       | de,nv  | de       | uk,nv    | ie,sv
#----------------------------------------test legend------------------------------
#		entries by: country,server/dsk,novat,coupon,hipaa
#
#		key: sv=server, nv=novat, cp=coupon, hp=hipaa
#		coupon code = 10PERCENTOFFOUTLINE
#
#     base smoke test = us yearly, 100gb, server
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
# precondition
# ssh root@phoenix01.qa6.mozyops.com  QAP@SSw0rd
# /var/www/phoenix/app/views/registration/_payment_details.rhtml
# 'ip_country' : '<%= country_with_ip(request.remote_ip)%>’
# set 'ip_country' : 'FR' if @ip_country=fr
# restart: /etc/init.d/apache2 restart
#---------------------------------------------------------------------------------

  @TC.125308 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125308 Add a new FR 10 GB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix  | Quantité | Montant |
      | 10 Go - Mensuel         | 7,99€ | 1        | 7,99€   |
      | Prix d'abonnement       | 7,99€ |          | 7,99€   |
      | TVA                     | 1,60€ |          | 1,60€   |
      | Montant total des frais | 9,59€ |          | 9,59€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125309 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125309 Add a new FR 10 GB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Annuel          | 87,89€  | 1        | 87,89€  |
      | Prix d'abonnement       | 87,89€  |          | 87,89€  |
      | TVA                     | 17,58€  |          | 17,58€  |
      | Montant total des frais | 105,47€ |          | 105,47€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125310 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125310 Add a new FR 10 GB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Bisannuel       | 167,79€ | 1        | 167,79€ |
      | Prix d'abonnement       | 167,79€ |          | 167,79€ |
      | TVA                     | 33,56€  |          | 33,56€  |
      | Montant total des frais | 201,35€ |          | 201,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125311 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125311 Add a new FR 50 GB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix   | Quantité | Montant |
      | 50 Go - Mensuel         | 15,99€ | 1        | 15,99€  |
      | Prix d'abonnement       | 15,99€ |          | 15,99€  |
      | TVA                     | 3,20€  |          | 3,20€   |
      | Montant total des frais | 19,19€ |          | 19,19€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125312 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125312 Add a new FR 50 GB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Annuel          | 175,89€ | 1        | 175,89€ |
      | Prix d'abonnement       | 175,89€ |          | 175,89€ |
      | TVA                     | 35,18€  |          | 35,18€  |
      | Montant total des frais | 211,07€ |          | 211,07€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125313 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125313 Add a new FR 50 GB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 50 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Bisannuel       | 335,79€ | 1        | 335,79€ |
      | Prix d'abonnement       | 335,79€ |          | 335,79€ |
      | TVA                     | 67,16€  |          | 67,16€  |
      | Montant total des frais | 402,95€ |          | 402,95€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125314 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125314 Add a new FR 100 GB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Mensuel        | 30,99€  | 1        | 30,99€  |
      | Prix d'abonnement       | 30,99€  |          | 30,99€  |
      | TVA                     | 6,20€   |          | 6,20€   |
      | Montant total des frais | 37,19€  |          | 37,19€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125315 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125315 Add a new FR 100 GB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Annuel         | 340,89€ | 1        | 340,89€ |
      | Prix d'abonnement       | 340,89€ |          | 340,89€ |
      | TVA                     | 68,18€  |          | 68,18€  |
      | Montant total des frais | 409,07€ |          | 409,07€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125316 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125316 Add a new FR 100 GB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 100 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 100 Go - Bisannuel      | 650,79€ | 1        | 650,79€ |
      | Prix d'abonnement       | 650,79€ |          | 650,79€ |
      | TVA                     | 130,16€ |          | 130,16€ |
      | Montant total des frais | 780,95€ |          | 780,95€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125317 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125317 Add a new FR 250 GB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 250 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix   | Quantité | Montant |
      | 250 Go - Mensuel        | 74,99€ | 1        | 74,99€  |
      | Prix d'abonnement       | 74,99€ |          | 74,99€  |
      | TVA                     | 15,00€ |          | 15,00€  |
      | Montant total des frais | 89,99€ |          | 89,99€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125318 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125318 Add a new FR 250 GB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 250 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 250 Go - Annuel         | 663,89€ | 1        | 663,89€ |
      | Prix d'abonnement       | 663,89€ |          | 663,89€ |
      | TVA                     | 132,78€ |          | 132,78€ |
      | Montant total des frais | 796,67€ |          | 796,67€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125319 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125319 Add a new FR 250 GB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 250 Go    | France  | France         | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 250 Go - Bisannuel      | 1 272,79€ | 1        | 1 272,79€ |
      | Prix d'abonnement       | 1 272,79€ |          | 1 272,79€ |
      | TVA                     | 254,56€   |          | 254,56€   |
      | Montant total des frais | 1 527,35€ |          | 1 527,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125320 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125320 Add a new FR 500 GB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 500 Go - Mensuel        | 149,99€ | 1        | 149,99€ |
      | Prix d'abonnement       | 149,99€ |          | 149,99€ |
      | TVA                     | 30,00€  |          | 30,00€  |
      | Montant total des frais | 179,99€ |          | 179,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125321 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125321 Add a new FR 500 GB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Annuel         | 1 327,89€ | 1        | 1 327,89€ |
      | Prix d'abonnement       | 1 327,89€ |          | 1 327,89€ |
      | TVA                     | 265,58€   |          | 265,58€   |
      | Montant total des frais | 1 593,47€ |          | 1 593,47€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125322 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125322 Add a new FR 500 GB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 500 Go    | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Bisannuel      | 2 536,79€ | 1        | 2 536,79€ |
      | Prix d'abonnement       | 2 536,79€ |          | 2 536,79€ |
      | TVA                     | 507,36€   |          | 507,36€   |
      | Montant total des frais | 3 044,15€ |          | 3 044,15€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125323 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125323 Add a new FR 1 TB monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 60,00€  |          | 60,00€  |
      | Montant total des frais | 359,99€ |          | 359,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125324 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125324 Add a new FR 1 TB yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 12     | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Annuel           | 2 654,89€ | 1        | 2 654,89€ |
      | Prix d'abonnement       | 2 654,89€ |          | 2 654,89€ |
      | TVA                     | 530,98€   |          | 530,98€   |
      | Montant total des frais | 3 185,87€ |          | 3 185,87€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125325 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125325 Add a new FR 1 TB biennial basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Bisannuel        | 5 072,79€ | 1        | 5 072,79€ |
      | Prix d'abonnement       | 5 072,79€ |          | 5 072,79€ |
      | TVA                     | 1 014,56€ |          | 1 014,56€ |
      | Montant total des frais | 6 087,35€ |          | 6 087,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125327 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr 
  Scenario: 125327 Add a new FR 10 GB coupon yearly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon              | cc number        |
      | 12     | 10 Go     | France  | France          | 10PERCENTOFFOUTLINE | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Annuel          | 87,89€  | 1        | 87,89€  |
      | Prix d'abonnement       | 87,89€  |          | 87,89€  |
      | Réductions              | - 8,79€ |          | - 8,79€ |
      | Sous-total              | 79,10€  |          | 79,10€  |
      | TVA                     | 15,82€  |          | 15,82€  |
      | Montant total des frais | 94,92€  |          | 94,92€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125328 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 125328 Add a new FR 10 GB biennial basic MozyPro partner with VAT No fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 10 Go     | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 10 Go - Bisannuel       | 167,79€   | 1        | 167,79€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 167,79€   |          | 167,79€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125329 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125329 Add a new FR 50 GB coupon monthly basic MozyPro partner fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan | coupon              | cc number        |
      | 1      | 50 Go     | France  | France          | yes         | 10PERCENTOFFOUTLINE | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 50 Go - Mensuel         | 15,99€  | 1        | 15,99€  |
      | Plan serveur - Mensuel  | 5,49€   | 1        | 5,49€   |
      | Prix d'abonnement       | 21,48€  |          | 21,48€  |
      | Réductions              | - 2,15€ |          | - 2,15€ |
      | Sous-total              | 19,33€  |          | 19,33€  |
      | TVA                     | 3,87€   |          | 3,87€   |
      | Montant total des frais | 23,20€  |          | 23,20€  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125330 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 125330 Add a new FR 50 GB yearly basic MozyPro partner with VAT No fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan | vat number    | cc number        |
      | 12     | 50 Go     | France  | Royaume-Uni     | yes         | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 50 Go - Annuel          | 175,89€   | 1        | 175,89€   |
      | Plan serveur - Annuel   | 60,39€    | 1        | 60,39€    |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 236,28€   |          | 236,28€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125331 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 125331 Add a new FR 50 GB coupon biennial basic MozyPro partner with VAT No fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon              | vat number    | cc number        |
      | 24     | 50 Go     | France  | Royaume-Uni     | 10PERCENTOFFOUTLINE | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 50 Go - Bisannuel       | 335,79€   | 1        | 335,79€   |
      | Prix d'abonnement       | 335,79€   |          | 335,79€   |
      | Réductions              | - 33,58€  |          | - 33,58€  |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 302,21€   |          | 302,21€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125332 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 125332 Add a new FR 100 GB coupon monthly basic MozyPro partner with VAT No fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | server plan |coupon              | vat number    | cc number        |
      | 1      | 100 Go    | France  | Royaume-Uni     | yes         |10PERCENTOFFOUTLINE | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 100 Go - Mensuel        | 30,99€    | 1        | 30,99€    |
      | Plan serveur - Mensuel  | 9,99€     | 1        | 9,99€     |
      | Prix d'abonnement       | 40,98€    |          | 40,98€    |
      | Réductions              | - 4,10€   |          | - 4,10€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 36,88€    |          | 36,88€    |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125334 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 125334 Add a new FR 10 GB biennial basic MozyPro partner fr_uk_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 10 Go     | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 10 Go - Bisannuel       | 167,79€ | 1        | 167,79€ |
      | Prix d'abonnement       | 167,79€ |          | 167,79€ |
      | TVA                     | 33,56€  |          | 33,56€  |
      | Montant total des frais | 201,35€ |          | 201,35€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125335 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 125335 Add a new FR 1 TB monthly basic MozyPro partner fr_uk_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 1 To      | France  | France          | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 60,00€  |          | 60,00€  |
      | Montant total des frais | 359,99€ |          | 359,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125336 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr
  Scenario: 125336 Add a new FR 10 GB biennial basic MozyPro partner with VAT No fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 1      | 10 Go     | France  | France          | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 10 Go - Mensuel         | 7,99€     | 1        | 7,99€     |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 7,99€     |          | 7,99€     |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125337 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr
  Scenario: 125337 Add a new FR 100 GB biennial basic MozyPro partner with VAT No fr_uk_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 100 Go    | France  | France          | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 100 Go - Bisannuel      | 650,79€   | 1        | 650,79€   |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 650,79€   |          | 650,79€   |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125338 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=uk
  Scenario: 125338 Add a new FR 250 GB monthly basic MozyPro partner with VAT No fr_uk_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 1      | 250 Go    | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 250 Go - Mensuel        | 74,99€    | 1        | 74,99€    |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 74,99€    |          | 74,99€    |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125339 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=it
  Scenario: 125339 Add a new FR 500 GB yearly basic MozyPro partner with VAT No fr_uk_it
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 12     | 500 Go    | France  | Royaume-Uni     | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 500 Go - Annuel         | 1 327,89€ | 1        | 1 327,89€ |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 1 327,89€ |          | 1 327,89€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125340 @phoenix @mozypro @profile_country=fr @ip_country=us @billing_country=us
  Scenario: 125340 Add a new FR 1 TB biennial basic MozyPro partner with VAT No fr_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number    | cc number        |
      | 24     | 1 To      | France  | États-Unis      | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
      | Description             | Prix      | Quantité | Montant   |
      | 1 To - Bisannuel        | 5 072,79€ | 1        | 5 072,79€ |
      | TVA                     | Exemption |          | Exemption |
      | Montant total des frais | 5 072,79€ |          | 5 072,79€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
