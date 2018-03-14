Feature: Return unused resources

  Background:
    Given I log in bus admin console as administrator

  @TC.146 @bus @resources @tasks_p1 @ROR_smoke
  Scenario: 146 #7206 - returning resources from partner with custom license types results
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    Then Resources should be purchased
    And Current purchased resources should be:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    And I return resources:
      | desktop license | desktop quota | server license | server quota |
      | 55              | 55            | 100            | 100          |
    Then Resources should be returned
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @TC.12932 @bus @resources @tasks_p1
  Scenario: 12932 Return Resources From a Selected User Group
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 29              | 29            | 29             | 29           |
    Then Resources should be purchased
    And Current purchased resources should be:
      | desktop license | desktop quota | server license | server quota |
      | 29              | 29            | 29             | 29           |
    And I add a new user group for an itemized partner:
      | name      | server_assigned_quota | desktop_assigned_quota |
      | oem_group | 2                     | 2                      |
    Then Itemized partner user group oem_group should be created
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 29      | 0.0 (0.0 active) / 29.0 | 0 / 29       | 0.0 (0.0 active) / 29.0 |
      | oem_group              | 0     | 1      | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
    And I return resources:
      | user group              | desktop license | desktop quota | server license | server quota |
      | (default user group)    | 29              | 29            | 29             | 29           |
    Then Resources should be returned
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
      | oem_group              | 0     | 1      | 0 / 0       | 0.0 (0.0 active) / 0.0  | 0 / 0        | 0.0 (0.0 active) / 0.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name





