# horizon can only be tested in qa5
Feature: Manage Horizon related settings

  As an Mozy administrator
  I want to leverage Horizon service as a 3rd party SSO solution
  So that my users can be authenticated using domain credentials

  Background:
    Given I log in bus admin console as administrator
    When I act as partner by:
      | email                   |
      | encoding_fedid@auto.com |
    And I navigate to Authentication Policy section from bus admin console page

#  @TC.17470 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent
#  Scenario: 17470 Successfully verify 'Test Connection' button should work with valid organization name
#    When I use Directory Service as authentication provider
#    And I select Horizon Manager with organization name mozyqa2
#    And I Test Connection for Horizon Manager
#    Then Horizon Manager test connection message should be Test passed.

  @TC.17471 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent @regression @core_function
  Scenario: 17471 Verify 'Test Connection' button should work with invalid organization name given
    When I use Directory Service as authentication provider
    And I select Horizon Manager with organization name 1ziygbnk
    And I Test Connection for Horizon Manager
    Then Horizon Manager test connection message should be Test failed.

#  @TC.17472 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent
#  Scenario: 17472 Can successfully load Horizon Manager's attributes with valid organization name
#    When I use Directory Service as authentication provider
#    And I select Horizon Manager with organization name mozyqa2
#    And I click SAML Authentication tab
#    And I clear SAML Authentication information exists
#    And I load attributes
#    Then SAML authentication information should include
#      | URL                                                                   | Endpoint          | Certificate           |
#      | mozyqa2.horizonmanager.com/SAAS/API/1.0/GET/federation/request?s=1876 | horizonmanager.com| glbv7YsYBdLHAtbX2Geg==|
#    And I save the SAML Authentication information
#    Then SAML authentication information should include
#      | URL                                                                   | Endpoint          | Certificate           |
#      | mozyqa2.horizonmanager.com/SAAS/API/1.0/GET/federation/request?s=1876 | horizonmanager.com| glbv7YsYBdLHAtbX2Geg==|

  @TC.17473 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent @regression @core_function
  Scenario: 17473 Failure will occur in a reasonable time loading attributes with invalid organization name
    When I use Directory Service as authentication provider
    And I select Horizon Manager with organization name 4ihlgoiyzhbje
    And I click SAML Authentication tab
    And I load attributes
    Then Horizon Manager load attribute information should be Failed to load attributes from Horizon

  @TC.17474 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent @regression @core_function
  Scenario: 17474 Pop-up window will be prompted loading attributes with empty organization name
    When I use Directory Service as authentication provider
    And I select Horizon Manager with organization name nothing
    And I click SAML Authentication tab
    Then I load attributes and I should see an JS alert with message Oranization name (Org Name) is not specified.

  @TC.17475 @bus @2.1 @direct_ldap_integration @authentication_migration @qa5 @env_dependent @regression @core_function
  Scenario: 17475 User mapping tab is disabled when managing horizon manager
    When I use Directory Service as authentication provider
    Then user mapping tab should be disabled
