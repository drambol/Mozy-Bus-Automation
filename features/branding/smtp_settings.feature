Feature: SMTP Settings
  As a Mozy partner Admin, I should be able to use my own smtp server to send mozy related emails

  @TC.122178 @bus @ROR_smoke
  Scenario: 122178 Add New SMTP Setting
    When I navigate to bus admin console login page
    And I use a existing partner:
      | company name             | admin email                              | partner type |
      |  TC.122139 [DO NOT EDIT] | mozyautotest+brandon+howard+1513@emc.com | Reseller     |
    And I log in bus admin console as new partner admin
    And I navigate to SMTP Settings section from bus admin console page
    Then I cleanup SMTP Setting
    And I input new SMTP Setting:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      | 127.0.0.1 | 25    | TLS        | LOGIN          | Mozy     | Test     |
    And I click SMTP Setting save changes button
    Then SMTP Settings change message should be: SMTP server settings were saved successfully.
    And I refresh SMTP Settings section
    Then SMTP Setting should be:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      | 127.0.0.1 | 25    | TLS        | LOGIN          | Mozy     | ****     |
    When I delete SMTP Setting
    Then SMTP Settings change message should be: SMTP server settings were deleted successfully.
    And SMTP Setting should be:
      |  Address  | Port  | Encryption | Authentication | Username | Password |
      |           | 25    | None       | None           |          |          |




