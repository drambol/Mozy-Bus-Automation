Feature: View billing information, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.15276 @ops_env
  Scenario: 15276 BILL.4000 Sub Partner views Billing Information
    When I add a new Reseller partner:
      | company name              | period | reseller type | reseller quota |
      | TC.15276_reseller_partner | 12     | Silver        | 100            |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I stop masquerading
    When I act as partner by:
      | name     |
      |TC.15276_reseller_partner|
    When I add a new sub partner:
      | Company Name                  |
      | TC.15276_reseller_sub_partner |
    And New partner should be created
    When I view the newly created subpartner admin details
    When I active admin in admin details QAP@SSword543210
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password QAP@SSword543210
    And I purchase resources:
      | generic quota   |
      | 50              |
    Then Resources should be purchased
    Then I open partner details by subpartner name in header
    Then I click Billing Info link to show the details
    Then purchased plan details should be:
      |Plan | Number purchased | Price each | Total price |
      |Quota| 50 GB            | $1.00      | $50.00      |


