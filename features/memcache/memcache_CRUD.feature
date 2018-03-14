Feature: memcache CRUD test with blue/green env switch

  Background:
    Given I switch hosts to blue


  @memcache
  Scenario: Direct write data through DB
    #blue create
    When I add a account attribute key:
      | key                    | data type | component  | internal |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test1 | Yes      |
    And I navigate to List Account Attribute Keys section from bus admin console page
    And I get account attribute key MEMCACHE_SHOULD_DELETE info:
      | key                    | data type | component  | aria field | action |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test1 |            | Delete |
    #green read
    And I switch hosts to green
    When I search account attribute key MEMCACHE_SHOULD_DELETE
    And I get account attribute key MEMCACHE_SHOULD_DELETE info from edit account attribute key section:
      | key                    | data type | component  | aria field |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test1 |            |
    #direct update through DB
    And I change account attribute key MEMCACHE_SHOULD_DELETE component to comp_test2 directly through db
    #blue read
    And I switch hosts to blue
    When I search account attribute key MEMCACHE_SHOULD_DELETE
    And I get account attribute key MEMCACHE_SHOULD_DELETE info from edit account attribute key section:
      | key                    | data type | component  | aria field |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test2 |            |
    #green read
    And I switch hosts to green
    When I search account attribute key MEMCACHE_SHOULD_DELETE
    And I get account attribute key MEMCACHE_SHOULD_DELETE info from edit account attribute key section:
      | key                    | data type | component  | aria field |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test2 |            |
    #direct delete through DB
    And I delete the account attribute key MEMCACHE_SHOULD_DELETE directly through db
    #blue read
    And I switch hosts to blue
    And I navigate to List Account Attribute Keys section from bus admin console page
    Then I should not find account attribute key MEMCACHE_SHOULD_DELETE
    #green read
    And I switch hosts to green
    And I navigate to List Account Attribute Keys section from bus admin console page
    Then I should not find account attribute key MEMCACHE_SHOULD_DELETE


  @memcache
  Scenario: AccountAttributeKey CRUD
    #blue create
    When I add a account attribute key:
      | key                    | data type | component  | internal |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test1 | Yes      |
    #green read
    And I switch hosts to green
    When I search account attribute key MEMCACHE_SHOULD_DELETE
    And I get account attribute key MEMCACHE_SHOULD_DELETE info:
      | key                    | data type | component  | aria field | action |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test1 |            | Delete |
    #green update
    Then I edit account attribute key:
      | component  |
      | comp_test2 |
    And I wait for 3 seconds
    #blue read
    And I switch hosts to blue
    When I search account attribute key MEMCACHE_SHOULD_DELETE
    And I get account attribute key MEMCACHE_SHOULD_DELETE info:
      | key                    | data type | component  | aria field | action |
      | MEMCACHE_SHOULD_DELETE | string    | comp_test2 |            | Delete |
    #blue delete
    And I delete account attribute key MEMCACHE_SHOULD_DELETE
    #green read
    And I switch hosts to green
    And I navigate to List Account Attribute Keys section from bus admin console page
    Then I should not find account attribute key MEMCACHE_SHOULD_DELETE


  @memcache
  Scenario: Admin CRU
    #blue create
    When I add a new MozyPro partner:
      | period | base plan  | server plan | admin name      |
      | 12     | 500 GB     | yes         | Fancisco Pardue |
    Then New partner should be created
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then admin name in admin details should be Fancisco Pardue
    #green update
    And edit admin details:
      | Name:             |
      | Fancisco1 Pardue1 |
    Then edit sub admin personal information success message should display
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then admin name in admin details should be Fancisco1 Pardue1
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: AdminPasswordPolicy CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 3                     | Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then admin password policy should be same as user password policy
    #green update
    And I edit admin passowrd policy:
      | admin user same policy | min length | admin policy type | min character classes | character classes                             |
      | No                     | 6          | custom            | 3                     | Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then admin password policy should not be same as user password policy
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: AuthLockout CR
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    And I activate new partner admin with default password
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name        | User Group          |
      | AuthLockout |(default user group) |
    When I view the admin details of AuthLockout
    When I active admin in admin details default password
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | max failures per username | failure period per username | lockout duration per username |
      | custom           | 2                         | 30                          | 30                            |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password wrong_password
    Then Login page error message should be Incorrect email or password.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password wrong_password
    Then Login page error message should be Incorrect email or password.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password wrong_password
    Then Login page error message should be There have been too many failed login attempts on your account. Please try logging in again later.
    #green read
    And I switch hosts to green without login bus
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password wrong_password
    Then Login page error message should be There have been too many failed login attempts on your account. Please try logging in again later.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ClientConfig CRUD
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I create a new client config:
      | name                        | type    | automatic max load | automatic min idle | automatic interval |
      | TC1339-server-client-config | Server  | 10                 | 10                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC1339-server-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load | automatic min idle | automatic interval |
      | 10                 | 10                 | 7:lock             |
    And I navigate to Resource Summary section from bus admin console page
    #green update
    And I edit client config:
      | name                        | type    | automatic max load | automatic min idle | automatic interval |
      | TC1339-server-client-config | Server  | 15                 | 15                 | 7:lock             |
    Then client configuration section message should be Your configuration was saved.
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to Client Configuration section from bus admin console page
    And I should see client config TC1339-server-client-config
    And I edit the new created config TC1339-server-client-config
    And I click tab Scheduling
    Then scheduling settings should be:
      | automatic max load | automatic min idle | automatic interval |
      | 15                 | 15                 | 7:lock             |
    #blue delete
    And I cancel update client configuration
    And I delete configuration TC1339-server-client-config
    Then client configuration section message should be Client config deleted successfully
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Client Configuration section from bus admin console page
    And I should not see client config TC1339-server-client-config
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ClientConfigsUserGroup CRUD
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC123901-group-1 | Shared       | yes            |
    Then TC123901-group-1 user group should be created
    When I create a new client config:
      | name                            | type   | user group       |
      | TC123901-server-client-config-1 | Server | TC123901-group-1 |
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                            | type    |
      | TC123901-server-client-config-2 | Server  |
    Then client configuration section message should be Your configuration was saved.
    #green read
    And I switch hosts to green and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be TC123901-server-client-config-1
    #green update
    And I change server client configuration to TC123901-server-client-config-2
    #blue read
    And I switch hosts to green and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be TC123901-server-client-config-2
    #blue delete
    And I change server client configuration to None (Inherited defaults from MozyPro)
    #green read
    And I switch hosts to green and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And I view user group details by clicking group name: TC123901-group-1
    And I open Client Configuration tab under user group details
    Then Server client configuration should be None (Inherited defaults from MozyPro)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ClientUpgradeRule CRUD
    #blue create
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name              | platform | arch    | version number | notes                                              |
      | LinuxTestVersion  | linux    | deb-32  | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version LinuxTestVersion if it exists
    Then I add a new upgrade rule:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     |
    #green read
    And I switch hosts to green
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    Then Upgrade Rule for version LinuxTestVersion should be:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     |
    #green update
    When I update Upgrade Rule for version LinuxTestVersion as below:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.2     | 0.0.0.3     |
    And I wait for 15 seconds
    #blue read
    And I switch hosts to blue
    When I act as partner by:
      | email                                 | including sub-partners |
      | redacted-4164@notarealdomain.mozy.com | yes                    |
    And I navigate to Upgrade Rules section from bus admin console page
    Then Upgrade Rule for version LinuxTestVersion should be:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.2     | 0.0.0.3     |
    #blue delete
    And I delete rule for version LinuxTestVersion if it exists
    #green read
    And I switch hosts to green
    When I act as partner by:
      | email                                 | including sub-partners |
      | redacted-4164@notarealdomain.mozy.com | yes                    |
    And I navigate to Upgrade Rules section from bus admin console page
    Then there is no rule for LinuxTestVersion in Upgrade Rules


  @memcache
  Scenario: ClientVersion CRUD
    #pre clean up
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
    #blue create
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name              | platform | arch    | version number | notes                                              |
      | LinuxTestVersion  | linux    | deb-32  | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully
    #green read
    And I switch hosts to green
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | linux    | true          |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status   |
      | 10.10.10.10 | linux     | LinuxTestVersion | disabled |
    #green update
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    #blue read
    And I switch hosts to blue
    When I navigate to List Versions section from bus admin console page
    When I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status  |
      | 10.10.10.10 | linux     | LinuxTestVersion | enabled |
    #blue delete
    And I delete version 10.10.10.10 if it exists
    #green read
    And I switch hosts to green
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I should not see version 10.10.10.10 in version list


  @memcache
  Scenario: Domain CRUD
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 001 | Shared       |
    Then Group 001 user group should be created
    When I add a new Bundled user group:
      | name     | storage_type |
      | Group001 | Shared       |
    Then Group001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 001 Group | Shared       |
    Then 001 Group user group should be created
    And I add a new Bundled user group:
      | name          | storage_type |
      | Subgroup 0001 | Shared       |
    Then Subgroup 0001 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | Group 100 | Shared       |
    Then Group 100 user group should be created
    When I add a new Bundled user group:
      | name      | storage_type |
      | 100 Group | Shared       |
    Then 100 Group user group should be created
    And I add a new Bundled user group:
      | name      | storage_type |
      | Group 0001 | Shared      |
    Then Group 0001 user group should be created
    When I add a new Bundled user group:
      | name        | storage_type |
      | Subgroup001 | Shared       |
    Then Subgroup001 user group should be created
    When I add a new Bundled user group:
      | name         | storage_type |
      | Subgroup 001 | Shared       |
    Then Subgroup 001 user group should be created
    And I add a new Bundled user group:
      | name       | storage_type |
      | Group 0011 | Shared       |
    Then Group 0011 user group should be created
    When I add a new Bundled user group:
      | name       | storage_type |
      | Group00101 | Shared       |
    Then Group00101 user group should be created
    When I add a new Bundled user group:
      | name    | storage_type |
      | Foo 001 | Shared       |
    Then Foo 001 user group should be created
    When I navigate to Network Domains section from bus admin console page
    And I add a network domain
      | Domain GUID   | Alias   | OU   | User Group |
      | auto_generate | domain1 | unit | 001 Group  |
    Then user groups search result should be
      | user groups                                                                                          |
      | 001 Group;Group 0001;Group 001;Group 0011;Group001;Group00101;Subgroup 0001;Subgroup001;Subgroup 001 |
    Then Add network domain message will be Domain added successfully.
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    And Existing network domain record should be
      | Alias   | Domain                     | OU   | User Group |
      | domain1 | <%=@network_domain.guid%>  | unit | 001 Group  |
    #green update
    And I click edit network domain button
    And I update a network domain
      | Domain GUID   | Alias   | OU    | User Group |
      | auto_generate | domain2 | unit1 | 100 Group  |
    Then user groups search result should be
      | user groups         |
      | Group 100;100 Group |
    Then Edit network domain message will be Domain updated successfully.
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    And Existing network domain record should be
      | Alias   | Domain                    | OU    | User Group |
      | domain2 | <%=@network_domain.guid%> | unit1 | 100 Group  |
    #blue delete
    And I remove the network domain record
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner
    When I navigate to Network Domains section from bus admin console page
    Then I can not find network domain record
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: EffectiveProPartnerSetting CRUD
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    Then I verify partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | t     | false  |
    #green update
    When I add partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | f     | false  |
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    Then I verify partner settings
      | Name                           | Value | Locked |
      | mobile_access_enabled_external | f     | false  |
    #blue delete
    And I delete partner settings
      | Name                           |
      | mobile_access_enabled_external |
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    Then I should not see partner setting mobile_access_enabled_external
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: MachineDetail CRUD
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | MachineDetailUser | (default user group) | Server       | 40            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by MachineDetailUser
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name    | user_name                   | machine_type |
      | MachineDetail   | <%=@new_users.first.email%> | Server       |
    And I search machine by:
      | machine_name  |
      | MachineDetail |
    And I view machine details for MachineDetail
    And I add machine external id
    #green read
    And I switch hosts to green and act as newly created partner
    And I search machine by:
      | machine_name  |
      | MachineDetail |
    And I view machine details for MachineDetail
    Then Machine search results should be:
      | External ID               | Machine       |
      | <%=@machine_external_id%> | MachineDetail |
    #green update
    And I add machine external id
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I search machine by:
      | machine_name  |
      | MachineDetail |
    And I view machine details for MachineDetail
    Then Machine search results should be:
      | External ID               | Machine       |
      | <%=@machine_external_id%> | MachineDetail |
    #blue delete
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by MachineDetailUser
    And I delete device by name: MachineDetail
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords          |
      | MachineDetailUser |
    And I view user details by MachineDetailUser
    Then Device MachineDetail should not show
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: MachineStoragePool CRUD
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan |
      | 12     | Silver        | 200            | yes         |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name | storage_type | server_support | enable_stash |
      | Test | Shared       | yes            | yes          |
    And I add new user(s):
      | name  | user_group | storage_type | storage_limit | devices | enable_stash |
      | User1 | Test       | Desktop      | 50            | 3       | no           |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota |
      | Machine1     | Desktop      | 0 GB       |
    When I refresh User Details section
    Then I set machine max for Machine1
    And I input the machine max value for Machine1 to 20 GB
    And I save machine max for Machine1
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit |
      | Machine1 | 0 / 20 GB      | 20 GB Edit Remove    |
    #green update
    Then I edit machine max for Machine1
    And I input the machine max value for Machine1 to 30 GB
    And I save machine max for Machine1
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    Then device table in user details should be:
      | Device   | Used/Available | Device Storage Limit |
      | Machine1 | 0 / 30 GB      | 30 GB Edit Remove    |
    #blue delete
    And I delete device by name: Machine1
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords   |
      | User1      |
    And I view user details by User1
    Then Device Machine1 should not show
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: MachinesEncryptionType CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.122435.User1 | (default user group) | Server       | 40            | 1       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.122435.User1
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name    | user_name                   | machine_type |
      | Machine1_122435 | <%=@new_users.first.email%> | Server       |
    And I update newly created machine encryption value to Default
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search machine by:
      | machine_name    |
      | Machine1_122435 |
    And I view machine details for Machine1_122435
    Then machine details should be:
      | Encryption: |
      | Default     |
    #green update
    And I update newly created machine encryption value to Custom
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search machine by:
      | machine_name    |
      | Machine1_122435 |
    And I view machine details for Machine1_122435
    Then machine details should be:
      | Encryption:    |
      | Custom         |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: MozyProKey CRU
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name        | user_group           | storage_type | storage_limit | devices |
      | TC.822.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | TC.822.User |
    And I view user details by TC.822.User
    And edit user details:
      | email                      |
      | mozyprokey-crud-1@test.com |
    Then edit user email success message to mozyprokey-crud-1@test.com should be displayed
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                       | Name        | User Group            | Sync     | Storage          |
      | mozyprokey-crud-1@test.com | TC.822.User | (default user group)  | Disabled | 100 GB (Limited) |
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords    |
      | TC.822.User |
    Then User search results should be:
      | User                       | Name        | User Group            | Sync     | Storage          |
      | mozyprokey-crud-1@test.com | TC.822.User | (default user group)  | Disabled | 100 GB (Limited) |
    #green update
    And I view user details by TC.822.User
    And edit user details:
      | email                      |
      | mozyprokey-crud-2@test.com |
    Then edit user email success message to mozyprokey-crud-2@test.com should be displayed
    When I navigate to Search / List Users section from bus admin console page
    Then User search results should be:
      | User                       | Name        | User Group            | Sync     | Storage          |
      | mozyprokey-crud-2@test.com | TC.822.User | (default user group)  | Disabled | 100 GB (Limited) |
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I search user by:
      | keywords    |
      | TC.822.User |
    Then User search results should be:
      | User                       | Name        | User Group            | Sync     | Storage          |
      | mozyprokey-crud-2@test.com | TC.822.User | (default user group)  | Disabled | 100 GB (Limited) |
    And I view user details by mozyprokey-crud-2@test.com
    And I delete user
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: PasswordPolicy CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 3                     | Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 6          | 3                     | 0             | 1               | f                        | f                    |
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 6          | 3                     | 0             | 1               | f                        | f                    |
    #green update
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 7          | 2                     | Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 7          | 2                     | 0             | 1               | f                        | f                    |
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 7          | 2                     | 0             | 1               | f                        | f                    |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ProPartner CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And partner's root role should be FedID role
    #green update
    And I change root role to Enterprise
    And partner's root role should be Enterprise
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And partner's root role should be Enterprise
    And I search and delete partner account by newly created partner company name

  @memcache
  Scenario: ProPartnerAccountAttribute CRU
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 100 GB    | yes       |
    And New partner should be created
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:            |    -1    |
      | Default Sync Storage:  |          |
    #green update
    And I enabled server in partner account details
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    Then Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:            |    -1    |
      | Default Sync Storage:  |          |
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ProPartnerContact CRU
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | net terms | country       | zip   | address      | phone      |
      | 12     | 4 TB      | yes       | United States | 12345 | test-address | 1234567890 |
    Then New partner should be created
    And I activate new partner admin with default password
    #green read
    And I switch hosts to green
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I expand contact info from partner details section
    Then Partner contact information should be:
      | Contact Address: | Contact Country:    | Contact ZIP/Postal Code: | Phone:     |
      | test-address     | United States       | 12345                    | 1234567890 |
    #green update
    When I change the partner contact information to:
      | Contact Address: | Contact Country:    | Contact ZIP/Postal Code: | Phone:     |
      | test-address-2   | China               | 54321                    | 9876543210 |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact Country:    | Contact ZIP/Postal Code: | Phone:     |
      | test-address-2   | China               | 54321                    | 9876543210 |
    #blue read
    And I switch hosts to blue
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I expand contact info from partner details section
    Then Partner contact information should be:
      | Contact Address: | Contact Country:    | Contact ZIP/Postal Code: | Phone:     |
      | test-address-2   | China               | 54321                    | 9876543210 |
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: ProPartnerStoragePool CRU
    #blue create
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 12     | 100 GB    | yes         | yes       |
    And New partner should be created
    And I get partner aria id
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Current plan table should be:
      |Resource     |   Current Plan |  Used    |   Change |    Updated Plan|
      |Total Storage|   100 GB       |  0 GB    |   0 GB   |    100 GB      |
    #green update
    And I change MozyPro account plan to:
      | base plan |
      | 250 GB    |
    Then Change plan charge summary should be:
      | Description                    | Amount   |
      | Credit for remainder of 100 GB | -$439.89 |
      | Charge for new 250 GB          | $729.89  |
      |                                |          |
      | Total amount to be charged     | $290.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 250 GB    | Yes         |
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Current plan table should be:
      |Resource     |   Current Plan |  Used    |   Change |    Updated Plan|
      |Total Storage|   250 GB       |  0 GB    |   0 GB   |    250 GB      |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: Role CRUD
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name          | Type          |
      | role_memcache | Partner admin |
    Then Add admin role message will be New role created
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to List Roles section from bus admin console page
    Then I can find role role_memcache in list roles section
    #green update
    And I click role role_memcache in list roles section to view details
    And I edit a role
      | Name            |
      | role_memcache2  |
    Then Edit admin role message will be Changes saved successfully
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to List Roles section from bus admin console page
    Then I can find role role_memcache2 in list roles section
    #blue delete
    And I delete role role_memcache2
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to List Roles section from bus admin console page
    Then I can not find role role_memcache2 in list roles section
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: SeedDevice CR
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 2     | 250 GB      |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  20           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 2.5" 1TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    #green read
    And I switch hosts to green and act as newly created partner
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: Subscription CRU
    #blue create
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the billing summary looks like:
      | Description                           | Price | Quantity | Amount |
      | MozyHome 50 GB (1 computer) - Monthly | $5.99 | 1        | $5.99  |
      | Total Charge                          |       |          | $5.99  |
    Then the user is successfully added.
    #green read
    And I switch hosts to green
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    And I get mozyhome user expire time
    #green update
    And I extend mozyhome user expire time by 1 years
    #blue read
    And I switch hosts to blue
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then The mozyhome user expire time should be 1 years later than last time
    And I delete user


  @memcache
  Scenario: User CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 10    |
    Then New partner should be created
    When I act as newly created partner
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.818_UG1 | Shared               | 1               |
    Then Itemized user group should be created
    And I add a new Itemized user group:
      | name       | desktop_storage_type | desktop_devices |
      | TC.818_UG2 | Shared               | 2               |
    Then Itemized user group should be created
    And I add new user(s):
      | name         | user_group | storage_type | storage_limit | devices |
      | TC.818_User1 | TC.818_UG1 | Desktop      | 10            | 1       |
    #green read
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords    |
      | @user_email |
    Then User search results should be:
      | User        | Name         |
      | @user_email | TC.818_User1 |
    #green update
    And I view user details by newly created user email
    And edit user details:
      | name         |
      | TC.818_User2 |
    Then the user's user name should be TC.818_User2 (change)
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords    |
      | @user_email |
    Then User search results should be:
      | User        | Name         |
      | @user_email | TC.818_User2 |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @memcache
  Scenario: UserAccountAttribute CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | company name             |
      | 12     | 8     | 100 GB      | yes       | [Itemized]Edit Device    |
    Then New partner should be created
    And I enable stash for the partner
    When I get the partner_id
    And I act as newly created partner account
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices | enable_stash |
      | Test | Shared               | 5               | Shared              | 10             | yes          |
    And I add new user(s):
      | name          | user_group | storage_type | storage_limit | devices | enable_stash |
      | TC.21096.User | Test       | Desktop      | 50            | 3       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    And I update the user password to default password
    And I add machines for the user and update its used quota
      | machine_name | machine_type | used_quota | machine_codename |
      | Machine1     | Desktop      | 0 GB       | MozyEnterprise   |
      | Machine2     | Desktop      | 0 GB       | MozyEnterprise   |
    #green read
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then users' device status should be:
      | Used | Available | storage_type |
      |  2   | 1         | Desktop      |
    #green update
    When I edit user device quota to 4
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by newly created user email
    Then users' device status should be:
      | Used | Available | storage_type |
      | 2    | 2         | Desktop      |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @memcache
  Scenario: UserGroup CRUD
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20894 UG | Shared       |
    Then TC.20894 UG user group should be created
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to User Group List section from bus admin console page
    Then User groups list should have TC.20894 UG user group
    Then User groups list should not have TC.20894 UG Edit user group
    #green update
    When I edit TC.20894 UG Bundled user group:
      | name             | storage_type |
      | TC.20894 UG Edit | Shared       |
    Then TC.20894 UG Edit user group should be updated
    #blue read
    And I switch hosts to blue and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    Then User groups list should have TC.20894 UG Edit user group
    Then User groups list should not have TC.20894 UG user group
    #blue delete
    When I delete user group details by name: TC.20894 UG Edit
    #green read
    And I switch hosts to blue and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    Then User groups list should not have TC.20894 UG Edit user group
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @memcache
  Scenario: UserGroupAccountAttribute CRU
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms |
      | 12     | Silver        | 100            | yes         | yes       |
    Then New partner should be created
    And I enable stash for the partner
    And I act as newly created partner
    And I add a new Bundled user group:
      | name        | storage_type |
      | TC.20894 UG | Shared       |
    Then TC.20894 UG user group should be created
    When I view user group details by clicking group name: TC.20894 UG
    And I enable stash for the user group
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to User Group List section from bus admin console page
    When I view user group details by clicking group name: TC.20894 UG
    Then User group details should be:
      | Enable Sync:  |
      | Yes (change)  |
    #green update
    And I disable stash for the user group
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to User Group List section from bus admin console page
    When I view user group details by clicking group name: TC.20894 UG
    Then User group details should be:
      | Enable Sync:  |
      | No (change)   |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: UserGroupStoragePool CRU
    #blue create
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | net terms | company name            |
      | 12     | Silver        | 100            | yes         | yes       | [Bundled] Add New Group |
    Then New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    When I add a new Bundled user group:
      | name             | storage_type | limited_quota |
      | TC.20716-Limited | Limited      | 50            |
    Then TC.20716-Limited user group should be created
    #green read
    And I switch hosts to green and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should be:
      | Group Name           | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group) | true  | true   | Shared       |            | 0            | 0            |
      | TC.20716-Limited     | false | false  | Limited      | 50 GB      | 0            | 0            |
    #green update
    And I edit TC.20716-Limited Bundled user group:
      | name             | storage_type | limited_quota |
      | TC.20716-Limited | Limited      | 20            |
    #blue read
    And I switch hosts to blue and act as newly created partner
    When I navigate to User Group List section from bus admin console page
    And Bundled user groups table should be:
      | Group Name           | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group) | true  | true   | Shared       |            | 0            | 0            |
      | TC.20716-Limited     | false | false  | Limited      | 20 GB      | 0            | 0            |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: UserPasswordPolicy CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 3                     | Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    #green read
    And I switch hosts to green and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then admin password policy should be same as user password policy
    #green update
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 8          | 2                     | Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I navigate to Password Policy section from bus admin console page
    Then user password policy should be:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 8          | 2                     | Lowercase letters,Numbers,Special characters  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


  @memcache
  Scenario: UserStoragePool CRU
    #blue create
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 100 GB      |
    Then New partner should be created
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.20993_user | (default user group) | Desktop      | 90            | 1       | yes          |
    Then 1 new user should be created
    #green read
    And I switch hosts to green and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I check user storage limit is 90 GB
    #green update
    And I edit user storage limit to 10 GB
    #blue read
    And I switch hosts to blue and act as newly created partner
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    Then I check user storage limit is 10 GB
    And I stop masquerading
    And I search and delete partner account by newly created partner company name