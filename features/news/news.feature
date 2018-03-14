Feature: News in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.22067 @bus @news @tasks_p1 @smoke @ROR_smoke
  Scenario: 22067:'New Features!' Section Link As The 'New Features' Link In The Take-over Welcome Page
    When I navigate to New Features! section from bus admin console page
    Then I navigate to new window
    Then I check the new window title is New Features

  @TC.22068 @bus @news @tasks_p1 @ROR_smoke
  Scenario: 22068:'Quick Start Guide' Section Link As The Quick Start Guide Link In The Take-over Welcome Page
    When I navigate to Quick Start Guide section from bus admin console page
    Then I navigate to new window
    Then I check the new window title is Administrator Quick Start

  @TC.22070 @bus @news @tasks_p1 @ROR_smoke
  Scenario: 22070:'Admin Console Release Notes' Link Unchangede
    When I navigate to Admin Console Release Notes section from bus admin console page
    Then I check the feature news-bus_release_notes is existed

  @TC.22071 @bus @news @tasks_p1 @ROR_smoke
  Scenario: 22071:'Product Release Notes' Link Unchanged
    When I navigate to Product Release Notes section from bus admin console page
    Then I check the feature news-release_notes is existed

  @TC.22072 @bus @news @tasks_p1 @ROR_smoke
  Scenario: 22072:'Maintenance/Outages' Link Unchanged
    When I navigate to Maintenance/Outages section from bus admin console page
    Then I navigate to new window
    Then I check the new window title is Mozy Support Main Home Page

  @TC.22069 @bus @news @tasks_p1 @ROR_smoke
  Scenario: 22069:'Learn About Sync' Link To CMS Page
    When I add a new Reseller partner:
      | period |
      | 12     |
    And New partner should be created
    And I act as newly created partner
    Then I navigate to Learn About Sync section from bus admin console page
    And I navigate to new window
    Then I check the new window title is File sync download for Windows and Mac | Mozy




