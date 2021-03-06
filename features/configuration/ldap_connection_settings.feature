Feature: Manage Horizon related settings

  As an Mozy administrator
  I want to leverage Horizon service as a 3rd party SSO solution
  So that my users can be authenticated using domain credentials

  Background:
    Given I log in bus admin console as administrator

  @TC.17476 @bus @2.1 @direct_ldap_integration @authentication_migration @regression @core_function
  Scenario: 17476 17477 17825 17478 17479 17480 17482 17484 17487 Verify manage ldap settings works
    # Scenario: 17476 Successfully verify 'Test Connection' button should work with valid host
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 8     | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to 10.29.103.120 on port 389 using No SSL.
    And I save the Connection Settings information
    Then server connection settings information should include
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    # Scenario: 17825 'Test Connection' should report invalid credentials error
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username            | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | fake@mtdev.mozypro.local | daf145gvi     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.
    # Scenario: 17478 Successfully verify 'Test Connection' button should work with valid domain name input
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test passed. Successfully connected to 10.29.103.120 on port 389 using No SSL.
    And I save the Connection Settings information
    Then server connection settings information should include
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    # Scenario: 17479 Host input should reject invalid parameters
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.34.9.             | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | 400 ERROR: Invalid hosts : 10.34.9. |
    # Scenario: 17480 Port input should reject invalid parameters
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 0    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | 400 ERROR: Invalid port: 0 |
    # Scenario: 17482 Base Tree should reject invalid empty inputs
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  |                           | leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then AD server test connection message should be Test failed. Error: AD base DN is not provided.
    # Scenario: 17484 Certificate should only be enabled with SSL enabled
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click Connection Settings tab
    And I select Protocol as No SSL
    Then certificate text field is disabled
    And I select Protocol as StartTLS
    Then certificate text field is enabled
    # Scenario: 17486 17487 Authentication tab should be able to save inputs correctly
    When I use Directory Service as authentication provider
    And I de-select Horizon Manager
    And I click SAML Authentication tab
    And I clear SAML Authentication information exists
    And I input SAML authentication information
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |
    And I save the SAML Authentication information
    Then SAML authentication information should include
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |
    When I stop masquerading
    And I search and delete partner account by newly created partner company name
