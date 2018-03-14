Feature: Add a new partner through phoenix

As a business owner
I want to create a partner through phoenix
So that I can organize my business in a way that works for me

Background:
#---------------------------------------------------------------------------------
# base coverage section:
#   represents a balanced set of coverage
#----------------------------------------test matrix------------------------------
#	partner size:	10        | 50          | 100    | 250      | 500      | 1tb
#	monthly:		ie,sv,cp  | ie          | uk     | fr,sv    | de,sv,hp | us
#	yearly:			uk,sv     | de,sv,nv,cp | us,sv  | ie,nv,hp | fr       | fr,cp
#	biannual:		us,hp     | fr,nv       | de,nv  | de       | uk,nv    | ie,sv
#----------------------------------------test legend------------------------------
#		entries by: country,server/dsk,novat,coupon,hipaa
#
#		key: sv=server, nv=novat, cp=coupon, hp=hipaa
#		coupon code = 10PERCENTOFFOUTLINE
#
#     base smoke test = us yearly, 100gb, server
#---------------------------------------------------------------------------------

  @TC.20965  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20965 Add a new US yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country       |
    | 1      | 1 TB      | United States |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            | -1       |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card   | Current Period: | Monthly            |
    | Unpaid Balance: | $0.00         | Collect On:     | N/A                |
    | Renewal Date:   | after 1 month | Renewal Period: | Use Current Period |
    | Next Charge:    | after 1 month |                 |                    |
    And I delete partner account

  @TC.20966  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20966 Add a new US biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country       | security |
    | 24     | 10 GB     | United States | HIPAA    |
    Then the order summary looks like:
    | Description      | Price   | Quantity | Amount  |
    | 10 GB - Biennial | $209.79 | 1        | $209.79 |
    | Total Charge     | $209.79 |          | $209.79 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                  | Users: | Contact Address:                    | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state_abbrev%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | $0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20967  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20967 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number | cc number        |
    | 1      | 50 GB     | Ireland | IE9691104A | 4319402211111113 |
    Then the order summary looks like:
    | Description        | Price  | Quantity | Amount |
    | 50 GB - Monthly    | €15.99 | 1        | €15.99 |
    | Subscription Price | €15.99 |          | €15.99 |
    | VAT                | €3.68  |          | €3.68  |
    | Total Charge       | €19.67 |          | €19.67 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20968  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20968 Add a new IE yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number | security | cc number        |
    | 12     | 250 GB    | Ireland |            |   HIPAA  | 4319402211111113 |
    Then the order summary looks like:
    | Description        | Price     | Quantity | Amount    |
    | 250 GB - Annual    | €663.89   | 1        | €663.89   |
    | Subscription Price | €663.89   |          | €663.89   |
    | VAT                | €152.69   |          | €152.69   |
    | Total Charge       | €816.58   |          | €816.58   |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20969  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20969 Add a new IE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number | server plan | cc number        |
    | 24     | 1 TB      | Ireland | IE9691104A | yes         | 4319402211111113 |
    Then the order summary looks like:
    | Description            | Price     | Quantity | Amount    |
    | 1 TB - Biennial        | €5,072.79 | 1        | €5,072.79 |
    | Server Plan - Biennial | €405.79   | 1        | €405.79   |
    | Subscription Price     | €5,478.58 |          | €5,478.58 |
    | VAT                    | €1,260.07 |          | €1,260.07 |
    | Total Charge           | €6,738.65 |          | €6,738.65 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20970  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20970 Add a new UK monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  | cc number        |
    | 1      | 100 GB    | United Kingdom | GB117223643 | 4916783606275713 |
    Then the order summary looks like:
    | Description            | Price  | Quantity | Amount |
    | 100 GB - Monthly       | £26.99 | 1        | £26.99 |
    | VAT                    | Exempt |          | Exempt |
    | Total Charge           | £26.99 |          | £26.99 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | £0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20971  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20971 Add a new UK yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  | server plan | cc number        |
    | 12     | 10 GB     | United Kingdom | GB117223643 | yes         | 4916783606275713 |
    Then the order summary looks like:
    | Description          | Price   | Quantity | Amount  |
    | 10 GB - Annual       | £76.89  | 1        | £76.89  |
    | Server Plan - Annual | £32.89  | 1        | £32.89  |
    | VAT                  | Exempt  |          | Exempt  |
    | Total Charge         | £109.78 |          | £109.78 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | £0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20972  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20972 Add a new UK biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country        | vat number  | cc number        |
    | 24     | 500 GB    | United Kingdom |             | 4916783606275713 |
    Then the order summary looks like:
    | Description            | Price     | Quantity | Amount    |
    | 500 GB - Biennial      | £1,823.79 | 1        | £1,823.79 |
    | Subscription Price     | £1,823.79 |          | £1,823.79 |
    | VAT                    | £364.76   |          | £364.76   |
    | Total Charge           | £2,188.55 |          | £2,188.55 |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | £0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20973  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20973 Add a new DE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  | server plan | security | cc number        |
    | 1      | 500 GB    | Germany | DE812321109 | yes         |   HIPAA  | 4188181111111112 |
    Then the order summary looks like:
    | Beschreibung           | Preis   | Menge  | Betrag  |
    | 500 GB - Monatlich     | 149,99€ | 1      | 149,99€ |
    | Serverplan - Monatlich | 15,99€  | 1      | 15,99€  |
    | Umsatzsteuer           | Befreit |        | Befreit |
    | Gesamtbelastung        | 165,98€ |        | 165,98€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                   | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20974  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20974 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  | cc number        |
    | 24     | 100 GB    | Germany |             | 4188181111111112 |
    Then the order summary looks like:
    | Beschreibung           | Preis   | Menge  | Betrag  |
    | 100 GB - 2-Jahre       | 650,79€ | 1      | 650,79€ |
    | Abonnementpreis        | 650,79€ |        | 650,79€ |
    | Umsatzsteuer           | 123,65€ |        | 123,65€ |
    | Gesamtbelastung        | 774,44€ |        | 774,44€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:           |    -1    |
    | Default Sync Storage: |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 100       | 100      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20975  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20975 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number  | cc number        |
    | 24     | 250 GB    | Germany | DE812321109 | 4188181111111112 |
    Then the order summary looks like:
    | Beschreibung           | Preis     | Menge  | Betrag    |
    | 250 GB - 2-Jahre       | 1.272,79€ | 1      | 1.272,79€ |
    | Umsatzsteuer           | Befreit   |        | Befreit   |
    | Gesamtbelastung        | 1.272,79€ |        | 1.272,79€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

  @TC.20976  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20976 Add a new FR monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number    | server plan | cc number        |
    | 1      | 250 Go    | France  | FR08410091490 | yes         | 4485393141463880 |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 250 Go - Mensuel        | 74,99€    | 1         | 74,99€    |
    | Plan serveur - Mensuel  | 12,99€    | 1         | 12,99€    |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 87,98€    |           | 87,98€    |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20977  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20977 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number    | cc number        |
    | 12     | 500 Go    | France  | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 500 Go - Annuel         | 1 327,89€ | 1         | 1 327,89€ |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 1 327,89€ |           | 1 327,89€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20978  @2.9 @regression_test @phoenix @mozypro
  Scenario: 20978 Add a new FR biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | country | vat number | cc number        |
    | 24     |  50 Go    | France  |            | 4485393141463880 |
    Then the order summary looks like:
    | Description              | Prix    | Quantité | Montant |
    | 50 Go - Bisannuel        | 335,79€ | 1        | 335,79€ |
    | Prix d'abonnement        | 335,79€ |          | 335,79€ |
    | TVA                      | 67,16€  |          | 67,16€  |
    | Montant total des frais  | 402,95€ |          | 402,95€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Biennial            |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 2 years          |                 |                     |
    And I delete partner account

#---------------------------------------------------------------------------------
# coupons : new section
#---------------------------------------------------------------------------------
  @TC.20979  @2.9 @regression_test @phoenix @mozypro @env_dependent
  Scenario: 20979 Add a new IE monthly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number | server plan | cc number        |
    | 1      | 10 GB     | 10PERCENTOFFOUTLINE | Ireland | IE9691104A | yes         | 4319402211111113 |
    Then the order summary looks like:
    | Description           | Price   | Quantity | Amount  |
    | 10 GB - Monthly       | €7.99   | 1        | €7.99   |
    | Server Plan - Monthly | €2.99   | 1        | €2.99   |
    | Subscription Price    | €10.98  |          | €10.98  |
    | Discounts             | - €1.10 |          | - €1.10 |
    | Subtotal              | €9.88   |          | €9.88   |
    | VAT                   | €2.27   |          | €2.27   |
    | Total Charge          | €12.15  |          | €12.15  |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card            | Current Period: | Monthly             |
    | Unpaid Balance: | €0.00                  | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 month          |                 |                     |
    And I delete partner account

  @TC.20980  @2.9 @regression_test @phoenix @mozypro @env_dependent
  Scenario: 20980 Add a new DE biennial basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number  | server plan | cc number        |
    | 12     | 50 GB     | 10PERCENTOFFOUTLINE | Germany |             | yes         | 4188181111111112 |
    Then the order summary looks like:
    | Beschreibung          | Preis    | Menge  | Betrag   |
    | 50 GB - jährlich      | 175,89€  | 1      | 175,89€  |
    | Serverplan - jährlich | 60,39€   | 1      | 60,39€   |
    | Abonnementpreis       | 236,28€  |        | 236,28€  |
    | Rabatte               | - 23,63€ |        | - 23,63€ |
    | Zwischensumme         | 212,65€  |        | 212,65€  |
    | Umsatzsteuer          | 40,41€   |        | 40,41€   |
    | Gesamtbelastung       | 253,06€  |        | 253,06€  |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Enabled  |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

  @TC.20982  @2.9 @regression_test @phoenix @mozypro @env_dependent
  Scenario: 20982 Add a new FR yearly basic MozyPro partner
    When I am at dom selection point:
    And I add a phoenix Pro partner:
    | period | base plan | coupon              | country | vat number    | cc number        |
    | 12     | 1 To      | 10PERCENTOFFOUTLINE | France  | FR08410091490 | 4485393141463880 |
    Then the order summary looks like:
    | Description             | Prix      | Quantité  | Montant   |
    | 1 To - Annuel           | 2 654,89€ | 1         | 2 654,89€ |
    | Prix d'abonnement       | 2 654,89€ |           | 2 654,89€ |
    | Réductions              | - 265,49€ |           | - 265,49€ |
    | TVA                     | Exemption |           | Exemption |
    | Montant total des frais | 2 389,40€ |           | 2 389,40€ |
    And the partner is successfully added.
    And they have logged in and verified their account.
    And I log in bus admin console as administrator
    And I search partner by:
    | name          | filter |
    | @company_name | None   |
    And I view partner details by newly created partner company name
    And Partner general information should be:
    | Status:         | Root Admin:          | Root Role:                  | Parent:                           | Marketing Referrals: | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
    | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | <%=@partner.partner_info.parent%> | (add referral)       | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change)   |
    And Partner contact information should be:
    | Company Type:                   | Users: | Contact Address:                   | Contact City:                   | Contact State:                          | Contact ZIP/Postal Code:       | Contact Country:                   | Phone:                           | Contact Email:                 |
    | <%=@partner.partner_info.type%> | 0      | <%=@partner.company_info.address%> | <%=@partner.company_info.city%> | <%=@partner.company_info.state%> | <%=@partner.company_info.zip%> | <%=@partner.company_info.country%> | <%=@partner.company_info.phone%> | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
    | Backup Devices         |          |
    | Backup Device Soft Cap | Disabled |
    | Server                 | Disabled |
    | Cloud Storage (GB)     |          |
    | Sync Users:            |    -1    |
    | Default Sync Storage:  |          |
    And Partner pooled storage information should be:
    | Used | Available | Assigned | Used | Available | Assigned  |
    | 0    | 1024      | 1024     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
    | Account Type:   | Credit Card           | Current Period: | Yearly              |
    | Unpaid Balance: | €0.00                 | Collect On:     | N/A                 |
    | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period  |
    | Next Charge:    | after 1 year          |                 |                     |
    And I delete partner account

#---------------------------------------------------------------------------------
# extended coverage section:
#   coverage based on changes made to UI, requirements changes, bugs, etc
#---------------------------------------------------------------------------------

#---------------------------------------------------------------------------------
#   Requirement #:  96067
#   Name: Phoenix needs to support the new account type, and sales origin partner details
#   Bug #: 97647
#   Name: Phoenix generated pro acct missing internal values
#---------------------------------------------------------------------------------

  @TC.20985  @2.9 @regression_test @phoenix @mozypro @BUG.97647
  Scenario: 20985 Verification of new internal acct attributes for phoenix generated MozyPro partner
  When I am at dom selection point:
  And I add a phoenix Pro partner:
  | period | base plan | country       |
  | 12     | 250 GB    | United States |
  And the partner is successfully added.
  And I log in bus admin console as administrator
  And I search partner by:
  | name          | filter |
  | @company_name | None   |
  And I view partner details by newly created partner company name
  Then Partner general information should be:
  | Account Type  | Sales Origin  |
  | Live (change) | Web           |
  And I delete partner account
