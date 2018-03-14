Feature: Linux BackupSet


  Background:
    Given I log in bus admin console as administrator

  @TC.126287 @tasks_p1 @client_configuration @bus
  Scenario: 126287 view/edit a new created linux backupset records
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 24     | 2     | 250 GB      |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126287_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes   | type excludes |
      | 126287_backupset      | test1         | test2         | autotest1       | autotest2     |
    And I click done to save linux backup sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | test1         | test2         | autotest1       | autotest2     |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      | auto1         | auto2         | *txt*           | *xlsx*        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames | exclude_filenames | filetypes | exclude_filetypes |
      | auto1     | auto2             | *txt*     | *xlsx*            |
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | auto1         | auto2         | *txt*           | *xlsx*        |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      |               |               |                 |               |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126287_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126287_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      |               |               |                 |               |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126252 @tasks_p1 @client_configuration @bus
  Scenario: 126252 #131235 BUS shows client config parent&sub-partner with same linux backup set name
    When I add a new MozyEnterprise partner:
      | company name         | period | users | server plan | net terms | root role  |
      | TC.126252_partner    | 12     | 18    | 100 GB      | yes       | FedID role |
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
      | TC.126252_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type   |
      | TC.126252_sub_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126252_sub_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | TestA                 |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I stop masquerading as sub partner
    And I create a new client config:
      | name                    | type   |
      | TC.126252_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126252_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | TestA                 |
    And I click done to save linux backup sets
    And I check the cascade for linux backup set TestA
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I act as partner by:
      | name                  |
      | TC.126252_sub_partner |
    And I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.126252_sub_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set TestA_(1)
    Then linux backup set TestA_(1) should be opened
    And I stop masquerading as sub partner
    And I stop masquerading
    And I search and delete partner account by TC.126252_sub_partner
    And I search and delete partner account by TC.126252_partner

  @TC.123886 @tasks_p1 @client_configuration @bus
  Scenario: 123886 Edit search location: include folder name&exclude file name
    When I add a new MozyEnterprise partner:
      | period | users | server plan |
      | 12     | 15    | 500 GB      |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.123886_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123886_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 123886_backupset      |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123886_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123886_backupset
    And I edit Linux Backup Set:
      | exclusionary | search locations 1      | search locations 2       |
      | true         | Include:/home/user/www* | Exclude:/home/user/test* |
    And I click done to save linux backup sets
    Then the linux backup set should be:
      | exclusionary | search locations 1      | search locations 2       |
      | true         | Include:/home/user/www* | Exclude:/home/user/test* |
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | exclusionary | search locations 1      | search locations 2       |
      | true         | Include:/home/user/www* | Exclude:/home/user/test* |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126294 @tasks_p1 @smoke @client_configuration @bus
  Scenario: 126294 Add linux backup set with include exclude search location and Options checked
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |  net terms |
      |   1    |  50 GB     |       yes     |     yes    |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126294_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126294_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | exclusionary | search locations 1        | search locations 2         | name excludes             | type includes                | type excludes |
      | 126294_backupset      | true         | Include:/home/备份/backup* | Exclude:/home/qiezi/*.exe  | note *e* "UNIT TEXT" 文件 | log txt JPG EXE MSI TA* *LSX | exe rb        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126294_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126294_backupset
    Then the linux backup set should be:
      | exclusionary | search locations 1        | search locations 2         | name excludes             | type includes                | type excludes |
      | true         | Include:/home/备份/backup* | Exclude:/home/qiezi/*.exe  | note *e* "UNIT TEXT" 文件 | log txt JPG EXE MSI TA* *LSX | exe rb        |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | exclusionary | search locations 1        | search locations 2         | exclude_filenames          | filetypes                   | exclude_filetypes |
      | true         | Include:/home/备份/backup* | Exclude:/home/qiezi/*.exe  | note *e* "UNIT TEXT" 文件 | log txt JPG EXE MSI TA* *LSX | exe rb            |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123874 @tasks_p1 @client_configuration @bus
  Scenario: 123874 Delete search location:include
    When I add a new MozyPro partner:
      | period |  base plan |   server plan |
      |   12   |  250 GB    |       yes     |
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.123874_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123874_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2         |
      | 123874_backupset      | Include:/home/user/*.txt  | Include:/home/qiezi/*.exe  |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123874_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123874_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2         |
      | Include:/home/user/*.txt  | Include:/home/qiezi/*.exe  |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2         |
      | Include:/home/user/*.txt  | Include:/home/qiezi/*.exe  |
    And I edit Linux Backup Set:
      | delete location            |
      | Include:/home/qiezi/*.exe  |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123874_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123874_backupset
    Then the linux backup set should be:
      | search locations 1        |
      | Include:/home/user/*.txt  |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        |
      | Include:/home/user/*.txt  |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126285 @tasks_p1 @client_configuration @bus
  Scenario: 126285:File name and File type includes and excludes
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |  net terms |
      |   1    |  Silver         | 1000           |      yes     |      yes   |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126285_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126285_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes                       | name excludes   | type includes   | type excludes |
      | 126285_backupset      | mozy*-8.5.3 *(copy)* "mozy backup"  | log j*p *p ex*  | log a* *d       | txt b* *f     |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126285_client_config
    And I click edit link of linux backup set 126285_backupset
    Then the linux backup set should be:
      | name includes                       | name excludes   | type includes   | type excludes |
      | mozy*-8.5.3 *(copy)* "mozy backup"  | log j*p *p ex*  | log a* *d       | txt b* *f     |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames                           | exclude_filenames | filetypes  | exclude_filetypes |
      | mozy*-8.5.3 *(copy)* "mozy backup"  | log j*p *p ex*    | log a* *d  | txt b* *f         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126276 @tasks_p1 @client_configuration @bus
  Scenario: 126276 Leave all 4 rules blank
    When I add a new MozyPro partner:
      | period |  base plan | server plan | storage add on |
      |   24   |  1 TB      | yes         | 15             |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126285_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126285_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 126285_backupset      |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126285_client_config
    And I click edit link of linux backup set 126285_backupset
    Then the linux backup set should be:
      | name includes | name excludes  | type includes | type excludes |
      |               |                |               |               |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames  | exclude_filenames | filetypes  | exclude_filetypes |
      |            |                   |            |                   |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126297 @tasks_p1 @client_configuration @bus
  Scenario: 126297 create/view/edit linux backupset of Key Type: Server
    When I add a new MozyPro partner:
      | period |  base plan | server plan | net terms |
      |   1    |  500 GB    | yes         | yes       |
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126297_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126297_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2           |
      | 126297_backupset      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126297_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126297_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2           |
      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2           |
      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And I edit Linux Backup Set:
      | search locations 1        | search locations 2           |
      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126297_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126297_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2           |
      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2           |
      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126277 @tasks_p1 @client_configuration @bus
  Scenario: 126277 Click Cancel when create a new linux backup set
    When I add a new MozyPro partner:
      | period | base plan  | server plan |
      | 12     | 4 TB       | yes         |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                    | type   |
      | TC.126277_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126277_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes   | type excludes |
      | 126277_backupset      | test1         | test2         | autotest1       | autotest2     |
    And I click cancel to cancel update linux backup sets
    Then I should on linux backup sets list page
    Then linux backup set 126277_backupset should not exist
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126277_client_config
    And I click tab Linux Backup Sets
    Then linux backup set 126277_backupset should not exist
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126278 @tasks_p1 @client_configuration @bus
  Scenario: 126278 Click Cancel when view/edit a new linux backup set
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 36     | 30    | 2 TB        | 1             |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126278_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126278_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes | type excludes |
      | 126278_backupset      | autotest      | manualtest    | *db           | *txt          |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126278_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126278_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes | type excludes |
      | autotest      | manualtest    | *db           | *txt          |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      | auto1         | auto2         | *txt*           | *xlsx*        |
    And I click cancel to cancel update linux backup sets
    Then I should on linux backup sets list page
    And I click edit link of linux backup set 126278_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes | type excludes |
      | autotest      | manualtest    | *db           | *txt          |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames | exclude_filenames | filetypes | exclude_filetypes |
      | autotest  | manualtest        | *db       | *txt              |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126298 @tasks_p1 @client_configuration @bus
  Scenario: 126298 create/view/edit linux backupset of Key Type: Desktop
    When I add a new MozyEnterprise partner:
      | period |  users | server plan | server add on |
      |   24   | 45     | 4 TB        | 9             |
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type    |
      | TC.126298_client_config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126298_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2           |
      | 126298_backupset      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126298_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126298_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2           |
      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And activate the user's Desktop device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2           |
      | Exclude:/home/user/www/   | Exclude:/home/user/new/*.txt |
    And I edit Linux Backup Set:
      | search locations 1        | search locations 2           |
      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126298_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126298_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2           |
      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2           |
      | Include:/home/user/www/   | Include:/home/user/new/*.txt |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126286 @tasks_p1 @client_configuration @bus
  Scenario: 126286 view/edit an existing linux backupset records
    When I add a new MozyEnterprise partner:
      | period | users | server plan | net terms |
      | 12     | 98    | 8 TB        | yes       |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126286_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126286_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 126286_backupset      |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126286_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126286_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      |               |               |                 |               |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames | exclude_filenames | filetypes | exclude_filetypes |
      |           |                   |           |                   |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      | mozybackup    | *log          | *txt            | *db           |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126286_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126286_backupset
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | mozybackup    | *log          | *txt            | *db           |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | filenames  | exclude_filenames | filetypes | exclude_filetypes |
      | mozybackup | *log              | *txt      | *db               |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126288 @tasks_p1 @client_configuration @bus
  Scenario: 126288 Add 2 linux backupset records
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan |
      | 24     | 10 GB     | yes       | yes         |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126288_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126288_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes  | type excludes |
      | 126288_backupset_1    | test*         | auto*         | *log           |   *txt        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126288_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126288_backupset_1
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | test*         | auto*         | *log            |   *txt        |
    And I click cancel to cancel update linux backup sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes   | type excludes |
      | 126288_backupset_2    | manual*       | auto*         | *db             |   *txt        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126288_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126288_backupset_2
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | manual*       | auto*         | *db             |   *txt        |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | linux backup set name | filenames  | exclude_filenames | filetypes | exclude_filetypes |
      | 126288_backupset_2    | manual*    | auto*             | *db       |   *txt            |
      | 126288_backupset_1    | test*      | auto*             | *log      |   *txt            |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126289 @tasks_p1 @client_configuration @bus
  Scenario: 126289 Delete a backupset records
    When I add a new Reseller partner:
      | period |  reseller type  | reseller quota |  server plan |
      |   12   |  Gold           | 998            |      yes     |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   |
      | TC.126289_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126289_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes  | type excludes |
      | 126289_backupset_1    | test*         | auto*         | *log           |   *txt        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126289_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes   | type excludes |
      | 126289_backupset_2    | manual*       | auto*         | *db             |   *txt        |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126289_client_config
    And I click tab Linux Backup Sets
    And I delete linux backup set 126289_backupset_1
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126289_client_config
    And I click tab Linux Backup Sets
    Then linux backup set 126277_backupset should not exist
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | linux backup set name | filenames  | exclude_filenames | filetypes | exclude_filetypes |
      | 126289_backupset_2    | manual*    | auto*             | *db       |   *txt            |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126290 @tasks_p1 @client_configuration @bus
  Scenario: 126290 Delete a client configuration with backupset record
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on |
      | 24     | 100   | 20 TB       | 19            |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type    |
      | TC.126290_client_config | Desktop |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126290_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 126290_backupset      |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I delete configuration TC.126290_client_config
    And activate the user's Desktop device without a key and with the default password
    And I get linux backup sets through API
    Then the linux backup set 126290_backupset should not exist in Client API
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126291 @tasks_p1 @client_configuration @bus
  Scenario: 126291 Copy a client configuration with backupset record
    When I add a new MozyPro partner:
      | period | base plan | net terms | server plan | root role               |
      | 24     | 10 GB     | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    When I add a new Bundled user group:
      | name             | storage_type | server_support |
      | TC126291-group-1 | Shared       | yes            |
    Then TC126291-group-1 user group should be created
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Server     |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                     | type   | user group            |
      | TC126291-client-config_1 | Server | (default user group)  |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC126291-client-config_1
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes  | type excludes |
      | 126291_backupset_1    | test1*        | auto1*        | *log1          |   *txt1       |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                     | type   |
      | TC126291-client-config_2 | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC126291-client-config_2
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | name includes | name excludes | type includes  | type excludes |
      | 126291_backupset_2    | test2*        | auto2*        | *log2          |   *txt2       |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I copy client configuration TC126291-client-config_1 to create new client configuration copy-client-config_1
    Then client configuration section message should be Successfully copied client configuration.
    Then the group of client configuration copy-client-config_1 should be blank
    And I edit the new created config copy-client-config_1
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126291_backupset_1
    Then the linux backup set should be:
      | name includes | name excludes | type includes   | type excludes |
      | test1*        | auto1*        | *log1           |   *txt1       |
    And I edit Linux Backup Set:
      | name includes | name excludes | type includes   | type excludes |
      | mozybackup    | *log          | *txt            | *db           |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I copy client configuration TC126291-client-config_2 to create new client configuration copy-client-config_2
    Then client configuration section message should be Successfully copied client configuration.
    Then the group of client configuration copy-client-config_2 should be blank
    And I edit the new created config copy-client-config_2
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126291_backupset_2
    Then the linux backup set should be:
      | name includes | name excludes | type includes  | type excludes |
      | test2*        | auto2*        | *log2          |   *txt2       |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | linux backup set name | filenames  | exclude_filenames | filetypes | exclude_filetypes |
      | 126291_backupset_1    | test1*     | auto1*            | *log1     |   *txt1           |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123916 @tasks_p1 @client_configuration @bus
  Scenario: 123916  create/view/edit linux backupset of Key Type: Server
    When I add a new MozyPro partner:
      | period |  base plan | server plan | storage add on  | net terms |
      |   1    |  8 TB      | yes         | 28              | yes       |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   | private key       |
      | TC.123916_client_config | Server | only private key  |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123916_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2       |
      | 123916_backupset      | Include:/home/user/www/   | Include:/home/user/www/  |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123916_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123916_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/www/   | Include:/home/user/www/  |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/www/   | Include:/home/user/www/  |
    And I edit Linux Backup Set:
      | exclusionary |
      | true         |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123916_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123916_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2       | exclusionary  |
      | Include:/home/user/www/   | Include:/home/user/www/  |  true         |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2       | exclusionary  |
      | Include:/home/user/www/   | Include:/home/user/www/  |  true         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.123917 @tasks_p1 @client_configuration @bus
  Scenario: 123917 Use ckey user for Linux backup sets
    When I add a new MozyEnterprise partner:
      | period | users | server plan | server add on  |
      |   36   | 112   | 24 TB       | 39             |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    And I add new user(s):
      |user_group           | storage_type | storage_limit | devices |
      |(default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   | ckey                          |
      | TC.123917_client_config | Server | http://burgifam.com/Rich.ckey |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123917_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2       |
      | 123917_backupset      | Include:/home/user/ckey/  | Include:/home/user/ckey/ |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123917_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123917_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/ckey/  | Include:/home/user/ckey/ |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/ckey/  | Include:/home/user/ckey/ |
    And I edit Linux Backup Set:
      | exclusionary |
      | true         |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123917_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 123917_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2       | exclusionary  |
      | Include:/home/user/ckey/  | Include:/home/user/ckey/ |  true         |
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2       | exclusionary  |
      | Include:/home/user/ckey/  | Include:/home/user/ckey/ |  true         |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.126296 @tasks_p1 @client_configuration @bus
  Scenario: 126296 Create a linux backupset with Setting Cascade and Lock checked
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan | net terms  | root role  |
      | TC.126296_partner |   12   | 129   | 28 TB       | yes        | FedID role |
    Then New partner should be created
    And I get the partner_id
    And I get the admin id from partner details
    When I act as newly created partner account
    When I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC126296-group-1 | Shared               | 5               | Shared              | 10             |
    Then TC126296-group-1 user group should be created
    And I add new user(s):
      |user_group           | storage_type | storage_limit | devices |
      |(default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                    | type   | user group           |
      | TC.126296_client_config | Server | (default user group) |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126296_client_config
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name | search locations 1        | search locations 2       |
      | 126296_backupset      | Include:/home/user/test/  | Include:/home/user/auto/ |
    And I click done to save linux backup sets
    And I check the cascade for linux backup set 126296_backupset
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126296_client_config
    And I click tab Linux Backup Sets
    And I click edit link of linux backup set 126296_backupset
    Then the linux backup set should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/test/  | Include:/home/user/auto/ |
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | search locations 1        | search locations 2       |
      | Include:/home/user/test/  | Include:/home/user/auto/ |
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
      | TC.126296_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type   |
      | TC.126296_sub_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.126296_sub_client_config
    And I click tab Linux Backup Sets
    Then linux backup set 126296_backupset should exist
    Then the setting and lock of linux backup set 126296_backupset should be disabled
    Then the setting and lock of linux backup set 126296_backupset should be checked
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.126296_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.126296_partner

  @TC.123884 @tasks_p1 @client_configuration @bus
  Scenario: 123884 Set a client config options to add/remove setting - Linux BackupSets
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan | net terms  | root role  |
      | TC.123884_partner |   36   | 130   | 16 TB       | yes        | FedID role |
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
      | TC.123884_sub_partner |
    Then New partner should be created
    And I get the subpartner_id
    And I get the subadmin id from partner details
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 100             | 100           | 100            | 100          |
    Then Resources should be purchased
    And I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC123884-group-1 | Shared               | 5               | Shared              | 10             |
    Then TC123884-group-1 user group should be created
    And I add new user(s):
      |user_group           | storage_type | storage_limit | devices |
      |(default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    When I create a new client config:
      | name                      | type   |
      | TC.123884_client_config_1 | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_client_config_1
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 123884_backupset_1    |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                      | type   | user group           |
      | TC.123884_client_config_2 | Server | (default user group) |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_client_config_2
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 123884_backupset_2      |
    And I click done to save linux backup sets
    And I check the setting for linux backup set 123884_backupset_2
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_client_config_1
    And I click tab Linux Backup Sets
    Then linux backup set 123884_backupset_2 should not exist
    And I cancel update client configuration
    When I create a new client config:
      | name                      | type   |
      | TC.123884_client_config_3 | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_client_config_3
    And I click tab Linux Backup Sets
    Then linux backup set 123884_backupset_2 should exist
    Then the setting of linux backup set 123884_backupset_2 should be checked
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name       | Type          | Parent  |
      | subsubrole | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name       | Company Type | Root Role  | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subsubplan | business     | subsubrole | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name              |
      | TC.123884_sub_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type   |
      | TC.123884_sub_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_sub_client_config
    And I click tab Linux Backup Sets
    Then linux backup set 123884_backupset_2 should exist
    Then the setting of linux backup set 123884_backupset_2 should be checked
    And I stop masquerading as sub partner
    And I get linux backup sets through API
    Then the backup sets from API should be:
      | linux backup set name |
      | 123884_backupset_2    |
    When I navigate to Client Configuration section from bus admin console page
    And I edit the new created config TC.123884_client_config_2
    And I click tab Linux Backup Sets
    And I uncheck the setting for linux backup set 123884_backupset_2
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    When I create a new client config:
      | name                      | type   |
      | TC.123884_client_config_4 | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123884_client_config_4
    And I click tab Linux Backup Sets
    Then linux backup set 123884_backupset_2 should exist
    Then the setting of linux backup set 123884_backupset_2 should be unchecked
    And I create Linux Backup Set:
      | linux backup set name |
      | 123884_backupset_4    |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I get linux backup sets through API
    Then the linux backup set 123884_backupset_2 should not exist in Client API
    And I search and delete partner account by TC.123884_sub_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.123884_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.123884_partner

  @TC.123882 @tasks_p1 @client_configuration @bus
  Scenario: 123882 Delete a client config options with Cascade - Linux BackupSets
    When I add a new MozyEnterprise partner:
      | company name      | period | users | server plan | net terms  | root role  | server add on |
      | TC.123882_partner |   12   | 200   | 12 TB       | yes        | FedID role | 40            |
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
      | TC.123882_sub_partner |
    Then New partner should be created
    And I get the subpartner_id
    And I get the subadmin id from partner details
    When I act as newly created partner account
    And I purchase resources:
      | desktop license | desktop quota | server license | server quota |
      | 100             | 100           | 100            | 100          |
    And I add a new Itemized user group:
      | name             | desktop_storage_type | desktop_devices | server_storage_type | server_devices |
      | TC123882-group-1 | Shared               | 5               | Shared              | 10             |
    Then TC123882-group-1 user group should be created
    And I add new user(s):
      |user_group           | storage_type | storage_limit | devices |
      |(default user group) |  Server      |  1            |  1      |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    When I create a new client config:
      | name                      | type   | user group           |
      | TC.123882_client_config_1 | Server | (default user group) |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123882_client_config_1
    And I click tab Linux Backup Sets
    And I create Linux Backup Set:
      | linux backup set name |
      | 123882_backupset_1    |
    And I click done to save linux backup sets
    And I check the cascade for linux backup set 123882_backupset_1
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And I delete configuration TC.123882_client_config_1
    When I create a new client config:
      | name                      | type   |
      | TC.123882_client_config_2 | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123882_client_config_2
    And I click tab Linux Backup Sets
    Then linux backup set 123882_backupset_1 should not exist
    And I create Linux Backup Set:
      | linux backup set name |
      | 123882_backupset_2    |
    And I click done to save linux backup sets
    And I save the client configuration changes
    Then client configuration section message should be Your configuration was saved.
    And activate the user's Server device without a key and with the default password
    And I get linux backup sets through API
    Then the linux backup set 123882_backupset_1 should not exist in Client API
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name       | Type          | Parent  |
      | subsubrole | Partner admin | subrole |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for MozyEnterprise partner:
      | Name       | Company Type | Root Role  | Periods | Tax Percentage | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | subsubplan | business     | subsubrole | yearly  | 10             | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name              |
      | TC.123882_sub_sub_partner |
    Then New partner should be created
    When I act as newly created partner account
    And I create a new client config:
      | name                        | type   |
      | TC.123882_sub_client_config | Server |
    Then client configuration section message should be Your configuration was saved.
    And I edit the new created config TC.123882_sub_client_config
    And I click tab Linux Backup Sets
    Then linux backup set 123882_backupset_1 should not exist
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.123882_sub_sub_partner
    And I stop masquerading as sub partner
    And I search and delete partner account by TC.123882_sub_partner
    And I stop masquerading
    And I search and delete partner account by TC.123882_partner




















