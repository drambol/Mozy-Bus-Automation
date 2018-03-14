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
#  4485393141463880: FR
#  4916783606275713: UK
#---------------------------------------------------------------------------------

  @TC.125273 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125273 Add a new FR monthly basic MozyPro partner credit card not match fr_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number | cc number        |
      | 1      | 100 Go    | France  | France          | IE9691104A | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.125274 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk @bin_country=fr @negative_test
  Scenario: 125274 Add a new FR biennial basic MozyPro partner invalid VAT number fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           | cc number        |
      | 24     | 10 Go     | France  | United Kingdom  | FR08410091490Invalid | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.125275 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125275 Add a new FR monthly basic MozyPro partner invalid coupon fr_uk_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | coupon      | cc number        |
      | 1      | 50 Go     | France  | France          | 5percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Code du coupon non valide
    """

  @TC.125276 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125276 Add a new FR monthly basic MozyPro partner invalid VAT number fr_uk_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | vat number           | cc number        |
      | 1      | 250 Go    | France  | France          | FR08410091490Invalid | 4485393141463880 |
    Then vat error message should be:
    """
     Le numéro de TVA n’est pas valide. Veuillez réessayer.
    """

  @TC.125277 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us @bin_country=fr @negative_test
  Scenario: 125277 Add a new US biennial basic MozyPro partner invalid coupon us_fr_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon      | cc number        |
      | 24     | 50 GB     | United States | United States   | 5percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.125278 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125278 Add a new US biennial basic MozyPro partner invalid coupon us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon       | cc number        |
      | 24     | 50 GB     | United States | United States   | 10percentoff | 4485393141463880 |
    Then mozy plan page error message should be:
    """
    Invalid coupon code
    """

  @TC.125279 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=uk @bin_country=fr @negative_test
  Scenario: 125279 Add a new FR monthly basic MozyPro partner invalid location fr_uk_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 100 Go    | France  | Royaume-Uni     | 4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """

  @TC.125280 @phoenix @mozypro @profile_country=fr @ip_country=uk @billing_country=it @bin_country=fr @negative_test
  Scenario: 125280 Add a new FR monthly basic MozyPro partner invalid location fr_uk_it
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |cc number        |
      | 1      | 100 Go    | France  | Italie          |4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """

  @TC.125281 @phoenix @mozypro @profile_country=fr @ip_country=us @billing_country=us @bin_country=fr @negative_test
  Scenario: 125281 Add a new FR monthly basic MozyPro partner invalid location fr_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country |cc number        |
      | 1      | 100 Go    | France  | États-Unis      |4485393141463880 |
    Then payment information page error message should be:
    """
     Échec de validation du pays de contact, de facturation, et du numéro de TVA.
    """


  #bug 130090. Actually got: "Could not validate payment information."
  @TC.125282 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=fr @bin_country=fr @negative_test
  Scenario: 125282 Add a new US monthly basic MozyPro partner invalid location us_fr_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 100 GB    | United States | France          | 4485393141463880 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.125283 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=it @bin_country=it @negative_test
  Scenario: 125283 Add a new US monthly basic MozyPro partner invalid location us_fr_it
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 100 GB    | United States | Italy           | 4916921703777575 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.125284 @phoenix @mozypro @profile_country=fr @ip_country=fr @billing_country=uk @bin_country=uk
  Scenario: 125284 Add a new FR biennial basic MozyPro partner credit card not match fr_fr_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 24     | 500 Go    | France  | Royaume-Uni     | 4916783606275713 |
    Then payment information page error message should be:
    """
    Impossible de valider les informations de paiement. Veuillez s'il vous plait vous assurer que votre pays de résidence corresponde au pays de la banque qui a produit votre carte de crédit.
    """

  #bug 130090.Actually got: "Could not validate payment information."
  @TC.125285 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=fr
  Scenario: 125285 Add a new US monthly basic MozyPro partner credit card not match us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 1 TB      | United States | France          | 4485393141463880 |
    Then payment information page error message should be:
    """
    Could not validate payment information. Please make sure your country of residence matches the country of the bank which issued your credit card.
    """
  @TC.125286 @phoenix @mozypro @profile_country=de @ip_country=us @billing_country=us @bin_country=fr @negative_test
  Scenario: 125286 Add a new DE monthly basic MozyPro partner invalid location de_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country    | cc number        |
      | 1      | 100 GB    | Germany | Vereinigte Staaten | 4485393141463880 |
    Then payment information page error message should be:
    """
     Das Land des Ansprechpartners, das Land der Zahlung und die Umsatzsteuer konnten nicht bestätigt werden
    """

  @TC.125287 @phoenix @mozypro @profile_country=de @ip_country=us @billing_country=de @bin_country=fr @negative_test
  Scenario: 125287 Add a new DE monthly basic MozyPro partner credit card not match de_us_de
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country    | cc number        |
      | 1      | 100 GB    | Germany | Deutschland        | 4485393141463880 |
    Then payment information page error message should be:
    """
    Zahlungsangaben konnten nicht bestätigt werden. Bitte überprüfen SIe, dass Ihre Rechnungsadresse mit dem Ausstellungsland Ihrer Kreditkarte übereinstimmt
    """

  @TC.125288 @phoenix @mozypro @profile_country=uk @ip_country=us @billing_country=us @bin_country=uk @negative_test
  Scenario: 125288 Add a new UK monthly basic MozyPro partner invalid location uk_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | United Kingdom | United States   | 4916783606275713 |
    Then payment information page error message should be:
    """
     Failed to validate contact country, billing country, and VAT number
    """

  @TC.125289 @phoenix @mozypro @profile_country=uk @ip_country=us @billing_country=uk @bin_country=fr @negative_test
  Scenario: 125289 Add a new UK monthly basic MozyPro partner credit card not match uk_us_uk
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country        | billing country | cc number        |
      | 1      | 100 GB    | United Kingdom | United Kingdom  | 4485393141463880 |
    Then payment information page error message should be:
    """
    Could not validate payment information. Please make sure your country of residence matches the country of the bank which issued your credit card.
    """
