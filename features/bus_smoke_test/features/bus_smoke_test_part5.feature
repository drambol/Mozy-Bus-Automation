Feature: BUS smoke test part 5
  pre-condition
  update environment:
  option 1: TEST_ENV = ENV['BUS_ENV'] || 'qa6' in test_sites/configs/configs_helper.rb
  option 2: export BUS_ENV=<environment>

  Background:
    Given I log in bus admin console as administrator

  #================== partner 'Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90' related scenarios ===================
  @bus_emea @TC.125966 @ROR_smoke
  Scenario: Test Case Mozy-125966: BUS EMEA -- Activate partner in email
    When I add a new Reseller partner:
      | company name                                                 | period | base plan | create under    | server plan | net terms | country | coupon                |
      | Internal Mozy - Reseller Ireland BUS Smoke Test 7531-8642-90 | 12     | 10 GB     | MozyPro Ireland | yes         | yes       | Ireland | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And the partner has activated the admin account with default password
    And I go to account
    Then I login as mozypro admin successfully

  #================== partner 'Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07' related scenarios ===================
  @bus_emea @TC.125975 @qa @ROR_smoke
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I add a new MozyPro partner:
      | company name                                                            | period  | base plan | create under   | server plan | net terms | country | coupon                |
      | Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07 | 12      | 50 GB     | MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I change root role to Business Root
    When I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type  | storage_limit | devices |
      | (default user group) | Desktop       | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 10    |
    Then Data shuttle order should be created

  @bus_emea @TC.125976 @qa @ROR_smoke
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle - Precondition:@TC.125975
    When I search order in view data shuttle orders section by Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    When I cancel the latest data shuttle order for Internal Mozy - MozyPro France BUS Smoke Test Data Shuttle 2468-1359-07
    Then The order should be Cancelled

  @bus_emea @TC.125975 @std
  Scenario: Test Case Mozy-125975: BUS EMEA -- Order Data Shuttle
    When I order data shuttle for Internal Mozy - DoNotEdit - MozyPro France for EMEA Data Shuttle
      | power adapter     | key from  |
      | Data Shuttle EMEA | available |
    Then Data shuttle order should be created

  @bus_emea @TC.125976 @std
  Scenario: Test Case Mozy-125976: BUS EMEA -- Update Data Shuttle - Precondition:@TC.125975
    When I search order in view data shuttle orders section by Internal Mozy - DoNotEdit - MozyPro France for EMEA Data Shuttle
    And I view data shuttle order details
    And I add drive to data shuttle order
    Then Add drive to data shuttle order message should include Successfully added drive to order
    When I cancel the latest data shuttle order for Internal Mozy - DoNotEdit - MozyPro France for EMEA Data Shuttle
    Then The order should be Cancelled

  #=====================================
  @bus_emea @TC.125979
  Scenario: Test Case Mozy-125979: BUS EMEA -- Delete test partner and validate they are in Pending Delete state
    When I add a new MozyPro partner:
      | company name                                        | period  |  create under   | server plan | net terms | country | coupon                |
      | Internal Mozy - MozyPro BUS Smoke Test 5979-5120-35 | 12      |  MozyPro France | yes         | yes       | France  | <%=QA_ENV['coupon']%> |
    And New partner should be created
    And I delete partner and verify pending delete

  @bus_emea @TC.125980
  Scenario: Test Case Mozy-125980: BUS EMEA -- Create a new partner (With VAT Number)
    When I add a new MozyPro partner:
      | company name                                        | period | base plan | create under | server plan | net terms | country        | coupon                | vat number  |
      | Internal Mozy - MozyPro BUS Smoke Test 5980-4326-85 | 1      | 10 GB     | MozyPro UK   | yes         | yes       | United Kingdom | <%=QA_ENV['coupon']%> | GB117223643 |
    And New partner should be created
    Then I delete partner account

  @bus_us @TC.125981 @prod
  Scenario: Test Case Mozy-125981: BUS US -- Download manifests for US user machine
  # data center: UT3
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords                      |
      | ut3dc@mozy.com  |
    And I view user details by ut3dc@mozy.com
    And I view machine DCEXEC02UT3 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXEC02UT3 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                                |
      | manifest-ut3dc@mozy.com-DCEXEC02UT3.txt  |
    Then I delete the newly downloaded file
  # data center: UT4
    And I close machine details section
    And I close user details section
    And I search user by:
      | keywords                      |
      | ut4dc@mozy.com  |
    And I view user details by ut4dc@mozy.com
    And I view machine DCEXEC03UT4 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXEC03UT4 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                                |
      | manifest-ut4dc@mozy.com-DCEXEC03UT4.txt  |
    Then I delete the newly downloaded file
  # data center: UT5
    And I close machine details section
    And I close user details section
    And I search user by:
      | keywords                      |
      | ut5dc@mozy.com  |
    And I view user details by ut5dc@mozy.com
    And I view machine DCEXEC04UT5 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXEC04UT5 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                                |
      | manifest-ut5dc@mozy.com-DCEXEC04UT5.txt  |
    Then I delete the newly downloaded file
  # data center: UT7
    And I close machine details section
    And I close user details section
    And I search user by:
      | keywords                      |
      | ut7dc@mozy.com  |
    And I view user details by ut7dc@mozy.com
    And I view machine DCEXEC05UT7 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXEC05UT7 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                                |
      | manifest-ut7dc@mozy.com-DCEXEC05UT7.txt  |
    Then I delete the newly downloaded file

  @bus_emea @TC.125982 @prod
  Scenario: Test Case Mozy-125982: BUS EMEA -- Download manifests for EMEA user machine
  # data center: IRL2
    When I navigate to Search / List Users section from bus admin console page
    And I search user by:
      | keywords         |
      | irl2dc@mozy.com  |
    And I view user details by irl2dc@mozy.com
    And I view machine DCEXEC06IRL2 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXEC06IRL2 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                                  |
      | manifest-irl2dc@mozy.com-DCEXEC06IRL2.txt  |
    Then I delete the newly downloaded file
  # data center: DUB1
    And I close machine details section
    And I close user details section
    And I search user by:
      | keywords         |
      | dub1dc@mozy.com  |
    And I view user details by dub1dc@mozy.com
    And I view machine DCEXECDUB1 details from user details section
    And I click manifest view link
    And view manifest window of machine DCEXECDUB1 is opened
    And I click manifest raw link to download the manifest file
    Then the manifest file is downloaded
      | file name                               |
      | manifest-dub1dc@mozy.com-DCEXECDUB1.txt |
    Then I delete the newly downloaded file
