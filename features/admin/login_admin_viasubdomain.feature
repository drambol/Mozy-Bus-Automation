Feature: login admins via subdomain
  Background:
    Given I log in bus admin console as administrator

  @TC.133719 @bus @admin @login_via_subdomain @regression @smoke @qa12
  Scenario: 133719:Not set subdomain and Not set value for root partner, root partner admin login via dell.mozy.com
    # existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't' inherited by mozy dell 't'
    When I use a existing partner:
      | admin email                            |company name                   |partner type |partner id|
      | mozyautotest+root+nosubdomain@emc.com  | DONOT EDIT AutoTestNoSubdomain|OEM          |426420    |
    #use mozy dell's subdomain to login
    When I go to page https://dell.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    # check subdomain if it is dell and domain_name if it is mozy.com according to the config
    Then I check the email content should include:
    """
    https://dell.mozy.com
    """
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your account credentials have been changed.
    # check if it can login bus after changing password
    When I go to page https://dell.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as @partner.company_info.name admin successfully
    # change the password to the original password QAP@SSw0rd
    When I go to page https://dell.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://dell.mozy.com
    """
    When I click reset password link from the email
    And I reset password with QAP@SSw0rd
    Then I will see reset password full massage Your account credentials have been changed.
    When I go to page https://dell.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

  @TC.133721 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133721:Set subdomain and Not set value for root partner, root partner admin login via *.mozy.com of root
# existing partner is under Enterprise(Mozy dell) as root partner with subdomain(qa12autotestsubdomain), allow_mozy_com_domain is 't' inherited by mozy dell 't'
    When I use a existing partner:
      | admin email                          |company name                 |partner type |partner id|
      | mozyautotest+root+subdomain@emc.com  | DONOT EDIT AutoTestSubdomain|OEM          |426421    |
    And I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

  @TC.133723 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133723:Set 'f' for root, Set 'f' for L1, set subdomain Not for root/Not for L1, check bus_domain for L1
    # existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
   # existing partner (DONOT EDIT NoSubdomainSub) is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT NoSubdomainSub
    And I view partner details by DONOT EDIT NoSubdomainSub
    # edit the partner settings for L1 partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    # edit the partner settings for root partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    # use existing L1 partner to check
    When I use a existing partner:
      | admin email                          |company name              |partner type |partner id|
      | mozyautotest+l1+nosubdomain@emc.com  | DONOT EDIT NoSubdomainSub|OEM          |426422    |
    When I go to page https://dell.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://dell.mozypro.com
    """
    When I go to page https://dell.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    #re-change the partner setting to the original
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT NoSubdomainSub
    And I view partner details by DONOT EDIT NoSubdomainSub
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |


  @TC.133724 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133724:Set 'f' for root, Set 'f' for L1, set subdomain Not for root/for L1, check bus_domain for L1
  # existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
 # existing partner (DONOT EDIT SubdomainSub) with 'qa12subdomainsub' is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    # edit partner setting of L1 partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    # edit partner setting of root partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    #use L1 partner to check
    When I use a existing partner:
      | admin email                        |company name            |partner type |partner id|
      | mozyautotest+l1+subdomain@emc.com  | DONOT EDIT SubdomainSub|OEM          |426423    |
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub.mozypro.com
    """
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I click forget your password link
    And I input email mozyautotest+fakesubdomain@emc.com in reset password panel to reset password
    And I search emails by keywords:
      | subject                   | to                                |
      | MozyPro password recovery | mozyautotest+fakesubdomain@emc.com|
    Then I should see 0 email(s)
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    #re-change partner setting to the original
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133828 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133828:Set 'f' for root, Set 'f' for L1, set subdomain for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
# existing partner (DONOT EDIT SubdomainSub1) with 'qa12subdomainsub1' is under 'DONOT EDIT AutoTestSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    # edit partner setting of root partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    # edit partner setting of root partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                         |company name             |partner type |partner id|
      | mozyautotest+l1+subdomain1@emc.com  | DONOT EDIT SubdomainSub1|OEM          |426425    |
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozypro.com
    """
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozypro.com
    """
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    #re-change partner setting to the original
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133831 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133831:Set 't' for root, Set 'f' for L1, set subdomain for root/Not for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
# existing partner (DONOT EDIT NoSubdomainSub1) is under 'DONOT EDIT AutoTestSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT NoSubdomainSub1
    And I view partner details by DONOT EDIT NoSubdomainSub1
    # edit partner setting of L1 partner
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                           |company name               |partner type |partner id|
      | mozyautotest+l1+nosubdomain1@emc.com  | DONOT EDIT NoSubdomainSub1|OEM          |426424    |
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12autotestsubdomain.mozypro.com
    """
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    #re-change partner setting to the original
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT NoSubdomainSub1
    And I view partner details by DONOT EDIT NoSubdomainSub1
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133720 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133720:Set subdomain and Not set value for root partner, root partner admin login via dell.mozy.com
# existing partner is under Enterprise(Mozy dell) as root partner with subdomain(qa12autotestsubdomain), allow_mozy_com_domain is 't' inherited by mozy dell 't'
    When I use a existing partner:
      | admin email                          |company name                 |partner type |partner id|
      | mozyautotest+root+subdomain@emc.com  | DONOT EDIT AutoTestSubdomain|OEM          |426421    |
    And I go to page https://dell.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

  @TC.133722 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133722:Set subdomain and Set 'f' for root partner, root partner admin login via *.mozy.com of root
# existing partner is under Enterprise(Mozy dell) as root partner with subdomain(qa12autotestsubdomain), allow_mozy_com_domain is 'f'
    When I use a existing partner:
      | admin email                          |company name                 |partner type |partner id|
      | mozyautotest+root+subdomain@emc.com  | DONOT EDIT AutoTestSubdomain|OEM          |426421    |
    And I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12autotestsubdomain.mozypro.com
    """
    And I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    And I go to page https://qa12autotestsubdomain.mozypro.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133725 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133725:Set 'f' for root, Set 't' for L1, set subdomain Not for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
# existing partner (DONOT EDIT SubdomainSub) with 'qa12subdomainsub' is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
    When I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    When I use a existing partner:
      | admin email                        |company name            |partner type |partner id|
      | mozyautotest+l1+subdomain@emc.com  | DONOT EDIT SubdomainSub|OEM          |426423    |
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub.mozy.com
    """
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestNoSubdomain
    And I view partner details by DONOT EDIT AutoTestNoSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133826 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133826:Set 't' for root, Set 'f' for L1, set subdomain Not for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
# existing partner (DONOT EDIT SubdomainSub) with 'qa12subdomainsub' is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                        |company name            |partner type |partner id|
      | mozyautotest+l1+subdomain@emc.com  | DONOT EDIT SubdomainSub|OEM          |426423    |
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub.mozypro.com
    """
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT SubdomainSub
    And I view partner details by DONOT EDIT SubdomainSub
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133827 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133827:Set 't' for root, Set 't' for L1, set subdomain Not for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
# existing partner (DONOT EDIT SubdomainSub) with 'qa12subdomainsub' is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
    When I use a existing partner:
      | admin email                        |company name            |partner type |partner id|
      | mozyautotest+l1+subdomain@emc.com  | DONOT EDIT SubdomainSub|OEM          |426423    |
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub.mozy.com
    """
    When I go to page https://qa12subdomainsub.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

  @TC.133829 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133829:Set 'f' for root, Set 't' for L1, set subdomain for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
# existing partner (DONOT EDIT SubdomainSub1) with 'qa12subdomainsub1' is under 'DONOT EDIT AutoTestSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
    When I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    When I use a existing partner:
      | admin email                         |company name             |partner type |partner id|
      | mozyautotest+l1+subdomain1@emc.com  | DONOT EDIT SubdomainSub1|OEM          |426425    |
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozy.com
    """
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozy.com
    """
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |


  @TC.133830 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133830:Set 't' for root, Set 'f' for L1, set subdomain for root/for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
# existing partner (DONOT EDIT SubdomainSub1) with 'qa12subdomainsub1' is under 'DONOT EDIT AutoTestSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                         |company name             |partner type |partner id|
      | mozyautotest+l1+subdomain1@emc.com  | DONOT EDIT SubdomainSub1|OEM          |426425    |
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozypro.com
    """
    When I go to page https://qa12subdomainsub1.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12subdomainsub1.mozypro.com
    """
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT SubdomainSub1
    And I view partner details by DONOT EDIT SubdomainSub1
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133832 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133832:Set 't' for root, Set 'f' for L1, set subdomain Not for root/Not for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 't'
# existing partner (DONOT EDIT NoSubdomainSub) is under 'DONOT EDIT AutoTestNoSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT NoSubdomainSub
    And I view partner details by DONOT EDIT NoSubdomainSub
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                          |company name              |partner type |partner id|
      | mozyautotest+l1+nosubdomain@emc.com  | DONOT EDIT NoSubdomainSub|OEM          |426422    |
    When I go to page https://dell.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://dell.mozypro.com
    """
    When I go to page https://dell.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully

    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT NoSubdomainSub
    And I view partner details by DONOT EDIT NoSubdomainSub
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |

  @TC.133833 @bus @admin @login_via_subdomain @regression @qa12
  Scenario: 133833:Set 'f' for root, Set 'f' for L1, set subdomain for root/Not for L1, check bus_domain for L1
# existing partner is under Enterprise(Mozy dell) as root partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
# existing partner (DONOT EDIT NoSubdomainSub1) is under 'DONOT EDIT AutoTestSubdomain' as L1 partner(QAP@SSw0rd), allow_mozy_com_domain is 'f'
    When I search partner by DONOT EDIT NoSubdomainSub1
    And I view partner details by DONOT EDIT NoSubdomainSub1
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    And I close the partner detail page
    When I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    When I add partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | f     | false  |
    When I use a existing partner:
      | admin email                           |company name                 |partner type |partner id|
      | mozyautotest+l1+nosubdomain1@emc.com  | DONOT EDIT NoSubdomainSub1  |OEM          |426424    |
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I retrieve email content by keywords:
      | to                             | subject                       |
      | <%=@partner.admin_info.email%> | Mozy password recovery |
    Then I check the email content should include:
    """
    https://qa12autotestsubdomain.mozypro.com
    """
    When I go to page https://qa12autotestsubdomain.mozy.com/login/admin
    And I log in bus admin console with user name @partner.admin_info.email and password QAP@SSw0rd
    Then I login as @partner.company_info.name admin successfully
    And I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I search partner by DONOT EDIT AutoTestSubdomain
    And I view partner details by DONOT EDIT AutoTestSubdomain
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |
    And I close the partner detail page
    And I search partner by DONOT EDIT NoSubdomainSub1
    And I view partner details by DONOT EDIT NoSubdomainSub1
    And I delete partner settings
      | Name                  |
      | allow_mozy_com_domain |
    Then I verify partner settings
      | Name                  | Value | Locked |
      | allow_mozy_com_domain | t     | false  |