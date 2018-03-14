Feature: As a Mozy Admin, I should be able to add new mac version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  @TC.126209 @bus @mac_version_management @tasks_p1
  Scenario: 126209 create a new Mac version in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I delete version 10.10.10.10 if it exists
    Then I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                       | platform | version number | notes                                              |
      | MacTestVersion 10.10.10.10 | mac      | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  @TC.126213 @bus @mac_version_management @tasks_p1
  Scenario: 126213 Mac client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | false         |
    And I should not see version 10.10.10.10 in version list
    Then I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I can find the version info in versions list:
      | Version     | Platform  | Name                       | Status   |
      | 10.10.10.10 | mac       | MacTestVersion 10.10.10.10 | disabled |

  @TC.126210 @bus @mac_version_management @tasks_p1
  Scenario: 126210 Mac client version can be enabled
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | true         |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | mac      | false         |
    Then I can find the version info in versions list:
      | Version     | Platform | Name                       | Status  |
      | 10.10.10.10 | mac      | MacTestVersion 10.10.10.10 | enabled |

  @TC.126216 @bus @mac_version_management @tasks_p1
  Scenario: 126216 Mac client can be uploaded successfully for Product Partner
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | true         |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeMacClient.dmg for partner Internal Mozy - MozyEnterprise product partner
    And I upload executable FakeMacClient.dmg for partner MozyPro
    And I save changes for the version
    And version info should be changed successfully
    And the download link for partner Internal Mozy - MozyEnterprise product partner should be generated
    And the download link for partner MozyPro should be generated


  @TC.126227 @bus @mac_version_management @tasks_p1
  Scenario: 126227 Create Auto upgrade rule for Mac client
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version MacTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name               | Req? | On? | min version | max version | Arch   | min os  |
      | MacTestVersion 10.10.10.10 | N    | Y   | 0.0.0.1     | 0.0.0.2     | x86_64 | 10.10.0 |

    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.126227.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126227.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_126227 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    And I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | mac      | x86_64 | mozypro  | 0.0.0.2 |
    And client config should contains:
      | update-url                               |
      | /downloads/mozypro-10_10_10_10-XXXXX.dmg |
    And I delete user

  @TC.126243 @bus @mac_version_management @tasks_p1
  Scenario: 126243 Partner without Edit User Group capability -- Set Force default client version for Backup client
    When I use a existing partner:
      | company name                                          | admin email                            | admin name       | partner type |
      | Internal Mozy - MozyPro no edit user group capability | mozyautotest+wanda+chavez+1446@emc.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And upgrade rule should contains:
      | Mac Default: |
      | auto-update  |
    And I select version Mac 10.10.10.10 in option list for rule mac
    Then client rule updated message should be All machines will have their backup software updated.
    And I add new user(s):
      | name           | storage_type | storage_limit | devices |
      | TC.126243.User | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126243.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_126243 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | mac      | x86_64 | mozypro  | 0.0.0.2 |
    Then client config should contains:
      | update-url                               | required-client-version | update-required |
      | /downloads/mozypro-10_10_10_10-XXXXX.dmg | 10.10.10.10             | 1               |
    And I delete user
    And I navigate to Edit Client Version section from bus admin console page
    And I select version auto-update in option list for rule mac

  @TC.126232 @bus @mac_version_management @tasks_p1
  Scenario: 126232 Upgrade to: No product partner list the inherited Backup version
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And there is version Mac 10.10.10.10 in Update to list

  @TC.126222 @bus @mac_version_management @tasks_p1
  Scenario: 126222 "Mac OS X 10.5(Intel):" download field of Mac client should show up correctly
    When I use a existing partner:
      | company name                                          | admin email                      | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise without server license | automation_test_partner@test.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Mac in Backup Clients part:
      | Mac OS X 10.5 (Intel): MozyEnterprise Mac |
    When I clear downloads folder
    And I click download link for Mac OS X 10.5 (Intel): MozyEnterprise Mac
    Then client started downloading successfully

  @TC.126217 @bus @mac_version_management @tasks_p1
  Scenario: 126217 mac client can be downloaded successfully for none product partner
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Mac in Backup Clients part:
      | MozyPro MacTestVersion 10.10.10.10 |
    When I view Details for client MozyPro MacTestVersion 10.10.10.10
    Then I should see download link for mozypro-10_10_10_10
    When I clear downloads folder
    And I click download link for mozypro-10_10_10_10
    Then client started downloading successfully
    When I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeMacClient.dmg

  @TC.126251 @bus @mac_version_management @tasks_p1
  Scenario: 126251 The most appropriate upgrade rules take effect
    When I navigate to List Versions section from bus admin console page
    ## use existing mac version 10.10.10.11 and 10.10.10.9 and enable/disable it instead of create/delete
    ## mac version 10.10.10.11 and 10.10.10.9 both has a uploaded client for MozyPro, 10.10.10.11 is FakeWinSyncClient2.exe, 10.10.10.9 is FakeWinSyncClient3.exe
    And I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.11
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    And I close version details section

    When I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.9
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    And I close version details section

    #And I list versions for:
    #  | platform | show disabled |
    #  | mac      | true          |
    #And I delete version 10.10.10.11 if it exists
    #And I navigate to Create New Version section from bus admin console page
    #And I add a new client version:
    #  | name                        | platform | version number | notes                                              |
    #  | MacTestVersion 10.10.10.11  | mac      | 10.10.10.11    | This is a test version for BUS version management. |
    #Then the client version should be created successfully
    #When I list versions for:
    #  | platform | show disabled |
    #  | mac      | true          |
    #And I view version details for 10.10.10.11
    #And I click Brandings tab of version details
    #And I upload executable FakeWinSyncClient2.exe for partner MozyPro
    #And I save changes for the version
    #Then version info should be changed successfully
    #And the download link for partner MozyPro should be generated
    #And I click General tab of version details
    #And I change version status to enabled
    #Then version info should be changed successfully
    #And I close version details section

    #When I list versions for:
    #  | platform | show disabled |
    #  | mac      | true          |
    #And I delete version 10.10.10.9 if it exists
    #And I navigate to Create New Version section from bus admin console page
    #And I add a new client version:
    #  | name                      | platform | version number | notes                                              |
    #  | MacTestVersion 10.10.10.9 | mac      | 10.10.10.9     | This is a test version for BUS version management. |
    #Then the client version should be created successfully
    #When I list versions for:
    #  | platform | show disabled |
    #  | mac      | true          |
    #And I view version details for 10.10.10.9
    #And I click Brandings tab of version details
    #And I upload executable FakeWinSyncClient3.exe for partner MozyPro
    #And I save changes for the version
    #Then version info should be changed successfully
    #And the download link for partner MozyEnterprise should be generated
    #And I click General tab of version details
    #And I change version status to enabled
    #Then version info should be changed successfully
    #And I close version details section

    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version MacTestVersion 10.10.10.10 if it exists

    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Mac 10.10.10.9 if it exists
    And I delete client version rule for Mac 10.10.10.10 if it exists
    And I delete client version rule for Mac 10.10.10.11 if it exists

    And I add a new rule in Edit Client Version:
      | Update To       |  User Group          | Current Version >= | Required |
      | Mac 10.10.10.11 |  All User Groups     | 10.10.10.8         | No       |
    And I refresh Edit Client Version section
    And I add a new rule in Edit Client Version:
      | Update To       |  User Group          | Required |
      | Mac 10.10.10.10 | (default user group) | No       |
    And I add a new rule in Edit Client Version:
      | Update To      |  User Group          | Current Version >= | Required |
      | Mac 10.10.10.9 | (default user group) | 10.10.10.8         | No       |
    Then Client Version Rules should include rule:
      | Update To       | User Group           | Current Version     | OS  | Required | Install Command | Options |
      | Mac 10.10.10.11 | All User Groups      | 10.10.10.8 or later | Any | No       |                 | Remove  |
      | Mac 10.10.10.10 | (default user group) | Any version         | Any | No       |                 | Remove  |
      | Mac 10.10.10.9  | (default user group) | 10.10.10.8 or later | Any | No       |                 | Remove  |

    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.126251.User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126251.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_126251 | <%=@new_users.first.email%> | Desktop      | <%=@partner_id%> |
   And I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | mac      | x86_64 | mozypro  | 0.0.0.2 |
      And client config should contains:
      | update-url                               |
      | /downloads/mozypro-10_10_10_10-XXXXX.dmg |
    And I delete user
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Mac 10.10.10.9 if it exists
    And I delete client version rule for Mac 10.10.10.10 if it exists
    And I delete client version rule for Mac 10.10.10.11 if it exists

    When I log in bus admin console as administrator
    And I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.11
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully
    And I close version details section

    When I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.9
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully

  @clean_up
  Scenario: clean up all mac test versions and rules
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.11
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully
    And I close version details section

    When I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I view version details for 10.10.10.9
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully
    And I close version details section

    And I list versions for:
      | platform | show disabled |
      | mac      | true          |
    And I delete version 10.10.10.10 if it exists

