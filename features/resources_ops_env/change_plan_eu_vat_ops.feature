Feature: Mozypro customers from 28 EU countries change plan, running on ops env (pantheon / staging)

  @TC.124598 @ops_env
  Scenario: TC.124598 change plan for EL MozyPro partner which signed up in phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | server plan | country | billing country | cc number        |
      | 1      | 10 GB     | yes         | Greece  | Greece          | 4532121111111111 |
    Then the order summary looks like:
      | Description           | Price  | Quantity | Amount |
      | 10 GB - Monthly       | €7.99  | 1        | €7.99  |
      | Server Plan - Monthly | €2.99  | 1        |	€2.99  |
      | Subscription Price    | €10.98 |          | €10.98 |
      | VAT                   | €2.53  |          | €2.53  |
      | Total Charge          | €13.51 |          | €13.51 |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email        |
      | @admin_email |
    And I change MozyPro account plan to:
      | base plan | server plan |
      | 24 TB     | no          |
    Then Change plan charge summary should be:
      | Description                   | Amount    |
      | Credit for remainder of 10 GB | -€9.83    |
      | Charge for new 24 TB          | €8,191.73 |
      |                               |           |
      | Total amount to be charged    | €8,181.90 |
    And the MozyPro account plan should be changed
    And MozyPro new plan should be:
      | base plan | server plan |
      | 24 TB     | no          |
    When I stop masquerading
    Then I search and delete partner account by newly created partner company name


