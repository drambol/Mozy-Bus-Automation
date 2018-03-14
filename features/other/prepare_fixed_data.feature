Feature: Add missing fixed data

  As a Mozy Administrator
  I want to provision fixed data which are hard coded in test cases
  so that the environment is ready for automation testing

  Background:
    Given I log in bus admin console as administrator

  @fixed_data_preparation @initialize
  Scenario: add missing role, partner 'FedID Encoding Automation Test[Dont Edit]', user group under FedID partner, LDAP settings
    #add 'FedID role' in MozyPro
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I click start using mozy button
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type           | Parent       |
      | FedID role   | Partner admin  | MozyPro Root |
    And I check all the capabilities for the new role
    And I stop masquerading
    #add 'MozyEnterprise' role in MozyEnterprise
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I click start using mozy button
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name             | Type           | Parent        |
      | MozyEnterprise   | Partner admin  | + ADRTestRole |
    And I check all the capabilities for the new role
    And I stop masquerading
    #add a MozyPro partner
    When I add a new MozyPro partner:
      | company name                              | admin name                     | admin email             | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | FedID Encoding Automation Test[Dont Edit] | FedID Encoding Automation Test | encoding_fedid@auto.com | 1      | 250 GB    | United States | 111         | 111       | AK           | 12345 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    #add a user group in fedid partner
    And I act as partner by:
      | email                   |
      | encoding_fedid@auto.com |
    And I add a new Bundled user group:
      | name    | storage_type | enable_stash |
      | Test    | Shared       | yes          |
    #ldap settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to 10.29.103.120 on port 389 using No SSL.
    And I save the Connection Settings information


  @fixed_data_preparation @initialize
  Scenario: add missing parter 'FedID Automation QA6[Do not edit]', user group 'dev', add pro plan, add role, subpartner, ldap settings
    #add MozyPro partner
    When I add a new MozyPro partner:
      | company name                    | admin name           | admin email                  | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | FedID Automation QA6[Dont Edit] | QA6 FedID Automation | qa8+saml+test+admin@mozy.com | 1      | 500 GB    | United States | 111         | 111       | AK           | 12345 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    #add user group in partner
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I add a new Bundled user group:
      | name    | storage_type | enable_stash |
      | dev     | Shared       | yes          |
    #add new role in partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | newrole | Partner admin | FedID role    |
    And I check all the capabilities for the new role
    #add new pro plan in partner
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 1.0            | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #add sub partner in created partner
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name | Admin Email Address            |
      | subpartner   | newplan      | subadmin   | mozyautotest+3pf8mtkux@emc.com |
    Then New partner should be created
    #ldap settings
    And I navigate to Authentication Policy section from bus admin console page
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully


  @fixed_data_preparation @initialize
  Scenario: add missing oem partner 'mozybus+q0cusmjgv@gmail.com'
    When I add a new OEM partner:
      | Company Name                | Root role         | Company Type   | Admin Name      | Admin Email Address         |
      | test_for_126029_DO_NOT_EDIT | OEM Partner Admin | Business       | Michelle Lawson | mozybus+q0cusmjgv@gmail.com |
    Then New partner should be created
    When I change the partner subdomain to osngbedo
    Then The partner subdomain is created with name https://osngbedo.mozypro.com/
    When I search partner by mozybus+q0cusmjgv@gmail.com
    When I view admin details by mozybus+q0cusmjgv@gmail.com
    And I active admin in admin details default password


  @fixed_data_preparation @initialize
  Scenario: add 'FedID role' for MozyEnterprise
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I click start using mozy button
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name             | Type           | Parent        |
      | FedID role       | Partner admin  | MozyPro Root  |
    And I check all the capabilities for the new role


  @fixed_data_preparation @initialize
  Scenario: Add MozyPro partner "Internal Mozy - MozyPro with edit user group capability"
    When I add a new MozyPro partner:
      | company name                                            | admin name       | admin email                         | period | base plan | server plan | storage add on | net terms | country       | address     | city      | state abbrev | zip   | phone      |
      | Internal Mozy - MozyPro with edit user group capability | Admin Automation | mozybus+bonnie+perez+0110@gmail.com | 1      | 1 TB      | yes         | 10             | yes       | United States | 111         | 111       | KS           | 85059 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to Bundle Pro Partner Root
    And I enabled server in partner account details


  @fixed_data_preparation @initialize
  Scenario: Add Reseller partner "TC.122139 [DO NOT EDIT]"
    When I add a new Reseller partner:
      | company name            | period | reseller type | reseller quota | server plan | admin name     | admin email                              |
      | TC.122139 [DO NOT EDIT] | 1      | Silver        | 500            | yes         | Karen Marshall | mozyautotest+brandon+howard+1513@emc.com |
    Then New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role


  @fixed_data_preparation @initialize
  Scenario: Add MozyPro partner "FedID pull PostQA Test 2"
    When I add a new MozyPro partner:
      | company name             | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | FedID pull PostQA Test 2 | 1      | 500 GB    | United States | 111         | 111       | KS           | 85059 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as partner by:
      | name                     |
      | FedID pull PostQA Test 2 |
    And I add a new Bundled user group:
      | name    | storage_type | enable_stash |
      | qa      | Shared       | yes          |


  @fixed_data_preparation @initialize
  Scenario: Add MozyPro partner "kalen.quam+qa6+marilyn+dean+1118@mozy.com"
    When I add a new MozyPro partner:
      | company name    | admin email                               | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | Dynaburr        | kalen.quam+qa6+marilyn+dean+1118@mozy.com | 1      | 500 GB    | United States | 111         | 111       | KS           | 85059 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to SMB Bundle Limited


  @fixed_data_preparation @initialize
  Scenario: Add root role "FedID role" for MozyEnterprise
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I click start using mozy button
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name       | Type           | Parent              |
      | FedID role | Partner admin  | MozyEnterprise Root |
    And I check all the capabilities for the new role


  @fixed_data_preparation @initialize
  Scenario: Add MozyEnterprise partner "mozyautotest+sean+walker+1513@emc.com"
    When I add a new MozyEnterprise partner:
      | company name                                                   | admin email                           | admin name       | period | users  |  server plan | net terms |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | 36     | 10     |  100 GB      | yes       |
    And New partner should be created
    When I view the newly created partner admin details
    And I activate new partner admin with default password
    And I change root role to FedID role


  @fixed_data_preparation @initialize
  Scenario: Add new role "Sales"
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name  | Type              | Parent |
      | Sales | Mozy, Inc. admin  | Root   |


  @fixed_data_preparation @initialize
  Scenario: Add root role "Leong Test Role" for MozyPro
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I click start using mozy button
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name            | Type           | Parent       |
      | Leong Test Role | Partner admin  | MozyPro Root |
    And I check all the capabilities for the new role


  @fixed_data_preparation @initialize
  Scenario: Add delete partner capability for "Reseller Root" role
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I click start using mozy button
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name          | Type           | Parent       |
      | Reseller Root | Partner admin  | MozyPro Root |
    And I uncheck all the capabilities for the new role
    And I add capabilities for the new role:
      |Capabilities                             |
      |Suspend users, user groups, or partners  |
      |View user, user group, or partner status |
      |Client Config: Encryption Key Export     |
      |Client Config: Encryption Key: Custom    |
      |Client Config: Encryption Key: Default   |
      |Co-branding: Configure                   |
      |Edit branding                            |
      |Edit client configuration                |
      |Edit error messages                      |
      |Edit network domains                     |
      |Force client update                      |
      |Mobile Access: edit                      |
      |Plans: add/edit/delete                   |
      |Plans: list/view                         |
      |Version Management                       |
      |API Key: view                            |
      |Edit Auth IP Whitelist                   |
      |Partners: add                            |
      |Partners: edit                           |
      |Partners: list/view                      |
      |View Auth IP Whitelist                   |
      |Edit quotas                              |
      |Log in as user                           |
      |Machines: create/edit/delete             |
      |Machines: list/view                      |
      |Perform web restore                      |
      |User groups: create/edit/delete          |
      |User groups: list/view                   |
      |Users: create/edit/delete                |
      |Users: list/view                         |
      |View log files                           |
      |View machine backup history              |
      |View restore history                     |
      |Roles: add/edit/delete                   |
      |Roles: view/assign                       |
      |Admins: add/edit/delete                  |
      |Admins: list/view                        |
      |Log in as admin                          |
      |Co-branding: Edit                        |
      |Co-branding: View                        |
      |Replace Machines                         |
      |Backup Health                            |
      |Backup History                           |
      |Report: Bandwidth                        |
      |Reports page                             |
      |Reports: create/edit                     |
      |Reports: view/run                        |
      |Authentication Policy Management         |
      |Edit billing information                 |
      |Password Policy Management               |
      |View charges                             |
      |Edit Suspended                           |
      |Show Data Center                         |
      |View Suspended                           |
      |Change Plan Resources                    |
      |Download client                          |
      |Edit Sync                                |
      |Purchase resources                       |
      |Return unused resources                  |
      |Transfer resources                       |

  @fixed_data_preparation @initialize
  Scenario: Add a new MozyOEM partner 'test_for_TC.19864_DONOT_EDIT', role 'subrole', user group 'test', pro plan 'subplan', subpartner 'TC.19864'
    When I add a new OEM partner:
      | Company Name                 | Root role     | Company Type     | Admin Name       | Admin Email Address            |
      | test_for_TC.19864_DONOT_EDIT | ITOK OEM Root | Service Provider | Michael Martinez | qa1+tc+19867+reserved@mozy.com |
    Then New partner should be created
    When I act as newly created partner account
    Given I navigate to Add New User Group section from bus admin console page
    When I add a new user group for an itemized partner:
      | name   |
      | test   |
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type            | Parent         |
      | subrole | Partner admin   | ITOK OEM Root  |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role  | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name | Admin Name      | Admin Email Address            |
      | TC.19864     | @TC.19864       | qa1+tc+19811+admin1@mozy.com   |
    Then New partner should be created


  @fixed_data_preparation @initialize
  Scenario: Add user group  in partner 'redacted-374495@notarealdomain.mozy.com'
    When I act as partner by:
      | email                                   |
      | redacted-374495@notarealdomain.mozy.com |
    Given I navigate to Add New User Group section from bus admin console page
    When I add a new user group for an itemized partner:
      | name   |
      | test   |

  @fixed_data_preparation @initialize
  Scenario: Add partner 'qa1+tc+19954+reserved@mozy.com'
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name                   | admin email                    | admin name |
      | 12     | Silver        | 300            | yes         | yes       | Skipstorm Company 0225-0548-39 | qa1+tc+19954+reserved@mozy.com | Ryan Clark |
    Then New partner should be created


  @fixed_data_preparation @initialize
  Scenario: add MozyPro partner 'test120694'
    When I add a new MozyPro partner:
      | company name | admin name  | admin email          | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | test120694   | test        | test_120694@auto.com | 1      | 250 GB    | United States | 111         | 111       | AK           | 12345 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role

    When I act as partner by:
      | email                |
      | test_120694@auto.com |
    And I add new user(s):
      | email                  | name | user_group           | storage_type | storage_limit | devices |
      | tc120694user1@auto.com | test | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc120694user1@auto.com
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name              | machine_type |
      | Sync         | tc120694user1@auto.com | Desktop      |

    And I navigate to Resource Summary section from bus admin console page
    And I add new user(s):
      | email                  | name         | user_group           | storage_type | storage_limit | devices |
      | tc120694user2@auto.com | tc120694use2 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc120694user2@auto.com
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name              | machine_type |
      | Sync         | tc120694user2@auto.com | Desktop      |


  @fixed_data_preparation @initialize
  Scenario: add missing oem partner 'Charter Business Trial - Reserved'
    When I add a new OEM partner:
      | Company Name                      | Root role     | Company Type      | Admin Name    | Admin Email Address     |
      | Charter Business Trial - Reserved | ITOK OEM Root | Service Provider  | Fred Marshall | qa1+opxjhb2bp@decho.com |
    Then New partner should be created


  @fixed_data_preparation @initialize
  Scenario: add oem partner 'HipaaAdminLoginTest' and user 'hippauser'
    When I add a new OEM partner:
      | Company Name        | Root role     | Company Type   | Admin Name      | Admin Email Address          | Security |
      | HipaaAdminLoginTest | ITOK OEM Root | Business       | Michelle Lawson | mozybus+i3m3fifkoi@gmail.com | HIPAA    |
    Then New partner should be created
    When I change the partner subdomain to hipaa01
    Then The partner subdomain is created with name https://hipaa01.mozypro.com/
    And I act as newly created partner
    And I add new itemized user(s):
      | name        | email                   |
      | hippauser   | hipaaloginuser@test.com |
    And new itemized user should be created
    When I search user by:
      | name      |
      | hippauser |
    And I view user details by hippauser
    And I update the user password to Hipaa password
    And I stop masquerading
    When I search partner by mozybus+i3m3fifkoi@gmail.com
    When I view admin details by mozybus+i3m3fifkoi@gmail.com
    And I active admin in admin details Hipaa password


  @fixed_data_preparation @initialize
  Scenario: add oem partner 'Quatz Company 0225-0529-50' and user 'standuser'
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name               | admin email                             | admin name       |
      | 12     | Silver        | 300            | yes         | yes       | Quatz Company 0225-0529-50 | mozybus+phillip+morrison+0529@gmail.com | Phillip Morrison |
    Then New partner should be created
    When I change the partner subdomain to nohipaa01
    Then The partner subdomain is created with name https://nohipaa01.mozypro.com/
    And I act as newly created partner
    And I add new user(s):
      | name      | email                     | user_group           | storage_type | storage_limit | devices |
      | standuser | nohipaaloginuser@test.com | (default user group) |  Desktop     |  20           | 1       |
    Then 1 new user should be created
    And I stop masquerading
    When I search partner by mozybus+phillip+morrison+0529@gmail.com
    When I view admin details by mozybus+phillip+morrison+0529@gmail.com
    And I active admin in admin details Standard password


  @fixed_data_preparation @initialize
  Scenario: 3.5" 2TB Drive by updating seed_device_order_types in db
    And I update seed device order types in db
      | storage_size | sku_size  | sku_name        |
      | 1.8          | 3.5       | 3.5" 2TB Drive  |


  @fixed_data_preparation @initialize
  Scenario: add 'stash_region_override' to settings for MozyEnterprise
    When I search partner by:
      | email                                   |
      | redacted-376413@notarealdomain.mozy.com |
    And I view partner details by MozyEnterprise
    And I add partner settings
      | Name                  | Value | Locked |
      | stash_region_override | qa    | false  |


  @fixed_data_preparation @initialize
  Scenario: add 'stash_region_override' to settings for MozyPro
    When I search partner by:
      | email                                   |
      | redacted-4164@notarealdomain.mozy.com   |
    And I view partner details by MozyPro
    And I add partner settings
      | Name                  | Value | Locked |
      | stash_region_override | qa    | false  |


  @fixed_data_preparation @initialize
  Scenario: Add MozyPro partner 'bundle_for_TC.20803_DONOT_EDIT' and its user/machine, update used quota to 30GB
    When I add a new MozyPro partner:
      | company name                   | admin name    | admin email                            | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | bundle_for_TC.20803_DONOT_EDIT | Sharon Moreno | test_resource_summary_bundled@auto.com | 1      | 100 GB    | United States | 111         | 111       | AK           | 12345 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    #add a user group in fedid partner
    And I act as partner by:
      | email                                  |
      | test_resource_summary_bundled@auto.com |
    And I add new user(s):
      | email                       | name                 | user_group           | storage_type | storage_limit | devices |
      | mozybus+ptifi0z0w@gmail.com | TC.20803.backup-user | (default user group) | Desktop      | 100           | 8       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by mozybus+ptifi0z0w@gmail.com
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 30 GB      |


  @fixed_data_preparation @initialize
  Scenario: Add MozyPro partner 'bundled_subpartner_for_TC.20805_DONOT_EDIT' and subpartner, update used quota to 30GB
    When I add a new MozyPro partner:
      | company name                                | admin name | admin email                                  | period | base plan | country       | address     | city      | state abbrev | zip   | phone      |
      | bundled_subpartner_for_TC.20805_DONOT_EDITT | Doris Ruiz | resource_summary_bundled_subpartner@auto.com | 1      | 100 GB    | United States | 111         | 111       | AK           | 12345 | 1234567890 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as partner by:
      | email                                        |
      | resource_summary_bundled_subpartner@auto.com |
    #add new role in partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | newrole | Partner admin | FedID role    |
    And I check all the capabilities for the new role
    #add new pro plan in partner
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 1.0            | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    #add sub partner in created partner
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name | Admin Email Address           |
      | TC.20805     | newplan      | subadmin   | mozybus+w3rnbz5lan@gmail.com  |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 30              |


  @fixed_data_preparation @initialize
  Scenario: Activate MozyHome
    When I search partner by redacted-4165@notarealdomain.mozy.com
    When I view admin details by redacted-4165@notarealdomain.mozy.com
    And I active admin in admin details default password


  @fixed_data_preparation @initialize
  Scenario: Add a new MozyOEM partner 'Barclays Root - Reserved', role 'subrole', user group 'test', pro plan 'subplan', subpartner 'TC.19864'
    When I add a new OEM partner:
      | Company Name             | Root role     | Company Type     | Admin Name    | Admin Email Address         |
      | Barclays Root - Reserved | ITOK OEM Root | Service Provider | Sarah Frazier | mozybus+nryu75sdb@gmail.com |
    Then New partner should be created
    And I Create an API key for current partner
    When I add a new ip whitelist 250.250.250.250
    Then Partner ip whitelist should be 250.250.250.250


