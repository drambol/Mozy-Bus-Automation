Feature: Auto Grow

  As an admin,
  I would like to give partners the option to consume more resources than allocated and be billed for those resources,
  So that their business can grow easily and with minimal hassle

  Success Criteria:

  Background:
    Given I log in bus admin console as administrator

  @TC.14115 @bus @env_dependent @regression @core_function
  Scenario: Mozy-14115::Enable autogrow partner admin
#    When I log in to legacy bus01 as administrator
#    And I successfully add an itemized Reseller partner:
#      | period | desktop licenses | desktop quota |
#      | 12     | 2                | 2             |
#    And I log in bus admin console as administrator
#    And I search partner by:
#      | name          | filter |
#      | @company_name | None   |
#    And I view partner details by newly created partner company name
#    And I get the partner_id
#    And I migrate the partner to aria
#    And I Enable partner details autogrow
#    Then partner details message should be
#    """
#    Autogrow protection enabled.
#    """
#    And I migrate the partner to pooled storage
    When I search partner by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I view partner details by Itemized_Reseller_DONOT_ChangePlan(Migrate)
    And I get the partner_id
    And I get the partners name Itemized_Reseller_DONOT_ChangePlan(Migrate) and type Reseller
    When I act as partner by:
      | email                  |
      | qa1+ruby_gem@decho.com |
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Desktop      | 1        |
    And 1 new user should be created
    And I search user by:
      | keywords   | user type                                         |
      | @user_name | Itemized_Reseller_DONOT_ChangePlan(Migrate) Users |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload data to device by batch
      | machine_id                  | GB  |
      | <%=@clients[0].machine_id%> | 0.8 |
    Then tds returns successful upload
    And I delete user

  @TC.14116 @bus @regression @core_function
  Scenario: Mozy-14116::Autogrow enabled billing
    And I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 2              | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add a new Bundled user group:
      | name | storage_type | limited_quota | server_support |
      | UG 1 | Limited      | 1             | yes            |
    Then UG 1 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 1       | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    And I get the machine_id by license_key
    And I upload data to device by batch
      | machine_id                  | GB  | upload_file |
      | <%=@clients[0].machine_id%> | 1.1 | false       |
    And I upload data to device by batch
      | machine_id                  | GB    | upload_file |
      | <%=@clients[0].machine_id%> | 0.001 | true        |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I add a new Bundled user group:
      | name | storage_type | server_support |
      | UG 2 | Shared       | yes            |
    Then UG 2 user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | UG 2       | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I get the machine_id by license_key
    And I upload 2 GB of data to device
    Then tds returns successful upload
    And I stop masquerading
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I search and delete partner account by newly created partner company name

  @TC.21963 @bus @slow @env_dependent @regression @core_function
  Scenario: 21963 - Autogrow Smoke - A Partner with Autogrow Enabled Can Overdraft Resources on Shared Usergroups
    When an Auto Grow Org is created
    And I navigate to Search / List Users section from bus admin console page
    And I sort user search results by Name
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 0        | Shared  | None         |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 0        | Shared  | None         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 15 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | 5 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 3 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I search user by:
      | keywords                |
      | <%=@users.first.email%> |
    And I view user details by <%=@users.first.email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name               | machine_type |
      | Machine 1    | <%=@users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@clients.first.license_key%>
    And I upload data to device
      | machine_id                     | GB | user_email              |
      | <%=@clients.first.machine_id%> | 6  | <%=@users.first.email%> |
    And I upload data to device by batch
      | machine_id                     | GB    | user_email              | upload_file |
      | <%=@clients.first.machine_id%> | 0.001 | <%=@users.first.email%> | true        |
    Then tds return first message should be:
    """
    Account or container quota has been exceeded
    """
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 6 GB         |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 0        | Shared  | None         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 15 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:      |
      | -1 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 3 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I clear user search results
    And I search user by:
      | keywords             |
      | <%=@users[2].email%> |
    And I view user details by <%=@users[2].email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name            | machine_type |
      | Machine 2    | <%=@users[2].email%> | Desktop      |
    And I get the machine id for client 1 by license key <%=@clients[1].license_key%>
    And I upload data to device
      | machine_id                  | GB | user_email           |
      | <%=@clients[1].machine_id%> | 3  | <%=@users[2].email%> |
    And I upload data to device by batch
      | machine_id                     | GB    | user_email              | upload_file |
      | <%=@clients.first.machine_id%> | 0.001 | <%=@users.first.email%> | true        |
    Then tds return first message should be:
    """
    Account or container quota has been exceeded
    """
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 6 GB         |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 1        | Shared  | 3 GB         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 0        | Shared  | None         |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | 12 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:      |
      | -1 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:    |
      | 0 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I clear user search results
    And I search user by:
      | keywords             |
      | <%=@users[1].email%> |
    And I view user details by <%=@users[1].email%>
    And I update the user password to default password
    And I close the user detail page
    Then I use keyless activation to activate devices
      | machine_name | user_name            | machine_type |
      | Machine 3    | <%=@users[1].email%> | Server       |
    And I get the machine id for client 2 by license key <%=@clients[2].license_key%>
    And I upload data to device
      | machine_id                  | GB | user_email           |
      | <%=@clients[2].machine_id%> | 18 | <%=@users[1].email%> |
    Then tds returns successful upload
    And I navigate to Search / List Users section from bus admin console page
    And I clear user search results
    Then User search results should be:
      | User                    | Name          | User Group  | Machines | Storage | Storage Used |
      | <%=@users.first.email%> | Jane Assigned | Assigned UG | 1        | Shared  | 6 GB         |
      | <%=@users[2].email%>    | Jane Limited  | Limited UG  | 1        | Shared  | 3 GB         |
      | <%=@users[1].email%>    | John Shared   | Shared UG   | 1        | Shared  | 18 GB        |
    And I view details of <%=@users[1].email%>'s user group
    Then User group details should be:
      | Available Quota: |
      | -6 GB(Shared)    |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users.first.email%>'s user group
    Then User group details should be:
      | Available Quota:      |
      | -1 GB(Assigned: 5 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I view details of <%=@users[2].email%>'s user group
    Then User group details should be:
      | Available Quota:     |
      | -6 GB(Limited: 3 GB) |
    And I close the user group detail page
    And I close the user detail page
    And I navigate to Resource Summary section from bus admin console page
    Then Bundled storage summary should be:
      | Available | Used  |
      | 0         | 26 GB |
    When I stop masquerading
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used  | Available | Assigned | Used | Available | Assigned  |
      | 26 GB | 0         | 20 GB    | 3    | Unlimited | Unlimited |
    And the overdraft script should report:
    """
    Partner <%=@current_partner[:id]%> is using autogrow and is overdrafted on its Generic license by 6 GB
    """
    And I search and delete partner account by newly created partner company name

  @TC.15727 @bus @auto_grow @tasks_p2
  Scenario: 15727:BILL.9000 Autogrow may be enabled or disabled Reseller
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |  net terms |
      |   1    |  Silver         | 1000           |      yes     |      yes   |
    Then New partner should be created
    And I Enable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | Yes (change)     |
    And I Disable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | No (change)      |
    When I act as newly created partner account
    And I navigate to Billing Information section from bus admin console page
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    And I Enable billing info autogrow
    Then Autogrow details should be:
      | Status            |
      | Enabled (disable) |
    And I Disable billing info autogrow
    Then Autogrow details should be:
      | Status               |
      | Disabled (more info) |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21937 @bus @auto_grow @tasks_p2
  Scenario: 21937 [Bundled]Resource Summary and Change plan warn the user to purchase or reduce quota when overquota
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota | server plan |
      | 12     |  Gold           | 100            | yes         |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add a new Bundled user group:
      | name       | storage_type |
      | TC21937_UG | Shared       |
    Then TC21937_UG user group should be created
    And I add new user(s):
      | user_group | storage_type | devices |
      | TC21937_UG | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21937 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 100 |
    Then tds returns successful upload
    And I navigate to Resource Summary section from bus admin console page
    Then the storage error message of resource summary section should be:
    """
    No Storage Available
    """
    And I navigate to Change Plan section from bus admin console page
    Then change plan section shouldn't have any storage errors
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 101 |
    And I refresh Resource Summary section
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 1 GB storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I refresh Change Plan section
    Then the storage error message of change plan section should be:
    """
    Your organization is now using 1 GB storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    When I change Reseller account plan to:
      | storage add-on |
      | 1              |
    And I refresh Resource Summary section
    Then resource summary section shouldn't have any storage errors
    And I refresh Change Plan section
    Then change plan section shouldn't have any storage errors
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 121 |
    And I refresh Resource Summary section
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 1 GB storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I refresh Change Plan section
    Then the storage error message of change plan section should be:
    """
    Your organization is now using 1 GB storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.15728 @bus @auto_grow @tasks_p2 @ROR_smoke
  Scenario: 15728 BILL.9000 Autogrow may be enabled or disabled OEM
    When I add a new OEM partner:
      | company name        | Root role   |
      | TC.15728oem_partner | D-SaaS Root |
    Then New partner should be created
    And I stop masquerading as sub partner
    And I stop masquerading
    When I search partner by TC.15728oem_partner
    And I view partner details by TC.15728oem_partner
    And I Enable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | Yes (change)     |
    And I Disable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | No (change)      |
    And I delete partner account

  @TC.15726 @bus @auto_grow @tasks_p2
  Scenario: 15726:BILL.9000 Autogrow may be enabled or disabled Business
    When I add a new MozyEnterprise partner:
      | company name     | period | users | server plan | server add on |
      | TC.15726_partner |   36   | 30    | 2 TB        | 1             |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.15726_sub_partner |
    Then New partner should be created
    And I stop masquerading
    When I search partner by TC.15726_sub_partner
    And I view partner details by TC.15726_sub_partner
    And I Enable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | Yes (change)     |
    And I Disable partner details autogrow
    Then Partner general information should be:
      | Enable Autogrow: |
      | No (change)      |
    And I delete partner account

  @TC.21938 @bus @auto_grow @tasks_p2
  Scenario: 21938 [Itemized]Resource Summary and Change plan warn the user to purchase or reduce (Server/Desktop)quota
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      |   12   | 8     | 100 GB      |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    #desktop
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21938 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 200 |
    Then tds returns successful upload
    And I navigate to Resource Summary section from bus admin console page
    Then the storage error message of resource summary section should be:
    """
    No Desktop Storage Available
    """
    And I navigate to Change Plan section from bus admin console page
    Then change plan section shouldn't have any storage errors
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 202 |
    And I refresh Resource Summary section
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 2 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I refresh Change Plan section
    Then the storage error message of change plan section should be:
    """
    Your organization is now using 2 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I delete user
    #server
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Server       | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_21938 | <%=@new_users.first.email%> | Server       |
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 100 |
    Then tds returns successful upload
    And I navigate to Resource Summary section from bus admin console page
    Then the storage error message of resource summary section should be:
    """
    No Server Storage Available
    """
    And I navigate to Change Plan section from bus admin console page
    Then change plan section shouldn't have any storage errors
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 101 |
    And I refresh Resource Summary section
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 1 GB Server storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I refresh Change Plan section
    Then the storage error message of change plan section should be:
    """
    Your organization is now using 1 GB Server storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21939 @bus @auto_grow @tasks_p2
  Scenario: 21939 [Itemized]Resource Summary and Change plan warn the user to purchase or reduce (Server/Desktop)quota
    When I add a new MozyEnterprise partner:
      | company name                | period | users | server plan |
      | TC.21939_enterprise_partner |   36   | 8     | 100 GB      |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I navigate to Billing Information section from bus admin console page
    And I Enable billing info autogrow
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21939 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 150 |
    Then tds returns successful upload
    And I navigate to Resource Summary section from bus admin console page
    Then resource summary section shouldn't have any storage errors
    And I navigate to Change Plan section from bus admin console page
    Then change plan section shouldn't have any storage errors
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                    |
      | TC.21939_enterprise_sub_partner |
    And New partner should be created
    And I get the partner_id
    And I change pooled resource for the subpartner:
      | Desktop Storage | Desktop Devices |
      | 50              | 1               |
    And I upload data to device by batch
      | machine_id                         | GB  |
      | <%=@new_clients.first.machine_id%> | 151 |
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_21939 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 10 |
    Then tds returns successful upload
    And I stop masquerading as sub partner
    And I navigate to Resource Summary section from bus admin console page
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 1 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I navigate to Change Plan section from bus admin console page
    Then the storage error message of change plan section should be:
    """
    Your organization is now using 1 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 51 |
    And I upload data to device by batch
      | machine_id                         | GB    | upload_file |
      | <%=@new_clients.first.machine_id%> | 0.001 | true        |
    Then tds return message should be:
    """
    Account or container quota has been exceeded
    """
    And I stop masquerading
    When I search partner by TC.21939_enterprise_sub_partner
    And I view partner details by TC.21939_enterprise_sub_partner
    And I Enable partner details autogrow
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 51 |
    Then tds returns successful upload
    And I act as partner by:
      | name                            |
      | TC.21939_enterprise_sub_partner |
    And I navigate to Resource Summary section from bus admin console page
    Then the storage error message of resource summary section should be:
    """
    Your organization is now using 1 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I navigate to Purchase Resources section from bus admin console page
    Then the storage error message of purchase resource section should be:
    """
    Your organization is now using 1 GB Desktop storage more than was purchased. You can purchase more storage or reduce consumption of storage space.
    """
    And I stop masquerading
    And I search and delete partner account by TC.21939_enterprise_sub_partner
    And I search and delete partner account by TC.21939_enterprise_partner







