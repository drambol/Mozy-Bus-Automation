Feature: Manage Pending Deletes in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.120569 @bus @pending_deletes @tasks_p1 @smoke @ROR_smoke
  Scenario: 120569:Pending delete for Enterprise partner
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 5     | yes       |
    Then New partner should be created
    When I get the partner_id
    And I get partner aria id
    And I delete partner account
    When I navigate to Manage Pending Deletes section from bus admin console page
    And I make sure pending deletes setting is 65 days
    And I search partners in pending-delete not available to purge by:
      | email        |
      | @admin_email |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            | Request Date | Days Remaining |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  | today        | 2 months       |
    And I search partner by newly created partner company name
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

  @TC.119214 @bus @pending_deletes @tasks_p1 @smoke @ROR_smoke
  Scenario: 119214:Verify that purged partners appear in the "Partners who have been purged" table
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 12     |  Silver       | 100            | yes       |
    Then New partner should be created
    And I get the partner_id
    When I get partner aria id
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        |
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Days Pending |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | 1 minute     |
    And I purge partner by newly created partner company name
    Then I wait for 5 seconds
    And I search partners in who have been purged by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in who have been purged search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      | Request Date | Date Purged |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  | today        | today       |
    Then I change to 60 days to purge account after delete

  @TC.120570 @bus @pending_deletes @tasks_p1
  Scenario: 120570:Pending delete for MozyPro partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |

  @TC.22474 @bus @pending_deletes @tasks_p1
  Scenario: 22474:Verify that deleted partners appear in the "Pending Delete - Waiting" for 180 day
    When I add a new Reseller partner:
      | period | base plan |
      | 1      | 10 GB     |
    Then New partner should be created
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |
    Then I change to 0 days to purge account after delete
    Then I wait for 5 seconds
    And I search partners in pending-delete available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete available to purge search results should be:
      | Partner       |
      | @company_name |
    Then I change to 60 days to purge account after delete
    Then I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    And I undelete partner in pending-delete not available to purge by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |

  @TC.119242 @bus @pending_deletes @tasks_p1
  Scenario: 119242:MozyPro Metalic Reseller Partner with Sub, Delete Subparner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 12     |  Silver       | 100            |
    And New partner should be created
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
      | test1   |
    And New partner should be created
    And I delete subpartner account
    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner                       |
      | <%=@subpartner.company_name%> |
    And I stop masquerading
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I should see No results found in pending-delete not available to purge table

  @TC.119243 @bus @pending_deletes @tasks_p1
  Scenario: 119243:MozyEnterprise Partner with Sub, Delete Subparner
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 5     |
    And New partner should be created
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name |
      | test1   |
    And New partner should be created
    And I delete subpartner account
    When I search partner by newly created subpartner company name
    Then Partner search results should not be:
      | Partner                       |
      | <%=@subpartner.company_name%> |
    And I stop masquerading
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | no          |
    Then I should see No results found in pending-delete not available to purge table

  @TC.119249 @bus @pending_deletes @tasks_p1
  Scenario: 119249:Delete MozyPro Partner
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 50 GB     |
    Then New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    And I act as newly created partner account
    And I build a new report:
      | type            | name                  | frequency |
      | Billing Summary | billing summary test  | Daily     |
    Then Billing summary report should be created
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
    And I log in bus admin console as new partner admin
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    When I log in bus admin console as administrator
    And I navigate to Manage Pending Deletes section from bus admin console page
    And I search partners in pending-delete not available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |
    When I wait for 86460 seconds
    And I search emails by keywords:
      | to               | content           |
      | @new_admin_email | <%=@report.name%> |
    Then I should see 0 email(s)

  @TC.22473 @bus @pending_deletes @tasks_p1
  Scenario: 22473:Verify that deleted partners appear in the "Pending Delete Available to Purge"
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 5     |
    Then New partner should be created
    And I get the partner_id
    And I get partner aria id
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |
    Then I advance the partner delete timestamp to 180 days
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  |
    Then I advance the partner delete timestamp to 180 days
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete available to purge search results should be:
      | Partner       | Days Pending |
      | @company_name | 12 months    |
    Then I advance the partner delete timestamp to 3240 days
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete available to purge search results should be:
      | Partner       | Days Pending    |
      | @company_name | almost 10 years |
    And I undelete partner in pending-delete available to purge by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |

  @TC.120572 @bus @pending_deletes @tasks_p1
  Scenario: 120572:Changing pending delete days to purge
    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 30 days to purge account after delete
    Then I wait for 30 seconds
    And I verify days to purge account after delete should be 30
    Then I change to 60 days to purge account after delete
    Then I wait for 30 seconds
    And I verify days to purge account after delete should be 60

  @TC.120573 @bus @pending_deletes @tasks_p1
  Scenario: 120573:Purge partners ready to purge
    When I add a new MozyEnterprise partner:
      | period | users | coupon              | security   |
      | 12     | 100   | 20PERCENTOFFOUTLINE | HIPAA      |
    Then New partner should be created
    And I get the partner_id
    When I get partner aria id
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in pending-delete available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type           | Request Date |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise | today        |
    And I purge partner by newly created partner company name
    And I search partners in who have been purged by:
      | name          | full search |
      | @company_name | yes         |
    Then Partners in who have been purged search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            | Request Date | Date Purged |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  | today        | today       |
    Then I change to 60 days to purge account after delete

  @TC.119257 @bus @pending_deletes @tasks_p1 @smoke @ROR_smoke @qa12
  Scenario: 119257:Undelete MozyPro Partner
    When I add a new MozyPro partner:
      | period | base plan | server plan | net terms |
      | 1      | 100 GB    | yes         | yes       |
    And New partner should be created
    When I enable stash for the partner
    And I act as newly created partner
    And I add new user(s):
      | name       | storage_type | storage_limit | devices | enable_stash |
      | TC.20921-1 | Desktop      | 10            | 1       | yes          |
    Then 1 new user should be created
    And I stop masquerading
    And I search and delete partner account by newly created partner company name
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I undelete partner in pending-delete not available to purge by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    And I view partner details by newly created partner company name
    Then Partner general information should be:
      | Status:         |
      | Active (change) |
    Then I act as partner by:
      | name          |
      | @company_name |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    Then I use keyless activation to activate devices
      | machine_name    | user_name                   | machine_type |
      | Machine1_20921  | <%=@new_users.first.email%> | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 10 |
    Then tds returns successful upload

  @TC.120574 @bus @pending_deletes @tasks_p1
  Scenario: 120574:Undelete pending partner
    When I add a new MozyPro partner:
      | period | base plan | create under   | vat number    | coupon              | country | cc number        |
      | 12     | 50 GB     | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 4485393141463880 |
    Then New partner should be created
    And I get the partner_id
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then I undelete partner in pending-delete not available to purge by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       | Root Admin  |
      | @company_name | @admin_email|

  @TC.120575 @bus @pending_deletes @tasks_p1
  Scenario: 120575:Verify cannot undelete a purged partner
    When I navigate to Manage Pending Deletes section from bus admin console page
    Then I verify can not undelete a purged partner

  @TC.120576 @bus @pending_deletes @tasks_p1
  Scenario: 120576:Verify undelete of ready to purge partner
    When I add a new MozyPro partner:
      | period | users |
      | 12     | 5     |
    Then New partner should be created
    And I get the partner_id
    And I delete partner account
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | Partner       |
      | @company_name |
    Then I change to 0 days to purge account after delete
    And I search partners in pending-delete available to purge by:
      | name          |
      | @company_name |
    And I undelete partner in pending-delete available to purge by newly created partner company name
    Then I wait for 5 seconds
    Then I change to 60 days to purge account after delete
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |

  @TC.119255 @bus @pending_deletes @tasks_p1 @ROR_smoke
  Scenario: 119255:MozyPro Metalic Reseller with Sub, Undelete
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | coupon              | country       | security |
      | 1      | Silver        | 780            | yes         |     10         | 10PERCENTOFFOUTLINE | United States | HIPAA    |
    And New partner should be created
    Then I get the partner_id
    And I get partner aria id
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
      | test1   |
    And New partner should be created
    Then I stop masquerading as sub partner
    And I search and delete partner account by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type      |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | Reseller  |

  @TC.119256 @bus @pending_deletes @tasks_p1
  Scenario: 119256:MozyEnterprise Partner with Sub, Undelete
    When I add a new MozyEnterprise partner:
      | period |
      | 12     |
    And New partner should be created
    Then I get the partner_id
    And I get partner aria id
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes |
      | subplan | business     | newrole   | yearly  | 10             | test     | false            | 1                    | 1               | 1                         | 1                    |
    And I add a new sub partner:
      | Company Name |
      | test1   |
    And New partner should be created
    Then I stop masquerading as sub partner
    And I search and delete partner account by newly created partner company name
    When I search partner by newly created partner company name
    Then Partner search results should not be:
      | Partner       |
      | @company_name |
    Then I navigate to Manage Pending Deletes section from bus admin console page
    Then I make sure pending deletes setting is 60 days
    And I search partners in pending-delete not available to purge by:
      | name          |
      | @company_name |
    Then Partners in pending-delete not available to purge search results should be:
      | ID          | Aria ID  | Partner       | Created | Root Admin   | Type            |
      | @partner_id | @aria_id | @company_name | today   | @admin_email | MozyEnterprise  |
