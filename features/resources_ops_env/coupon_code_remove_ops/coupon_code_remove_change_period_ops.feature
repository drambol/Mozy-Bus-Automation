Feature: coupon code remove change period, running on ops env (pantheon / staging)

  Subscription:
    - Requirement #143134 Aria coupon code remove: change period and change plan

    - account with coupon not in exception list, change period, delete coupon.
    - other account, change period, not delete coupon.
    - new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
    - coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133536 @ops_env
  Scenario: MozyPro 10 GB monthly to 10 GB yearly with coupon not in exception list, not delete coupon
    When I add a new MozyPro partner:
      | period | base plan | coupon                         | create under   | country | cc number        |
      | 1      | 10 GB     | <%=QA_ENV['10percentcoupon']%> | MozyPro France | France  | 4485393141463880 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | €7.99 *   | You are currently using this plan.                   |
      | Annual Cost   | €87.89 *  | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | €167.79 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount |
      | Credit for remainder of monthly subscription  | €8.63  |
      | Charge for new yearly subscription            | €87.89 |
      | Total amount to be charged                    | €79.26 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    And change billing period table should be:
      | Monthly Cost  | €7.99 *   | Switch to monthly billing                            |
      | Annual Cost   | €87.89 *  | You are currently using this plan.                   |
      | Biennial Cost | €167.79 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period          | Date         | Amount                              | Payment Type                  |
      | Yearly (change) | after 1 year | €87.89 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €86.29 | €86.29     | €0.00       |
      | today | €8.63  | €8.63      | €0.00       |


  @TC.133538 @ops_env
  Scenario: MozyPro 10 GB monthly to 10 GB yearly with coupon in exception list, not delete coupon
    When I add a new MozyPro partner:
      | period | base plan | coupon                        | create under   | country | cc number        |
      | 1      | 10 GB     | <%=QA_ENV['expt10pccoupon']%> | MozyPro France | France  | 4485393141463880 |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    When I act as newly created partner account
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | €7.99 *   | You are currently using this plan.                   |
      | Annual Cost   | €87.89 *  | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | €167.79 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount |
      | Credit for remainder of monthly subscription  | €8.63  |
      | Charge for new yearly subscription            | €87.89 |
      | Total amount to be charged                    | €79.26 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    And change billing period table should be:
      | Monthly Cost  | €7.99 *   | Switch to monthly billing                            |
      | Annual Cost   | €87.89 *  | You are currently using this plan.                   |
      | Biennial Cost | €167.79 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period          | Date         | Amount                              | Payment Type                  |
      | Yearly (change) | after 1 year | €87.89 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €86.29 | €86.29     | €0.00       |
      | today | €8.63  | €8.63      | €0.00       |
