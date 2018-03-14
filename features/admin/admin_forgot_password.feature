Feature: admin forgot password

  Background:
    Given I log in bus admin console as administrator

  @TC.133938 @bus
  Scenario: 133938 MozyPro admin forgot password in phoenix login/forgot page
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    And New partner should be created
    And I activate new partner admin with default password
    And I log out bus admin console
    When I navigate to phoenix login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I search emails by keywords:
      | subject                   | to                            |
      | MozyPro password recovery | <%=@partner.admin_info.email%>|
    Then I should see 1 email(s)
    When I click reset password link from the email
    And I set a new password reset password
    Then password changed message should be Your password has been changed.

    When I log into phoenix with username newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console

    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.126033 @bus @admin @tasks_p1 @smoke
  Scenario: 126033 Admin forgot Password from www.mozypro.com
    #MozyPro admin forgot password in BUS login/forgot link will be redirected to phoenix login/forgot page
    When I add a new MozyPro partner:
      | period | base plan |
      | 12     | 24 TB     |
    Then New partner should be created
    And I activate new partner admin with Hipaa password
    And I log out bus admin console
    When I go to page QA_ENV['bus_host']/login/admin
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                             |
      | MozyPro password recovery | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133940 @bus
  Scenario: 133940 MozyEnterprise admin forgot password in BUS login/forgot link will be redirect to phoenix
    When I add a new MozyEnterprise partner:
      | period  | users | net terms |
      | 12      | 100   | yes       |
    And New partner should be created
    And I get partner id by admin email from database
    And I activate new partner admin with default password
    And I log out bus admin console
    When I go to page https://www.mozyenterprise.com/login/admin?pid=@partner_id
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I search emails by keywords:
      | subject                          | to                            |
      | MozyEnterprise password recovery | <%=@partner.admin_info.email%>|
    Then I should see 1 email(s)
    #https://www.mozyenterprise.com/p/540919/1474261733/af1ec5f5c1e7ca21f721af04d0d0e1eb/pass
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your account credentials have been changed.

    When I navigate to bus admin console login page
    And I log in bus admin console with user name newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    When I log into phoenix with username newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.133941 @bus
  Scenario: 133941 Reseller admin forgot password in BUS login/forgot link will be redirect to phoenix
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     |
      | 12     | Silver        | 100            | Reseller Root |
    And New partner should be created
    And I get partner id by admin email from database
    And I activate new partner admin with default password
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    And I search emails by keywords:
      | subject                   | to                            |
      | MozyPro password recovery | <%=@partner.admin_info.email%>|
    Then I should see 1 email(s)
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your password has been changed.

    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    And I log in bus admin console with user name newly created partner admin email and password reset password
    Then I login as mozypro admin successfully
    When I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | User Group           | Roles         |
      | Admin_132235_04 | (default user group) | Reseller Root |
    Then Add New Admin success message should be displayed
    And I view the admin details of Admin_132235_04
    And I active admin in admin details default password
    And I wait for 2 seconds
    And I log out bus admin console
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    And I click forget your password link
    And I input email @admin.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                |
      | MozyPro password recovery | <%=@admin.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your password has been changed.
    When I go to page QA_ENV['bus_host']/login/admin?pid=@partner_id
    And I log in bus admin console with user name @admin.email and password reset password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name



  @TC.133942 @bus
  Scenario: 133942 MozyOEM admin forgot password in BUS login/forgot link
    # link for https://mozyoem.mozypro.com/login/forgot
    When I add a new OEM partner:
      | Company Name       | Root role         | Security | Company Type     |
      | test_for_132235_04 | OEM Partner Admin | Standard | Service Provider |
    Then New partner should be created
    And I view the newly created subpartner admin details
    And I active admin in admin details default password
    When I go to page https://mozyoem.mozypro.com/login/admin
    And I click forget your password link
    And I input email @subpartner.admin_email_address in reset password panel to reset password
    And I search emails by keywords:
      | subject                | to                                  |
      | Mozy password recovery | <%=@subpartner.admin_email_address%>|
    Then I should see 1 email(s)
    # like https://mozyoem.mozypro.com/p/540887/1474265368/98b2b5fab68b303423a9ce53f1bc9451/pass
    When I click reset password link from the email
    And I reset password with reset password
    Then I will see reset password full massage Your account credentials have been changed.

    When I go to page https://mozyoem.mozypro.com/login/admin
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully

  @TC.126043 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 126043 Reset Admin Password from subdomain.mozypro.com
    #MozyPro/MozyEnterprise with subdomain, admin forgot password in BUS login/forgot link
    When I use a existing partner:
      | admin email                   | partner type |
      | qa8+saml+test+admin@mozy.com  | MozyPro      |
    And I log in bus admin console as new partner admin
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I click forget your password link
    And I input email @admin.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                |
      | MozyPro password recovery | <%=@admin.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with default password
    And I will see reset password full massage Your password has been changed.
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I log in bus admin console as new partner admin
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |




