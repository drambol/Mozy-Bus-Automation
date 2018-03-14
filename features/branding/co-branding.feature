Feature: co-branding
  As a Mozy partner Admin, I should be able to upload images that appears in my web portal and within the Windows and Mac clients.

  Background:
    Given I log in bus admin console as administrator

  # currently this case will be failed in qa12 (wrong permission for uploaded file  https://redmine.mozy.lab.emc.com/issues/126540)
  @TC.20915 @bus @ROR_smoke
  Scenario: 20915 Activate co-branding on a partner and verify it appears on subpartner
    When I clean up png files in downloads folder
    # create a Reseller partner
    And I add a new Reseller partner:
      | period | company name | reseller type | reseller quota | server plan | country       |
      | 12     | TC.20915     |Silver         | 100            | yes         | United States |
    And New partner should be created
    And I click admin name @partner.admin_info.full_name in partner details section
    And I active admin in admin details default password
    # add a subpartner under this reseller
    When I log in bus admin console as new partner admin
    Then Navigation item Co-Branding should be unavailable
    When I navigate to Add New Role section from bus admin console page
    And I add a new role:
      | Name    | Type          |
      | newrole | Partner admin |
    When I navigate to Add New Pro Plan section from bus admin console page
    Then I add a new pro plan for Mozypro partner:
      | Name    | Company Type | Root Role | Enabled | Public | Currency                        | Periods | Tax Name | Auto-include tax | Generic Price per gigabyte | Generic Min gigabytes |
      | newplan | business     | newrole   | Yes     | No     | $ — US Dollar (Partner Default) | yearly  | test     | false            | 1                          | 1                     |
    And I add a new sub partner:
      | Company Name        |
      | TC.20915_subpartner |
    And New partner should be created
    And I click admin name @subpartner.admin_name in partner details section
    And I active admin in admin details default password
    And I close the admin details section
    And I refresh the page
    # turning "Enable Co-branding" and "Require Ingredient:" to yes in partner details
    When I view the partner info
    And I enable co-branding for the partner
    And I enable require ingredient for the partner
    And I refresh the page
    Then Navigation item Co-Branding should be available
    # upload a image for web portal and activate it
    When I navigate to Co-Branding section from bus admin console page
    And I upload image title.png for Web Portal for Co-Branding
    And I activate Co-branding
    # now the partner should see this upload image on left top side
    And I refresh the page
    And I wait for 5 seconds
    And I download the partner branding img as file new_partner_img.png on top left side of dashboard
    Then the downloaded top img new_partner_img.png should be same as the upload img title.png
    # then subpartner should see the inherited image on left top side
    When I log out bus admin console
    And I navigate to bus admin console login page
    And I log in bus admin console with user name @subpartner.admin_email_address and password default password
    Then I login as TC.20915_subpartner admin successfully
    When I download the partner branding img as file new_sub_partner_img.png on top left side of dashboard
    Then the downloaded top img new_sub_partner_img.png should be same as the upload img title.png