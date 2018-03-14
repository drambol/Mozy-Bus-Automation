Feature: Admin Console Branding
  As a Mozy partner Admin, I should be able to brand areas in my admin console page

  Background:
    Given I log in bus admin console as administrator

  @TC.122402 @bus @ROR_smoke
  Scenario: 122402 Add Custom Text
    # existing partner is a OEM partner with subdomain_name 'osngbedo'
    When I use a existing partner:
      | company name                 | admin email                 | partner type | partner id |
      |  test_for_126029_DO_NOT_EDIT | mozybus+q0cusmjgv@gmail.com | OEM          | 3475729    |
    And I go to page https://osngbedo.mozypro.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then Navigation item Admin Console Branding should be available
    # dashboard link text should be changed if set dashboard link text in Text Header
    When I navigate to Admin Console Branding section from bus admin console page
    And I click Text tab in Admin Console Branding section
    And I open admin console text setting for header
    And I set Dashboard Link Text to DELL-EMC-TEST
    And I refresh the page
    And I wait for 5 seconds
    Then dashboard link text in global nav area should be DELL-EMC-TEST
    # clear the header text, dashboard link text should be default value DASHBOARD
    When I open admin console text setting for header
    And I clear text area of Dashboard Link Text
    And I refresh the page
    And I wait for 5 seconds
    Then dashboard link text in global nav area should be DASHBOARD
