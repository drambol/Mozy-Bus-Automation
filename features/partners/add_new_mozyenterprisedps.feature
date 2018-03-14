Feature: Add a new MozyEnterprise DPS partner

  As a Mozy Administrator
  I want to create MozyEnterprise DPS partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.22365 @bus @2.7 @add_new_partner @mozyenterprisedps @regression @core_function
Scenario: 22365 Add New MozyEnterprise DPS Partner - US - Yearly - 2 TB
  When I add a new MozyEnterprise DPS partner:
    | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
    | 12     | 2         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
  Then Sub-total before taxes or discounts should be $0.00
  And Order summary table should be:
    | Description             | Quantity | Price Each | Total Price |
    | TB - MozyEnterprise DPS | 2        | $0.00      | $0.00       |
    | Total Charges           |          |            | $0.00       |
  And New partner should be created
  And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: |
    | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         |
  And Partner contact information should be:
    | Company Type:      | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
    | MozyEnterprise DPS | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
  And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            | -1       |
    | Default Sync Storage:  |          |
  And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 2 TB      | 2 TB     | 0    | Unlimited | Unlimited |
  And Partner stash info should be:
    | Users:         | 0 |
    | Storage Usage: | 0 |
  And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly             |
    | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
    | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
    | Date  | Amount    | Total Paid | Balance Due |
    | today | $0.00     | $0.00      | $0.00       |
  And I delete partner account


#@STT_vmbu  @STT_vmbu_ent_dps
#  Scenario: Add New MozyEnterprise DPS Partner - US - 3 Years - 6 TB
#   When I add a new MozyEnterprise DPS partner:
#      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
#      | 36     | 6         | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
#    And I change root role to FedID role
#    And I enabled server in partner account details
#    And I act as newly created partner
#  ##create user groups and client configurations
#    When I create a new client config:
#      | name    | type   |
#      | default | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | private_group | Shared      | yes          | yes            |
#    Then private_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | private key       |
#      | private | private_group | Server | only private key |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | ckey_group | Shared      | yes          | yes            |
#    Then ckey_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | ckey                         |
#      | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#    Then client configuration section message should be Your configuration was saved.
#  ##create users
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | default_desktop | (default user group) | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | ckey_desktop    | ckey_group           | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | default_server1 | (default user group) | Server       |               | 2       |
#      | default_server2 | (default user group) | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | private_server1 | private_group        | Server       |               | 2       |
#      | private_server2 | private_group        | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | ckey_server1    | ckey_group           | Server       |               | 2       |
#      | ckey_server2    | ckey_group           | Server       |               | 2       |
#    Then 2 new user should be created
#
#  ## create sub-partner
#    When I navigate to Add New Role section from bus admin console page
#    And I add a new role:
#      | Name    | Type          |
#      | newrole | Partner admin |
#    And I check all the capabilities for the new role
#    And I close the role details section
#    When I navigate to Add New Pro Plan section from bus admin console page
#    Then I add a new pro plan for MozyEnterprise DPS partner:
#      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
#      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
#    And I add a new sub partner:
#      | Company Name |
#      | STT_subent_dps    |
#    And New partner should be created
#    And I act as newly created partner
#    And I purchase resources:
#      | generic quota |
#      | 2200             |
#    Then Resources should be purchased
#
#  ##create sub-partner user groups and client configuration
#    When I create a new client config:
#      | name    | type   |
#      | default | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | private_group | Shared      | yes          | yes            |
#    Then private_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | private key       |
#      | private | private_group | Server | only private key |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | ckey_group | Shared      | yes          | yes            |
#    Then ckey_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | ckey                         |
#      | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#    Then client configuration section message should be Your configuration was saved.
#  ##create sub-partner users
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | default_server1 | (default user group) | Server       |               | 1       |
#      | default_server2 | (default user group) | Server       |               | 1       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | private_server1 | private_group        | Server       |               | 1       |
#      | private_server2 | private_group        | Server       |               | 1       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | ckey_server1    | ckey_group           | Server       |               | 1       |
#      | ckey_server2    | ckey_group           | Server       |               | 1       |
#    Then 2 new user should be created
#

  @TC.22481 @bus @dps_partner @tasks_p3
  Scenario: Mozy-22481: Verify that general functions work for DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22481 user | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then user details should be:
      | Name:                  | Enable Sync:                |
      | TC.22481 user (change) | Yes (Send Invitation Email) |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise DPS partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax |
      | subplan | business     | subrole   | Yes     | No     |          | yearly  | 10             | test     | false            |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    When I navigate to Billing Information section from bus admin console page
    Then Next renewal info table should be:
      | Period          | Date         |
      | Yearly (change) | after 1 year |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.22482 @bus @dps_partner @tasks_p3
  Scenario: Mozy-22482: Verify that general functions work for DPS user.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I get the partner_id
    Then I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.22481 user | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then the user log out bus
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22484 @bus @dps_partner @tasks_p3
  Scenario: Mozy-22484: Verify that server can configure client when working as DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | MozyEnterprise Windows |
    When I clear downloads folder
    And I click download link for MozyEnterprise Windows
    Then client started downloading successfully
    When I create a new client config:
      | name                         | type    | automatic max load | automatic min idle | automatic interval |
      | TC22484-server-client-config | Server  | 10                 | 10                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.22484.User | (default user group) | Server       | 40            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_22484 | <%=@new_users.first.email%> | Server       |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch | codename       | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | windows  | x64  | MozyEnterprise | 0.0.0.1 |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

