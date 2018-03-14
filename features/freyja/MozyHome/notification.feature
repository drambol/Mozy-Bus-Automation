Feature: View Notification

  Background:
    Given I have login freyja as home user

  @TC.120701 @freyja @freyja_smoke  @home  @home_notification
Scenario: home user view Notification through Freyja
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
