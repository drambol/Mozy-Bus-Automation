Feature: These are the test we run for every deploy

  These are the tests we run for deploys. The correspond to testlink cases
  -Things to do before you can run
  -- $ export BUS_ENV=<environment>
  - If you are running in prod
  -- $ ruby set_credit_card.rb


  Additional Things to check:
  - Delete partner if in prod
  - Prod 50 - Check Download Manifests
  - Prod 29 - Check the support link
  - Prod 89 - Activate in Email

  @bus_smoke @TC.20 @TC.21 @TC.73 @TC.22 @TC.23 @TC.24 @TC.177 @TC.25 @TC.26 @TC.27 @TC.32 @TC.36 @TC.49 @TC.197
  Scenario: BUS - US MozyPro smoke test
    #Prod 20
    Given I log in bus admin console as administrator
    #Prod 21
    When I add a new MozyPro partner:
      | period | base plan | coupon                | net terms | server plan | root role               |
      | 24     | 10 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    #Prod 73, 197
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    But I activate the partner
    #Prod 22
    When I act as newly created partner account
    #Prod 23
    And I add a new Bundled user group:
      | name   | storage_type |
      | alpha | Shared       |
    Then alpha user group should be created
    When I add a new Bundled user group:
      | name   | storage_type |
      | omega | Shared       |
    Then omega user group should be created
    #Prod 36 - Delete user group
    When I add a new Bundled user group:
      | name   | storage_type |
      | gamma | Shared       |
    Then gamma user group should be created
    When I delete user group details by name: gamma
    Then gamma user group should be deleted
    #Prod 24 - Create a user
    And I add new user(s):
      | name | user_group | storage_type |  devices |
      | user | alpha      | Desktop      |  1       |
    Then 1 new user should be created
    #Prod 31 - Run report
    Given I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
      | Name                | Type            | Recipients                      | Schedule | Actions |
      | billing detail test | Billing Detail  | <%=@partner.admin_info.email%>  | Daily    | Run     |
#TODO download report
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list
    #Prod 177 - Update a username & password
    Given  I navigate to Search / List Users section from bus admin console page
    When I view user details by @user_email
    Then edit user details:
      | email                  |
      | <%=create_user_email%> |
    Then I update the user password to Test1234
    #Prod 26
    But I reassign the user to user group omega
    Then the user's user group should be omega
    #Prod 32
    Given I delete user
    #Prod 25 - client config
    When I create a new client config:
      | name                 | type   |
      | deploy_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    #Prod 27 - Open all Resources headers
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page
    #Prod 49 - Delete partner and test that they are in Pending Delete
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_smoke @TC.89
  Scenario: BUS - US MozyPro smoke test
    #Prod 89 Activate partner in email
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | net terms | coupon                |
      | 1      | yes       | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And the partner has activated the admin account with default password
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    When I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @bus_smoke @TC.179 @TC.198
  Scenario: BUS - US MozyEnterprise smoke test
    #Prod 198
    Given I log in bus admin console as administrator
    When I add a new MozyEnterprise partner:
      | period | users  | coupon                |  server plan | net terms |
      | 36     | 10     | <%=QA_ENV['coupon']%> |  100 GB      | yes       |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Server       | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view the user's product keys
    Then Number of Server activated keys should be 0
    And Number of Server unactivated keys should be 3
    #Prod 179
    When I click Send Keys button
    And I search emails by keywords:
      | content                |
      | <%=@unactivated_keys%> |
    Then I should see 1 email(s)
    When I stop masquerading
    Then I delete partner and verify pending delete

  @bus_smoke @TC.199
  Scenario: BUS - US MozyFortress smoke test
    #Prod 199
    Given I log in bus admin console as administrator
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                       |
      | Fortress Internal Test Sub Partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by Fortress Internal Test Sub Partner
    And I view partner details by Fortress Internal Test Sub Partner
    Then partner account details should be:
      | Account Type | Sales Origin | Sales Channel |
      | N/A (change) | Sales        | N/A (change)  |
    And I delete partner account

  @bus_smoke @TC.121283
  Scenario: BUS - US MozyOEM smoke test
    #Prod 199
    Given I log in bus admin console as administrator
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    Then I stop masquerading as sub partner
    And I search and delete partner account by newly created subpartner company name

  @bus_smoke @TC.178 @TC.180 @TC.377
  Scenario: BUS - US MozyPro smoke test data shuttle
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | coupon                |
      | 12     | 50 GB     | MozyPro      | yes         | yes       | <%=QA_ENV['coupon']%> |
    And New partner should be created
    #Prod 180.1
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 30            | 1       |
    And I search user by:
      | keywords |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    #Prod 180.2
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 1    | Unlimited | Unlimited |
    #Prod 377 order data shuttle
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    #Prod 178
    When I navigate to Search / List Machines section from bus admin console page
    Then Search list machines section is opened
    And I search and delete partner account by newly created partner company name

  @emea_smoke @TC.74 @TC.75 @TC.76 @TC.90 @TC.77 @TC.78 @TC.79 @TC.80 @TC.81 @TC.82 @TC.85 @TC.86 @TC.87
  Scenario: BUS - EMEA smoke test
    #Prod 74 log into bus
    Given I log in bus admin console as administrator
    #Prod 75 create a new partner (no vat number)
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | net terms | country | coupon                |
      | 1      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Small Business Root
    #Prod 76 verify partner in ARIA
    And I get partner aria id
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    #Prod 90 active partner in email
    And the partner has activated the admin account with default password
    Then I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    #Prod 78 create a user group
    When I add a new Bundled user group:
      | name         | storage_type |
      | group-test-1 | Shared       |
    Then group-test-1 user group should be created
    When I add a new Bundled user group:
      | name         | storage_type |
      | group-test-2 | Shared       |
    Then group-test-2 user group should be created
    #Prod 86 delete test user group
    When I delete user group details by name: group-test-2
    #Prod 79 Create a user
    And I add new user(s):
      | name   | user_group   | storage_type  | storage_limit | devices |
      | test-2 | group-test-1 | Desktop       | 10            | 1       |
    Then 1 new user should be created
    #Prod 80 create a client config
    When I create a new client config:
      | name                | user group   | type   |
      | smoke_client_config | group-test-1 | Server |
    Then client configuration section message should be Your configuration was saved.
    #Prod 81 move the user from one user group to a different user group
    Given  I navigate to Search / List Users section from bus admin console page
    When I view user details by @user_email
    And I reassign the user to user group (default user group)
    Then the user's user group should be (default user group)
    #Prod-85 delete test user
    And I delete user
    #Prod 82 open all resource header to open all of the modules
    Given I navigate to Resource Summary section from bus admin console page
    When I navigate to User Group List section from bus admin console page
    Then I navigate to Change Plan section from bus admin console page
    And  I navigate to Billing Information section from bus admin console page
    But  I navigate to Billing History section from bus admin console page
    Then I navigate to Change Payment Information section from bus admin console page
    When I navigate to Download * Client section from bus admin console page
    #Prod 84 - Run report
    Given I build a new report:
      | type            | name                |
      | Billing Detail  | billing detail test |
    Then Billing detail report should be created
    And Scheduled report list should be:
      | Name                | Type            | Recipients                      | Schedule | Actions |
      | billing detail test | Billing Detail  | <%=@partner.admin_info.email%>  | Daily    | Run     |
    When I delete billing detail test scheduled report
    Then I should see No results found in scheduled reports list

  @emea_smoke @TC.379
  Scenario: Bus - EMEA smoke test data shuttle
    Given I log in bus admin console as administrator
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | net terms | country | coupon                |
      | 12     | 10 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Small Business Root
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    #Prod 379 order data shuttle
    When I order data shuttle for newly created partner company name
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 10    |
    Then Data shuttle order should be created
    #Prod 380 - update data shuttle
    #Prod check the support link
    #Prod 87 - delete test partner and validate they are in Pending Delete state
