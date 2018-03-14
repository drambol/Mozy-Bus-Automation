Feature: purge production partners

  Background:
    Given I log in bus admin console as administrator

  @bus @purge_partner @prod_partners
  Scenario: purge partners from csv file
    When I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 90 days
    And I verify days to purge account after delete should be 90
    When I purge multiple partners from csv file
