Feature: Search List admins

  Background:
   Given I log in bus admin console as administrator

  @TC.872 @bus @admin @tasks_p1
  Scenario: 872 List the admins on a partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 10    | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name        | Roles      | User Group           |
      | Admin_872_1 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name        | Roles      | User Group           |
      | Admin_872_2 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I navigate to List Admins section from bus admin console page
    Then Admin information in List Admins section should be correct
      | Name        | User Groups          | Role       |
      | Admin_872_1 | (default user group) | FedID role |
      | Admin_872_2 | (default user group) | FedID role |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.122120 @bus @admin @tasks_p1
  Scenario: 122120 Edit an admins user group
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 100            | Reseller Root |
    Then New partner should be created
    And I act as newly created partner account
    And I add a new Bundled user group:
      | name         | storage_type |
      | TC.122120_UG | Shared       |
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group   | Roles         |
      | Admin_122120 | TC.122120_UG | Reseller Root |
    Then Add New Admin success message should be displayed
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully
    And I view admin details by:
      | name         |
      | Admin_122120 |
    Then I will see this admin has access to these user groups
      | user_groups  |
      | TC.122120_UG |
    And I add or remove user groups
      | add                  | remove       |
      | (default user group) | TC.122120_UG |
    Then I can save admin groups successfully
    Then I will see this admin has access to these user groups
      | user_groups          |
      | (default user group) |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123341 @bus @admin @tasks_p1 @smoke
  Scenario: 123341 Activate a new HIPAA sub-admin via email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 12     | 1     | 1 TB        | FedID role | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I go to account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | Roles      | User Group           |
      | Admin_123341 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_123341
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with Hipaa password
    And I go to account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name           | Roles      | User Group           |
      | Admin_123341_1 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_123341_1
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with Hipaa password
    And I go to account
    Then I login as Admin_123341_1 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123354 @bus @admin @tasks_p1
  Scenario: 123354 Activate a new partner sub-admin via email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 10    | 1 TB        | FedID role |
    Then New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | Roles      | User Group           |
      | Admin_123354 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_123354
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with default password
    And I go to account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name           | Roles      | User Group           |
      | Admin_123354_1 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_123354_1
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with default password
    And I go to account
    Then I login as Admin_123354_1 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123356 @bus @admin @tasks_p1
  Scenario: 123356:Activate a new partner root admin via partners activate link
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     | Silver        | 100            | yes       |
    And New partner should be created
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.123356 |
    And New partner should be created
    And I stop masquerading
    When I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    When I view the newly created subpartner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.123861 @bus @admin @tasks_p1
  Scenario: 123861 Activate a new standard sub-admin in admin details
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 100            | Reseller Root |
    Then New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name         | User Group           |
      | Admin_123861 | (default user group) |
    And I view the admin details of Admin_123861
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as Admin_123861 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


