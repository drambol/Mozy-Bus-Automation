Feature: admins log out

  Background:
    Given I log in bus admin console as administrator

  @TC.123918 @bus @admin @tasks_p1 @ldap_sequence @subdomain
  Scenario: 123918 New LDAP login through LDAP process
    When I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I use Directory Service as authentication provider without saving
    And I choose LDAP Pull as Directory Service provider without saving
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
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    And I log out bus admin console
    Then ldap admin logout url is https://CONFIGS['fedid']['subdomain'].mozypro.com/login/logout
    And ldap admin logout text is Logged OutYou've successfully logged out, please close this window (or tab) to exit.
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |
    And I delete a user @admin.name in the AD



