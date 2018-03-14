Feature: Add a new MozyEnterprise partner

  As a Mozy Administrator
  I want to create MozyEnterprise partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.18144 @bus @2.5 @add_new_partner @mozyenterprise @env_dependent @regression @core_function
  Scenario: 18144 Add New MozyEnterprise Partner - US - Yearly - 100 Users - Coupon - CC
    When I add a new MozyEnterprise partner:
      | period | users | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 100   | 20PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9,500.00
    And Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 100      | $95.00     | $9,500.00   |
      | Discounts Applied   |          |            | -$1,900.00  |
      | Pre-tax Subtotal    |          |            | $7,600.00   |
      | Total Charges       |          |            | $7,600.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 2.4 TB      | 2.4 TB | 0    | 100       | 100      |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $7,600.00 | $7,600.00  | $0.00       |
    And I delete partner account

  @TC.18147 @bus @2.5 @add_new_partner @mozyenterprise @regression @core_function
  Scenario: 18147 Add New MozyEnterprise Partner - US - Biennially - 200 Users - 250 GB Server Plan -10 Add on - CC
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 200   | 250 GB      | 10            | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $58,478.48
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | MozyEnterprise User  | 200      | $181.00    | $36,200.00  |
      | 250 GB Server Plan   | 1        | $2,330.58  | $2,330.58   |
      | 250 GB Server Add-on | 10       | $1,994.79  | $19,947.90  |
      | Pre-tax Subtotal     |          |            | $58,478.48  |
      | Total Charges        |          |            | $58,478.48  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 5000      | 5000     | 0    | 200       | 200      |
      | Server  | 0    | 2750      | 2750     | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Biennial           |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years         | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years         |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $58,478.48 | $58,478.48 | $0.00       |
    And I delete partner account

  @TC.18150 @bus @2.5 @add_new_partner @mozyenterprise @env_dependent @regression @core_function
  Scenario: 18150 Add New MozyEnterprise Partner - US - 3 Years - 300 Users - 500 GB Server Plan - 10 Add on - Coupon - CC
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 36     | 300   | 500 GB      | 10            | 20PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $112,496.40
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | MozyEnterprise User  | 300      | $259.00    | $77,700.00  |
      | 500 GB Server Plan   | 1        | $6,299.40  | $6,299.40   |
      | 250 GB Server Add-on | 10       | $2,849.70  | $28,497.00  |
      | Discounts Applied    |          |            | -$22,499.28 |
      | Pre-tax Subtotal     |          |            | $89,997.12  |
      | Total Charges        |          |            | $89,997.12  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 7500      | 7500     | 0    | 300       | 300      |
      | Server  | 0    | 3000      | 3000     | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | 3-year             |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 3 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 3 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $89,997.12 | $89,997.12 | $0.00       |
    And I delete partner account

  @TC.18156 @bus @2.5 @add_new_partner @mozyenterprise @regression @core_function
  Scenario: 18156 Add New MozyEnterprise Partner - US - Yearly - 400 Users - 1 TB Server Plan - 10 Add on - CC
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | 400   | 1 TB        | 10            | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $52,958.68
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | MozyEnterprise User  | 400      | $95.00     | $38,000.00  |
      | 1 TB Server Plan     | 1        | $4,509.78  | $4,509.78   |
      | 250 GB Server Add-on | 10       | $1,044.89  | $10,448.90  |
      | Pre-tax Subtotal     |          |            | $52,958.68  |
      | Total Charges        |          |            | $52,958.68  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 10000     | 10000    | 0    | 400       | 400      |
      | Server  | 0    | 3524      | 3524     | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $52,958.68 | $52,958.68 | $0.00       |
    And I delete partner account

  @TC.17962 @bus @2.5 @add_new_partner @mozyenterprise @env_dependent @regression @core_function
  Scenario: 17962 Add New MozyEnterprise Partner - US - Biennially - 500 Users - 2 TB Server Plan - Coupon - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | server plan | coupon              | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 500   | 2 TB        | 20PERCENTOFFOUTLINE | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    And Sub-total before taxes or discounts should be $107,089.58
    Then Order summary table should be:
      | Description         | Quantity | Price Each | Total Price |
      | MozyEnterprise User | 500      | $181.00    | $90,500.00  |
      | 2 TB Server Plan    | 1        | $16,589.58 | $16,589.58  |
      | Discounts Applied   |          |            | -$21,417.92 |
      | Pre-tax Subtotal    |          |            | $85,671.66  |
      | Total Charges       |          |            | $85,671.66  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 12500     | 12500    | 0    | 500       | 500      |
      | Server  | 0    | 2048      | 2048     | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Biennial           |
      | Unpaid Balance: | $85,671.66             | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $85,671.66 | $0.00      | $85,671.66  |
    And I delete partner account

  @TC.17963 @bus @2.5 @add_new_partner @mozyenterprise @regression @core_function
  Scenario: 17963 Add New MozyEnterprise Partner - US - 3 Years - 600 Users - 4 TB Server Plan - 10 Add on - Net Terms
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 36     | 600   | 4 TB        | 10            | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $228,596.40
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | MozyEnterprise User  | 600      | $259.00    | $155,400.00 |
      | 4 TB Server Plan     | 1        | $44,699.40 | $44,699.40  |
      | 250 GB Server Add-on | 10       | $2,849.70  | $28,497.00  |
      | Pre-tax Subtotal     |          |            | $228,596.40 |
      | Total Charges        |          |            | $228,596.40 |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 15000     | 15000    | 0    | 600       | 600      |
      | Server  | 0    | 6596      | 6596     | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | 3-year             |
      | Unpaid Balance: | $228,596.40            | Collect On:     | N/A                |
      | Renewal Date:   | after 3 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 3 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid | Balance Due |
      | today | $228,596.40 | $0.00      | $228,596.40 |
    And I delete partner account

  @TC.18736 @bus @2.5 @add_new_partner @mozyenterprise @regression @core_function
  Scenario: 18736 Add New MozyEnterprise Partner US Without Initial Purchases
    When I add a new MozyEnterprise partner:
      | period | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner internal billing should be:
      | Account Type:   | Other/None            | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

  @TC.18721 @bus @2.5 @add_new_partner @mozyenterprise @regression @core_function
  Scenario: 18721 Verify MozyEnterprise partner has 3 period options
    When I navigate to Add New Partner section from bus admin console page
    Then MozyEnterprise partner subscription period options should be:
      | Yearly | Biennially | 3 years |

  @TC.20378 @bus @2.5 @add_new_partner @mozyenterprise @env_dependent @regression @core_function
  Scenario: 20378 Add New MozyEnterprise Partner - US - Yearly - 10 Users - 500 B Server Plan - 2 Add on - Coupon - CC
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | coupon               |
      | 12     | 10    | 500 GB      | 2             | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $5,349.56
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | MozyEnterprise User  | 10       | $95.00     | $950.00     |
      | 500 GB Server Plan   | 1        | $2,309.78  | $2,309.78   |
      | 250 GB Server Add-on | 2        | $1,044.89  | $2,089.78   |
      | Discounts Applied    |          |            | -$5,349.56  |
      | Total Charges        |          |            | $0.00       |
    And New partner should be created
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

#   @STT_vmbu  @STT_vmbu_ent
#   Scenario: Add New MozyEnterprise Partner - US - 3 Years - 600 Users - 4 TB Server Plan - 10 Add on - Net Terms
#     #When I navigate to bus admin console login page
#     #When I log in bus admin console with user name christine@mozy2.com and password test1234
#     When I add a new MozyEnterprise partner:
#       | period | users | server plan | server add on | coupon               | country       | address           | city      | state abbrev | zip   | phone          |
#       | 36     | 600   | 4 TB        | 10            | 20PERCENTOFFOUTLINE  | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
#     And I change root role to FedID role
#     And I act as newly created partner
#     ##create user groups and client configurations
#     When I create a new client config:
#       | name    | type   |
#       | default | Server |
#     And I add a new Itemized user group:
#       | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices  | enable_stash|
#       | private_group     | Shared               | 20               | Shared              | 50             | yes         |
#     Then private_group user group should be created
#     When I create a new client config:
#       | name | user group | type   | private key       |
#       | private | private_group | Server | only private key |
#     And I add a new Itemized user group:
#       | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices  | enable_stash|
#       | ckey_group        | Shared               | 20               | Shared              | 50             | yes         |
#     Then ckey_group user group should be created
#     When I create a new client config:
#       | name | user group | type   | ckey                         |
#       | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#     Then client configuration section message should be Your configuration was saved.
#     ##create users
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#       | default_desktop | (default user group) | Desktop      |               | 2       | yes          |
#     Then 1 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#       | ckey_desktop    | ckey_group           | Desktop      |               | 2       | yes          |
#     Then 1 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | default_server1 | (default user group) | Server       |               | 2       |
#       | default_server2 | (default user group) | Server       |               | 2       |
#     Then 2 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | private_server1 | private_group        | Server       |               | 2       |
#       | private_server2 | private_group        | Server       |               | 2       |
#     Then 2 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | ckey_server1    | ckey_group           | Server       |               | 2       |
#       | ckey_server2    | ckey_group           | Server       |               | 2       |
#     Then 2 new user should be created
#     ## create sub-partner
#     When I navigate to Add New Role section from bus admin console page
#     And I add a new role:
#       | Name    | Type          |
#       | newrole | Partner admin |
#     And I check all the capabilities for the new role
#     And I close the role details section
#     When I navigate to Add New Pro Plan section from bus admin console page
#     Then I add a new pro plan for MozyEnterprise partner:
#       | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
#       | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
#     And I add a new sub partner:
#       | Company Name |
#       | STT_subent    |
#     And New partner should be created
#     And I act as newly created partner
#     And I purchase resources:
#       | desktop license | desktop quota | server license | server quota |
#       | 80              | 2200            | 80           | 2200           |
#     Then Resources should be purchased
#     ##create sub-partner user groups and client configuration
#     When I create a new client config:
#       | name    | type   |
#       | default | Server |
#     And I add a new Itemized user group:
#       | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices  | enable_stash|
#       | private_group     | Shared               | 20               | Shared              | 20             | yes         |
#     Then private_group user group should be created
#     When I create a new client config:
#       | name | user group | type   | private key       |
#       | private | private_group | Server | only private key |
#     And I add a new Itemized user group:
#       | name              | desktop_storage_type | desktop_devices | server_storage_type | server_devices  | enable_stash|
#       | ckey_group        | Shared               | 20               | Shared              | 20             | yes         |
#     Then ckey_group user group should be created
#     When I create a new client config:
#       | name | user group | type   | ckey                         |
#       | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#     Then client configuration section message should be Your configuration was saved.
#     ##create sub-partner users
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#       | default_desktop | (default user group) | Desktop      |               | 2       | yes          |
#     Then 1 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#       | ckey_desktop    | ckey_group           | Desktop      |               | 2       | yes          |
#     Then 1 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | default_server1 | (default user group) | Server       |               | 2       |
#       | default_server2 | (default user group) | Server       |               | 2       |
#     Then 2 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | private_server1 | private_group        | Server       |               | 2       |
#       | private_server2 | private_group        | Server       |               | 2       |
#     Then 2 new user should be created
#     When I add new user(s):
#       | name            | user_group           | storage_type | storage_limit | devices |
#       | ckey_server1    | ckey_group           | Server       |               | 2       |
#       | ckey_server2    | ckey_group           | Server       |               | 2       |
#     Then 2 new user should be created


