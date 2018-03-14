Feature: view edit machine details


  Background:
    Given I log in bus admin console as administrator


  ###############################################################################

  # view backup restores history

  ###############################################################################

  @TC.122155 @bus @machines_sync @tasks_p2
  Scenario: 122155 : View Backup History
    When I check that linux client service is available
    And I upload change linux client env script to remote machine
    And I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    And New partner should be created
    And I activate new partner admin with default password
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.122155.User  | Server       | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    When I backup file using linux client for user newly created user email password default password
    And I backup files again with no new files added
    And I cancel backup when I add a large file
    And I wait for 5 seconds
    And I refresh User Details section
    And I view machine BUS-Auto-03-Zoe details from user details section
    Then Backups table will display as:
      | Start Time     | Type                | Duration | Result            | Files | Size | Files Encoded | Size Encoded | Files Transferred | Size Transferred |
      | today          | Manual Backup       | any      | CancelError0      | any   | any  | any           | any          | 0                 | any              |
      | today          | Manual Backup       | any      | Success           | 1     | 20   | 0             | 0            | 0                 | 0                |
      | today          | Manual Backup       | any      | Success           | 1     | 20   | 1             | 74 bytes     | 1                 | 74 bytes         |
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.122156 @bus @machines_sync @tasks_p2
  Scenario: 122156:View Restore History
    When I check that linux client service is available
    And I upload change linux client env script to remote machine
    And I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    And New partner should be created
    And I activate new partner admin with default password
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.122156.User  | Server       | 10            | 3       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I backup file using linux client for user newly created user email password default password
    And I wait for 5 seconds
    # Perform a media restore for this machine
    When I refresh User Details section
    And I click restore Files folder icon for device BUS-Auto-03-Zoe
    And I navigate to new window
    Then I have login freyja from BUS
    When I select the Devices tab
    And I choose one device
    And I click restore all files in the detail panel
    And I fill out the restore all files wizard
      | restore_name     | restore_type |
      | archive_all_file | media        |
    When I select options menu
    And I select event history
    Then this restore is In Progress
    When I close new window
    And I wait for 50 seconds
    And I view machine BUS-Auto-03-Zoe details from user details section
    Then Restores table first record will display as:
      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads                       |
      | <%=@restore.restore_id%> | today               | today              | 4 / 4           | 1 DVD | Retrieved files; preparing to burn DVDs. |
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


  ###############################################################################

  # view edit details

  ###############################################################################

  @TC.21056 @bus @machines_sync @tasks_p2
  Scenario: 21056 Verify retention period for MozyPro direct Germany
    When I add a new MozyPro partner:
      | period | base plan | country  | create under     | net terms |
      | 12     | 8 TB      | Germany  | MozyPro Germany  | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.21056.User | Desktop      | 50            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21056 | <%=@new_users.first.email%> | Desktop      |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch | codename | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | windows  | x86  | mozypro  | 0.0.0.2 |
    Then retention period should be 60 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21057 @bus @machines_sync @tasks_p2
  Scenario: 21057 Verify retention period for MozyHome Germany
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country | billing country | cc number        |
      | 12     | 125 GB    | Germany | Deutschland     | 4188181111111112 |
    Then the user is successfully added.
    And I log in bus admin console as administrator
    And I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    When I view Sync details
    And I get machine details info
    When I got client config for the user machine:
      | user_name           | machine                     | platform | arch | codename | version |
      | <%=@mh_user_email%> | <%=@machine_info['Hash:']%> | windows  | x86  | mozy     | 0.0.0.2 |
    Then retention period should be 30 days
    And I delete user

  @TC.21058 @bus @machines_sync @tasks_p2
  Scenario: 21058 Verify retention period for MozyPro Germany reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under     | net terms |
      | 12     | Silver        | 100            | MozyPro Germany  | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21058.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21058.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21058 | <%=@new_users.first.email%> | Desktop      |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch | codename | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | windows  | x86  | mozypro  | 0.0.0.2 |
    Then retention period should be 90 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21059 @bus @machines_sync @tasks_p2 @ROR_smoke
  Scenario: 21059 Verify retention period for MozyEnterprise UK
    When I add a new MozyEnterprise partner:
      | period | users | server plan | country        | net terms |
      | 12     | 10    | 250 GB      | United Kingdom | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.21059.User | (default user group) | Server       | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name   | user_name                   | machine_type |
      | Machine1_21059 | <%=@new_users.first.email%> | Server       |
    When I got client config for the user machine:
      | user_name                   | machine                   | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@client.machine_hash%> | linux    | deb-32 | MozyEnterprise | 0.0.0.2 |
    Then retention period should be 90 days
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  ###############################################################################

  # Machines: Device Storage Limit

  ###############################################################################

  @TC.22475 @bus @machines_sync @tasks_p2
  Scenario: 22475 Backup a desktop for DPS customers
    When I navigate to Add New Partner section from bus admin console page
    And I select company type as MozyEnterprise DPS
    Then storage based plan shows while user based plan and server add-on not show
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | address           | city      | state abbrev | zip   | phone          | sales channel |
      | 12     | 100       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.22475.User | (default user group) | Desktop      | 1024          | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                            |
      | 0 Used / 1 TB Available | Desktop: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name   | machine_type |
      | Machine1_22475 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    And I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_22475 | 1 GB / 1023 GB | Set                  | N/A         |        |
    When I set machine max for Machine1_22475
    And I input the machine max value for Machine1_22475 to 1025 GB
    And The range of machine max for Machine1_22475 by tooltips should be:
      | Min | Max  |
      | 0   | 1024 |
    And I save machine max for Machine1_22475
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 1025 GB, out of resources.
      """
    When I set machine max for Machine1_22475
    And I input the machine max value for Machine1_22475 to -1 GB
    And I save machine max for Machine1_22475
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_22475
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 1 GB | 100 TB    | 100 TB   | 1    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view machine Machine1_22475 details from user details section
    When I delete device by name: Machine1_22475
    Then the popup message when delete device is Do you want to delete Machine1_22475?
    When I refresh User Details section
    Then Device Machine1_22475 should not show
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.22476 @bus @machines_sync @tasks_p2
  Scenario: 22476 Backup a server for DPS customers
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       | sales channel |
      | 12     | 100       | United States | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.22476.User | (default user group) | Server       | 1024          | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                           |
      | 0 Used / 1 TB Available | Server: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name   | machine_type |
      | Machine1_22476 | Server       |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    And I refresh User Details section
    Then device table in user details should be:
      | Device         | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_22476 | 1 GB / 1023 GB | Set                  | N/A         |        |
    When I set machine max for Machine1_22476
    And I input the machine max value for Machine1_22476 to 1025 GB
    And The range of machine max for Machine1_22476 by tooltips should be:
      | Min | Max  |
      | 0   | 1024 |
    And I save machine max for Machine1_22476
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 1025 GB, out of resources.
      """
    When I set machine max for Machine1_22476
    And I input the machine max value for Machine1_22476 to -1 GB
    And I save machine max for Machine1_22476
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_22476
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 1 GB | 100 TB    | 100 TB   | 1    | Unlimited | Unlimited |
    When I act as newly created partner account
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I view machine Machine1_22476 details from user details section
    When I delete device by name: Machine1_22476
    Then the popup message when delete device is Do you want to delete Machine1_22476?
    When I refresh User Details section
    Then Device Machine1_22476 should not show
    And I stop masquerading
    When I navigate to Search / List Partners section from bus admin console page
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 TB    | 100 TB   | 0    | Unlimited | Unlimited |
    And I delete partner account

  @TC.119220 @bus @machines_sync @tasks_p2
  Scenario: 119220:Back up desktop server stash with storage more than device storage limit for DPS customer
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | sales channel |
      | 12     | 1         | Velocity      |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 1 TB      | 1 TB     | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.119220.User1 | (default user group) | Desktop      | 1             | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                            |
      | 0 Used / 1 GB Available | Desktop: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name    | machine_type |
      | Machine1_119220 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
      # error about failing to upload a big file returne dif upload a 2 GB file
      # workaround: update machine quota in db with 1GB, then upload a small real file
      #| <%=@new_clients.first.machine_id%> | 2  |
    And I upload data to device by batch
      | machine_id                         | GB    | upload_file |
      | <%=@new_clients.first.machine_id%> | 0.005 | true        |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine1_119220 | 1 GB / 0       | Set                  | < a minute ago |        |
      #| Machine1_119220 | 0 / 1 GB       | Set                  | N/A         |        |
    When I set machine max for Machine1_119220
    And I input the machine max value for Machine1_119220 to 2 GB
    And The range of machine max for Machine1_119220 by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Machine1_119220
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 2 GB, out of resources.
      """
    When I set machine max for Machine1_119220
    And I input the machine max value for Machine1_119220 to -1 GB
    And I save machine max for Machine1_119220
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine1_119220
    And stash device table in user details should be:
      | Sync Container | Used/Available | Device Storage Limit | Last Update      | Action |
      | Sync           | 0 / 0          | Set                  | N/A              |        |
      #| Sync           | 0 / 1 GB       | Set                  | N/A              |        |
    When I view Sync details
    And I get machine details info
    When I upload data to device by batch
      | machine_id                | GB    | upload_file |
      | <%=@machine_info['ID:']%> | 0.005 | true        |
      #| machine_id                | GB |
      #| <%=@machine_info['ID:']%> | 2  |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    When I set machine max for Sync
    And I input the machine max value for Sync to 2 GB
    And The range of machine max for Sync by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Sync
    Then set max message should be:
      """
      The Sync Storage limit cannot be more than what is available for this user.
      """
    When I set machine max for Sync
    And I input the machine max value for Sync to -1 GB
    And I save machine max for Sync
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Sync
    And I close User Details section
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.119220.User2 | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And user resources details rows should be:
      | Storage                 | Devices                           |
      | 0 Used / 1 GB Available | Server: 0 Used / 2 Available Edit |
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name    | machine_type |
      | Machine2_119220 | Server       |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
      #| <%=@new_clients.first.machine_id%> | 2  |
    And I upload data to device by batch
      | machine_id                         | GB    | upload_file |
      | <%=@new_clients.first.machine_id%> | 0.005 | true        |
    Then tds return message should be:
      """
      Account or container quota has been exceeded
      """
    And I refresh User Details section
    Then device table in user details should be:
      | Device          | Used/Available | Device Storage Limit | Last Update | Action |
      | Machine2_119220 | 1 GB / 0       | Set                  | < a minute ago |        |
      #| Machine2_119220 | 0 / 1 GB       | Set                  | N/A         |        |
    When I set machine max for Machine2_119220
    And I input the machine max value for Machine2_119220 to 2 GB
    And The range of machine max for Machine2_119220 by tooltips should be:
      | Min | Max |
      | 0   | 1   |
    And I save machine max for Machine2_119220
    Then set max message should be:
      """
      Machine Storage limit cannot be set to 2 GB, out of resources.
      """
    When I set machine max for Machine2_119220
    And I input the machine max value for Machine2_119220 to -1 GB
    And I save machine max for Machine2_119220
    Then set max alert should be:
      """
      Please enter a positive integer
      """
    And I cancel machine max for Machine2_119220
    And I stop masquerading
    Then I search and delete partner account by newly created partner company name

    # using fixed data Linux GA Test
  @TC.122433 @TC.122434 @bus @machines_sync @tasks_p2
  Scenario: 122433 122434:Linux machines displayed correctly in the machine list view
    When I search machine by:
      | machine_name                  |
      | ubuntu10-x86.bif.mozycorp.com |
    Then Machine search results should be:
      | External ID | Machine                       | User                 | User Group           | Data Center | Storage Used |
      |             | ubuntu10-x86.bif.mozycorp.com | chris.qa6.1@mozy.com | (default user group) | qa6         | 107 bytes    |
    And I view machine details for ubuntu10-x86.bif.mozycorp.com
    Then machine details should be:
      | ID:      | External ID: | MTM/SN: | Retry PEW:  | Status:             | Suspended:              | Owner:               | Space Used: | Encryption: | Client Version:                 | Product Key:                  | Hash:                                    | Data Center: |
      | 81309996 | (change)     | (edit)  | No (toggle) | No expiration (add) | Not Suspended (suspend) | chris.qa6.1@mozy.com | 107 bytes   | Default     | MozyPro linux deb-64 1.0.5.4698 | QZA5CBD6DXZ3AGCD622D (Server) | a58b657962424b20e7229cec2f87afb320c4ca0d | qa6          |
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name mozybus+catherine+0401@gmail.com and password default password
    When I search machine by:
      | machine_name                  |
      | ubuntu10-x86.bif.mozycorp.com |
    Then Machine search results should be:
      | Machine                       | User                 | User Group           | Data Center | Storage Used |
      | ubuntu10-x86.bif.mozycorp.com | chris.qa6.1@mozy.com | (default user group) | qa6         | 107 bytes    |
    And I view machine details for ubuntu10-x86.bif.mozycorp.com
    Then machine details should be:
      | ID:      | MTM/SN: | Retry PEW:  | Status:             | Suspended:              | Owner:               | Space Used: | Encryption: | Client Version:                 | Product Key:                  | Hash:                                    | Data Center: |
      | 81309996 | (edit)  | No (toggle) | No expiration (add) | Not Suspended (suspend) | chris.qa6.1@mozy.com | 107 bytes   | Default     | MozyPro linux deb-64 1.0.5.4698 | QZA5CBD6DXZ3AGCD622D (Server) | a58b657962424b20e7229cec2f87afb320c4ca0d | qa6          |

  @TC.122435 @bus @machines_sync @tasks_p2
  Scenario: 122435: Linux client version updates correctly in the machine's details after replace
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    And I get 2 enabled linux version for deb-64
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | TC.122435.User1 | (default user group) | Server       | 40            | 1       |
      | TC.122435.User2 | (default user group) | Server       | 40            | 1       |
    Then 2 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by TC.122435.User1
    And I update the user password to default password
    Then I close user details section
    And I view user details by TC.122435.User2
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name    | user_name                   | machine_type |
      | Machine1_122435 | <%=@new_users.first.email%> | Server       |
    And I update newly created machine encryption value to Default
    And I got client config for the user machine:
      | user_name                | machine                   | platform | arch   | codename       | version       |
      | <%=@new_users[0].email%> | <%=@client.machine_hash%> | linux    | deb-64 | MozyEnterprise | <%=@version%> |
    Then I use keyless activation to activate devices
      | machine_name    | user_name                | machine_type |
      | Machine2_122435 | <%=@new_users[1].email%> | Server       |
    And I update newly created machine encryption value to Default
    And I got client config for the user machine:
      | user_name                | machine                   | platform | arch   | codename       | version        |
      | <%=@new_users[1].email%> | <%=@client.machine_hash%> | linux    | deb-64 | MozyEnterprise | <%=@version2%> |
    And I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Machine2_122435
    And I click on the replace machine link
    And I select Machine1_122435 to be replaced
    And I navigate to Search / List Machines section from bus admin console page
    Then replace machine message should be Replace operation was successful.
    And I search machine by:
      | machine_name    |
      | Machine1_122435 |
    Then I should not search out machine record
    When I search machine by:
      | machine_name    |
      | Machine2_122435 |
    And I view machine details for Machine2_122435
    Then machine details should be:
      | Client Version:              |
      | MozyEnterprise @version_name |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122537 @TC.122540 @bus @machines_sync @tasks_p2
  Scenario: 122537 122540:Mac Sync machines and client version displayed correctly in the machine details and list view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac-sync | false         |
    And I get 1 enabled mac-sync version
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    And New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name            | storage_type | storage_limit | devices | enable_stash |
      | TC.122537.User  | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    And I get machine details info
    And I got client config for the user machine:
      | user_name                   | machine    | platform | arch   | codename  | version       |
      | <%=@new_users.first.email%> | plop000001 | mac      | x86_64 | mozypro   | <%=@version%> |
    And I upload data to device by batch
      | machine_id                | user_agent                        |
      | <%=@machine_info['ID:']%> | <%='msync_mac_client/'+@version%> |
    And I refresh Machine Details section
    Then machine details should be:
      | ID:                       | Owner:                      | Space Used: | Encryption: | Client Version:       |
      | <%=@machine_info['ID:']%> | <%=@new_users.first.email%> | 1 GB        | Default     | MozyPro @version_name |
    When I search machine by:
      | machine_name |
      | Sync         |
    Then Machine search results should be:
      | Machine  | User                        | User Group           | Storage Used |
      | Sync     | <%=@new_users.first.email%> | (default user group) | 1 GB         |
    And I add machine external id
    When I log in bus admin console as administrator
    And I search machine by:
      | keywords                  |
      | <%=@machine_external_id%> |
    Then Machine search results should be:
      | External ID                  | Machine  | User                        | User Group           | Storage Used | Created |
      | <%=@machine_external_id%>    | Sync     | <%=@new_users.first.email%> | (default user group) | 1 GB         | today   |
    And I view machine details for Sync
    Then machine details should be:
      | ID:                       | External ID:                           | Owner:                      | Space Used: | Encryption: | Client Version:       | Hash:                         |
      | <%=@machine_info['ID:']%> | <%=@machine_external_id+' (change)'%>  | <%=@new_users.first.email%> | 1 GB        | Default     | MozyPro @version_name | <%='user_'+@user_id+'_sync'%> |
    And I search and delete partner account by newly created partner company name


  @TC.122455 @TC.122456 @bus @machines_sync @tasks_p2
  Scenario: 122455 122456:Windows Sync machines and client version displayed correctly in the machine details and list view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    And I get 1 enabled win-sync version
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    And New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name            | storage_type | storage_limit | devices | enable_stash |
      | TC.122455.User  | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I get the user id
    And I update the user password to default password
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Sync
    And I get machine details info
    And I got client config for the user machine:
      | user_name                   | machine    | platform | arch   | codename  | version       |
      | <%=@new_users.first.email%> | plop000001 | win      | x86_64 | mozypro   | <%=@version%> |
    And I upload data to device by batch
      | machine_id                | user_agent                            |
      | <%=@machine_info['ID:']%> | <%='msync_windows_client/'+@version%> |
    And I refresh Machine Details section
    Then machine details should be:
      | ID:                       | Owner:                      | Space Used: | Encryption: | Client Version:       |
      | <%=@machine_info['ID:']%> | <%=@new_users.first.email%> | 1 GB        | Default     | MozyPro @version_name |
    When I search machine by:
      | machine_name |
      | Sync         |
    Then Machine search results should be:
      | Machine  | User                        | User Group           | Storage Used |
      | Sync     | <%=@new_users.first.email%> | (default user group) | 1 GB         |
    And I add machine external id
    When I log in bus admin console as administrator
    And I search machine by:
      | keywords                  |
      | <%=@machine_external_id%> |
    Then Machine search results should be:
      | External ID                  | Machine  | User                        | User Group           | Storage Used | Created |
      | <%=@machine_external_id%>    | Sync     | <%=@new_users.first.email%> | (default user group) | 1 GB         | today   |
    And I view machine details for Sync
    Then machine details should be:
      | ID:                       | External ID:                           | Owner:                      | Space Used: | Encryption: | Client Version:       | Hash:                         |
      | <%=@machine_info['ID:']%> | <%=@machine_external_id+' (change)'%>  | <%=@new_users.first.email%> | 1 GB        | Default     | MozyPro @version_name | <%='user_'+@user_id+'_sync'%> |

    And I search and delete partner account by newly created partner company name

  @TC.122569 @bus @machines_sync @tasks_p2
  Scenario: 122569: Sync client version update from unknown to correct one in the machines details
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    And I get 1 enabled win-sync version
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 8 TB      | yes       |
    Then New partner should be created
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | name           | storage_type | storage_limit | devices | enable_stash |
      | TC.122569.User | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    When I view Sync details
    Then machine details should be:
      | Client Version: |
      | unknown         |
    And I got client config for the user machine:
      | user_name                   | machine    | platform | codename | version       | arch   |
      | <%=@new_users.first.email%> | plop000001 | win      | mozypro  | <%=@version%> | x86_64 |
    When I refresh Machine Details section
    Then machine details should be:
      | Client Version:       |
      | MozyPro @version_name |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  #######################################################################

  ## VMBU View Search

  #######################################################################
#  @TC.124098 @bus @machines_sync @tasks_p2 @qa12 @env_dependent
#  Scenario: 124098 VMBU container details
#    When I act as partner by:
#      | name                       |
#      | VMBU Enterprise_DONOT_EDIT |
#    When I search machine by:
#      | machine_name              |
#      | sh-loki4.mozy.lab.emc.com |
#    And I view machine details for sh-loki4.mozy.lab.emc.com
#    Then machine details should be:
#      | ID:     | External ID: | Suspended:              | Owner:                   | Space Used: | Last Update: | Encryption: | Client Version: | Product Key:                  | Data Center: |
#      | 7692271 | (change)     | Not Suspended (suspend) | vmbu_freyja_ent1@emc.com | 214.1 GB    | N/A          | Default     | unknown         | 4GAXEDSARDTGZZTWSZXF (Server) | q12a         |
#    And Virtual Machines table will display as:
#      | Name              | Type      | Created At | Backed Up | View Logfile |
#      | VMBU_windows_200  | vmware-vm | 08/07/15   | N/A       | View Logfile |
#      | VMBU_CentOS_test  | vmware-vm | 08/07/15   | N/A       | View Logfile |
#      | VMBU_ubuntu       | vmware-vm | 08/07/15   | N/A       | View Logfile |
#      | VMBU_windows_test | vmware-vm | 08/07/15   | N/A       | View Logfile |

#  # fixed data, partner: vmbu_emea
#  @TC.125782 @bus @machines_sync @tasks_p2 @qa12 @env_dependent
#  Scenario: 125782:VMBU restore status is reflected correctly in BUS
#    When I search user by:
#      | keywords               |
#      | jaden+vmbutest@emc.com |
#    And I view user details by jaden+vmbutest@emc.com
#    When I click restore VMs folder icon for device sh-loki4.mozy.lab.emc.com
#    And I navigate to new window
#    Then I have login freyja from BUS
#    When I select the vSphere VMs tab
#    And I click VM container sh-loki4.mozy.lab.emc.com
#    And I right click VM VMBU_windows_test to add to restore queue and then restore
#    And I fill out the restore VMs wizard
#      | restore_name | restore_type |
#      | archive_vm   | media        |
#    When I select options menu
#    And I select event history
#    Then this restore is In Progress
#    When I close new window
#    And I view machine sh-loki4.mozy.lab.emc.com details from user details section
#    Then Restores table first record will display as:
#      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size   | Status / Downloads                                                |
#      | <%=@restore.restore_id%> | today               | —                  | 0 / 4           | 0 DVDs | Restore building - you will receive an email when it is complete. |
#    When I wait for 850 seconds
#    And I refresh Machine Details section
#    Then Restores table first record will display as:
#      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads                       |
#      | <%=@restore.restore_id%> | today               | today              | 4 / 4           | 1 DVD | Retrieved files; preparing to burn DVDs. |
#    When I set the restore dvd burned at time
#    And I refresh Machine Details section
#    Then Restores table first record will display as:
#      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads |
#      | <%=@restore.restore_id%> | today               | today              | 4 / 4           | 1 DVD | Burned on today    |
#    When I set the restore dvd mailed at time
#    And I refresh Machine Details section
#    Then Restores table first record will display as:
#      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads |
#      | <%=@restore.restore_id%> | today               | today              | 4 / 4           | 1 DVD | Mailed on today    |


#  @TC.124099 @bus @machines_sync @tasks_p2 @qa12 @env_dependent
#  Scenario: 124099:Server storage used for VMBU container
#    When I act as partner by:
#      | name                       |
#      | VMBU Enterprise_DONOT_EDIT |
#    When I navigate to Search / List Users section from bus admin console page
#    And I view user details by vmbu_freyja_ent1@emc.com
#    And user resources details rows should be:
#      | Storage                                  | Devices                           | Server User Storage Limit:     |
#      | Server: 214.1 GB Used / 1.3 TB Available | Server: 3 Used / 7 Available Edit | Server User Storage Limit: Set |
#    And I view machine sh-loki4.mozy.lab.emc.com details from user details section
#    Then machine details should be:
#      | ID:     | External ID: | Suspended:              | Owner:                   | Space Used: | Last Update: | Encryption: | Client Version: | Product Key:                  | Data Center: |
#      | 7692271 | (change)     | Not Suspended (suspend) | vmbu_freyja_ent1@emc.com | 214.1 GB    | N/A          | Default     | unknown         | 4GAXEDSARDTGZZTWSZXF (Server) | q12a         |
#    When I navigate to Resource Summary section from bus admin console page
#    Then Itemized storage summary should be:
#      | Desktop Used | Desktop Total | Server Used | Server Total | Available | Used     |
#      | 0            | 125 GB        | 214.1 GB    | 1.5 TB       | 1.4 TB    | 214.1 GB |
#    When I download Machine Details (CSV) quick report
#    And I get record for column Machine with value sh-loki4.mozy.lab.emc.com from Quick report machines csv file should be
#      | Machine                   | Key Type | Quota Used |
#      | sh-loki4.mozy.lab.emc.com | Server   | 214.1      |

#  @TC.125784 @bus @machines_sync @tasks_p2 @qa12 @env_dependent
#  Scenario: 125784 VMBU data shuttle status is reflected correctly in BUS
#    When I search partner by:
#      | name          |
#      | ClientQA-VMBU |
#    And I view admin details by jasona+clientvmbu@mozy.com
#    And I get the admin id from admin details
#    When I order data shuttle for ClientQA-VMBU
#      | power adapter   | key from             | os      |
#      | Data Shuttle US | 9X37WGFV58DBXBC7TSS2 | vSphere |
#    Then Data shuttle order should be created
#    Then I get the data shuttle seed id by partner ClientQA-VMBU
#    When I search machine by:
#      | machine_name                  |
#      | jeff2-loki.mozyclientqa.local |
#    And I view machine details for jefft+qa12loki@mozy.com
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase   | % Complete | GB Transferred | GB Remaining | Start | Elapsed |
#      | <%=@seed_id%> |                        | Ordered |            |                |              |       |         |
#    And I set the data shuttle seed status:
#      | status  | username                | password                           | machine_hash                             |
#      | seeding | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd']%> | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase   | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Seeding | 0%         | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status        | username                | password                           | total files | total bytes | machine_hash                             |
#      | seed_complete | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd']%> | 1000        | 2097152     | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase         | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Seed Complete | 0%         | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status     | username                | password                            | machine_hash                             |
#      | seed_error | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd'] %> | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase      | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Seed Error | 0%         | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status  | username                | password                           | total files seeded | total bytes seeded | machine_hash                             |
#      | loading | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd']%> | 100                | 2000000            | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase   | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Loading | 0%         | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status        | username                | password                            | total files | total bytes | total files seeded | total bytes seeded | machine_hash                             |
#      | load_complete | jefft+qa12loki@mozy.com |  <%=CONFIGS['global']['test_pwd']%> | 1000        | 2097152     | 1000               | 2097152            | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase         | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Load Complete |  0%        | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status     | username                | password                           | machine_hash                             |
#      | load_error | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd']%> | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase      | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Load Error | 0%         | 0              | 0            | 1 minute |
#    And I set the data shuttle seed status:
#      | status    | username                | password                           | machine_hash                             |
#      | cancelled | jefft+qa12loki@mozy.com | <%=CONFIGS['global']['test_pwd']%> | 45f3e4287416ace3b94a6d372c6329f9315d7974 |
#    When I refresh Machines Details section
#    Then the data shuttle machine details should be:
#      | Order ID      | Data Shuttle Device ID | Phase     | % Complete | GB Transferred | GB Remaining | Elapsed  |
#      | <%=@seed_id%> | <%=@seed_id%>          | Cancelled |            |                |              | 1 minute |