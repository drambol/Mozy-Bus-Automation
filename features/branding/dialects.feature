Feature: Dialect
  As a Mozy partner Admin, I should be able to set up my own dialects

  @TC.122139 @bus @ROR_smoke
  Scenario: 122139 Add a dialect
    When I navigate to bus admin console login page
    And I use a existing partner:
      | company name             | admin email                              | partner type |
      |  TC.122139 [DO NOT EDIT] | mozyautotest+brandon+howard+1513@emc.com | Reseller     |
    And I get partner id by admin email from database
    And I delete dialects of current partner from database
    And I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I click start with the default link in List Dialects section
    Then dialects table should be:
      | Order | Description | Dialect | Enabled | Type           |
      | 0     | English     | en      | yes     | Admins & Users |
    # go to admin login page to verify that no other language can be selected
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    Then I should not see language select field
    # back to partner dialect list to add another dialect
    When I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I add a dialect:
      | Order | Code  | Enabled | Type           |
      | 1     | de    | Yes     | Users          |
    Then dialects table should be:
      | Order | Description | Dialect | Enabled | Type           |
      | 1     | German      | de      | yes     | Users          |
      | 0     | English     | en      | yes     | Admins & Users |
    # go to user login page to verify that English and German language can be selected
    When I go to page QA_ENV['bus_host']/login/user?pid=@partner_id
    Then I should see language select field
    And language select filed should include option English
    And language select filed should include option Deutsch
    # back to partner dialect list to clean up dialect settings
    When I log in bus admin console as new partner admin
    And I navigate to Dialects section from bus admin console page
    And I delete dialect of English
    And I delete dialect of German

