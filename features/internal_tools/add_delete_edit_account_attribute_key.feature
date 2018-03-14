Feature:Add/Delete/Edit acount attribute key in Internal Tools in Admin Console

  Background:
    Given I log in bus admin console as administrator

  @TC.122211 @TC.122212 @TC.122213 @bus @internal_tools @smoke @ROR_smoke
  Scenario: 122211 Add New Account Attribute Key
    #======step1: create a account attribute key======
    When I add a account attribute key:
      | key                    | data type | internal |
      | TEST_ROR_SHOULD_DELETE | string    | Yes      |
    #======step2: search the key and edit======
    When I search account attribute key TEST_ROR_SHOULD_DELETE
    Then I edit account attribute key:
      | component |
      | comp_test |
    #======step3: verify the key is updated successfully======
    And I get account attribute key TEST_ROR_SHOULD_DELETE info:
      | key                    | data type | component | aria field | action |
      | TEST_ROR_SHOULD_DELETE | string    | comp_test |            | Delete |
    #======step4: delete the key======
    And I delete account attribute key TEST_ROR_SHOULD_DELETE