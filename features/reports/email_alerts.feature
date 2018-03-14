Feature: Email Alerts
  pre-condition
  update environment:
  MAILBOX = ENV['BUS_MAILBOX'] || ''

  Background:
    Given I log in bus admin console as administrator

  @TC.1980 @bus @email_alerts @tasks_p1 @smoke @ROR_smoke
  Scenario: 1980:Create New Daily Alert
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules                             | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups| <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    And The email alert details should be:
      | subject line       | frequency | report modules                               | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups  | <%=@partner.admin_info.full_name%> |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to               | content       |
      | @new_admin_email | Backup Summary|
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1983 @bus @email_alerts @tasks_p1
  Scenario: 1983:Modify Existing Email Alert
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States |
    Then New partner should be created
    Then I change root role to FedID role
    Then I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    Then I add a new admin:
      | Name        | Roles      | User Group           |
      | alert_admin | FedID role | (default user group) |
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules                              | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created

    When I expand the add email alert
    And I modify email alert to:
      | subject line        | frequency | report modules                                  | scope                |recipients |
      | email_alerts_modify | weekly    | Users/Machines nearing max;Storage pool summary | (default user group) |alert_admin |
    Then show email alerts section message should be The alert has been updated.
    And The email alert details should be:
      | subject line         | frequency | report modules                                  | recipients  |
      | email_alerts_modify  | weekly    | Users/Machines nearing max;Storage pool summary | alert_admin |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to                | content                 |
      | <%=@admin.email%> | Machines using over 90% |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1981 @bus @email_alerts @tasks_p1
  Scenario: 1981:Create New Weekly Alert
    When I add a new MozyEnterprise partner:
      | period | users | coupon              | country       |
      | 12     | 100   | 20PERCENTOFFOUTLINE | United States |
    Then New partner should be created
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules                              | recipients                         |
      | email_alerts_test  | weekly    | Backup summary;Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    And The email alert details should be:
      | subject line       | frequency | report modules                               | recipients                         |
      | email_alerts_test  | weekly    | Backup summary;Users without recent backups  | <%=@partner.admin_info.full_name%> |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to               | content        |
      | @new_admin_email | Backup Summary |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122228 @bus @email_alerts @tasks_p1
  Scenario: 122228:Delete an email alert
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 100   |
    Then New partner should be created
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules |
      | email_alerts_test  | weekly    | Backup summary |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    And I delete the email alert
    And I wait for 2 seconds
    And The email alert email_alerts_test should be deleted
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.2169 @bus @email_alerts @tasks_p1
  Scenario: 2169:Change the email alerts recipients
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States |
    Then New partner should be created
    Then I change root role to FedID role
    Then I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    Then I add a new admin:
      | Name              | Roles      | User Group           |
      | email_alert_admin | FedID role | (default user group) |
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line       | frequency | report modules                              | recipients                         |
      | email_alerts_test  | daily     | Backup summary;Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    And I modify email alert to:
      | recipients        |
      | email_alert_admin |
    Then show email alerts section message should be The alert has been updated.
    And The email alert details should be:
      | recipients        |
      | email_alert_admin |
    Then I Send Now the email alert
    And I search emails by keywords:
      | to                | content          |
      | <%=@admin.email%> | Backup Summary   |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122440 @bus @email_alerts @tasks_p1
  Scenario: 122440:Storage pool summary of Email Alerts
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122440.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.122440.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_122440 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                 | frequency | report modules       | recipients                         |
      | alerts_test_storage_summary  | daily     | Storage pool summary | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content         |
      | @new_admin_email  | Storage Summary |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include 30 GB/70 GB
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122441 @bus @email_alerts @tasks_p1
  Scenario: 122441:Backup summary of Email Alerts
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122441.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.122441.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_122441 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                | frequency | report modules | recipients                         |
      | alerts_test_backup_summary  | daily     | Backup summary | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content        |
      | @new_admin_email  | Backup Summary |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include Machine1_122441
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122442 @bus @email_alerts @tasks_p1
  Scenario: 122442:Users without recent backups of Email Alerts
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122442.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.122442.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_122442 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                        | frequency | report modules               | recipients                         |
      | alerts_test_without_backup_summary  | daily     | Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                              |
      | @new_admin_email  | Machines that haven't been backed up |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include No machines.
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122443 @bus @email_alerts @tasks_p1
  Scenario: 122443:Users with outdated clients of Email Alerts
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 100            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122443.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.122443.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_122443 | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 30 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line               | frequency | report modules               | recipients                         |
      | alerts_test_without_backup | daily     | Users without recent backups | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                                                |
      | @new_admin_email  | Machines that haven't been backed up in the last 1 day |
    Then I should see 1 email(s)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21191_1 @bus @email_alerts @tasks_p1
  Scenario: 21191_1:[Email Alert] Verify Users Nearing Quota Report Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 200            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    When I add a new Bundled user group:
      | name           | storage_type |
      | NEW-Assigned-1 | Shared       |
    Then NEW-Assigned-1 user group should be created
    And I add new user(s):
      | name             | user_group           | storage_type | storage_limit | devices |
      | TC.21191_90.User | (default user group) | Desktop      | 100           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21191_90.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine1_90  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 90 |
    Then tds returns successful upload
    Then I close the user detail page
    And I add new user(s):
      | name             | user_group     | storage_type | storage_limit | devices |
      | TC.21191_80.User | NEW-Assigned-1 | Desktop      | 100           | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21191_80.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine1_80  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 80 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |
      | alerts_test_nearing_max_90% | daily     | Users/Machines nearing max | 90%                |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                 |
      | @new_admin_email  | Machines using over 90% |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include Machine1_90 (90% quota used)
    Then I close the show email alert section
    When I expand the add email alert
    And I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |
      | alerts_test_nearing_max_80% | daily     | Users/Machines nearing max | 80%                |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                     |
      | @new_admin_email  | Machines using over 80% |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include Machine1_90 (90% quota used)
    Then I get text for user group NEW-Assigned-1 from email content
    Then The email content should include Machine1_80 (80% quota used)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21191_2 @bus @email_alerts @tasks_p1
  Scenario: 21191_2:[Email Alert] Verify Users Nearing Quota Report Email
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    When I add a new Itemized user group:
      | name           | desktop_storage_type | desktop_devices | enable_stash | server_storage_type | server_devices |
      | NEW-Assigned-1 | Shared               | 2               | yes          | Shared              | 2              |
    Then NEW-Assigned-1 user group should be created
    And I add new user(s):
      | name             | user_group           | storage_type | storage_limit | devices |
      | TC.21191_70.User | (default user group) | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21191_70.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine1_70  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 70 |
    Then tds returns successful upload
    Then I close the user detail page
    And I add new user(s):
      | name             | user_group     | storage_type | storage_limit | devices |
      | TC.21191_60.User | NEW-Assigned-1 | Desktop      | 100           | 2       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.21191_60.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name | user_name                   | machine_type |
      | Machine1_60  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 60 |
    Then tds returns successful upload
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |
      | alerts_test_nearing_max_70% | daily     | Users/Machines nearing max | 70%                |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                     |
      | @new_admin_email  | Machines using over 70% |
    Then I should see 1 email(s)
    Then I get text for user group (default user group) from email content
    Then The email content should include Machine1_70 (70% quota used)
    Then I close the show email alert section
    When I expand the add email alert
    And I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |recipients                          |
      | alerts_test_nearing_max_60% | daily     | Users/Machines nearing max | 60%                | <%=@partner.admin_info.full_name%> |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                 |
      | @new_admin_email  | Machines using over 60% |
    Then I should see 1 email(s)
    Then I get text for user group NEW-Assigned-1 from email content
    Then The email content should include Machine1_60 (60% quota used)
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21191_3 @bus @email_alerts @tasks_p1
  Scenario: 21191_3:[Email Alert] Verify Users Nearing Quota Report Email
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 200            |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |
      | alerts_test_nearing_max_90% | daily     | Users/Machines nearing max | 90%                |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                     |
      | @new_admin_email  | Machines using over 90% |
    Then I should see 1 email(s)
    Then The email content should include No machines
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21191_4 @bus @email_alerts @tasks_p1
  Scenario: 21191_4:[Email Alert] Verify Users Nearing Quota Report Email
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 10    | 250 GB      |
    Then New partner should be created
    And I get the admin id from partner details
    Then I act as newly created partner account
    Then I navigate to Email Alerts section from bus admin console page
    Then I expand the add email alert
    Then I add a new email alert:
      | subject line                | frequency | report modules             | Percent quota used |
      | alerts_test_nearing_max_60% | daily     | Users/Machines nearing max | 60%                |
    Then email alerts section message should be New alert created
    When I expand the add email alert
    Then I Send Now the email alert
    And I retrieve email content by keywords:
      | to                | content                 |
      | @new_admin_email  | Machines using over 60% |
    Then I should see 1 email(s)
    Then The email content should include No machines
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name
