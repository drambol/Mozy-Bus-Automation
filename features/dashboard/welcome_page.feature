Feature: Dashboard welcome page

  Background:
    Given I log in bus admin console as administrator

  @TC.22217 @TC.22218 @TC.22219 @TC.22221 @TC.22222 @bus @dashboard @tasks_p3 @welcome_page @regression
  Scenario: 'Admin Features' links to the current pooled storage link
    And I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    And I act as newly created partner with welcome page poped up
    And I check welcome page for Admin Features link
    And I check welcome page for File Sync link
    And I check welcome page for Quick Start Guide link
    And I check welcome page for Download Mozy Software link
    And I check welcome page for Release Notes link


  @TC.21189 @bus @dashboard @tasks_p3 @welcome_page @regression
  Scenario: Mozy-21189:"Only show when updated" works
    And I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    And I act as newly created partner with welcome page poped up
    And I click start using mozy button
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account with welcome page poped up
    And I check show welcome checkbox
    And I click start using mozy button
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And I act as newly created partner account with welcome page poped up
    Then No welcome page poped up