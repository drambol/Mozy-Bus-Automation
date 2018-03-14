Feature: Add Sub_partner

  Background:
    Given I log in bus admin console as administrator

  @TC.21268 @add_sub_partner @tasks_p2 @bus
  Scenario: 21268 Enterprise partner creates sub with pooled storage
    When I add a new MozyEnterprise partner:
      | company name        | period | users | server plan  |
      | TC.21268_partner    | 12     | 200   | 12 TB        |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 4.9 TB    | 4.9 TB   | 0    | 200       | 200      |
      | Server  | 0    | 12 TB     | 12 TB    | 0    | 200       | 200      |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21268_sub_partner |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 0         | 0        | 0    | 0         | 0        |
    Then the pooled resource section of subpartner should have edit link
    Then the Server and Desktop pooled resource should be editable for the subpartner
    And I stop masquerading
    And I search and delete partner account by TC.21268_sub_partner
    And I search and delete partner account by TC.21268_partner

  @TC.21272 @add_sub_partner @tasks_p2 @bus
  Scenario: 21272 Metalic Reseller partner creates sub with pooled storage
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota | net terms |
      | TC.21272_partner | 12     | Gold          | 500            | yes       |
    Then New partner should be created
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21272_sub_partner |
    Then New partner should be created
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned   |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited  |
    Then the pooled resource section of subpartner should have edit link
    Then the Generic pooled resource should be editable for the subpartner
    And I stop masquerading
    And I search and delete partner account by TC.21272_sub_partner
    And I search and delete partner account by TC.21272_partner

  @TC.21273 @add_sub_partner @tasks_p2 @bus
  Scenario: 21273 MozyPro Bundled partner creates sub with pooled storage
    When I add a new MozyPro partner:
      | company name     | period | base plan | server plan | storage add on |
      | TC.21273_partner | 12     | 16 TB     | yes         | 10             |
    Then New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 18884     | 18884    | 0    | Unlimited | Unlimited |
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
      | TC.21273_sub_partner |
    Then New partner should be created
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned   |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited  |
    Then the pooled resource section of subpartner should have edit link
    Then the Generic pooled resource should be editable for the subpartner
    And I stop masquerading
    And I search and delete partner account by TC.21273_sub_partner
    And I search and delete partner account by TC.21273_partner

  @TC.21275 @add_sub_partner @tasks_p2 @bus
  Scenario: 21275 EMEA UK Enterprise partner creates sub with pooled storage
    When I add a new MozyEnterprise partner:
      | company name        | period | users | server plan  | server add on | country        | cc number        |
      | TC.21275_partner    | 24     | 98    | 500 GB       | 59            | United Kingdom | 4916783606275713 |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 2.4 TB    | 2.4 TB   | 0    | 98        | 98       |
      | Server  | 0    | 14.9 TB   | 14.9 TB  | 0    | 200       | 200      |
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole    | yearly | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21275_sub_partner |
    Then New partner should be created
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 0         | 0        | 0    | 0         | 0        |
    Then the pooled resource section of subpartner should have edit link
    Then the Server and Desktop pooled resource should be editable for the subpartner
    And I stop masquerading
    And I search and delete partner account by TC.21275_sub_partner
    And I search and delete partner account by TC.21275_partner

  @TC.20706 @add_sub_partner @tasks_p2 @bus
  Scenario: 20706 Create a New MozyEnterprise (Fortress Internal Test) Sub Partner
    When I act as partner by:
      | name                      | including sub-partners |
      | MozyEnterprise (Fortress) | yes                    |
    And I add a new sub partner:
      | Company Name                 |
      | TC.20706_me_fortress_partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by TC.20706_me_fortress_partner
    And I view partner details by TC.20706_me_fortress_partner
    And I change account type to Internal Test
    Then account type should be changed to Internal Test successfully
    And I change sales channel to Inside Sales
    Then sales channel should be changed to Inside Sales successfully
    And I delete partner account





