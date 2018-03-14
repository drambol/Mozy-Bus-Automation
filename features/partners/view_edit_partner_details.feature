Feature: View Edit Partner Details

  Background:
    Given I log in bus admin console as administrator

  @TC.1649 @selenium @bus @others @regression @core_function @subdomain
  Scenario: 1649 Set a partners subdomain
    When I add a new MozyPro partner:
    | period | base plan |
    | 1      | 50 GB     |
    Then New partner should be created
    When I change the subdomain to @subdomain
    Then The subdomain is created with name https://@subdomain.mozypro.com/
    And The subdomain in BUS will be @subdomain
    And I delete partner account

  @TC.1051 @bus @2.5 @partner @regression @core_function
  Scenario: 1051 Verify Partner Details Links - Strings
    When I add a new MozyPro partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 10 GB            | 1        | $9.99      | $9.99       |
      | Pre-tax Subtotal |          |            | $9.99       |
      | Total Charges    |          |            | $9.99       |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:| Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro| @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $9.99  | $9.99      | $0.00       |
    And I delete partner account

  # This test cases requires an OEM partner with API Key
  # Test account Barclays Root - Reserved is in QA6 only
  #
  # Todo: this case need to check create ip white list successful message
  @TC.643 @need_test_account @bus @2.5 @partner @ip_white_list_visibility @env_dependents @regression @core_function
  Scenario: 643 Verify White List visibility for an OEM partner with an API Key
    When I search partner by:
      | name                     | filter |
      | Barclays Root - Reserved | OEMs   |
    Then I view partner details by Barclays Root - Reserved
    And Partner ip whitelist should be 250.250.250.250

  # Todo: this case need to check create ip white list successful message
  # Todo: This test cases could be failed because no ui for api creating if partner uses pooled storage
  @TC.644 @bus @2.5 @partner @ip_white_list_visibility @regression @core_function @ROR_smoke
  Scenario: 644 Verify White List visibility for a Corp partner with an API Key
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And I Create an API key for current partner
    When I add a new ip whitelist 250.250.250.250
    Then Partner ip whitelist should be 250.250.250.250
    And I delete partner account

  # This test cases requires an OEM partner without API Key
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.645 @need_test_account @bus @2.5 @partner @ip_white_list_visibility @env_dependent @regression @core_function
  Scenario: 645 Verify White List visibility for an OEM partner without an API Key
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then I view partner details by Charter Business Trial - Reserved
    And Partner API key should be empty
    And Partner ip whitelist should be There is no current API key.

  # Todo: This test cases could be failed because no ui for api creating if partner uses pooled storage
  @TC.646 @bus @2.5 @partner @ip_white_list_visibility @regression @core_function
  Scenario: 646 Verify White List visibility for a Corp partner without an API Key
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And Partner API key should be empty
    And Partner ip whitelist should be There is no current API key.

  @TC.122225 @bus @partners_setting @tasks_p1
  Scenario: Mozy-122225:Click Settings Link
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false   |
    Then I delete partner account

  @TC.122226 @bus @partners_setting @tasks_p1 @ROR_smoke
  Scenario: Mozy-122226:Edit partner settings
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    Then I verify partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    Then I delete partner account

  @TC.122227 @bus @partner_setting @tasks_p1
  Scenario: Mozy-122227:Lock setting as parent
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    And New partner should be created
    Then I change root role to FedID role
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 GB    | 100 GB   | 0    | Unlimited | Unlimited |
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | test1        |
    And New partner should be created
    Then I stop masquerading
    And I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | true   |
    Then I act as partner by:
      | email        |
      | @admin_email |
    And I search partner by newly created subpartner company name
    Then I view partner details by newly created subpartner company name
    Then I verify partner settings
      | Name                            | Value | Locked |
      | mobile_access_enabled_external  | t     | true   |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.129678 @bus @partners_setting @tasks_p1
  Scenario: Mozy-129678:2.15 VMBU: Partner Setting
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I add partner settings
      | Name             | Value | Locked |
      | enable_vmbu_beta | t     | false  |
    Then I verify partner settings
      | Name             | Value | Locked |
      | enable_vmbu_beta | t     | false  |
    Then I delete partner account

  @TC.2007 @bus @partners_setting @tasks_p1
  Scenario: Mozy-2007:Enforce association between email addresses and emailed keys (desktop)
    When I add a new OEM partner:
      | Company Name    | Root role         | Security | Company Type     |
      | test_for_2007TC | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    Then I stop masquerading as sub partner
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | enforce_email_key_match | t     | false  |
    When I set product name for the partner
    Then I navigate to old window
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name     | email               |
      | oem user | tc2007test@mozy.com |
    And new itemized user should be created
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I update the user password to reset password
    Then I navigate to Assign Keys section from bus admin console page
    Then I assign Desktop key to user tc2007test@mozy.com on (default user group)
    Then I use key activation to activate devices
      | email                       | machine_name |
      | tc2007test_invalid@mozy.com | machine_2007 |
    Then Activate key response should be ERROR: KEY UNAVAILABLE
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.2008 @bus @partners_setting @tasks_p1
  Scenario: Mozy-2008:Enforce association between email addresses and emailed keys (server)
    When I add a new OEM partner:
      | Company Name    | Root role         | Security | Company Type     |
      | test_for_2008TC | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    Then I stop masquerading as sub partner
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | enforce_email_key_match | t     | false  |
    When I set product name for the partner
    Then I navigate to old window
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name     | email               |
      | oem user | tc2008test@mozy.com |
    And new itemized user should be created
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I update the user password to reset password
    Then I navigate to Assign Keys section from bus admin console page
    Then I assign Server key to user tc2008test@mozy.com on (default user group)
    Then I use key activation to activate devices
      | email                       | machine_name |
      | tc2008test_invalid@mozy.com | machine_2008 |
    Then Activate key response should be ERROR: KEY UNAVAILABLE
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.2052 @bus @partners_setting @tasks_p1
  Scenario: Mozy-2052:enforce key to email-moving user groups
    When I add a new OEM partner:
      | Company Name    | Root role         | Security | Company Type     |
      | test_for_2052TC | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    Then I stop masquerading as sub partner
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    When I add partner settings
      | Name                    | Value | Locked |
      | enforce_email_key_match | t     | false  |
    When I set product name for the partner
    Then I navigate to old window
    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I save current purchased resources
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name     | email               |
      | oem user | tc2052test@mozy.com |
    And new itemized user should be created
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I update the user password to reset password
    Then I navigate to Assign Keys section from bus admin console page
    Then I assign Desktop key to user tc2052test@mozy.com on (default user group)
    When I add a new user group for an itemized partner:
      | name         |
      | 2052_ug_test |
    Then I search user by:
      | name     |
      | oem user |
    Then I view user details by oem user
    Then I reassign the user to user group 2052_ug_test
    Then I use key activation to activate devices
      | email               | machine_name |
      | tc2052test@mozy.com | machine_2052 |
    Then Activate key response should be OK
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  #bus issue 141992
  @TC.15508 @bus @edit_partner_details @tasks_p2
  Scenario: 15508 BILL.10010 MozyPro Partner Account Name is programatically sync'd with Aria
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 500 GB     | yes         |
    Then New partner should be created
    And I get partner aria id
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner admin email
    And I click admin name newly created admin name in partner details section
    And edit admin details:
      | Name:             |
      | Fancisco1 Pardue1 |
    Then edit sub admin personal information success message should display
    Then API* Aria account should be:
      | first_name | last_name  |
      | Fancisco1  | Pardue1    |
    When API* I set newly created partner aria id account contact to:
      | first_name | last_name |
      | fname      | lname     |
    Then API* Aria account should be:
      | first_name | last_name  |
      | fname      | lname      |
#    And I refresh the partner details section
#    Then Partner general information should be:
#      | Root Admin:          |
#      | fname lname (act as) |
    And I delete partner account

  @TC.15478 @bus @edit_partner_details @tasks_p2
  Scenario: 15478 BILL.10001 Mozy Admin Edits Subpartner Account
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota  |
      | TC.15478_partner | 12     | Gold          | 1000            |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.15478_sub_partner   | subplan      | subadmin   |
    Then New partner should be created
    And I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
      | sh add test 123  | Richtest      | AL             | 12345                    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: | Pricing Plan: |
      | sh add test 123  | Richtest      | AL             | 12345                    | subplan       |
    And I stop masquerading
    And I search partner by:
      | name                  |
      | TC.15478_sub_partner  |
    And I view partner details by TC.15478_sub_partner
    Then Partner details shouldn't have Aria ID
    And I delete partner account
    And I search and delete partner account by TC.15478_partner

  # existing bug 141992
  @TC.15481 @bus @edit_partner_details @tasks_p2
  Scenario: 15481 BILL.10009 sales and support representatives edit partner account in Aria
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 36     | 30    | 2 TB        | 1             |
    Then New partner should be created
    And I get partner aria id
    When API* I set newly created partner aria id account contact to:
      | first_name  | last_name |
      | Ftestname   | Ltestname |
    Then API* Aria account should be:
      | first_name | last_name  |
      | Ftestname  | Ltestname  |
#    And I refresh the partner details section
#    Then Partner general information should be:
#      | Root Admin:                  |
#      | Ftestname Ltestname (act as) |
    And I delete partner account

  @TC.15485 @tasks_p2 @edit_partner_details @bus
  Scenario: 15485 BILL.10006 OEM admins edit of sub-partners is continued support
    When I add a new OEM partner:
      | company name          | Root role   | Company Type     |
      | TC.15485_OEM_partner  | D-SaaS Root | Service Provider |
    Then New partner should be created
    And I act as newly created partner
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                | Pricing Plan | Admin Name |
      | TC.15485_OEM_sub_partner    | subplan      | subadmin   |
    And New partner should be created
    And I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: |
      | sh add test oem  | Richoemtest   | AR             | 12345                    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact City: | Contact State: | Contact ZIP/Postal Code: | Pricing Plan: |
      | sh add test oem  | Richoemtest   | AR             | 12345                    | subplan       |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.15485_OEM_sub_partner
    And I search and delete partner account by TC.15485_OEM_partner

  @TC.15650 @tasks_p2 @edit_partner_details @bus
  Scenario: 15650 BILL.10515 Partner Removes VAT is from partner details not tax exempt
    When I add a new MozyEnterprise partner:
      | period | base plan | country | vat number    |  cc number         |
      | 24     | 1 TB      | France  | FR08410091490 |  4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      |                  |
    Then Partner contact information is changed
    And Partner contact information should be:
      | VAT Number:     |
      |                 |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account








