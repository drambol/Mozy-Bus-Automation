Feature: Assign keys

  Background:
    Given I log in bus admin console as administrator

  @TC.19255 @bus @resources @tasks_p1
  Scenario: 19255 Assign Keys OEM purchase resources
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 99            | 10             | 99           |
    And I navigate to Assign Keys section from bus admin console page
    Then assign keys summary information should be:
      | Total Account Storage: | Desktop Storage: | Server Storage: | Server:| Total Product Keys: | Desktop Devices: | Server Devices: |
      | 198 GB                 | 99 GB            | 99 GB           | Yes    | 20                  | 10               | 10              |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name
