Feature: View Event History

  Background:
    Given I have login freyja as home user

  @TC.120512 @freyja @freyja_smoke  @home  @home_event_history
Scenario: home user view event history through Freyja
  When I select options menu
  And I select event history
  And I choose the latest event
  Then detail panel slide in
  When I select options menu
  And I logout
