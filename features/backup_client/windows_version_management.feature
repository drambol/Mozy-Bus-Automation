Feature: As a Mozy Admin, I should be able to add new windows version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  @TC.126168 @bus @windows_version_management @tasks_p1
  Scenario: 126168 Create a windows client version in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                       | platform | version number | notes                                              |
      | WinTestVersion 10.10.10.10 | win      | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  @TC.126172 @bus @windows_version_management @tasks_p1
  Scenario: 126172 Windows Backup client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | win      | true         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name                       | Status     |
      | 10.10.10.10 | win       | WinTestVersion 10.10.10.10 | incomplete |

  @TC.132025 @bus @windows_version_management @tasks_p1
  Scenario: 132025 Backup client version can only be managed by BDS partner
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    Then I will not see the Create New Versions link from navigation links
    And I will not see the List Versions link from navigation links
    When I navigate to Edit Client Version section from bus admin console page
    Then there is no field for Create New Version in edit client version section
    Then there is no field for List Versions in edit client version section

  @TC.122205 @bus @windows_version_management @tasks_p1
  Scenario: 122205 Upload an oem.db3 for windows version
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I upload file objects_2.30.0.466.db3 for the windows version
    And I save changes for the version
    And I wait for 120 seconds
    Then version info should be changed successfully
    And I refresh version details section
    And I change version status to enabled
    Then version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | win      | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name                       | Status  |
      | 10.10.10.10 | win       | WinTestVersion 10.10.10.10 | enabled |
    # upload executable for pro and enterprise
    When I click Brandings tab of version details
    And I upload executable FakeWinClient.exe for partner MozyPro
    And I upload executable FakeWinClient.exe for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated

  @TC.126170 @bus @windows_version_management @tasks_p1
  Scenario: 126170 Backup client version can be disabled
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully
    When I close version details section
    And I list versions for:
      | platform | show disabled |
      | win      | false         |
    Then I should not see version 10.10.10.10 in version list

  # Upgrade Rules

  @TC.126183 @bus @windows_version_management @tasks_p1
  Scenario: 126183 "Upgrade Version" selector should include enabled Backup client versions
    When I navigate to Upgrade Rules section from bus admin console page
    Then there is no version WinTestVersion 10.10.10.10 in Upgrade Version list

    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully

    When I navigate to Upgrade Rules section from bus admin console page
    And I refresh Upgrade Rules section
    Then there is version WinTestVersion 10.10.10.10 in Upgrade Version list


  @TC.124042 @bus @windows_version_management @tasks_p1
  Scenario: 124042 Create Manual upgrade rule for Backup client in Mozypro partner
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To           | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       | "%1" /silent    |         |
    And I delete client version rule for Windows 10.10.10.10 if it exists
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.124042.User | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.124042.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_124042 | <%=@new_users.first.email%> | Desktop      | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | win      | x86    | mozypro  | 0.0.0.2 |
    Then client config should contains:
      | update-manual-url                        |
      | /downloads/mozypro-10_10_10_10-XXXXX.exe |
    And I delete user

  @TC.124044 @bus @windows_version_management @tasks_p1
  Scenario: 124044 Create Force upgrade rule for Backup client in MozyEnterprise partner
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | Y    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To           | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      | "%1" /silent    |         |
    And I delete client version rule for Windows 10.10.10.10 if it exists
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.124044.User | (default user group) | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.124044.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_124044 | <%=@new_users.first.email%> | Desktop      | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | win      | x86    | mozypro  | 0.0.0.2 |
    Then client config should contains:
      | update-url                                      | required-client-version | update-required | update-command |
      | /downloads/MozyEnterprise-10_10_10_10-XXXXX.exe | 10.10.10.10             | 1               | "%1" /silent   |
    And I delete user

    When I log in bus admin console as administrator
    And I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists

  @TC.126184 @bus @windows_version_management @tasks_p1
  Scenario: 126184 Remove the client upgrade rule in BDS partner
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    And I add a new upgrade rule:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    Then there is rule for WinTestVersion 10.10.10.10 in Upgrade Rules

    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    Then there is no rule for WinTestVersion 10.10.10.10 in Upgrade Rules


  @TC.124041 @bus @windows_version_management @tasks_p1
  Scenario: 124041 bds partner can update the client upgrade rule successfully
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    When I add a new upgrade rule:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    Then Upgrade Rule for version WinTestVersion 10.10.10.10 should be:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    When I update Upgrade Rule for version WinTestVersion 10.10.10.10 as below:
      | version name                | Req? | On? |
      | WinTestVersion 10.10.10.10  | N    | Y   |
    And I wait for 15 seconds
    And I refresh Upgrade Rules section
    Then Upgrade Rule for version WinTestVersion 10.10.10.10 should be:
      | version name                | Req? | On? | min version | max version | Install CMD   |
      | WinTestVersion 10.10.10.10  | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent  |
    #And I delete rule for version WinTestVersion 10.10.10.10 if it exists


  # Edit Client Version

  @TC.126189 @bus @windows_version_management @tasks_p1
  Scenario: 126189 Upgrade to: Product partner can't list the inherited version if not branded
    When I use a existing partner:
      | company name                                   | admin email                           | admin name       | partner type |
      | Internal Mozy - MozyEnterprise product partner | mozyautotest+maria+white+0139@emc.com | Admin Automation | OEM          |
    And I get partner id by admin email from database
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    When I navigate to Edit Client Version section from bus admin console page
    Then there is no version Windows 10.10.10.10 in Update to list

  @TC.126188 @bus @windows_version_management @tasks_p1
  Scenario: 126188 Upgrade to: Product partner can list the Branding version if branded
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeWinSyncClient.exe for partner Internal Mozy - MozyEnterprise product partner
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner Internal Mozy - MozyEnterprise product partner should be generated

    When I use a existing partner:
      | company name                                   | admin email                           | admin name       | partner type |
      | Internal Mozy - MozyEnterprise product partner | mozyautotest+maria+white+0139@emc.com | Admin Automation | OEM          |
    And I get partner id by admin email from database
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    When I navigate to Edit Client Version section from bus admin console page
    Then there is version Windows 10.10.10.10 in Update to list

  @TC.131322 @bus @windows_version_management @tasks_p1
  Scenario: 131322 Operating System: Operating System should list all the required windows os
    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I select version Windows 10.10.10.10 in Update To list
    Then Operating System should include OS:
      | Any | Windows 2000 (NT 5.0) | Windows XP (NT 5.1) | Windows XP(x64)/Windows Server 2003/2003R2 (NT 5.2) | Windows Vista/Windows Server 2008 (NT 6.0) | Windows 7/Windows Server 2008 R2 (NT 6.1) | Windows 8/Windows Server 2012 (NT 6.2) | Windows 8.1/Windows Server 2012 R2 (NT 6.3) |

  @TC.126194 @bus @windows_version_management @tasks_p1
  Scenario: 126194 User Group: User groups selector will list "All User Groups" and each user group of the partner
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I add a new Bundled user group:
      | name             | storage_type |
      | TC.126194-Shared | Shared       |
    And I navigate to Edit Client Version section from bus admin console page
    Then User Group selector should include:
      | All User Groups | (default user group) | TC.126194-Shared |
    And I navigate to User Group List section from bus admin console page
    And I delete user group details by name: TC.126194-Shared

  @TC.126191 @TC.126192 @bus @windows_version_management @tasks_p1
  Scenario: 126191 126192 Client Version Rules: Create Force update client version rule for Backup client. Client Version Rules: Remove the client version rules in non-BDS partner
    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Windows 10.10.10.10 if it exists

    And I add a new rule in Edit Client Version:
      | Update To           | Current Version >= | Current Version <= | Required | Install Command |
      | Windows 10.10.10.10 | 0.0.0.1            | 0.0.0.2            | Yes      | "%1" /silent    |
    And Client Version Rules should include rule:
      | Update To           | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      | "%1" /silent    | Remove  |

    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.126191.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126191.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_126191 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    And I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | win      | x86_64 | MozyEnterprise | 0.0.0.2 |
    And client config should contains:
      | update-url                                      | required-client-version | update-required | update-command |
      | /downloads/MozyEnterprise-10_10_10_10-XXXXX.exe | 10.10.10.10             |  1              | "%1" /silent   |

    When I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Windows 10.10.10.10 if it exists
    Then Client Version Rules should not include rule:
      | Update To           | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      | "%1" /silent    | Remove  |
    And I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | win      | x86_64 | MozyEnterprise | 0.0.0.2 |
    Then client config should not contains:
      | update-url                                      | update-required |
      | /downloads/MozyEnterprise-10_10_10_10-XXXXX.exe |  1              |
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.126191.User
    And I delete user

  # Download * Client

  # qa12,qa6busclient01 download permission bug
  @TC.126176 @bus @windows_version_management @tasks_p1
  Scenario: 126176 backup client can be downloaded successfully for none product partner
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinTestVersion 10.10.10.10 if it exists
    And I add a new upgrade rule:
      | version name                | Req? | On? | min version | max version | Install CMD  |
      | WinTestVersion 10.10.10.10  | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |
    Then there is rule for WinTestVersion 10.10.10.10 in Upgrade Rules

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | MozyEnterprise WinTestVersion 10.10.10.10 |
    When I view Details for client MozyEnterprise WinTestVersion 10.10.10.10
    Then I should see download link for MozyEnterprise-10_10_10_10
    When I clear downloads folder
    And I click download link for MozyEnterprise-10_10_10_10
    Then client started downloading successfully
    When I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinClient.exe

  # precondition: TC.126188
  # qa12,qa6busclient01 download permission bug
  @TC.126177 @bus @windows_version_management @tasks_p1
  Scenario: 126177 backup client can be downloaded successfully for product partner
    When I use a existing partner:
      | company name                                   | admin email                           | admin name       | partner type |
      | Internal Mozy - MozyEnterprise product partner | mozyautotest+maria+white+0139@emc.com | Admin Automation | OEM          |
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    And I navigate to Download * Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | WinTestVersion 10.10.10.10 |
    When I view Details for client WinTestVersion 10.10.10.10
    Then I should see download link for backupclient-10_10_10_10
    When I clear downloads folder
    And I click download link for backupclient-10_10_10_10
    Then client started downloading successfully
    When I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinSyncClient.exe

  @TC.126178 @bus @windows_version_management @tasks_p1
  Scenario: 126178 "Windows Crypto Utility" link of windows client should work correctly
    When I use a existing partner:
      | company name                                          | admin email                      | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise without server license | automation_test_partner@test.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | Other: Windows Crypto Utility |
    When I clear downloads folder
    And I click download link for Windows Crypto Utility
    Then client started downloading successfully

  @TC.126180 @bus @windows_version_management @tasks_p1
  Scenario: 126180 Details link of backup client should work correctly
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | MozyPro WinTestVersion 10.10.10.10 |
    And I view Details for client MozyPro WinTestVersion 10.10.10.10
    Then the version detail info should be:
      | Download:                     | MD5:               | Date:  |
      | mozypro-10_10_10_10-XXXXX.exe | FakeWinClient.exe  | @today |

  @TC.505 @bus @windows_version_management @tasks_p1
  Scenario: 505 Verify md5 checksum explanation links are functional
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Windows in Backup Clients part:
      | MozyPro WinTestVersion 10.10.10.10 |
    When I view Details for client MozyPro WinTestVersion 10.10.10.10
    And I click MD5 help link
    Then I should see help message on MD5
    When I close MD5 help message div
    Then I should not see help message on MD5

  @clean_up
  Scenario: clean up all windows test versions
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win      | true          |
    And I delete version 10.10.10.10 if it exists

