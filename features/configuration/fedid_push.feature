
Feature: FedID push

  As an Mozy administrator
  I want to use fedid push authentication policy in BUS to sync users.
  So that the partner admin can manage their users easily

  Background:
    Given I log in bus admin console as administrator

  @TC.121644 @ui @bus @2.11 @ldap_push_integration @connection_settings @sync_rules @regression @core_function
  Scenario: ETS 439979 440012 Check UI for connection settings and sync_rules
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 18    | 100 GB      |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to User Group List section from bus admin console page
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | pm   | Shared               | 5               | Shared              | 10             |
    Then pm user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | qa   | Shared               | 5               | Shared              | 10             |
    Then qa user group should be created

    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I save the changes
    Then Authentication Policy has been updated successfully

    When I click Connection Settings tab
    And Next Sync should be invisible
    And Bind Username should be invisible
    And Bind Password should be invisible
    And Test Connection should be invisible

    # Scenario: 121638 Certificate only enabled with StartTLS/LDAPS enabled
    And I select Protocol as No SSL
    Then certificate text field is disabled
    And I select Protocol as StartTLS
    Then certificate text field is enabled
    And I select Protocol as LDAPS
    Then certificate text field is enabled

    # Scenario: 121636 121637 121639 121641 121642 Valid Host, Protocol, Port, Cert, Base DN can be saved
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                    |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com |
    And I save the changes
    Then server connection settings information should include
      | Server Host          | Protocol | SSL Cert | Port | Base DN                   |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com|

    And I input server connection settings
      | Server Host          | Protocol   |   SSL Cert   | Port | Base DN                    |
      | 10.135.16.154        | StartTLS   | 1qazxsw23edc | 389  | dc=qa5, dc=mozyops, dc=com |
    And I save the changes
    Then server connection settings information should include
      | Server Host          | Protocol   |   SSL Cert   | Port | Base DN                    |
      | 10.135.16.154        | StartTLS   | 1qazxsw23edc | 389  | dc=qa5, dc=mozyops, dc=com |

    And I input server connection settings
      | Server Host          | Protocol |   SSL Cert   | Port | Base DN                        |
      | 10.29.103.120        |  LDAPS   | abcdefghijkl | 389  | dc=mtdev, dc=mozyops, dc=local |
    And I save the changes
    Then server connection settings information should include
      | Server Host          | Protocol |   SSL Cert   | Port | Base DN                        |
      | 10.29.103.120        |  LDAPS   | abcdefghijkl | 389  | dc=mtdev, dc=mozyops, dc=local |

    When I click Sync Rules tab
    And Scheduled Sync should be invisible
    And Sync Now should be invisible

    # Scenario: 121621 Invalid LDAP Query should not be saved successfully
    And I add 1 new provision rules:
      | rule         |       group           |
      | dev_test*    | (default user group)  |
    And I save the changes
    Then The save error message should be:
      | Save failed                         |
      | 400 Invalid LDAP queries: dev_test* |
    And I delete all the rules
    And I add 1 new deprovision rules:
      | rule         |    action      |
      | qa_test*     |    Delete      |
    And I save the changes
    Then The save error message should be:
      | Save failed                    |
      | 400 Invalid LDAP queries: qa_test* |
    And I delete all the rules

    And I add 3 new deprovision rules:
      | rule         | action         |
      | cn=dev_test* | Delete         |
      | cn=pm_test*  | Suspend        |
      | cn=qa_test*  | Take no action |
    And I save the changes
    Then Authentication Policy has been updated successfully
    # Scenario: 121629 User provision - Local groups dropdown list check
    And I add 1 new provision rules:
      | rule         | group|
      | cn=dev_test* |      |
    Then There should be 4 provision items:
      | (default user group) | dev | pm | qa |
    And I delete all the rules
    # Scenario: 121625 User provision - Rules ordering interaction
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
    Then The provision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the provision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new provision rules order should be:
      | rule         | group|
      | cn=pm_test*  | pm   |
      | cn=qa_test*  | qa   |
      | cn=dev_test* | dev  |
    When I save the changes
    Then Authentication Policy has been updated successfully
    And I delete 3 provision rules
    And I save the changes
    # Scenario: 121624 User provision - Delete rules
    When I click Sync Rules tab
    And I add 3 new provision rules:
      | rule         | group|
      | cn=dev_test* | dev  |
      | cn=pm_test*  | dev  |
      | cn=qa_test*  | dev  |
    And I delete 1 provision rules
    And I save the changes
    Then The provision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 provision rules
    And I save the changes
    Then The provision rule number is 0
    And Authentication Policy has been updated successfully
    # Scenario: 121626 UserDestruction - UI Components check
    When I click Sync Rules tab
    And I add 1 new deprovision rules:
      | rule         | action |
      | cn=dev_test* |        |
    Then There should be 3 deprovision items:
      | Take no action | Suspend | Delete |
    And The selected deprovision option is Take no action
    And I delete all the rules
    # Scenario: 121628 UserDestruction - Rules ordering interaction
    When I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action  |
      | cn=dev_test* | Delete  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
    Then The deprovision order icon should be correct
      | up hidden | down        | delete |
      | up        | down        | delete |
      | up        | down hidden | delete |
    When I change the deprovision order by the following rule:
      | 1 | down |
      | 2 |      |
      | 3 | up   |
    Then The new deprovision rules order should be:
      | rule         | action  |
      | cn=pm_test*  | Delete  |
      | cn=qa_test*  | Delete  |
      | cn=dev_test* | Delete  |
    When I save the changes
    Then Authentication Policy has been updated successfully
    And I delete 3 deprovision rules
    And I save the changes
    # Scenario: 121627 UserDestruction - Rules deletion
    When I click Sync Rules tab
    And I add 3 new deprovision rules:
      | rule         | action |
      | cn=dev_test* | Delete |
      | cn=pm_test*  | Delete |
      | cn=qa_test*  | Delete |
    And I delete 1 deprovision rules
    When I save the changes
    Then The deprovision rule number is 2
    And Authentication Policy has been updated successfully
    When I delete 2 deprovision rules
    And I save the changes
    Then The deprovision rule number is 0
    And Authentication Policy has been updated successfully
    When I stop masquerading

    And I search and delete partner account by newly created partner company name


  @TC.121630 @ui @bus @2.11 @ldap_push_integration @attribute_mapping @SAML_Authentication @sync_rules @regression @core_function
  Scenario: 121630 121631 121645 121646 121647 121648 120740 120744 Check UI for attribute mapping, SAML Authentication, sync rules
  # Scenario: 121630 Happy Path: Initial values for SAML Authentication for a clean partner
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 18    | 100 GB      | yes       |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I input server connection settings
      | Server Host   | Protocol | SSL Cert | Port | Base DN                    |
      | 10.135.16.154 | No SSL   |          | 389  | dc=qa5, dc=mozyops, dc=com |
    And I click Sync Rules tab
    And I uncheck enable synchronization safeguards in Sync Rules tab
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I click Connection Settings tab
    Then The sync status result should be:
      | Sync Status | Never Run          |
      | Sync Result |                    |

    When I click SAML Authentication tab
    Then SAML authentication information should include
      | URL                        | Endpoint | Certificate |
      |                            |          |             |
    # Scenario: 121645 121646 121647 Components check for 'URL','Endpoint','Certificate'
    And I input SAML authentication information
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |
    And I save the SAML Authentication information
    Then SAML authentication information should include
      | URL                        | Endpoint                    | Certificate      |
      |sso.connect.pingidentity.com|sso.connect.pingidentity.com | abcdefghijkl     |
    # Scenario: 121630 Happy Path: Initial values for attribute mapping for a clean partner
    When I click Attribute Mapping tab
    Then The layout of attribute should:
      | Mozy              | Username:      | Name:      |Fixed Attribute |
      | Directory Service | mail           |  cn        |                |
    # Scenario: 121631 Components check for 'Username','Name','Fixed Attribute'
    And I set the fixed attribute to uid
    And I save the changes
    When I click Attribute Mapping tab
    Then The layout of attribute should:
      | Mozy              | Username:      | Name:      |Fixed Attribute |
      | Directory Service | mail           |  cn        |      uid       |
    And I clear the fixed attribute
    And I clear the user name
    And I clear the name
    And I save the changes
    Then I click Attribute Mapping tab
    And The layout of attribute should:
      | Mozy              | Username:      | Name:      |Fixed Attribute |
      | Directory Service | mail           |  cn        |                |

    When I click Sync Rules tab
    And I Choose to delete users if missing from LDAP for 80 days
    And I save the changes
    And I refresh the authentication policy section
    And The chosen rule should be delete users if missing from LDAP for 80 days

    And I clear the user sync information
    And I Choose to suspend users if missing from LDAP for 60 days
    And I save the changes
    And I refresh the authentication policy section
    And The chosen rule should be suspend users if missing from LDAP for 60 days

    And I clear the user sync information
    And I save the changes

    When I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.121635 @121640 @121643 @ui @bus @ldap_push_integration @connection_settings @sync_rules @regression @tasks_p3
  Scenario: 121635 - Invalid Port can not be saved in Connection Settings
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 18    | 100 GB      |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to User Group List section from bus admin console page
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | dev  | Shared               | 5               | Shared              | 10             |
    Then dev user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | pm   | Shared               | 5               | Shared              | 10             |
    Then pm user group should be created
    And I add a new Itemized user group:
      | name | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | qa   | Shared               | 5               | Shared              | 10             |
    Then qa user group should be created

    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I save the changes
    Then Authentication Policy has been updated successfully

    When I click Connection Settings tab
    # Scenario: 121635 Invalid Port can not be saved in Connection Settings
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                    |
      | ad01.qa5.mozyops.com | No SSL   |          | 0    | dc=qa5, dc=mozyops, dc=com |
    And I save the changes
    Then The save error message should be:
      | Save failed                |
      | 400 ERROR: Invalid port: 0 |
    # Scenario: 121640 Invalid Server Host can not be saved in Connection Settings
    And I input server connection settings
      | Server Host | Protocol | SSL Cert | Port | Base DN                    |
      | 10.34.9.    | No SSL   |          | 389    | dc=qa5, dc=mozyops, dc=com |
    And I save the changes
    Then The save error message should be:
      | Save failed                         |
      | 400 ERROR: Invalid hosts : 10.34.9. |
    # Scenario: 121643 Invalid Base DN can be saved in Connection Settings
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN              |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | "basedntest", "1234" |
    And I save the changes
    Then server connection settings information should include
      | Server Host          | Protocol | SSL Cert | Port | Base DN              |
      | ad01.qa5.mozyops.com | No SSL   |          | 389  | "basedntest", "1234" |


