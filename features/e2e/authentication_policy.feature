Feature:

  Background:


  @redmine.119233 @qa8 @env_dependent
  Scenario: QA8 Modify the query to pull the new user
    When I add a user to the AD
      | user name  | mail           | host           | user                            | password   | treebase                             | email_postfix             |
      | First Last | email@mozy.com | 10.135.10.150  | gsmith@qa8.test.fedidactive.com | QAP@SSw0rd | DC=qa8,DC=test,DC=fedidactive,DC=com | @qa8.test.fedidactive.com |
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                     |
      | qa1+031320140955@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                                | Bind Username | Bind Password |
      | 10.135.10.150        | No SSL   |          | 389  | dc=qa8, dc=test, dc=fedidactive, dc=com| QA8\Test1     | A123456!      |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                      | group                |
      | mail=<%=LDAPHelper.ldap_user_mail%> | (default user group) |
    And I click the sync now button
    And I wait for 100 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)|
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0 |
      | Next Sync   | Not Scheduled(Set)                                                 |

  @qa12 @env_dependent
  Scenario: QA12 Modify the query to pull the new user
    When I add a user to the AD
      | user name  | mail           | host          | user                              | password   | treebase                                | email_postfix                |
      | First Last | email@mozy.com | 10.135.10.94  | admin@qa12.test.fedidactive.local | QAP@SSw0rd | DC=qa12,DC=test,DC=fedidactive,DC=local | @qa12.test.fedidactive.local |
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                     |
      | qa1+030420140225@mozy.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I input server connection settings
      | Server Host         | Protocol | SSL Cert | Port | Base DN                                    | Bind Username       | Bind Password |
      | 10.135.10.94        | No SSL   |          | 389  | dc=qa12, dc=test, dc=fedidactive, dc=local | QA12\Admininstrator | QAP@SSw0rd    |
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                                 | group                |
      | mail=<%=@LDAPHelper.ldap_user_mail%> | (default user group) |
    And I click the sync now button
    And I wait for 80 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)|
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0 |
      | Next Sync   | Not Scheduled(Set)                                                 |

  @qa8 @push_connector @env_dependent
  Scenario: QA8 Modify the query to push the new user
    When I add a user to the AD
      | user name  | mail           | host           | user                            | password   | treebase                             | email_postfix             |
      | First Last | email@mozy.com | 10.135.10.150  | gsmith@qa8.test.fedidactive.com | QAP@SSw0rd | DC=qa8,DC=test,DC=fedidactive,DC=com | @qa8.test.fedidactive.com |
    And I log in bus admin console as administrator
    And I act as partner by:
      | email                     |
      | qa1+bonnie+ray+1133@decho.com |
    And I navigate to Authentication Policy section from bus admin console page
    And I input server connection settings
      | Server Host          | Protocol | SSL Cert | Port | Base DN                                |
      | 10.135.10.150        | No SSL   |          | 389  | dc=qa8, dc=test, dc=fedidactive, dc=com|
    And I save the changes
    Then Authentication Policy has been updated successfully
    And I click Sync Rules tab
    And I add 1 new provision rules:
      | rule                      | group                |
      | mail=<%=LDAPHelper.ldap_user_mail%> | (default user group) |
    And I save the changes
    And I wait for 30 seconds
    And I push the adfs user(s) to BUS
    And I wait for 30 seconds
    And I delete 1 provision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)|
      | Sync Result | Users Provisioned: 1 succeeded, 0 failed \| Users Deprovisioned: 0 |
    And I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                       |
      | <%=LDAPHelper.ldap_user_mail%> |
    Then User search results should be:
      | User                           |
      | <%=LDAPHelper.ldap_user_mail%> |
    Then I activate and back up the adfs user
      | Client  | Environment | Subdomain           | User                           |
      | mozypro | qa8         | bifrost18266mozypro | <%=LDAPHelper.ldap_user_mail%> |
    And I wait for 30 seconds
    And I view user details by <%=LDAPHelper.ldap_user_mail%>
    And device table in user details should be:
      | Device     | Used/Available      | Device Storage Limit | Last Update    | Action |
      | WIN8-64BIT | \d+\.\d+ KB / 10 GB | Set                  | < a minute ago |        |
    And I add 1 new deprovision rules:
      | rule                                | action |
      | mail=<%=LDAPHelper.ldap_user_mail%> | Delete |
    And I save the changes
    And I wait for 30 seconds
    And I push the adfs user(s) to BUS
    And I wait for 30 seconds
    And I delete 1 deprovision rules
    And I save the changes
    And I click Connection Settings tab
    Then The sync status result should like:
      | Sync Status | Finished at %m/%d/%y %H:%M %:z \(duration about \d+\.\d+ seconds*\)|
      | Sync Result | Users Provisioned: 0 succeeded \| Users Deprovisioned: 1, 0 failed |
    And I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                       |
      | <%=LDAPHelper.ldap_user_mail%> |
    Then The users table should be empty
    And I activate and back up the adfs user
      | Client  | Environment | Subdomain           | User                           |
      | mozypro | qa8         | bifrost18266mozypro | <%=LDAPHelper.ldap_user_mail%> |
