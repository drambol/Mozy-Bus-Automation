Feature: BUS smoke test
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test 0123-2015-32
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - Reseller BUS Smoke Test 3849-7653-73
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - OEM BUS Smoke Test 4863-2704-60
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - subpartner1 8376-3615-73

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - subpartner2 4974-9147-43

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Storage Test 1543-8769-22
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyEnterprise BUS Smoke Test Report 5062-7291-02
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Credit Card 0709-1754-57
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test Credit Card 0709-1754-57
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Credit Card 0709-1802-56
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro France BUS Smoke Test Credit Card 0709-1802-56
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test Data Shuttle 6201-2851-04
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5958-2015-10
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test 5958-2015-10
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Reseller BUS Smoke Test 5959-3026-41
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - Reseller BUS Smoke Test 5959-3026-41
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyEnterprise BUS Smoke Test 1704-3692-83
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Fortress BUS Smoke Test 2940-4826-39
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - Fortress BUS Smoke Test 2940-4826-39
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro France BUS Smoke Test 3061-0518-27
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    Then I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro France BUS Smoke Test Report 4170-3928-56
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5979-5120-35
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test 5979-5120-35
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90

  @cleanup
  Scenario: Delete all the created partners
    And I search and delete partner account if it exists by Internal Mozy - MozyPro BUS Smoke Test 5980-4326-85
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I verify days to purge account after delete should be 0
    And I purge partner for cleanup by Internal Mozy - MozyPro BUS Smoke Test 5980-4326-85
    Then I change to 90 days to purge account after delete
    And I verify days to purge account after delete should be 90
