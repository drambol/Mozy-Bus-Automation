Feature: sync status

  Background:
    Given I log in bus admin console as administrator

  @TC.131006 @TC.131005 @TC.121634 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 131006 131005 check help link after sync AD user
    Given I delete a user tc131006.user1 in the AD
    # step1 - add one users in AD server
    When I add a user to the AD
    | user name      |
    | tc131006.user1 |
    # step2 - create a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
    | period | users | server plan | root role  |
    | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    # step3 - partner setting
    When I add partner settings
    | Name                    | Value | Locked |
    | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step4 - Authentication Ploicy/Connection Settings
    When I navigate to Authentication Policy section from bus admin console page
    Then I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
    | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
    | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step5 - check <Send Welcome Email>, sync rules.
    When I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
    | rule              | group                |
    | cn=tc131006.user1 | (default user group) |
    Then I save the changes with password default password
    And Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 90 seconds
    # step6 - verify the users are provisioned by partner A successfully
    Given I monitor the sync result and restart bds-boot service if sync failed
    When The sync status result should like:
    | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
    | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0  |
    # step7 - help lin is invisible
    Then help link is invisible
    # step8 - logout
    And I log out bus admin console
    And I log in bus admin console as administrator
    # ============================================================
    # step9 - create a new parter B
    When I add a new MozyEnterprise partner:
    | period | users | server plan | root role  |
    | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    # step10 - partner setting
    When I add partner settings
    | Name                    | Value | Locked |
    | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    Then I log in bus admin console with user name @partner.admin_info.email and password default password
    # step11 - Authentication Ploicy/Connection Settings
    When I navigate to Authentication Policy section from bus admin console page
    Then I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I click Connection Settings tab
    And I input server connection settings
    | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
    | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step12 - check <Send Welcome Email>, sync rules.
    When I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
    | rule              | group                |
    | cn=tc131006.user1 | (default user group) |
    Then I save the changes with password default password
    And Authentication Policy has been updated successfully
    And I click Sync Rules tab
    # step13 - restart bds-root due to a known issue as workaround
    #          click sync know button to provision new user with the same rule
    #Given I restart bds-boot service
    Then I wait for 30 seconds
    And I click Sync Rules tab
    And I click the sync now button
    Given I wait for 90 seconds
    When I click Connection Settings tab
    And I refresh the authentication policy section
    # step14 - download the csv and verify the error message
    And I click Details link to download csv file
    Then the download LDAP_object_list csv file should be like:
      | Column A                                       | Column B    |
      | provision                                      | failed_list |
      | CN=tc131006.user1,DC=mtdev,DC=mozypro,DC=local | {"message"=>"Validation failed: Username An account with email address \"<%=@AD_User_Emails["tc131006.user1"]>\" already exists"}  |
    # step15 - verify the help link is visible and access support page by clicking the link
    Then help link is visible
    And I click help link
    And I access help page successfully

  @TC.133922 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 133922 Admin will get notification email if sync failed due to LDAP Connection Failed
    # step1 - create a partner
    Given I delete a user tc133922.user1 in the AD
    # step1 - add one users in AD server
    When I add a user to the AD
      | user name      |
      | tc133922.user1 |
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    Then I act as newly created partner account
    # step2 - set Directory Service settings, invalid server host
    When I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.121 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    # step3 - add new rule
    And I check enable sso for admins to log in with their network credentials
    When I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule              | group                |
      | cn=tc133922.user1 | (default user group) |
    Then I save the changes with password default password
    And Authentication Policy has been updated successfully
    # step4 - wait for few seconds and sync, verify the sync result
    #Given I restart bds-boot service
    When I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    And I click Connection Settings tab
    And I refresh the authentication policy section
    Then The sync status result should like:
      | Sync Status | Failed at %m/%d/%y %H:%M %:z \(duration about (\d+\.\d+ seconds*\|\d+ minutes*)\) |
      | Sync Result | Cannot connect to the LDAP server.                                                |
    # step5 - search email, the admin should get a email notification
    When I search emails by keywords:
      | to                             | subject                               |
      | <%=@partner.admin_info.email%> | MozyEnterprise LDAP Connection Failed |
    Then I should see 1 email(s)