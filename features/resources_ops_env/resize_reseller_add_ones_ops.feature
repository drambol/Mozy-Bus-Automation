Feature: Resize Reseller Gold & Platinum Partners add-ons to 20 GB add-on, running on ops env (pantheon / staging)

  Background:
    Given I log in bus admin console as administrator

  @TC.20180 @ops_env
  Scenario: 20180 Create New Gold Reseller - Monthly - US - 20 GB Add on - Net Terms
    When I add a new Reseller partner:
      | period  | reseller type | reseller quota | storage add on | net terms |
      | 1       | Gold          | 200            | 2              | yes       |
    And Order summary table should be:
      | Description             | Quantity |
      | GB - Gold Reseller      | 200      |
      #| 20 GB add-on            | 2        |
      # Replace with below code if running on staging
      | 50 GB add-on            | 2        |
    And New partner should be created
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 240       | 240      | 0    | Unlimited | Unlimited |
    When I act as newly created partner
    And I navigate to Change Plan section from bus admin console page
    Then Reseller supplemental plans should be:
      | storage add on type | # storage add on | has server plan |
      #| 20 GB add-on        | 2                | No              |
      # Replace with below code if running on staging
      | 50 GB add-on        | 2                | No              |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.20186 @ops_env
  Scenario: 20186 Assign new Gold Reseller 20 GB add on plan in Aria
    When I add a new Reseller partner:
      | company name | period  | reseller type | reseller quota | storage add on |
      | TC.20186     | 12      | Gold          | 200            | 2              |
    And Order summary table should be:
      | Description        | Quantity |
      | GB - Gold Reseller | 200      |
      #| 20 GB add-on       | 2        |
      # Replace with below code if running on staging
      |                    | 2        |
    And New partner should be created
    And I wait for 10 seconds
    And I get partner aria id
    Then API* Aria account plans for newly created partner aria id should be:
      | plan_name                                  | plan_units |
      | Annual EN                                  | 1          |
      | Mozy Reseller GB - Gold (Annual)           | 200        |
      | Mozy Reseller 20 GB add-on - Gold (Annual) | 2          |
    When API* I replace aria supplemental units plans for newly created partner aria id
      | plan_name                                  | num_plan_units |
      | Mozy Reseller 20 GB add-on - Gold (Annual) | 3              |
    And I wait for 10 seconds
    Then API* Aria account plans for newly created partner aria id should be:
      | plan_name                                  | plan_units |
      | Annual EN                                  | 1          |
      | Mozy Reseller GB - Gold (Annual)           | 200        |
      | Mozy Reseller 20 GB add-on - Gold (Annual) | 3          |
    And I wait for 30 seconds
    And I refresh the partner details section
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 260       | 260      | 0    | Unlimited | Unlimited |
    And I delete partner account