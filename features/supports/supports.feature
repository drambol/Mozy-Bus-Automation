Feature: Supports on BUS

  Background:
    Given I log in bus admin console as administrator

  @TC.22472 @bus @support @tasks_p1 @smoke
  Scenario: 22472:Verify that contact works for DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    When I navigate to Contact section from bus admin console page
    And I click Community on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
    | email        |
    | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Knowledge Base on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Documentation on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click Create or update a support case on contact section
    Then I login my support successfully
    When I log in bus admin console as administrator
    And I act as partner by:
      | email        |
      | @admin_email |
    When I navigate to Contact section from bus admin console page
    And I click 24/7 Live Chat Support on contact section
    Then I login my support successfully
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.22479 @bus @support @tasks_p1
  Scenario: 22479:Verify that Online Help works for DPS admin.
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | country       |
      | 12     | 2         | United States |
    And New partner should be created
    Then I act as newly created partner account
    When I navigate to Online Help section from bus admin console page
    And I wait for 30 seconds
    Then I check link Community is exists
    And I check link Knowledge Base is exists
    And I check link Documentation is exists
    And I check link My Support is exists
    Then I search with subject test
    And The search results title should include test
    Then I log in bus admin console as administrator
    And I search and delete partner account by newly created partner company name

  @TC.122153 @bus @support @tasks_p1 @ldap_sequence @subdomain
  Scenario: 122153:Push SSO admin stay logged in when go to support and community
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
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    When I navigate to Contact section from bus admin console page
    And I click Community on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click My Support on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Knowledge Base on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Documentation on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Create or update a support case on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click 24/7 Live Chat Support on contact section
    Then I login my support successfully
    And I delete a user @admin.name in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |

  @TC.122154 @bus @support @tasks_p1 @ldap_sequence @subdomain
  Scenario: 122154 Pull SSO admin stay logged in when go to support and community
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
    When I start a new session
    And I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I sign in with user name @admin.name and password AD user default password
    Then I login as @admin.name admin successfully
    When I navigate to Contact section from bus admin console page
    And I click Community on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click My Support on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Knowledge Base on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Documentation on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click Create or update a support case on contact section
    Then I login my support successfully
    When I login the admin subdomain <%=CONFIGS['fedid']['subdomain']%>
    And I navigate to Contact section from bus admin console page
    And I click 24/7 Live Chat Support on contact section
    Then I login my support successfully
    And I delete a user @admin.name in the AD
    When I log in bus admin console as administrator
    And I act as partner by:
      | email                        |
      | qa8+saml+test+admin@mozy.com |
    And I delete admin by:
      | email             |
      | <%=@admin.email%> |



