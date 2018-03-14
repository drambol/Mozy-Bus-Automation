Feature: New Links section on takeover welcome page

  Background:
    Given I log in bus admin console as administrator

  @TC.22221 @bus @bus @takeover_welcome @smoke @ROR @ROR_smoke
  Scenario: 22221 MozyPro - Download Mozy Software link to the admin console download page
    #======step1: create a mozypro partner======
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    #======step2: verify the welcome_takeover_enabled setting parameter======
    And I verify partner settings
      | Name                     | Value | Locked | Inherited |
      | welcome_takeover_enabled | t     | false  | true      |
    #======step3: click act as linke to get welcome page(popup window)======
    When I act as partner to get welcome page
    Then get welcome page title What's New?
    #======step4: click Download Mozy Software link on welcome page and navigate to the download mozy software section======
    And click Download Mozy Software link on welcome page