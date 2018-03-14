Feature: Transfer Resources

  Background:
    Given I log in bus admin console as administrator

  @TC.428 @tasks_p1 @resuorces @bus @ROR_smoke
  Scenario: 428 Transfer Resources
    When I add a new OEM partner:
      | Root role      | Company Type     |
      | OEM Root Trial | Service Provider |
    Then New partner should be created
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 10            | 10             | 10           |
    And I add a new user group for an itemized partner:
      | name      | server_assigned_quota | desktop_assigned_quota |
      | oem_group | 2                     | 2                     |
    Then Itemized partner user group oem_group should be created
    When I transfer resources from user group (default user group) to partner the same partner and user group oem_group with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 2               | 3              | 2                | 3               |
    Then Resources should be transferred
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 8       | 0.0 (0.0 active) / 7.0  | 0 / 8        | 0.0 (0.0 active) / 7.0  |
      | oem_group              | 0     | 1      | 0 / 2       | 0.0 (0.0 active) / 3.0  | 0 / 2        | 0.0 (0.0 active) / 3.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @TC.13085 @tasks_p1 @resuorces @bus
  Scenario: 13085 Transfer Resources Test
    When I add a new OEM partner:
      | company name      | Root role      | Company Type     |
      | TC.13085_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 99              | 99            | 99             | 99           |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          | Pricing Plan | Admin Name |
      | TC.13085_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I transfer resources from user group (default user group) to partner TC.13085_sub_partner and user group (default user group) with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 9               | 9              | 9                | 9               |
    Then Resources should be transferred
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 90      | 0.0 (0.0 active) / 90.0 | 0 / 90       | 0.0 (0.0 active) / 90.0 |
    And I act as partner by:
      | name                   |
      | TC.13085_sub_partner   |
    And I navigate to List User Groups section from bus admin console page
    Then User groups list table should be:
      | Name                   | Users | Admins | Server Keys | Server Quota            | Desktop Keys | Desktop Quota           |
      | (default user group) * | 0     | 1      | 0 / 9       | 0.0 (0.0 active) / 9.0  | 0 / 9        | 0.0 (0.0 active) / 9.0  |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.13085_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.13085_partner

  @TC.12819 @bus @partners_setting @tasks_p2
  Scenario: 12819 Additional quota purchased through data shuttle order appears under transfer resources
    When I add a new OEM partner:
      | Company Name         | Root role         | Company Type     |
      | TC.12819_oem_partner | OEM Partner Admin | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    Then I stop masquerading as sub partner
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | enforce_email_key_match | t     | false  |
    When I set product name for the partner
    Then I navigate to old window
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name     | email                |
      | oem user | tc12819test@mozy.com |
    And new itemized user should be created
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I update the user password to reset password
    Then I navigate to Assign Keys section from bus admin console page
    Then I assign Desktop key to user tc12819test@mozy.com on (default user group)
    Then I use key activation to activate devices
      | email                | machine_name  |
      | tc12819test@mozy.com | machine_12819 |
    Then Activate key response should be OK
    And I stop masquerading
    When I order data shuttle for TC.12819_oem_partner
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    And I act as partner by:
      | name                  |
      | TC.12819_oem_partner  |
    And I navigate to Transfer Resources section from bus admin console page
    Then available key and storage of group (default user group) from source user group should be (3 keys 30 GB)
    Then available key and storage of group (default user group) from target user group should be (3 keys 30 GB)
    And I stop masquerading
    And I search and delete partner account by newly created subpartner company name

  @TC.12816 @tasks_p2 @resuorces @bus
  Scenario: 12816 Existing keys assigned to data shuttle order don't appear under transfer resources of parent partner
    When I add a new OEM partner:
      | company name      | Root role      | Company Type     |
      | TC.12816_partner  | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 88              | 88            | 88             | 88           |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          | Pricing Plan | Admin Name |
      | TC.12816_sub_partner  | subplan      | subadmin   |
    Then New partner should be created
    And I transfer resources from user group (default user group) to partner TC.12816_sub_partner and user group (default user group) with:
      | server_licenses | server_storage | desktop_licenses | desktop_storage |
      | 8               | 8              | 8                | 8               |
    Then Resources should be transferred
    And I stop masquerading as sub partner
    And I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by TC.12816_sub_partner
    And I view partner details by TC.12816_sub_partner
    When I add partner settings
      | Name                    | Value | Locked |
      | enforce_email_key_match | t     | false  |
    When I set product name for the partner
    Then I navigate to old window
    When I act as partner by:
      | name                 |
      | TC.12816_sub_partner |
    And I add new itemized user(s):
      | name     | email                |
      | oem user | tc12816test@mozy.com |
    And new itemized user should be created
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I update the user password to reset password
    Then I navigate to Assign Keys section from bus admin console page
    Then I assign Desktop key to user tc12816test@mozy.com on (default user group)
    Then I use key activation to activate devices
      | email                | machine_name  |
      | tc12816test@mozy.com | machine_12816 |
    Then Activate key response should be OK
    And I stop masquerading
    When I order data shuttle for TC.12816_sub_partner
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  | quota |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available | 2     |
    Then Data shuttle order should be created
    When I act as partner by:
      | name             |
      | TC.12816_partner |
    And I navigate to Transfer Resources section from bus admin console page
    Then available key and storage of partner TC.12816_sub_partner from target partner should be (15 keys 14 GB)
    And I select TC.12816_sub_partner as target partner
    Then available key and storage of group (default user group) from target user group should be (15 keys 14 GB)
    And I stop masquerading
    And I search and delete partner account by TC.12816_sub_partner
    And I search and delete partner account by TC.12816_partner



