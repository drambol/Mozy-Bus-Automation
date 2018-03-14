Feature: Change Date

  Background:
    Given I have login freyja as ent user

  @TC.121709 @freyja @freyja_smoke  @ent  @ent_change_date  @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user change date through Freyja
  When I select the Devices tab
  And I select the device
  And I open Actions panel
  And I click Change Date
  And I click Go
#  When I select options menu
#  And I logout
