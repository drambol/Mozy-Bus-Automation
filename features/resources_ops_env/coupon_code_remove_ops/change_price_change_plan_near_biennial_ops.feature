Feature: change price change plan near biennial, running on ops env (pantheon / staging)

  Subscription:
   - Bugs #144165 Cannot increase resources in BUS, when we compare plans by price, we compare the "Default" USD price, not the price in use.
   - Requirement #141405 Changing price schedules in Aria, and how this is reflected in BUS
   - Requirement #143134 Aria coupon code remove: change period and change plan

   - As a Mozy Administrator
   - I upgrade from 1 plan with higher server plan to another plan with lower server plan
   - So that I change successfully without issues

   - old 100 GB with Server plan to new 250 GB with Server plan in USD&GBP yearly and Biennial
   - old 250 GB with Server plan to new 500 GB with Server plan in UDS&EURO&GBP yearly and Biennial
   - old 1 TB with Server plan to new 2 TB with Server plan in USD&GBP yearly and Biennial
   - old 2 TB with Server plan to 4 TB with Server plan USD&GBP yearly and Biennial

  Background:
    Given I log in bus admin console as administrator


  @TC.133676 @ops_env
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
