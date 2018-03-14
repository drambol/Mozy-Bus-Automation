Feature: Quick Links section & Link removal from left navigation

    #
    # Base case for nav link removal
    #   Redmine: 99538
    #
    @TC.21175 @bus @2.5 @nav_link_removal @mozyenterprisedps @regression @core_function
    Scenario: 21175 MozyEnteprise DPS - BUS Admin UI - Nav link removal
      When I log in bus admin console as administrator
      And I add a new MozyEnterprise DPS partner:
        | period | base plan | sales channel | net terms |
        | 12     | 2         | Velocity      | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name


    #
    #   Cases for bundled Pro/Metallic Reseller/Enterprise
    #
    @TC.21176 @bus @2.5 @nav_link_removal @mozypro @regression @core_function
    Scenario: 21176 MozyPro - BUS Admin UI - Nav link removal
      When I log in bus admin console as administrator
      And I add a new MozyPro partner:
        | period | base plan | server plan | net terms |
        | 1      | 100 GB    | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21178 @bus @2.5 @nav_link_removal @metallic @regression @core_function
    Scenario: 21178 Metallic Reseller - BUS Admin UI - Nav link removal
      When I log in bus admin console as administrator
      And I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | net terms |
        | 12     | Gold          | 750            | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21179 @bus @2.5 @nav_link_removal @mozyenterprise @regression @core_function
    Scenario: 21179 MozyEnterprise BUS Admin UI - Nav link removal
      When I log in bus admin console as administrator
      And I add a new MozyEnterprise partner:
        | period | users | server plan | net terms |
        | 12     | 10    | 250 GB      | yes       |
      And New partner should be created
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    #
    #   Cases for itemized Pro/Reseller
    #
    @TC.21182 @itemized @bus @2.5 @nav_link_removal @mozypro @env_dependent @regression @core_function
    Scenario: 21182 Pooled Storage - MozyPro Itemized - BUS Admin UI -  Nav link removal
      When I log in bus admin console as administrator
      When I act as partner by:
        | email                                 |
        | redacted-608@notarealdomain.mozy.com  |
      And navigation items should be removed
      And I stop masquerading

    @TC.21183 @itemized @bus @2.5 @nav_link_removal @reseller @env_dependent @regression @core_function
    Scenario: 21183 Pooled Storage - Reseller Itemized - BUS Admin UI -  Nav link removal
      When I log in bus admin console as administrator
      When I act as partner by:
        | email                                 |
        | redacted-303@notarealdomain.mozy.com  |
      And navigation items should be removed
      And I stop masquerading

    #
    # nav removal - for acct through phoenix
    #   Redmine: 99538
    #
    @TC.21177 @bus @2.5 @nav_link_removal @mozypro @regression @core_function
    Scenario: 21177 MozyPro - Phoenix UI - Left nav link removal
      When I am at dom selection point:
      And I add a phoenix Pro partner:
        | period | base plan | country       | server plan |
        | 1      | 100 GB    | United States | yes         |
      And the partner is successfully added.
      And I log in bus admin console as administrator
      And I search partner by:
        | name          | filter |
        | @company_name | None   |
      And I view partner details by newly created partner company name
      And I act as newly created partner
      And navigation items should be removed
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    #
    # Base case for Quick Link section
    #   Section heading is only a title, as each link goes to different modules
    #   Redmine: 99171
    #
    @TC.21295 @bus @2.5 @quick_link @mozyenterprisedps @regression @core_function
    Scenario: 21295 MozyEnteprise DPS - BUS Admin UI - New Quick Link Section
      When I log in bus admin console as administrator
      And I add a new MozyEnterprise DPS partner:
        | period | base plan | sales channel | net terms |
        | 12     | 2         | Velocity      | yes       |
      And New partner should be created
      And I act as newly created partner
      And new section & navigation items are present for MozyEnterprise DPS partner
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    #
    #   Cases for bundled Pro/Metallic Reseller/Enterprise
    #
    @TC.21296 @bus @2.5 @quick_link @mozypro @regression @core_function
    Scenario: 21296 MozyPro - BUS Admin UI - New Quick Link Section
      When I log in bus admin console as administrator
      And I add a new MozyPro partner:
        | period | base plan | server plan | net terms |
        | 1      | 100 GB    | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And new section & navigation items are present for MozyPro partner
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21298 @bus @2.5 @quick_link @metallic @regression @core_function
    Scenario: 21298 Metallic Reseller - BUS Admin UI - New Quick Link Section
      When I log in bus admin console as administrator
      And I add a new Reseller partner:
        | period | reseller type | reseller quota | server plan | net terms |
        | 12     | Gold          | 750            | yes         | yes       |
      And New partner should be created
      And I act as newly created partner
      And new section & navigation items are present for Reseller partner
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    @TC.21299 @bus @2.5 @quick_link @mozyenterprise @regression @core_function
    Scenario: 21299 MozyEnterprise BUS Admin UI - New Quick Link Section
      When I log in bus admin console as administrator
      And I add a new MozyEnterprise partner:
        | period | users | server plan | net terms |
        | 12     | 10    | 250 GB      | yes       |
      And New partner should be created
      And I act as newly created partner
      And new section & navigation items are present for MozyEnterprise partner
      And I stop masquerading
      And I search and delete partner account by newly created partner company name

    #
    #   Cases for itemized Pro/Reseller
    #
    @TC.21300 @itemized  @bus @2.5 @quick_link @mozypro @env_dependent @regression @core_function
    Scenario: 21300 Pooled Storage - MozyPro Itemized - BUS Admin UI - New Quick Links Section
      When I log in bus admin console as administrator
      When I act as partner by:
        | email                                 |
        | redacted-608@notarealdomain.mozy.com  |
      And new section & navigation items are present for Itemized partner
      And I stop masquerading

    @TC.21301 @itemized  @bus @2.5 @quick_link @reseller @env_dependent @regression @core_function
    Scenario: 21301 Pooled Storage - Reseller - BUS Admin UI - New Quick Links Section
      When I log in bus admin console as administrator
      When I act as partner by:
        | email                                 |
        | redacted-303@notarealdomain.mozy.com  |
      And new section & navigation items are present for Itemized partner
      And I stop masquerading

      #
      # quick link section - through phoenix
      #   Redmine: 99171
      #
      @TC.21297  @bus @2.5 @quick_link @mozypro @phoenix @regression @core_function
      Scenario: 21297 MozyPro - Phoenix UI - New Quick Link Section
        When I am at dom selection point:
        And I add a phoenix Pro partner:
          | period | base plan | country       | server plan |
          | 1      | 100 GB    | United States | yes         |
        And the partner is successfully added.
        And I log in bus admin console as administrator
        And I search partner by:
          | name          | filter |
          | @company_name | None   |
        And I view partner details by newly created partner company name
        And I act as newly created partner
        And new section & navigation items are present for MozyPro partner
        And I stop masquerading
        And I search and delete partner account by newly created partner company name
