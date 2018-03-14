Feature: Upload and delete files in Sync
  Background:
    Given I have login freyja as home user

  @TC.120361 @TC.120362 @freyja @freyja_smoke  @home  @home_upload_delete_one_file_Sync
  Scenario: home user upload and delete one file in Sync
    When I select the Synced tab
    And I open Actions panel
    And I click Upload Files
    And I upload one file
    Then one file is uploaded successfully
    And I choose the uploaded file
    And I click Delete and confirm
    Then deleted files isn't shown
    When I select options menu
    And I logout

