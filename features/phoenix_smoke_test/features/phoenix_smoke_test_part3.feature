Feature: Phoenix smoke test

  As a business owner
  (1) I want to create a partner through phoenix
  (2) I want to create a mozyhome user and manage home user
  So that I can organize my business in a way that works for me

  Background:

  @TC.126129 @mozy @phoenix @regression_test
  Scenario: 126129 Verify DL links within CMS content pages
    When I clear downloads folder
    When I go to cms page
    And I download home client
    And I go to cms page
    And I download sync client
    And I go to cms page
    And I download pro client

  @TC.126121 @bus @mozypro @phoenix @regression_test @us
  Scenario: 126121 Create a MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | company name                                 | country       | billing country |  coupon                |
      | 1      | 50 GB     | Internal Mozy - Phoenix smoke test - mozypro |United States | United States   |  <%=QA_ENV['coupon']%> |
    Then the order summary looks like:
      | Description     | Price  | Quantity | Amount |
      | 50 GB - Monthly | $19.99 | 1        | $19.99 |
      | Total Charge    | $19.99 |          | $19.99 |
    And the partner is successfully added.
    And I save the partner info

  @TC.126125 @bus @mozypro @phoenix @regression_test @us
  Scenario: 126125 log in as a pro admin - Precondition:@TC.126121
    When I get previous partner info
    And I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I login as mozypro admin successfully