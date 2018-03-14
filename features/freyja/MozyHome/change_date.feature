Feature: Change Date

  Background:
    Given I have login freyja as home user

  @TC.120248 @freyja  @freyja_smoke @home  @home_change_date
Scenario: home user change date through Freyja
  When I select the Devices tab
  And I select the device
  And I open Actions panel
  And I click Change Date
  And I click Go
  When I select options menu
  And I logout
