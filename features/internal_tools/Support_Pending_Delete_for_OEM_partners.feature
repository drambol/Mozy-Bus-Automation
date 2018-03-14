Feature: delete partner, Mozy Inc --> Fortress (BDS) --> MozyOEM --> Partner Root --> Partner L1 --> Partner L2 --> Partner L3

  Background:
    Given I log in bus admin console as administrator

  @TC.133692 @bus @delete_partner
  Scenario: Mozy-144460_01: Delete MozyPro Partner Root, check Partner Root information
    When I check that linux client service is available
    And I upload change linux client env script to remote machine
    When I add a new MozyPro partner:
      | period | base plan | server plan |
      | 1      | 250 GB    | yes         |
    And New partner should be created
    And Partner general information should be:
      | Status:         |
      | Active (change) |

    When I get partner aria id
    And I get the partner_id
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    And I act as newly created partner

    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 100           | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED
    #And I use keyless activation to activate devices
    #  | machine_name      | machine_type |
    #  | machine_144460_01 | Desktop      |
    #Then activate machine result should be
    #  | code | body                                  |
    #  | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created partner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.
    #When I use keyless activation to activate devices unsuccessful
    #  | machine_name      | machine_type |
    #  | machine_144460_01 | Desktop      |
    #Then activate machine result should be
    #  | code | body                 |
    #  | 401  | ERROR: invalid token |

    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |
    When I search partner by newly created partner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created partner company name
    Then Partner general information should be:
      | Pending | Root Admin: |
      | today   | @root_admin |

    When I navigate to user login page with partner ID
    And I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I log in bus admin console as administrator
    And I move backwards account billing dates 1 month for newly created partner aria id
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $110.98 | $110.98    | $0.00       |

    Then no report is scheduled for this partner

  @TC.133693 @bus @delete_partner
  Scenario: Mozy-144460_02: Delete OEM Partner Root, check Partner Root information
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_02_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_02_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |

    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Pending | Root Admin: |
      | today   | @root_admin |

#    When I use key activation to activate devices
#      | machine_name      |
#      | machine_144460_02 |
#    Then Activate key response should be ERROR: invalid token

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    Then no report is scheduled for this partner

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)

  @TC.133694 @bus @delete_partner
  Scenario: Mozy-144460_03: Delete OEM Partner, check next renewal
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    When I get partner aria id

    And I move backwards account billing dates 1 month for newly created partner aria id
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $94.99    | $94.99     | $0.00       |

  @TC.133695 @bus @delete_partner
  Scenario: Mozy-144460_04: Delete OEM Partner Root, check Partner L1 information
    When I add a new OEM partner:
      | Company Name                | Root role         | Security | Company Type     |
      | TC.144460_04 parent partner | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Pricing Plan | Admin Name |
      | subplan      | subadmin1  |
    Then New partner should be created

    When I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_04_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_04_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_04 parent partner
    And I view partner details by TC.144460_04 parent partner
    And I delete partner account

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then I should see No results found in pending-delete not available to purge table

    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by newly created subpartner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Status:         |
      | Active (change) |

#    When I use key activation to activate devices
#      | machine_name      |
#      | machine_144460_04 |
#    Then Activate key response should be ERROR: invalid token

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    Then no report is scheduled for this partner

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)

  @TC.133696 @bus @delete_partner
  Scenario: Mozy-144460_05: delete OEM Partner L1, check Partner L1 information
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Pricing Plan | Admin Name |
      | subplan      | subadmin1  |
    Then New partner should be created

    When I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_05_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_05_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I should see No results found in pending-delete not available to purge table

    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    And Partner general information should be:
      | Deleted: | Root Admin: |
      | today    | @root_admin |

    When I use key activation to activate devices
      | machine_name      |
      | machine_144460_05 |
    Then Activate key response should be ERROR: COULD NOT FIND KEY

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)

  @TC.133697 @bus @delete_partner
  Scenario: Mozy-144460_06: Undelete OEM Partner Root, check Partner Root information, undelete not ready to purge, ready to purge
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_06_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_06_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I change to 60 days to purge account after delete
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    And I undelete partner in pending-delete not available to purge by newly created subpartner company name

    When I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I should see No results found in pending-delete not available to purge table

    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by newly created subpartner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    And Partner general information should be:
      | Status:         |
      | Active (change) |

    When I use key activation to activate devices
      | machine_name      |
      | machine_144460_06 |
    Then Activate key response should be OK

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then I will see the user account page

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as @subpartner.company_name admin successfully

    Then 1 report is scheduled for this partner

#    bugs: delete partner will suspend jobs, but undelete will not unsuspend jobs, no email was sent
#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 1 email(s)

  @TC.133698 @bus @delete_partner
  Scenario: Mozy-144460_07: Undelete OEM Partner Root, check Partner L1 information
    When I add a new OEM partner:
      | Company Name                | Root role         | Security | Company Type     |
      | TC.144460_07 parent partner | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Pricing Plan | Admin Name |
      | subplan      | subadmin1  |
    Then New partner should be created

    When I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    When I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_07_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_07_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_07 parent partner
    And I view partner details by TC.144460_07 parent partner
    And I delete partner account

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I change to 60 days to purge account after delete
    And I search partners in pending-delete not available to purge by:
      | name                        |
      | TC.144460_07 parent partner |
    And I undelete partner in pending-delete not available to purge by TC.144460_07 parent partner

    When I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I should see No results found in pending-delete not available to purge table

    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    When I search partner by newly created subpartner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    And Partner general information should be:
      | Status:         |
      | Active (change) |

    When I use key activation to activate devices
      | machine_name      |
      | machine_144460_07 |
    Then Activate key response should be OK

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then I will see the user account page

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully

    Then 1 report is scheduled for this partner

#    bugs: delete partner will suspend jobs, but undelete will not unsuspend jobs, no email was sent
#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 1 email(s)

  @TC.133700 @bus @delete_partner
  Scenario: Mozy-144460_09: Purge OEM Partner Root, check Partner Root information
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     |
      | oem user |
    Then new itemized user should be created
    When I search user by:
      | name     | email                      |
      | oem user | tc_144460_09_user@mozy.com |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_09_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Partner       | Created | Root Admin   | Type | Request Date |
      | @partner_id | @company_name | today   | @admin_email | oem  | today        |
    And I purge partner by newly created subpartner company name
    And I search partners in who have been purged by:
      | name          |
      | @company_name |
    Then Partners in who have been purged search results should be:
      | ID          | Partner       | Created | Root Admin   | Type | Request Date | Date Purged |
      | @partner_id | @company_name | today   | @admin_email | oem  | today        | today       |
    Then I change to 60 days to purge account after delete

    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
#    When I search partner by:
#      | name          | filter         |
#      | @company_name | Pending Delete |
#    Then Partner search results should not be:
#      | Partner       |
#      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Deleted: |
      | today    |

    When I use key activation to activate devices
      | machine_name      |
      | machine_144460_09 |
    Then Activate key response should be ERROR: COULD NOT FIND KEY

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)

  @TC.133701 @bus @delete_partner
  Scenario: Mozy-144460_10: Purge OEM Partner Root, check Partner L1 information
    When I add a new OEM partner:
      | Company Name                | Root role         | Security | Company Type     |
      | TC.144460_10 parent partner | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent            |
      | new OEM role | Partner admin | OEM Partner Admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for OEM partner:
      | Name    | Company Type | Root Role    | Enabled | Public | Currency | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes | Grandfathered Price per key | Grandfathered Min keys | Grandfathered Price per gigabyte | Grandfathered Min gigabytes |
      | subplan | business     | new OEM role | Yes     | No     |          | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     | 1                           | 1                      | 1                                | 1                           |
    And I add a new sub partner:
      | Pricing Plan | Admin Name |
      | subplan      | subadmin1  |
    Then New partner should be created

    When I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I get the partner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I set product name for the partner
    And I navigate to old window

    When I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 2               | 20            | 2              | 20           |
    Then Resources should be purchased

    And I add new itemized user(s):
      | name     | email                      |
      | oem user | tc_144460_10_user@mozy.com |
    Then new itemized user should be created
    When I search user by:
      | name     |
      | oem user |
    And I view user details by oem user
    And I update the user password to reset password
    And I navigate to Assign Keys section from bus admin console page
    And I assign Desktop key to user tc_144460_10_user@mozy.com on (default user group)

    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_10 parent partner
    And I view partner details by TC.144460_10 parent partner
    And I delete partner account

    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name                        |
      | TC.144460_10 parent partner |
    And I purge partner by TC.144460_10 parent partner
    And I change to 60 days to purge account after delete

    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
#    When I search partner by:
#      | name          | filter         |
#      | @company_name | Pending Delete |
#    Then Partner search results should not be:
#      | Partner       |
#      | @company_name |
    When I search partner by:
      | name          | filter  |
      | @company_name | Deleted |
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    When I view partner details by newly created subpartner company name
    Then Partner general information should be:
      | Deleted: |
      | today    |

    When I use key activation to activate devices
      | machine_name      |
      | machine_144460_10 |
    Then Activate key response should be ERROR: COULD NOT FIND KEY

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner

#    When I wait for 86460 seconds
#    And I search emails by keywords:
#      | to               | content           |
#      | @new_admin_email | <%=@report.name%> |
#    Then I should see 0 email(s)
