Feature: Search and list partner

  Background:
    Given I log in bus admin console as administrator

  @TC.789  @bus @2.5 @partner @partner_search @regression @core_function
  Scenario: 789 Search partner by company name
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    When I search partner by newly created partner company name
    Then Partner search results should be:
      | Partner       |
      | @company_name |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an OEM partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.790 @need_test_account @bus @2.5 @partner @partner_search @env_dependent @regression @core_function
  Scenario: 790 Do a search for all partners
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    When I search partner by:
      | name                              |
      | Charter Business Trial - Reserved |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |
    When I search partner by:
      | name          |
      | @company_name |
    Then Partner search results should be:
      | Partner       | Created |
      | @company_name | today   |
    And I search and delete partner account by newly created partner company name

  @TC.791 @bus @2.5 @partner @partner_search @regression @core_function
  Scenario: 791 Do a regular expression search for a partner
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    And New partner should be created
    And I add a new partner external id
    And Partner general information should be:
      | External ID:          |
      | @external_id (change) |
    When I search partner by newly created partner external id
    Then Partner search results should be:
      | External ID  | Partner       | Type    |
      | @external_id | @company_name | MozyPro |
    When I search partner by newly created partner admin email
    Then Partner search results should be:
      | External ID  | Partner       | Root Admin   |
      | @external_id | @company_name | @admin_email |
    And I search and delete partner account by newly created partner company name

  @TC.792 @bus @2.5 @partner @partner_search @regression @core_function
  Scenario: 792 Do a search on all deleted partners
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    And I delete partner account
    When I search partner by:
      | name          | filter         |
      | @company_name | Pending Delete |
    Then Partner search results should be:
      | Partner       |
      | @company_name |

  @TC.795 @bus @2.5 @partner @partner_search @regression @core_function
  Scenario: 795 Search for partners with the business type
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 1      | 10 GB     | yes       |
    Then New partner should be created
    When I search partner by:
      | name          | filter     |
      | @company_name | Businesses |
    Then Partner search results should be:
      | Partner       | Type    |
      | @company_name | MozyPro |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an incompleted partner
  # Test account Quigley-Effertz - Reserved is in QA6 only
  #
  @TC.794 @need_test_account @bus @2.5 @partner @partner_search @env_dependent @regression @core_function
  Scenario: 794 Search incomplete all partners
    When I search partner by:
      | name                       | filter           |
      | Quigley-Effertz - Reserved | Incomplete (all) |
    Then Partner search results should be:
      | Partner                    | Type             |
      | Quigley-Effertz - Reserved | MozyPro Itemized |

  @TC.796 @bus @2.5 @partner @partner_search @regression @core_function
  Scenario: 796 Search for partners with the reseller type
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms |
      | 1      | Platinum      | 500            | yes       |
    And New partner should be created
    When I search partner by:
      | name          | filter   |
      | @company_name | Reseller |
    Then Partner search results should be:
      | Partner       | Type     |
      | @company_name | Reseller |
    And I search and delete partner account by newly created partner company name

  # This test cases requires an OEM partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.797 @need_test_account @bus @2.5 @partner @partner_search @env_dependent @regression @core_function
  Scenario: 797 Search for partners with the OEMs type
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |

  # This test cases requires any existing partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.799 @need_test_account @bus @2.5 @partner @partner_search @env_dependent @regression @core_function
  Scenario: 799 Uncheck the include sub-partners
    When I search partner by:
      | name                              | including sub-partners |
      | Charter Business Trial - Reserved | no                     |
    Then Partner search results should be empty

  # This test cases requires any existing partner
  # Test account Charter Business Trial - Reserved is in QA6 only
  #
  @TC.800 @need_test_account @bus @2.5 @partner @partner_search @env_dependents @regression @core_function
  Scenario: 800 Clear the search results for a partner
    When I search partner by:
      | name                              | filter |
      | Charter Business Trial - Reserved | OEMs   |
    Then Partner search results should be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |
    When I clear partner search results
    Then Partner search results should not be:
      | Partner                           | Type |
      | Charter Business Trial - Reserved | oem  |

  @TC.2188 @bus @others @regression @core_function
  Scenario: 2188 XXS issues and input validation
    When I search partner by <script>alert('foo')</script>
    Then I will see alert('foo') in the search partner input box
