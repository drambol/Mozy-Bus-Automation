Feature: Change Plan for MozyEnterprisedps Partners

  Background:
    Given I log in bus admin console as administrator

  @TC.22480 @bus @change_plan @tasks_p3 @regression
  Scenario: 22480 [positive]Change Plan to available higher/lower capacity plan for DPS partner
    When I add a new MozyEnterprise DPS partner:
      | period | base plan   | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 100         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $0.00
    And Order summary table should be:
      | Description             | Quantity | Price Each | Total Price |
      | TB - MozyEnterprise DPS | 100      | $0.00      | $0.00       |
      | Total Charges           |          |            | $0.00       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    When I cancel MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    And MozyEnterpriseDPS new plan should be 100
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    Then Change plan charge summary should be:
      | Description                            | Amount     |
      |Charge for new TB - MozyEnterprise DPS  | $0.00      |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 200
    And I refresh Change Plan section
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 100       |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 100
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.22483 @bus @change_plan @tasks_p3 @regression
  Scenario: 22483 [nagative]Change Plan to invalid lower capacity plan for DPS partner
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | sales channel |
      | 12     | 2         | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 2 TB      | 2 TB     | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22483.User1 | (default user group) | Desktop      | 2048          | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                    | Devices                            |
      | 0 Used / 2 TB Available    | Desktop: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name   | machine_type |
      | Machine1_22483 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB    |
      | <%=@new_clients.first.machine_id%> | 2048  |
    And I navigate to Change Plan section from bus admin console page
    Then Current plan table should be:
      |Resource     |   Current Plan |  Used    |   Change |    Updated Plan|
      |Total Storage|   2048 GB      |  2048 GB |   0 GB   |    2048 GB     |
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 1         |
    Then Change Plan error message should be You are currently using more storage than the plan you selected allows. To reduce the amount of storage used, deselect files on individual machines or further limit the files allowed for backup in your client configuration.
    When I refresh Change Plan section
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 0         |
    Then Change Plan error message should be You are currently using more storage than the plan you selected allows. To reduce the amount of storage used, deselect files on individual machines or further limit the files allowed for backup in your client configuration.
    When I refresh Change Plan section
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | -1        |
    Then the storage error message of change plan section should be:
    """
    Invalid input. Enter a value between 1 and 200000.
    """
    When I stop masquerading
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used    | Available | Assigned  | Used | Available | Assigned  |
      | 2 TB    | 0         | 2 TB      | 1    | Unlimited | Unlimited |
    Then I search and delete partner account by newly created partner company name

  #it should be failed as no change plan function for ME DPS subpartner
  @TC.119226 @bus @change_plan @tasks_p3 @regression
  Scenario: 119226 [positive]Change Plan to available higher/lower capacity plan for DPS sub-partner
    When I add a new MozyEnterprise DPS partner:
      | company name          | period | base plan   | country       | address           | city      | state abbrev | zip   | phone          |
      |TC.119226_dps_partner  | 12     | 100         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $0.00
    And Order summary table should be:
      | Description             | Quantity | Price Each | Total Price |
      | TB - MozyEnterprise DPS | 100      | $0.00      | $0.00       |
      | Total Charges           |          |            | $0.00       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Enterprise    |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise DPS partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I stop masquerading
    When I act as partner by:
      | name     |
      |TC.119226_dps_partner|
    When I add a new sub partner:
      | Company Name             |
      | TC.119226_dps_subpartner |
    And New partner should be created
    And I act as newly created partner account
    # no change plan feature for subpartner yet, so it would fail for this step
    And I navigate to Change Plan section from bus admin console page
    When I cancel MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    And MozyEnterpriseDPS new plan should be 100
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 200       |
    Then Change plan charge summary should be:
      | Description                            | Amount     |
      |Charge for new TB - MozyEnterprise DPS  | $0.00      |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 200
    And I refresh Change Plan section
    When I change MozyEnterprise DPS account plan to:
      | base plan |
      | 100       |
    And the MozyEnterprise DPS account plan should be changed
    And MozyEnterpriseDPS new plan should be 100
    And I stop masquerading as sub partner
    When I stop masquerading
    Then I search and delete partner account by TC.119226_dps_subpartner
    Then I search and delete partner account by TC.119226_dps_partner

