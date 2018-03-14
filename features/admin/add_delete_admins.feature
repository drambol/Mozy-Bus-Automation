Feature: Add admins, delete admins

  Background:
    Given I log in bus admin console as administrator

  @TC.873 @bus @admin @smoke @tasks_p1
  Scenario: 873 Add New Admin
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 12     | 18    | 100 GB      | yes       | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name      | Roles      | User Group           |
      | Admin_873 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    When I view the admin details of Admin_873
    Then Admin information in List Admins section should be correct
      | Name      | User Groups          | Role       |
      | Admin_873 | (default user group) | FedID role |
    When I search emails by keywords:
      | subject                         | after | to                |
      | MozyEnterprise Account Created! | today | <%=@admin.email%> |
    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.121840 @bus @admin @tasks_p1
  Scenario: 121840 Add LDAP admin in LDAP Push
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  |
      | 24     | 18    | 500 GB      | yes       | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | Roles      | User Group           |
      | Admin_121840 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    When I search emails by keywords:
      | subject                               | after | to                | content                                             |
      | New Account Created on MozyEnterprise | today | <%=@admin.email%> | assigned you a MozyEnterprise administrator account |
    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.121911 @bus @admin @tasks_p1
  Scenario: 121911 Add root admin and active
    When I add a new MozyPro partner:
      | period | base plan | root role          |
      | 24     | 1 TB      | SMB Bundle Limited |
    Then New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.121951 @bus @admin @tasks_p1
  Scenario: 121951 Add LDAP admin in LDAP Pull
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Pull as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | Roles      | User Group           |
      | Admin_121951 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    When I search emails by keywords:
      | subject                        | after | to                | content                                      |
      | New Account Created on MozyPro | today | <%=@admin.email%> | assigned you a MozyPro administrator account |
    Then I should see 1 email(s)
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  ##############################################################################################################

  # delete admins

  ##############################################################################################################

  @TC.120206 @bus @admin @tasks_p1
  Scenario: 120206 Verify admin password when new created admin delete hipaa sub-admin
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security | root role     |
      | 12     | Silver        | 100            | yes       | HIPAA    | Reseller Root |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group           | Roles         |
      | Admin_120206 | (default user group) | Reseller Root |
    Then Add New Admin success message should be displayed
    And the partner has activated the admin account with Hipaa password
    And I go to account
    Then I login as mozypro admin successfully
    And I view the admin details of Admin_120206
    When I delete admin with default password
    Then error message when delete admin will be
      """
        Incorrect password.
      """
    When I delete admin with Hipaa password
    And I search admin by:
      | name         |
      | Admin_120206 |
    Then I should not search out admin record
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123728 @bus @admin @tasks_p1
  Scenario: 123728 Verify standard admin password when new created admin delete sub-admin
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 100            | Reseller Root |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group           | Roles         |
      | Admin_123728 | (default user group) | Reseller Root |
    Then Add New Admin success message should be displayed
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I view the admin details of Admin_123728
    When I delete admin with Hipaa password
    And error message when delete admin will be
      """
        Incorrect password.
      """
    When I delete admin with default password
    And I search admin by:
      | name         |
      | Admin_123728 |
    Then I should not search out admin record
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.121550 @bus @admin @tasks_p1 @ROR_smoke
  Scenario: 121550 New JS popup window appears for delete admin
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 500            | Reseller Root |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group           | Roles         |
      | Admin_121550 | (default user group) | Reseller Root |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_121550
    When I delete admin then cancel, the confirm message on the popup will be
      """
        Really delete this admin? Any sub-admins will also be deleted.
      """
    And I search admin by:
      | name         |
      | Admin_121550 |
    Then I should can search out admin record
    When I delete admin with bus admin password
    And I search admin by:
      | name         |
      | Admin_121550 |
    Then I should not search out admin record
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
