Feature: sync rules

  Background:
    Given I log in bus admin console as administrator

  @TC.131019 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 131019 Newly synced user in no oem partner should receive welcome email
    Given I delete a user tc131019.user1 in the AD
    Given I delete a user tc131019.user2 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131019.user1 |
    And I add a user to the AD
      | user name      |
      | tc131019.user2 |
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
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - Sync Rules setting  ~ check <Send Welcome Email>
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 2 new provision rules:
      | rule                                   | group                |
      | cn=tc131019.user1                      | (default user group) |
      | mail=@AD_User_Emails["tc131019.user2"] | (default user group) |
    And I check Send Welcome email to new users checkbox
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    #click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    #Then I monitor the sync result and restart bds-boot service if sync failed
    # step 7 - check the users are provisioned successfully
    And I wait for 90 seconds
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131019.user1"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131019.user2"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I delete a user tc131019.user1 in the AD
    And I delete a user tc131019.user2 in the AD


  @TC.131021 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 131021 Newly synced user without welcome email setting should not receive welcome email
    Given I delete a user tc131021.user1 in the AD
    Given I delete a user tc131021.user2 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131021.user1 |
    And I add a user to the AD
      | user name      |
      | tc131021.user2 |
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
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - Sync Rules setting ~ uncheck <Send Welcome Email>
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 2 new provision rules:
      | rule                                   | group                |
      | cn=tc131021.user1                      | (default user group) |
      | mail=@AD_User_Emails["tc131021.user2"] | (default user group) |
    And I uncheck Send Welcome email to new users checkbox
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    #click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    Then I monitor the sync result and restart bds-boot service if sync failed
    # step 7 - check the users are provisioned successfully
    #And I wait for 90 seconds
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131021.user1"] | New Account Created on MozyEnterprise |
    Then I should see 0 email(s)
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131021.user2"] | New Account Created on MozyEnterprise |
    Then I should see 0 email(s)
    And I delete a user tc131021.user1 in the AD
    And I delete a user tc131021.user2 in the AD


  @TC.131023 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 131023 Existing synced user should not receive welcome email
    Given I delete a user tc131023.user1 in the AD
    Given I delete a user tc131023.user2 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131023.user1 |
    And I add a user to the AD
      | user name      |
      | tc131023.user2 |
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
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - Sync Rules setting ~ check <Send Welcome Email>
    And I click Sync Rules tab
    And I check enable synchronization safeguards in Sync Rules tab
    And I add 2 new provision rules:
      | rule                                   | group                |
      | cn=tc131023.user1                      | (default user group) |
      | mail=@AD_User_Emails["tc131023.user2"] | (default user group) |
    And I check Send Welcome email to new users checkbox
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    # click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    #Then I monitor the sync result and restart bds-boot service if sync failed
    # step 7 - add a new rule
    And I click Sync Rules tab
    And I check enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule                                   | group                |
      | cn=tc131023.user1                      | (default user group) |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    # step 8 - sync for the new rule
    # click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    # step 9 - check the received welcome email
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131023.user1"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I search emails by keywords:
      | to                                | subject                               |
      | @AD_User_Emails["tc131023.user2"] | New Account Created on MozyEnterprise |
    Then I should see 1 email(s)
    And I delete a user tc131023.user1 in the AD
    And I delete a user tc131023.user2 in the AD


  @TC.131010 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: 131010 ldap push partner can not use hourly sync
    # step1 - create a MozyEnterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    # step2 - partner setting
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    # step6 - hourly sync checkbox is unavailable
    When I choose LDAP Push as Directory Service provider without saving
    Then sync hourly checkbox is invisible


  @TC.131012 @bus @admin @ldap_sequence @tasks_p3
  Scenario: 131012 ldap pull partner can use hourly sync successfully
    Given I delete a user tc131012.user1 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131012.user1 |
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
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    Then I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - New sync rule
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule                                   | group                |
      | cn=tc131012.user1                      | (default user group) |
    And I save the changes with password default password

  @TC.131043 @bus @ldap_sequence @tasks_p3 @regression
  Scenario: Check whether the safeguard option presents
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    # step3 - partner setting
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    # step6 - verify the sync safeguard is visible
    And I click Sync Rules tab
    Then sync safeguards checkbox is visible
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully

  @TC.131057 @bus @ldap_sequence @qa12 @tasks_p3 @regression
  Scenario: approve safeguard warnings and validate the results
    Given I delete a user tc131057.user1 in the AD
    Given I delete a user tc131057.user2 in the AD
    # step1 - add two users in AD server
    When I add a user to the AD
      | user name      |
      | tc131057.user1 |
    And I add a user to the AD
      | user name      |
      | tc131057.user2 |
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
    Then I active admin in admin details default password
    And I log out bus admin console
    # step4 - relog in as new user
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    # step5 - Authentication Ploicy/Connection Settings
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    # step6 - provision two users via sync rule
    And I click Sync Rules tab
    And I check enable synchronization safeguards in Sync Rules tab
    And I add 1 new provision rules:
      | rule          | group                |
      | cn=tc131057.* | (default user group) |
    And I check Send Welcome email to new users checkbox
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    #click Sync Rule tab again.
    And I click Sync Rules tab
    And I click the sync now button
    And I wait for 60 seconds
    # step 7 - delete the provision sync rule
    Then I delete 1 provision rules
    # step 8 - add a new deprovision rule
    Then I add 1 new deprovision rules:
      | rule          | action |
      | cn=tc131057.* | Delete |
    And I save the changes
    # step 9 - deprovision
    When I click the sync now button
    And I wait for 90 seconds
    # step 10 - check the deprovision result
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)                                    |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 0 succeeded, 2 failed(Details \| Help) Blocked Deprovision|
    When I search emails by keywords:
      | to                             | subject                                     |
      | <%=@partner.admin_info.email%> | MozyEnterprise automated provisioning alert |
    Then I should see 1 email(s)
    # step 11 - click Blocked Deprovision link
    And I click Blocked Deprovision link
    And I approve rule  (cn=tc131057.*)
    When I click Sync Rules tab
    And I click the sync now button
    And I wait for 90 seconds
    And I click Connection Settings tab
    # step11 - chec the deprovision result again
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)                    |
      | Sync Result | Users Provisioned: 0 \| Users Deprovisioned: 2 succeeded, 0 failed Blocked Deprovision |