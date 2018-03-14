Feature: Preferences


  Background:
    Given I log in bus admin console as administrator

  @TC.1336 @tasks_p1 @integration @client_configuration @bus
  Scenario: 1336 Edit a client config (Server)
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  net terms |
      |   1    |  50 GB     |       yes     |     yes    |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                        | type   |
      | TC1336-server-client-config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                        | all settings |
      | TC1336-server-client-config | uncheck      |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1336-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings |
      | unchecked    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1337 @tasks_p1 @integration @client_configuration @bus
  Scenario: 1337 Edit a client config (Desktop)
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |
      |   12   |  250 GB    |   yes         |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                         | type    |
      | TC1337-desktop-client-config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                         | all settings   |
      | TC1337-desktop-client-config | uncheck        |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC1337-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings |
      | unchecked    |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.488 @tasks_p1 @integration @client_configuration @bus
  Scenario: 488 Set a client config option to Cascade -prefrences tab
    When I add a new MozyEnterprise partner:
      | company name   | period | users | server plan | net terms  | root role  |
      | TC.488_partner |   36   | 130   | 16 TB       | yes        | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I create a new client config:
      | name                | type    |
      | TC488-client-config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit client config:
      | name                | warning days |
      | TC488-client-config | 15:cascade   |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC488-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | warning days |
      | 15:cascade   |
    When I add a new sub partner:
      | Company Name       |
      | TC.488_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                  | type    |
      | TC488-client-config-2 | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC488-client-config-2
    And I click tab Preferences
    Then preferences settings should be:
      | warning days | warning days editable |
      | 15:cascade   | all disabled          |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.488_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.488_partner

  @TC.884 @tasks_p1 @integration @client_configuration @bus
  Scenario: 884 Create a new client config (Desktop)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      |   24   | 2     | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                        | type    | all settings  |
      | TC884-desktop-client-config | Desktop | check         |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC884-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings    |
      | checked         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.885 @tasks_p1 @integration @client_configuration @bus
  Scenario: 885 Create a new client config (Server)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      |   12   | 18    | 100 GB      | FedID role | yes       |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                       | type   | all settings   |
      | TC885-server-client-config | Server | check          |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC885-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all settings  |
      | checked       |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.491 @tasks_p1 @integration @client_configuration @bus
  Scenario: 491 Set a client config option to no longer cascade
    When I add a new MozyEnterprise partner:
      | company name   | period | users | server plan | server add on |net terms  | root role  |
      | TC.491_partner |   12   | 15   | 500 GB       | 40            |yes        | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I create a new client config:
      | name                | type    | warning days |
      | TC491-client-config | Desktop | 15:cascade   |
    Then client configuration section message should be Your configuration was saved.
    When I edit client config:
      | name                | warning days        |
      | TC491-client-config | 15:cascade uncheck  |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC491-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | warning days |
      | 15:lock      |
    When I add a new sub partner:
      | Company Name       |
      | TC.491_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    When I create a new client config:
      | name                  | type    |
      | TC491-client-config-2 | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC491-client-config-2
    And I click tab Preferences
    Then preferences settings should be:
      | warning days | warning days editable |
      | 15:lock      | all enabled           |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.491_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.491_partner

  @TC.492 @tasks_p1 @smoke @client_configuration @bus
  Scenario: 492 Delete a cascaded client config
    When I add a new MozyEnterprise partner:
      | company name   | period | users | server plan | server add on | root role  |
      | TC.492_partner |   36   | 30    | 2 TB        | 1             | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I create a new client config:
      | name                 | type    | all cascades |
      | TC.492-client-config | Desktop | check        |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.492-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | all cascades | all locks |
      | checked      | checked   |
    When I add a new sub partner:
      | Company Name       |
      | TC.492_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                   | type    |
      | TC.492-client-config-2 | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.492-client-config-2
    And I click tab Preferences
    Then preferences settings should be:
      | all cascades | all locks |
      | checked      | checked   |
    And I stop masquerading as sub partner
    And I delete configuration TC.492-client-config
    And I search partner by TC.492_sub_partner
    And I view partner details by TC.492_sub_partner
    When I act as newly created partner account
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.492-client-config-2
    And I click tab Preferences
    Then preferences settings should be:
      | all cascades |
      | unchecked    |
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.492_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.492_partner

  @TC.120812 @tasks_p1 @client_configuration @bus
  Scenario: 120812 Validate Cascade Option Removed on BDS Partners
    # MozyEnterprise
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I create a new client config:
      | name                      |
      | TC.120812-client-config-1 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120812-client-config-1
    And I click tab Preferences
    Then cascade option should not exist for encryption key
    And I cancel update client configuration
    And I delete configuration TC.120812-client-config-1
    And I stop masquerading
    # Fortress
    When I act as partner by:
      | name      | including sub-partners |
      | Fortress  | no                     |
    And I create a new client config:
      | name                      |
      | TC.120812-client-config-2 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120812-client-config-2
    And I click tab Preferences
    Then cascade option should not exist for encryption key
    And I cancel update client configuration
    And I delete configuration TC.120812-client-config-2
    And I stop masquerading
    # MozyCorp
    When I act as partner by:
      | name      | including sub-partners |
      | MozyCorp  | no                     |
    And I create a new client config:
      | name                      |
      | TC.120812-client-config-3 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120812-client-config-3
    And I click tab Preferences
    Then cascade option should not exist for encryption key
    And I cancel update client configuration
    And I delete configuration TC.120812-client-config-3
    And I stop masquerading
    # MozyHome
    When I act as partner by:
      | name      | including sub-partners |
      | MozyHome  | no                     |
    And I create a new client config:
      | name                      |
      | TC.120812-client-config-4 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120812-client-config-4
    And I click tab Preferences
    Then cascade option should not exist for encryption key
    And I cancel update client configuration
    And I delete configuration TC.120812-client-config-4
    And I stop masquerading
    # MozyPro
    When I act as partner by:
      | name      | including sub-partners |
      | MozyPro   | no                     |
    And I create a new client config:
      | name                      |
      | TC.120812-client-config-5 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120812-client-config-5
    And I click tab Preferences
    Then cascade option should not exist for encryption key
    And I cancel update client configuration
    And I delete configuration TC.120812-client-config-5
    And I stop masquerading

  @TC.120813 @tasks_p1 @client_configuration @bus
  Scenario: 120813 Validate Cascade Option on Non-BDS Partners
    # MozyPro sub_partner
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |
      |   1    |  500 GB    |       yes     |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.120813-client-config-1 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120813-client-config-1
    And I click tab Preferences
    Then cascade option should exist for encryption key
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    # MozyEnterprise sub_partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      |   12   | 200   | 12 TB       | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.120813-client-config-2 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120813-client-config-2
    And I click tab Preferences
    Then cascade option should exist for encryption key
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    # Fortress sub partner
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                  |
      | TC.120813-Fortress Sub Partner|
    Then New partner should be created
    And I change root role to Enterprise Special
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.120813-client-config-3 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120813-client-config-3
    And I click tab Preferences
    Then cascade option should exist for encryption key
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.120813-Fortress Sub Partner
    And I stop masquerading
    # Reseller sub_partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 1      | Silver        | 500            | yes         |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.120813-client-config-4 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.120813-client-config-4
    And I click tab Preferences
    Then cascade option should exist for encryption key
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123911 @tasks_p1 @integration @client_configuration @bus
  Scenario: 123911 Windows setting 'Access files online' link and 'Restore files" button'
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  net terms |
      |   12   |  4 TB      |   yes         |     yes    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I create a new client config:
      | name                      | web restores |
      | TC.123911-client-config   | all uncheck  |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123911-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | web restores   |
      | all unchecked  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123909 @tasks_p1 @integration @client_configuration @bus
  Scenario: 123909 Windows setting 'Access files online' link and 'Restore files" button'
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  storage add on |
      |   1    |  8 TB      |   yes         |  28             |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I create a new client config:
      | name                      | web restores |
      | TC.123909-client-config   | setting      |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123909-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | web restores |
      | setting      |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131224 @tasks_p1 @client_configuration @bus
  Scenario: 131224 Verify roles with client config option can prevent backup with wrong encryption,MozyPro
    # root role Bundle Pro Partner Root
    When I add a new MozyPro partner:
      | company name              | period |  base plan | server plan |  net terms | root role                |
      | TC.131224_mozypro_partner |   24   |  24 TB     | yes         |  yes       | Bundle Pro Partner Root  |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.131224-client-config   |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    And I stop masquerading
    # root role SMB Bundle Limited
    And I search partner by TC.131224_mozypro_partner
    And I view partner details by TC.131224_mozypro_partner
    When I change root role to SMB Bundle Limited
    And I act as partner by:
      | name                      |
      | TC.131224_mozypro_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    And I stop masquerading
    # root role Small Business Root
    And I search partner by TC.131224_mozypro_partner
    And I view partner details by TC.131224_mozypro_partner
    When I change root role to Small Business Root
    And I act as partner by:
      | name                      |
      | TC.131224_mozypro_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    And I navigate to Client Configuration section from bus admin console page
    Then prevent backup with wrong encryption type is enabled
    And I stop masquerading
    # root role Business Root
    And I search partner by TC.131224_mozypro_partner
    And I view partner details by TC.131224_mozypro_partner
    When I change root role to Business Root
    And I act as partner by:
      | name                      |
      | TC.131224_mozypro_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    # sub admin
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | newrole | Partner admin | Business Root |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                  |
      | TC.131224_mozypro_sub_partner |
    And New partner should be created
    And I act as newly created partner account
    Then I will see the Client Configuration link from navigation links
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.131224_mozypro_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.131224_mozypro_partner

  @TC.131224 @tasks_p1 @client_configuration @bus
  Scenario: 131224 Verify roles with client config option can prevent backup with wrong encryption,MozyEnterprise
    # root role Velocity Root
    When I add a new MozyEnterprise partner:
      | company name                     | period | users | server plan | net terms  | root role     |
      | TC.131224_mozyenterprise_partner |   12   | 129   | 28 TB       | yes        | Velocity Root |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.131224-client-config   |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    And I stop masquerading
    # root role Enterprise Limited
    And I search partner by TC.131224_mozyenterprise_partner
    And I view partner details by TC.131224_mozyenterprise_partner
    When I change root role to Enterprise Limited
    And I act as partner by:
      | name                             |
      | TC.131224_mozyenterprise_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    # sub admin
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent             |
      | subrole | Partner admin | Enterprise Limited |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                         |
      | TC.131224_mozyenterprise_sub_partner |
    And New partner should be created
    And I act as newly created partner account
    Then I will see the Client Configuration link from navigation links
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.131224_mozyenterprise_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.131224_mozyenterprise_partner

  @TC.131224 @tasks_p1 @client_configuration @bus
  Scenario: 131224 Verify roles with client config option can prevent backup with wrong encryption,Reseller
    When I add a new Reseller partner:
      | company name               | period | reseller type | reseller quota | net terms |
      | TC.131224_reseller_partner | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    And I act as newly created partner account
    # sub admin
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                   |
      | TC.131224_reseller_sub_partner |
    And New partner should be created
    And I act as newly created partner account
    Then I will see the Client Configuration link from navigation links
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.131224_reseller_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.131224_reseller_partner

  @TC.131224 @tasks_p1 @client_configuration @bus
  Scenario: 131224 Verify roles with client config option can prevent backup with wrong encryption,OEM partner
    # root role OEM Root Trial
    When I add a new OEM partner:
      | company name          | Root role      | Company Type     |
      | TC.131224_OEM_partner | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      |
      | TC.131224-client-config   |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131224-client-config
    And I click tab Preferences
    Then prevent backup with wrong encryption type is enabled
    # sub admin
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent         |
      | subrole | Partner admin | OEM Root Trial |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name                | Pricing Plan | Admin Name |
      | TC.131224_OEM_sub_partner   | subplan      | subadmin   |
    And New partner should be created
    And I act as newly created partner account
    Then I will see the Client Configuration link from navigation links
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.131224_OEM_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.131224_OEM_partner

  @TC.131225 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131225 Prevent backup option enforced for new client config
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  net terms |
      |   1    |  50 GB     |       yes     |     yes    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Bundled user group:
      | name            | storage_type |
      | TC.131225-group | Shared       |
    Then TC.131225-group user group should be created
    And I create a new client config:
      | name                      | user group      | ckey                                 | enforce encryption type |
      | TC.131225-client-config   | TC.131225-group | http://gradyplayer.com/myckey.ckey   | all uncheck             |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131225-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | ckey                               | enforce encryption type |
      | http://gradyplayer.com/myckey.ckey | all unchecked           |
    And I cancel update client configuration
    And I edit client config:
      | name                      | enforce encryption type | default key      |
      | TC.131225-client-config   | setting                 | only default key |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131225-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | enforce encryption type | default key      |
      | setting                 | only default key |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122759 @tasks_p1 @integration @client_configuration @bus
  Scenario: 122759 Set private/custom encryption key for new partner
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |
      |   12   |  250 GB    |       yes     |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I add a new Bundled user group:
      | name            | storage_type |
      | TC.122759-group | Shared       |
    Then TC.122759-group user group should be created
    And I create a new client config:
      | name                      | user group       | private key         |
      | TC.122759-client-config   | TC.122759-group  | only private key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.122759-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         |
      | only private key    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131210 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131210 Prevent backup if encryption type does not match for new partner, MozyEnterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      |   36   | 112   | 24 TB       | 39            |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | default key         |
      | TC.131210-client-config    | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I cancel update client configuration
    When I edit client config:
      | name                      | private key       | enforce encryption type |
      | TC.131210-client-config   | only private key  | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         | enforce encryption type |
      | only private key    | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131210 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131210 Prevent backup if encryption type does not match for new partner, MozyPro
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   24   |  24 TB     | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      | default key         |
      | TC.131210-client-config   | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I cancel update client configuration
    When I edit client config:
      | name                      | private key       | enforce encryption type |
      | TC.131210-client-config   | only private key  | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         | enforce encryption type |
      | only private key    | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131210 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131210 Prevent backup if encryption type does not match for new partner, Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Gold          | 500            | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      | default key         |
      | TC.131210-client-config   | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I cancel update client configuration
    When I edit client config:
      | name                      | private key       | enforce encryption type |
      | TC.131210-client-config   | only private key  | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         | enforce encryption type |
      | only private key    | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131210 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131210 Prevent backup if encryption type does not match for new partner, OEM
    When I add a new OEM partner:
      | Root role         | Company Type     |
      | OEM Partner Admin | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                      | default key         |
      | TC.131210-client-config   | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I cancel update client configuration
    When I edit client config:
      | name                      | private key       | enforce encryption type |
      | TC.131210-client-config   | only private key  | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131210-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         | enforce encryption type |
      | only private key    | setting                 |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @TC.131204 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131204 Set private/custom encryption key for existing partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      |   36   | 112   | 24 TB       | 39            |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name            | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC.131204-group | Shared               | 11              | Shared              | 10             |
    Then TC.131204-group user group should be created
    And I create a new client config:
      | name                      | user group       | private key         |
      | TC.131204-client-config   | TC.131204-group  | only private key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131204-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | private key         |
      | only private key    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131182 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131182 Set ckey encryption key for new partner, MozyEnterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      |   24   | 100   | 20 TB       | 9             |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | ckey                               | enforce encryption type |
      | TC.131182-client-config    | http://gradyplayer.com/myckey.ckey | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131182-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | ckey                               | enforce encryption type |
      | http://gradyplayer.com/myckey.ckey | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131182 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131182 Set ckey encryption key for new partner, MozyPro
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  storage add on |
      | 24     |  1 TB      |       yes     |     15          |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I create a new client config:
      | name                       | ckey                               | enforce encryption type |
      | TC.131182-client-config    | http://gradyplayer.com/myckey.ckey | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131182-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | ckey                               | enforce encryption type |
      | http://gradyplayer.com/myckey.ckey | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131182 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131182 Set ckey encryption key for new partner, Reseller
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |  net terms |
      |   12   |  Platinum       | 500            |      yes     |      yes   |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | ckey                               | enforce encryption type |
      | TC.131182-client-config    | http://gradyplayer.com/myckey.ckey | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131182-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | ckey                               | enforce encryption type |
      | http://gradyplayer.com/myckey.ckey | setting                 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131182 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131182 Set ckey encryption key for new partner, OEM
    When I add a new OEM partner:
      | Company Type     | Root role         |
      | Service Provider | OEM Partner Admin |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | ckey                               | enforce encryption type |
      | TC.131182-client-config    | http://gradyplayer.com/myckey.ckey | setting                 |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131182-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | ckey                               | enforce encryption type |
      | http://gradyplayer.com/myckey.ckey | setting                 |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @TC.131190 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131190 Set default encryption key for existing partner, MozyEnterprise
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | net terms |
      |   12   | 98    | 8 TB        | 19            | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | default key         |
      | TC.131190-client-config    | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131190-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131190 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131190 Set default encryption key for existing partner, MozyPro
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan |
      | 24     | 10 GB     | yes       | yes         |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | default key         |
      | TC.131190-client-config    | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131190-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131190 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131190 Set default encryption key for existing partner, Reseller
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |
      |   1    |  Gold           | 998            |      yes     |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | default key         |
      | TC.131190-client-config    | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131190-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131190 @tasks_p1 @integration @client_configuration @bus
  Scenario: 131190 Set default encryption key for existing partner, OEM
    When I add a new OEM partner:
      | Company Type     |
      | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I create a new client config:
      | name                       | default key         |
      | TC.131190-client-config    | only default key    |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.131190-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | default key         |
      | only default key    |
    And I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name


