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

  @TC.125292 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=us
  Scenario: 125292 Add a new US 50 GB monthly basic MozyPro partner us_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 50 GB     | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description     | Price  | Quantity | Amount |
      | 50 GB - Monthly | $19.99 | 1        | $19.99 |
      | Total Charge    | $19.99 |          | $19.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125293 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=us
  Scenario: 125293 Add a new US 500 GB biennial basic MozyPro partner us_us_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 500 GB    | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description       | Price     | Quantity | Amount    |
      | 500 GB - Biennial | $2,789.79 | 1        | $2,789.79 |
      | Total Charge      | $2,789.79 |          | $2,789.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125294 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 125294 Add a new US 50 GB yearly basic MozyPro partner us_fr_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description    | Price   | Quantity | Amount  |
      | 50 GB - Annual | $219.89 | 1        | $219.89 |
      | Total Charge   | $219.89 |          | $219.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125295 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=us
  Scenario: 125295 Add a new US 500 GB yearly basic MozyPro partner us_fr_us
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 500 GB    | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description     | Price     | Quantity | Amount    |
      | 500 GB - Annual | $1,459.89 | 1        | $1,459.89 |
      | Total Charge    | $1,459.89 |          | $1,459.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125296 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=us
  Scenario: 125296 Add a new US 50 GB biennial basic MozyPro partner us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 50 GB     | United States | France          | 4018121111111122 |
    Then the order summary looks like:
      | Description      | Price   | Quantity | Amount  |
      | 50 GB - Biennial | $419.79 | 1        | $419.79 |
      | Total Charge     | $419.79 |          | $419.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125297 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=us
  Scenario: 125297 Add a new US 250 GB biennial basic MozyPro partner us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | server plan | cc number        |
      | 24     | 250 GB    | United States | France          | yes         | 4018121111111122 |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 250 GB - Biennial      | $1,399.79 | 1        | $1,399.79 |
      | Server Plan - Biennial | $231.79   | 1        | $231.79   |
      | Total Charge           | $1,631.58 |          | $1,631.58 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125298 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=us
  Scenario: 125298 Add a new US 500 GB monthly basic MozyPro partner us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | coupon              | cc number        |
      | 1      | 500 GB    | United States | France          | 10PERCENTOFFOUTLINE | 4018121111111122 |
    Then the order summary looks like:
      | Description        | Price    | Quantity | Amount   |
      | 500 GB - Monthly   | $189.99  | 1        | $189.99  |
      | Subscription Price | $189.99  |          | $189.99  |
      | Discounts          | - $19.00 |          | - $19.00 |
      | Total Charge       | $170.99  |          | $170.99  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125299 @phoenix @mozypro @profile_country=us @ip_country=us @billing_country=fr @bin_country=us
  Scenario: 125299 Add a new US 500 GB yearly basic MozyPro partner us_us_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | server plan | coupon              | cc number        |
      | 12     | 500 GB    | United States | France          | yes         | 10PERCENTOFFOUTLINE | 4018121111111122 |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 500 GB - Annual      | $1,459.89 | 1        | $1,459.89 |
      | Server Plan - Annual | $156.89   | 1        | $156.89   |
      | Subscription Price   | $1,616.78 |          | $1,616.78 |
      | Discounts            | - $161.68 |          | - $161.68 |
      | Total Charge         | $1,455.10 |          | $1,455.10 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125300 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=cn @bin_country=us
  Scenario: 125300 Add a new US 100 GB monthly basic MozyPro partner us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 100 GB    | United States | China           | 4018121111111122 |
    Then the order summary looks like:
      | Description      | Price  | Quantity | Amount |
      | 100 GB - Monthly | $39.99 | 1        | $39.99 |
      | Total Charge     | $39.99 |          | $39.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125301 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=cn @bin_country=us
  Scenario: 125301 Add a new US 250 GB biennial basic MozyPro partner us_jp_cn
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 250 GB    | United States | China           | 4018121111111122 |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 250 GB - Biennial      | $1,399.79 | 1        | $1,399.79 |
      | Total Charge           | $1,399.79 |          | $1,399.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125302 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=cn @bin_country=us
  Scenario: 125302 Add a new US 100 GB yearly basic MozyPro partner us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 100 GB    | United States | China           | 4018121111111122 |
    Then the order summary looks like:
      | Description     | Price   | Quantity | Amount  |
      | 100 GB - Annual | $439.89 | 1        | $439.89 |
      | Total Charge    | $439.89 |          | $439.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125303 @phoenix @mozypro @profile_country=us @ip_country=fr @billing_country=cn @bin_country=us
  Scenario: 125303 Add a new US 250 GB yearly basic MozyPro partner us_fr_cn
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 250 GB    | United States | China           | 4018121111111122 |
    Then the order summary looks like:
      | Description     | Price   | Quantity | Amount  |
      | 250 GB - Annual | $729.89 | 1        | $729.89 |
      | Total Charge    | $729.89 |          | $729.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125304 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=fr @bin_country=us
  Scenario: 125304 Add a new US 100 GB biennial basic MozyPro partner us_jp_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 24     | 100 GB    | United States | France          | 4018121111111122 |
    Then the order summary looks like:
      | Description            | Price   | Quantity | Amount  |
      | 100 GB - Biennial      | $839.79 | 1        | $839.79 |
      | Total Charge           | $839.79 |          | $839.79 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.125305 @phoenix @mozypro @profile_country=us @ip_country=jp @billing_country=fr @bin_country=us
  Scenario: 125305 Add a new US 250 GB monthly basic MozyPro partner us_jp_fr
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 1      | 250 GB    | United States | France          | 4018121111111122 |
    Then the order summary looks like:
      | Description      | Price  | Quantity | Amount |
      | 250 GB - Monthly | $94.99 | 1        | $94.99 |
      | Total Charge     | $94.99 |          | $94.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
