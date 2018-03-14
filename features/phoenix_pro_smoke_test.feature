Feature: Add a new partner through phoenix

  As a business owner
  I want to create a partner through phoenix
  So that I can organize my business in a way that works for me

  Background:
  #-- phoenix smoke test --
  #   adding bus smoke test line items to a phoenix test
  #     & verifying that they will work without any problem, once tweaked.
  @TC.20959 @slow @phoenix @bus @2.5 @smoke @mozypro @email
  Scenario: 20959 Add a new US yearly MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | server plan |
      | 12     | 100 GB    | United States | yes         |
    Then the order summary looks like:
      | Description          | Price   | Quantity | Amount  |
      | 100 GB - Annual      | $439.89 | 1        | $439.89 |
      | Server Plan - Annual | $142.89 | 1        | $142.89 |
      | Total Charge         | $582.78 |          | $582.78 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
      | name          | filter |
      | @company_name | None   |
    And I view partner details by newly created partner company name
    And I get partner aria id
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
      | MozyPro       | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:            |   -1     |
      | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly              |
      | Unpaid Balance: | $0.00                 | Collect On:     | N/A                 |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 1 year          |                 |                     |
    When I act as newly created partner account
    And I change MozyPro account plan to:
      | base plan |
      | 500 GB    |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of plans | -$582.78  |
      | Charge for upgraded plans     | $2,309.78 |
      |                               |           |
      | Total amount to be charged    | $1,727.00  |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan |
      | 500 GB    |
    When I add new user(s):
      | name       | storage_type | storage_limit | devices |
      | TC.20959-1 | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I change account subscription to biennial period!
    Then Subscription changed message should be Your account has been changed to biennial billing.
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name
    When I search emails by keywords:
      | content                             |
      | <%=@partner.credit_card.full_name%> |
    Then I should see 4 email(s)
    When I search emails by keywords:
      | content                        |
      | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)

