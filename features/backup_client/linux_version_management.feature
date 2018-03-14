Feature: As a Mozy Admin, I should be able to add new linux version and manage the version.

  Background:
    Given I log in bus admin console as administrator

  # It takes about 51s in qa6 if the version is not existed
  # It takes about 13m25s in qa6 if the version has executable uploaded (It will iterate all product partner when deleting a version with executable)
  @TC.122460 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 122460 create a new linux version in Mozy Inc
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
    And I navigate to Create New Version section from bus admin console page
    And I add a new client version:
      | name              | platform | arch    | version number | notes                                              |
      | LinuxTestVersion  | linux    | deb-32  | 10.10.10.10    | This is a test version for BUS version management. |
    Then the client version should be created successfully

  #It takes about 2m16s in qa6
  @TC.122465 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 122465 Linux client version can be listed in List Version view
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I should not see version 10.10.10.10 in version list
    When I list versions for:
      | platform | show disabled |
      | linux    | true         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status   |
      | 10.10.10.10 | linux     | LinuxTestVersion | disabled |

  #Jira BUS-9276. It sometimes fail in qa6, bus will return 500 error (timeout) in this section, while the client is uploaded successfully
  #It takes 2m3s in staging
  @TC.123296 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 123296 Linux client can be uploaded successfully for Mozy, Inc.
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click Brandings tab of version details
    And I upload executable FakeLinuxClient.deb for partner Mozy, Inc.
    And I upload executable FakeLinuxClient.deb for partner MozyPro
    And I upload executable FakeLinuxClient.deb for partner MozyEnterprise
    And I save changes for the version
    Then version info should be changed successfully
    And the download link for partner Mozy, Inc. should be generated
    And the download link for partner MozyPro should be generated
    And the download link for partner MozyEnterprise should be generated

  ##Jira BUS-9276. It sometimes fails in qa6, bus will return 500 error (timeout) in this section, while the version status will changed to enabled
  #It takes 2m3s in staging
  @TC.122462 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 122462 Linux client version can be enabled
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I view version details for 10.10.10.10
    And I click General tab of version details
    And I change version status to enabled
    And version info should be changed successfully
    When I list versions for:
      | platform | show disabled |
      | linux    | false         |
    Then I can find the version info in versions list:
      | Version     | Platform  | Name             | Status  |
      | 10.10.10.10 | linux     | LinuxTestVersion | enabled |

  #Jira BUS-9619. Create/update Upgrade Rules will get 500 error
  @TC.122544 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 122544 Create Auto upgrade rule for Linux client
    When I act as partner by:
      | name    | including sub-partners |
      | MozyPro | no                     |
    And I navigate to Upgrade Rules section from bus admin console page
    And I delete rule for version LinuxTestVersion if it exists
    Then I add a new upgrade rule:
      | version name      | Req? | On? | min version | max version |
      | LinuxTestVersion  | N    | Y   | 0.0.0.1     | 0.0.0.2     |

    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then Client Version Rules should include rule:
      | Update To                       | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Linux - 32 bit .deb 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 |         |
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists
    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122544.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.122544.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_122544 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | linux    | deb-32 | mozypro  | 0.0.0.2 |
    And I delete user
    Then client config should contains:
      | update-url                                      |
      | /downloads/mozypro-deb-32-10_10_10_10-XXXXX.deb |


  @TC.122559 @bus @linux_version_management @tasks_p1
  Scenario: 122559 Partner without Edit User Group capability -- have limited edit client version functionality
    When I use a existing partner:
      | company name                                          | admin email                            | admin name       | partner type |
      | Internal Mozy - MozyPro no edit user group capability | mozyautotest+wanda+chavez+1446@emc.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And the set default client version note should be:
    """
    Set a default client version if you wish to force your users to update to a particular version of the MozyPro software.
    """
    And upgrade rule should contains:
      | Windows Default: | Mac Default: | Linux - 32 bit .deb Default: | Windows Sync Default: | Mac Sync Default: |
      | auto-update      | auto-update  | auto-update                  | auto-update           | auto-update       |


  @TC.122561 @bus @linux_version_management @tasks_p1
  Scenario: 122521 Partner without Edit User Group cap: All client version in subpartner when there is no override rule
    When I use a existing partner:
      | company name                                          | admin email                            | admin name       | partner type |
      | Internal Mozy - MozyPro no edit user group capability | mozyautotest+wanda+chavez+1446@emc.com | Admin Automation | MozyPro      |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then upgrade rule should contains:
      | Linux - 32 bit .deb Default: |
      | auto-update                  |
    And I can see version Linux - 32 bit .deb 10.10.10.10 in option list for rule linux:deb-32

    When I add new user(s):
      | name           | storage_type | storage_limit | devices |
      | TC.122561.User | Server       | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.122561.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_122561 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | linux    | deb-32 | mozypro  | 0.0.0.2 |
    And I delete user
    Then client config should contains:
      | update-url                                      |
      | /downloads/mozypro-deb-32-10_10_10_10-XXXXX.deb |

  @TC.122549 @bus @linux_version_management @tasks_p1
  Scenario: 122549 Upgrade to: Partner without server license can't list Linux client version
    When I use a existing partner:
      | company name                                   | admin email                            | admin name       | partner type |
      | Internal Mozy - MozyPro without server license | mozyautotest+eric+ramirez+0519@emc.com | Admin Automation | MozyPro      |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then there is no Linux rule in client rule fieldset

    When I use a existing partner:
      | company name                                          | admin email                      | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise without server license | automation_test_partner@test.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    Then there is no rule for Linux - 32 bit .deb 10.10.10.10 in Client Version Rules
    And there is no version Linux - 32 bit .deb 10.10.10.10 in Update to list



  @TC.122553 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 122553 Client Version Rules: Create Auto update client version rule for Linux client
    When I use a existing partner:
      | company name                                                   | admin email                           | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise with edit user group capability | mozyautotest+sean+walker+1513@emc.com | Admin Automation | MozyEnterprise |
    And I get admin id of current partner from the database
    And I get partner id by admin email from database
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists

    When I add a new rule in Edit Client Version:
      | Update To                       | Current Version >= | Current Version <= | Required |
      | Linux - 32 bit .deb 10.10.10.10 | 0.0.0.1            | 0.0.0.2            | No       |
    Then Client Version Rules should include rule:
      | Update To                       | User Group      | Current Version         | OS  | Required | Install Command | Options |
      | Linux - 32 bit .deb 10.10.10.10 | All User Groups | 0.0.0.1 through 0.0.0.2 | Any | No       |                 | Remove  |

    When I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices |
      | TC.122553.User | (default user group) | Server       | 10            | 1       |
    Then 1 new user should be created
    When I search user by:
      | keywords    |
      | @user_email |
    And I view user details by TC.122553.User
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type | partner_id       |
      | Machine1_122553 | <%=@new_users.first.email%> | Server       | <%=@partner_id%> |
    When I got client config for the user machine:
      | user_name                   | machine                       | platform | arch   | codename       | version |
      | <%=@new_users.first.email%> | <%=@clients[0].machine_hash%> | linux    | deb-32 | MozyEnterprise | 0.0.0.2 |
    And I delete user
    Then client config should contains:
      | update-url                                             |
      | /downloads/MozyEnterprise-deb-32-10_10_10_10-XXXXX.deb |
    When I navigate to Edit Client Version section from bus admin console page
    And I delete client version rule for Linux - 32 bit .deb 10.10.10.10 if it exists


  # Precondition: (@TC.122544) No auto rule or auto rule defined in MozyPro is 10.10.10.10
  #
  @TC.123298 @bus @linux_version_management @tasks_p1 @ROR_smoke
  Scenario: 123298 Linux client can be downloaded successfully for none product partner
    When I use a existing partner:
      | company name                                            | admin email                         | admin name       | partner type |
      | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyPro Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: MozyPro LinuxTestVersion |
    When I clear downloads folder
    And I click download link for MozyPro LinuxTestVersion
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @TC.131413 @bus @linux_version_management @tasks_p1
  Scenario: 131413 Linux client can not be downloaded if the partner don't have server license
    When I use a existing partner:
      | company name                                          | admin email                      | admin name       | partner type   |
      | Internal Mozy - MozyEnterprise without server license | automation_test_partner@test.com | Admin Automation | MozyEnterprise |
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I navigate to Download MozyEnterprise Client section from bus admin console page
    Then I should not see Linux download info


  # Only automate part of 123391.
  # Disabling all linux version (except one only have Mozy,Inc uploaded) is not a necessary scenario in production
  @TC.123391 @bus @linux_version_management @tasks_p1
  Scenario: 123391 bds linux client can be download successfully for MozyOEM partner
    When I navigate to Download BDS Remote Backup Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: LinuxTestVersion |
    When I clear downloads folder
    And I view Details for client LinuxTestVersion
    And I click download link for bds-deb-32-10_10_10_10
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb
    
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I navigate to Download BDS Remote Backup Client section from bus admin console page
    Then I can find client download info of platform Linux in Backup Clients part:
      | 32 bit .deb: BDS Remote Backup LinuxTestVersion |
    When I clear downloads folder
    And I view Details for client BDS Remote Backup LinuxTestVersion
    And I click download link for bds-deb-32-10_10_10_10
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  @TC.123297 @bus @linux_version_management @tasks_p1
  Scenario: 123297 Check download links for bds linux client
    When I navigate to Download BDS Remote Backup Client section from bus admin console page
    And I clear downloads folder
    And I visit BUS download link for bds-deb-32setup.deb
    Then client started downloading successfully
    And I wait for client fully downloaded
    Then the downloaded client should be same as the uploaded file FakeLinuxClient.deb

  #@TC.124097 @bus @linux_version_management @tasks_p1 @qa12
  #Scenario: 124097 VMBU Client can be downloaded
  #  When I use a existing partner:
  #    | company name                                            | admin email                         | admin name       | partner type |
  #    | Internal Mozy - MozyPro with edit user group capability | mozybus+bonnie+perez+0110@gmail.com | Admin Automation | MozyPro      |
  #  And I navigate to bus admin console login page
  #  And I log in bus admin console as new partner admin
  #  And I navigate to Download MozyPro Client section from bus admin console page
  #  Then I should see download link for Download MozyPro vSphere Backup Software
  #  When I clear downloads folder
  #  And I click download link for Download MozyPro vSphere Backup Software
  #  Then client started downloading successfully

  @clean_up @ROR_smoke
  Scenario: clean up all linux test versions and rules
    When I navigate to List Versions section from bus admin console page
    And I list versions for:
      | platform | show disabled |
      | linux    | true          |
    And I delete version 10.10.10.10 if it exists
