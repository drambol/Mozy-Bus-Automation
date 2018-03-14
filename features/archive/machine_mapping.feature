# Duplicate with machine_migration.feature, for reference only
#
#Feature: Machine migration(Test for using bifrost helper files and create partner if necessary)
#
#  As an admin
#  I want to migrate machines from current owners to new owners
#  So that I can proceed my work to migrate users between mozy and ad authentication
#
#  Background:
#    Given I log in bus admin console as administrator
#
#  @TC.16266-
#  Scenario: 16266 Export the machine-user mapping csv file
#    When I add a new MozyPro partner if not exist:
#      | company_name | period | base plan |
#      |   Test08     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test08
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    When I click the export machine csv button
#    Then There should be export message to inform that it is exporting
#    When I wait until the file is downloaded
#    Then The exported csv file should be like:(header as below, row number is 3, order by current owner, no duplicated rows)
#      | column 1      |  column 2                              |  column 3       | column 4  |
#      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
#      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |
#
#  @TC.16270-
#  Scenario: 16270 Export a CSV file in Synchronized way after deleting one user-machine mapping
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I rename the machine csv file
#    And I delete 1 new user and machine mapping by bifrost
#    When I download the machine csv file
#    Then The exported csv file should be 1 rows less than the former one
#
#  @TC.16271-
#  Scenario: 16271 Export a CSV file in Synchronized way after adding one user-machine mapping
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I rename the machine csv file
#    And I add 1 new user and machine mapping by bifrost
#    When I download the machine csv file
#    Then The exported csv file should be 1 rows more than the former one
#
#  @TC.16272-
#  Scenario: 16272 Export a CSV file in Synchronized way while the partner has 10000 machines before
#    When I act as partner by:
#      | name                         |
#      | Machine Migration Automation |
#    And I navigate to the machine mapping page
#    When I download the machine csv file
#    Then The exported csv file should be like:(header as below, row number is 3, order by current owner, no duplicated rows)
#      | column 1      |  column 2                              |  column 3       | column 4  |
#      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
#      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |
#
#  @TC.16273-
#  Scenario: 16273 Export a CSV file in Synchronized way while the partner has no Mozy users before
#    When I add a new MozyPro partner if not exist:
#      | company name    | period | base plan |
#      |   Test16273     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test16273
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    When I download the machine csv file
#    Then The exported csv file should be:
#      | column 1      |  column 2                              |  column 3       | column 4  |
#      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
#
#  @TC.16275- @positive @regression @core_function
#  Scenario: 16275 Import a valid CSV file in non-passive way
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I change the csv file by adding new owners to the machines
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 3 rows imported |3 machines moved to new users | 0 machines skipped (no new user specified) |
#
#  @TC.16276-
#  Scenario: 16276 Import a CSV file in no passive way while the partner has 10000 machines before
#    When I act as partner by:
#      | name                         |
#      | Machine Migration Automation |
#    And I navigate to the machine mapping page
#    And I download the machine csv file
#    And I change the csv file by adding new owners to the machines
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 3 rows imported |3 machines moved to new users | 0 machines skipped (no new user specified) |
#
#  @TC.16278-
#  Scenario: 16278 Import an empty CSV file in non-passive way
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create an empty file
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 0 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) |
#
#  @TC.16279-
#  Scenario: 16279 Import a CSV file whose type is not CSV in non-passive way
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    When I upload the non-csv file
#    Then The import result should be like:
#      | column 1      |  column 2        |  column 3                    | column 4                                   | column 5  |   column 6                                                 |
#      |Import Results:| -1 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 1 Errors: |   Invalid file. The uploaded file was an invalid CSV file. |
#
#  @TC.16280- @TC.16281- @TC.16282-
#Scenario Outline: 16280 16281 16282 Import a CSV file with a column absent
#  When I add a new MozyPro partner if not exist:
#    | company name | period | base plan |
#    |   Test00     | 1      | 50 GB     |
#  And I navigate to Search / List Partners section from bus admin console page
#  And I navigate to the partner_details page of Test00
#  And I get the api_key
#  And I get the partner_id
#  And I act as newly created partner account
#  And I navigate to the machine mapping page
#  And I create 3 machine user mappings
#  And I download the machine csv file
#  And I make the <column> absent
#  When I upload the machine csv file
#  Then The import result should be like:
#    | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6                                                                                         |
#    |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Row 2 - Invalid record - one or more of machine name, machine hash, and current owner are blank. |
#
#Examples:
#  | column        |
#  | Machine Name  |
#  | Machine Hash  |
#  | Current Owner |
#
#  @TC.16283-
#  Scenario: 16283 Import a CSV file with a column absent (new owner)
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the New Owner absent
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |
#
#  @TC.16284- @TC.16285-
#  Scenario Outline: 16284 16285 Import a CSV file whose one column has unknown value
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the <column> an unknown value
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |
#
#  Examples:
#    | column        |
#    | Machine Name  |
#    | Machine Hash  |
#
#  @TC.16286-
#  Scenario: 16286 Import a CSV file whose one column has unknown value (Current Owner)
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the Current Owner an unknown value
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |
#
#  @TC.16287-
#  Scenario: 16287 Import a CSV file whose one column has unknown value (New Owner)
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the New Owner an unknown value
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |
#
#  @TC.16288-
#  Scenario: 16288 Import a CSV file with current owners invalid format
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the Current Owner an invalid value
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6             |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | does not own machine |
#
#  @TC.16289-
#  Scenario: 16289 Import a CSV file with new owners invalid format
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the New Owner an invalid value
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6          |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown new owner |
#
#  @TC.16290-
#  Scenario: 16290 Import a CSV file with mismatched machine name and machine hash
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make a column with mismatched machine name and machine hash
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   | column 5  | column 6        |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 0 machines skipped (no new user specified) | 3 Errors: | Unknown machine |
#
#  @TC.16291-
#  Scenario: 16291 Import a CSV file with new owner an empty string in non-passive way
#    When I add a new MozyPro partner if not exist:
#      | company name | period | base plan |
#      |   Test00     | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test00
#    And I get the api_key
#    And I get the partner_id
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    And I create 3 machine user mappings
#    And I download the machine csv file
#    And I make the new owner column with a space
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 3 rows imported |0 machines moved to new users | 3 machines skipped (no new user specified) |
#
#  @TC.16343-
#  Scenario: 16343 Export a CSV file when the partner has subpartners
#    When I add a new MozyPro partner if not exist:
#      | company name | email             | period | base plan |
#      |   Test01     | test1238@test.com | 1      | 50 GB     |
#    And I navigate to Search / List Partners section from bus admin console page
#    And I navigate to the partner_details page of Test01
#    And I get the api_key
#    And I get the partner_id
#    And I get the default group id by bifrost
#    And I create 3 machine user mappings
#    And I close the partner detail page
#    And I add a subpartner if not exist:
#      | name          | username             |
#      | subpartner1  | bifrost1@bifrost.com  |
#    And I navigate to the partner_details page of subpartner1
#    And I get the subpartner api_key
#    And I create 2 Machine user mappings for the subpartner
#    And I close the partner detail page
#    And I navigate to the partner_details page of Test01
#    And I act as newly created partner account
#    And I navigate to the machine mapping page
#    When I download the machine csv file
#    Then The exported csv file should be like:(header as below, row number is 3, order by current owner, no duplicated rows)
#      | column 1      |  column 2                              |  column 3       | column 4  |
#      | Machine Name  | Machine Hash                           | Current Owner   | New Owner |
#      |WIN-F13I7JF06G5|87f9fa5583e952cf76fe53e1eab0123923dc92e4|new_user@test.com|           |
#
#  @TC.17936-
#  Scenario: 17936 Import a CSV file while two users have same machine
#    When I act as partner by:
#      | name                          |
#      | Machine Migration for TC17936 |
#    And I navigate to the machine mapping page
#    And I download the machine csv file
#    And I change the csv file by moving the machines to new users
#    When I upload the machine csv file
#    Then The import result should be like:
#      | column 1      |  column 2       |  column 3                    | column 4                                   |
#      |Import Results:| 2 rows imported |2 machines moved to new users | 0 machines skipped (no new user specified) |
#
