Feature: user login via subdomain
  Background:
    Given I log in bus admin console as administrator

  #Dell Root -> MozyEnt ->Root partner -> L1 Partner-> L2 Partner
  @TC.133424 @bus @user @user_login_via_subdomain @regression @smoke @qa12
  Scenario: 133424:Partner root's user can login successfully via *.mozy.com under MozyOEM
    # Partner root's subdomain is autotestsubdomaindell, user under Partner root use autotestsubdomaindell to login
    When I go to page https://autotestsubdomaindell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133426 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133426:L1 Partner's user can login successfully via dell.mozy.com under MozyOEM
    # L1 Partner has no subdomain, user under L1 Partner use dell.mozy.com to login
    When I go to page https://dell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133428 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133428:L1 Partner 's user can login successfully via *.mozy.com of partner root under MozyOEM
    # L1 Partner has no subdomain, user under L1 Partner use its parent partner's autotestsubdomaindell.mozy.com to login
    When I go to page https://autotestsubdomaindell.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserdell+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133431 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133431:User login successfully via *.mozycom after set subdomain for fedid partner under MozyOEM
    # existing user: jadenadminreauth21@mtdev.mozypro.local, partner:Jaden admin reauth test partner[Do not edit]
    # allow_mozy_com_domain = 't', password:abc!@#123, subdomain: qa12oemdellpull
    # login via qa12oemdellpull.mozypro.com or qa12oemdellpull.mozy.com will result in qa12oemdellpull.mozy.com
    When I go to page https://qa12oemdellpull.mozypro.com
    And I sign in the subdomain Trust.oemdellpullqa12
    And I sign in with user name jadenadminreauth21@mtdev.mozypro.local and password abc!@#123
    Then I will see the user account page
    And I log out bus admin console
    Then ldap admin logout url is https://qa12oemdellpull.mozy.com/login/logout
    When I go to page https://qa12oemdellpull.mozy.com
    And I sign in the subdomain Trust.oemdellpullqa12
    And I sign in with user name jadenadminreauth21@mtdev.mozypro.local and password abc!@#123
    Then I will see the user account page
    And I log out bus admin console
    Then ldap admin logout url is https://qa12oemdellpull.mozy.com/login/logout

  @TC.133411 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133411:Partner root's user can login successfully via *.mozypro.com under mozypro
    # Partner root's subdomain is autotestsubdomainpro, user under Partner root use autotestsubdomainpro to login
    When I go to page https://autotestsubdomainpro.mozypro.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133412 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133412:Partner root's user can login successfully via *.mozy.com under mozypro
    When I go to page https://autotestsubdomainpro.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133413 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133413:L1 Partner 's user can login successfully via *.mozypro.com under mozypro
    # L1 Partner has subdomain autotestsubdomainprosub, user under L1 Partner use autotestsubdomainprosub to login
    When I go to page https://autotestsubdomainprosub.mozypro.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133414 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133414:L1 Partner's user can login successfully via *.mozy.com under mozypro
    When I go to page https://autotestsubdomainprosub.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133415 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133415:L1 Partner 's user can login successfully via *.mozypro.com of partner root under mozypro
    # L1 Partner has subdomain autotestsubdomainprosub, user under L1 Partner use autotestsubdomainpro of parent partner to login
    When I go to page https://autotestsubdomainpro.mozypro.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133416 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133416:L1 Partner 's user can login successfully via *.mozy.com of partner root under mozypro
    When I go to page https://autotestsubdomainpro.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuser+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133417 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133417:Partner root's user can login successfully via *.mozyenterprise.com under mozyEnt
    When I go to page https://autotestsubdomainent.mozyenterprise.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuserent+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133418 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133418:Partner root's user can login successfully via *.mozy.com under mozyEnt
    When I go to page https://autotestsubdomainent.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+rootuserent+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133421 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133421:L1 Partner 's user can login successfully via *.mozyenterprise.com of partner root under mozyEnt
    When I go to page https://autotestsubdomainent.mozyenterprise.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserent+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

  @TC.133422 @bus @user @user_login_via_subdomain @regression @qa12
  Scenario: 133422:L1 Partner 's user can login successfully via *.mozy.com of partner root under mozyEnt
    When I go to page https://autotestsubdomainent.mozy.com/login/user
    And I log in bus admin console with user name mozyautotest+l1subuserent+subdomain@emc.com and password QAP@SSw0rd
    Then I will see the user account page

