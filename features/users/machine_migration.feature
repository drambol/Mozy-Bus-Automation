#If you want to run these testcases in other environment other than QA5, You need to prepare these data
#To do: I will add a new feature to prepare these data automately
#(1). Add some partner with the following partner name and admin if not exist
# | partner name                      | admin                                    | usage                               |
# | Machine Migration Automation      | machine_migration_auto@auto.com          | general                             |
# | Machine Migration Add Delete Test | machine_migration_add_delete@auto.com    | add and delete user machine mapping |
# | Fed ID Partner                    | leongh+system@mozy.com                   | 10000 user machine mappings         |
# | Machine Migration for TC16273     | machine_migraion_tc16273@auto.com        | 0 user machine mappings             |
# | Freecom                           | robert.bartelds-at-freecom.com@mozy.test | a partner which has subpartner      |
# | Machine Migration for TC17936     | machine_migraion_tc17936@auto.com        | 2 users have the same machine       |
#(2). Bifrostcli needed for the "Machine Migration Add Delete Test"
#a. Download mozybfstcli from git repo and run 'python setup.py install' to install it
#b. Change /etc/mozybfst.yml according to "Machine Migration Add Delete Test", in QA5, 1 example is like:
#    secret: 5NDOVgE2OpdpZc5IPBEA8ZuQ6t2Ch7094MGoHg8nElxK6geBlpCFSSRxAt028Qa5
#    group_id: 129736

Feature: Machine migration
  (This is only for QA5 environment, This file will be replaced by machine_mapping.feature)

  As an admin
  I want to migrate machines from current owners to new owners
  So that I can proceed my work to migrate users between mozy and ad authentication

  Background:
    Given I log in bus admin console as administrator

  @TC.16266 @regression @core_function @smoke @bus @2.5 @machine_migration
  Scenario: 16266 Export the machine-user mapping csv file
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name           | user_group           | storage_type | storage_limit | devices | machine_name |
      | TC.16266.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | TC.16266.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | TC.16266.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    And I navigate to the machine mapping page
    When I click the export machine csv button
    Then There should be export message to inform that it is exporting
    And The exported csv file should be like:(header as below, row number is 3, order by current owner, no duplicated rows)
      | column 1     | column 2      | column 3             | column 4  |
      | Machine Name | Machine Hash  | Current Owner        | New Owner |
      | TestMachine1 | @machine_hash | <%=@users[0].email%> |           |
      | TestMachine2 | @machine_hash | <%=@users[1].email%> |           |
      | TestMachine3 | @machine_hash | <%=@users[2].email%> |           |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16270 @bus @2.5 @machine_migration @regression @core_function
  Scenario: 16270 16271 Export a CSV file in Synchronized way after adding/deleting one user-machine mapping
    # Scenario: 16270 Export a CSV file in Synchronized way after adding/deleting one user-machine mapping
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name                   |
      | 12     | 8     | 100 GB      | yes       | Machine Migration Add & Delete |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I rename the machine csv file
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.16270.User | (default user group) | Desktop      | 50            | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name | machine_type | partner_name  |
      | @user_email | Machine1     | Desktop      | @partner_name |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be 1 rows more than the former one
    And I rename the machine csv file
    # now delete the user machine
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I delete user
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be 1 rows less than the former one
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.16272 @bus @2.5 @machine_migration @qa5 @env_dependent @regression
  Scenario: 16272 Export a CSV file in Synchronized way while the partner has 10000 machines before
    When I act as partner by:
      | email                  |
      | leongh+system@mozy.com |
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be like:(header as below, row number is 9793, order by current owner, no duplicated rows)
      | column 1      | column 2                                 | column 3          | column 4  |
      | Machine Name  | Machine Hash                             | Current Owner     | New Owner |
      | @machine_name | 87f9fa5583e952cf76fe53e1eab0123923dc92e4 | new_user@test.com |           |

  @TC.16273 @bus @2.5 @machine_migration @regression @core_function
  Scenario: 16273 16279 Export a CSV file in Synchronized way while the partner has no Mozy users before; Import a CSV file whose type is not CSV in non-passive way
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I navigate to the machine mapping page
    When I download the machine csv file
    Then The exported csv file should be:
      | column 1      |  column 2                              |  column 3       | column 4  |
      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
    When I upload the non-csv file
    Then The import result should be like:
      | column 1      |  column 2        |  column 3                    | column 4                                   | column 5  |   column 6                                                 |
      |Import Results:| -1 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 1 Errors: |   Invalid file. The uploaded file was an invalid CSV file. |

  @TC.16275 @positive @regression @core_function @smoke @bus @2.5 @machine_migration @ROR_smoke
  Scenario: 16275 Import a valid CSV file in non-passive way
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name            | user_group           | storage_type | storage_limit | devices | machine_name |
      | Migration.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | Migration.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | Migration.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by adding new owners to the machines
    When I upload the machine csv file
    Then There should be import message to inform that it is importing
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |3 machines moved to new users | 0 machines skipped (no new user specified) |

  @TC.16280 @bus @2.5 @machine_migration @regression @core_function
  Scenario: 16280 16281 16282 16283 Import a CSV file with a column absent
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name            | user_group           | storage_type | storage_limit | devices | machine_name |
      | Migration.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | Migration.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | Migration.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    And I navigate to the machine mapping page
    When I download the machine csv file
    And I make the Machine Name absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6                                                                                         |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Row 2 - Invalid record - one or more of machine name, machine hash, and current owner are blank. |
    And I refresh the machine mapping section
    When I download the machine csv file
    And I make the Machine Hash absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6                                                                                         |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Row 2 - Invalid record - one or more of machine name, machine hash, and current owner are blank. |
    And I refresh the machine mapping section
    When I download the machine csv file
    And I make the Current Owner absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6                                                                                         |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Row 2 - Invalid record - one or more of machine name, machine hash, and current owner are blank. |
    And I refresh the machine mapping section
    # 16283 Import a CSV file with a column absent (new owner)
    When I download the machine csv file
    And I make the New Owner absent
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |

  @TC.16284 @bus @2.5 @machine_migration @regression @core_function
  Scenario: 16284 16285 16286 16287 Import a CSV file whose one column has unknown value
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name            | user_group           | storage_type | storage_limit | devices | machine_name |
      | Migration.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | Migration.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | Migration.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    And I navigate to the machine mapping page
    When I download the machine csv file
    And I make the Machine Name an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |
    When I download the machine csv file
    And I make the Machine Hash an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |
    And I refresh the machine mapping section
    # Scenario: 16286 Import a CSV file whose one column has unknown value (current Owner)
    When I download the machine csv file
    And I make the Current Owner an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |
    And I refresh the machine mapping section
    # Scenario: 16287 Import a CSV file whose one column has unknown value (New Owner)
    When I download the machine csv file
    And I make the New Owner an unknown value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |

  @TC.16288 @bus @bug @2.5 @machine_migration @regression @core_function
  Scenario: 16288 16289 16290 16291 Import a CSV file with current owners invalid format
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name            | user_group           | storage_type | storage_limit | devices | machine_name |
      | Migration.User1 | (default user group) | Desktop      | 50            | 3       | TestMachine1 |
      | Migration.User2 | (default user group) | Desktop      | 50            | 2       | TestMachine2 |
      | Migration.User3 | (default user group) | Desktop      | 50            | 1       | TestMachine3 |
    When I navigate to the machine mapping page
    And I download the machine csv file
    And I make the Current Owner an invalid value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |
    And I refresh the machine mapping section
    # Scenario: 16289 Import a CSV file with new owners invalid format
    When I download the machine csv file
    And I make the New Owner an invalid value
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |
    And I refresh the machine mapping section
    # Scenario: 16290 Import a CSV file with mismatched machine name and machine hash
    When I download the machine csv file
    And I make a column with mismatched machine name and machine hash
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |
    And I refresh the machine mapping section
    # Scenario: 16291 Import a CSV file with new owner an empty string in non-passive way
    When I download the machine csv file
    And I make the new owner column with a space
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |

  @TC.16343 @bus @bug @2.5 @machine_migration @regression @core_function
  Scenario: 16343 Export a CSV file when the partner has subpartners
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 8     | 100 GB      | yes       | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I add some new users and activate one machine for each
      | name          | user_group           | storage_type | storage_limit | devices | machine_name       |
      | partner.User1 | (default user group) | Desktop      | 50            | 3       | PartnerTestMachine |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Desktop Storage | Desktop Devices | Server Storage | Server Devices |
      | 30              | 3               | 50             | 5              |
    And I act as newly created subpartner account
    And I add some new users and activate one machine for each
      | name             | user_group           | storage_type | storage_limit | devices | machine_name   |
      | subpartner.User1 | (default user group) | Desktop      | 10            | 3       | SubTestMachine |
    And I navigate to the machine mapping page
    When I download the machine csv file
    And The exported csv file should be like:(header as below, row number is 1, order by current owner, no duplicated rows)
      | column 1       | column 2      | column 3             | column 4  |
      | Machine Name   | Machine Hash  | Current Owner        | New Owner |
      | SubTestMachine | @machine_hash | <%=@users[1].email%> |           |
    Then I stop masquerading from subpartner
    And I navigate to the machine mapping page
    When I download the machine csv file
    And The exported csv file should be like:(header as below, row number is 1, order by current owner, no duplicated rows)
      | column 1           | column 2      | column 3             | column 4  |
      | Machine Name       | Machine Hash  | Current Owner        | New Owner |
      | PartnerTestMachine | @machine_hash | <%=@users[0].email%> |           |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.17936 @bug @2.2 @machine_migration @qa5 @env_dependent @regression
  Scenario: 17936 Import a CSV file while two users have same machine
    When I act as partner by:
      | email                             |
      | machine_migraion_tc17936@auto.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by moving the machines to new users
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2       |  column 3                    | column 4                                   |
      |Import Results:| 2 rows imported |2 machines moved to new users | 0 machines skipped (no new user specified) |

  @TC.16276 @slow @bug @2.5 @machine_migration @qa5 @env_dependent @regression
  Scenario: 16276 Import a CSV file in no passive way while the partner has 10000 machines before
    When I act as partner by:
      | email                  |
      | leongh+system@mozy.com |
    And I navigate to the machine mapping page
    And I download the machine csv file
    And I change the csv file by adding new owners to the machines for 9793 machines
    When I upload the machine csv file
    Then The import result should be like:
      | column 1      |  column 2          |  column 3                       | column 4                                   |
      |Import Results:| 9793 rows imported |9793 machines moved to new users | 0 machines skipped (no new user specified) |

  @TC.2168 @bus @others @regression @core_function @ROR_smoke
  Scenario: 2168 Export to CSV
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 500 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role

    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | user_2168      | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by user_2168
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_2168   | <%=@new_users.first.email%> | Desktop      |
    And I clear user search results
    And I export the users csv
    And I navigate to Search / List Machines section from bus admin console page
    And I export the machines csv
    Then users.csv and machines.csv are downloaded
