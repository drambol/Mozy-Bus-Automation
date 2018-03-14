Feature: View Notification

  Background:
    Given I have login freyja as ent user

  @TC.121714 @freyja @freyja_smoke  @ent  @ent_notification @ent_smoke @QA12 @QA6 @std @prd
Scenario: MozyEnterprise user view Notification through Freyja
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
  And I click notification
  Then notification detail slide in
  When I select options menu
  And I logout
