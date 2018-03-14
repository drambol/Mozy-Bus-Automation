Feature: View edit admins details

  Background:
    Given I log in bus admin console as administrator

  ###############################################################################

  # Change Password Standard Hipaa

  ################################################################################
  @TC.12435 @bus @admin @tasks_p1 @smoke @ROR_smoke
  Scenario: 12435 Standard Login admin change sub-admins password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name        | Roles      | User Group           |
      | Admin_12435 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with default password
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I view admin details by:
      | name        |
      | Admin_12435 |
    And I change admin password to Standard password
    Then I can change admin password successfully
    And I log out bus admin console
    And I log in bus admin console with user name @admin.email and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admin.email and password Standard password
    Then I login as Admin_12435 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.12437 @bus @admin @tasks_p1
  Scenario: 12437:Masquerade admin change sub-admins password successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles |
      | Root  |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[0].name%> |
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[1].name%> |
    And I view admin details by:
      | email                 |
      | <%=@admins[0].email%> |
    And I get the admin id for admin 0 from admin details
    And I close the admin details section
    And I view admin details by:
      | email                 |
      | <%=@admins[1].email%> |
    And I get the admin id for admin 1 from admin details
    And the partner has activated the @admins[2].email account with default password
    And the partner has activated the @admins[0].email account with default password
    And I go to account
    And I act as admin by:
      | email                 |
      | <%=@admins[1].email%> |
    And I view admin details by:
      | email                 |
      | <%=@admins[2].email%> |
    And I change admin password to Standard password
    Then I can change admin password successfully
    And I get the action record from db table action_audits
      | effective_admin_id | action name                       |
      | <%=@admins[1].id%> | spartacus::admin::change_password |
    Then the record from action_audits table should be
      | effective_admin_type | actual_admin_id    | actual_admin_type |
      | Admin                | <%=@admins[0].id%> | Admin             |
    And the record from model_audits table should be
      | column_name  | table_name | action | be_changed_admin_email |
      | passwordhash | admins     | update | <%=@admins[2].email%>  |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I delete admin by:
      | email                 |
      | <%=@admins[0].email%> |

  @TC.12443 @bus @admin @tasks_p1
  Scenario: 12443 Login Admin doesnt change its own password successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles |
      | Root  |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | email                 |
      | <%=@admins[0].email%> |
    And I get the admin id for admin 0 from admin details
    And the partner has activated the <%=@admins[0].email%> account with default password
    And I go to account
    And I click admin name on the top right
    Then I change root admin password in Account Details from old password wrongpass to Hipaa password
    Then Account Details error message should be:
      """
      Incorrect password
      """
    And I get the action record from db table action_audits
      | actual_admin_id    | action name                         |
      | <%=@admins[0].id%> | spartacus::setting::change_password |
    And There is no model audits record for this action_audits action
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I delete admin by:
      | email                 |
      | <%=@admins[0].email%> |

  @TC.12462 @bus @admin @tasks_p1
  Scenario: 12462:The last Masquerade admin change sub-admins password successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles |
      | Root  |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[0].name%> |
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[1].name%> |
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[2].name%> |
    And I refresh Add New Admin section
    And I add a new admin:
      | Roles | Parent               |
      | Root  | <%=@admins[3].name%> |
    And I view admin details by:
      | email                 |
      | <%=@admins[0].email%> |
    And I get the admin id for admin 0 from admin details
    And I close the admin details section
    And I view admin details by:
      | email                 |
      | <%=@admins[3].email%> |
    And I get the admin id for admin 3 from admin details
    And the partner has activated the <%=@admins[4].email%> account with default password
    And the partner has activated the <%=@admins[0].email%> account with default password
    And I go to account
    And I act as admin by:
      | email                 |
      | <%=@admins[1].email%> |
    And I act as admin by:
      | email                 |
      | <%=@admins[2].email%> |
    And I act as admin by:
      | email                 |
      | <%=@admins[3].email%> |
    And I view admin details by:
      | email                 |
      | <%=@admins[4].email%> |
    And I change admin password to Standard password
    Then I can change admin password successfully
    And I get the action record from db table action_audits
      | effective_admin_id | action name                       |
      | <%=@admins[3].id%> | spartacus::admin::change_password |
    Then the record from action_audits table should be
      | effective_admin_type | actual_admin_id    | actual_admin_type |
      | Admin                | <%=@admins[0].id%> | Admin             |
    And the record from model_audits table should be
      | column_name  | table_name | action | be_changed_admin_email |
      | passwordhash | admins     | update | <%=@admins[4].email%>  |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I delete admin by:
      | email                  |
      | <%=@admins[0].email%>  |

  @TC.123367 @bus @admin @tasks_p1
  Scenario: 123367 Hippa Login admin change sub-admins password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms | security |
      | 24     | 3     | 12 TB       | FedID role | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123367 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I login as mozypro admin successfully
    And I view admin details by:
      | name         |
      | Admin_123367 |
    And I change admin password to reset password
    Then I can change admin password successfully
    And I log out bus admin console
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123367 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123367 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123371 @bus @admin @tasks_p1
  Scenario: 123371 Hipaa Masquerade admin change sub-admins password successfully
    When I add a new MozyPro partner:
      | period | base plan | net terms | security |
      | 24     | 10 GB     | yes       | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123371 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I login as mozypro admin successfully
    And I view the admin details of Admin_123371
    And I change admin password to reset password
    Then I can change admin password successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123371 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123371 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123373 @bus @admin @tasks_p1
  Scenario: 123373 Hipaa The last Masquerade admin can change sub-admins password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 24     | 3     | 12 TB       | FedID role | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Roles      | User Group           |
      | Admin_123373_1 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Roles       | Parent               |
      | Admin_123373_2 | FedID role  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Roles       | Parent               |
      | Admin_123373_3 | FedID role  | <%=@admins[1].name%> |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@admins[2].email%> account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I act as admin by:
      | email                 |
      | <%=@admins[0].email%> |
    And I act as admin by:
      | email                 |
      | <%=@admins[1].email%> |
    And I view admin details by:
      | email                 |
      | <%=@admins[2].email%> |
    And I change admin password to reset password
    Then I can change admin password successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123373_3 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123373_3 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123374 @bus @admin @tasks_p1
  Scenario: 123374 Hipaa Masquerade Admin didnt change its own password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security | net terms |
      | 12     | 1     | 12 TB       | FedID role | HIPAA    | yes       |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123374 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I act as admin by:
      | name         |
      | Admin_123374 |
    And I click admin Admin_123374 on the top right
    Then I change root admin password in Account Details from old password wrongpass to Hipaa password
    Then Account Details error message should be:
      """
      Incorrect password
      """
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password Hipaa password
    Then I login as Admin_123374 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password Hipaa password
    Then I login as Admin_123374 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password wrongpass password
    Then Login page error message should be Incorrect email or password.
    And I log into phoenix with username @new_admins[0].email and password wrongpass password
    Then Phoenix Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123389 @bus @admin @tasks_p1
  Scenario: 123389 Hipaa Masquerade Admin can change its own password successfully
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 12     | 10    | 50 GB       | FedID role | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123389 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I act as admin by:
      | name         |
      | Admin_123389 |
    And I click admin Admin_123389 on the top right
    Then I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123389 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123389 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123390 @bus @admin @tasks_p1
  Scenario: 123390 Hipaa The last Masquerade Admin can change its own password successfully
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     | security |
      | 12     | Silver        | 100            | Reseller Root | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | Roles         |
      | Admin_123390_1 | Reseller Root |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Roles         | Parent               |
      | Admin_123390_2 | Reseller Root | <%=@admins[0].name%> |
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Roles         | Parent               |
      | Admin_123390_3 | Reseller Root | <%=@admins[1].name%> |
    And the partner has activated the <%=@admins[2].email%> account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I go to account
    And I act as admin by:
      | email                 |
      | <%=@admins[0].email%> |
    And I act as admin by:
      | email                 |
      | <%=@admins[1].email%> |
    And I act as admin by:
      | email                 |
      | <%=@admins[2].email%> |
    And I click admin Admin_123390_3 on the top right
    Then I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123390_3 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123390_3 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  ##############################################################################################################

  # Admin : Account details

  ##############################################################################################################

  @TC.1989 @bus @admin @tasks_p1
  Scenario: 1989 Edit an admins name
    When I add a new MozyPro partner:
      | period | base plan | country | cc number         |
      | 1      | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I act as newly created partner account
    And I click admin name on the top right
    When I change the display name to admin.new.name
    Then display name changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1990 @bus @admin @tasks_p1
  Scenario: 1990 Edit an admins email address
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 100            |
    Then New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I act as newly created partner account
    And I click admin name on the top right
    When I change the username to auto generated email
    Then username changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.1991 @bus @admin @tasks_p1
  Scenario: 1991 Edit an admins password
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 18    | 50 GB       |
    Then New partner should be created
    And the partner has activated the admin account with default password
    And I navigate to bus admin console login page
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I click admin name on the top right
    And I change root admin password in Account Details from old password default password to Standard password
    Then password changed success message should be displayed
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.1992 @bus @admin @tasks_p1
  Scenario: 1992 Edit an admins option to receive the newsletter
    When I add a new MozyPro partner:
      | period | base plan | security | net terms |
      | 12     | 50 GB     |  HIPAA   |    yes    |
    Then New partner should be created
    And I act as newly created partner account
    And I click admin name on the top right
    And I get the value of pro newsletter
    And I change receive mozy pro newsletter to different value
    Then newsletter changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.1993 @bus @admin @tasks_p1
  Scenario: 1993 Edit an admins option to receive email notifications
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I click admin name on the top right
    And I change receive mozy email notifications to different value
    Then email notification changed success message should be displayed
    And I stop masquerading
    And I search and delete partner account by newly created partner company name


