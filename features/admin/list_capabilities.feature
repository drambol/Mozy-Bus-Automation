Feature: List capabilities

  Background:
    #Given I log in bus admin console as administrator

  @TC.122149 @bus @admin @tasks_p1
   Scenario: 122149 View List Capabilities
    When I navigate to bus admin console login page
    And I log in bus admin console with user name bus01_admin and password bus01_pass
    And I navigate to List Capabilities section from bus admin console page
    Then The list capabilities column names would be
      | ID | Name | Category |
    And capabilities name is linkable

