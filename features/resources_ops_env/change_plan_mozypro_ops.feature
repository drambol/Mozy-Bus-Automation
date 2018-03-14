Feature: Change Plan for MozyPro Partners, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.16485 @ops_env
  Scenario: 16485 MozyPro monthly US partner 10 GB moves to 50 GB plan
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 50 GB     |
    Then Change plan charge summary should be:
      | Description                   | Amount |
      | Credit for remainder of 10 GB | -$9.99 |
      | Charge for new 50 GB          | $19.99 |
      |                               |        |
      | Total amount to be charged    | $10.00 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 50 GB     |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.18248 @ops_env
  Scenario: 18248 MozyPro biennially Ireland partner 1 TB moves to 2 TB plan
    When I add a new MozyPro partner:
      | period | base plan | country | cc number        |
      | 24     | 1 TB      | Ireland | 4319402211111113 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 2 TB      |
    Then Change plan charge summary should be:
      | Description                  | Amount     |
      | Credit for remainder of 1 TB | -$6,863.14 |
      | Charge for new 2 TB          | $13,554.34 |
      |                              |            |
      | Total amount to be charged   | $6,691.20  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 2 TB      |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name


  @TC.17104 @ops_env
  Scenario: 17104 Add server plan option to MozyPro monthly US partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount |
      | Charge for new Server Plan | $3.99  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 10        | Yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


  @TC.131841 @ops_env
  Scenario: 131841 Change plan from plan with 50 GB add on to a plan with 250 add on or vise vessa
    When I add a new MozyPro partner:
      | period | base plan | net terms |storage add on 50 gb|
      | 1      | 250 GB    | yes       |    1               |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      |Credit for remainder of 250 GB  |  -$94.99 |
      |Charge for new 1 TB             | $379.99  |
      |                                |          |
      | Total amount to be charged     | $285.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 1 TB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
