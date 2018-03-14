Feature: login as admins

  Background:
    Given I log in bus admin console as administrator

 #########################################################################

 #  Test Suite : Log In Screen

##########################################################################
  @TC.2134 @bus @log_in_screen @regression @core_function
  Scenario: 2134 Attempt to log into BUS with a invalid username
    When I navigate to bus admin console login page
    And I log in bus admin console with user name invalid_name@mozy.com and password Naich4yei8
    Then Login page error message should be Incorrect email or password.

  @TC.2135 @bus @log_in_screen @regression @core_function
  Scenario: 2135 Attempt to log into BUS with a invalid password
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password wrong_password
    Then Login page error message should be Incorrect email or password.

  @TC.2187 @bus @log_in_screen @regression @core_function
  Scenario: 2187 Prevent Session Fixation
    When I navigate to bus admin console login page
    And I save login page cookies _session_id value
    And I log in bus admin console with user name qa1+automation+admin@mozy.com and password Naich4yei8
    And I save admin console page cookies _session_id value
    Then Two cookies value should be different
    When I search partner by:
      | name  |
      | mozy  |
    And Admin console page cookies _session_id value should not changed

  @TC.120658 @bus @log_in_screen @need_test_account @env_dependent @regression @core_function
  Scenario: 120658 Standard admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Standard admin and Standard password
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Standard admin and Standard password
    And I log out bus admin console

  @TC.120659 @bus @log_in_screen @need_test_account @env_dependent @regression @core_function
  Scenario: 120659 Hipaa admin log into BUS with upper/mixed case username
    When I navigate to bus admin console login page
    Then I log into bus admin console with uppercase Hipaa admin and Hipaa password
    And I log out bus admin console
    Then I navigate to bus admin console login page
    And I log into bus admin console with mixed case Hipaa admin and Hipaa password
    And I log out bus admin console

#########################################################################

 #  Test Suite : LDAP admin login

########################################################################
  @TC.121831 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121831 Old admins which AD does not have can not login
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles      | User Group           |
      | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name             |
      | <%=@admin.name%> |
    And I active admin in admin details default password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password default password
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |

  @TC.121833 @bus @admin @tasks_p1 @ldap_sequence @smoke @subdomain @ROR_smoke
  Scenario: 121833 New LDAP login through LDAP process
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    And I add a user to the AD
      | user name        | mail              |
      | <%=@admin.name%> | <%=@admin.email%> |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password wrongpass12
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |
    And I delete a user @admin.name in the AD

  @TC.121837 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121837 New non LDAP admins can not login
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password AD user default password
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |

  @TC.121838 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121838 Old admins which AD has login through LDAP process
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles      | User Group           |
      | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name             |
      | <%=@admin.name%> |
    And I active admin in admin details default password
    And I add a user to the AD
      | user name        | mail              |
      | <%=@admin.name%> | <%=@admin.email%> |
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password wrongpass12
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins.last.email and password wrongpass12
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |
    And I delete a user @admins.last.name in the AD

  @TC.121920 @bus @admin @tasks_p1
  Scenario: 121920 Root admin can login BUS using secure.mozy.com
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Pull as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And the partner has activated the admin account with default password
    And I log into phoenix with username @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I log into phoenix with username @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.121921 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121921 Root admin can login BUS Root admin can login BUS using https://subdomain.mozypro.com/login/admin?authtype=mozy
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I go to page https://CONFIGS['fedid']['subdomain'].mozypro.com/login/admin?authtype=mozy
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    Then I login as @current_partner_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I go to page https://CONFIGS['fedid']['subdomain'].mozypro.com/login/admin?authtype=mozy
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    Then I login as @current_partner_name admin successfully

  @TC.121975 @bus @admin @tasks_p1
  Scenario: 121975 Root admin can login BUS using https://www.mozypro.com/login/admin
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Pull as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I go to page QA_ENV['bus_host']/login/admin
    And I log in with username @partner.admin_info.email and password default password from phoenix login page
    Then I login as @partner.company_info.name admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I go to page QA_ENV['bus_host']/login/admin
    And I log in with username @partner.admin_info.email and password default password from phoenix login page
    Then I login as @partner.company_info.name admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : LDAP admin login

##########################################################################

  @TC.121916 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121916 Push Old admins which AD does not have can not login
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles      | User Group           |
      | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name             |
      | <%=@admin.name%> |
    And I active admin in admin details default password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  | Bind Username | Bind Password  |
      | @server_host | @protocol |          | @port | @base_dn | @bind_user    | @bind_password |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password default password
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |

  @TC.121917 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121917 Push New LDAP login through LDAP process
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    And I add a user to the AD
      | user name        | mail              |
      | <%=@admin.name%> | <%=@admin.email%> |
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password wrongpass12
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |
    And I delete a user @admin.name in the AD

  @TC.121918 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121918 Push New non LDAP admins can not login
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | User Group           |
      | (default user group) |
    Then Add New Admin success message should be displayed
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admins.last.name and password AD user default password
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins.last.email and password AD user default password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admins.last.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins.last.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                   |
      | <%=@admins.last.email%> |

  @TC.121919 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121919 Push Old admins which AD has can login
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Mozy as authentication provider
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Roles      | User Group           |
      | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name             |
      | <%=@admin.name%> |
    And I active admin in admin details default password
    And I add a user to the AD
      | user name        | mail              |
      | <%=@admin.name%> | <%=@admin.email%> |
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I start a new session
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admins.last.name and password wrongpass12
    Then I will see ldap admin log in error message The user name or password is incorrect.
    And I sign in with user name @admins.last.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins.last.email and password wrongpass12
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I navigate to the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I log in bus admin console with user name @admins.last.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins.last.email and password AD user default password
    Then Login page error message should be This account has not yet been activated. Please check your email account for activation instructions.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email                   |
      | <%=@admins.last.email%> |
    And I delete a user @admins.last.name in the AD

  @TC.121923 @bus @admin @tasks_p1
  Scenario: 121923  Push Root admin can login BUS using secure.mozy.com
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And the partner has activated the admin account with default password
    And I log into phoenix with username @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I log into phoenix with username @partner.admin_info.email and password default password
    Then I login as @partner.company_info.name admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.121924 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 121924 Push Root admin can login BUS Root admin can login BUS using https://subdomain.mozypro.com/login/admin?authtype=mozy
    When I search partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    Then I get current partner name
    And I view admin details by qa8+saml+test+admin@mozy.com
    And I change admin password to default password
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Push as Directory Service provider without saving
    And I input server connection settings
      | Server Host  | Protocol  | SSL Cert | Port  | Base DN  |
      | @server_host | @protocol |          | @port | @base_dn |
    And I check enable sso for admins to log in with their network credentials
    And I click SAML Authentication tab
    And I clear SAML Authentication information
    And I input SAML authentication information
      | URL  | Endpoint  | Certificate  |
      | @url | @endpoint | @certificate |
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I go to page https://CONFIGS['fedid']['subdomain'].mozypro.com/login/admin?authtype=mozy
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    Then I login as @current_partner_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I go to page https://CONFIGS['fedid']['subdomain'].mozypro.com/login/admin?authtype=mozy
    And I log in bus admin console with user name qa8+saml+test+admin@mozy.com and password default password
    Then I login as @current_partner_name admin successfully

  @TC.121974 @bus @admin @tasks_p1
  Scenario: 121974 Push Root admin can login BUS using https://www.mozypro.com/login/admin
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 18    | 500 GB      | FedID role |
    Then New partner should be created
    When I add partner settings
      | Name                    | Value | Locked |
      | allow_ad_authentication | t     | true   |
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I act as newly created partner account
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider
    And I choose LDAP Push as Directory Service provider
    And I check enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I go to page QA_ENV['bus_host']/login/admin
    And I log in with username @partner.admin_info.email and password default password from phoenix login page
    Then I login as @partner.company_info.name admin successfully
    And I navigate to Authentication Policy section from bus admin console page
    And I uncheck enable sso for admins to log in with their network credentials
    And I save the changes
    Then Authentication Policy has been updated successfully
    When I go to page QA_ENV['bus_host']/login/admin
    And I log in with username @partner.admin_info.email and password default password from phoenix login page
    Then I login as @partner.company_info.name admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


#########################################################################

 #  Test Suite : Standard partner login_Sub Admin

########################################################################

  @TC.14477 @bus @admin @tasks_p1
  Scenario: 14477 Sub-admin cannot login its account after partner was suspended from BUS
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name        | Roles      | User Group           |
      | Admin_14477 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with default password
    Then I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    Then I suspend the partner
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123704 @bus @admin @tasks_p1
  Scenario: 123704 New created standard sub-admin forget password and reset password on bus
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then I login as mozypro admin successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123704 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name         |
      | Admin_123704 |
    Then I active admin in admin details default password
    When I navigate to bus admin console login page
    And I click forget your password link
    And I input email @admin.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                |
      | MozyPro password recovery | <%=@admin.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with Standard password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password Standard password
    Then I login as Admin_123704 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password Standard password
    Then I login as Admin_123704 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name


#########################################################################

 #  Test Suite : HIPAA partner login_Sub Admin

########################################################################
  @TC.123421 @bus @admin @tasks_p1
  Scenario: 123421 New created standard sub-admin forget password and reset password on bus
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 24     | 10 GB     | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I view the newly created partner admin details
    Then I active admin in admin details reset password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123421 | FedID role | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@new_admins[0].email%> account with reset password
    When I navigate to bus admin console login page
    And I click forget your password link
    And I input email @admin.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                |
      | MozyPro password recovery | <%=@admin.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with Hipaa password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password Hipaa password
    Then I login as Admin_123421 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password Hipaa password
    Then I login as Admin_123421 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123401 @bus @admin @tasks_p1
  Scenario: 123401 Hipaa MozyPro login bus and phoenix after activating and changing password(admin before subadmin)
    When I add a new MozyPro partner:
      | period | base plan | net terms | security |
      | 24     | 10 GB     | yes       | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123401_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name           | Parent               |
      | Admin_123401_2 | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@admin.email%> account with Hipaa password
    And the partner has activated the <%=@admins[0].email%> account with reset password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I view admin details by:
      | name           |
      | Admin_123401_1 |
    And I change admin password to Hipaa password
    Then I can change Admin_123401_1 password successfully
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123401_2 |
    And I click admin Admin_123401_2 on the top right
    And I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Hipaa password
    Then I login as Admin_123401_1 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admins[0].email and password Hipaa password
    Then I login as Admin_123401_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123401_2 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123401_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123402 @bus @admin @tasks_p1
  Scenario: 123402 Hipaa Reseller EMEA login bus after activating and changing password(subadmin before admin)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | net terms | country        | security |
      | 12     | Silver        | 50             | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    And New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123402_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123402_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And the partner has activated the <%=@new_admins[0].email%> account with Hipaa password
    And the partner has activated the <%=@admins[0].email%> account with reset password
    And I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    And I view admin details by:
      | name           |
      | Admin_123402_2 |
    And I change admin password to reset password
    Then I can change Admin_123402_2 password successfully
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123402_1 |
    And I click admin Admin_123402_1 on the top right
    And I change root admin password in Account Details from old password reset password to Hipaa password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Hipaa password
    Then I login as Admin_123402_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123402_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123686 @bus @admin @tasks_p1
  Scenario: 123686 Hipaa Sub-admin cannot login its account after partner was suspended from BUS
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | root role     | security |
      | 12     | Silver        | 100            | Reseller Root | HIPAA    |
    Then New partner should be created
    And I view the newly created partner admin details
    #Then I active admin in admin details default password
    And I view partner details by newly created partner company name
    Then I suspend the partner
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123686 | (default user group) |
    Then Add New Admin success message should be displayed
    And the partner has activated the sub-admin account with Hipaa password
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then Login page error message should be Your account has been suspended and cannot currently be accessed.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : Standard partners login_Root Admin

########################################################################

  @TC.123673 @bus @admin @tasks_p1
  Scenario: 123673 Create standard for MozyPro US partner and sub-partners and admin on phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | security |
      | 24     | 10 GB     | United States | Standard |
    And the partner is successfully added.
    And I log in bus admin console as administrator
    And I view partner details by newly created partner company name
    And I change root role to FedID role
    Then I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password default password
    Then I login as mozypro admin successfully
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.123673 |
    And New partner should be created
    Then The security filed value is Standard
    And I search partner by newly created subpartner company name
    And I view admin details by @subpartner.admin_email_address
    And I active admin in admin details Standard password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password Standard password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log into phoenix with username @subpartner.admin_email_address and password Standard password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.123716 @bus @admin @tasks_p1
  Scenario: 123716 Standard MozyPro login bus and phoenix after activating and changing password(admin before subadmin)
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123716_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123716_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name           |
      | Admin_123716_1 |
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change Admin_123716_1 password successfully
    And I close the admin details section
    And I view admin details by:
      | name           |
      | Admin_123716_2 |
    Then I active admin in admin details default password
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123716_2 |
    And I click admin Admin_123716_2 on the top right
    And I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password Standard password
    Then I login as Admin_123716_1 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @admins[0].email and password Standard password
    Then I login as Admin_123716_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password reset password
    Then I login as Admin_123716_2 admin successfully
    And I log out bus admin console
    And I log into phoenix with username @new_admins[0].email and password reset password
    Then I login as Admin_123716_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123717 @bus @admin @tasks_p1
  Scenario: 123717 Standard Reseller EMEA login bus after activating and changing password(subadmin before admin)
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | create under | net terms | country        |
      | 12     | Silver        | 500            | 10             | MozyPro UK   | yes       | United Kingdom |
    And New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name           | User Group           |
      | Admin_123717_1 | (default user group) |
    Then Add New Admin success message should be displayed
    And I refresh Add New Admin section
    And I add a new admin:
      | Name            | Parent               |
      | Admin_123717_2  | <%=@admins[0].name%> |
    Then Add New Admin success message should be displayed
    And I view admin details by:
      | name           |
      | Admin_123717_2 |
    Then I active admin in admin details default password
    And I change admin password to Standard password
    Then I can change Admin_123717_2 password successfully
    And I close the admin details section
    And I view admin details by:
      | name           |
      | Admin_123717_1 |
    Then I active admin in admin details default password
    And I close the admin details section
    And I act as admin by:
      | email          |
      | Admin_123717_1 |
    And I click admin Admin_123717_1 on the top right
    And I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admins[0].email and password reset password
    Then I login as Admin_123717_1 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @new_admins[0].email and password Standard password
    Then I login as Admin_123717_2 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123718 @bus @admin @tasks_p1
  Scenario: 123718 Standard MozyEnterprise login bus after activating and changing password
     When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 12     | 1     | 1 TB        | FedID role |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123718 | FedID role | (default user group) |
    And the partner has activated the sub-admin account with default password
    And I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details default password
    And I change admin password to Standard password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as Admin_123718 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123719 @bus @admin @tasks_p1
  Scenario: 123719 Standard Mozy OEM login bus after activating and changing password
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I act as partner by:
      | name    | including sub-partners |
      | MozyOEM | no                     |
    And I add a new sub partner:
      | Security |
      | Standard |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123719 | (default user group) |
    And the partner has activated the oem-admin account with default password
    And I go to account
    Then I login as @subpartner.company_name admin successfully
    And I view admin details by:
      | name         |
      | Admin_123719 |
    And I active admin in admin details default password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password default password
    Then I login as Admin_123719 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as @subpartner.company_name admin successfully
    And I act as admin by:
      | email             |
      | <%=@admin.email%> |
    And I click admin Admin_123719 on the top right
    Then I change root admin password in Account Details from old password default password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password reset password
    Then I login as Admin_123719 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name

  @TC.123700 @bus @admin @tasks_p1
  Scenario: 123700 New created standard admin forget password and reset password on bus
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                             |
      | MozyPro password recovery | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with Standard password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123702 @bus @admin @tasks_p1
  Scenario: 123702 New created standard admin forget password and reset password on phoenix
    When I add a new MozyPro partner:
      | period | base plan | net terms |
      | 24     | 10 GB     | yes       |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details default password
    And I log out bus admin console
    When I navigate to phoenix login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                             |
      | MozyPro password recovery | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with Standard password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Standard password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

#########################################################################

 #  Test Suite : HIPAA partner login_Root Admin

########################################################################

  @TC.120062 @TC.120063 @bus @admin @tasks_p1
  Scenario: 120062 120063 New Hipaa admin can log in bus and phoenix after account activation
    When I add a new MozyPro partner:
      | period | base plan | net terms | security |
      | 24     | 10 GB     | yes       | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120073 @busNegative @admin @tasks_p1
  Scenario: 120073 [Negative]Hipaa admin cannot log in bus with error empty password
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 500 GB    | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password wrongpass password
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console with user name @partner.admin_info.email and password Empty
    Then Login page error message should be Incorrect email or password.
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.120076 @bus @admin @tasks_p1
  Scenario: 120076 HIPAA for MozyPro EMEA partner and sub-partners and admin could login bus and phoenix
    When I navigate to Add New Partner section from bus admin console page
    Then Security field options on add new partner page should be:
      | | Standard | HIPAA |
    And Security field default value when add partner is blank
    And HIPPA security tool tip appears next to the security drop-down
    When I add a new MozyPro partner:
      | period | base plan | create under | net terms | country        | security |
      | 12     | 2 TB      | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    Then New partner should be created
    And The security filed value is HIPAA
    And I change root role to FedID role
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                             | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | £ — Pound Sterling (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.120076 |
    And New partner should be created
    Then The security filed value is HIPAA
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.120078 @bus @admin @tasks_p1
  Scenario: 120078 HIPAA for Reseller EMEA partner and sub-partners and admin could login bus
    When I navigate to Add New Partner section from bus admin console page
    Then Security field options on add new partner page should be:
      | | Standard | HIPAA |
    And Security field default value when add partner is blank
    And HIPPA security tool tip appears next to the security drop-down
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under | net terms | country        | security |
      | 12     | Silver        | 100            | MozyPro UK   | yes       | United Kingdom | HIPAA    |
    Then New partner should be created
    Then The security filed value is HIPAA
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency           | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | £ — Pound Sterling | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name          | Pricing Plan | Admin Name |
      | sub_partner_TC.120078 | subplan      | subadmin   |
    Then New partner should be created
    Then The security filed value is HIPAA
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.120083 @bus @admin @tasks_p1
  Scenario: 120083 Hipaa admin can login bus after activated through email
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 24     | 3     | 24 TB       | FedID role | HIPAA    |
    Then New partner should be created
    And the partner has activated the admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123404 @bus @admin @tasks_p1 @smoke
  Scenario: 123404 HIPAA MozyEnterprise login bus after activating and changing password
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | security |
      | 12     | 1     | 12 TB       | FedID role | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | Roles      | User Group           |
      | Admin_123404 | FedID role | (default user group) |
    And the partner has activated the sub-admin account with Hipaa password
    And I log in bus admin console as administrator
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details Hipaa password
    And I change admin password to reset password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then I login as Admin_123404 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123407 @bus @admin @tasks_p1
  Scenario: 123407 Hipaa Mozy OEM login bus after activating and changing password
    When I act as partner by:
      | name     | including sub-partners |
      | Fortress | no                     |
    And I act as partner by:
      | name    | including sub-partners |
      | MozyOEM | no                     |
    And I add a new sub partner:
      | Security |
      | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin newly:
      | Name         | User Group           |
      | Admin_123407 | (default user group) |
    And I wait for 15 seconds
    And the partner has activated the oem-admin account with Hipaa password
    And I go to account
    Then I login as @subpartner.company_name admin successfully
    And I view admin details by:
      | name         |
      | Admin_123407 |
    Then I click here to re-send activation email in admin details section
    And the partner has activated the sub-admin account with Hipaa password
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password Hipaa password
    Then I login as Admin_123407 admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password Hipaa password
    Then I login as @subpartner.company_name admin successfully
    And I act as admin by:
      | email             |
      | <%=@admin.email%> |
    And I click admin Admin_123407 on the top right
    Then I change root admin password in Account Details from old password Hipaa password to reset password
    Then password changed success message should be displayed
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @admin.email and password reset password
    Then I login as Admin_123407 admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name

  @TC.123340 @bus @admin @tasks_p1
  Scenario: 123340 Activate a new HIPAA root admin in admin detail
     When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 24 TB     | HIPAA    |
    Then New partner should be created
    And I change root role to FedID role
    And I act as newly created partner
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name          |
      | sub_partner_TC.123340 |
    And New partner should be created
    Then I stop masquerading
    And I search partner by newly created partner admin email
    And I view admin details by newly created partner admin email
    Then I active admin in admin details Hipaa password
    And I close the admin details section
    And I search partner by newly created subpartner company name
    And I view admin details by @subpartner.admin_email_address
    And I active admin in admin details reset password
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password Hipaa password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log into phoenix with username @subpartner.admin_email_address and password reset password
    Then I login as @subpartner.company_name admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created subpartner company name
    And I search and delete partner account by newly created partner company name

  @TC.123523 @bus @admin @tasks_p1
  Scenario: 123523 Create HIPAA for MozyPro US partner and sub-partner and admin on phoenix
    When I am at dom selection point:
    And I add a phoenix Pro partner:
      | period | base plan | country       | security |
      | 24     | 10 GB     | United States | HIPAA    |
    And the partner is successfully added.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123417 @bus @admin @tasks_p1
  Scenario: 123417 New created Hipaa admin forget password and reset password on bus
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 24 TB     | HIPAA    |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details Hipaa password
    And I log out bus admin console
    When I navigate to bus admin console login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                             |
      | MozyPro password recovery | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.123418 @bus @admin @tasks_p1
  Scenario: 123418 New created Hipaa admin forget password and reset password on phoenix
    When I add a new MozyPro partner:
      | period | base plan | security |
      | 12     | 24 TB     | HIPAA    |
    Then New partner should be created
    And I view the newly created partner admin details
    Then I active admin in admin details Hipaa password
    And I log out bus admin console
    When I navigate to phoenix login page
    And I click forget your password link
    And I input email @partner.admin_info.email in reset password panel to reset password
    When I search emails by keywords:
      | subject                   | to                             |
      | MozyPro password recovery | <%=@partner.admin_info.email%> |
    Then I should see 1 email(s)
    When I click reset password link from the email
    Then I reset password with reset password
    And I will see reset password massage Your password has been changed.
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log into phoenix with username @partner.admin_info.email and password reset password
    Then I login as mozypro admin successfully
    And I log out bus admin console
    And I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name



