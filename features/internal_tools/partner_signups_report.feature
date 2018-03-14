Feature: Partner Signups Report in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122196 @bus @internal_tools @smoke @ROR @ROR_smoke
  Scenario: 122196 Open Partner Signups
    #======step2: create a resller type partner======
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | yes         |
    #======step1: verify the header on Partner Signups Report table======
    When I navigate to Partner Signups Report section from bus admin console page
    Then Partner Signups Report table header should be:
      | Name | Approved | Type | Initial Keys | Initial Quota |
    #======step2: search the new created partner and view details======
    When I search partner on partner signups report by:
      | name                            |
      | <%=@partner.company_info.name%> |
    Then I view parter details on signup partner report by newly created partner company name
    #======step3: click clear search underline button======
    And I click clear search
    #======step4: export pro partner and check the newly created partner in the csv======
    When I export partner signups report
    Then I find the partner newly created partner company name in downloaded csv