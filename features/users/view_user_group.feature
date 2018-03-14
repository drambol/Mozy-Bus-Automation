Feature: view user group

  Background:
    Given I log in bus admin console as administrator

  @TC.18995 @BSA.3030 @bus @2.5 @user_stories @stash @need_test_account @env_dependent @regression @core_function
  Scenario: 18995 [Search/List Users View][P]"Sync" column shows and has valid value
    When I act as partner by:
      | email                        |
      | test3010_3030_3040@auto.com  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                   | Name           | User Group           | Sync     |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled |
      | backup@test.com        | backup         | backup               | Disabled |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  |
      | stash@test.com         | stash          | stash                | Enabled  |

  @TC.18996 @BSA.3030 @bus @2.5 @user_stories @stash @need_test_account @env_dependents @regression @core_function
  Scenario: 18996 [Search/List Users View][P]"Storage" and "Storage Used" column includes backup and stash
    When I act as partner by:
      | email                       |
      | test3010_3030_3040@auto.com |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User
    Then User search results should be:
      | User                   | Name           | User Group           | Sync     | Machines | Storage | Storage Used |
      | backup19045@test.com   | backup19045    | (default user group) | Disabled | 1        | 1 GB    | 10 MB        |
      | backup@test.com        | backup         | backup               | Disabled | 1        | 1 GB    | 10 MB        |
      | stash19045@test.com    | stash19045     | (default user group) | Enabled  | 0        | 2 GB    | 20 MB        |
      | stash@test.com         | stash          | stash                | Enabled  | 0        | 2 GB    | 20 MB        |

  @TC.18997 @BSA.3030 @bus @2.5 @user_stories @need_test_account @env_dependent @regression @core_function
  Scenario: 18997 [List User Groups View][P]"Sync Users" column shows and has valid values
  When I act as partner by:
  | email                        |
  | test3010_3030_3040@auto.com  |
  When I navigate to List User Groups section from bus admin console page
  Then User groups list table should be:
  | Name                   | Users | Admins | Sync Users |
  | (default user group) * | 2     | 1      | 1           |
  | backup                 | 1     | 1      | 0           |
  | stash                  | 1     | 1      | 1           |

  @TC.18998 @BSA.3030 @bus @2.5 @user_stories @need_test_account @env_dependent @regression @core_function
  Scenario: 18998 [List User Groups View][P]"Desktop Quota" column includes backup and stash
  When I act as partner by:
  | email                        |
  | test3010_3030_3040@auto.com  |
  When I navigate to List User Groups section from bus admin console page
  Then User groups list table should be:
  | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
  | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
  | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
  | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |

  @TC.18999 @BSA.3030 @bus @2.5 @user_stories @need_test_account @env_dependent @regression @core_function
  Scenario: 18999 [Group Detail View][P]"Sync" column shows and has valid value
  When I act as partner by:
  | email                        |
  | test3010_3030_3040@auto.com  |
  When I navigate to List User Groups section from bus admin console page
  Then User groups list table should be:
  | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
  | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
  | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
  | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |
  When I view (default user group) * user group details
  Then User group users list details should be:
  | User                 | Name        | Sync    |
  | stash19045@test.com  | stash19045  | Enabled  |
  | backup19045@test.com | backup19045 | Disabled |
  And I close the user group detail page
  When I view stash user group details
  Then User group users list details should be:
  | User            | Name  | Sync    |
  | stash@test.com  | stash | Enabled  |
  And I close the user group detail page
  When I view backup user group details
  Then User group users list details should be:
  | User            | Name   | Sync    |
  | backup@test.com | backup | Disabled |

  @TC.19000 @BSA.3030 @bus @2.5 @user_stories @need_test_account @env_dependent @regression @core_function
  Scenario: 19000 [Group Detail View][P]"Storage" and "Storage Used" column includes backup and stash
  When I act as partner by:
  | email                        |
  | test3010_3030_3040@auto.com  |
  When I navigate to List User Groups section from bus admin console page
  Then User groups list table should be:
  | Name                   | Users | Admins | Sync Users | Server Keys | Server Quota           | Desktop Keys | Desktop Quota             |
  | (default user group) * | 2     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 9        | 0.03 (3.0 active) / 230.0 |
  | backup                 | 1     | 1      | 0           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 1 / 10       | 0.01 (1.0 active) / 10.0  |
  | stash                  | 1     | 1      | 1           | 0 / 0       | 0.0 (0.0 active) / 0.0 | 0 / 0        | 0.02 (2.0 active) / 10.0  |
  When I view (default user group) * user group details
  Then User group users list details should be:
  | User                 | Name        | Sync    | Machines | Storage | Storage Used |
  | stash19045@test.com  | stash19045  | Enabled  | 0        | 2 GB    | 20 MB        |
  | backup19045@test.com | backup19045 | Disabled | 1        | 1 GB    | 10 MB        |
  And I close the user group detail page
  When I view stash user group details
  Then User group users list details should be:
  | User            | Name  | Sync    | Machines | Storage | Storage Used |
  | stash@test.com  | stash | Enabled  | 0        | 2 GB    | 20 MB        |
  And I close the user group detail page
  When I view backup user group details
  Then User group users list details should be:
  | User            | Name   | Sync    | Machines | Storage | Storage Used |
  | backup@test.com | backup | Disabled | 1        | 1 GB    | 10 MB        |