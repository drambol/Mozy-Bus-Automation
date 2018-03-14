Feature: login as admins

  Background:
    Given I log in bus admin console as administrator

  @TC.121959 @bus @admin @tasks_p1 @ldap_sequence
  Scenario: 121959 Root admin deleting admin should not require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc121959.user1 | tc121959.user1@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121959.user2 | tc121959.user2@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121959.user3 | tc121959.user3@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121959.user4 | tc121959.user4@mtdev.mozypro.local |
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule              | group                |
      | cn=tc121959.user* | (default user group) |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 4 succeeded, 0 failed \| Users Deprovisioned: 0  |
    When I navigate to Search / List Users section from bus admin console page
    And I sort user search results by User desc
    Then User search results should be:
      | User                               | Name           | User Group           |
      | tc121959.user4@mtdev.mozypro.local | tc121959.user4 | (default user group) |
      | tc121959.user3@mtdev.mozypro.local | tc121959.user3 | (default user group) |
      | tc121959.user2@mtdev.mozypro.local | tc121959.user2 | (default user group) |
      | tc121959.user1@mtdev.mozypro.local | tc121959.user1 | (default user group) |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              |
      | tc121959.user1 | tc121959.user1@mtdev.mozypro.local |
    Then Add New Admin success message should be displayed
    And I view the admin details of tc121959.user1
    When I delete admin with default password
    And I search admin by:
      | name           |
      | tc121959.user1 |
    Then I should not search out admin record
    And I navigate to Authentication Policy section from bus admin console page
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule              | action |
      | cn=tc121959.user* | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I delete a user tc121959.user4 in the AD
    And I delete a user tc121959.user3 in the AD
    And I delete a user tc121959.user2 in the AD
    And I delete a user tc121959.user1 in the AD

  @TC.121965 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121965 LDAP admin changing auth type should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc121965.user1 | tc121965.user1@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121965.user2 | tc121965.user2@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121965.user3 | tc121965.user3@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121965.user4 | tc121965.user4@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule              |
      | cn=tc121965.user* |
    And I click the sync now button
    And I wait for 90 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\) |
      | Sync Result | Users Provisioned: 4 succeeded, 0 failed \| Users Deprovisioned: 0  |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc121965.user1 | tc121965.user1@mtdev.mozypro.local | (default user group) | FedID role |
    When I refresh Add New Admin section
    And I add a new admin:
      | Name           | Email                              | User Group           | Roles      |
      | tc121965.user2 | tc121965.user2@mtdev.mozypro.local | (default user group) | FedID role |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc121965.user1 and password AD user default password
    Then I login as tc121965.user1 admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I choose LDAP Push as Directory Service provider without saving
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    And I use Mozy as authentication provider without saving
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    When I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I save the changes with password default password
    Then The save error message should be:
      | Save failed         |
      | Incorrect password. |
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc121965.user1@mtdev.mozypro.local |
    And I delete admin by:
      | email                              |
      | tc121965.user2@mtdev.mozypro.local |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule              | action |
      | cn=tc121965.user* | Delete |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I delete a user tc121965.user4 in the AD
    And I delete a user tc121965.user3 in the AD
    And I delete a user tc121965.user2 in the AD
    And I delete a user tc121965.user1 in the AD

  @TC.121966 @bus @admin @tasks_p1 @ldap_sequence @smoke @subdomain
  Scenario: 121966 LDAP admin deleting admin should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc121966.user1 | tc121966.user1@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc121966.user3 | tc121966.user3@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc121966.user3 | tc121966.user3@mtdev.mozypro.local | (default user group) | FedID role |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc121966.user3 and password AD user default password
    Then I login as tc121966.user3 admin successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc121966.user1 | tc121966.user1@mtdev.mozypro.local | (default user group) | FedID role |
    When Ldap admin delete admin by:
      | email                              |
      | tc121966.user1@mtdev.mozypro.local |
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    And I refresh Search Admins section
    Then I should not search out admin record
    And I delete a user tc121966.user3 in the AD
    And I delete a user tc121966.user1 in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc121966.user3@mtdev.mozypro.local |

  @TC.121967 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121967 LDAP admin deleting partner should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc121967.user1 | tc121967.user1@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc121967.user1 | tc121967.user1@mtdev.mozypro.local | (default user group) | FedID role |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.121967 |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc121967.user1 and password AD user default password
    Then I login as tc121967.user1 admin successfully
    And I search partner by:
      | email                                | filter |
      | <%=@subpartner.admin_email_address%> | None   |
    And I view partner details by sub_partner_TC.121967
    And LDAP admin delete partner
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    When I navigate to old window
    And I wait for 3 seconds
    And I refresh Search List Partners section
    Then Partner search results should be empty
    And I delete a user tc121967.user1 in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc121967.user1@mtdev.mozypro.local |

  @TC.121961 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121961 Root admin deleting partner should not require AD re-auth
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I check enable sso for admins to log in with their network credentials
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.121961 |
    And I search partner by:
      | email                                | filter |
      | <%=@subpartner.admin_email_address%> | None   |
    When I delete subpartner accountdefault password
    And I refresh Search List Partners section
    Then Partner search results should be empty

  @TC.121962 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121962 Root admin changing auth type should not require AD re-auth
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I check enable sso for admins to log in with their network credentials
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I choose LDAP Push as Directory Service provider without saving
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I use Mozy as authentication provider without saving
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    When I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully

############################################################################

  # LDAP push

############################################################################

  @TC.122047 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 122047 LDAP Push admin deleting partner should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc122047.user1 | tc122047.user1@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc122047.user1 | tc122047.user1@mtdev.mozypro.local | (default user group) | FedID role |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.122047 |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc122047.user1 and password AD user default password
    Then I login as tc122047.user1 admin successfully
    And I search partner by:
      | email                                | filter |
      | <%=@subpartner.admin_email_address%> | None   |
    And I view partner details by sub_partner_TC.122047
    And LDAP admin delete partner
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    When I navigate to old window
    And I wait for 3 seconds
    And I refresh Search List Partners section
    Then Partner search results should be empty
    And I delete a user tc122047.user1 in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc122047.user1@mtdev.mozypro.local |

  @TC.122048 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 122048 LDAP Push admin deleting admin should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc122048.user1 | tc122048.user1@mtdev.mozypro.local |
    And I add a user to the AD
      | user name      | mail                               |
      | tc122048.user3 | tc122048.user3@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc122048.user3 | tc122048.user3@mtdev.mozypro.local | (default user group) | FedID role |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc122048.user3 and password AD user default password
    Then I login as tc122048.user3 admin successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc122048.user1 | tc122048.user1@mtdev.mozypro.local | (default user group) | FedID role |
    When Ldap admin delete admin by:
      | email                              |
      | tc122048.user1@mtdev.mozypro.local |
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    And I refresh Search Admins section
    Then I should not search out admin record
    And I delete a user tc122048.user3 in the AD
    And I delete a user tc122048.user1 in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc122048.user3@mtdev.mozypro.local |

  @TC.122049 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 122049 LDAP Push admin changing auth type should require AD re-auth
    When I add a user to the AD
      | user name      | mail                               |
      | tc122049.user1 | tc122049.user1@mtdev.mozypro.local |
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes with password default password
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Email                              | User Group           | Roles      |
      | tc122049.user1 | tc122049.user1@mtdev.mozypro.local | (default user group) | FedID role |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name tc122049.user1 and password AD user default password
    Then I login as tc122049.user1 admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    And I choose LDAP Push as Directory Service provider without saving
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    And I use Mozy as authentication provider without saving
    And I save the changes which will need re auth
    And I navigate to new window
    Then I sign in the subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to old window
    And I wait for 3 seconds
    Then Authentication Policy has been updated successfully
    When I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I save the changes with password default password
    Then The save error message should be:
      | Save failed         |
      | Incorrect password. |
    And I delete a user tc122049.user1 in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                              |
      | tc122049.user1@mtdev.mozypro.local |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully

