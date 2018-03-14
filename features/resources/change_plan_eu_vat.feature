Feature: Mozypro customers from 28 EU countries change plan

  @TC.124587 @change_plan @eu
  Scenario: TC.124587 change plan Austria AT 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | security | create under   | net terms |
      | 1      | 10 GB     | yes         | Austria | Standard | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount  |
      | Credit for remainder of plans | -€13.18 |
      | Charge for upgraded plans     | €49.18  |
      |                               |         |
      | Total amount to be charged    | €36.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124588 @change_plan @eu
  Scenario: TC.124588 change plan Belgium BE 21
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | security | create under   | cc number        |
      | 1      | 50 GB     | yes         | Belgium | HIPAA    | MozyPro France | 5413271111111222 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | no          |
    Then Change plan charge message should be:
    """
    Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 50 GB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124589 @change_plan @eu
  Scenario: TC.124589 change plan Bulgaria BG 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number        |
      | 12     | 32 TB     | Bulgaria | 4169912111111121 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Charge for new Server Plan    | $284.27    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124590 @change_plan @eu @qa6_dependent
  Scenario: TC.124590 change plan Croatia HR 25
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country | security | create under   | cc number        |
      | 24     | 250 GB    | Croatia | HIPAA    | MozyPro France | 5437781111111222 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 250 GB | -€1,590.99 |
      | Charge for new 500 GB          | €3,170.99  |
      |                                |            |
      | Total amount to be charged     | €1,580.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124591 @change_plan @eu
  Scenario: TC.124591 change plan Cyprus CY 19
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country | create under    | net terms |
      | 1      | 500 GB    | Cyprus  | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 1 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 500 GB | -€178.49 |
      | Charge for upgraded plans      | €380.78  |
      |                                |          |
      | Total amount to be charged     | €202.29  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124592 @change_plan @eu @qa6_dependent
  Scenario: TC.124592 change plan Czech Republic CZ 21
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | net terms | country        | security | create under   |
      | 12     | 1 TB      | yes       | Czech Republic | HIPAA    | MozyPro France |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                  | Amount     |
      | Credit for remainder of 1 TB | -€3,212.42 |
      | Charge for upgraded plans    | €6,691.04  |
      |                              |            |
      | Total amount to be charged   | €3,478.62  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124593 @change_plan @eu @qa6_dependent
  Scenario: TC.124593 change plan Denmark DK 25
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country | create under    | net terms |
      | 24     | 2 TB      | Denmark | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                  | Amount      |
      | Credit for remainder of 2 TB | -€12,522.24 |
      | Charge for new 4 TB          | €24,057.24  |
      |                              |             |
      | Total amount to be charged   | €11,535.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 4 TB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124594 @change_plan @eu @qa6_dependent
  Scenario: TC.124594 change plan Estonia EE 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country | create under    | net terms |
      | 1      | 4 TB      | Estonia | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €35.99 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124595 @change_plan @eu
  Scenario: TC.124595 change plan Finland FI 24
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | security | create under   | net terms |
      | 12     | 8 TB      | yes         | 2              | Finland | HIPAA    | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 12 TB     | no          |
    Then Change plan charge summary should be:
      | Description                  | Amount      |
      | Credit for remainder of 8 TB | -€30,280.53 |
      | Charge for new 12 TB         | €45,420.79  |
      |                              |             |
      | Total amount to be charged   | €15,140.26  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 12 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124596 @change_plan @eu
  Scenario: TC.124596 change plan France FR 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under   | net terms |
      | 1      | 250 GB    | yes         | France  | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€105.58 |
      | Charge for upgraded plans     | €199.18  |
      |                               |          |
      | Total amount to be charged    | €93.60   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124597 @change_plan @eu
  Scenario: TC.124597 change plan Germany DE 19
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country  | create under    | net terms |
      | 24     | 500 GB    | Germany  | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 8 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 500 GB | -€3,018.78 |
      | Charge for upgraded plans      | €57,476.00 |
      |                                |            |
      | Total amount to be charged     | €54,457.22 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124598 @change_plan @eu
  Scenario: TC.124598 change plan for EL MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country | cc number        |
      | 1      | 10 GB     | yes         | Greece  | Greece          | 4532121111111111 |
    Then the order summary looks like:
      | Description           | Price  | Quantity | Amount |
      | 10 GB - Monthly       | €7.99  | 1        | €7.99  |
      | Server Plan - Monthly | €2.99  | 1        |	€2.99  |
      | Subscription Price    | €10.98 |          | €10.98 |
      | VAT                   | €2.53  |          | €2.53  |
      | Total Charge          | €13.51 |          | €13.51 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
       | email        |
       | @admin_email |
     And I change MozyPro account plan to:
       | base plan | server plan |
       | 24 TB     | no          |
     Then Change plan charge summary should be:
       | Description                   | Amount    |
       | Credit for remainder of 10 GB | -€9.83    |
       | Charge for new 24 TB          | €8,191.73 |
       |                               |           |
       | Total amount to be charged    | €8,181.90 |
     And the MozyPro account plan should be changed
     And MozyPro new plan should be:
       | base plan | server plan |
       | 24 TB     | no          |
     When I stop masquerading
     Then I search and delete partner account by newly created partner company name

  @TC.124599 @change_plan @eu
  Scenario: TC.124599 change plan for HU MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country | cc number        |
      | 12     | 50 GB     | yes         | Hungary | Hungary         | 4333112111111111 |
    Then the order summary looks like:
      | Description          | Price   | Quantity | Amount  |
      | 50 GB - Annual       | €175.89 | 1        | €175.89 |
      | Server Plan - Annual | €60.39  | 1        |	€60.39  |
      | Subscription Price   | €236.28 |          | €236.28 |
      | VAT                  | €63.80  |          | €63.80  |
      | Total Charge         | €300.08 |          | €300.08 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 28 TB     |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -€300.08    |
      | Charge for upgraded plans     | €112,456.54 |
      |                               |             |
      | Total amount to be charged    | €112,156.46 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 28 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124600 @change_plan @eu @qa6_dependent
  Scenario: TC.124600 change plan for IE 23 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | coupon              | country | billing country | cc number        |
      | 24     | 100 GB    | 10PERCENTOFFOUTLINE | Ireland | Ireland         | 4319402211111113 |
    Then the order summary looks like:
      | Description        | Price    | Quantity | Amount   |
      | 100 GB - Biennial  | €650.79  | 1        | €650.79  |
      | Subscription Price | €650.79  |          | €650.79  |
      | Discounts          | - €65.08 |          | - €65.08 |
      | Subtotal           | €585.71  |          | €585.71  |
      | VAT                | €134.71  |          | €134.71  |
      | Total Charge       | €720.42  |          | €720.42  |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 32 TB     | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of 100 GB | -€720.42    |
      | Charge for upgraded plans      | €213,868.68 |
      |                                |             |
      | Total amount to be charged     | €213,148.26 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 32 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124601 @change_plan @eu
  Scenario: TC.124601 change plan for IT MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | billing country | cc number        |
      | 1      | 500 GB    | Italy   | Italy           | 4916921703777575 |
    Then the order summary looks like:
      | Description        | Price   | Quantity | Amount  |
      | 500 GB - Monthly   | €149.99 | 1        | €149.99 |
      | Subscription Price | €149.99 |          | €149.99 |
      | VAT                | €33.00  |          | €33.00  |
      | Total Charge       | €182.99 |          | €182.99 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €12.19 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124602 @change_plan @eu
  Scenario: TC.124602 change plan for Latvia LV MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country | cc number        |
      | 12     | 500 GB    | yes         | Latvia  | Latvia          | 4405211111111122 |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 500 GB - Annual      | €1,327.89 | 1        | €1,327.89 |
      | Server Plan - Annual | €141.89   | 1        | €141.89   |
      | Subscription Price   | €1,469.78 |          | €1,469.78 |
      | VAT                  | €308.66   |          | €308.66   |
      | Total Charge         | €1,778.44 |          | €1,778.44 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | no          |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124603 @change_plan @eu
  Scenario: TC.124603 change plan for LT 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country   | billing country | cc number        |
      | 24     | 1 TB      | yes         | Lithuania | Lithuania       | 4797121111111111 |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 1 TB - Biennial        | €5,072.79 | 1        | €5,072.79 |
      | Server Plan - Biennial | €405.79   | 1        | €405.79   |
      | Subscription Price     | €5,478.58 |          | €5,478.58 |
      | VAT                    | €1,150.51 |          | €1,150.51 |
      | Total Charge           | €6,629.09 |          | €6,629.09 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan |
      | 16 TB     |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of plans  | -€6,629.09  |
      | Charge for upgraded plans      | €116,883.96 |
      |                                |             |
      | Total amount to be charged     | €110,254.87 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 16 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124604 @change_plan @eu @qa6_dependent
  Scenario: TC.124604 change plan for Luxembourg LU 17 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country    | billing country | cc number        |
      | 1      | 1 To      | Luxembourg | Luxembourg      | 4779531111111121 |
    Then the order summary looks like:
      | Description             | Prix    | Quantité | Montant |
      | 1 To - Mensuel          | 299,99€ | 1        | 299,99€ |
      | Prix d'abonnement       | 299,99€ |          | 299,99€ |
      | TVA                     | 51,00€  |          | 51,00€  |
      | Montant total des frais | 350,99€ |          | 350,99€ |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 100 GB    | yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | €11.69 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124605 @change_plan @eu
  Scenario: TC.124605 change plan for Malta LT 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country | cc number        |
      | 12     | 500 GB    | yes         | Malta   | Malta           | 4313801111111121 |
    Then the order summary looks like:
      | Description          | Price     | Quantity | Amount    |
      | 500 GB - Annual      | €1,327.89 | 1        | €1,327.89 |
      | Server Plan - Annual | €141.89   | 1        | €141.89   |
      | Subscription Price   | €1,469.78 |          | €1,469.78 |
      | VAT                  | €264.56   |          | €264.56   |
      | Total Charge         | €1,734.34 |          | €1,734.34 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | server plan |
      | no          |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124606 @change_plan @eu
  Scenario: TC.124606 change plan for Netherlands 21 MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country     | billing country | cc number        |
      | 24     | 500 GB    | yes         | Netherlands | Netherlands     | 5100291111111111 |
    Then the order summary looks like:
      | Description            | Price     | Quantity | Amount    |
      | 500 GB - Biennial      | €2,536.79 | 1        | €2,536.79 |
      | Server Plan - Biennial | €268.79   | 1        | €268.79   |
      | Subscription Price     | €2,805.58 |          | €2,805.58 |
      | VAT                    | €589.18   |          | €589.18   |
      | Total Charge           | €3,394.76 |          | €3,394.76 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 20 TB     | no          |
    Then Change plan charge summary should be:
      | Description                    | Amount      |
      | Credit for remainder of 500 GB | -€3,069.52  |
      | Charge for new 20 TB           | €141,024.23 |
      |                                |             |
      | Total amount to be charged     | €137,954.71 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 20 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124607 @change_plan @eu
  Scenario: TC.124607 change plan Poland PL 23
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under    | net terms |
      | 1      | 28 TB     | yes         | 2              | Poland  | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 32 TB     |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€9,901.32 |
      | Charge for upgraded plans     | €11,315.80 |
      |                               |            |
      | Total amount to be charged    | €1,414.48  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 32 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124608 @change_plan @eu
  Scenario: TC.124608 change plan Portugal PT 23
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country  | create under    | cc number        |
      | 12     | 24 TB     | yes         | 1              | Portugal | MozyPro Ireland | 4556581910687747 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 16 TB     |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 16 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124609 @change_plan @eu
  Scenario: TC.124609 change plan Romania Ro 24
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | storage add on | country | create under   | net terms |
      | 24     | 20 TB     | 7              | Romania | MozyPro France | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 28 TB     | yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount       |
      | Credit for remainder of 20 TB | -€144,520.70 |
      | Charge for upgraded plans     | €209,618.36  |
      |                               |              |
      | Total amount to be charged    | €65,097.66   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 28 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124610 @change_plan @eu
  Scenario: TC.124610 change plan Slovakia SK 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | storage add on | country  | create under   | cc number        |
      | 1      | 16 TB     | 5              | Slovakia | MozyPro France | 4544170111111122 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 250 GB    | yes         |
    Then Change plan charge message should be:
    """
      Are you sure you want to change your Mozy plan? If you choose to continue, your account will automatically be charged for the new plan quantities for the remainder of your current subscription period.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124611 @change_plan @eu  @qa6_dependent
  Scenario: TC.124611 change plan Slovenia SI 22
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country  | create under    | net terms |
      | 12     | 100 GB    | yes         | Slovenia | MozyPro Ireland | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 4 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€549.96   |
      | Charge for upgraded plans     | €12,724.34 |
      |                               |            |
      | Total amount to be charged    | €12,174.38 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124612 @change_plan @eu
  Scenario: TC.124612 change plan Spain ES 21
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under    | net terms |
      | 24     | 16 TB     | yes         | 10             | Spain   | MozyPro Germany | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 20 TB     |
    Then Change plan charge summary should be:
      | Description                   | Amount       |
      | Credit for remainder of plans | -€116,883.96 |
      | Charge for upgraded plans     | €146,104.96  |
      |                               |              |
      | Total amount to be charged    | €29,221.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 20 TB     | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124613 @change_plan @eu
  Scenario: TC.124613 change plan Sween SE 25
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country | create under | cc number        |
      | 1      | 20 TB     | yes         | 8              | Sweden  | MozyPro UK   | 4581092111111122 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | no          |
    Then Change plan charge message should be:
    """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
    """
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 20 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124614 @change_plan @eu
  Scenario:TC.124614 change plan United Kingdom UK 20
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country        | create under | net terms |
      | 12     | 100 GB    | yes         | United Kingdom | MozyPro UK   | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -£474.94  |
      | Charge for upgraded plans     | £1,268.14 |
      |                               |           |
      | Total amount to be charged    | £793.20   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.124615 @change_plan @eu
  Scenario:TC.124615 change plan United Kingdom UK 20 with VAT number
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country        | create under | cc number        | vat number  |
      | 12     | 100 GB    | yes         | United Kingdom | MozyPro UK   | 4916783606275713 | GB117223643 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -£395.78  |
      | Charge for upgraded plans     | £1,056.78 |
      |                               |           |
      | Total amount to be charged    | £661.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.131998 @change_plan @eu
  Scenario:TC.131998 change plan Ireland IE 23 with VAT number
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under    | net terms | vat number |
      | 24     | 250 GB    | yes         | Ireland | MozyPro Ireland | yes       | IE9691104A |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€1,824.80 |
      | Charge for upgraded plans     | €6,738.65  |
      |                               |            |
      | Total amount to be charged    | €4,913.85  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.131999 @change_plan @eu
  Scenario: TC.131999 change plan France FR 20 with VAT number
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under   | net terms | vat number    |
      | 1      | 250 GB    | yes         | France  | MozyPro France | yes       | FR08410091490 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount   |
      | Credit for remainder of plans | -€87.98  |
      | Charge for upgraded plans     | €165.98  |
      |                               |          |
      | Total amount to be charged    | €78.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.132000 @change_plan @eu
  Scenario: TC.132000 change plan Germany DE 19 with VAT number
    When I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | country  | create under    | net terms | vat number  |
      | 24     | 500 GB    | Germany  | MozyPro Germany | yes       | DE811304768 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 8 TB      | yes         |
    Then Change plan charge summary should be:
      | Description                    | Amount     |
      | Credit for remainder of 500 GB | -€2,536.79 |
      | Charge for upgraded plans      | €48,299.16 |
      |                                |            |
      | Total amount to be charged     | €45,762.37 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 8 TB      | yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name