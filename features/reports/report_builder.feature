Feature: Report Builder
  As a Mozy Administrator
  I want to view reports on the services I have purchased
  so that I can understand why I was charged what I was charged and for which partner or usergroup, update my records, or re-bill my sub-partners and usergroups.

  Background:
    Given I log in bus admin console as administrator

  @TC.17939 @bus @reports @tasks_p2
  Scenario: 17939 Verify billing summary report csv all fields from email (mozyenterprise)
    When I add a new MozyEnterprise partner:
      | period | users | server plan  | server add-on |
      | 12     | 1     | 100 GB       | 2             |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I build a new report:
      | type            | name                  |
      | Billing Summary | billing summary test  |
    Then Billing summary report should be created
    And I wait for 45 seconds
    And I search emails by keywords:
      | to               | content                                     |
      | @new_admin_email | Your billing summary test - Billing Summary |
    Then I should see 1 email(s)
    And I clear downloads folder billing-summary*.csv file
    And I download email attachment by keywords:
      | to               | content                                      |
      | @new_admin_email | Your billing summary test - Billing Summary  |
    Then Scheduled Billing Summary report csv file which attached to email details should be:
      | Column A | Column B              | Column C     | Column D           | Column E              | Column F            | Column G               | Column H             | Column I                           | Column J                            | Column K               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | Server Keys Purchased | Server GB Purchased | Desktop Keys Purchased | Desktop GB Purchased | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
      | @name    | (default user group)  |              | N/A                | 200                   | Shared              | 1                      | Shared               |                                    |                                     | $0.45                  |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
    And I clear downloads folder billing-summary*.csv file

  @TC.17940 @bus @reports @tasks_p2
  Scenario: 17940 Verify billing detail report csv all fields from email (mozyenterprise)
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add-on |
      | 24     | 1     | 100         | 2             |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    And I build a new report:
      | type           | name                |
      | Billing Detail | billing detail test |
    Then Billing detail report should be created
    And I wait for 45 seconds
    And I search emails by keywords:
      | to               | content                                   |
      | @new_admin_email | Your billing detail test - Billing Detail |
    Then I should see 1 email(s)
    And I clear downloads folder billing-detail*.csv file
    And I download email attachment by keywords:
      | to               | content                                   |
      | @new_admin_email | Your billing detail test - Billing Detail |
    Then Scheduled Billing Detail report csv file which attached to email details should be:
      | Column A | Column B              | Column C     | Column D           | Column E                    | Column F                    | Column G               | Column H              | Column I              | Column J                               | Column K                     | Column L                     | Column M                | Column N               | Column O               | Column P                                | Column Q                           | Column R                            | Column S               |
      | Partner  | User Group            | Billing Code | Total GB Purchased | Server GB Purchased         | Server Quota Allocated (GB) | Server Quota Used (GB) | Server Keys Purchased | Server Keys Activated | Server Keys Assigned But Not Activated | Desktop GB Purchased         | Desktop Quota Allocated (GB) | Desktop Quota Used (GB) | Desktop Keys Purchased | Desktop Keys Activated | Desktop Keys Assigned But Not Activated | Effective price per Server license | Effective price per Desktop license | Effective price per GB |
      | @name    | (default user group)  |              | N/A                | Shared                      | N/A                         | 0                      | 200                   | 0                     | 0                                      | Shared                       | N/A                          | 0                       | 1                      | 0                      | 0                                       |                                    |                                     | $0.43                  |
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name
    And I clear downloads folder billing-detail*.csv file