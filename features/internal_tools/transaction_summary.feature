Feature:Transaction Summary in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122195 @bus @internal_tools @smoke @ROR_smoke
  Scenario: 122195 Open Transaction Summary
    #======step1: check the header on Transaction Summary table======
    Given I wait for 30 seconds
    When I navigate to Transaction Summary section from bus admin console page
    Then Transaction Summary table main header should be:
    | Date | Mozy Unlimited | MozyPro | DVD Orders | Data Shuttle Fees | Total |
    And Transaction Summary table sub header should be:
    | Biennial | Yearly | Monthly | Total |
    #======step2: download revenue report======
    And I download revenue report