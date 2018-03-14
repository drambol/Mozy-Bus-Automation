Feature: Add a new Reseller partner

  As a Mozy Administrator
  I want to create Reseller partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.18143 @bus @2.5 @add_new_partner @reseller @env_dependent @regression @core_function
  Scenario: 18143 Add New Reseller Partner - US - Monthly - Silver 500 GB - Server Plan - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | Silver        | 500            | yes         | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $190.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | $0.33      | $165.00     |
      | Server Plan          | 1        | $25.00     | $25.00      |
      | Discounts Applied    |          |            | -$19.00     |
      | Pre-tax Subtotal     |          |            | $171.00     |
      | Total Charges        |          |            | $171.00     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro    | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | $171.00 | $171.00    | $0.00       |
    And I delete partner account

  @TC.18146 @bus @2.5 @add_new_partner @reseller @env_dependent @vat @regression @core_function
  Scenario: 18146 Add New Reseller Partner - FR - Yearly - Gold 500 GB - Server Plan - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under   | vat number    | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 12     | Gold          | 500            | yes         | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €2,460.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | €3.00      | €1,500.00   |
      | Server Plan        | 1        | €960.00    | €960.00     |
      | Discounts Applied  |          |            | -€246.00    |
      | Pre-tax Subtotal   |          |            | €2,214.00   |
      | Total Charges      |          |            | €2,214.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro France (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                 | VAT Number:   |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 |           |                 | <%=@partner.admin_info.email%> | FR08410091490 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €2,214.00 | €2,214.00  | €0.00       |
    And I delete partner account

  @TC.18149 @bus @2.5 @add_new_partner @reseller @env_dependent @vat @regression @core_function
  Scenario: 18149 Add New Reseller Partner - DE - Monthly - Platinum 500 GB - Server Plan - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | create under    | vat number  | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 1      | Platinum      | 500            | yes         | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4188181111111112 |
    Then Sub-total before taxes or discounts should be €250.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | €0.22      | €110.00     |
      | Server Plan            | 1        | €140.00    | €140.00     |
      | Discounts Applied      |          |            | -€25.00     |
      | Pre-tax Subtotal       |          |            | €225.00     |
      | Total Charges          |          |            | €225.00     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Germany (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 |           |                 | <%=@partner.admin_info.email%> | DE812321109 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | €0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €225.00 | €225.00    | €0.00       |
    And I delete partner account

  @TC.18152 @bus @2.5 @add_new_partner @reseller @env_dependent @vat @regression @core_function
  Scenario: 18152 Add New Reseller Partner - IE - Yearly - Silver 500 GB - Server Plan - 10 Add on - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under    | vat number | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 12     | Silver        | 500            | yes         | 10             | MozyPro Ireland | IE9691104A | 10PERCENTOFFOUTLINE | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €2,760.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €3.60      | €1,800.00   |
      | Server Plan          | 1        | €240.00    | €240.00     |
      | 20 GB add-on         | 10       | €72.00     | €720.00     |
      | Discounts Applied    |          |            | -€276.00    |
      | Pre-tax Subtotal     |          |            | €2,484.00   |
      | Taxes                |          |            | €571.32     |
      | Total Charges        |          |            | €3,055.32   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Ireland (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> | IE9691104A  |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €3,055.32 | €3,055.32  | €0.00       |
    And I delete partner account

  @TC.18153 @bus @2.5 @add_new_partner @reseller @env_dependent @vat @regression @core_function
  Scenario: 18153 Add New Reseller Partner - UK - Monthly - Gold 500 GB - Server Plan -  10 Add on - VAT - Coupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | storage add on | create under | vat number  | coupon              | country        | address           | city      | state | zip   | phone          | cc number        |
      | 1      | Gold          | 500            | yes         | 10             | MozyPro UK   | GB117223643 | 10PERCENTOFFOUTLINE | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £191.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | £0.18      | £90.00     |
      | Server Plan        | 1        | £65.00     | £65.00      |
      | 20 GB add-on       | 10       | £3.60      | £36.00      |
      | Discounts Applied  |          |            | -£19.10     |
      | Pre-tax Subtotal   |          |            | £171.90     |
      | Total Charges      |          |            | £171.90     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:              | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro UK (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> | GB117223643 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | £0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | £171.90 | £171.90    | £0.00       |
    And I delete partner account

  @TC.18155 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 18155 Add New Reseller Partner - US - Yearly - Platinum 500 GB - 10 Add on - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 12     | Platinum      | 500            | 10             | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $2,016.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | $2.88      | $1,440.00   |
      | 20 GB add-on           | 10       | $57.60     | $576.00     |
      | Pre-tax Subtotal       |          |            | $2,016.00   |
      | Total Charges          |          |            | $2,016.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | $2,016.00             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | $2,016.00 | $0.00      | $2,016.00   |
    And I delete partner account

  @TC.17970  @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 17970 Add New Reseller Partner - FR - Monthly - Silver 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | create under   | net terms | country | address           | city      | state | zip   | phone          |
      | 1      | Silver        | 500            | MozyPro France | yes       | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €150.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | €0.30      | €150.00     |
      | Pre-tax Subtotal     |          |            | €150.00     |
      | Taxes                |          |            | €30.00      |
      | Total Charges        |          |            | €180.00     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro France (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | €180.00                | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
  And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €180.00 | €0.00      | €180.00     |
    And I delete partner account

  @TC.17971 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 17971 Add New Reseller Partner - DE - Yearly - Gold 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | create under    | country | address           | city      | state | zip   | phone          |
      | 12     | Gold          | 500            | yes       | MozyPro Germany | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €1,500.00
    And Order summary table should be:
      | Description        | Quantity | Price Each | Total Price |
      | GB - Gold Reseller | 500      | €3.00      | €1,500.00   |
      | Pre-tax Subtotal   |          |            | €1,500.00   |
      | Taxes              |          |            | €285.00     |
      | Total Charges      |          |            | €1,785.00   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Germany (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | €1,785.00             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | €1,785.00 | €0.00      | €1,785.00   |
    And I delete partner account

  @TC.17972 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 17972 Add New Reseller Partner - IE - Monthly - Platinum 500 GB - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | net terms | create under    | country | address           | city      | state | zip   | phone          |
      | 1      | Platinum      | 500            | yes       | MozyPro Ireland | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €110.00
    And Order summary table should be:
      | Description            | Quantity | Price Each | Total Price |
      | GB - Platinum Reseller | 500      | €0.22      | €110.00     |
      | Pre-tax Subtotal       |          |            | €110.00     |
      | Taxes                  |          |            | €25.30      |
      | Total Charges          |          |            | €135.30     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:                    | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro Ireland (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 500       | 500      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | €135.30                | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €135.30 | €0.00      | €135.30     |
    And I delete partner account

  @TC.17973 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 17973 Add New Reseller Partner - UK - Yearly - Silver 500 GB - 10 Add on - Net Terms
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | storage add on | create under | net terms | country        | address           | city      | state | zip   | phone          |
      | 12     | Silver        | 500            | 10             | MozyPro UK   | yes       | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £1,848.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | £2.64      | £1,320.00   |
      | 20 GB add-on         | 10       | £52.80     | £528.00     |
      | Pre-tax Subtotal     |          |            | £1,848.00   |
      | Taxes                |          |            | £369.60     |
      | Total Charges        |          |            | £2,217.60   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:               | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro UK (MozyPro)  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 700       | 700      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | £2,217.60             | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £2,217.60 | £0.00      | £2,217.60   |
    And I delete partner account

  @TC.17974 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 17974 Add New Reseller Partner US Without Initial Purchases
    When I add a new Reseller partner:
      | period | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:             | Parent:  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | Reseller Root (change) | MozyPro  | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | Reseller      | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 0         | 0        | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Other/None             | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

  @TC.18722 @bus @2.5 @add_new_partner @reseller @regression @core_function
  Scenario: 18722 Verify Reseller partner has 2 period options
    When I navigate to Add New Partner section from bus admin console page
    Then Reseller partner subscription period options should be:
      | Monthly | Yearly |

  @TC.20379 @bus @2.5 @add_new_partner @reseller @env_dependent @regression @core_function
  Scenario: 20379 Add New Reseller Partner - US - Monthly - Silver 500 GB - Server Plan - 100PercentDiscountCoupon - CC
    When I add a new Reseller partner:
      | period | reseller type | reseller quota | server plan | coupon               |
      | 1      | Silver        | 500            | yes         | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $190.00
    And Order summary table should be:
      | Description          | Quantity | Price Each | Total Price |
      | GB - Silver Reseller | 500      | $0.33      | $165.00     |
      | Server Plan          | 1        | $25.00     | $25.00      |
      | Discounts Applied    |          |            | -$190.00    |
      | Total Charges        |          |            | $0.00       |
    And New partner should be created
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account



#  @STT_vmbu  @STT_vmbu_reseller
#  Scenario:  Add New Reseller Partner - UK - Monthly - Gold 5000 GB - Server Plan -  100 Add on - VAT - Coupon - CC
#
#    When I add a new Reseller partner:
#      | period | reseller type | reseller quota | server plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
#      | 1      | Silver        | 5000            | yes         | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
#    And I change root role to Fedid
#    And I enabled server in partner account details
#    And I act as newly created partner
#    When I create a new client config:
#      | name    | type   |
#      | default | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | private_group | Shared      | yes          | yes            |
#    Then private_group user group should be created
#    When I create a new client config:
#      | name | user group | type   |
#      | private | private_group | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | ckey_group | Shared      | yes          | yes            |
#    Then ckey_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | ckey                         |
#      | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#    Then client configuration section message should be Your configuratiowas saved.
#
#  ##create users
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | default_desktop | (default user group) | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | ckey_desktop    | ckey_group           | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | default_server1 | (default user group) | Server       |               | 2       |
#      | default_server2 | (default user group) | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | private_server1 | private_group        | Server       |               | 2       |
#      | private_server2 | private_group        | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | ckey_server1    | ckey_group           | Server       |               | 2       |
#      | ckey_server2    | ckey_group           | Server       |               | 2       |
#    Then 2 new user should be created
#
#    When I navigate to Add New Role section from bus admin console page
#    And I add a new role:
#      | Name    | Type          |
#      | newrole | Partner admin |
#    And I check all the capabilities for the new role
#    And I close the role details section
#    When I navigate to Add New Pro Plan section from bus admin console page
#    Then I add a new pro plan for MozyEnterprise partner:
#      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
#      | newplan | reseller     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
#    And I add a new sub partner:
#      | Company Name |
#      | STT_subreseller    |
#    And New partner should be created
#    And I act as newly created partner
#    And I purchase resources:
#      | generic quota |
#      | 22000           |
#    Then Resources should be purchased
#
#    When I create a new client config:
#      | name    | type   |
#      | default | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | private_group | Shared      | yes          | yes            |
#    Then private_group user group should be created
#    When I create a new client config:
#      | name | user group | type   |
#      | private | private_group | Server |
#    When I add a new Bundled user group:
#      | name| storage_type | enable_stash | server_support |
#      | ckey_group | Shared      | yes          | yes            |
#    Then ckey_group user group should be created
#    When I create a new client config:
#      | name | user group | type   | ckey                         |
#      | ckey | ckey_group | Server | http://burgifam.com/Rich.ckey|
#    Then client configuration section message should be Your configuration was saved.
#  ##create users
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | default_desktop | (default user group) | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices | enable_stash |
#      | ckey_desktop    | ckey_group           | Desktop      |               | 2       | yes          |
#    Then 1 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | default_server1 | (default user group) | Server       |               | 2       |
#      | default_server2 | (default user group) | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | private_server1 | private_group        | Server       |               | 2       |
#      | private_server2 | private_group        | Server       |               | 2       |
#    Then 2 new user should be created
#    When I add new user(s):
#      | name            | user_group           | storage_type | storage_limit | devices |
#      | ckey_server1    | ckey_group           | Server       |               | 2       |
#      | ckey_server2    | ckey_group           | Server       |               | 2       |
#    Then 2 new user should be created
