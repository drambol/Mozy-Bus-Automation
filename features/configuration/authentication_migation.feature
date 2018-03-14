Feature: Default created partners are using Mozy authentication

  Default created partners are using Mozy authentication,
  and NO ‘Generate random passwords for users’& ‘Send users emails for their passwords’ options check boxes are displayed.

  Background:
    Given I log in bus admin console as administrator

  @TC.17460 @bus @2.1 @direct_ldap_integration @authentication_migration @regression @core_function
  Scenario: 17460 Default created partners are using Mozy authentication
    When I add a new MozyPro partner:
      | period |
      | 1      |
    Then New partner should be created
    Then I change root role to Business Root
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    Then I should see Mozy auth selected
