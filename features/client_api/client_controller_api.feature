Feature: Client Controller API

  Background:
    Given I log in bus admin console as administrator

  @TC.20948 @bus @client_api @smoke @tasks_p1 @ROR_smoke @qa12
  Scenario: 20948 machine_get_info when 0<m.used_quota<u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20948.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20948.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_20948 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20949 @bus @client_api @tasks_p1
  Scenario: 20949 machine_get_info when m1.used_quota+m2.used_quota=0
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20949.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20949.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_20949 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20949 | <%=@new_users.first.email%> | Desktop      |
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20950 @bus @client_api @tasks_p1
  Scenario: 20950 machine_get_info when m1.used_quota+m2.used_quota<u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20950.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20950.User
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20950 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20950 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 60 |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused | machine_hash                     |
      | 104857600  | 64424509440    | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20951 @bus @client_api @tasks_p1
  Scenario: 20951 machine_get_info when m1.used_quota+m2.used_quota=u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20951.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.20951.User
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20951 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20951 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 70 |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused | machine_hash                     |
      | 104857600  | 75161927680    | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20952 @bus @client_api @tasks_p1
  Scenario: 20952 machine_get_info when m1.used_quota+m2.used_quota>u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Gold          | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20952.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20952 | <%=@new_users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@new_clients.last.license_key%>
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20952 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I update <%=@clients[1].machine_id%> used quota to 80 GB
    And I get the machine info should be
      | quota     | user_spaceused | machine_hash                     |
      | 104857600 | 85899345920    | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20953 @bus @client_api @tasks_p1
  Scenario: 20953 machine_get_info when m1.share_withmax+m2.used_quota<u.total_quota&&m1.used_quota<m1.shared_with_max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20953.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20953 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                  | machine_type |
      | Machine2_20953 | <%=@new_users.first.email%> | Desktop     |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 20 |
    Then tds returns successful upload
    And I refresh User Details section
    When I set machine max for Machine1_20953
    And I input the machine max value for Machine1_20953 to 40 GB
    And I save machine max for Machine1_20953
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                     |
      | 41943040 | 0              | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20954 @bus @client_api @tasks_p1
  Scenario: 20954 machine_get_info when m1.used_quota+m2.used_quota+m3.used_quota<u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Platinum      | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20954.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20954 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20954 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine3_20954 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 60 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[2].machine_id%> | 5  |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused | machine_hash                     |
      | 104857600  | 69793218560    | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20955 @bus @client_api @tasks_p1
  Scenario: 20955 machine_get_info when m.used_quota>u.total_quota
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Platinum      | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20955.User | (default user group) | Desktop      | 100           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20955 | <%=@new_users.first.email%> | Desktop      |
    And I update <%=@clients[0].machine_id%> used quota to 110 GB
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20956 @bus @client_api @tasks_p1
  Scenario: 20956 machine_get_info when m1.share_withmax+m2.used_quota<u.total_quota&&m1.used_quota=m1.shared_with_max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20956.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20956 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20956 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 40 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 20 |
    Then tds returns successful upload
    And I refresh User Details section
    When I set machine max for Machine1_20956
    And I input the machine max value for Machine1_20956 to 40 GB
    And I save machine max for Machine1_20956
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                     |
      | 41943040 | 0              | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20957 @bus @client_api @tasks_p1
  Scenario: 20957 machine_get_info when m1.share_withmax+m2.used_quota<u.total_quota&&m1.used_quota>m1.shared_with_max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20957.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20957 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20957 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 50 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 20 |
    Then tds returns successful upload
    And I refresh User Details section
    When I set machine max for Machine1_20957
    And I input the machine max value for Machine1_20957 to 40 GB
    And I save machine max for Machine1_20957
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                     |
      | 41943040 | 0              | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.20958 @bus @client_api @tasks_p1
  Scenario: 20958 machine_get_info when m1.share_withmax+m2.used_quota>u.total_quota&&m1.used_quota>m1.shared_with_max
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Platinum      | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.20958.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_20958 | <%=@new_users.first.email%> | Desktop      |
    And I get the machine id for client 0 by license key <%=@license_key%>
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_20958 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[1].machine_id%> | 65 |
    Then tds returns successful upload
    And I refresh User Details section
    When I set machine max for Machine1_20958
    And I input the machine max value for Machine1_20958 to 40 GB
    And I save machine max for Machine1_20958
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                     |
      | 36700160 | 0              | <%=@clients.first.machine_hash%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21004 @bus @client_api @tasks_p1
  Scenario: 21004 machine_get_info when 0<m.used_quota<u.total_quota by machineid
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Silver        | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21004.User | (default user group) | Desktop      | 100           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_21004 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB |
      | <%=@clients[0].machine_id%> | 30 |
    Then tds returns successful upload
    And I get the machine info should be
      | quota      | user_spaceused |
      | 104857600  | 0              |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21005 @bus @client_api @tasks_p1
  Scenario: 21005 machine_get_info when 0<m.used_quota<u.total_quota by machine_id and other user's authentication
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Platinum      | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.21005.User1 | (default user group) | Desktop      | 50           | 3       |
      | TC.21005.User2 | (default user group) | Desktop      | 50           | 3       |
    Then 2 new user should be created
    And I search user by:
      | keywords                |
      | <%=@new_users[0].name%> |
    And I view user details by TC.21005.User1
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords                |
      | <%=@new_users[1].name%> |
    And I view user details by TC.21005.User2
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_21005 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB | user_email               |
      | <%=@clients[0].machine_id%> | 30 | <%=@new_users[0].email%> |
    Then tds returns successful upload
    And I get the machine info with other user authentication should be
    """
        ERROR: PRO USER MACHINE CREATION INVALID
      """
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21049 @bus @client_api @tasks_p1
  Scenario: 21049 machine_get_info when 2 users in the user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    And New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.21049.User1 | (default user group) | Desktop      | 40            | 3       |
      | TC.21049.User2 | (default user group) | Desktop      | 40            | 3       |
    Then 2 new user should be created
    And I search user by:
      | keywords                |
      | <%=@new_users[0].name%> |
    And I view user details by TC.21049.User1
    And I update the user password to default password
    Then I close user details section
    And I search user by:
      | keywords                |
      | <%=@new_users[1].name%> |
    And I view user details by TC.21049.User2
    And I update the user password to default password
    When I remove user max for TC.21049.User2
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine1_21049 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine2_21049 | <%=@new_users.first.email%> | Desktop      |
    Then I use keyless activation to activate devices
      | machine_name   | user_name                | machine_type |
      | Machine1_User2 | <%=@new_users[1].email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                  | GB | user_email               |
      | <%=@clients[0].machine_id%> | 10 | <%=@new_users[0].email%> |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB | user_email               |
      | <%=@clients[1].machine_id%> | 20 | <%=@new_users[0].email%> |
    Then tds returns successful upload
    And I upload data to device by batch
      | machine_id                  | GB | user_email               |
      | <%=@clients[2].machine_id%> | 50 | <%=@new_users[1].email%> |
    Then tds returns successful upload
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                  | user_email                  |
      | 41943040 | 21474836480    | <%=@clients[0].machine_hash%> | <%=@new_users.first.email%> |
    And I get the machine info should be
      | quota    | user_spaceused | machine_hash                  |
      | 73400320 | 0              | <%=@clients[2].machine_hash%> |
    And I update <%=@clients.first.machine_id%> used quota to 0 GB
    And I update <%=@clients[2].machine_id%> used quota to 70 GB
    Then I get the machine info should be
      | quota    | user_spaceused | machine_hash                     | user_email                  |
      | 31457280 | 21474836480    | <%=@clients.first.machine_hash%> | <%=@new_users.first.email%> |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21212 @bus @client_api @smoke @tasks_p1 @ROR_smoke
  Scenario: 21212 [Itemized]GET /client/user/resources API for desktop user with stash and machines
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21212.User | (default user group) | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 0      | 0      | 3       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21212 | Desktop      |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21212 | Desktop      |
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 2      | 0      | 3       |
    And I enable stash without send email in user details section
    Then Get client user resources api result should be
      | stash | backup | server | desktop |
      | 1     | 2      | 0      | 3       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21213 @bus @client_api @tasks_p1
  Scenario: 21213 [Itemized]GET /client/user/resources API for server user with deleted machine
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 36     | 1     | 250 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21213.User | (default user group) | Server       | 50            | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21213 | Server       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21213 | Server       |
    And I refresh User Details section
    When I delete device by name: Machine2_21213
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 1      | 2      | 0       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21214 @bus @client_api @tasks_p1
  Scenario: 21214 [Itemized]GET /client/user/resources API with invalid authorization
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 2     | 500 GB      |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21214.User | (default user group) | Desktop      | 50            | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21214 | Desktop      |
    And I enable stash without send email in user details section
    And Get client user resources api with invalid authorization result should like
    """
       ERROR: invalid token
    """
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21215 @bus @client_api @tasks_p1
  Scenario: 21215 [Bundled]GET /client/user/resources API for desktop user with stash and machines
    When I add a new MozyPro partner:
      | period | base plan | root role               |
      | 24     | 1 TB      | Bundle Pro Partner Root |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | user_group           |
      | TC.21215.User | Desktop      | 50            | 5       | (default user group) |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And Get client user resources api result should be
      | stash | backup | desktop |
      | 0     | 0      | 5       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21215 | Desktop      |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21215 | Desktop      |
    And Get client user resources api result should be
      | stash | backup | desktop |
      | 0     | 2      | 5       |
    And I enable stash without send email in user details section
    And Get client user resources api result should be
      | stash | backup | desktop |
      | 1     | 2      | 5       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21216 @bus @client_api @tasks_p1
  Scenario: 21216 [Bundled]GET /client/user/resources API for server user with deleted machine
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 10 GB     | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.21216.User | Server       | 10            | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21216 | Server       |
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine2_21216 | Server       |
    And I refresh User Details section
    When I delete device by name: Machine2_21216
    And Get client user resources api result should be
      | stash | backup | server | desktop |
      | 0     | 1      | 2      | 0       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

  @TC.21217 @bus @client_api @tasks_p1
  Scenario: 21217 [Bunlded]GET /client/user/resources API with invalid authorization
    When I add a new MozyPro partner:
      | period | base plan | country        | net terms |
      | 12     | 500 GB    | United Kingdom | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices | enable_stash |
      | TC.21217.User | Desktop      | 50            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name   | machine_type |
      | @user_email | Machine1_21217 | Desktop      |
    And Get client user resources api with invalid authorization result should like
    """
       ERROR: invalid token
    """
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name

