Feature: Change Preference Settings

  Background:
    Given I have login freyja as ent user

  @TC.121712 @freyja @freyja_smoke  @ent  @ent_preference  @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user change preference settings through Freyja
  When I select options menu
  And I select Preferences
  And I choose Devices radio
  And I choose Yes for restore queue
  And I click save Preferences button
  And I re-login
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
#  When I select options menu
#  And I logout