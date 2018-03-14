Feature: Configurable Retention Partner Setting (111550)

  As a Mozy SE, I want to restrict my customer's retention period to something less than what Mozy offers for my given
  plan, so they can manage their e-discovery exposure.

#  Success Criteria:
#  * Add a partner level parameter for all partners except Home.

#  * Paramater is adjustable down to 1 day and up to their products natural limit. Adjustments are made in 1 day
#  increments.

#  * Mozy Mac and Win client will honor the setting and mask any files outside the retention period

#  * Web and mobile client will honor the setting and mask any files outside of the retention period

#  Risks
#  * Partner settings, Client Controller (get_config)

  Background:
    Given I log in bus admin console as administrator

  @TC.120809 @retention @environment_dependent @partner_setting @bus @regression @core_function @ROR_smoke
  Scenario: 120809 Configurable Retention - MozyPro
    When I add a new MozyPro partner:
      | period |
      | 1      |
    Then New partner should be created
    #MozyPro partners default retention is 60 days
    And I get the partner_id
    Then I try all positive retention date for MozyPro Direct
    Then I try all negative retention date for MozyPro Direct
    #Delete partner when done with validating retention period
    Then I delete partner account

  @TC.120810 @retention @environment_dependent @partner_setting @bus @regression @core_function
  Scenario: 120810 Configurable Retention - MozyEnterprise
    When I add a new MozyEnterprise partner:
      | period |
      | 12      |
    Then New partner should be created
    #Enterprise partners default retention is 90 days
    And I get the partner_id
    Then I try all positive retention date for Enterprise
    Then I try all negative retention date for Enterprise
    #Delete partner when done with validating retention period
    Then I delete partner account

  @TC.120811 @retention @environment_dependent @partner_setting @bus @regression @core_function
  Scenario: 120811 Configurable Retention - OEM
    When I add a new OEM partner:
      | period |
      | 1      |
    Then New partner should be created
    Then I stop masquerading as sub partner
    And I stop masquerading
    And I search partner by newly created subpartner company name
    And I view partner details by newly created subpartner company name
    #OEM partners default retention is 30 days
    And I get the partner_id
    Then I try all positive retention date for OEM
    Then I try all negative retention date for OEM
    #Delete partner when done with validating retention period
    Then I delete partner account
