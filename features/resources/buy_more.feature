Feature: Show warning message for depleted resources when used = total

  Background:
    Given I log in bus admin console as administrator

  @TC.20819 @bus @2.5 @manage_storage @buy_more_storage @regression @core_function
  Scenario: 20819:[Itemized] Show warning message for depleted resources when used = total (desktop & sever storage)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Resource Summary section from bus admin console page
    Then I should not see any storage error in resource summary
    When I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_assigned_quota | desktop_devices | enable_stash | server_storage_type |
      | TC.20819-Desktop | Assigned             | 250                    | 1               | yes          | None                |
    Then TC.20819-Desktop user group should be created
    And I refresh Resource Summary section
    Then I should see Desktop Storage error in resource summary
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 20    | 100 GB      |
    And the MozyEnterprise account plan should be changed
    And I refresh Resource Summary section
    Then I should not see any storage error in resource summary
    When I add a new Itemized user group:
      | name            | desktop_storage_type | enable_stash | server_storage_type | server_assigned_quota | server_devices |
      | TC.20819-Server | None                 | no           | Assigned            | 100                   | 1              |
    Then TC.20819-Server user group should be created
    And I refresh Resource Summary section
    Then I should see Server Storage error in resource summary
    When I change MozyEnterprise account plan to:
      | server plan |
      | 250 GB      |
    And the MozyEnterprise account plan should be changed
    And I refresh Resource Summary section
    Then I should not see any storage error in resource summary

  @TC.20832 @bus @2.5 @manage_storage @buy_more_resources @regression @core_function
  Scenario: 20832:[Itemized] Show warning message for depleted resources when used = total (desktop & server device)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 250 GB      | yes       |
    Then New partner should be created
    When I enable stash for the partner
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Resource Summary section from bus admin console page
    Then I should not see any device error in resource summary
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 0       |
    Then 1 new user should be created
    And I activate the new user's 10 Desktop device(s) and update used quota to 1 GB
    And I navigate to Resource Summary section from bus admin console page
    Then I should see Desktop Device error in resource summary
    When I change MozyEnterprise account plan to:
      | users | server plan |
      | 20    | 250 GB      |
    And the MozyEnterprise account plan should be changed
    And I refresh Resource Summary section
    Then I should not see any device error in resource summary
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name  | machine_type |
      | @user_email | M_20832       | Server       |
    And I update <%=@clients[0].machine_id%> used quota to 1 GB
    And I activate the new user's 199 Server device(s) and update used quota to 1 GB
    And I navigate to Resource Summary section from bus admin console page
    Then I should see Server Device error in resource summary
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    And I delete device by name: M_20832
    And I navigate to Resource Summary section from bus admin console page
    Then I should not see any device error in resource summary

  @TC.20825 @bus @2.5 @manage_storage @buy_more_resources @regression @core_function
  Scenario: 20825:[Bundled] Show warning message for depleted resources when available = 0
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I navigate to Resource Summary section from bus admin console page
    Then I should not see any storage error in resource summary
    When I add a new Bundled user group:
      | name     | storage_type | assigned_quota |
      | TC.20825 | Assigned     | 100            |
    Then TC.20825 user group should be created
    When I refresh Resource Summary section
    Then I should see Storage error in resource summary
    When I change Reseller account plan to:
      | storage add-on |
      | 10             |
    Then the Reseller account plan should be changed
    When I refresh Resource Summary section
    Then I should not see any storage error in resource summary
