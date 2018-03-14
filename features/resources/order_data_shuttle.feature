Feature: Order data shuttle


  Background:
    Given I log in bus admin console as administrator

  @TC.12355 @bus @data_shuttle @order @regression @core_function
  Scenario: 12355 Add a new partner and verify it appears in the module
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12659 @bus @data_shuttle @order @regression @core_function
  Scenario: 12659 Delete a partner and verify the module updates correctly
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I delete partner account
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty

  @TC.12354 @bus @data_shuttle @order @regression @core_function
  Scenario: 12354 Verify Module - General UI Controls
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by this is a really long text this is a really long text this is a really long text
    Then Partner search results in order data shuttle section should be empty
    When I clear partner search results in order data shuttle section
    And I search partner in order data shuttle section by $%^**
    Then Partner search results in order data shuttle section should be empty
    When I collapse order data shuttle section
    And Partner search results in order data shuttle section should be invisible

  @TC.12662 @bus @data_shuttle @order @regression @core_function
  Scenario: 12662 Verify Partners Appear - Search
    When I add a new MozyPro partner:
      | period | base plan | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12661 @bus @data_shuttle @order @regression @core_function
  Scenario: 12661 Verify EMEA Pro Partners Appear - Search
    When I add a new MozyPro partner:
      | period | base plan | create under    | country  | cc number        |
      | 1      | 250 GB    | MozyPro Ireland | Ireland  | 4319402211111113 |
    Then New partner should be created
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partners search results in order data shuttle section should be:
      | Partner        | Root Admin    | Type    |
      | @partner_name  | @admin_email  | MozyPro |
    Then I search and delete partner account by newly created partner company name

  @TC.12942 @bus @data_shuttle @order @regression @core_function
  Scenario: 12942 Suspended partner order data shuttle
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    Then New partner should be created
    And I suspend the partner
    When I navigate to Order Data Shuttle section from bus admin console page
    And I search partner in order data shuttle section by newly created partner company name
    Then Partner search results in order data shuttle section should be empty
    Then I search and delete partner account by newly created partner company name

  @TC.12368 @bus @data_shuttle @process @verify_shipping_address_tab @regression @core_function
  Scenario: 12368 Verify Shipping Address Section - Populated Fields Correctly
    When I add a new MozyPro partner:
      | period | base plan | admin name     | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 50 GB     | TC.16188 Admin | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I navigate to process data shuttle order section for newly created partner company name
    Then Verify shipping address table should be:
      | description            | value             |
      | Name:                  | TC.16188 Admin    |
      | Address 1:             | 3401 Hillview Ave |
      | Address 2:             |                   |
      | City:                  | Palo Alto         |
      | State/Province/Region: | CA                |
      | Country:               | United States     |
      | Zip/Postal Code:       | 94304             |
      | Phone Number:          | 1-877-486-9273    |
      | Power Adapter:         |                   |
    And I search and delete partner account by newly created partner company name

  @TC.12370 @bus @data_shuttle @process @verify_shipping_address_tab @regression @core_function
  Scenario: 12370 Verify shipping address - field validate
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I order data shuttle for newly created partner company name
      | name | address 1 | city | state | phone | zip |
      |      |           |      |       |       |     |
    Then Order data shuttle message should include Please specify a name
    And Order data shuttle message should include Please specify an address
    And Order data shuttle message should include Please specify a city
    And Order data shuttle message should include Please specify a state
    And Order data shuttle message should include Please specify a phone number
    And Order data shuttle message should include Please specify a zip
    And Order data shuttle message should include Please select the power adapter type.
    And I search and delete partner account by newly created partner company name

  @TC.12184 @bus @data_shuttle @status @device_status @regression @core_function @ROR_smoke
  Scenario: 12184 Verify Data Shuttle Device Status report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device status summary table header should be:
      | Ordered | Not Started | Seeding | Seed Complete | Seed Error | Loading  | Load Complete | Load Error | Cancelled |

  @TC.12197 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12197 Verify clicking Seeding
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle seeding status table
    Then Data shuttle device seeding status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12198 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12198 Verify clicking Seed Complete
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle seed complete status table
    Then Data shuttle device seed complete status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12199 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12199 Verify clicking Seed Error
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle seed error status table
    Then Data shuttle device seed error status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12200 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12200 Verify clicking Loading
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle loading status table
    Then Data shuttle device loading status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12201 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12201 Verify clicking Load Complete
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle load complete status table
    Then Data shuttle device load complete status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12203 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12203 Verify clicking Load Error
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle load error status table
    Then Data shuttle device load error status table header should be:
      |Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12202 @bus @data_shuttle @status @device_status @regression @core_function
  Scenario: 12202 Verify clicking Cancelled
    When I navigate to Data Shuttle Status section from bus admin console page
    And I view data shuttle cancelled status table
    Then Data shuttle device cancelled status table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed | Cancelled |

  @TC.12185 @bus @data_shuttle @status @device_stuck @regression @core_function
  Scenario: 12185 Verify Data Shuttle Stuck report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck summary table header should be:
      | > 7 days | > 14 days | > 30 days |

  @TC.12204 @bus @data_shuttle @status @device_stuck @regression @core_function
  Scenario: 12204 Verify Data Shuttle Stuck > 7 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 7 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12922 @bus @data_shuttle @status @device_stuck @regression @core_function
  Scenario: 12922 Verify Data Shuttle Stuck > 14 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 14 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12923 @bus @data_shuttle @status @device_stuck @regression @core_function
  Scenario: 12923 Verify Data Shuttle Stuck > 30 days
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle device stuck over 30 days table header should be:
      | Order # | Partner | Created | Key | Machine | Data Shuttle Device ID | Phase | Status | % Complete | GB Transferred | Seed Size | Start | Elapsed |

  @TC.12186 @bus @data_shuttle @status @data_inventory_status @regression @core_function
  Scenario: 12186 Verify Data Inventory Status report
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory status summary table header should be:
      | Drives @ 3PL Site | Active Drives | Drives at 80% Life | Dead Drives (100%+) |

  @TC.12216 @bus @data_shuttle @status @data_inventory_status @regression @core_function
  Scenario: 12216 Verify the Active Drives #
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory active drivers status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.12295 @bus @data_shuttle @status @data_inventory_status @regression @core_function
  Scenario: 12295 Verify the # of drives at 80%
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory drivers at 80% life status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.12296 @bus @data_shuttle @status @data_inventory_status @regression @core_function
  Scenario: 12296 Verify the Dead Drives #
    When I navigate to Data Shuttle Status section from bus admin console page
    Then Data shuttle inventory dead drivers status table header should be:
      | Drive SN | % Life Used | Current Location | Order | Phase |

  @TC.16183 @bus @data_shuttle @regression @core_function
  Scenario: 16183 Verify ordering data shuttle exceed partner available resources
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    And I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 5000  | 2.5" 1TB Drive |
    Then order data shuttle message should be:
    """
    The resources added in this Data Shuttle order exceed those available for machine 'AUTOTEST'. Please visit the Edit Machine page to add more resources.
    """
    And I search and delete partner account by newly created partner company name

  @TC.16325 @bus @data_shuttle @regression @core_function
  Scenario: 16325 Ordering data shuttle with 110% Discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 1     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | discount | drive type     |
      | Data Shuttle US | available | 110      | 3.5" 2TB Drive |
    Then order data shuttle message should be:
    """
    Discount >100% are not allowed. Please correct the value in the red box
    """
    And I search and delete partner account by newly created partner company name

  @TC.21985 @bus @slow @regression @core_function
  Scenario: 21985 Ordering data shuttle for MozyPro
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 50 GB     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 30            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16324 @slow @bus @data_shuttle @regression @core_function
  Scenario: 16324 Ordering data shuttle with 50% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount | drive type     |
      | Data Shuttle US | available | 10    | 50       | 3.5" 2TB Drive |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 1        | $275.00  |
      | Total Price         |          | $137.50  |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16323 @slow @bus @data_shuttle @regression @core_function
  Scenario: 16323 Ordering data shuttle with 100% discount
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | discount | drive type     |
      | Data Shuttle US | available | 10    | 100      | 3.5" 2TB Drive |
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $0.00   |
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16211 @bus @data_shuttle @regression @core_function
  Scenario: 16211 Canceling orders that were created using the Add Link
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 20    |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for newly created partner company name
    Then The order should be Cancelled
    And I search and delete partner account by newly created partner company name

  @TC.17879 @bus @data_shuttle @regression @core_function
  Scenario: 17879 Ordering data shuttle over 1.8T for Reseller
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 2000          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 2000  | 3.5" 2TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 3.6 TB | 1        | $375.00 |
      | Total Price         |          | $375.00 |
    Then The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16320 @bus @data_shuttle @regression @core_function
  Scenario: 16320 Ordering data shuttle over 3.6T for MozyPro
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 4 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 3800          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 3800  | 3.5" 2TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 5.4 TB | 1        | $475.00 |
      | Total Price         |          | $475.00 |
    Then The number of win drivers should be 3
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16340 @bus @data_shuttle @regression @core_function
  Scenario: 16340 Manually change number of windows drives ordered
    When I add a new Reseller partner:
      | period | reseller type | reseller quota |
      | 1      | Silver        | 2000           |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 1000        | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | drive type     |
      | Data Shuttle US | available | 1000  | 2           | 3.5" 2TB Drive |
    And The number of win drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.16342 @bus @data_shuttle @regression @core_function
  Scenario: 16342 Manually change number of mac drives ordered
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 1 TB      |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | storage_type | storage_limit | devices |
      | Desktop      | 500           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | win drivers | mac drivers | drive type     |
      | Data Shuttle US | available | 500   | 0           | 2           | 3.5" 2TB Drive |
    And The number of mac drivers should be 2
    Then Data shuttle order should be created
    And I search and delete partner account by newly created partner company name

  @TC.17881 @bus @data_shuttle @regression @core_function
  Scenario: 17881 Verify billing statements when order a data shuttle
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      #| today | $0.00   | $275.00    | $-275.00    |
      | today | $275.00 | $275.00    | $0.00       |
      | today | $190.00 | $190.00    | $0.00       |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.21978 @bus @data_shuttle @status @BUG.91049 @regression @core_function
  Scenario: 21978 Data shuttle backed up til load complete, then second data shuttle seeded for same user/key/machine
    When I add a new MozyEnterprise partner:
      | period | users |
      | 12     | 2     |
    Then New partner should be created
    When I get the partner_id
    And I get the admin id from partner details
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) |  Desktop     |  20           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status  |
      | seeding |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    Then I close machine details section
    And I set the data shuttle seed status:
      | status        | total files | total bytes |
      | seed_complete | 1000        | 2097152     |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Seed Complete |
    Then I close machine details section
    And I set the data shuttle seed status:
      | status  | total files seeded | total bytes seeded |
      | loading | 100                | 2000000            |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Loading |
    Then I close machine details section
    And I set the data shuttle seed status:
      | status        | total files | total bytes | total files seeded | total bytes seeded |
      | load_complete | 1000        | 2097152     | 1000               | 2097152            |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase         |
      | <%=@seed_id%> | <%=@seed_id%>          | Load Complete |
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    Then Data shuttle order should be created
    Then I get the data shuttle seed id for newly created partner company name
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I set the data shuttle seed status:
      | status |
      | seeding |
    Then I navigate to Search / List Machines section from bus admin console page
    Then I view machine details for the newly created device name
    Then the data shuttle machine details should be:
      | Order ID      | Data Shuttle Device ID | Phase   |
      | <%=@seed_id%> | <%=@seed_id%>          | Seeding |
    And I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.119234 @bus @data_shuttle @regression @core_function
  Scenario: 119234 order a data shuttle for DPS partner when drive type is 2TB
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | sales channel |
      | 12     | 2         | Velocity      |
    Then Sub-total before taxes or discounts should be $0.00
    And Order summary table should be:
      | Description             | Quantity | Price Each | Total Price |
      | TB - MozyEnterprise DPS | 2        | $0.00      | $0.00       |
      | Total Charges           |          |            | $0.00       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 20            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 20    | 3.5" 2TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 1.8 TB | 1        | $275.00 |
      | Total Price         |          | $275.00 |
    Then The number of win drivers should be 1
    Then Data shuttle order should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $275.00 | $275.00    | $0.00       |
      | today | $0.00   | $0.00      | $0.00       |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name

  @TC.119235 @bus @data_shuttle @regression @core_function
  Scenario: 119235 order a data shuttle for DPS partner when driver type is 1TB
    When I add a new MozyEnterprise DPS partner:
      | period | base plan | sales channel |
      | 12     | 10        | Velocity      |
    Then Sub-total before taxes or discounts should be $0.00
    And Order summary table should be:
      | Description             | Quantity | Price Each | Total Price |
      | TB - MozyEnterprise DPS | 10       | $0.00      | $0.00       |
      | Total Charges           |          |            | $0.00       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 8000          | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota | drive type     |
      | Data Shuttle US | available | 2000  | 2.5" 1TB Drive |
    And Data shuttle order summary should be:
      | Description         | Quantity | Total   |
      | Data Shuttle 3.6 TB | 1        | $375.00 |
      | Total Price         |          | $375.00 |
    Then The number of win drivers should be 3
    Then Data shuttle order should be created
    When I navigate to Search / List Partners section from bus admin console page
    And I view partner details by newly created partner company name
    And I act as newly created partner account
    And I navigate to Billing History section from bus admin console page
    Then Billing history table should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $375.00 | $375.00    | $0.00       |
      | today | $0.00   | $0.00      | $0.00       |
    Then I stop masquerading
    And I search and delete partner account by newly created partner company name


  @TC.119990 @bus @data_shuttle @regression @core_function
  Scenario: 119990 Order Data Shuttle for Invoiced Customer
    When I add a new MozyEnterprise partner:
      | period | users | net terms |
      | 12     | 2     | yes       |
    Then New partner should be created
    When I get the partner_id
    And I act as newly created partner account
    And I add new user(s):
      | user_group           | storage_type | storage_limit | devices |
      | (default user group) | Desktop      | 10            | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    And I order data shuttle for newly created partner company name
      | power adapter   | key from  |
      | Data Shuttle US | available |
    Then order data shuttle notification should be:
    """
    This account will be billed for this Data Shuttle order when you click "Finish". If this order is intended to be free of charge, please type "100" in the Discount field then click somewhere outside the field to update the order total.
    """
    And I search and delete partner account by newly created partner company name


  @TC.120693 @bus @data_shuttle @Bug.116986 @need_test_account @regression @core_function
  Scenario: 120693 Verify shipped drive has inbound number
#    When I search order in view data shuttle orders section by Jabberstorm Company 0311-1822-21
#    Then order search results in data shuttle orders section should be:
#      | # of Drives | Drives Ordered |
#      | 1           | Yes            |
#    Then the data shuttle order details should contain valid inbound number
    When I add a new MozyPro partner:
      | period | base plan | server plan | country | create under   | net terms |
      | 1      | 250 GB    | yes         | France  | MozyPro France | yes       |
    And New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | storage_type  | storage_limit | devices |
      | Desktop       | 250           | 1       |
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I fill in data shuttle for newly created partner company name
      | power adapter     | key from  | quota |
      | Data Shuttle EMEA | available | 250  |
    And I refresh process data shuttle section
    When I click finish button
    Then Data shuttle order should be created
    And I wait for 200 seconds
    When I view data shuttle order details
    Then the shipping tracking table of data shuttle order should be
      | Drive # | Status |
      | 1       | Burned |
    And I search and delete partner account by newly created partner company name

  @bus @TC.12342 @resources @tasks_p2 @ROR_smoke
  Scenario: 12342 data_shuttle_ordered_active: (Data Shuttle ordered for activated machine phase III - to user)
    And I add a new Reseller partner:
      | company name    | period | reseller type | reseller quota | server plan | net terms |
      | tc12342 partner | 1      | Silver        | 50             | yes         | yes       |
    Then New partner should be created
    And I get the partner_id
    And I act as newly created partner
    And I add new user(s):
      | user_group           | storage_type | devices |
      | (default user group) | Desktop      | 1       |
    Then 1 new user should be created
    And I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for newly created partner company name
      | power adapter   | key from  | quota |
      | Data Shuttle US | available | 10    |
    Then Data shuttle order should be created
    When I search emails by keywords:
      | subject                                                          | to                          |
      | Your Key @license_key for MozyPro Now Activated for Data Shuttle | <%=@new_users.first.email%> |
    Then I should see 1 email(s)
    And I search and delete partner account by newly created partner company name

  @bus @TC.16208 @resources @tasks_p3
  Scenario: Test Case Mozy-16208: BUS US -- Order Data Shuttle for MozyEnterprise
    When I add a new MozyEnterprise partner:
      |company name                                          | period | users | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      |Internal Mozy - MozyEnterprise Test Data Shuttle 16208| 12     | 100   | 20PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | user with machine | (default user group) | Desktop      | 20            | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading
    When I order data shuttle for Internal Mozy - MozyEnterprise Test Data Shuttle 16208
      | power adapter   | key from  | quota  |
      | Data Shuttle US | available | 20     |
    Then Data shuttle order should be created

  @bus @TC.12480 @resources @tasks_p3
  Scenario: Test Case Mozy-12480:Turn On Data Seeding on Partner
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then New partner should be created
    And I act as newly created partner account
    Then Navigation item Order Data Shuttle should be unavailable
    When I navigate to bus admin console login page
    And I log in bus admin console with user name qa1+automation+nosuperadmin@mozy.com and password Test1234
    Then Navigation item Order Data Shuttle should be unavailable


  @bus @TC.126313 @resources @tasks_p3
  Scenario: Test Case Mozy-126313:Linux Data shuttle can be created successfully
    When I check that linux client service is available
    And I upload change linux client env script to remote machine
    When I add a new MozyPro partner:
      |company name                                    | period | base plan | server plan |
      |Internal Mozy - MozyPro Test Data Shuttle 126313| 1      | 250 GB    | yes         |
    And New partner should be created
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    And I act as newly created partner
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | tc_126313_01_user | (default user group) | Server       | 100           | 3       |
    Then 1 new user should be created
    When I search user by:
      | keywords   |
      | @user_name |
    And I view user details by newly created user email
    And I update the user password to default password
    And I activate linux machine using username newly created user email and password default password
    Then linux machine activation message should be AUTHENTICATED
    Then I stop masquerading
    When I order data shuttle for Internal Mozy - MozyPro Test Data Shuttle 126313
      | name            | address 1     | city         | state | zip    | country         | phone        | power adapter    | key from  | quota | os  |
      | tc.126313_order | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US  | available | 1     |Linux|
    Then Data shuttle order should be created

  @bus @TC.126314 @resources @tasks_p3
  Scenario: Test Case Mozy-126314:Linux Data shuttle status is correct - Precondition:@TC.126313
    And I search order in view data shuttle orders section by Internal Mozy - MozyPro Test Data Shuttle 126313
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name                                | # of Drives | Drives Ordered |
      | Internal Mozy - MozyPro Test Data Shuttle 126313| 1           | Yes            |
    And I view data shuttle order details
    Then data shuttle order info should be
      | Partner                                          | Name              | Address                                         | Phone      | Target Data Center         |
      | Internal Mozy - MozyPro Test Data Shuttle 126313 | tc.126313_order   | 151 S Morgan,Shelbyville,IL,62565,United States | 3127584030 | <%=QA_ENV['data_center']%> |

  @bus @TC.12381 @resources @tasks_p3
  Scenario: Test Case Mozy-12381:Verify Filtering (All Field Options)
    When I add a new MozyPro partner:
      |company name                                    | period | base plan | server plan |
      |Internal Mozy - MozyPro Test Data Shuttle 12381 | 1      | 250 GB    | yes         |
    Then New partner should be created
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | TC.12381_user_01  | (default user group) | Desktop      | 20            | 2       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I add a new Bundled user group:
      | name            | storage_type |server_support|enable_stash|
      | TC.12381-Shared | Shared       | yes          |  yes       |
    Then TC.12381-Shared user group should be created
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | TC.12381_user_02  | TC.12381-Shared      | Server       | 20            | 2       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I navigate to process data shuttle order section for Internal Mozy - MozyPro Test Data Shuttle 12381
    When I fill in shipping address table and proceed to next section
      |  power adapter   |
      |  Data Shuttle US |
    Then The size of available key search results in order data shuttle section should be 2
    And Verify all the options in create order tab
      | user group          |license type|
      | (default user group)|Desktop     |
    Then The size of available key search results in order data shuttle section should be 1
    And Verify all the options in create order tab
      | user group          |license type|
      | TC.12381-Shared     |Server      |
    Then The size of available key search results in order data shuttle section should be 1
    And Verify all the options in create order tab
      | user group          |license type|
      | TC.12381-Shared     |Desktop     |
    Then The size of available key search results in order data shuttle section should be 0
    And I clear all the field options
    Then The size of available key search results in order data shuttle section should be 2

  @bus @TC.12382 @resources @tasks_p3
  Scenario: Test Case Mozy-12382:Adding Keys (Server, Desktop, Grandfathered)
    When I add a new MozyPro partner:
      |company name                                    | period | base plan | server plan |
      |Internal Mozy - MozyPro Test Data Shuttle 12382 | 1      | 250 GB    | yes         |
    Then New partner should be created
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | TC.12382_user_01  | (default user group) | Desktop      | 20            | 2       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    And I add a new Bundled user group:
      | name            | storage_type |server_support|enable_stash|
      | TC.12382-Shared | Shared       | yes          |  yes       |
    Then TC.12382-Shared user group should be created
    And I add new user(s):
      | name              | user_group           | storage_type | storage_limit | devices |
      | TC.12382_user_02  | TC.12382-Shared      | Server       | 20            | 2       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Server device without a key and with the default password
    Then I stop masquerading
    When I navigate to process data shuttle order section for Internal Mozy - MozyPro Test Data Shuttle 12382
    When I fill in shipping address table and proceed to next section
      |  power adapter   |
      |  Data Shuttle US |
    Then The size of available key search results in order data shuttle section should be 2
    And Verify all the options in create order tab
      | user group          |license type|
      | (default user group)|Desktop     |
    Then The size of available key search results in order data shuttle section should be 1
    And I add available key to order key table
    And I clear all the field options
    Then The size of available key search results in order data shuttle section should be 1
    And I remove available key from order key table
    Then The size of available key search results in order data shuttle section should be 2
    And Verify all the options in create order tab
      | user group          |license type|
      | TC.12382-Shared     |Server      |
    Then The size of available key search results in order data shuttle section should be 1
    And I add available key to order key table
    And I clear all the field options
    Then The size of available key search results in order data shuttle section should be 1
    And I remove available key from order key table
    Then The size of available key search results in order data shuttle section should be 2

  @bus @TC.130971 @resources @tasks_p3
  Scenario: Test Case Mozy-130971:Order a data shuttle order for a subpartner
    When I add a new MozyPro partner:
      | company name      | period | base plan| server plan | storage add on |
      | TC.130971_partner | 12     | 1 TB     | yes         | 10             |
    Then New partner should be created
    And I view the newly created partner admin details
    And I active admin in admin details default password
    And I change root role to FedID role
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent     |
      | newrole | Partner admin | FedID role |
    And I check all the capabilities for the new role
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.130971_sub_partner |
    Then New partner should be created
    And I act as newly created subpartner account
    And I navigate to Purchase Resources section from bus admin console page
    And I purchase resources:
      | generic quota |
      | 20            |
    And I add new user(s):
      | name               | user_group           | storage_type | storage_limit | devices |
      | TC.130971_user_01  | (default user group) | Desktop      | 20            | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading as sub partner
    Then I stop masquerading
    When I order data shuttle for TC.130971_sub_partner
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  |quota  |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available |20     |
    Then Data shuttle order should be created

  @bus @TC.130978 @resources @tasks_p3
  Scenario: Test Case Mozy-130978:Cancel data shuttle order for Reseller subpartner
    When I add a new Reseller partner:
      | company name      | period | reseller type | reseller quota | net terms |
      | TC.130978_partner | 12     | Gold          | 500            | yes       |
    Then New partner should be created
    When I act as newly created partner account
    And I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          | Parent        |
      | subrole | Partner admin | Reseller Root |
    And I check all the capabilities for the new role
#    And I act as partner by:
#    |email|
#    | mozyautotest+virginia+smith+1631@emc.com    |
    And I navigate to Add New Pro Plan section from bus admin console page
    And I add a new pro plan for Reseller partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | subrole   | Yes     | No     |          | yearly  | test     | false            | 1                          | 1                     |
    Then add new pro plan success message should be displayed
    When I add a new sub partner:
      | Company Name          |
      | TC.130978_sub_partner |
    Then New partner should be created
    And I act as newly created subpartner account
    And I purchase resources:
      | generic quota   |
      | 30              |
    Then Resources should be purchased
    And I add new user(s):
      | name               | user_group           | storage_type | storage_limit | devices |
      | TC.130978_user_01  | (default user group) | Desktop      | 20            | 1       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And activate the user's Desktop device without a key and with the default password
    Then I stop masquerading as sub partner
    Then I stop masquerading
    When I order data shuttle for TC.130978_sub_partner
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from  |quota  |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | available |20     |
    Then Data shuttle order should be created
    When I cancel the latest data shuttle order for TC.130978_sub_partner
    Then The order should be Cancelled


  @bus @TC.22001 @resources @tasks_p3
  Scenario: Test Case Mozy-22001:Enable Data Shuttle for OEM
    When I add a new OEM partner:
      |Company Name            | Root role      | Company Type     |
      |TC.22001_fordatashuttle | OEM Root Trial | Service Provider |
    Then New partner should be created
    And I act as newly created partner account
    And I purchase resources:
      | desktop license| desktop quota | server license | server quota |
      | 2              | 2             | 2              |  2           |
    Then Resources should be purchased
    And I add new itemized user(s):
      | name           | devices_server | quota_server | devices_desktop | quota_desktop |
      | oem_user_22001 | 1              | 1            | 1               | 1             |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I activate the new user's 1 Desktop device(s) and update used quota to 4096 GB
    And I activate the new user's 1 Server device(s) and update used quota to 4096 GB
    Then I stop masquerading from subpartner
    Then I stop masquerading from subpartner
    Then I stop masquerading
    When I order data shuttle for TC.22001_fordatashuttle
      | address 1     | city         | state | zip    | country         | phone        | power adapter   | key from    |
      | 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US | 2 available |
    Then Data shuttle order should be created
    And I search order in view data shuttle orders section by TC.22001_fordatashuttle
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name       | # of Drives | Drives Ordered |
      | TC.22001_fordatashuttle| 0           | Yes            |

  @bus @TC.13793 @resources @tasks_p3
  Scenario: Test Case Mozy-13793:Purchase quota for multiple keys of different license type and different user group with data shuttl
    When I add a new MozyPro partner:
      | company name            | period | base plan | coupon                | net terms | server plan | root role               |
      | TC.13793_fordatashuttle | 24     | 50 GB     | <%=QA_ENV['coupon']%> | yes       | yes         | Bundle Pro Partner Root |
    Then New partner should be created
    And I change root role to FedID role
    When I act as newly created partner account
    And I add new user(s):
      | name            | user_group           | storage_type | storage_limit | devices |
      | oem_user1_13793 | (default user group) | Desktop      | 15            | 3       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I activate the new user's 3 Desktop device(s) and update used quota to 5 GB
    And I add a new Bundled user group:
      | name            | storage_type |server_support|enable_stash|
      | TC.13793-Shared | Shared       | yes          |  yes       |
    Then TC.13793-Shared user group should be created
    And I add new user(s):
      | name             | user_group           | storage_type | storage_limit | devices |
      | oem_user2_13793  | TC.13793-Shared      | Server       | 15            | 3       |
    When I navigate to Search / List Users section from bus admin console page
    And I view user details by newly created user email
    And I update the user password to default password
    And I activate the new user's 3 Server device(s) and update used quota to 5 GB
    Then I stop masquerading
    When I navigate to process data shuttle order section for TC.13793_fordatashuttle
    When I fill in shipping address table and proceed to next section
      |name          | address 1     | city         | state | zip    | country         | phone        | power adapter   |
      |tc.13793_order| 151 S Morgan  | Shelbyville  | IL    | 62565  | United States   | 3127584030   | Data Shuttle US |
    And I add 6 available Licenses
    Then The size of available key search results in order data shuttle section should be 0
    And I proceed to next section from Create order section
    Then Data shuttle order summary should be:
      | Description         | Quantity | Total    |
      | Data Shuttle 1.8 TB | 6        | $1,650.00|
      | Total Price         |          | $1,650.00|
    When I click finish button
    Then Data shuttle order should be created
    And I search order in view data shuttle orders section by TC.13793_fordatashuttle
    Then order search results in data shuttle orders section should be:
      | Pro Partner Name       | # of Drives | Drives Ordered |
      | TC.13793_fordatashuttle| 1           | Yes            |
    And I view data shuttle order details
    Then data shuttle order info should be
      | Partner                 | Name             | Address      | Phone      | Target Data Center         |
      | TC.13793_fordatashuttle | tc.13793_order   | 151 S Morgan | 3127584030 | <%=QA_ENV['data_center']%> |
    And I search and delete partner account by TC.13793_fordatashuttle


