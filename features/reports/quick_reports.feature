Feature: Quick Report

  Background:
    Given I log in bus admin console as administrator



  @TC.124057 @bus @tasks_p2 @reports
  Scenario: 124057 Linux - Machine of Quick Reports
    When I check that linux client service is available
    And I upload change linux client env script to remote machine
    And I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 50 GB     | yes         |
    And New partner should be created
    And I change root role to Business Root
    And I activate new partner admin with default password
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name            | storage_type | storage_limit | devices | user_group           |
      | TC.124057.User  | Server       | 10            | 3       | (default user group) |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I backup file using linux client for user newly created user email password default password
    When I search machine by:
      | machine_name    |
      | BUS-Auto-03-Zoe |
    When I view machine details for BUS-Auto-03-Zoe
    And I get machine details info
    And I clear downloads folder machines*.csv file
    When I download Machines (CSV) quick report
    Then Quick report Machines csv file details should include
      | Column A        | Column B                 | Column C             | Column D          | Column E                                      | Column F  | Column G        | Column H    |
      | Machine         | User                     | User Group           | Data Center       | Storage Used                                  | Created   | Last Update     | Backed Up   |
      | BUS-Auto-03-Zoe | <%=@new_users[0].email%> | (default user group) | <%=@data_center%> | <%=@machine_info['Space Used:']+' / Shared'%> | today     | today           | minute      |
    And I clear downloads folder machines*.csv file
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name



  @TC.21160 @bus @tasks_p2 @reports
  Scenario: 21160 [Quick Reports] Verify User Group CSV
    And I clear downloads folder
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I clear downloads folder user_groups*.csv file
    When I download UserGroups (CSV) quick report
    Then Quick report User Groups csv file details should be:
      | Column A    | Column B               | Column C | Column D | Column E   | Column F | Column G  | Column H     | Column I        | Column J   | Column K     |
      | External ID | Name                   | Users    | Admins   | Sync Users | Keys     | Keys Used | Quota        | Quota Allocated | Quota Used | Billing Code |
      |             | (default user group) * | 3        | 2        | 1          | N/A      | 2         | Shared       | N/A             | 45.0       |              |
      |             | NEW-Assigned-1         | 2        | 2        | 0          | N/A      | 2         | Assigned: 30 | N/A             | 24.0       |              |
      |             | NEW-Assigned-2         | 1        | 2        | 0          | N/A      | 2         | Assigned: 10 | N/A             | 7.0        |              |
      |             | NEW-Limited            | 1        | 2        | 0          | N/A      | 3         | Limited: 50  | N/A             | 9.0        |              |
      |             | NEW-None               | 0        | 2        | 0          | N/A      | 0         | N/A          | N/A             | 0.0        |              |
    When I navigate to User Group List section from bus admin console page
    Then Bundled user groups table should be:
      | Group Name           | Sync  | Server | Storage Type | Type Value | Storage Used | Devices Used |
      | (default user group) | true  | true   | Shared       |            | 45 GB        | 2            |
      | NEW-Assigned-1       | false | true   | Assigned     | 30 GB      | 24 GB        | 2            |
      | NEW-Assigned-2       | false | true   | Assigned     | 10 GB      | 7 GB         | 2            |
      | NEW-Limited          | false | true   | Limited      | 50 GB      | 9 GB         | 3            |
      | NEW-None             | false | false  | None         |            | 0            | 0            |
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I clear downloads folder user_groups*.csv file
    When I download UserGroups (CSV) quick report
    Then Quick report User Groups csv file details should be:
      | Column A    | Column B               | Column C | Column D | Column E   | Column F    | Column G         | Column H     | Column I               | Column J          | Column K     | Column L          | Column M      | Column N                | Column O           | Column P     |
      | External ID | Name                   | Users    | Admins   | Sync Users | Server Keys | Server Keys Used | Server Quota | Server Quota Allocated | Server Quota Used | Desktop Keys | Desktop Keys Used | Desktop Quota | Desktop Quota Allocated | Desktop Quota Used | Billing Code |
      |             | (default user group) * | 1        | 1        | 0          | 192         | 0 (2 reserved)   | Shared       | N/A                    | 0.0               | 2            | 0                 | Shared        | N/A                     | 0.0                |              |
      |             | NEW-Assigned           | 2        | 1        | 1          | 4           | 2 (2 reserved)   | Assigned: 50 | N/A                    | 42.0              | 4            | 2 (2 reserved)    | Assigned: 100 | N/A                     | 98.0               |              |
      |             | NEW-Limited            | 2        | 1        | 1          | 4           | 2                | Limited: 50  | N/A                    | 37.0              | 4            | 2                 | Limited: 80   | N/A                     | 51.0               |              |
      |             | NEW-None               | 0        | 1        | 0          | 0           | 0                | N/A          | N/A                    | 0.0               | 0            | 0                 | N/A           | N/A                     | 0.0                |              |
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Sync  | Desktop Storage Type | Desktop Type Value | Desktop Storage Used | Desktop Devices Used | Desktop Devices Total | Server Storage Type | Server Type Value | Server Storage Used | Server Devices Used | Server Devices Total |
      | (default user group) | false | Shared               |                    | 0                    | 0                    | 2                     | Shared              |                   | 0                   | 0                   | 192                  |
      | NEW-Assigned         | true  | Assigned             | 100 GB             | 98 GB                | 2                    | 4                     | Assigned            | 50 GB             | 42 GB               | 2                   | 4                    |
      | NEW-Limited          | false | Limited              | 80 GB              | 51 GB                | 2                    | 4                     | Limited             | 50 GB             | 37 GB               | 2                   | 4                    |
      | NEW-None             | false | None                 |                    | 0                    | 0                    | 0                     | None                |                   | 0                   | 0                   | 0                    |
    And I clear downloads folder user_groups*.csv file

  @TC.21161 @bus @tasks_p2 @reports
  Scenario: 21161 [Quick Reports] Verify Mozy Pro Keys CSV
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I clear downloads folder mozy_pro_keys*.csv file
    When I download Mozy Pro Keys (CSV) quick report
    Then Quick report Mozy Pro Keys csv file header should be:
      | Column A | Column B      | Column C        | Column D  | Column E | Column F  |
      | Key Type | User Group ID | User Group Name | Key       | Quota    | Email To  |
    And Quick report Mozy Pro Keys csv file column E value should be empty
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I clear downloads folder mozy_pro_keys*.csv file
    When I download Mozy Pro Keys (CSV) quick report
    Then Quick report Mozy Pro Keys csv file header should be:
      | Column A | Column B      | Column C        | Column D  | Column E | Column F  |
      | Key Type | User Group ID | User Group Name | Key       | Quota    | Email To  |
    And Quick report Mozy Pro Keys csv file column E value should be empty
    And I clear downloads folder mozy_pro_keys*.csv file

  @TC.21162 @bus @tasks_p2 @reports
  Scenario: 21162 [Quick Reports] Verify Machine Details CSV
    When I act as partner by:
      | name                                    |
      | [DO NOT CHANGE][Bundled] Reporting Test |
    And I clear downloads folder machines*.csv file
    When I download Machine Details (CSV) quick report
    Then Quick report Machines csv file header should be:
      | Column A | Column B   | Column C     | Column D  | Column E | Column F | Column G | Column H   | Column I      | Column J     | Column K    | Column L       | Column M    |
      | Partner  | User Group | Billing Code | User      | Name     | Machine  | Key Type | Quota Used | Quota Granted | Created Date | Last Backup | Client Version | Data Center |
    And Quick report Machines csv file column I value should match Shared or Limited: xx
    When I stop masquerading
    When I act as partner by:
      | name                                     |
      | [DO NOT CHANGE][Itemized] Reporting Test |
    And I clear downloads folder machines*.csv file
    When I download Machine Details (CSV) quick report
    Then Quick report Machines csv file header should be:
      | Column A | Column B   | Column C     | Column D  | Column E | Column F | Column G | Column H   | Column I      | Column J     | Column K    | Column L       | Column M    |
      | Partner  | User Group | Billing Code | User      | Name     | Machine  | Key Type | Quota Used | Quota Granted | Created Date | Last Backup | Client Version | Data Center |
    And Quick report Machines csv file column I value should match Shared or Limited: xx
    When I stop masquerading
    When I act as partner by:
      | name                    |
      | [MozyPro] Delete Device |
    And I clear downloads folder machines*.csv file
    When I download Machine Details (CSV) quick report
    Then Quick report Machines csv file header should be:
      | Column A | Column B   | Column C     | Column D  | Column E | Column F | Column G | Column H   | Column I      | Column J     | Column K    | Column L       | Column M    |
      | Partner  | User Group | Billing Code | User      | Name     | Machine  | Key Type | Quota Used | Quota Granted | Created Date | Last Backup | Client Version | Data Center |
    And Quick report Machines csv file column I value should match Shared or Limited: xx
    When I stop masquerading
    When I act as partner by:
      | name                                 |
      | Alura Business Solutions[Donot edit] |
    And I clear downloads folder machines*.csv file
    When I download Machine Details (CSV) quick report
    Then Quick report Machines csv file header should be:
      | Column A | Column B   | Column C     | Column D  | Column E | Column F | Column G | Column H   | Column I      | Column J     | Column K    | Column L       | Column M    |
      | Partner  | User Group | Billing Code | User      | Name     | Machine  | Key Type | Quota Used | Quota Granted | Created Date | Last Backup | Client Version | Data Center |
    And Quick report Machines csv file column I value should match number
