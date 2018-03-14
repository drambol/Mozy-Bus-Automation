Feature: Search

  Background:
    Given I have login freyja as home user

  @TC.120543 @freyja @freyja_smoke  @home @home_search  @home_search_files
Scenario: Home user search files through Freyja
  When I select the Synced tab
  When I enter search file keyword in search box
  And I click search
  Then search results is displayed
  When I select the Devices tab
  When I enter search file keyword in search box
  And I click search
  Then search results is displayed
  When I select options menu
  And I logout

@TC.120551 @freyja @freyja_smoke  @home @home_search  @home_search_folders
  Scenario: Home user search folders through Freyja
    When I select the Synced tab
    When I enter search folder keyword in search box
    And I click search
    Then search results is displayed
    When I select the Devices tab
    When I enter search folder keyword in search box
    And I click search
    Then search results is displayed
    When I select options menu
    And I logout