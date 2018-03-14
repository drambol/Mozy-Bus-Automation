Feature: Send activated / unactivated license keys

  Background:
    Given I log in bus admin console as administrator

  @TC.20947 @bus @2.5 @user_view @server_license @email @regression @core_function
  Scenario: 20947 [Itemized][Server License]Admin can send activated/unactived license keys
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 10    | 100 GB      | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 0       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then I can see Send Keys button is disable
    Then I close user details section
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 0
    And Number of Server unactivated keys should be 3
    When I click Send Keys button
    And I wait for 15 seconds
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I cannot find any Activated license key(s) from the mail
    And I can find 3 Unactivated Server license key(s) from the mail
    When I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Server activated keys should be 1
    And Number of Server unactivated keys should be 2
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content                                  |
      | <%=@activated_keys + @unactivated_keys%> |
    Then I should see 2 email(s)
    And I can find 1 Activated Server license key(s) from the mail
    And I can find 2 Unactivated Server license key(s) from the mail
    And Unactivated keys should show above activated in the mail
    When activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I view the user's product keys
    Then Number of Server activated keys should be 3
    And Number of Server unactivated keys should be 0
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content              |
      | <%=@activated_keys%> |
    Then I should see 3 email(s)
    And I can find 3 Activated Server license key(s) from the mail
    And I cannot find any Unactivated license key(s) from the mail

  @TC.21006 @bus @email @regression @core_function
  Scenario: 21006 [BundleReseller][Desktop License]Admin can send activated/unactivated license keys
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 100            | no          |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 25            | 0       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then I can see Send Keys button is disable
    Then I close user details section
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 25            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Desktop activated keys should be 0
    And Number of Desktop unactivated keys should be 3
    When I click Send Keys button
    And I wait for 15 seconds
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    And I cannot find any Activated license key(s) from the mail
    And I can find 3 Unactivated Desktop license key(s) from the mail
    When I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I wait for 15 seconds
    And I view the user's product keys
    Then Number of Desktop activated keys should be 1
    And Number of Desktop unactivated keys should be 2
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content                                  |
      | <%=@activated_keys + @unactivated_keys%> |
    Then I should see 2 email(s)
    And I can find 1 Activated Desktop license key(s) from the mail
    And I can find 2 Unactivated Desktop license key(s) from the mail
    And Unactivated keys should show above activated in the mail
    When activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I update the newly created machine used quota to 5 GB
    And I refresh User Details section
    And I wait for 15 seconds
    And I view the user's product keys
    Then Number of Desktop activated keys should be 3
    And Number of Desktop unactivated keys should be 0
    When I click Send Keys button
    And I wait for 45 seconds
    And I search emails by keywords:
      | content              |
      | <%=@activated_keys%> |
    Then I should see 3 email(s)
    And I can find 3 Activated Desktop license key(s) from the mail
    And I cannot find any Unactivated license key(s) from the mail
