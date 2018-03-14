Feature: Move between offers

  Background:
    Given I log in bus admin console as administrator

  @TC.22485 @bus @aria @tasks_p2
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


  @TC.119231 @bus @aria @tasks_p2
  Scenario: 119231:Change 32TB Server plan,4 250GB add-on,3 years with initial purchase to DPS
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | net terms |
      | 12     | 10    | 32 TB       | 4             | yes       |
    Then New partner should be created
    And I get partner aria id
    And API* I change aria plan to MozyEnterprise for DPS 1 TB (Annual) with 34 units for newly created partner aria id
    And I wait for 30 seconds
    And I close the partner detail page
    And I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner contact information should be:
      | Company Type:      | Users: | Contact Email:                 |
      | MozyEnterprise DPS | 0      | <%=@partner.admin_info.email%> |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 34 TB     | 34 TB    | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 3 TB      |
    Then Change plan charge message should be:
      """
      Are you sure that you want to downgrade your Mozy plan? When you return resources, they are no longer available for use and your next charge will be reduced to renew only the remaining resources.
      """
    And the MozyEnterprise DPS account plan should be changed
    And I change account subscription to biennial billing period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then Next renewal info table should be:
      | Period            | Date          | Amount                             |
      | Biennial (change) | after 2 years | $0.00 (Without taxes or discounts) |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.119233 @bus @aria @tasks_p2
  Scenario: 119233:Change Mozyenterprise with storage to DPS with storage lower than used quota
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 41    | yes       |
    Then New partner should be created
    And I get partner aria id
    When I act as newly created partner account
    And I add new user(s):
      | name      | user_group           | storage_type | devices |
      | TC.119233 | (default user group) | Desktop       | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name  | machine_type |
      | @user_email | M_119233_user | Desktop      |
    And I update <%=@clients[0].machine_id%> used quota to 1025 GB
    When I move enterprise to DPS by script for newly created partner aria id
      | plan name                            | units | dry run |
      | MozyEnterprise for DPS 1 TB (Annual) | 1     | yes     |
    Then Move enterprise to DPS script output should include
      """
       Quota in new offer is not big enough to cover old pools
      """
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner contact information should be:
      | Company Type:  | Users: | Contact Email:                 |
      | MozyEnterprise | 1      | <%=@partner.admin_info.email%> |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 1 TB | 0         | 1 TB     | 1    | 40        | 41       |
    Then I delete partner account
