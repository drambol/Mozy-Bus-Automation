Feature: View/Edit Details: Account Details

  Background:
    Given I log in bus admin console as administrator

# Edit partner info
  @TC.122386 @edit_account_details @tasks_p2 @bus @ROR_smoke
  Scenario: 122386 Edit a partners contact info
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 12     | 4 TB      | yes       |
    Then New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country |
      | China   |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    And I expand contact info from partner details section
    When I change the partner contact information default password
      | Contact Address: | Contact Email:              | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Address: | Contact Email:              | Contact Country:    | Contact City: | Contact ZIP/Postal Code: | Phone:     | Contact State: | Industry:    | # of employees: |
      | test address     | mozybus+auto+chg1@gmail.com | China               | test city     | 5214                     | 1234567890 | BC             | Accounting   | 6-20            |
    And I log out bus admin console
    When I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

# Parent can modify sub partner resources#99625
  @TC.21174 @edit_account_details @tasks_p2 @bus
  Scenario: 21174 Enterprise Partner with Sub add storage to Sub
    When I add a new MozyEnterprise partner:
      | company name        | period | users | server plan | net terms |
      | TC.21174_partner    | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21174_sub_partner |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Server Storage |
      | 101            |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    Validation failed: Pool policy assigned Server storage can only be assigned between 0 and 100 GB.
    """
    And I change pooled resource for the subpartner:
      | Server Storage |
      | 99             |
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 99 GB     | 99 GB    | 0    | 0         | 0        |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21174_partner  |
    And I view partner details by TC.21174_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Assigned |
      | Desktop | 0    | 450 GB    | 0          | 450 GB    | 0    | 18        | 18        |
      | Server  | 0    | 1 GB      | 99 GB      | 100 GB    | 0    | 200       | 200      |
    And I act as partner by:
      | name               |
      | TC.21174_partner   |
    When I search partner by:
      | name                  |
      | TC.21174_sub_partner  |
    And I view partner details by TC.21174_sub_partner
    And I change pooled resource for the subpartner:
      | Server Devices |
      | 201            |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    You can not assign more licenses than are available in your parent.
    """
    And I change pooled resource for the subpartner:
      | Server Devices |
      | 199            |
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 0         | 0        | 0    | 0         | 0        |
      | Server  | 0    | 99 GB     | 99 GB    | 0    | 199       | 199      |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21174_partner  |
    And I view partner details by TC.21174_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Subpartner | Assigned |
      | Desktop | 0    | 450 GB    | 0          | 450 GB    | 0    | 18        | 0          | 18       |
      | Server  | 0    | 1 GB      | 99 GB      | 100 GB    | 0    | 1         | 199        | 200      |
    And I delete partner account
    And I search and delete partner account by TC.21174_sub_partner

  @TC.21251 @edit_account_details @tasks_p2 @bus
  Scenario: 21251 Enterprise Partner with Sub Remove storage from Sub
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan | server add on |
      | TC.21251_partner  | 36     | 30    | 2 TB        | 40            |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | Enterprise |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax |Server Price per key | Server Min keys | Server Price per gigabyte | Server Min gigabytes | Desktop Price per key | Desktop Min keys | Desktop Price per gigabyte | Desktop Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            |1                    | 1               | 1                         | 1                    | 1                     | 1                | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name         |
      | TC.21251_sub_partner |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 10              | 100           | 10             | 100          |
    Then Resources should be purchased
    And I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC123884-group-1 | Shared               | 6               | Shared              | 6              |
    Then TC123884-group-1 user group should be created
    And I stop masquerading as sub partner
    When I search partner by:
      | name                  |
      | TC.21251_sub_partner  |
    And I view partner details by TC.21251_sub_partner
    And I change pooled resource for the subpartner:
      | Desktop Devices | Server Devices |
      | 5               | 5              |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    You can not assign fewer licenses than you are using.
    """
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 100  GB   | 100 GB   | 0    | 10        | 10       |
      | Server  | 0    | 100  GB   | 100 GB   | 0    | 10        | 10       |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21251_partner  |
    And I view partner details by TC.21251_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Subpartner | Assigned |
      | Desktop | 0    | 650 GB    | 100 GB     | 750 GB    | 0    | 20        | 10         | 30       |
      | Server  | 0    | 11.7 TB   | 100 GB     | 11.8 TB   | 0    | 190       | 10         | 200      |
    And I act as partner by:
      | name               |
      | TC.21251_partner   |
    When I search partner by:
      | name                  |
      | TC.21251_sub_partner  |
    And I view partner details by TC.21251_sub_partner
    And I change pooled resource for the subpartner:
      | Desktop Devices | Server Devices |
      | 6               | 6              |
    Then Partner pooled storage information should be:
      |         | Used | Available | Assigned | Used | Available | Assigned |
      | Desktop | 0    | 100  GB   | 100 GB   | 0    | 6         | 6        |
      | Server  | 0    | 100  GB   | 100 GB   | 0    | 6         | 6        |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21251_partner  |
    And I view partner details by TC.21251_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      |         | Used | Available | Subpartner | Assigned  | Used | Available | Subpartner | Assigned |
      | Desktop | 0    | 650 GB    | 100 GB     | 750 GB    | 0    | 24        | 6          | 30       |
      | Server  | 0    | 11.7 TB   | 100 GB     | 11.8 TB   | 0    | 194       | 6          | 200      |
    And I delete partner account
    And I search and delete partner account by TC.21251_sub_partner

  @TC.21260 @edit_account_details @tasks_p2 @bus
  Scenario: 21260 Metalic Reseller Partner with Sub add storage to Sub
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota | net terms |
      | TC.21260_partner | 12     | Silver        | 100            | yes       |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.21260_sub_partner   | subplan      | subadmin   |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Generic Storage |
      | 101             |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    Validation failed: Pool policy assigned storage can only be assigned between 0 and 100 GB.
    """
    And I change pooled resource for the subpartner:
      | Generic Storage |
      | 99              |
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 99 GB     | 99 GB    | 0    | Unlimited | Unlimited |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21260_partner  |
    And I view partner details by TC.21260_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      | Used | Available | Subpartner | Assigned | Used | Available | Assigned  |
      | 0    | 1 GB      | 99 GB      | 100 GB   | 0    | Unlimited | Unlimited |
    And I delete partner account
    And I search and delete partner account by TC.21260_sub_partner

  @TC.21265 @edit_account_details @tasks_p2 @bus
  Scenario: 21265 Metalic Reseller Partner with Sub Remove storage from Sub
    When I add a new Reseller partner:
      | company name     | period | reseller type | reseller quota |
      | TC.21265_partner | 1      | Gold          | 800            |
    Then New partner should be created
    And I act as newly created partner account
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name           | Pricing Plan | Admin Name |
      | TC.21265_sub_partner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | generic quota |
      | 99            |
    Then Resources should be purchased
    When I add a new Bundled user group:
      | name              | storage_type | assigned_quota |
      | TC.21265-Assigned | Assigned     | 10             |
    Then TC.21265-Assigned user group should be created
    And I stop masquerading as sub partner
    When I search partner by:
      | name                  |
      | TC.21265_sub_partner  |
    And I view partner details by TC.21265_sub_partner
    And I change pooled resource for the subpartner:
      | Generic Storage |
      | 9               |
    Then pooled resource shouldn't be changed and the error message should be:
    """
    Validation failed: Pool policy assigned storage can only be assigned between 10 and 800 GB.
    """
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 10   | 89  GB    | 99 GB    | 0    | Unlimited | Unlimited |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21265_partner  |
    And I view partner details by TC.21265_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      | Used | Available | Subpartner | Assigned  | Used | Available | Assigned   |
      | 0    | 701 GB    | 99 GB      | 800 GB    | 0    | Unlimited | Unlimited  |
    And I act as partner by:
      | name               |
      | TC.21265_partner   |
    When I search partner by:
      | name                  |
      | TC.21265_sub_partner  |
    And I view partner details by TC.21265_sub_partner
    And I change pooled resource for the subpartner:
      | Generic Storage |
      | 11              |
    Then Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 10   | 1  GB     | 11 GB    | 0    | Unlimited | Unlimited |
    And I stop masquerading
    When I search partner by:
      | name              |
      | TC.21265_partner  |
    And I view partner details by TC.21265_partner
    And I expand contact info from partner details section
    Then Partner pooled storage information should be:
      | Used | Available | Subpartner | Assigned  | Used | Available | Assigned   |
      | 0    | 789 GB    | 11 GB      | 800 GB    | 0    | Unlimited | Unlimited  |
    And I delete partner account
    And I search and delete partner account by TC.21265_sub_partner


