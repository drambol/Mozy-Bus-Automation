Feature: As a Mozy Admin, I should be able to add new sync version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  @TC.131353 @bus @sync_version_management @tasks_p1
  Scenario: 131353 Create a new mozy sync version and in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                           | platform | version number | notes                                              |
      | WinSyncTestVersion 10.10.10.10 | win-sync | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  @TC.131358 @bus @sync_version_management @tasks_p1
  Scenario: 131358 Sync client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name                           | Status   |
      | 10.10.10.10 | win-sync  | WinSyncTestVersion 10.10.10.10 | disabled |

  @TC.131359 @TC.131360 @bus @sync_version_management @tasks_p1
  Scenario: 131359 131360 Linux client can be uploaded successfully for Mozy, Inc.(MozyEnterprise/MozyPro root partner)
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeWinSyncClient.exe for partner Mozy, Inc.
    And I upload executable FakeWinSyncClient.exe for partner MozyPro
    And I upload executable FakeWinSyncClient.exe for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner Mozy, Inc. should be generated
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | win-sync | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name                           | Status  |
      | 10.10.10.10 | win-sync  | WinSyncTestVersion 10.10.10.10 | enabled |

  @TC.131371 @bus @sync_version_management @tasks_p1
  Scenario: 131371 Create Auto upgrade rule for Sync client
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.131371.User | (default user group) | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.131371.User
    And I got client config for the user machine:
      | user_name                   | machine    | platform | codename | version | arch |
      | <%=@new_users.first.email%> | plop000001 | win      | mozypro  | 0.0.0.2 | x86  |
    And client config should contains:
      | update-url                                    |
      | /downloads/mozypro-sync-10_10_10_10-XXXXX.exe |
    And I delete user

  @TC.132043 @bus @sync_version_management @tasks_p1
  Scenario: 132043 Partner without Edit User Group capability -- Auto update will inherit parent upgrade rules
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | N    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                          | admin email                            | admin name       | partner type |
      | Internal Mozy - MozyPro no edit user group capability | mozyautotest+wanda+chavez+1446@emc.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then upgrade rule should contains:
      | Windows Sync Default: |
      | auto-update           |
    When I add new user(s):
      | name           | storage_type | storage_limit | devices | enable_stash |
      | TC.132043.User | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.132043.User
    And I got client config for the user machine:
      | user_name                   | machine    | platform | codename | version | arch |
      | <%=@new_users.first.email%> | plop000001 | win      | mozypro  | 0.0.0.2 | x86  |
    And client config should contains:
      | update-url                                    |
      | /downloads/mozypro-sync-10_10_10_10-XXXXX.exe |
    And I delete user

  @TC.132044 @bus @sync_version_management @tasks_p1
  Scenario: 132044 Partner without Edit User Group capability -- Sync Default is not displayed if it's Sync disabled
    When I use a existing partner:
      | company name                               | admin email                        | admin name       | partner type |
      | Internal Mozy - MozyPro with sync disabled | mozybus+joan+moreno+2337@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then there is no Sync rule in client rule fieldset

  @TC.132030 @bus @sync_version_management @tasks_p1
  Scenario: 132030 Upgrade to: Product partner can list the inherited version if not branded
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                   | admin email                           | admin name       | partner type |
      | Internal Mozy - MozyEnterprise product partner | mozyautotest+maria+white+0139@emc.com | Admin Automation | OEM          |
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       | "%1" /silent    |         |
    And there is version Windows Sync 10.10.10.10 in Update to list

  @TC.131403 @bus @sync_version_management @tasks_p1
  Scenario: 131403 Sync client can not be downloaded if sync is not enabled
    When I use a existing partner:
      | company name                               | admin email                        | admin name       | partner type |
      | Internal Mozy - MozyPro with sync disabled | mozybus+joan+moreno+2337@gmail.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I should not see Sync Clients download info

  @TC.131405 @bus @sync_version_management @tasks_p1
  Scenario: 131405 Product partner can download sync executable upload in Mozy,Inc if it has no branded executables
    When I use a existing partner:
      | company name                                   | admin email                           | admin name       | partner type |
      | Internal Mozy - MozyEnterprise product partner | mozyautotest+maria+white+0139@emc.com | Admin Automation | OEM          |
    And I navigate to bus admin console login page
    Then I log in bus admin console as new partner admin
    And I navigate to Download * Client section from bus admin console page
    Then I can find client download info of platform Windows in Sync Clients part:
      | WinSyncTestVersion 10.10.10.10 |
    When I view Details for client WinSyncTestVersion 10.10.10.10
    Then I should see download link for MozyEnterprise-sync-10_10_10_10
    When I clear downloads folder
    And I click download link for MozyEnterprise-sync-10_10_10_10
    Then client started downloading successfully
    When I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinSyncClient.exe

  @TC.126245 @bus @sync_version_management @tasks_p1
  Scenario: 126245 Upgrade to: Drop down list version >= forced upgrade rules version in parent partner
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.11 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                            | platform | version number | notes                                              |
      | WinSyncTestVersion 10.10.10.11  | win-sync | 10.10.10.11    | This is a test version for BUS version management. |
    Then the client version should be created successfully
    When I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.11
    And I click Brandings tab of version details
    And I upload executable FakeWinSyncClient2.exe for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner MozyEnterprise should be generated
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    And I close version details section

    When I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.9 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name                          | platform | version number | notes                                              |
      | WinSyncTestVersion 10.10.10.9 | win-sync | 10.10.10.9     | This is a test version for BUS version management. |
    Then the client version should be created successfully
    When I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.9
    And I click Brandings tab of version details
    And I upload executable FakeWinSyncClient3.exe for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner MozyEnterprise should be generated
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully
    And I close version details section

    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then there is version Windows Sync 10.10.10.9 in Update to list
    And there is version Windows Sync 10.10.10.10 in Update to list
    And there is version Windows Sync 10.10.10.11 in Update to list

    When I log in bus admin console as administrator
    And I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | Y    | Y   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      | "%1" /silent    |         |
    And there is no version Windows Sync 10.10.10.9 in Update to list
    And there is version Windows Sync 10.10.10.10 in Update to list
    And there is version Windows Sync 10.10.10.11 in Update to list

    When I log in bus admin console as administrator
    And I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists

  @TC.126195 @TC.126196 @bus @sync_version_management @tasks_p1
  Scenario: 126195 126196 Client Version Rules: Upgrade rules show up in sub-partner when there is no override rule. Client Version Rules: Only Force Upgrade rules show up in sub-partner when there is override rule
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    When I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | N    | N   | 0.0.0.1     | 0.0.0.2     |              |

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Windows Sync 10.10.10.10 if it exists
    And I delete client version rule for Windows Sync 10.10.10.11 if it exists
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 |         |
    When I add a new rule in Edit Client Version:
      | Update To                |  User Group     | Current Version  | Required |
      | Windows Sync 10.10.10.11 | All User Groups | Any version      | No       |
    Then Client Version Rules should not include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 |         |

    When I log in bus admin console as administrator
    And I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    When I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | Y    | Y   | 0.0.0.1     | 0.0.0.2     |              |

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Windows Sync 10.10.10.10 if it exists
    And I delete client version rule for Windows Sync 10.10.10.11 if it exists
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      |                 |         |
    When I add a new rule in Edit Client Version:
      | Update To                |  User Group     | Current Version  | Required |
      | Windows Sync 10.10.10.11 | All User Groups | Any version      | No       |
    Then Client Version Rules should include rule:
      | Update To                | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Windows Sync 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | Yes      |                 |         |
      | Windows Sync 10.10.10.11 | All User Groups | Any version             | Any | No       |                 | Remove  |
    And I delete client version rule for Windows Sync 10.10.10.10 if it exists
    And I delete client version rule for Windows Sync 10.10.10.11 if it exists

    When I log in bus admin console as administrator
    And I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists

  @TC.126181 @TC.126182 @bus @sync_version_management @tasks_p1
  Scenario: 126181 Other Releases link of backup client should show up correctly 126182 The downloaded backup client version should be correct
    When I act as partner by:
      | name           | including sub-partners |
      | MozyEnterprise | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version WinSyncTestVersion 10.10.10.10 if it exists
    Then I add a new upgrade rule:
      | version name                   | Req? | On? | min version | max version | Install CMD  |
      | WinSyncTestVersion 10.10.10.10 | N    | N   | 0.0.0.1     | 0.0.0.2     | "%1" /silent |

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Windows in Sync Clients part:
      | MozyEnterprise WinSyncTestVersion 10.10.10.10|
    When I view Details for client MozyEnterprise WinSyncTestVersion 10.10.10.10
    Then the version detail info should be:
      | Download:                                 | MD5:                   | Date:  |
      | MozyEnterprise-sync-10_10_10_10-XXXXX.exe | FakeWinSyncClient.exe  | @today |
    And I view Details for client MozyEnterprise WinSyncTestVersion 10.10.10.10
    When I view Other Releases for client MozyEnterprise WinSyncTestVersion 10.10.10.10
    Then I can see version MozyEnterprise WinSyncTestVersion 10.10.10.9 in Older Releases
    And the version detail info MozyEnterprise WinSyncTestVersion 10.10.10.9 should be:
      | Download:                                 | MD5:                    | Date:  |
      | MozyEnterprise-sync-10_10_10_9-XXXXX.exe  | FakeWinSyncClient3.exe  | @today |
    And I can see version MozyEnterprise WinSyncTestVersion 10.10.10.11 in Upcoming Releases
    And the version detail info MozyEnterprise WinSyncTestVersion 10.10.10.11 should be:
      | Download:                                 | MD5:                    | Date:  |
      | MozyEnterprise-sync-10_10_10_11-XXXXX.exe | FakeWinSyncClient2.exe  | @today |
    When I clear downloads folder
    And I visit BUS download link for MozyEnterprise-syncsetup.exe
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinSyncClient.exe
    And I clear downloads folder

    When I log in bus admin console as administrator
    And I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to disabled
    Then version info should be changed successfully

    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I can find client download info of platform Windows in Sync Clients part:
      | MozyEnterprise WinSyncTestVersion 10.10.10.11 |
    When I view Other Releases for client MozyEnterprise WinSyncTestVersion
    Then I can see version MozyEnterprise WinSyncTestVersion 10.10.10.9 in Older Releases
    And I can not see version MozyEnterprise WinSyncTestVersion 10.10.10.10 in Older Releases
    When I visit BUS download link for MozyEnterprise-syncsetup.exe
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeWinSyncClient2.exe

    When I log in bus admin console as administrator
    And I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    Then version info should be changed successfully


  @TC.131357 @bus @sync_version_management @tasks_p1
  Scenario: 131357 Sync client version can be deleted
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.10 if it exists
    And I should not see version 10.10.10.10 in version list

  @clean_up
  Scenario: clean up all windows test versions
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | win-sync | true          |
    And I delete version 10.10.10.9 if it exists
    And I delete version 10.10.10.10 if it exists
    And I delete version 10.10.10.11 if it exists
