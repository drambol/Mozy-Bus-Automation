Feature: Change Preference Settings

  Background:
    Given I have login freyja as home user

  @TC.120697 @freyja @freyja_smoke  @home  @home_preference
Scenario: Mozyhome user change preference settings through Freyja
  When I select options menu
  And I select Preferences
  And I choose Devices radio
  And I choose Yes for restore queue
  And I click save Preferences button
  Then freyja page should be Devices start
  Then freyja page should be enable restore queue
  When I select options menu
  And I select Preferences
  And I choose Synced radio
  And I choose No for restore queue
  And I click save Preferences button
  And I re-login
  Then freyja page should be Synced start
  Then freyja page should be enable restore queue
  When I select options menu
  And I logout