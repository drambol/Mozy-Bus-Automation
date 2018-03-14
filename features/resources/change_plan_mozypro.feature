Feature: Change Plan for MozyPro Partners

  Background:
    Given I log in bus admin console as administrator

  # This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18730 @Bug.83813 @regression @core_function @bus @2.5 @change_plan @mozypro
  Scenario: 18730 Verify MozyPro monthly base plans info
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

# This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18731 @Bug.83813 @regression @core_function @bus @2.5 @change_plan @mozypro
  Scenario: 18731 Verify MozyPro yearly base plans info
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 10 GB     |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

  # This scenario is highly depend on our product plans, if scenario failed, please login bus and update plan table below
  @TC.18732 @Bug.83813 @regression @core_function  @bus @2.5 @change_plan @mozypro
  Scenario: 18732 Verify MozyPro biennially base plans info
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans should be:
      | plan   |
      | 10 GB  |
      | 50 GB  |
      | 100 GB |
      | 250 GB |
      | 500 GB |
      | 1 TB   |
      | 2 TB   |
      | 4 TB   |
      | 8 TB   |
      | 12 TB  |
      | 16 TB  |
      | 20 TB  |
      | 24 TB  |
      | 28 TB  |
      | 32 TB  |
  When I stop masquerading
  Then I search and delete partner account by newly created partner company name

  @TC.16485 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
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

  @TC.18424 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 18424 MozyPro monthly US partner 1 TB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 1 TB      |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18336 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 18336 MozyPro yearly UK partner 500 GB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan | country        | net terms |
      | 12     | 500 GB    | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then Change plan charge summary should be:
      | Description                     | Amount     |
      | Credit for remainder of 500 GB  | -$1,751.87 |
      | Charge for new 1 TB             | $3,503.87  |
      |                                 |            |
      | Total amount to be charged      | $1,752.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 1 TB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18443 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 18443 MozyPro yearly UK partner 500 GB moves to 250 GB plan
    When I add a new MozyPro partner:
      | period | base plan | country        | net terms |
      | 12     | 500 GB    | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 250 GB    |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.18248 @Smoke @Bug.84931 @bus @2.5 @change_plan @mozypro @regression @core_function
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

  @TC.18407 @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 18407 MozyPro biennially Ireland partner 2 TB moves to 1 TB plan
    When I add a new MozyPro partner:
      | period | base plan | country | cc number        |
      | 24     | 2 TB      | Ireland | 4319402211111113 |
    Then New partner should be created
    When I act as newly created partner account
    When I change MozyPro account plan to:
      | base plan |
      | 1 TB      |
    Then the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 1 TB      |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.17104 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
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

#  @TC.17105 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
#  Scenario: 17105 Add server storage add on to MozyPro monthly US partner
#    When I add a new MozyPro partner:
#      | period | base plan | net terms |
#      | 1      | 1 TB      | yes       |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I change MozyPro account plan to:
#      | storage add-on |
#      | 10             |
#    Then Change plan charge summary should be:
#      | Description                  | Amount   |
#      | Charge for new 250 GB Add-on | $949.90  |
#    And the MozyPro account plan should be changed
#    And MozyPro new plan should be:
#      | base plan | storage add-on |
#      | 1 TB      | 10             |
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name

  @TC.17274 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 17274 Add server plan option to MozyPro yearly UK partner
    When I add a new MozyPro partner:
      | period | base plan | country        | net terms |
      | 12     | 500 GB    | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for new Server Plan | $188.27 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

#  @TC.17275 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
#  Scenario: 17275 Add server storage add on to MozyPro yearly UK partner
#    When I add a new MozyPro partner:
#      | period | base plan | country        | net terms |
#      | 12     | 1 TB      | United Kingdom | yes       |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I change MozyPro account plan to:
#      | storage add-on |
#      | 10             |
#    Then Change plan charge summary should be:
#      | Description                  | Amount     |
#      | Charge for new 250 GB Add-on | $12,538.68 |
#    And the MozyPro account plan should be changed
#    And MozyPro new plan should be:
#      | base plan | storage add-on |
#      | 1 TB      | 10             |
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name

  @TC.17276 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
  Scenario: 17276 Add server plan option to MozyPro biennially Ireland partner
    When I add a new MozyPro partner:
      | period | base plan | country | cc number        |
      | 24     | 500 GB    | Ireland | 4319402211111113 |
    Then New partner should be created
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description                | Amount  |
      | Charge for new Server Plan | $365.05 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 500 GB    | Yes         |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

#  @TC.17277 @Smoke @bus @2.5 @change_plan @mozypro @regression @core_function
#  Scenario: 17277 Add server storage add on to MozyPro biennially Ireland partner
#    When I add a new MozyPro partner:
#      | period | base plan | country | cc number        |
#      | 24     | 1 TB      | Ireland | 4319402211111113 |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I change MozyPro account plan to:
#      | storage add-on |
#      | 10             |
#    Then Change plan charge summary should be:
#      | Description                  | Amount     |
#      | Charge for new 250 GB Add-on | $24,535.92 |
#    And the MozyPro account plan should be changed
#    And MozyPro new plan should be:
#      | base plan | storage add-on |
#      | 1 TB      | 10             |
#    When I stop masquerading
#    Then I search and delete partner account by newly created partner company name

#  @test_coupon @Bug.85011 @regression @core_function @2.0 @env_dependent
#  Scenario: MozyPro monthly US partner 10 GB moves to 1T GB plan with 10 percent inline coupon
#    When I add a new MozyPro partner:
#      | period | base plan |
#      | 1      | 10 GB     |
#    Then New partner should be created
#    When I act as newly created partner account
#    And I change MozyPro account plan to:
#      | base plan | server plan | storage add-on | coupon              |
#      | 1 TB      | yes         | 1              | test10pctUltdInline |
#    Then Change plan charge summary should be:
#      | Description                   | Amount  |
#      | Credit for remainder of 10 GB | -$9.99  |
#      | Charge for upgraded plans     | $454.47 |
#      |                               |         |
#      | Total amount to be charged    | $444.48 |
#    And the MozyPro account plan should be changed
#    And MozyPro new plan should be:
#      | base plan | server plan | storage add-on |
#      | 1 TB      | yes         | 1              |
#  When I stop masquerading
#  Then I search and delete partner account by newly created partner company name

  @TC.131841 @bus @change_plan @tasks_p3 @regression
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
