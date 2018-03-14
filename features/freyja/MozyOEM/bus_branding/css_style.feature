Feature: BUS branding - css style

  As an Mozy administrator
  I want to change web css style
  So that oem users can have branded freyja page


  @TC @freyja @oem_css_hex
  Scenario: Successfully change header and footer color hex
   Given I log in bus admin console as administrator
   When I act as partner by:
     | name                |
     | QA13 White label    |
   And I navigate to Web Access Site Branding section from bus admin console page
   When I input content color hex for header and footer
   And I save changes
   #Then I waited 1 minutes
   When I navigate to freyja oem login page
   And I login as a existing user
   Then freyja page is displayed
   #Then I waited 1 minutes

   Given I log in bus admin console as administrator
   When I act as partner by:
     | name                |
     | WhiteLabelTest-Subpartner    |
   And I navigate to Web Access Site Branding section from bus admin console page
   When I input content color hex for header and footer
   And I save changes
   #Then I waited 1 minutes
   When I navigate to freyja oem login page
   And I login as a existing sub-partner user
   Then freyja page is displayed
   #Then I waited 1 minutes

    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | WhiteLabelTest-Subpartner    |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I remove content color
    And I save changes
  #Then I waited 1 minutes
    When I navigate to freyja oem login page
    And I login as a existing sub-partner user
    Then freyja page is displayed
  #Then I waited 1 minutes

    Given I log in bus admin console as administrator
    When I act as partner by:
      | name                |
      | QA13 White label     |
    And I navigate to Web Access Site Branding section from bus admin console page
    When I remove content color
    And I save changes
  #Then I waited 1 minutes
    When I navigate to freyja oem login page
    And I login as a existing user
    Then freyja page is displayed
  #Then I waited 1 minutes

  @TC @freyja @oem_css_name
  Scenario: Successfully change header and footer color name
  Given I log in bus admin console as administrator
  When I act as partner by:
    | name                |
    | QA13 White label    |
  And I navigate to Web Access Site Branding section from bus admin console page
  When I input content color name for header and footer
  And I save changes
  #Then I waited 1 minutes
  When I navigate to freyja oem login page
  And I login as a existing user
  Then freyja page is displayed
  #Then I waited 1 minutes

  Given I log in bus admin console as administrator
  When I act as partner by:
    | name                |
    | WhiteLabelTest-Subpartner    |
  And I navigate to Web Access Site Branding section from bus admin console page
  When I input content color name for header and footer
  And I save changes
#Then I waited 1 minutes
  When I navigate to freyja oem login page
  And I login as a existing sub-partner user
  Then freyja page is displayed
#Then I waited 1 minutes

  Given I log in bus admin console as administrator
  When I act as partner by:
    | name                |
    | WhiteLabelTest-Subpartner    |
  And I navigate to Web Access Site Branding section from bus admin console page
  When I remove content color
  And I save changes
#Then I waited 1 minutes
  When I navigate to freyja oem login page
  And I login as a existing sub-partner user
  Then freyja page is displayed
#Then I waited 1 minutes

  Given I log in bus admin console as administrator
  When I act as partner by:
    | name                |
    | QA13 White label     |
  And I navigate to Web Access Site Branding section from bus admin console page
  When I remove content color
  And I save changes
#Then I waited 1 minutes
  When I navigate to freyja oem login page
  And I login as a existing user
  Then freyja page is displayed
#Then I waited 1 minutes
