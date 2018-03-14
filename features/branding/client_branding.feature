Feature: As a Mozy OEM partner Admin, I should be brand my own windows client

  Background:
    Given I log in bus admin console as administrator


  @TC.131667 @bus @tasks_p1
  Scenario: 131667 Client branding for newly created OEM partner
    When I add a new OEM partner:
      | Company Name                                    | Root role         | Company Type     |
      | Internal Mozy - BUS Regression Client Branding  | OEM Partner Admin | Service Provider |
    Then New partner should be created
    When I set product name for the partner
    Then The partner product name set up successfully
    And I stop masquerading as sub partner
    And I stop masquerading as sub partner

    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | false         |
    And I view version details for 2.28.0.421
    And I click Brandings tab of version details
    And I choose to rebuild executable for partner Internal Mozy - BUS Regression Client Branding
    And version info should be changed successfully
    Then executable for partner Internal Mozy - BUS Regression Client Branding should be rebuild successfully

    When I act as partner by:
      | name                                           | including sub-partners |
      | Internal Mozy - BUS Regression Client Branding | yes                    |
    And I navigate to Client Branding Wizard section from bus admin console page
    And I use branding version Windows 2.28.0.421
    And I use neutral as branding language
    And I choose file IDI_APPICON.ico for branding item IDI_APPICON
    And I choose file IDB_LOGO.bmp for branding item IDB_LOGO
    And I choose file IDB_INSTALLLOGO.bmp for branding item IDB_INSTALLLOGO
    Then I finish all the branding settings
    When I wait for branding finished
    Then branding build download link should be generated successfully

  @clean_up
  Scenario: clean up OEM test partner
    When I search and delete partner account if it exists by Internal Mozy - BUS Regression Client Branding
