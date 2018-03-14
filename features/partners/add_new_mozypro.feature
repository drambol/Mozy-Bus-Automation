Feature: Add a new MozyPro partner

  As a Mozy Administrator
  I want to create MozyPro partners
  So that I can organize my business in a way that works for me

  Background:
    Given I log in bus admin console as administrator

  @TC.17942 @create_partner_sample @bus @2.5 @add_new_partner @mozypro @env_dependent @regression @core_function
  Scenario: 17942 Add New MozyPro Partner - US - Monthly - 10 GB - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | coupon              | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | 10 GB     | 10PERCENTOFFOUTLINE | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $9.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 10 GB             | 1        | $9.99      | $9.99       |
      | Discounts Applied |          |            | -$1.00      |
      | Pre-tax Subtotal  |          |            | $8.99       |
      | Total Charges     |          |            | $8.99       |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 10        | 10       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $8.99  | $8.99      | $0.00       |
    And I delete partner account

  @TC.17955 @bus @2.5 @add_new_partner @mozypro @env_dependent @vat @regression @core_function
  Scenario: 17955 Add New MozyPro Partner - FR - Yearly - 50 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under   | vat number    | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 12     | 50 GB     | MozyPro France | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4485393141463880 |
    Then Sub-total before taxes or discounts should be €175.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | €175.89    | €175.89     |
      | Discounts Applied |          |            | -€17.59     |
      | Pre-tax Subtotal  |          |            | €158.30     |
      | Total Charges     |          |            | €158.30     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number:   |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> | FR08410091490 |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 50        | 50       | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | €0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €158.30 | €158.30    | €0.00       |
    And I delete partner account

  @TC.18142 @bus @2.5 @add_new_partner @mozypro @env_dependent @vat @regression @core_function
  Scenario: 18142 Add New MozyPro Partner - DE - Biennially - 100 GB - VAT - Coupon CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number  | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 24     | 100 GB    | MozyPro Germany | DE812321109 | 10PERCENTOFFOUTLINE | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4188181111111112 |
    Then Sub-total before taxes or discounts should be €650.79
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 100 GB            | 1        | €650.79    | €650.79     |
      | Discounts Applied |          |            | -€65.08     |
      | Pre-tax Subtotal  |          |            | €585.71     |
      | Total Charges     |          |            | €585.71     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Germany (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> | DE812321109 |
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
      | Account Type:   | Credit Card            | Current Period: | Biennial           |
      | Unpaid Balance: | €0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €585.71 | €585.71    | €0.00       |
    And I delete partner account

  @TC.18145 @bus @2.5 @add_new_partner @mozypro @env_dependent @vat @regression @core_function
  Scenario: 18145 Add New MozyPro Partner - IE - Monthly - 250 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under    | vat number | coupon              | country | address           | city      | state | zip   | phone          | cc number        |
      | 1      | 250 GB    | MozyPro Ireland | IE9691104A | 10PERCENTOFFOUTLINE | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4319402211111113 |
    Then Sub-total before taxes or discounts should be €74.99
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 250 GB            | 1        | €74.99     | €74.99      |
      | Discounts Applied |          |            | -€7.50      |
      | Pre-tax Subtotal  |          |            | €67.49      |
      | Taxes             |          |            | €15.52      |
      | Total Charges     |          |            | €83.01      |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> | IE9691104A  |
    And Partner account attributes should be:
      | Backup Devices            |          |
      | Backup Device Soft Cap    | Disabled |
      | Server                 | Disabled |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 250       | 250      | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Monthly            |
      | Unpaid Balance: | €0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | €83.01 | €83.01     | €0.00       |
    And I delete partner account

  @TC.18148 @bus @2.5 @add_new_partner @mozypro @env_dependent @vat @regression @core_function
  Scenario: 18148 Add New MozyPro Partner - UK - Yearly - 500 GB - VAT - Coupon - CC
    When I add a new MozyPro partner:
      | period | base plan | create under | vat number  | coupon              | country        | address           | city      | state | zip   | phone          | cc number        |
      | 12     | 500 GB    | MozyPro UK   | GB117223643 | 10PERCENTOFFOUTLINE | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 | 4916783606275713 |
    Then Sub-total before taxes or discounts should be £954.89
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 500 GB            | 1        | £954.89    | £954.89     |
      | Discounts Applied |          |            | -£95.49     |
      | Pre-tax Subtotal  |          |            | £859.40     |
      | Total Charges     |          |            | £859.40     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 | VAT Number: |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> | GB117223643 |
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
      | Account Type:   | Credit Card           | Current Period: | Yearly             |
      | Unpaid Balance: | £0.00                 | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | £859.40 | £859.40    | £0.00       |
    And I delete partner account

  @TC.18151 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18151 Add New MozyPro Partner US - Biennially - 1 TB - Server Plan - 10 Add on - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | net terms | country       | address           | city      | state abbrev | zip   | phone          |
      | 24     | 1 TB      | yes         | 10             | yes       | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be $25,974.48
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 1 TB             | 1        | $5,579.79  | $5,579.79   |
      | Server Plan      | 1        | $446.79    | $446.79     |
      | 250 GB Add-on    | 10       | $1,994.79  | $19,947.90  |
      | Pre-tax Subtotal |          |            | $25,974.48  |
      | Total Charges    |          |            | $25,974.48  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 3524      | 3524     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Biennial           |
      | Unpaid Balance: | $25,974.48             | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $25,974.48 | $0.00      | $25,974.48  |
    And I delete partner account

  @TC.18154 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18154 Add New MozyPro Partner - FR - Monthly - 2 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 1      | 2 TB      | MozyPro France | yes         | yes       | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €609.98
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 2 TB             | 1        | €579.99    | €579.99     |
      | Server Plan      | 1        | €29.99     | €29.99      |
      | Pre-tax Subtotal |          |            | €609.98     |
      | Taxes            |          |            | €122.00     |
      | Total Charges    |          |            | €731.98     |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 2048      | 2048     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | €731.98                | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount  | Total Paid | Balance Due |
      | today | €731.98 | €0.00      | €731.98     |
    And I delete partner account

  @TC.18851 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18851 Add New MozyPro Partner - DE - Yearly - 4 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 12     | 4 TB      | MozyPro Germany | yes         | yes       | Germany | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €10,429.78
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 4 TB             | 1        | €10,081.89 | €10,081.89  |
      | Server Plan      | 1        | €347.89    | €347.89     |
      | Pre-tax Subtotal |          |            | €10,429.78  |
      | Taxes            |          |            | €1,981.66   |
      | Total Charges    |          |            | €12,411.44  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Germany (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Germany          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 4096      | 4096     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30          | Current Period: | Yearly             |
      | Unpaid Balance: | €12,411.44            | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €12,411.44 | €0.00      | €12,411.44  |
    And I delete partner account

  @TC.18852 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18852 Add New MozyPro Partner - IE - Biennially - 8 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under    | server plan | net terms | country | address           | city      | state | zip   | phone          |
      | 24     | 8 TB      | MozyPro Ireland | yes         | yes       | Ireland | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €48,299.16
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 8 TB             | 1        | €46,619.58 | €46,619.58  |
      | Server Plan      | 1        | €1,679.58  | €1,679.58   |
      | Pre-tax Subtotal |          |            | €48,299.16  |
      | Taxes            |          |            | €11,108.80  |
      | Total Charges    |          |            | €59,407.96  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                   | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro Ireland (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | Ireland          | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 8192      | 8192     | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Biennial           |
      | Unpaid Balance: | €59,407.96             | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | €59,407.96 | €0.00      | €59,407.96  |
    And I delete partner account

  @TC.18853 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18853 Add New MozyPro Partner - UK - Monthly - 12 TB - Server Plan - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under | server plan | net terms | country        | address           | city      | state | zip   | phone          |
      | 1      | 12 TB     | MozyPro UK   | yes         | yes       | United Kingdom | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be £2,837.94
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 12 TB            | 1        | £2,732.97  | £2,732.97   |
      | Server Plan      | 1        | £104.97    | £104.97     |
      | Pre-tax Subtotal |          |            | £2,837.94   |
      | Taxes            |          |            | £567.58     |
      | Total Charges    |          |            | £3,405.52   |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:              | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro UK (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United Kingdom   | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 12288     | 12288    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Monthly            |
      | Unpaid Balance: | £3,405.52              | Collect On:     | N/A                |
      | Renewal Date:   | after 1 month          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 month          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount    | Total Paid | Balance Due |
      | today | £3,405.52 | £0.00      | £3,405.52   |
    And I delete partner account

  @TC.17956 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 17956 Add New MozyPro Partner - US - Yearly - 16 TB - Server Plan - 10 Storage Add on - CC
    When I add a new MozyPro partner:
      | period | base plan | server plan | storage add on | country       | address           | city      | state abbrev | zip   | phone          | cc number        |
      | 12     | 16 TB     | yes         | 10             | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 | 4640603114144552 |
    Then Sub-total before taxes or discounts should be $76,008.02
    And Order summary table should be:
      | Description      | Quantity | Price Each | Total Price |
      | 16 TB            | 1        | $63,359.56 | $63,359.56  |
      | Server Plan      | 1        | $2,199.56  | $2,199.56   |
      | 250 GB Add-on    | 10       | $1,044.89  | $10,448.90  |
      | Pre-tax Subtotal |          |            | $76,008.02  |
      | Total Charges    |          |            | $76,008.02  |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 18884     | 18884    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Credit Card            | Current Period: | Yearly             |
      | Unpaid Balance: | $0.00                  | Collect On:     | N/A                |
      | Renewal Date:   | after 1 year           | Renewal Period: | Use Current Period |
      | Next Charge:    | after 1 year          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount     | Total Paid | Balance Due |
      | today | $76,008.02 | $76,008.02 | $0.00       |
    And I delete partner account

  @TC.17957 @bus @2.5 @add_new_partner @mozypro @env_dependent @vat @regression @core_function
  Scenario: 17957 Add New MozyPro Partner - FR - Biennially - 20 TB - Server Plan - 10 Storage Add on - VAT - Coupon - Net Terms
    When I add a new MozyPro partner:
      | period | base plan | create under   | server plan | storage add on | net terms | vat number    | coupon              | country | address           | city      | state | zip   | phone          |
      | 24     | 20 TB     | MozyPro France | yes         | 10             | yes       | FR08410091490 | 10PERCENTOFFOUTLINE | France  | 3401 Hillview Ave | Palo Alto | CA    | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be €136,495.80
    And Order summary table should be:
      | Description       | Quantity | Price Each  | Total Price |
      | 20 TB             | 1        | €116,548.95 | €116,548.95 |
      | Server Plan       | 1        | €4,198.95   | €4,198.95   |
      | 250 GB Add-on     | 10       | €1,574.79   | €15,747.90  |
      | Discounts Applied |          |             | -€13,649.59 |
      | Pre-tax Subtotal  |          |             | €122,846.21 |
      | Total Charges     |          |             | €122,846.21 |
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent:                  | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro France (MozyPro) | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | France           | 1-877-486-9273 | <%=@partner.admin_info.email%> |
    And Partner account attributes should be:
      | Backup Devices         |          |
      | Backup Device Soft Cap | Disabled |
      | Server                 | Enabled  |
      | Cloud Storage (GB)     |          |
      | Sync Users:           |    -1    |
      | Default Sync Storage: |          |
    And Partner pooled storage information should be:
      | Used | Available | Assigned | Used | Available | Assigned  |
      | 0    | 22980     | 22980    | 0    | Unlimited | Unlimited |
    And Partner internal billing should be:
      | Account Type:   | Net Terms 30           | Current Period: | Biennial           |
      | Unpaid Balance: | €122,846.21            | Collect On:     | N/A                |
      | Renewal Date:   | after 2 years          | Renewal Period: | Use Current Period |
      | Next Charge:    | after 2 years          |                 |                    |
    And Partner billing history should be:
      | Date  | Amount      | Total Paid | Balance Due |
      | today | €122,846.21 | €0.00      | €122,846.21 |
    And I delete partner account

  @TC.17979 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 17979 Add New MozyPro Partner Without Initial Purchases
    When I add a new MozyPro partner:
      | period | country       | address           | city      | state abbrev | zip   | phone          |
      | 1      | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |
    Then Sub-total before taxes or discounts should be 0
    And New partner should be created
    And Partner general information should be:
      | Status:         | Root Admin:          | Root Role:                  | Parent: | Marketing Referrals:                  | Subdomain:              | Enable Mobile Access: | Enable Co-branding: | Require Ingredient: | Enable Sync: |
      | Active (change) | @root_admin (act as) | SMB Bundle Limited (change) | MozyPro | @login_admin_email [X] (add referral) | (learn more and set up) | Yes (change)          | No (change)         | No (change)         | Yes (change) |
    And Partner contact information should be:
      | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Contact Email:                 |
      | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 | <%=@partner.admin_info.email%> |
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

  @TC.18720 @bus @2.5 @add_new_partner @mozypro @regression @core_function
  Scenario: 18720 Verify MozyPro partner has 3 period options
    When I navigate to Add New Partner section from bus admin console page
    Then MozyPro partner subscription period options should be:
      | Monthly | Yearly | Biennially |

  @TC.20377 @bus @2.5 @add_new_partner @mozypro @env_dependent @regression @core_function
  Scenario: 20377 Add New MozyPro Partner - US - Monthly - 50 GB - Server Plan - 100PercentDiscountCoupon - CC
    When I add a new MozyPro partner:
      | period | base plan | server plan | coupon               |
      | 1      | 50 GB     | yes         | 100PERCENTOFFOUTLINE |
    Then Sub-total before taxes or discounts should be $26.98
    And Order summary table should be:
      | Description       | Quantity | Price Each | Total Price |
      | 50 GB             | 1        | $19.99     | $19.99      |
      | Server Plan       | 1        | $6.99      | $6.99       |
      | Discounts Applied |          |            | -$26.98     |
      | Total Charges     |          |            | $0.00       |
    And New partner should be created
    And Partner billing history should be:
      | Date  | Amount | Total Paid | Balance Due |
      | today | $0.00  | $0.00      | $0.00       |
    And I delete partner account

#  @STT_vmbu  @STT_vmbu_pro
#  Scenario:  Add New MozyPro Partner - FR - Biennially - 20 TB - Server Plan - 10 Storage Add on - VAT - Coupon - Net Terms
#
#    When I add a new MozyPro partner:
#      | period | base plan | server plan | storage add on | country       | address           | city      | state abbrev | zip   | phone          |  security |
#      | 12     | 16 TB     | yes         | 10             | United States | 3401 Hillview Ave | Palo Alto | CA           | 94304 | 1-877-486-9273 |   HIPAA   |
#    And I change root role to Fedid
#    And I enabled server in partner account details
#    And I act as newly created partner
#  ##create user groups and client configurations
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
#  ## create sub-partner
#    When I navigate to Add New Role section from bus admin console page
#    And I add a new role:
#      | Name    | Type          |
#      | newrole | Partner admin |
#    And I check all the capabilities for the new role
#    And I close the role details section
#    When I navigate to Add New Pro Plan section from bus admin console page
#    Then I add a new pro plan for Mozypro partner:
#      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
#      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
#    And I add a new sub partner:
#      | Company Name |
#      | STT_subpro    |
#    And New partner should be created
#    And I act as newly created partner
#    And I purchase resources:
#      | generic quota |
#      | 2200          |
#    Then Resources should be purchased
#  ##create sub-partner user groups and client configuration
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
#  ##create sub-partner users
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

  @TC.125448 @bus @mozypro @tasks_p3
  Scenario: 125448: Info is stored when signup MozyPro/Home user
    When I add a new MozyPro partner:
      | period | base plan |
      | 1      | 250 GB    |
    And New partner should be created
    And I get partner aria id
    And the partner has activated the admin account with default password
    And The admin's IP address should be stored in demeter
    When API* I get Aria account details by newly created partner aria id
    Then API* Aria account should be:
      | country | billing_country |
      | US      | US              |
    When I log in bus admin console as administrator
    #And I search and delete partner account by newly created partner company name
    When I am at dom selection point:
    And I maximize the automation browser
    And I add a phoenix Home user:
      | period | base plan | country       |
      | 1      | 50 GB     | United States |
    Then the user is successfully added.
    And the user has activated their account
    When I get the current user id from the database
    And I get user cybersource id from database
    Then I am able to retrieve information from CyberSource:
      | last four digits                           | BIN country                        |
      | <%=@partner.credit_card.last_four_digits%> | <%=@partner.billing_info.country%> |

