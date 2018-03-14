Feature: Change VAT Number


  Background:
    Given I log in bus admin console as administrator

  #
  #Partner Admin Change/Partner Details
  #
  @TC.124661 @bus @change_vat_number
  Scenario: 124661 Partner admin change VAT number with valid value
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country | server plan |  cc number         |
      | 1      | 100 GB    | Italy   |  yes        |  4916921703777575  |
    And the partner is successfully added.
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I change the partner contact information default password
      | VAT Number:     |
      | IT03018900245   |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      | IT03018900245   |
    Then API* Aria account should be:
      | taxpayer_id   |
      | IT03018900245 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124662 @bus @change_vat_number
  Scenario: 124662 Partner admin change VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country | cc number         |
      | 1      | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information default password
      | VAT Number:   |
      | IT03018900245 |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124663 @bus @change_vat_number
  Scenario: 124663 Partner admin change VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country |  cc number         |
      | 12     | 50 GB     | France  |  4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information default password
      | VAT Number:     |
      | IT03            |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124664 @bus @change_vat_number
  Scenario: 124664 Partner admin change VAT number with blank value should succeed
    When I add a new MozyEnterprise partner:
      | period | base plan | country | vat number    |  cc number         |
      | 24     | 50 GB     | France  | FR08410091490 |  4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    When I change the partner contact information default password
      | VAT Number:     |
      |                 |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #Partner Admin Change/VAT Number in "Change Contact Country"
  #
  @TC.124665 @bus @change_vat_number
  Scenario: 124665 Partner admin change from EU country to Non-EU country check VAT Number
    When I add a new Reseller partner:
      | period | country |  cc number        |
      | 12     | France  |  4485393141463880 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    Then I am partner admin and I change contact country to Non-EU country
    Then VAT number field of Change Contact Country section should disappear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124666 @bus @change_vat_number
  Scenario: 124666 Partner admin change from Non-EU country to EU country check VAT Number
    When I add a new Reseller partner:
      | period | country        | cc number        |
      | 12     | United States  | 4916655952145825 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    Then I am partner admin and I change contact country to EU country
    Then VAT number field of Change Contact Country section should appear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124667 @bus @change_vat_number
  Scenario: 124667 Partner admin change VAT number with valid value should succeed
    When I add a new MozyEnterprise partner:
      | period | base plan | country |  cc number        |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country | VAT Number    |
      | France  | FR08410091490 |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124668 @bus @change_vat_number
  Scenario: 124668 Partner admin change VAT number with other country's VAT number
    When I add a new MozyEnterprise partner:
      | period | base plan | country | cc number         |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country | VAT Number    |
      | France  | DE812321109   |
    Then Change contact country and VAT number shouldn't succeed and the message should be:
    """
     VAT number is not valid
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124669 @bus @change_vat_number
  Scenario: 124669 Partner admin change VAT number with invalid value
    When I add a new MozyEnterprise partner:
      | period | base plan | country | cc number         |
      | 24     | 50 GB     | France  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country | VAT Number    |
      | France  | invalid11     |
    Then Change contact country and VAT number shouldn't succeed and the message should be:
    """
     VAT number is not valid
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124670 @bus @change_vat_number
  Scenario: 124670 Partner admin change VAT number with blank value should succeed
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    Then I open partner details by partner name in header
    And I change contact country and VAT number default password
      | Country | VAT Number    |
      | France  | @blank_space  |
    Then Change contact country and VAT number should succeed and the message should be:
    """
    Your contact country was successfully updated.
    """
    Then API* Aria account should be:
      | taxpayer_id   |
      |               |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #Partner Admin Change/billing information
  #
  @TC.124671 @bus @change_vat_number
  Scenario: 124671 Partner admin check billing information section should have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then VAT table should display
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124672 @bus @change_vat_number
  Scenario: 124672 Partner admin check billing information section shouldn't have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country        | cc number          |
      | 24     | 50 GB     | United States  | 4916655952145825   |
    Then New partner should be created
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then VAT table shouldn't display
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124673 @bus @change_vat_number
  Scenario: 124673 Partner admin's billing information section, change vat number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then VAT number was saved successfully:
      | VAT number     |
      | FR08410091490  |
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124674 @bus @change_vat_number
  Scenario: 124674 Partner admin's billing information section, change vat number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country          | cc number          |
      | 24     | 50 GB     | United Kingdom   | 4916783606275713   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124675 @bus @change_vat_number
  Scenario: 124675 Partner admin's billing information section, change vat number with invalid VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | invalid_number |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124676 @bus @change_vat_number
  Scenario: 124676 Partner admin's billing information section, change vat number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number   |
      | @blank_value |
    Then VAT number was saved successfully:
      | VAT number   |
      | @blank_value |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124677 @bus @change_vat_number
  Scenario: 124677 Partner admin's billing information section, delete vat number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    When I navigate to Billing Information section from bus admin console page
    Then I delete VAT number
    Then VAT number was deleted successfully
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  #
  #BUS Admin Change/Partner Details
  #
  @TC.124678 @bus @change_vat_number
  Scenario: 124678 BUS admin change partner's contact country from EU country to Non-EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 1 TB      | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I am BUS admin and I change contact country to Non-EU country
    Then VAT number field of Partner Details section should disappear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124679 @bus @change_vat_number
  Scenario: 124679 BUS admin change partner's contact country from Non-EU country to EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan |  cc number         |
      | 1      | 100 GB    | United States  |  yes        |  4916655952145825  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I am BUS admin and I change contact country to EU country
    Then VAT number field of Partner Details section should appear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124680 @bus @change_vat_number
  Scenario: 124680 BUS admin change partner's contact country (with a vat number) from EU country to Non-EU country, save changes
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 12     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Country:  |
      | United States     |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124681 @bus @change_vat_number
  Scenario: 124681 BUS admin edit partner's VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      | DE812321109      |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124682 @bus @change_vat_number
  Scenario: 124682 BUS admin edit partner's VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      | invalid_number   |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124683 @bus @change_vat_number
  Scenario: 124683 BUS admin edit partner's VAT number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 1      | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | VAT Number:      |
      |                  |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I delete partner account

  @TC.124684 @bus @change_vat_number
  Scenario: 124684 BUS admin edit partner's contact country and VAT number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I expand contact info from partner details section
    When I change the partner contact information to:
      | Contact Country: | VAT Number:      |
      | Germany          | DE812321109      |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | Contact Country: | VAT Number:      |
#      | Germany          | DE812321109      |
    Then API* Aria account should be:
      | taxpayer_id |
      | DE812321109 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    And I delete partner account

  #
  #BUS Admin Change/act as partner: Partner Details
  #
  @TC.124685 @bus @change_vat_number
  Scenario: 124685 act as partner and change contact country from EU country to Non-EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 1 TB      | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    Then I open partner details by partner name in header
    Then I am BUS admin and I change contact country to Non-EU country
    Then VAT number field of Partner Details section should disappear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124686 @bus @change_vat_number
  Scenario: 124686 act as partner and change contact country from Non-EU country to EU country, check VAT number field
    When I add a new MozyPro partner:
      | period | base plan | country        | server plan |  cc number         |
      | 1      | 4 TB      | United States  |  yes        |  4916655952145825  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    Then I open partner details by partner name in header
    Then I am BUS admin and I change contact country to EU country
    Then VAT number field of Partner Details section should appear
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124687 @bus @change_vat_number
  Scenario: 124687 act as partner and change contact country (with a vat number) from EU country to Non-EU country, save changes
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 12     | 4 TB      | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | Contact Country: |
      | United States    |
    Then Partner contact information is changed
    And Partner contact information should be:
      | Contact Country:  |
      | United States     |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124688 @bus @change_vat_number
  Scenario: 124688 act as partner and edit its VAT number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 100 GB    | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      | DE812321109      |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124689 @bus @change_vat_number
  Scenario: 124689 act as partner and edit its VAT number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 100 GB    | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      | invalid_number   |
    Then contact info shouldn't be changed and the error message should be:
    """
    Error updating VAT info. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124690 @bus @change_vat_number
  Scenario: 124690 act as partner and edit its VAT number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | VAT Number:      |
      |                  |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | VAT Number:     |
#      |                 |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124691 @bus @change_vat_number
  Scenario: 124691 act as partner, edit its contact country and VAT number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 100 GB    | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    Then I open partner details by partner name in header
    When I change the partner contact information to:
      | Contact Country: | VAT Number:      |
      | Germany          | DE812321109      |
    Then Partner contact information is changed
#    And Partner contact information should be:
#      | Contact Country: | VAT Number:      |
#      | Germany          | DE812321109      |
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | DE812321109 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  #BUS Admin Change/billing information
  #
  @TC.124692 @bus @change_vat_number
  Scenario: 124692 act as a partner which contact country is EU country, check billing information section should have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country | vat number     | cc number         |
      | 24     | 50 GB     | France  | FR08410091490  | 4485393141463880  |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then VAT table should display
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124693 @bus @change_vat_number
  Scenario: 124693 act as a partner which contact country is Non-EU country, check billing information section shouldn't have VAT table
    When I add a new MozyPro partner:
      | period | base plan | country        | cc number          |
      | 24     | 50 GB     | United States  | 4916655952145825   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then VAT table shouldn't display
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124694 @bus @change_vat_number
  Scenario: 124694 act as a partner and then go to billing information section, change vat number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then VAT number was saved successfully:
      | VAT number     |
      | FR08410091490  |
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124695 @bus @change_vat_number
  Scenario: 124695 act as a partner and then go to billing information section, change vat number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country          | cc number          |
      | 24     | 50 GB     | United Kingdom   | 4916783606275713   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | FR08410091490  |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124696 @bus @change_vat_number
  Scenario: 124696 act as a partner and then go to billing information section, change vat number with invalid VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 24     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number     |
      | invalid_number |
    Then Fail to change VAT number:
    """
    VAT number is invalid. Please try again.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124697 @bus @change_vat_number
  Scenario: 124697 act as a partner and then go to billing information section, change vat number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I change VAT number to:
      | VAT number   |
      | @blank_value |
    Then VAT number was saved successfully:
      | VAT number   |
      | @blank_value |
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.124698 @bus @change_vat_number
  Scenario: 124698 act as a partner and then go to billing information section, delete vat number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          | vat number    |
      | 24     | 50 GB     | France   | 4485393141463880   | FR08410091490 |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    When I act as newly created partner account
    When I navigate to Billing Information section from bus admin console page
    Then I delete VAT number
    Then VAT number was deleted successfully
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    When I stop masquerading
    And I search and delete partner account by newly created partner company name

  #
  #Partner Admin Change/Change Payment Information
  #
  @TC.124699 @bus @change_vat_number
  Scenario: 124699 Partner admin change payment information section, set vat number with valid value
    When I add a new MozyPro partner:
      | period | base plan | country  | net terms          |
      | 24     | 50 GB     | France   | yes                |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | country |
      | China   |
    And I save payment information changes with default password
    Then I change VAT number from change payment information section:
      | VAT Number    |
      | FR08410091490 |
    And I save payment information changes with default password
    Then Contact country and billing information should be updated:
    """
    Your contact country and billing information was successfully updated.
    """
    Then API* Aria account should be:
      | taxpayer_id   |
      | FR08410091490 |
    And API* Aria tax exempt status for newly created partner aria id should be State/Province and Federal/National Tax Exempt
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124700 @bus @change_vat_number
  Scenario: 124700 Partner admin change payment information section, set vat number with invalid value
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 12     | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | country |
      | China   |
    And I save payment information changes with default password
    Then I change VAT number from change payment information section:
      | VAT Number     |
      | invalid_number |
    And I save payment information changes with default password
    Then Contact country and billing information shouldn't be updated:
    """
     VAT number is not valid
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124701 @bus @change_vat_number
  Scenario: 124701 Partner admin change payment information section, set vat number with other country's VAT number
    When I add a new MozyPro partner:
      | period | base plan | country  | cc number          |
      | 1      | 50 GB     | France   | 4485393141463880   |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | country |
      | China   |
    And I save payment information changes with default password
    Then I change VAT number from change payment information section:
      | VAT Number     |
      | DE812321109    |
    And I save payment information changes with default password
    Then Contact country and billing information shouldn't be updated:
    """
     VAT number is not valid
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.124702 @bus @change_vat_number
  Scenario: 124702 Partner admin change payment information section, set vat number with blank value
    When I add a new MozyPro partner:
      | period | base plan | country  | net terms          |
      | 24     | 100 GB    | France   | yes                |
    Then New partner should be created
    And I get partner aria id
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    And I activate new partner admin with default password
    And I log out bus admin console
    And I log in bus admin console as new partner admin
    And I navigate to Change Payment Information section from bus admin console page
    And I update payment contact information to:
      | country |
      | China   |
    And I save payment information changes with default password
    Then I change VAT number from change payment information section:
      | VAT Number    |
      | @blank_space  |
    And I update payment contact information to:
      | country |
      | France  |
    And I save payment information changes with default password
    Then Contact country and billing information should be updated:
    """
    Your contact country and billing information was successfully updated.
    """
    Then API* Aria account should be:
      | taxpayer_id  |
      |              |
    And API* Aria tax exempt status for newly created partner aria id should be No tax exemption
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I delete partner account

  @TC.126158 @bus @vat @tasks_p3
  Scenario: 126158 Create data shuttle to see if any VAT is applied or not
    When I add a new MozyPro partner:
      | period | base plan | create under   | country | cc number        |
      | 24     | 50 GB     | MozyPro France | France  | 4485393141463880 |
    Then New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name           | storage_type | storage_limit | devices |
      | TC.126158.User | Desktop      | 10            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name    | machine_type |
      | @user_email | Machine1_126158 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    And Data shuttle order should be created
    And Data shuttle order should have VAT fee
    Then I cancel the latest data shuttle order for newly created partner company name
    When I search partner by newly created partner company name
    And I open partner details by partner name in header
    And I change the partner contact information to:
      | VAT Number:      |
      | FR08410091490    |
    Then Partner contact information is changed
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    And Data shuttle order should be created
    And Data shuttle order should not have VAT fee
    And I search partner by newly created partner company name
    And I open partner details by partner name in header
    And I delete partner account

  @TC.126159 @bus @vat @tasks_p3
  Scenario: 126159 a partner with or without VAT number, set renewal to see if VAT works
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | country        | coupon                | vat number  |
      | 1      | 10 GB     | MozyPro UK   | yes         | yes       | United Kingdom | <%=QA_ENV['coupon']%> | GB117223643 |
    And New partner should be created
    And I activate new partner admin with default password
    And I act as newly created partner
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.126159.User1 | Desktop      | 10            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name      | machine_type |
      | @user_email | Machine1_126159_1 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    And Data shuttle order should be created
    And Data shuttle order should not have VAT fee
    When I search partner by newly created partner company name
    And I open partner details by partner name in header
    And I clear VAT number for the partner contact information
    Then Partner contact information is changed
    And I act as newly created partner
    And I add new user(s):
      | name            | storage_type | storage_limit | devices |
      | TC.126159.User2 | Desktop      | 10            | 2       |
    Then 1 new user should be created
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    When I update the user password to default password
    And I use keyless activation to activate devices
      | user_email  | machine_name      | machine_type |
      | @user_email | Machine1_126159_2 | Desktop      |
    And I upload data to device by batch
      | machine_id                         | GB |
      | <%=@new_clients.first.machine_id%> | 1  |
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 1     |
    And Data shuttle order should be created
    And Data shuttle order should have VAT fee
    And I search partner by newly created partner company name
    And I open partner details by partner name in header
    And I delete partner account