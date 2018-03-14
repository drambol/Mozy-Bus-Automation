Feature: Add a new user through phoenix

  As a private citizen
  I want to create a user account through phoenix
  So that I can organize my personal life in a way that works for me

  Background:
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
  # 125 GB Cases
  #
  @TC.125259 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=us @negative_test @invalid_coupon
  Scenario: 125259 Add a new US yearly basic MozyHome user invalid coupon us_fr_us
  When I am at dom selection point:
  And I add a phoenix Home user:
    | period | base plan | country       | billing country | coupon      |
    | 12     | 125 GB    | United States | United States   | 5percentoff |
  Then mozy plan page error message should be:
  """
   The promotion code 5percentoff is invalid or has expired.
  """

  @TC.125260 @phoenix @mozyhome @profile_country=us @ip_country=us @billing_country=us @bin_country=uk @negative_test @billing_cc_not_match
  Scenario: 125260 Add a new US biennial basic MozyHome user credit card not match us_us_us
  When I am at dom selection point:
  And I add a phoenix Home user:
    | period | base plan | country       | billing country | cc number        |
    | 24     | 125 GB    | United States | United States   | 4916783606275713 |
  Then billing details page error message should be:
  """
   The billing country you provided does not match the country of the bank which issued your credit card.
  """

  @TC.125261 @BUG.128707 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=uk
  Scenario: 125261 Add a new FR yearly basic MozyHome user invalid coupon fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | addl storage | coupon              |
      | 12     | 125 Go    | France  | Royaume-Uni     | 98           | 10percentoffInvalid |
    Then mozy plan page error message should be:
    """
     Le code de promotion 10percentoffInvalid est incorrect ou a expiré.
    """

  @TC.125262 @phoenix @mozyhome @profile_country=fr @ip_country=fr @billing_country=fr @bin_country=uk
  Scenario: 125262 Add a new FR monthly basic MozyHome user credit card not match fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number       |
      | 1      | 125 Go    | France  | France          | 4916783606275713|
    Then billing details page error message should be:
    """
     Le pays de facturation indiqué ne correspond pas au pays de la banque ayant fourni votre carte de crédit.
    """

  @TC.125263 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=uk @bin_country=uk @negative_test
  Scenario: 125263 Add a new FR yearly basic MozyHome user invalid location fr_uk_uk
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | Royaume-Uni     | 4916783606275713 |
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence.
    """

  @TC.125264 @phoenix @mozyhome @profile_country=fr @ip_country=uk @billing_country=it @bin_country=us @negative_test
  Scenario: 125264 Add a new FR yearly basic MozyHome user credit card not match fr_uk_it
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | Italie          | 4111111111111111 |
    Then billing details page error message should be:
    """
     Le pays de facturation indiqué ne correspond pas au pays de la banque ayant fourni votre carte de crédit.
    """

  @TC.125265 @phoenix @mozyhome @profile_country=fr @ip_country=us @billing_country=us @bin_country=us @negative_test
  Scenario: 125265 Add a new FR yearly basic MozyHome user invalid location fr_us_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 Go    | France  | États-Unis      | 4018121111111122 |
    Then billing details page error message should be:
    """
     Le pays de résidence que vous avez fourni ne correspond pas au pays de la banque qui a émis votre carte de crédit. Veuillez changer le pays que vous avez choisi comme pays de résidence, ou saisissez une carte de crédit qui correspond à votre pays de résidence.
    """

  @TC.125266 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125266 Add a new US yearly basic MozyHome user invalid location us_fr_fr
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number       |
      | 12     | 125 GB    | United States | France          | 4485393141463880|
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.125267 @phoenix @mozyhome @profile_country=us @ip_country=fr @billing_country=it @bin_country=it @negative_test
  Scenario: 125267 Add a new US yearly basic MozyHome user invalid location us_fr_it
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 125 GB    | United States | Italy           | 4916921703777575 |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.125268 @phoenix @mozyhome @profile_country=de @ip_country=fr @billing_country=us @bin_country=us @negative_test
  Scenario: 125268 Add a new DE yearly basic MozyHome user invalid location de_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | billing state abbrev | cc number        |
      | 12     | 125 GB    | Germany | USA             | CA                   | 4018121111111122 |
    Then billing details page error message should be:
    """
    Das Land des Firmensitzes, das Sie angegeben haben, stimmt nicht mit dem Land der Bank, die Ihre Kreditkarte verwaltet, überein. Bitte prüfen Sie das Land noch einmal, das Sie als Land Ihres Firmensitzes angegeben haben, oder geben Sie eine Kreditkarte an, die mit dem Land Ihres Firmensitzes übereinstimmt.
    """
  @TC.125269 @phoenix @mozyhome @profile_country=de @ip_country=fr @billing_country=de @bin_country=us @negative_test
  Scenario: 125269 Add a new DE yearly basic MozyHome user credit card not match de_fr_de
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 GB    | Germany | Deutschland     | 4018121111111122 |
    Then billing details page error message should be:
    """
     Ihre Kreditkarte wurde in einem anderen Land ausgestellt als das, in dem sich Ihre Rechnungsadresse befindet
    """

  @TC.125270 @phoenix @mozyhome @profile_country=uk @ip_country=fr @billing_country=us @bin_country=us @negative_test
  Scenario: 125270 Add a new UK yearly basic MozyHome user invalid location uk_fr_us
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 125 GB    | United Kingdom | United States   | 4018121111111122 |
    Then billing details page error message should be:
    """
     The country of residence you provided does not match the country of the bank which issued your credit card. Please review the country you chose as your country of residence, or enter a credit card which matches your country of residence.
    """

  @TC.125271 @phoenix @mozyhome @profile_country=uk @ip_country=fr @billing_country=uk @bin_country=us @negative_test
  Scenario: 125271 Add a new UK yearly basic MozyHome credit card not match user uk_fr_uk
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | cc number        |
      | 12     | 125 GB    | United Kingdom | United Kingdom  | 4111111111111111 |
    Then billing details page error message should be:
    """
     The billing country you provided does not match the country of the bank which issued your credit card.
    """
