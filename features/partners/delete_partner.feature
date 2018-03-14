Feature: delete partner


  Background:
    Given I log in bus admin console as administrator

  @TC.13785 @bus @delete_partner @tasks_p1 @smoke
  Scenario: Mozy-13785:Deletion is triggered by admins in the bus Mozypro,business,yearly
    When I add a new MozyPro partner:
      | period  | base plan | coupon              | country       |
      | 12      | 10 GB     | 10PERCENTOFFOUTLINE | United States |
    And New partner should be created
    When I get partner aria id
    And Partner general information should be:
      | Status:         |
      | Active (change) |
    And I delete partner account
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |

  @TC.13786 @bus @delete_partner @tasks_p1
  Scenario: Mozy-13786:Deletion is triggered by Aria Mozypro, reseller , monthly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | coupon              | country       |
      | 1      | Silver        | 500            | yes         | 10PERCENTOFFOUTLINE | United States |
    And New partner should be created
    Then I get partner aria id
    And Partner general information should be:
      | Status:         |
      | Active (change) |
    And API* I change the Aria account status by newly created partner aria id to -2
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |
    Then I wait for 180 seconds
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | email        | full search |
      | @admin_email | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Aria ID  | Partner       |
      | @aria_id | @company_name |

  @TC.13816 @bus @delete_partner @tasks_p1
  Scenario: Mozy-13816:can not automatically refundor credit a deleted partner mozypro,reseller,biennially
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     | Silver        | 500            |
    And New partner should be created
    Then I get partner aria id
    Then API* The Aria account newly created partner aria id payment amount should be 1980
    And API* I change the Aria account status by newly created partner aria id to -2
    And I wait for 30 seconds
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |
    Then API* There is no refunds for aria account newly created partner aria id
    Then API* The Aria account newly created partner aria id payment amount should be 1980
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $1,980.00 | $1,980.00  | $0.00       |

  @TC.13862 @bus @delete_partner @tasks_p1
  Scenario: Mozy-13862:can not automatically refund or credit a deleted partner Mozypro DE, reseller, yearly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under    | vat number  | coupon              | country | cc number        |
      | 12     | Platinum      | 500            | yes         | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 4188181111111112 |
    And New partner should be created
    Then I get partner aria id
    And I delete partner account
    And API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | status_label |
      | CANCELLED    |
    Then API* There is no refunds for aria account newly created partner aria id
    Then API* The Aria account newly created partner aria id payment amount should be 2700

  @TC.13865 @bus @delete_partner @tasks_p1
  Scenario: 13865:can not log in if account has been deleted Mozypro,business, monthly
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 100 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.13865.User | Desktop      | 100           | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.13865.User
    And I update the user password to default password
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    And I navigate to user login page with partner ID
    And I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    When I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    When I log into phoenix with username @partner.admin_info.email and password default password
    And user log in failed, error message is:
    """
     Your account has been suspended and cannot currently be accessed.
    """

  @TC.13867 @bus @delete_partner @tasks_p1
  Scenario: 13867:can not log in if account has been deleted Mozypro FR, business, biennially
    When I add a new MozyPro partner:
      | period | base plan | create under   | vat number    | coupon              | country | cc number        |
      | 12     | 50 GB     | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 4485393141463880 |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details Hipaa password
    And I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | name          | storage_type | storage_limit | devices |
      | TC.13867.User | Desktop      | 50            | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.13867.User
    And I update the user password to default password
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    And I navigate to user login page with partner ID
    And I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

  @TC.13870 @bus @delete_partner @tasks_p1
  Scenario: 13870:can not log in if account has been deleted Mozypro Germany, reseller,monthly
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number  | coupon              | country | cc number        |
      | 12     | 100 GB    | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 4188181111111112 |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.13870.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.13870.User
    And I update the user password to default password
    Then I stop masquerading
    Then I search and delete partner account by newly created partner company name
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

  @TC.13871 @bus @delete_partner @tasks_p1
  Scenario: 13871:can not log in if account has been deleted Mozypro ireland,business, biennially
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number | coupon              | country | cc number        |
      | 24     | 250 GB    | MozyPro Ireland | IE9691104A | 10PERCENTOFFOUTLINE | Ireland | 4319402211111113 |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.13871.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.13871.User
    And I update the user password to default password
    Then I stop masquerading
    Then I search and delete partner account by newly created partner company name
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

  @TC.13874 @bus @delete_partner @tasks_p1
  Scenario: 13874:can not log in if account has been deleted Mozypro UK, reseller, yearly
    When I add a new MozyPro partner:
      | period | base plan | create under | vat number  | coupon              | country        | cc number        |
      | 12     | 500 GB    | MozyPro UK   | GB117223643 | 10PERCENTOFFOUTLINE | United Kingdom | 4916783606275713 |
    And New partner should be created
    Then I get the partner_id
    Then I change root role to FedID role
    And I act as newly created partner
    And I add new user(s):
      | name          | user_group           | storage_type | storage_limit | devices |
      | TC.13871.User | (default user group) | Desktop      | 100           | 3       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by TC.13871.User
    And I update the user password to default password
    Then I stop masquerading
    Then I search and delete partner account by newly created partner company name
    Then I navigate to user login page with partner ID
    Then I log in bus pid console with:
      | username                 | password                            |
      | <%=@new_users[0].email%> | <%=CONFIGS['global']['test_pwd'] %> |
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.

  @TC.123514 @bus @delete_partner @tasks_p1
  Scenario: Mozy-123514:Attempt to delete a existing partner with a incorrect password
    When I add a new MozyPro partner:
      | period  | base plan |
      | 12      | 10 GB     |
    And New partner should be created
    When I delete partner account with password xxx
    Then I delete partner account

  @TC.123515 @bus @delete_partner @tasks_p1
  Scenario: Mozy-123515:Delete a existing partner
    When I add a new MozyPro partner:
      | period  | base plan |
      | 12      | 10 GB     |
    And New partner should be created
    When I delete partner account
    And I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | email        | full search |
      | @admin_email | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |

  @TC.21276 @bus @delete_partner @tasks_p1
  Scenario: Mozy- 21276:MozyPro Bundled Partner with Sub Delete Subparner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 100 GB    |
    And New partner should be created
    Then I change root role to FedID role
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 GB    | 100 GB   | 0    | Unlimited | Unlimited |
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | test1        |
    And New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 50              |
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Subpartner | Assigned | Used | Available | Assigned  |
      | 0    | 50 GB     | 50 GB      | 100 GB   | 0    | Unlimited | Unlimited |
    When I act as partner by:
      | name          |
      | @company_name |
    Then I search and delete partner account by test1
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 GB    | 100 GB   | 0    | Unlimited | Unlimited |
    Then I delete partner account

  @TC.21277 @bus @delete_partner @tasks_p1
  Scenario: Mozy-21277:Enterprise Partner with Sub, Delete Subparner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 100 GB      | FedID role |
    Then New partner should be created
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 25 GB     | 25 GB    | 0    | 1         | 1        |
      | Server  | 0    | 100 GB    | 100 GB   | 0    | 200       | 200      |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21277_sub_partner |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | desktop_storage |
      | 20              |
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      |         | Used | Available | Subpartner |Assigned | Used | Available | Assigned |
      | Desktop | 0    | 5 GB      | 20 GB      |25 GB    | 0    | 1         | 1        |
      | Server  | 0    | 100 GB    | 0          |100 GB   | 0    | 200       | 200      |
    When I act as partner by:
      | name          |
      | @company_name |
    Then I search and delete partner account by TC.21277_sub_partner
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 25 GB     | 25 GB    | 0    | 1         | 1        |
      | Server  | 0    | 100 GB    | 100 GB   | 0    | 200       | 200      |
    Then I delete partner account

  @TC.21278 @bus @delete_partner @tasks_p1
  Scenario: Mozy- 21278:Metallic Reseller Partner with Sub Delete Subparner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     |  Silver       | 100            |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 GB    | 100 GB   | 0    | Unlimited | Unlimited |
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | test1        |
    And New partner should be created
    And I change pooled resource for the subpartner:
      | generic_storage |
      | 50              |
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Subpartner | Assigned | Used | Available | Assigned  |
      | 0    | 50 GB     | 50 GB      | 100 GB   | 0    | Unlimited | Unlimited |
    When I act as partner by:
      | name          |
      | @company_name |
    Then I search and delete partner account by test1
    Then I stop masquerading
    Then I search partner by newly created partner company name
    Then I view partner details by newly created partner company name
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100 GB    | 100 GB   | 0    | Unlimited | Unlimited |
    Then I delete partner account
