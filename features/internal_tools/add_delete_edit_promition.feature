Feature: Add New Promition in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122197 @122199 @bus @internal_tools @smoke @ROR_smoke
  Scenario: 122197 Add New Promtion
    #======prestep: delete promotion if already exists======
    Given I delete promo ror001 from plsql
    #======step1 : create a promotion======
    When I add a new promotion:
      | description | promo code | discount type  | discount value | valid from | through    |
      | testing     | ror001     | Price Discount | 0.5000         | 2016-01-21 | 2022-01-21 |
    Then new promotion is created
    #======step2: create a mozy home user with the created coupon code======
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | coupon |
      | 12     | 125 GB    | United States  | United States   | ror001 |
    Then the user is successfully added
    Given I log in bus admin console as administrator
    #======step3: search the user and verify the subscription table======
    When I search user by:
      | keywords       |
      | @mh_user_email |
      #| @partner.admin_info.email |
    And I view user details by newly created MozyHome username
    Then MozyHome user billing info should be:
     | Amount  |
     | $104.39 |
    #======step4: delete the promotion======
    And I delete promo ror001 from plsql
    #When I search promition ror001 <-- time killer, delete promotion from plsql directly
    #Then I delete promotion


  @TC.122198 @TC.122199 @bus @internal_tools @smoke @ROR_smoke
  Scenario: 122198 122199 Edit Promtion
    #======prestep: delete promotion if already exists======
    Given I delete promo ror004 from plsql
    #======step1: create a promotion======
    When I add a new promotion:
      | description | promo code | discount type  | discount value | through    |
      | testing     | ror004     | Price Discount | 0.5000         | 2022-01-21 |
    Then new promotion is created
    #======step2: update promotion======
    When I search promition ror004
    And I update an existing promotion:
      | discount value |
      | 0.12           |
    Then promotion is updated
    #======step3: create a new mozyhome user with updated promotion======
    When I am at dom selection point:
    And I add a phoenix Home user:
      | period | base plan | country        | billing country | coupon |
      | 12     | 125 GB    | United States  | United States   | ror004 |
    Then the user is successfully added
    Given I log in bus admin console as administrator
    #======step4: search the user and verify the subscription table======
    When I search user by:
      | keywords       |
      | @mh_user_email |
    And I view user details by newly created MozyHome username
    Then MozyHome user billing info should be:
      | Amount  |
      | $108.58 |
    #======step5: delete promotion======
    And I delete promo ror004 from plsql
    #When I search promition ror004 <-- time killer, delete promotion from plsql directly
    #Then I delete promotion