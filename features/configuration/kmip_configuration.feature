Feature: BUS-9568 KMIP support for encryption key

  Background:
    Given I log in bus admin console as administrator

  @TC.134000 @bus @kmip @2.33
  Scenario: Mozy-134000: Configure client configuration to KMIP with all fields with valid info: MozyEnterprise
    When I add a new MozyEnterprise partner:
      | period | base plan | root role      | net terms |
      | 12     | 2         | ADREntTestRole | yes       |
    And New partner should be created
    When I act as newly created partner account

    When I create a new client config:
      | name                      | type   | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | kmip-server-client-config | Server | true     | 10.29.111.6 | 9443              | test     | 5432                 | group 1        |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config kmip-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | true     | 10.29.111.6 | 9443              | test     | 5432                 | group 1        |
    And I cancel update client configuration

    When I create a new client config:
      | name                       | type    | kmip key | address         | KMIP service port | Trust CA | NAE-XML service port | Key group name  |
      | kmip-desktop-client-config | Desktop | true     | farmers.kms.com | 9442              | CA       | 5431                 | dev;qa;it;admin |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config kmip-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | kmip key | address         | KMIP service port | Trust CA | NAE-XML service port | Key group name  |
      | true     | farmers.kms.com | 9442              | CA       | 5431                 | dev;qa;it;admin |

    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.134002 @bus @kmip @2.33
  Scenario: Mozy-134002:Configure KMIP option with all fields left blank
    When I add a new MozyEnterprise partner:
      | period | base plan | root role      | net terms |
      | 12     | 2         | ADREntTestRole | yes       |
    And New partner should be created
    When I act as newly created partner account

    When I create a new client config:
      | name                | type    | kmip key | address | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | empty-client-config | Desktop | true     |         | 9443              | test     | 5432                 | group 1        |
    Then client configuration section message should be KMS address cannot be left blank
    And I cancel update client configuration

    When I create a new client config:
      | name                | type   | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | empty-client-config | Server | true     | 10.29.111.6 |                   |          | 5432                 | group 1        |
    Then client configuration section message should be KMS port cannot be left blank
    And I cancel update client configuration

    When I create a new client config:
      | name                | type   | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | empty-client-config | Server | true     | 10.29.111.6 | 9443              |          |                      | group 1        |
    Then client configuration section message should be NAE service port cannot be left blank
    And I cancel update client configuration

    When I create a new client config:
      | name                | type    | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | empty-client-config | Desktop | true     | 10.29.111.6 | 9443              |          | 5432                 |                |
    Then client configuration section message should be Group name cannot be left blank

  @TC.134003 @bus @kmip @2.33 @BUG.BUS-9622
  Scenario: Mozy-134003:Negative test of each of the KMIP fields
    When I add a new MozyEnterprise partner:
      | period | base plan | root role      | net terms |
      | 12     | 2         | ADREntTestRole | yes       |
    And New partner should be created
    When I act as newly created partner account

    When I create a new client config:
      | name                  | type   | kmip key | address | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | invalid-client-config | Server | true     | 5678    | abc               | 123      | ret                  | ;;;            |
    Then client configuration section message should be Your configuration was saved.

  @TC.134005 @bus @kmip @2.33
  Scenario: Mozy-134005:KMS Authentication field help info test
    When I add a new MozyEnterprise partner:
      | period | base plan | root role      | net terms |
      | 12     | 2         | ADREntTestRole | yes       |
    And New partner should be created
    When I act as newly created partner account

    When I create a new client config:
      | name                      | type   | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | kmip-server-client-config | Server | true     | 10.29.111.6 | 9443              | test     | 5432                 | group 1        |
    Then client configuration section message should be Your configuration was saved.

    And I edit the new created config kmip-server-client-config
    And I click tab Preferences

    Then kmip client certificate issuer help icon text is more
    And kmip nae service port help icon text is more
    And kmip group name help icon text is more

    When I click help icon for kmip client certificate issuer
    Then KMIP client certificate issuer help message should be:
     """
      By entering the client certificate issuer, MozyEnterprise will locate client certificate more quickly.
     """
    And kmip client certificate issuer help icon text is less

    When I click help icon for kmip nae service port
    Then KMIP nae service port help message should be:
     """
      If users use SafeNet KeySecure server and need admin restore function, the NAE services port must be set.
     """
    And kmip nae service port help icon text is less

    When I click help icon for kmip group name
    Then KMIP group name help message should be:
     """
      If users use SafeNet KeySecure server and need admin restore function, the group name must be set.
     """
    And kmip group name help icon text is less

  @TC.134017 @bus @kmip @2.33
  Scenario: Mozy-134000:Configure client configuration to KMIP with all fields with valid info: OEM
    When I add a new OEM partner:
      | Root role         | Security | Company Type     |
      | OEM Partner Admin | HIPAA    | Service Provider |
    Then New partner should be created
    When I act as newly created partner account

    When I create a new client config:
      | name                      | type   | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | kmip-server-client-config | Server | true     | 10.29.111.6 | 9443              | test     | 5432                 | group 1        |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config kmip-server-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | kmip key | address     | KMIP service port | Trust CA | NAE-XML service port | Key group name |
      | true     | 10.29.111.6 | 9443              | test     | 5432                 | group 1        |
    And I cancel update client configuration

    When I create a new client config:
      | name                       | type    | kmip key | address         | KMIP service port | Trust CA | NAE-XML service port | Key group name  |
      | kmip-desktop-client-config | Desktop | true     | farmers.kms.com | 9442              | CA       | 5431                 | dev;qa;it;admin |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config kmip-desktop-client-config
    And I click tab Preferences
    Then preferences settings should be:
      | kmip key | address         | KMIP service port | Trust CA | NAE-XML service port | Key group name  |
      | true     | farmers.kms.com | 9442              | CA       | 5431                 | dev;qa;it;admin |
