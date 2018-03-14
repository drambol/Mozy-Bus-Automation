Feature: View machine manifest, logfile

  Background:
    Given I log in bus admin console as administrator

  @TC.869 @bus @machines_sync @tasks_p2 @smoke @ROR_smoke @qa12
  Scenario: 869 View a manifest normal
    When I add a new MozyPro partner:
      | period | base plan | net terms | root role               |
      | 1      | 10 GB     | yes       | Bundle Pro Partner Root |
    And New partner should be created
    Then I change root role to testall(partner)
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.869.User   | (default user group) | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.869.User
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine_869    | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device
      | machine_id                  |
      | <%=@clients[0].machine_id%> |
    When I search machine by:
      | machine_name   |
      | Machine_869    |
    And I view machine details for <%=@new_users.first.email%>
    And I click View from machines details section
    And I navigate to new window
    Then the manifest window title should include Manifest for Machine_869
    And action links in the manifest will be
      | show deleted files | show real filenames | open raw | reload |
    And manifest content will include
      """
      backup time    | mtime          |  file size |  comp size | patch size | hash
      """

  @TC.870 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 870 View a manifest raw
    When I add a new MozyPro partner:
      | period | base plan | net terms | root role               |
      | 1      | 10 GB     | yes       | Bundle Pro Partner Root |
    And New partner should be created
    Then I change root role to testall(partner)
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.870.User   | (default user group) | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.870.User
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine_870    | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device
      | machine_id                  |
      | <%=@clients[0].machine_id%> |
    When I search machine by:
      | machine_name   |
      | Machine_870    |
    And I view machine details for <%=@new_users.first.email%>
    And I delete the manifest file belongs to Machine_870
    And I click Raw from machines details section
    Then the manifest file is downloaded
      | file name                |
      | <%=@manifest_file_name%> |
    And manifest file should have valid manifest

  @TC.2059 @bus @machines_sync @tasks_p2 @smoke
  Scenario: 2059 View the Logfile in BUS
    When I add a new MozyPro partner:
      | period | base plan | net terms | root role               |
      | 1      | 10 GB     | yes       | Bundle Pro Partner Root |
    And New partner should be created
    Then I change root role to testall(partner)
    And I act as newly created partner account
    And I add new user(s):
      | name          | user_group           | storage_type | devices |
      | TC.2059.User  | (default user group) | Desktop      | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.2059.User
    And I update the user password to default password
    Then I use keyless activation to activate devices newly
      | machine_name   | user_name                   | machine_type |
      | Machine_2059   | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device
      | machine_id                  |
      | <%=@clients[0].machine_id%> |
    When I search machine by:
      | machine_name   |
      | Machine_2059   |
    And I view machine details for <%=@new_users.first.email%>
    And I delete the client log belongs to Machine_2059
    And I click View Logfile from machines details section
    Then the Logfile file is downloaded
      | file name           |
      | <%=@log_file_name%> |
    And File size should be greater than 0
    Then I delete the newly downloaded file

  # using fixed data partner id: 3431128,  partner: freyatest01[Do Not Edit]
  @TC.122221 @bus @machines_sync @tasks_p2 @smoke @ROR_smoke @qa12
  Scenario: 122221 Order Restore dvd
    When I search user by:
     | keywords                    |
     | mozybus+freyatest01@emc.com |
    And I view user details by mozybus+freyatest01@emc.com
    When I click restore Files folder icon for device CNENCHENC33L1C
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
    And I view machine CNENCHENC33L1C details from user details section
    Then Restores table first record will display as:
      | ID                       | Date/Time Requested | Date/Time Finished | Files Retrieved | Size  | Status / Downloads                       |
      | <%=@restore.restore_id%> | today               | today              | 1 / 1           | 1 DVD | Retrieved files; preparing to burn DVDs. |



