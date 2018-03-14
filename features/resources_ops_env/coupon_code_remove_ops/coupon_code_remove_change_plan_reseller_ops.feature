Feature: coupon code remove change plan resller, running on ops env (pantheon / staging)

  Subscription:
   - Requirement #143134 Aria coupon code remove: change period and change plan

   - account with coupon not in exception list, change to new plan, confirmation page without coupon price, delete coupon.
   - other account, confirmation page with coupon price, not delete coupon.
   - new plan: 250&500*1&2&4 yearly and biennially base and server plan, reseller monthly*yearly exclude monthly server plan.
   - coupon exception list: Nonprofit10, 100pctOffInternalTestCustomer, 30pctultdpro.

  Background:
    Given I log in bus admin console as administrator

  @TC.133506 @ops_env
  Scenario: silver monthly to 20 GB add on
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | coupon                         | country       |
      | 1      | Silver        | 100            | <%=QA_ENV['15percentcoupon']%> | United States |
    Then Sub-total before taxes or discounts should be $33.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 100      | $0.33      | $33.00      |
#      | Pre-tax Subtotal     |          |            | $28.05      |
#      | Total Charges        |          |            | $28.05      |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | storage add-on |
      | 2              |
    Then Change plan charge summary should be:
      | Description                 | Amount |
      | Charge for new 20 GB add-on | $13.20 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 100            | 2              | No          |
    Then API* Aria account coupon code info should be nil

  @TC.133507 @ops_env
  Scenario: silver monthly to server plan
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under   | vat number    | coupon                         | country | cc number        |
      | 1      | Silver        | 500            | MozyPro France | FR08410091490 | <%=QA_ENV['15percentcoupon']%> | France  | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €150.00
#    And Order summary table should be:
#      | Description          | Quantity | Price Each | Total Price |
#      | GB - Silver Reseller | 500      | €0.30      | €150.00     |
#      | Pre-tax Subtotal     |          |            | €127.50     |
#      | Total Charges        |          |            | €127.50     |
    And New partner should be created
    And I get partner aria id
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>
    When I act as newly created partner account
    When I change Reseller account plan to:
      | server plan |
      | Yes         |
    Then Change plan charge summary should be:
      | Description     | Amount |
      | Charge for new  | €16.00 |
    And the Reseller account plan should be changed
    And Reseller new plan should be:
      | reseller quota | storage add-on | server plan |
      | 500            | 0              | Yes         |
    Then API* Aria account coupon code info should be <%=QA_ENV['15percentcoupon']%>

