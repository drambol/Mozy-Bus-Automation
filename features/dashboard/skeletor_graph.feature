Feature: Skeletor Graph

  Background:
    Given I log in bus admin console as administrator

  @bus @skeletor @tasks_p3 @skeletor_graph
  Scenario: Skeletor graph exists
    When I clean up png files in downloads folder
    When I act as partner by:
      | email                  |
      | mozynext+root@mozy.com |
    When I download the partner backup overview img as file backup_overview_img.png
    Then the downloaded top img backup_overview_img.png should be same as the upload img backupoverview.png

