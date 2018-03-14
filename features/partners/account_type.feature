Feature: Account Type

  As a Business Analyst,
  I would like to tell the difference between trial, internal test and live accounts,
  So that I can filter out non-paying and temporary accounts for reports.

  Success Criteria:
  - Add an "account type" attribute. The values are: Live, Internal Test, or Trial.
  - Add a "sales origin" attribute. The values are: Web or Sales.
  - Add a "sales channel" attribute. Values are: Inside Sales, Velocity, Reseller.

  Background:
    Given I log in bus admin console as administrator

  @TC.20925 @BUG.98477 @v.2.4.3 @bus @regression @core_function
  Scenario: Mozy-20925:Create a New Trial Partner
    When I add a new MozyEnterprise partner:
      | period | users | company name             | account type | sales channel |
      | 12     | 5     | Enterprise Trial Partner | Trial        | Inside Sales  |
    Then New partner should be created
    When I search partner by Enterprise Trial Partner
    And I view partner details by Enterprise Trial Partner
    Then partner account details should be:
    # No Sales Channel in partner details anymore for partners with ARIA id
      | Account Type   | Sales Origin |
      | Trial (change) | Sales        |
    And I delete partner account

  @TC.20923 @BUG.98477 @v.2.4.3 @bus @regression @core_function
  Scenario: Mozy-20923:Create a New Internal Test Partner
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | company name                   | account type  |
      | 1      | Silver        | 10             | Reseller Internal Test Partner | Internal Test |
    Then New partner should be created
    When I search partner by Reseller Internal Test Partner
    And I view partner details by Reseller Internal Test Partner
    Then partner account details should be:
      | Account Type           | Sales Origin |
      | Internal Test (change) | Sales        |
    And I delete partner account

  @TC.20698 @BUG.98477 @v.2.4.3 @bus @regression @core_function
  Scenario: Mozy-20698:Create a New Live Partner
    When I add a new MozyPro partner:
      | period | base plan | company name         | account type  | sales channel |
      | 1      | 10 GB     | MozyPro Live Partner | Live          | Inside Sales  |
    Then New partner should be created
    When I search partner by MozyPro Live Partner
    And I view partner details by MozyPro Live Partner
    Then partner account details should be:
      | Account Type  | Sales Origin |
      | Live (change) | Sales        |
    And I delete partner account

  @TC.20707 @BUG.98491 @BUG.98477 @v.2.4.3  @bus @regression @core_function
  Scenario: Mozy-20707:Create a New Fortress Internal Test Sub Partner
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I add a new sub partner:
      | Company Name                       |
      | Fortress Internal Test Sub Partner |
    Then New partner should be created
    When I stop masquerading
    And I search partner by Fortress Internal Test Sub Partner
    And I view partner details by Fortress Internal Test Sub Partner
    Then partner account details should be:
      | Account Type | Sales Origin | Sales Channel |
      | N/A (change) | Sales        | N/A (change)  |
    And I delete partner account

  @TC.20702 @bus @account_type @tasks_p3
  Scenario: Mozy-20702: Create a New Mozypro Internal Test Partner
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:                  |
      | SMB Bundle Limited (change) |
    And I search and delete partner account by newly created partner company name

  @TC.20703 @bus @account_type @tasks_p3
  Scenario: Mozy-20703: Create a New MozyPro Trial Partner
    When I add a new MozyPro partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Trial        | Inside Sales  |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:                  |
      | SMB Bundle Limited (change) |
    And I search and delete partner account by newly created partner company name

  @TC.20705 @bus @account_type @tasks_p3
  Scenario: Mozy-20705: Create a New Enterprise Internal Velocity Test Partner
    When I add a new MozyEnterprise partner:
      | period | account type  | sales channel | Root role     |
      | 12     | Internal Test | Inside Sales  | Velocity Root |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:          |
      | Enterprise (change) |
    And I search and delete partner account by newly created partner company name

  @TC.20922 @bus @account_type @tasks_p3
  Scenario: Mozy-20922: Create a New Reseller Trial Partner
    When I add a new Reseller partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Trial        | Reseller      |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:             |
      | Reseller Root (change) |
    And I search and delete partner account by newly created partner company name

  @TC.20924 @bus @account_type @tasks_p3
  Scenario: Mozy-20924: Create a New Reseller Live Partner
    When I add a new Reseller partner:
      | period | base plan | account type | sales channel |
      | 1      | 10 GB     | Live         | Reseller      |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:             |
      | Reseller Root (change) |
    And I search and delete partner account by newly created partner company name

  @TC.20926 @bus @account_type @tasks_p3
  Scenario: Mozy-20926: Create a New Enterprise Internal Test Partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Internal Test | Inside Sales  |
    Then New partner should be created
    And partner's root role should be Enterprise
    And I search and delete partner account by newly created partner company name

  @TC.20927 @bus @account_type @tasks_p3
  Scenario: Mozy-20927: Create a New Enterprise Live Partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Live          | Inside Sales  |
    Then New partner should be created
    And Partner general information should be:
      | Root Role:          |
      | Enterprise (change) |
    And I search and delete partner account by newly created partner company name

  @TC.22138 @bus @account_type @tasks_p3
  Scenario: Mozy-22138: Order Summary for Enterprise Velocity partner
    When I add a new MozyEnterprise partner:
      | period | users | account type  | sales channel |
      | 12     | 5     | Live          | Velocity      |
    Then New partner should be created
    And I get partner aria id
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | balance |
      | 0       |
    And I search and delete partner account by newly created partner company name

  @TC.131834 @bus @account_type @tasks_p3
  Scenario: Mozy-131834: Add Value Lifetime Free to Account Type Picklist
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    When I log in bus admin console as administrator
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then I change account type to Lifetime Free
    Then account type should be changed to Lifetime Free successfully
    And I search and delete partner account by newly created partner company name

  @TC.122387 @bus @account_type @tasks_p3
  Scenario: Mozy-122387: Edit Account Type
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    When I log in bus admin console as administrator
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then I change account type to Lifetime Free
    Then account type should be changed to Lifetime Free successfully
    When I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then partner account details should be:
      | Account Type           | Sales Origin |
      | Lifetime Free (change) | Sales        |
    And I search and delete partner account by newly created partner company name

  @TC.123253 @bus @account_type @tasks_p3
  Scenario: 123253 Set Product Name
    When I add a new OEM partner:
      | Root role         | Company Type     |
      | OEM Partner Admin | Service Provider |
    Then New partner should be created
    When I set product name for the partner
    Then The partner product name set up successfully
    And I stop masquerading as sub partner

  @TC.125461 @bus @account_type @tasks_p3
  Scenario: 125461 Add a new US yearly basic MozyPro partner from phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | billing country | cc number        |
      | 12     | 50 GB     | United States | United States   | 4018121111111122 |
    Then the order summary looks like:
      | Description    | Price   | Quantity | Amount  |
      | 50 GB - Annual | $219.89 | 1        | $219.89 |
      | Total Charge   | $219.89 |          | $219.89 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.129692 @bus @account_type @tasks_p3
  Scenario: Mozy-129692: New partners get no rollback to pooled link[2.15VMBU]
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then Rollback to pooled storage link should not be there
    And I delete partner account

  @TC.126025 @bus @account_type @tasks_p3
  Scenario: Mozy-126025: View Account in Aria from Partner Details with Credentials#122705
    When I add a new MozyPro partner:
      | period | base plan | account type  | sales channel |
      | 1      | 10 GB     | Internal Test | Inside Sales  |
    Then New partner should be created
    And I search partner by newly created partner company name
    And I view partner details by newly created partner company name
    Then view in aria link should be visible
    And I delete partner account
