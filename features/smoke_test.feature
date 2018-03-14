Feature: Bus Smoke Test

  Background:
    Given I log in bus admin console as administrator

  @TC.18361 @slow @bus @2.5 @smoke @enterprise @email @regression @core_function
  Scenario: 18361 Mozy Enterprise Smoke Test
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | company name | address           | city      | state abbrev | zip   | country       | phone          | admin name   | cc number        | expire month | expire year | cvv |
      | 24     | 10    | 100 GB      | 1             | Smoke Test   | 3401 Hillview Ave | Palo Alto | CA           | 94304 | United States | 1-877-486-9273 | vmware admin | 4111111111111111 | 12           | 32          | 123 |
    Then Sub-total before taxes or discounts should be $4,917.37
    And Order summary table should be:
      | Description           | Quantity | Price Each | Total Price |
      | MozyEnterprise User   | 10       | $181.00    | $1,810.00   |
      | 100 GB Server Plan    | 1        | $1,112.58  | $1,112.58   |
      | 250 GB Server Add-on  | 1        | $1,994.79  | $1,994.79   |
      | Pre-tax Subtotal      |          |            | $4,917.37   |
      | Total Charges         |          |            | $4,917.37   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:                                 | Root Role:          | Parent:        | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Autogrow: |
      | Active (change) | <%=@partner.admin_info.full_name%> (act as) | Enterprise (change) | MozyEnterprise | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | No (change)      |
    And I get partner aria id
    And Partner contact information should be:
      | Company Type:  | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         |
      | MozyEnterprise | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |
    And Partner account attributes should be:
      | Backup Devices         |           |
      | Backup Device Soft Cap | Disabled  |
      | Server                 | Disabled  |
      | Cloud Storage (GB)     |           |
      | Sync Users:            |   -1      |
      | Default Sync Storage:  |           |
    And Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 250 GB    | 250 GB   | 0    | 10        | 10       |
      | Server  | 0    | 350 GB    | 350 GB   | 0    | 200       | 200      |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Biennial            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                 |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
      | Next Charge:    | after 2 years          |                 |                     |
    And Partner sub admins should be empty
    When I act as newly created partner account
    And I change MozyEnterprise account plan to:
      | users | server plan | storage add-on |
      | 15    | 500 GB      | 5             |
    Then Change plan charge summary should be:
      | Description                                | Amount      |
      | Credit for remainder of 100 GB Server Plan | -$1,112.58  |
      | Charge for upgraded plans                  | $13,293.74  |
      |                                            |             |
      | Total amount to be charged                 | $12,181.16  |
    And the MozyEnterprise account plan should be changed
    And MozyEnterprise new plan should be:
      | users | server plan | server add-on |
      | 15    | 500 GB      | 5             |
    When I add a new Itemized user group:
      | name        | desktop_storage_type | desktop_assigned_quota | desktop_devices | server_storage_type | server_assigned_quota | server_devices |
      | test group  | Assigned             | 10                     | 1               | Assigned            | 20                    | 2              |
    Then test group user group should be created
    When I navigate to User Group List section from bus admin console page
    And Itemized user groups table should be:
      | Group Name           | Stash | DT Storage Type | DT Storage Value | DT Storage Used | Desktop Used | Desktop Total | SR Storage Type | SR Storage Value | SR Storage Used | Server Used | Total |
      | (default user group) | true  | Shared          |                  | 0               | 0            | 14            | Shared          |                  | 0               | 0           | 198   |
      | test group           | false | Assigned        | 10 GB            | 0               | 0            | 1             | Assigned	     | 20 GB	        | 0	              | 0	        | 2     |
    When I add new user(s):
      | user_group | storage_type | storage_limit | devices |
      | test group | Desktop      | 10            | 1       |
    Then 1 new user should be created
    When I change account subscription to 3-year billing period!
    Then Subscription changed message should be Your account has been changed to 3-year billing.
    When I create a new client config:
      | name                | user group | type   |
      | smoke_client_config | test group | Server |
    Then client configuration section message should be Your configuration was saved.
    Then API* Aria account should be:
      | status_label |
      | ACTIVE       |
    When I stop masquerading
    Then I search and delete partner account by Smoke Test
    And I wait for 1200 seconds
    When I search emails by keywords:
      | content                             |
      | <%=@partner.credit_card.full_name%> |
    Then I should see 7 email(s)
    When I search emails by keywords:
      | content                            |
      | <%=@partner.admin_info.email%>     |
    Then I should see 1 email(s)

  @TC.112 @regression @core_function
  Scenario: 112 MozyPro France
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | vat number     |
      | 12     | 50 GB     | MozyPro France | France  | FR08410091490  |
#      | 12     | 50 GB     | MozyPro France | France  | BE0883236072  |
    Then Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | €175.89    | €175.89     |
      | Pre-tax Subtotal  |          |            | €175.89     |
      | Total Charges     |          |            | €175.89     |
    And New partner should be created
    And I delete partner account

  @TC.120711 @prod_206 @regression @core_function
  Scenario: Verify Skeletor
    Given I verify Skeletor by visiting url
