Feature: Change Password

  Background:
    Given I have login freyja as ent user

  @TC.121713 @freyja @freyja_smoke  @ent  @ent_change_password @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user change password through Freyja
  When I select options menu
  And I click Change password
  And I change the old password to the new password
  Then Password changed message should be Your password has been changed.
  And I change password successfully
  When I select options menu
  And I click Change password
  And I change the old password to the new password again
  Then Password changed message should be Your password has been changed.
  And I change password successfully
  When I select options menu
  And I logout