Feature: Sort user group list

  Background:
    Given I log in bus admin console as administrator

    @TC.20932 @bus @2.5 @manage_storage @sort_columns @bundled @regression @core_function
    Scenario: 20932 [Bundled] Sort Columns

      When I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | net terms | company name                   |
        | 12     | Silver        | 100            | yes         | yes       | [Bundled] Sort User Group List |
      Then New partner should be created
      And I get the partner_id
      And I enable stash for the partner
      And I act as newly created partner

      And I add a new Bundled user group:
        | name         | storage_type |
        | User Group A | Shared       |
      Then User Group A user group should be created

      When I add a new Bundled user group:
        | name         | storage_type | assigned_quota | enable_stash |
        | User Group B | Assigned     | 10             | yes          |
      Then User Group B user group should be created

      And I add a new Bundled user group:
        | name         | storage_type | limited_quota | enable_stash |
        | User Group C | Limited      | 10            | yes          |
      Then User Group C user group should be created


      And I add new user(s):
        | name       | user_group           | storage_type | storage_limit | devices |
        | TC.20932-1 | (default user group) | Desktop      | 10            | 3       |
      Then 1 new user should be created
      And I search user by:
        | keywords   |
        | @user_name |
      And I view user details by newly created user email
      And I update the user password to default password
      And I add machines for the user and update its used quota
        | user_email  | machine_name | machine_type | partner_name  | used_quota |
        | @user_email | Machine1     | Desktop      | @partner_name | 1 GB       |
        | @user_email | Machine2     | Desktop      | @partner_name | 1 GB       |
        | @user_email | Machine3     | Desktop      | @partner_name | 1 GB       |
      Then I close user details section


      And I add new user(s):
        | name       | user_group   | storage_type | storage_limit | devices |
        | TC.20932-2 | User Group B | Desktop      | 10            | 2       |
      Then 1 new user should be created
      And I search user by:
        | keywords   |
        | @user_name |
      And I view user details by newly created user email
      And I update the user password to default password
      And I add machines for the user and update its used quota
        | user_email  | machine_name | machine_type | partner_name  | used_quota |
        | @user_email | Machine1     | Desktop      | @partner_name | 1 GB       |
        | @user_email | Machine1     | Desktop      | @partner_name | 1 GB       |
      Then I close user details section

      And I add new user(s):
        | name       | user_group   | storage_type | storage_limit | devices |
        | TC.20932-3 | User Group C | Desktop      | 10            | 2       |
      Then 1 new user should be created
      And I search user by:
        | keywords   |
        | @user_name |
      And I view user details by newly created user email
      And I update the user password to default password
      And I add machines for the user and update its used quota
        | user_email  | machine_name | machine_type | partner_name  | used_quota |
        | @user_email | Machine1     | Desktop      | @partner_name | 5 GB       |
      Then I close user details section

      When I navigate to User Group List section from bus admin console page

      Then Column Group Name sorts in ascending order
      And Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |

      When I click Group Name table header
      Then Column Group Name sorts in descending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |

      Then I refresh User Group list section
      When I click Sync table header
      Then Column Sync sorts in ascending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |


      When I click Sync table header
      Then Column Sync sorts in descending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |

      Then I refresh User Group list section
      When I click Server Enabled table header
      Then Column Server Enabled sorts in ascending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |


      When I click Server Enabled table header
      Then Column Server Enabled sorts in descending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |


      Then I refresh User Group list section
      When I click Device Used table header
      Then Column Device Used sorts in ascending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |


      When I click Device Used table header
      Then Column Device Used sorts in descending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |

      Then I refresh User Group list section
      When I click Storage Used table header
      Then Column Storage Used sorts in ascending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |

      When I click Storage Used table header
      Then Column Storage Used sorts in descending order
      Then Bundled user groups table should be:
        | Group Name            | Sync | Server | Storage Type | Type Value | Storage Used | Devices Used |
        | User Group C          | true  | false  | Limited      | 10 GB      | 5 GB         | 1            |
        | (default user group)  | true  | true   | Shared       |            | 3 GB         | 3            |
        | User Group B          | true  | false  | Assigned     | 10 GB      | 2 GB         | 2            |
        | User Group A          | false | false  | Shared       |            | 0            | 0            |


  @TC.20933 @bus @2.5 @manage_storage @sort_columns @itemized @regression @core_function
Scenario: 20933 [Itemized] Sort Columns

    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                    |
      | 12     | 10    | 100 GB      | yes       | [Itemized] Sort User Group List |
    Then New partner should be created
    And I get the partner_id
    And I enable stash for the partner
    And I act as newly created partner


    And I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | User Group A | Shared               | 3               | Shared              | 3              | yes          |
    Then User Group A user group should be created

    And I add a new Itemized user group:
      | name         | desktop_storage_type | desktop_devices | desktop_assigned_quota | server_storage_type | server_devices | server_assigned_quota |
      | User Group B | Assigned             | 2               | 10                     | Assigned            | 2              | 10                    |
    Then User Group B user group should be created

    And I add a new Itemized user group:
      | name          | desktop_storage_type | desktop_devices | desktop_limited_quota | server_storage_type | server_devices | server_limited_quota |
      | User Group C  | Limited              | 1               | 10                    | Limited             | 1              | 10                    |
    Then User Group C user group should be created


    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | (default user group) | TC.20933-1 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 1 GB       |
    Then I close user details section

    And I add new user(s):
      | user_group           | name       | storage_type | storage_limit | devices |
      | (default user group) | TC.20933-2 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Server       | @partner_name | 1 GB       |
    Then I close user details section


    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group A | TC.20933-3 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 2 GB       |
    Then I close user details section

    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group A | TC.20933-4 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Server       | @partner_name | 2 GB       |
    Then I close user details section


    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group B | TC.20933-5 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 3 GB       |
    Then I close user details section

    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group B | TC.20933-6 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Server       | @partner_name | 3 GB       |
    Then I close user details section



    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group C | TC.20933-7 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Desktop      | @partner_name | 4 GB       |
    Then I close user details section

    And I add new user(s):
      | user_group   | name       | storage_type | storage_limit | devices |
      | User Group C | TC.20933-8 | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | user_email  | machine_name | machine_type | partner_name  | used_quota |
      | @user_email | Machine1     | Server       | @partner_name | 4 GB       |
    Then I close user details section


    When I navigate to User Group List section from bus admin console page

    Then Column Group Name sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |

    When I click Group Name table header
    Then Column Group Name sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |


    Then I refresh User Group list section
    When I click Sync table header
    Then Column Sync sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |


    Then I click Sync table header
    Then Column Sync sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |


    Then I refresh User Group list section
    Then I click Server Storage Used table header
    Then Column Server Storage Used sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |

    When I click Server Storage Used table header
    Then Column Server Storage Used sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |

    Then I refresh User Group list section
    Then I click Desktop Storage Used table header
    Then Column Desktop Storage Used sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |

    When I click Desktop Storage Used table header
    Then Column Desktop Storage Used sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |


    Then I refresh User Group list section
    When I click Desktop Device Total table header
    Then Column Desktop Device Total sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |

    When I click Desktop Device Total table header
    Then Column Desktop Device Total sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |


    Then I refresh User Group list section
    When I click Server Device Total table header
    Then Column Server Device Total sorts in ascending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |

    When I click Server Device Total table header
    Then Column Server Device Total sorts in descending order
    And Itemized user groups table should be:
      | Group Name           | Sync | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | true  | Shared               |                    | 1 GB                 | 1                    | 4                     | Shared              |                   | 1 GB                | 1                   | 194                  |
      | User Group A         | true  | Shared               |                    | 2 GB                 | 1                    | 3                     | Shared              |                   | 2 GB                | 1                   | 3                    |
      | User Group B         | false | Assigned             | 10 GB              | 3 GB                 | 1                    | 2                     | Assigned            | 10 GB             | 3 GB                | 1                   | 2                    |
      | User Group C         | false | Limited              | 10 GB              | 4 GB                 | 1                    | 1                     | Limited             | 10 GB             | 4 GB                | 1                   | 1                    |
