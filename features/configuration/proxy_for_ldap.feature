# now only qa5 setup bds-boot, so this can only run on qa5
Feature: Proxy for LDAP queries

  As the Operations/Security team
  We want outbound LDAP requests to go through a dynamically-updated proxy server
  So that we don't have to punch holes in our firewall for every FedId customer

  Background:
    Given I log in bus admin console as administrator

  @FID11.1006 @TC.19194 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent @regression @core_function
  Scenario: 19194 [Test connection][UI][N]Test failed with 400 when I input invalid data
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password |
      | 10.29.99    | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | abc!@#123     |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid hosts|
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @FID11.1006 @TC.19196 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent @regression @core_function
  Scenario: 19196 [Test connection][UI][N]Test failed with 200 when I input valid data but meet with other failure
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    When I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    Then I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                      | Bind Username             | Bind Password  |
      | 10.29.103.120 | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local | admin@mtdev.mozypro.local | wrong password |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test failed. Error: Could not connect to the AD server. Reason: BIND failed. Please verify you entered the correct BIND settings.
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @FID11.1006 @TC.19203 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19203 [Update whitelists][P]The whitelist(sockd.conf) add 1 item after adding 1 new IP/port in the UI
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    And I get the full whitelist into new_whitelist
    Then 3 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    And The new Server Host and Port should be the same as input according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                     | Bind Username            | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19204 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19204 [Update whitelists][P]The whitelist delete 1 item after deleting 1 new IP/port
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 3 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                     | Bind Username            | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19205 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19205 [Update whitelists][P]The whitelist is updated after updating 1 new IP/port
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are updated to the whitelist according to old_whitelist and new_whitelist
    And The new Server Host and Port should be the same as input according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                     | Bind Username            | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19206 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19206 [Update whitelists][N]The whitelist should stay intact if I save the changes multi times
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                     | Bind Username            | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into old_whitelist
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are updated to the whitelist according to old_whitelist and new_whitelist
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19207 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19207 [Update whitelists][P]The whitelist add 2 items after adding different new IP/port in two partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | @host_address        | No SSL   |          | @port  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19208 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19208 [Update whitelists][P]The whitelist add 1 item after adding the same IP/port in two partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19209 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19209 [Update whitelists][P]The whitelist stay intact after deleting 1 IP/port in two partners of same config
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19210 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19210 [Update whitelists][N]The item is deleted in whitelist after deleting all the IP/port in 2 partners
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19211 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19211 [Update whitelists][P]1 item is deleted in the whitelist after updating 1 IP/port to the same as that in another partner
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 2.2.2.2              | No SSL   |          | 222    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are deleted to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19212 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19212 [Update whitelists][P]1 item is added in the whitelist after updating 1 IP/port in one partner when two partners has the same configure
    When I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+1@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I stop masquerading
    And I act as partner by:
      | email                            |
      | congshanl+fedid+proxy+2@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1.1              | No SSL   |          | 111    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 2.2.2.2              | No SSL   |          | 222    | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed

  @FID11.1006 @TC.19213 @bus @2.3 @direct_ldap_integration @proxy @adfs @qa5 @need_test_account @env_dependent
  Scenario: 19213 [Update whitelists][N]The whitelist stay intact if an invalid new IP/port added to it
    When I act as partner by:
      | email                          |
      | congshanl+fedid+proxy@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I click Connection Settings tab
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      |                      | No SSL   |          |      | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I get the full whitelist into old_whitelist
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port   | Base DN                   | Bind Username         | Bind Password |
      | 1.1.1                | No SSL   |          | 65536  | dc=qa5, dc=mozyops, dc=com| leongh@qa5.mozyops.com| QAP@SSw0rd    |
    And I save the changes
    Then The save error message should be:
      | Save failed  |
      | Invalid hosts|
    And I get the full whitelist into new_whitelist
    Then 0 Server Host and Port are added to the whitelist according to old_whitelist and new_whitelist
    When I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   | Bind Username         | Bind Password |
      | 10.29.103.120        | No SSL   |          | 389  | dc=mtdev,dc=mozypro,dc=local| admin@mtdev.mozypro.local| abc!@#123     |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I Test Connection for AD
    Then test connection message should be Test passed
