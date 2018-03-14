Feature: Requirement #143134 Aria coupon code remove: change period and change plan

  account with coupon not in exception list, change period, delete coupon.
  other account, change period, not delete coupon.
  new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
  coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133536 @bus @change_period @mozypro
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

  @TC.133537 @bus @change_period @mozypro
  Scenario: MozyPro USD 250 gb monthly to 250 gb yearly with coupon not in exception list, delete coupon
    When I add a new MozyPro partner:
      | period | base plan | country       | coupon                         |
      | 1      | 250 GB    | United States | <%=QA_ENV['10percentcoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When I act as newly created partner account
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $94.99 *    | You are currently using this plan.                   |
      | Annual Cost   | $729.89 *   | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount  |
      | Credit for remainder of monthly subscription  | $85.49  |
      | Charge for new yearly subscription            | $729.89 |
      | Total amount to be charged                    | $644.40 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account coupon code info should be nil
    And change billing period table should be:
      | Monthly Cost  | $94.99 *    | Switch to monthly billing                            |
      | Annual Cost   | $729.89 *   | You are currently using this plan.                   |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period          | Date         | Amount                               | Payment Type                  |
      | Yearly (change) | after 1 year | $729.89 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $644.40 | $644.40    | $0.00       |
      | today | $85.49  | $85.49     | $0.00       |

  @TC.133538 @bus @change_period @mozypro
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

  @TC.133539 @bus @change_period @mozypro
  Scenario: MozyPro USD 250 gb monthly to 250 gb yearly with coupon in exception list, not delete coupon
    When I add a new MozyPro partner:
      | period | base plan | country       | coupon                        |
      | 1      | 250 GB    | United States | <%=QA_ENV['expt10pccoupon']%> |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    When I act as newly created partner account
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $94.99 *    | You are currently using this plan.                   |
      | Annual Cost   | $729.89 *   | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to annual billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from monthly to yearly billing?
      If you choose to continue, your account will be credited for the remainder of your monthly Subscription, then charged for a new yearly subscription beginning today. By choosing yearly billing, you will receive 1 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                   | Amount  |
      | Credit for remainder of monthly subscription  | $85.49  |
      | Charge for new yearly subscription            | $729.89 |
      | Total amount to be charged                    | $644.40 |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to yearly billing.
    And API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    And change billing period table should be:
      | Monthly Cost  | $94.99 *    | Switch to monthly billing                            |
      | Annual Cost   | $729.89 *   | You are currently using this plan.                   |
      | Biennial Cost | $1,399.79 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period          | Date         | Amount                               | Payment Type                  |
      | Yearly (change) | after 1 year | $729.89 (Without taxes or discounts) | Visa ending in @XXXX (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $571.41 | $571.41    | $0.00       |
      | today | $85.49  | $85.49     | $0.00       |

  @TC.133540 @bus @change_period @mozypro
  Scenario: MozyPro USD old 250 gb yearly to 250 GB monthly with coupon not in exception list, not delete coupon
    When I add a new MozyPro partner:
      | period | country       |
      | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign coupon code <%=QA_ENV['10percentcoupon']%> to newly created partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                            |
      | Annual Cost   | $1,220.78 * | You are currently using this plan.                   |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    And API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    And change billing period table should be:
      | Monthly Cost  | $110.98 *   | You are currently using this plan.                   |
      | Annual Cost   | $854.78 *   | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period           | Date         | Amount                               | Payment Type  |
      | Monthly (change) | after 1 year | $110.98 (Without taxes or discounts) | None (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $158.30 | $0.00      | $1,098.70   |
      | today | $940.40 | $0.00      | $940.40     |
      | today | $0.00   | $0.00      | $0.00       |

  @TC.133541 @bus @change_period @mozypro
  Scenario: MozyPro USD old 250 gb yearly to 250 GB biennial with coupon not in exception list, delete coupon
    When I add a new MozyPro partner:
      | period | country       |
      | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign coupon code <%=QA_ENV['10percentcoupon']%> to newly created partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['10percentcoupon']%>
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                            |
      | Annual Cost   | $1,220.78 * | You are currently using this plan.                   |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to biennial billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from yearly to biennial billing?
      If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                 | Amount    |
      | Credit for remainder of yearly subscription | $1,098.70 |
      | Charge for new biennial subscription        | $1,631.58 |
      | Total amount to be charged                  | $532.88   |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to biennial billing.
    And API* Aria account coupon code info should be nil
    And change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                         |
      | Annual Cost   | $854.78 *   | Switch to annual billing (includes 1 free month!) |
      | Biennial Cost | $1,631.58 * | You are currently using this plan.                |
    And Next renewal info table should be:
      | Period            | Date          | Amount                                 | Payment Type  |
      | Biennial (change) | after 2 years | $1,631.58 (Without taxes or discounts) | None (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $231.79 | $0.00      | $1,631.58   |
      | today | $301.09 | $0.00      | $1,399.79   |
      | today | $158.30 | $0.00      | $1,098.70   |
      | today | $940.40 | $0.00      | $940.40     |
      | today | $0.00   | $0.00      | $0.00       |

  @TC.133542 @bus @change_period @mozypro
  Scenario: MozyPro USD old 250 gb yearly to 250 GB monthly with coupon in exception list, not delete coupon
    When I add a new MozyPro partner:
      | period | country       |
      | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign coupon code <%=QA_ENV['expt10pccoupon']%> to newly created partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                            |
      | Annual Cost   | $1,220.78 * | You are currently using this plan.                   |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to monthly billing period
    Then Subscription changed message should be Your account will be switched to monthly billing schedule at your next renewal.
    And API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    And change billing period table should be:
      | Monthly Cost  | $110.98 *   | You are currently using this plan.                   |
      | Annual Cost   | $854.78 *   | Switch to annual billing (includes 1 free month!)    |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And Next renewal info table should be:
      | Period           | Date         | Amount                               | Payment Type  |
      | Monthly (change) | after 1 year | $110.98 (Without taxes or discounts) | None (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $158.30 | $0.00      | $1,098.70   |
      | today | $940.40 | $0.00      | $940.40     |
      | today | $0.00   | $0.00      | $0.00       |

  @TC.133543 @bus @change_period @mozypro
  Scenario: MozyPro USD old 250 gb yearly to 250 GB biennial with coupon in exception list, not delete coupon, max 2 times nonprofit10
    When I add a new MozyPro partner:
      | period | country       |
      | 12     | United States |
    And New partner should be created
    And I get partner aria id
    When API* I assign coupon code <%=QA_ENV['expt10pccoupon']%> to newly created partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro 250 GB Plan (Annual)                   | Custom Old Standard | usd               | 1              |
    When API* I assign aria supp plan multi for newly created partner aria id
      | plan_name                                      | rate_schedule_name  | schedule_currency | num_plan_units |
      | MozyPro Server Add-on for 250 GB Plan (Annual) | Custom Old Standard | usd               | 1              |
    When I act as newly created partner account
    And I navigate to Change Plan section from bus admin console page
    Then MozyPro available base plans and price should be:
      | plan                               |
      | 10 GB, $109.89                     |
      | 50 GB, $219.89                     |
      | 100 GB, $439.89                    |
      | 250 GB, $1,044.89 (current purchase) |
      | 500 GB, $1,459.89                  |
      | 1 TB, $2,919.89                    |
      | 2 TB, $5,769.89                    |
      | 4 TB, $11,089.89                   |
      | 8 TB, $31,679.78                   |
      | 12 TB, $47,519.67                  |
      | 16 TB, $63,359.56                  |
      | 20 TB, $79,199.45                  |
      | 24 TB, $95,039.34                  |
      | 28 TB, $110,879.23                 |
      | 32 TB, $126,719.12                 |
    And Add-ons price should be Server Plan, $175.89
    And I go to change billing period section
    Then change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                            |
      | Annual Cost   | $1,220.78 * | You are currently using this plan.                   |
      | Biennial Cost | $1,631.58 * | Switch to biennial billing (includes 3 free months!) |
    And I change account subscription to biennial billing period
    Then Change subscription confirmation message should be:
      """
      Are you sure that you want to change your subscription period from yearly to biennial billing?
      If you choose to continue, your account will be credited for the remainder of your yearly Subscription, then charged for a new biennial subscription beginning today. By choosing biennial billing, you will receive 3 free month(s) of Mozy service.
      Any resources you scheduled for return in your next subscription have been deducted from the new subscription total.
      """
    And Change subscription price table should be:
      | Description                                 | Amount    |
      | Credit for remainder of yearly subscription | $1,098.70 |
      | Charge for new biennial subscription        | $1,631.58 |
      | Total amount to be charged                  | $532.88   |
    When I continue to change account subscription
    Then Subscription changed message should be Your account has been changed to biennial billing.
    And API* Aria account coupon code info should be <%=QA_ENV['expt10pccoupon']%>
    And change billing period table should be:
      | Monthly Cost  | $110.98 *   | Switch to monthly billing                         |
      | Annual Cost   | $854.78 *   | Switch to annual billing (includes 1 free month!) |
      | Biennial Cost | $1,631.58 * | You are currently using this plan.                |
    And Next renewal info table should be:
      | Period            | Date          | Amount                                 | Payment Type  |
      | Biennial (change) | after 2 years | $1,631.58 (Without taxes or discounts) | None (change) |
    When I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $231.79 | $0.00      | $1,631.58   |
      | today | $301.09 | $0.00      | $1,399.79   |
      | today | $158.30 | $0.00      | $1,098.70   |
      | today | $940.40 | $0.00      | $940.40     |
      | today | $0.00   | $0.00      | $0.00       |
