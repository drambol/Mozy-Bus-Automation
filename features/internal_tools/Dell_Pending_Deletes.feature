Feature: delete partner without setting, Mozy Inc --> Fortress (BDS) --> MozyOEM --> Mozy Dell --> MozyPro/MozyEnterprise --> Customer Tenant L1 --> Customer Tenant L2

  Background:
    Given I log in bus admin console as administrator

  @TC.133703 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_01: Delete Dell MozyPro Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                            |
      | mozyprotestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type | Root Role |
      | testadmin  | MozyOntheBox | MozyPro   |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | storage_type | storage_limit | devices |
      | tc_144460_01_user | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to reset password
    And I activate linux machine using username newly created user email and password reset password
    Then linux machine activation message should be AUTHENTICATED

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
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

    When I activate linux machine using username newly created user email and password reset password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

  @TC.133704 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_02: Delete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    Then no report is scheduled for this partner

  @TC.133705 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_03: Delete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Company Name                   | Admin Name | Company Type |
      | TC.144460_02_03 parent partner | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to reset password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_02_03 parent partner
    And I view partner details by TC.144460_02_03 parent partner
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
    And Partner general information should be:
      | Status:         |
      | Active (change) |

    When I activate linux machine using username newly created user email and password reset password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

#Bugs #145101: Subpartner jobs is still active when pending delete a partner
    Then 0 report is scheduled for this partner

  @TC.133706 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_04: Delete Dell MozyEnterprise Customer Tenant L2, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |
    Then New partner should be created

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
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
    Then Partner general information should be:
      | Deleted: | Root Admin: |
      | today    | @root_admin |

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner

  @TC.133707 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_05: Undelete Dell MozyPro Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                            |
      | mozyprotestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type | Root Role |
      | testadmin  | MozyOntheBox | MozyPro   |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | storage_type | storage_limit | devices |
      | tc_144460_01_user | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then I will see the user account page

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully

  @TC.133708 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_06: Undelete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then I will see the user account page

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as @subpartner.company_name admin successfully

# Bugs #145100: Undelete partner not active jobs
    Then 1 report is scheduled for this partner

  @TC.133709 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_07: Undelete Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Company Name                   | Admin Name | Company Type |
      | TC.144460_02_07 parent partner | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details reset password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_02_07 parent partner
    And I view partner details by TC.144460_02_07 parent partner
    And I delete partner account

    When I navigate to Manage Pending Deletes section from bus admin console page
    And I change to 60 days to purge account after delete
    And I search partners in pending-delete not available to purge by:
      | name                           |
      | TC.144460_02_07 parent partner |
    And I undelete partner in pending-delete not available to purge by TC.144460_02_07 parent partner

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

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then I will see the user account page

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully

    Then 1 report is scheduled for this partner

  @TC.133711 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_09: Purge Dell MozyPro Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                            |
      | mozyprotestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type | Root Role |
      | testadmin  | MozyOntheBox | MozyPro   |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | storage_type | storage_limit | devices |
      | tc_144460_01_user | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

    When I stop masquerading
    And I search and delete partner account by newly created subpartner company name

    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Partner       | Created | Root Admin   | Type     | Request Date |
      | @partner_id | @company_name | today   | @admin_email | business | today        |
    And I purge partner by newly created subpartner company name
    And I search partners in who have been purged by:
      | name          |
      | @company_name |
    Then Partners in who have been purged search results should be:
      | ID          | Partner       | Created | Root Admin   | Type     | Request Date | Date Purged |
      | @partner_id | @company_name | today   | @admin_email | business | today        | today       |
    Then I change to 60 days to purge account after delete

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
    Then Partner general information should be:
      | Deleted: |
      | today    |

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Incorrect email or password.

  @TC.133712 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_10: Purge Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L1 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Admin Name | Company Type |
      | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED

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
      | ID          | Partner       | Created | Root Admin   | Type     | Request Date |
      | @partner_id | @company_name | today   | @admin_email | business | today        |
    And I purge partner by newly created subpartner company name
    And I search partners in who have been purged by:
      | name          |
      | @company_name |
    Then Partners in who have been purged search results should be:
      | ID          | Partner       | Created | Root Admin   | Type     | Request Date | Date Purged |
      | @partner_id | @company_name | today   | @admin_email | business | today        | today       |
    Then I change to 60 days to purge account after delete

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
    Then Partner general information should be:
      | Deleted: |
      | today    |

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner

  @TC.133713 @bus @delete_partner @qa12
  Scenario: Mozy-144460_02_11: Purge Dell MozyEnterprise Customer Tenant L1, check Customer Tenant L2 information
    When I act as partner by:
      | email                                   |
      | mozyenterprisetestonqa12@mozy.local.com |
    And I add a new sub partner:
      | Company Name                   | Admin Name | Company Type |
      | TC.144460_02_11 parent partner | testadmin  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I act as newly created subpartner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name         | Type          | Parent         |
      | new OEM role | Partner admin | MozyEnterprise |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Admin Name | Company Type |
      | subadmin1  | MozyOntheBox |
    Then New partner should be created
    And SubPartner general information should be:
      | Status:         |
      | Active (change) |
    And I change pooled resource for the subpartner:
      | Server Storage | Server Devices |
      | 1              | 2              |

    When I get the subpartner_id
    And I view the newly created subpartner admin details
    And I active admin in admin details default password

    When I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name

    When I act as newly created subpartner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_144460_01_user | (default user group) | Server       | 1             | 2       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by tc_144460_01_user
    And I update the user password to default password
    And I use keyless activation to activate devices
      | machine_name      | machine_type |
      | machine_144460_01 | Server      |
    Then activate machine result should be
      | code | body                                  |
      | 200  | {"license_key":"machine license key"} |
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    And 1 report is scheduled for this partner

    When I stop masquerading
    And I search partner by TC.144460_02_11 parent partner
    And I view partner details by TC.144460_02_11 parent partner
    And I delete partner account

    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name                           |
      | TC.144460_02_11 parent partner |
    And I purge partner by TC.144460_02_11 parent partner
    And I change to 60 days to purge account after delete

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
    Then Partner general information should be:
      | Deleted: |
      | today    |

    When I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be Invalid credentials.  Re-enter your account information.

    When I navigate to user login page with partner ID oem.partners.com
    And I log in bus admin console with user name @new_users[0].email and password default password
    Then Login page error message should be Incorrect email or password.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then Login page error message should be Incorrect email or password.

    Then no report is scheduled for this partner
