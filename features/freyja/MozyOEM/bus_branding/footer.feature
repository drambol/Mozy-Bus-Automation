Feature: BUS branding - footer

  As an Mozy administrator
  I want to change web footer
  So that oem users can have branded freyja page


  @TC @freyja @oem_add_footer
  Scenario: Successfully add footer
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | QA13 White label    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I choose Footer tab
    And I input Footer
    And I save changes
    #When I navigate to freyja oem login page
    #And I login as a existing user
    #Then freyja page is displayed

    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | WhiteLabelTest-Subpartner    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I choose Footer tab
    And I input sub-partner Footer
    And I save changes
    #When I navigate to freyja oem login page
    #And I login as a existing sub-partner user
    #Then freyja page is displayed

  @TC @freyja @oem_remove_footer
  Scenario: Successfully remove footer
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | WhiteLabelTest-Subpartner    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I choose Footer tab
    And I remove footer
    And I save changes
    #When I navigate to freyja oem login page
    #And I login as a existing sub-partner user
    #Then freyja page is displayed

    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | QA13 White label    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I choose Footer tab
    And I remove footer
    And I save changes
    #When I navigate to freyja oem login page
    #And I login as a existing user
    #Then freyja page is displayed