Feature: Machine and Sync


  Background:
    Given I log in bus admin console as administrator


    @TC.132601 @bus @machines_sync @tasks_p3
    Scenario: 132601 [default-no pci] MozyHome user can multiple download via same download link in bus
        #======using a existing user (qa12)======
        #======half automation since the new mozyhome user has some thrid party api issue======
    When I navigate to Search / List Users section from bus admin console page
    Then I search user by:
    | keywords                      |
    | fabuloussnake0125@hotmail.com |
    And I view user details by fabuloussnake0125@hotmail.com
    When as a MozyHome User clicks computer CNENZHANGJ7M1
    Then click item Download Restore to download restore file
    And click item Download Restore to download restore file
    And click item Download Restore to download restore file


    @TC.132602 @bus @machines_sync @tasks_p3
    Scenario: 132602 [default-no pci] MozyPro/MozyEnt user can multiple download via same download link in bus
    When I add a new MozyEnterprise partner:
    | period | users | server plan | security |
    | 12     | 10    | 250 GB      | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
    | name  | user_group           | storage_type | storage_limit | devices |
    | User1 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
    | keywords   |
    | User1 |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
    | machine_name  | user_name                   | machine_type |
    | Machine1      | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
    | machine_id                         | GB | password                      | file_name    |
    | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> | TC131831.txt |
    Then tds returns successful upload
    Then I refresh User Details section
    And I access freyja from bus admin
    Then I navigate to new window
    Then I have login freyja from BUS
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
    | restore_name         | restore_type |
    | archive_restore_file | archive      |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout
    Then I navigate to old window
    And I refresh User Details section
        #======click Download Restore item on the machine detail to download the restore file======
    When I navigate to Search / List Machines section from bus admin console page
    And I view machine details for Machine1
    And I get machine details info
    Then Restores table first record will display as:
    | Status / Downloads |
    | Download Restore   |
    And click item Download Restore to download restore file
    And click item Download Restore to download restore file
    And click item Download Restore to download restore file
    And I stop masquerading


    @TC.132603 @bus @machines_sync @tasks_p3
    Scenario: 132603 [default-no pci] MozyHome user login as user can multiple download via same download link in bus
    Given I log into phoenix with username fabuloussnake0125@hotmail.com and password QAP@SSw0rd
    Given I log in bus admin console as administrator
    When I navigate to Search / List Users section from bus admin console page
    Then I search user by:
    | keywords                      |
    | fabuloussnake0125@hotmail.com |
    And I view user details by fabuloussnake0125@hotmail.com
    #======get machine id======
    When as a MozyHome User clicks computer CNENZHANGJ7M1
    Then I get machine details info
    #======since there is two X button on the UI, click Log in as user will casue some unepected behavior
    #logining in the phenix, workaroing======
    When I navigate to Search / List Partners section from bus admin console page
    But I navigate to Search / List Users section from bus admin console page
    Then I search user by:
    | keywords                      |
    | fabuloussnake0125@hotmail.com |
    And I view user details by fabuloussnake0125@hotmail.com
    #======log in as the user to access phoenix page======
    When I Log in as the user
    Then I navigate to phoenix login page
    And I navigate to new window
    #======access the freyja page======
    When I click Restore Files link beside device CNENZHANGJ7M1
    And I navigate to new window
    Then I select the Devices tab
    And I download file /Users/zhangj7/Documents/extracting/1 on machine from its Devices device
    Then I select the Synced tab
    And I select the Devices tab
    And I download file /Users/zhangj7/Documents/extracting/1 on machine from its Devices device
    Then I select the Synced tab
    And I select the Devices tab
    And I download file /Users/zhangj7/Documents/extracting/1 on machine from its Devices device


    @TC.132604 @bus @machines_sync @tasks_p3
    Scenario: 132604 [default-no pci] MozyPro/Ent user login as user can mutiple download via same download link in bus
    When I add a new MozyEnterprise partner:
    | period | users | server plan | security |
    | 12     | 10    | 250 GB      | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I act as newly created partner
    And I add new user(s):
    | name  | user_group           | storage_type | storage_limit | devices |
    | User1 | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
    | keywords   |
    | User1 |
    And I view user details by newly created user email
    And I update the user password to Hipaa password
    Then I use keyless activation to activate devices
    | machine_name  | user_name                   | machine_type |
    | Machine1      | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
    | machine_id                         | GB | password                      | file_name    |
    | <%=@new_clients.first.machine_id%> | 30 | <%=QA_ENV['hipaa_password']%> | TC131831.txt |
    Then tds returns successful upload
    Then I refresh User Details section
    And I access freyja from bus admin
    Then I navigate to new window
    Then I have login freyja from BUS
    When I select the Devices tab
    And I choose one file
    And I open Actions panel
    And I click Large Download Options restore wizard
    And I fill out the restore wizard
    | restore_name         | restore_type |
    | archive_restore_file | archive      |
    When I select options menu
    And I select event history
    Then this restore is Ready for Download
    When I select options menu
    And I logout
    Then I navigate to old window
    And I refresh User Details section
        #======act as user======
        #======click Download Restore item on the machine detail to download the restore file======
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
    | keywords |
    | User1    |
    And I view user details by newly created user email
    Then I Log in as the user
    And I navigate to new window
    When after acting as user then clicks computer Machine1
    Then after acting as user then click item Download Restore to download restore file
    And after acting as user then click item Download Restore to download restore file
    And after acting as user then click item Download Restore to download restore file
    Then I close new window