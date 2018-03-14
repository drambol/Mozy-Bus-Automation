Feature: Bugs #144165 Cannot increase resources in BUS, when we compare plans by price, we compare the "Default" USD price, not the price in use.
  Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS
  Requirement #143134 Aria coupon code remove: change period and change plan

  As a Mozy Administrator
  I upgrade from 1 plan with higher server plan to another plan with lower server plan
  So that I change successfully without issues

  old 100 GB with Server plan to new 250 GB with Server plan in USD&GBP yearly and Biennial
  old 250 GB with Server plan to new 500 GB with Server plan in UDS&EURO&GBP yearly and Biennial
  old 1 TB with Server plan to new 2 TB with Server plan in USD&GBP yearly and Biennial
  old 2 TB with Server plan to 4 TB with Server plan USD&GBP yearly and Biennial

  Background:
    Given I log in bus admin console as administrator

  @TC.133673 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 100 gb Biennial to 250 gb Biennial
    When I add a new MozyPro partner:
      | company name                                         | period | base plan | server plan | net terms |
      | DONOT MozyPro USD 100 gb Biennial to 250 gb Biennial | 24     | 100 GB    | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 100 GB | -$839.79  |
      | Charge for new 250 GB          | $1,399.79 |
      |                                |           |
      | Total amount to be charged     | $560.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.133674 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 250 gb Biennial to 100 gb Biennial
    When I add a new MozyPro partner:
      | company name                                             | period | base plan | server plan | net terms |
      | DONOT MozyPro USD new 250 gb Biennial to 100 gb Biennial | 24     | 250 GB    | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -$231.79 |
      | Charge for new Server Plan          | $272.79  |
      |                                     |          |
      | Total amount to be charged          | $41.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133675 @add_new_partner @mozypro @bus
  Scenario: MozyPro custom old USD 250 gb Biennial to 100 GB Biennial
    When I add a new MozyPro partner:
      | company name                                                  | period | country       |
      | DONOT EDIT MozyPro USD old 250 gb Biennial to 100 GB Biennial | 24     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, $209.79                       |
      | 50 GB, $419.79                       |
      | 100 GB, $839.79                      |
      | 250 GB, $1,994.79 (current purchase) |
      | 500 GB, $2,789.79                    |
      | 1 TB, $5,579.79                      |
      | 2 TB, $11,019.79                     |
      | 4 TB, $21,169.79                     |
      | 8 TB, $60,479.58                     |
      | 12 TB, $90,719.37                    |
      | 16 TB, $120,959.16                   |
      | 20 TB, $151,198.95                   |
      | 24 TB, $181,438.74                   |
      | 28 TB, $211,678.53                   |
      | 32 TB, $241,918.32                   |
    And Add-ons price should be Server Plan, $335.79
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -$335.79 |
      | Charge for new Server Plan          | $272.79  |
      |                                     |          |
      | Total amount to be charged          | $0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133676 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 100 gb Biennial to 250 gb Biennial
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | server plan | create under | country        | vat number  | net terms |
      | DONOT MozyPro UK 100 gb Biennial to 250 gb Biennial | 24     | 100 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -£566.79 |
      | Charge for new 250 GB          | £914.79  |
      |                                |          |
      | Total amount to be charged     | £348.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.133677 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 250 gb Biennial to 100 gb Biennial
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | server plan | create under | country        | vat number  | net terms |
      | DONOT MozyPro UK 250 gb Biennial to 100 gb Biennial | 24     | 250 GB    | yes         | MozyPro UK   | United Kingdom | GB117223643 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -£151.79 |
      | Charge for new Server Plan          | £188.79  |
      |                                     |          |
      | Total amount to be charged          | £37.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133678 @add_new_partner @mozypro @bus
  Scenario: MozyPro custom old UK 250 gb Biennial to 100 GB Biennial
    When I add a new MozyPro partner:
      | company name                                                 | period | create under | country        | cc number        |
      | DONOT EDIT MozyPro UK old 250 gb Biennial to 100 GB Biennial | 24     | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, £146.79                       |
      | 50 GB, £293.79                       |
      | 100 GB, £566.79                      |
      | 250 GB, £1,343.79 (current purchase) |
      | 500 GB, £1,823.79                    |
      | 1 TB, £3,646.79                      |
      | 2 TB, £7,202.79                      |
      | 4 TB, £13,836.79                     |
      | 8 TB, £38,261.58                     |
      | 12 TB, £57,392.37                    |
      | 16 TB, £76,523.16                    |
      | 20 TB, £95,653.95                    |
      | 24 TB, £114,784.74                   |
      | 28 TB, £133,915.53                   |
      | 32 TB, £153,046.32                   |
    And Add-ons price should be Server Plan, £230.79
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -£276.95 |
      | Charge for new Server Plan          | £226.55  |
      |                                     |          |
      | Total amount to be charged          | £0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133679 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 100 gb Biennial to 250 gb Biennial
    When I add a new MozyPro partner:
      | company name                                             | period | base plan | server plan | create under    | country | vat number  | net terms |
      | DONOT MozyPro Germany 100 gb Biennial to 250 gb Biennial | 24     | 100 GB    | yes         | MozyPro Germany | Germany | DE812321109 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount    |
      | Credit for remainder of 100 GB | -€650.79  |
      | Charge for new 250 GB          | €1,272.79 |
      |                                |           |
      | Total amount to be charged     | €622.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |

  @TC.133680 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 250 gb Biennial to 100 gb Biennial
    When I add a new MozyPro partner:
      | company name                                             | period | base plan | server plan | create under    | country | vat number  | net terms |
      | DONOT MozyPro Germany 250 gb Biennial to 100 gb Biennial | 24     | 250 GB    | yes         | MozyPro Germany | Germany | DE812321109 | yes       |
    And New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -€210.79 |
      | Charge for new Server Plan          | €209.79  |
      |                                     |          |
      | Total amount to be charged          | €0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133681 @add_new_partner @mozypro @bus
  Scenario: MozyPro custom old Germany 250 gb Biennial to 100 gb Biennial
    When I add a new MozyPro partner:
      | company name                                                 | period | create under    | country | cc number        |
      | DONOT MozyPro Germany old 250 gb Biennial to 100 gb Biennial | 24     | MozyPro Germany | Germany | 4188181111111112 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, €167.79                       |
      | 50 GB, €335.79                       |
      | 100 GB, €650.79                      |
      | 250 GB, €1,574.79 (current purchase) |
      | 500 GB, €2,536.79                    |
      | 1 TB, €5,072.79                      |
      | 2 TB, €10,017.79                     |
      | 4 TB, €19,245.79                     |
      | 8 TB, €46,619.58                     |
      | 12 TB, €69,929.37                    |
      | 16 TB, €93,239.16                    |
      | 20 TB, €116,548.95                   |
      | 24 TB, €139,858.74                   |
      | 28 TB, €163,168.53                   |
      | 32 TB, €186,478.32                   |
    And Add-ons price should be Server Plan, €272.79
    And I change MozyPro account plan to:
      | base plan |
      | 100 GB    |
    Then Change plan charge summary should be:
      | Description                         | Amount   |
      | Credit for remainder of Server Plan | -€324.62 |
      | Charge for new Server Plan          | €249.65  |
      |                                     |          |
      | Total amount to be charged          | €0.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 100 GB    | Yes         |

  @TC.133682 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 250 gb Biennial to 500 GB Biennial
    When I add a new MozyPro partner:
      | company name                                              | period | country       |
      | DONOT EDIT MozyPro USD 250 gb Biennial to 500 GB Biennial | 24     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, $209.79                       |
      | 50 GB, $419.79                       |
      | 100 GB, $839.79                      |
      | 250 GB, $1,994.79 (current purchase) |
      | 500 GB, $2,789.79                    |
      | 1 TB, $5,579.79                      |
      | 2 TB, $11,019.79                     |
      | 4 TB, $21,169.79                     |
      | 8 TB, $60,479.58                     |
      | 12 TB, $90,719.37                    |
      | 16 TB, $120,959.16                   |
      | 20 TB, $151,198.95                   |
      | 24 TB, $181,438.74                   |
      | 28 TB, $211,678.53                   |
      | 32 TB, $241,918.32                   |
    And Add-ons price should be Server Plan, $335.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$2,330.58 |
      | Charge for upgraded plans     | $3,086.58  |
      |                               |            |
      | Total amount to be charged    | $756.00    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.133683 @add_new_partner @mozypro @bus
  Scenario: MozyPro Germany 250 gb Biennial to 500 GB Biennial
    When I add a new MozyPro partner:
      | company name                                                  | period | create under    | country | net terms |
      | DONOT EDIT MozyPro Germany 250 gb Biennial to 500 GB Biennial | 24     | MozyPro Germany | Germany | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, €167.79                       |
      | 50 GB, €335.79                       |
      | 100 GB, €650.79                      |
      | 250 GB, €1,574.79 (current purchase) |
      | 500 GB, €2,536.79                    |
      | 1 TB, €5,072.79                      |
      | 2 TB, €10,017.79                     |
      | 4 TB, €19,245.79                     |
      | 8 TB, €46,619.58                     |
      | 12 TB, €69,929.37                    |
      | 16 TB, €93,239.16                    |
      | 20 TB, €116,548.95                   |
      | 24 TB, €139,858.74                   |
      | 28 TB, €163,168.53                   |
      | 32 TB, €186,478.32                   |
    And Add-ons price should be Server Plan, €272.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€2,198.62 |
      | Charge for upgraded plans     | €3,338.64  |
      |                               |            |
      | Total amount to be charged    | €1,140.02  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.133684 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 250 gb Biennial to 500 GB Biennial
    When I add a new MozyPro partner:
      | company name                                             | period | create under | country        | net terms |
      | DONOT EDIT MozyPro UK 250 gb Biennial to 500 GB Biennial | 24     | MozyPro UK   | United Kingdom | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Biennial)                   | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, £146.79                       |
      | 50 GB, £293.79                       |
      | 100 GB, £566.79                      |
      | 250 GB, £1,343.79 (current purchase) |
      | 500 GB, £1,823.79                    |
      | 1 TB, £3,646.79                      |
      | 2 TB, £7,202.79                      |
      | 4 TB, £13,836.79                     |
      | 8 TB, £38,261.58                     |
      | 12 TB, £57,392.37                    |
      | 16 TB, £76,523.16                    |
      | 20 TB, £95,653.95                    |
      | 24 TB, £114,784.74                   |
      | 28 TB, £133,915.53                   |
      | 32 TB, £153,046.32                   |
    And Add-ons price should be Server Plan, £230.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 500 GB    | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£1,889.50 |
      | Charge for upgraded plans     | £2,421.10  |
      |                               |            |
      | Total amount to be charged    | £531.60    |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |

  @TC.133685 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 1 TB Biennial to 2 TB Biennial
    When I add a new MozyPro partner:
      | company name                                          | period | country       |
      | DONOT EDIT MozyPro USD 1 TB Biennial to 2 TB Biennial | 24     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, $209.79                       |
      | 50 GB, $419.79                       |
      | 100 GB, $839.79                      |
      | 250 GB, $1,399.79                    |
      | 500 GB, $2,789.79                    |
      | 1 TB, $7,979.79 (current purchase)   |
      | 2 TB, $11,019.79                     |
      | 4 TB, $21,169.79                     |
      | 8 TB, $60,479.58                     |
      | 12 TB, $90,719.37                    |
      | 16 TB, $120,959.16                   |
      | 20 TB, $151,198.95                   |
      | 24 TB, $181,438.74                   |
      | 28 TB, $211,678.53                   |
      | 32 TB, $241,918.32                   |
#    And Add-ons price should be Server Plan, $629.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$8,609.58 |
      | Charge for upgraded plans     | $11,612.58 |
      |                               |            |
      | Total amount to be charged    | $3,003.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.133686 @add_new_partner @mozypro @bus
  Scenario: MozyPro France 1 TB Biennial to 2 TB Biennial
    When I add a new MozyPro partner:
      | company name                                             | period | create under   | country | cc number        |
      | DONOT EDIT MozyPro France 1 TB Biennial to 2 TB Biennial | 24     | MozyPro France | France  | 4485393141463880 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, €167.79                       |
      | 50 GB, €335.79                       |
      | 100 GB, €650.79                      |
      | 250 GB, €1,272.79                    |
      | 500 GB, €2,536.79                    |
      | 1 TB, €6,299.79 (current purchase)   |
      | 2 TB, €10,017.79                     |
      | 4 TB, €19,245.79                     |
      | 8 TB, €46,619.58                     |
      | 12 TB, €69,929.37                    |
      | 16 TB, €93,239.16                    |
      | 20 TB, €116,548.95                   |
      | 24 TB, €139,858.74                   |
      | 28 TB, €163,168.53                   |
      | 32 TB, €186,478.32                   |
#    And Add-ons price should be Server Plan, €419.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -€8,063.50 |
      | Charge for upgraded plans     | €12,667.90 |
      |                               |            |
      | Total amount to be charged    | €4,604.40  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.133687 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 1 TB Biennial to 2 TB Biennial
    When I add a new MozyPro partner:
      | company name                                         | period | create under | country        | cc number        |
      | DONOT EDIT MozyPro UK 1 TB Biennial to 2 TB Biennial | 24     | MozyPro UK   | United Kingdom | 4916783606275713 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 1 TB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 1 TB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, £146.79                       |
      | 50 GB, £293.79                       |
      | 100 GB, £566.79                      |
      | 250 GB, £914.79                      |
      | 500 GB, £1,823.79                    |
      | 1 TB, £5,144.79 (current purchase)   |
      | 2 TB, £7,202.79                      |
      | 4 TB, £13,836.79                     |
      | 8 TB, £38,261.58                     |
      | 12 TB, £57,392.37                    |
      | 16 TB, £76,523.16                    |
      | 20 TB, £95,653.95                    |
      | 24 TB, £114,784.74                   |
      | 28 TB, £133,915.53                   |
      | 32 TB, £153,046.32                   |
#    And Add-ons price should be Server Plan, £419.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 2 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -£6,677.50 |
      | Charge for upgraded plans     | £9,107.50  |
      |                               |            |
      | Total amount to be charged    | £2,430.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 2 TB      | Yes         |

  @TC.133688 @add_new_partner @mozypro @bus
  Scenario: MozyPro USD 2 TB Biennial to 4 TB Biennial
    When I add a new MozyPro partner:
      | company name                                          | period | country       |
      | DONOT EDIT MozyPro USD 2 TB Biennial to 4 TB Biennial | 24     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, $209.79                       |
      | 50 GB, $419.79                       |
      | 100 GB, $839.79                      |
      | 250 GB, $1,399.79                    |
      | 500 GB, $2,789.79                    |
      | 1 TB, $5,579.79                      |
      | 2 TB, $15,749.79 (current purchase)  |
      | 4 TB, $21,169.79                     |
      | 8 TB, $60,479.58                     |
      | 12 TB, $90,719.37                    |
      | 16 TB, $120,959.16                   |
      | 20 TB, $151,198.95                   |
      | 24 TB, $181,438.74                   |
      | 28 TB, $211,678.53                   |
      | 32 TB, $241,918.32                   |
#    And Add-ons price should be Server Plan, $839.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -$16,589.58 |
      | Charge for upgraded plans     | $21,902.58  |
      |                               |             |
      | Total amount to be charged    | $5,313.00   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.133689 @add_new_partner @mozypro @bus
  Scenario: MozyPro Ireland 2 TB Biennial to 4 TB Biennial
    When I add a new MozyPro partner:
      | company name                                              | period | create under    | country | cc number        |
      | DONOT EDIT MozyPro Ireland 2 TB Biennial to 4 TB Biennial | 24     | MozyPro Ireland | Ireland | 4319402211111113 |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Biennial) | Custom Old Standard | eur               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, €167.79                       |
      | 50 GB, €335.79                       |
      | 100 GB, €650.79                      |
      | 250 GB, €1,272.79                    |
      | 500 GB, €2,536.79                    |
      | 1 TB, €5,072.79                      |
      | 2 TB, €12,179.79 (current purchase)  |
      | 4 TB, €19,245.79                     |
      | 8 TB, €46,619.58                     |
      | 12 TB, €69,929.37                    |
      | 16 TB, €93,239.16                    |
      | 20 TB, €116,548.95                   |
      | 24 TB, €139,858.74                   |
      | 28 TB, €163,168.53                   |
      | 32 TB, €186,478.32                   |
#    And Add-ons price should be Server Plan, €629.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -€15,755.78 |
      | Charge for upgraded plans     | €24,491.24  |
      |                               |             |
      | Total amount to be charged    | €8,735.46   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.133690 @add_new_partner @mozypro @bus
  Scenario: MozyPro UK 2 TB Biennial to 4 TB Biennial
    When I add a new MozyPro partner:
      | company name                                         | period | create under | country        | net terms |
      | DONOT EDIT MozyPro UK 2 TB Biennial to 4 TB Biennial | 24     | MozyPro UK   | United Kingdom | yes       |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                    | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 2 TB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 2 TB Plan (Biennial) | Custom Old Standard | gbp               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                                 |
      | 10 GB, £146.79                       |
      | 50 GB, £293.79                       |
      | 100 GB, £566.79                      |
      | 250 GB, £914.79                      |
      | 500 GB, £1,823.79                    |
      | 1 TB, £3,646.79                      |
      | 2 TB, £9,974.79 (current purchase)   |
      | 4 TB, £13,836.79                     |
      | 8 TB, £38,261.58                     |
      | 12 TB, £57,392.37                    |
      | 16 TB, £76,523.16                    |
      | 20 TB, £95,653.95                    |
      | 24 TB, £114,784.74                   |
      | 28 TB, £133,915.53                   |
      | 32 TB, £153,046.32                   |
#    And Add-ons price should be Server Plan, £629.79
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 4 TB      | Yes         |
    Then Change plan charge summary should be:
      | Description                   | Amount      |
      | Credit for remainder of plans | -£12,725.50 |
      | Charge for upgraded plans     | £17,178.70  |
      |                               |             |
      | Total amount to be charged    | £4,453.20   |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 4 TB      | Yes         |

  @TC.133691 @add_new_partner @mozypro @bus
  Scenario: MozyPro US old 500 gb Biennial to 1 tb Biennial
    When I add a new MozyPro partner:
      | company name                                          | period | country       |
      | DONOT MozyPro US old 500 gb Biennial to 1 tb Biennial | 24     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 500 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                        | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 500 GB Plan (Biennial) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                   | Amount     |
      | Credit for remainder of plans | -$4,409.58 |
      | Charge for upgraded plans     | $6,026.58  |
      |                               |            |
      | Total amount to be charged    | $1,617.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 1 TB      | Yes         |
