Feature: IP Whitelist Visibility test

  Background:
    Given I log in bus admin console as administrator

  @TC.22083 @bus @ip_whitelist @tasks_p3
  Scenario: 22083 IP Blocked
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change newly created admin name password successfully
    Then I view partner details by newly created partner company name
    And I add a none-api ip whitelist 10.29.136.124
    When I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    And The login action should be restricted by IP whitelist
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22084 @bus @ip_whitelist @tasks_p3
  Scenario: 22084 Add local IP to IP Whitelisted
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change newly created admin name password successfully
    Then I view partner details by newly created partner company name
    And I add a none-api ip whitelist local IP
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    And I login as mozypro admin successfully
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22085 @bus @ip_whitelist @tasks_p3
  Scenario: 22085 Remove Whitelisted IP from list
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change newly created admin name password successfully
    Then I view partner details by newly created partner company name
    And I add a none-api ip whitelist 10.29.136.124
    Then I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    And The login action should be restricted by IP whitelist
    And I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view partner details by newly created partner company name
    And I remove a none-api ip whitelist 10.29.136.124
    Then I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    And I login as mozypro admin successfully
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22086 @bus @ip_whitelist @tasks_p3
  Scenario: 22086 Log in a subpartner on IP whitelisted Partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | newrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.22086_sub_partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by newly created subpartner admin email
    And I view admin details by newly created subpartner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I view partner details by newly created subpartner company name
    And I add a none-api ip whitelist 10.29.136.124
    When I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password Standard password
    And The login action should be restricted by IP whitelist

  @TC.122150 @bus @ip_whitelist @tasks_p3
  Scenario: 122150 Enable View/Edit Whitelist
    When I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles | User Group           |
      | Whitelist Admin | Root  | (default user group) |
    Then Add New Admin success message should be displayed
    And I act as latest created admin
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change newly created admin name password successfully
    Then I view partner details by newly created partner company name
    And I add a none-api ip whitelist 10.29.136.124
    When I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    And The login action should be restricted by IP whitelist
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
    And I search and delete admin Whitelist Admin