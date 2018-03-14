Feature: Password policy is saved successfully to db

  Background:
    Given I log in bus admin console as administrator

  @TC.120092 @password_policy @bus @regression @core_function
  Scenario: 120092 [MozyEnterprise]Hipaa partner password policy settings should be saved to database correctly
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.120103 @password_policy @bus @regression @core_function
  Scenario: 120103 [Reseller]Hipaa partner password policy settings should be saved to database correctly
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading as sub partner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120104 @password_policy @bus @regression @core_function
  Scenario: 120104 [OEM]Hipaa partner password policy settings should be saved to database correctly
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
    When I act as newly created partner account
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Company Name | Admin Name |
      | subpartner   | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then The subpartner user password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The user password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then The subpartner admin password policy from rails console will be
      | min_length | min_character_classes | min_age_hours | max_age_days | min_generations | max_failures_per_ip | failure_period_per_ip | lockout_duration_per_ip | max_failures_per_username | failure_period_per_username | lockout_duration_per_username | failures_before_captcha | display_captcha_on_login | verify_email_address |
      | 8          | 3                     | 0             | 90           | 12              | 3                   | 5                     | 30                      | 3                         | 5                           | 30                            | 2                       | t                        | f                    |
    And The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special | upper |
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.120088  @password_policy @bus @regression @core_function
  Scenario: 120088 [MozyEnterprise]Hipaa admin cannot see the password policy link in admin console
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms | root role  | security |
      | 12     | 18    | 100 GB      | yes       | FedID role | HIPAA    |
    Then New partner should be created
    When I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120089  @password_policy @bus @regression @core_function
  Scenario: [Reseller]120089 Hipaa admin cannot see the password policy link in admin console
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | security |
      | 12     | Silver        | 100            | yes       | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
    When I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    And I add a new sub partner:
      | Company Name | Pricing Plan | Admin Name |
      | subpartner   | subplan      | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading as sub partner
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120090 @password_policy @bus @regression @core_function
  Scenario: 120090 [OEM]Hippa admin cannot see the password policy link in admin console
    When I add a new OEM partner:
      | Security |
      | HIPAA    |
    Then New partner should be created
    When I view the newly created subpartner admin details
    And I act as newly created partner account
    Then I will not see the Password Policy link from navigation links
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | subrole | Partner admin |
    And I check all the capabilities for the new role
    And I add a new sub partner:
      | Company Name | Admin Name |
      | subpartner   | subadmin   |
    Then New partner should be created
    And I act as newly created subpartner account
    Then I will not see the Password Policy link from navigation links
    Then I stop masquerading from subpartner
    And I search and delete partner account by newly created subpartner company name

  @TC.120553 @tasks_p1 @password_policy @bus @ROR_smoke
  Scenario: 120553 Setting up a Password policy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  |
      | 24     | 20    | 250 GB      | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 3                     | Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 6          | 3                     | 0             | 1               | f                        | f                    |
    Then The user and admin password will contains at least 3 of the following types of charactors
      | lower | digit | special |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120555 @tasks_p1 @password_policy @bus
  Scenario: 120555 Custom user password policy with default admin policy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |root role  |
      | 36     | 100   | 1 TB        | 10            |FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles      |
      | TC.120555_admin | FedID role |
    And I view the admin details of TC.120555_admin
    And I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120555_user | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I activate the user
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                             |
      | custom           | 6          | 2                     | Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy | admin policy type |
      | No                     | default           |
    And I save password policy
    Then Password policy updated successfully
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 6          | 2                     | 0             | 1               | f                        | f                    |
    Then The user password will contains at least 2 of the following types of charactors
      | lower | digit | special |
    Then The admin should use default password policy
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I update user password to incorrect password wrongpass and get the error message:
    """
    Passwords must contain at least 2 of the following types of characters: numbers, lowercase letters, special characters
    """
    Then I update user password to incorrect password pass! and get the error message:
    """
    Please enter a password at least 6 characters long
    """
    And I update the user password to test1234
    And I navigate to Add New Admin section from bus admin console page
    And I view the admin details of TC.120555_admin
    And I change admin password to pass!
    Then Fail to update admin password and the message should be Please enter a password at least 8 characters long
    And I change admin password to testps12!
    Then Succeed to update admin password and the message should be The password for TC.120555_admin has been changed.
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120556 @tasks_p1 @password_policy @bus
  Scenario: 120556 Using same password policy for admins and users
    When I add a new MozyEnterprise partner:
      | period | users | server plan | root role  | net terms |
      | 24     | 5     | 50 GB       | FedID role | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles      |
      | TC.120556_admin | FedID role |
    And I view the admin details of TC.120556_admin
    And I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120556_user | (default user group) | Desktop      | 10            | 2       | yes          |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I activate the user
    When I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                      |
      | custom           | 8          | 2                     | Lowercase letters,Special characters   |
    And I edit admin passowrd policy:
      | admin user same policy |
      | Yes                    |
    And I save password policy
    Then Password policy updated successfully
    Then The user and admin password policy from database will be
      | user_type | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | all       | 8          | 2                     | 0             | 1               | f                        | f                    |
    Then The user and admin password will contains at least 2 of the following types of charactors
      | lower | special |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I update user password to incorrect password wrongpass and get the error message:
    """
    Passwords must contain all of the following types of characters: lowercase letters, special characters
    """
    Then I update user password to incorrect password pass! and get the error message:
    """
    Please enter a password at least 8 characters long
    """
    And I update the user password to testp!pp
    And I navigate to Add New Admin section from bus admin console page
    And I view the admin details of TC.120556_admin
    And I change admin password to wrongpass
    Then Fail to update admin password and the message should be Passwords must contain all of the following types of characters: lowercase letters, special characters
    And I change admin password to pass!
    Then Fail to update admin password and the message should be Please enter a password at least 8 characters long
    And I change admin password to testp!pp
    Then Succeed to update admin password and the message should be The password for TC.120556_admin has been changed.
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120557 @tasks_p1 @password_policy @bus
  Scenario: 120557 Using custom admin password policy with default user policy
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |root role  |
      | 12     | 10    | 2 TB        | 99            |FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles      |
      | TC.120557_admin | FedID role |
    And I view the admin details of TC.120557_admin
    And I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.120557_user | (default user group) | Desktop      | 15            | 2       | yes          |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I activate the user
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type |
      | default          |
    And I edit admin passowrd policy:
      | admin user same policy | min length | admin policy type | min character classes | character classes                             |
      | No                     | 6          | custom            | 3                     | Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 6          | 3                     | 0             | 1               | f                        | f                    |
    Then The admin password will contains at least 3 of the following types of charactors
      | lower | digit | special |
    Then The user should use default password policy
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I update user password to incorrect password pass! and get the error message:
    """
    Please enter a password at least 8 characters long
    """
    And I update the user password to testps1.
#    And I update the user password to testps
    And I navigate to Add New Admin section from bus admin console page
    And I view the admin details of TC.120557_admin
    And I change admin password to wrongpass
    Then Fail to update admin password and the message should be Passwords must contain all of the following types of characters: numbers, lowercase letters, special characters
    And I change admin password to pa12!
    Then Fail to update admin password and the message should be Please enter a password at least 6 characters long
    And I change admin password to test123!
    Then Succeed to update admin password and the message should be The password for TC.120557_admin has been changed.
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.120091 @tasks_p1 @password_policy @bus
  Scenario: 120091 [MozyEnterprise]Non Hipaa admin can see the password policy link in admin console
    When I add a new MozyEnterprise partner:
      | period | users | server plan |root role  | security |
      | 24     | 98    | 500 GB      |FedID role | HIPAA    |
    Then New partner should be created
    And I act as newly created partner account
    Then I should not see Password Policy link
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131877 @tasks_p1 @password_policy @bus
  Scenario: 131877 Custom Complextity, 2nd radio button and 4 in textbox and all checkboxes
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on | root role  | net terms |
      | 36     | 59    | 8 TB        | 58            | FedID role | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles      |
      | TC.131877_admin | FedID role |
    And I view the admin details of TC.131877_admin
    And I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.131877_user | (default user group) | Desktop      | 12            | 5       | yes          |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I activate the user
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min character classes | character classes                                             |
      | custom           | 4                     | Capital letters,Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy | admin policy type | min character classes | character classes                                             |
      | No                     | custom            | 4                     | Capital letters,Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 8          | 4                     | 0             | 1               | f                        | f                    |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 8          | 4                     | 0             | 1               | f                        | f                    |
    Then The user password will contains at least 4 of the following types of charactors
      | upper | lower | digit | special |
    Then The admin password will contains at least 4 of the following types of charactors
      | upper | lower | digit | special |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I update user password to incorrect password Pas4! and get the error message:
    """
    Please enter a password at least 8 characters long
    """
    Then I update user password to incorrect password test123! and get the error message:
    """
    Passwords must contain all of the following types of characters: numbers, lowercase letters, special characters, capital letters
    """
    And I update the user password to Test123!
    And I navigate to Add New Admin section from bus admin console page
    And I view the admin details of TC.131877_admin
    And I change admin password to test1234!
    Then Fail to update admin password and the message should be Passwords must contain all of the following types of characters: numbers, lowercase letters, special characters, capital letters
    And I change admin password to Pa12!
    Then Fail to update admin password and the message should be Please enter a password at least 8 characters long
    And I change admin password to Test1234!
    Then Succeed to update admin password and the message should be The password for TC.131877_admin has been changed.
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.131879 @tasks_p1 @smoke @password_policy @bus
  Scenario: 131879 Sub Partner, Custom Complextity, 2nd radio button and input 3 in textbox and select all checkboxes
    When I add a new MozyEnterprise partner:
      | company name       | period | users | server plan | root role  |
      | TC.131879_partner  | 12     | 9     | 4 TB        | FedID role |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | subrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name    | Company Type | Root Role | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subplan | business     | subrole   | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.131879_sub_partner |
    Then New partner should be created
    And I change pooled resource for the subpartner:
      | Desktop Storage | Desktop Devices |
      | 20              | 1               |
    When I act as newly created partner account
    And I navigate to Add New Admin section from bus admin console page
    And I add a new admin:
      | Name            | Roles      |
      | TC.131879_admin | subrole    |
    And I view the admin details of TC.131879_admin
    And I active admin in admin details default password
    And I add new user(s):
      | name           | user_group           | storage_type | storage_limit | devices | enable_stash |
      | TC.131879_user | (default user group) | Desktop      | 5             | 1       | yes          |
    Then 1 new user should be created
    And I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I activate the user
    And I navigate to Password Policy section from bus admin console page
    And I edit user passowrd policy:
      | user policy type | min length | min character classes | character classes                                             |
      | custom           | 6          | 3                     | Capital letters,Lowercase letters,Numbers,Special characters  |
    And I edit admin passowrd policy:
      | admin user same policy | min length | admin policy type | min character classes | character classes                                             |
      | No                     | 6          | custom            | 3                     | Capital letters,Lowercase letters,Numbers,Special characters  |
    And I save password policy
    Then Password policy updated successfully
    Then The user password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 6          | 3                     | 0             | 1               | f                        | f                    |
    Then The admin password policy from database will be
      | min_length | min_character_classes | min_age_hours | min_generations | display_captcha_on_login | verify_email_address |
      | 6          | 3                     | 0             | 1               | f                        | f                    |
    Then The user password will contains at least 3 of the following types of charactors
      | upper | lower | digit | special |
    Then The admin password will contains at least 3 of the following types of charactors
      | upper | lower | digit | special |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    Then I update user password to incorrect password pas4! and get the error message:
    """
    Please enter a password at least 6 characters long
    """
    Then I update user password to incorrect password test1234 and get the error message:
    """
    Passwords must contain at least 3 of the following types of characters: numbers, lowercase letters, special characters, capital letters
    """
    And I update the user password to test123!
    And I navigate to Add New Admin section from bus admin console page
    And I view the admin details of TC.131879_admin
    And I change admin password to test1234
    Then Fail to update admin password and the message should be Passwords must contain at least 3 of the following types of characters: numbers, lowercase letters, special characters, capital letters
    And I change admin password to pa12!
    Then Fail to update admin password and the message should be Please enter a password at least 6 characters long
    And I change admin password to test1234!
    Then Succeed to update admin password and the message should be The password for TC.131879_admin has been changed.
    And I stop masquerading as sub partner
    And I stop masquerading
    And I search and delete partner account by TC.131879_sub_partner
    And I search and delete partner account by TC.131879_partner

