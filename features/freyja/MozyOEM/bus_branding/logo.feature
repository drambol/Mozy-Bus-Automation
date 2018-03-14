Feature: BUS branding - logo

  As an Mozy administrator
  I want to change web logo
  So that oem users can have branded freyja page


  @TC @freyja @oem_add_logo
  Scenario: Successfully add logo
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | QA13 White label    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I choose Images/Icons tab
    And I upload the logo