Feature: Move between offers, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.22485 @ops_env
  Scenario: 22485 Change non-initialmozyEnterprise to MozyEnterprise for DPS
    When I add a new MozyEnterprise partner:
      | period | country       |
      | 12     | United States |
    Then New partner should be created
    And I get the partner_id
    And I get partner aria id
    When API* I assign aria plan MozyEnterprise for DPS 1 TB (Annual) with 1 units for newly created partner aria id
    And I wait for 20 seconds
    And I close the partner detail page
    And I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    Then Partner contact information should be:
      | Company Type:      | Users: | Contact Email:                 |
      | MozyEnterprise DPS | 0      | <%=@partner.admin_info.email%> |
    And I delete partner account