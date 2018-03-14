module Bus
  # This class provides actions for partner details page section
  class PartnerDetailsSection < SiteHelper::Section

    # Private elements
    #
    # element(:settings_link, css: 'ul.actions>li:nth-child(2)>a')
    element(:settings_link, xpath: "//a[text()='Settings']")
    element(:new_setting_btn, {css: 'span[id^=new_setting]>input'}, true)
    element(:setting_key_select, id: 'pro_partner_setting_key')
    element(:setting_value_input, id: 'pro_partner_setting_value')
    element(:setting_locked_checkbox, id: 'pro_partner_setting_is_locked')
    element(:setting_save_btn, css: 'input[name=create_setting]')
    element(:setting_cancel_link, css: 'input[name=create_setting]+a')
    element(:close_settings_link, css: 'a[id^=close_settings]')
    element(:msg_div, xpath: "//div[contains(@id,'partner-show')]/ul[@class='flash successes']")
    element(:error_msg_div, xpath: "//ul[@class='flash errors']")
    element(:billing_info_link, xpath: "//a[text()='Billing Info']")
    element(:act_as_link, xpath: "//a[text()='act as']")
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:delete_partner_link, xpath: "//a[text()='Delete Partner']")
    element(:view_in_aria_link, xpath: "//a[text()='View in Aria']")
    element(:export_to_excel_link, xpath: "//a[text()='Export to Excel (CSV)']")
    element(:set_product_name_link, xpath: "//a[text()='Set Product Name']")

    # Change partner external id
    element(:external_id_tb, id: 'external_id')
    element(:change_external_id_link, css: 'dd.view>form>span.view a')
    element(:cancel_external_id_link, css: 'dd.edit>form>span.edit a')
    element(:submit_external_id_btn, css: 'dd.edit>form>span.edit input[value=Submit]')

    # Change partner status
    element(:change_status_link, css: 'span[id^=partner-display-status-] a')
    element(:change_status_select, css: 'span[id^=partner-change-status-] select')
    element(:submit_change_status_btn, css: 'span[id^=partner-change-status-] input')
    element(:cancel_change_status_link, css: 'span[id^=partner-change-status-] a')

    # Change partner root role
    element(:partner_root_role_change_link, xpath: "//span[contains(@id,'partner-display-root-role')]/a")
    element(:partner_root_role_type_select, xpath: "//span[contains(@id,'partner-change-root-role')]/select")
    element(:partner_root_role_submit_btn, xpath: "//span[contains(@id,'partner-change-root-role')]/input")
    element(:partner_root_role_cancel_btn, xpath: "//span[contains(@id,'partner-change-root-role')]/a")
    element(:partner_root_role_name, xpath: "//span[contains(@id, 'partner-display-root-role')]")

    # Change partner account type
    element(:account_type_change_link, xpath: "//a[contains(@onclick,'-acct-type-')][contains(text(),'change')]")
    element(:account_type_select, xpath: "//select[@name='acct_type']")
    element(:account_type_submit_btn , xpath: "//select[@name='acct_type']/../input[@type='submit'] ")
    element(:account_type_span, xpath: "//span[contains(@id,'partner-display-acct-type-')]")

    # change sales channnel
    element(:sales_channel_change_link, xpath: "//a[contains(@onclick,'partner-display-sales-channel')][text()='(change)']")
    element(:sales_channel_select, xpath: "//select[@name='sales_channel']")
    element(:sales_channel_submit_btn , xpath: "//select[@name='sales_channel']/../input[@type='submit']")
    element(:sales_channel_span, xpath: "//span[contains(@id,'partner-display-sales-channel')]")



    # General information
    elements(:general_info_dls, css: 'div>dl')
    element(:stash_info_dl, css: 'div>dl>form')

    # Contact information
    element(:partner_details_div, xpath: "//div[contains(@id,'account_details')]")
    element(:account_details_icon, xpath: "//i[contains(@id,'account-dtl-icon')]")
    element(:account_details_attribute_edit, xpath: "//a[contains(@id, 'toggle_partner_attribute_management_edit')]/span")
    element(:account_details_attribute_server, xpath: "//input[@name='backup:server_support' and @type='checkbox']")
    element(:account_details_attribute_save, css: "div.partner_attribute_management_shown > input[type=\"submit\"]")

    elements(:contact_info_dls, xpath: "//div/form/dl")
    element(:contact_address_tb, xpath: "//input[@name='contact_address']")
    element(:contact_city_tb, xpath: "//input[@name='contact_city']")
    element(:contact_state_select, xpath: "//input[@name='contact_state']")
    element(:contact_state_us_select, xpath: "//select[@id='contact_state_us']")
    element(:contact_state_ca_select, xpath: "//select[@id='contact_state_ca']")
    element(:contact_zip_tb, xpath: "//input[@name='contact_zip']")
    element(:contact_country_select, xpath: "//select[@name='contact_country']")
    element(:contact_country_text, xpath: '//div/form/dl[2]/dd[5]')
    element(:contact_phone_tb, xpath: "//input[@name='partner_contact_phone']")
    element(:contact_industry_select, xpath: "//select[@name='partner[industry]']")
    element(:contact_employees_select, xpath: "//select[@name='partner[num_employees]']")
    element(:contact_email_tb, xpath: "//input[@name='contact_email']")
    element(:contact_vat_tb, id: 'vat_info_vat_number')
    element(:save_changes_btn, xpath: "//input[contains(@onclick,'password_dialog')]")

    #change contact country section
    element(:chg_country_link_a, xpath: "//a[text()='Change Contact Country']")
    element(:contact_vat_number, xpath: "//input[@id='vat_num']")
    element(:contact_chg_country_select, xpath: "//select[@id='country_and_vat_contact_country']")
    element(:submit_btn, xpath: "//input[@id='submit_button']")

    # verify password pop up
    element(:verify_passowrd_input, xpath: "//div[@class='popup-window']//input[@name='password']")
    element(:submit_popup_btn, xpath: "//div[@class='popup-window-footer']/input[@value='Submit']")

    # API Key
    element(:api_key_div, xpath: "//label[.='API Key:']/..")
    element(:create_or_delete_api_key_link, css: 'div[id^=api-key-box-] fieldset div:nth-child(1) a')
    element(:ip_whitelist_div, css: 'div[id^=api-key-box-] fieldset div:nth-child(2)')
    element(:ip_whitelist_icon, xpath: "//i[contains(@id, 'ip-whitelist-icon')]")
    element(:add_ip_whitelist_tab, xpath: "//li[text()='Add IP Whitelist']")
    element(:ip_address_range, xpath: "//input[@name='auth_ip_whitelist[ip_address]']")
    element(:save_ip_whitelist, xpath: "//input[contains(@onclick, 'auth_ip_whitelist')]")
    element(:change_api_ip_whitelist_a, xpath: "//label[.='API IP Whitelist:']/../span/form/span[@class='view']/a")
    element(:api_ip_whitelist_input, xpath: "//input[@id='api_allowed_ips']")
    element(:submit_ip_whitelist_input, xpath: "//label[.='API IP Whitelist:']/../span/form/span[@class='edit']/input[@name='commit']")

    # Account attribute table
    element(:account_attributes_table, css: 'form[id^=account_attributes_form] table')

    # Pooled Storage
    element(:pooled_resource_edit_link, css: 'a[id^=toggle_partner_pooled_resource_item_edit]')
    element(:pooled_resource_submit_btn, xpath: "//div[@class='resource_item_edit']/p/input[@type='submit']")
    element(:assign_quota_desktop_input, xpath: "//input[@name='assigned_quota[Desktop]']")
    element(:assigned_licenses_desktop_input, xpath: "//input[@name='assigned_licenses[Desktop]']")
    element(:assign_quota_server_input, xpath: "//input[@name='assigned_quota[Server]']")
    element(:assigned_licenses_server_input, xpath: "//input[@name='assigned_licenses[Server]']")
    element(:assigned_quota_generic_input, xpath: "//input[@name='assigned_quota[Generic]']")
    element(:pooled_resource_edit_link, xpath: "//a[contains(@id,'toggle_partner_pooled_resource_item_edit')]")

    # Resources table, for MozyPro
    element(:generic_resources_table, css: 'form[id^=generic_resources_form] table')

    # Pooled Resources table, for Pooled partner
    element(:pooled_resources_table, xpath: "//form[contains(@id,'pooled_resources_form')]/table")

    # License types table
    element(:license_types_table, css: 'div[id^=partner_license_types] table')

    # Stash table
    element(:stash_info_table, css: 'div[id$=account_details]>table.form-box2')

    # Internal billing table
    element(:internal_billing_div, css: 'div[id$=internal-billing]')
    element(:internal_billing_table, css: 'div[id$=internal-billing-content] table')

    # Subadmins
    element(:subadmins_icon, css: 'i[id$=subadmin-icon]')
    element(:sub_admins_div, css: '.adminbox.subadminbox')
    element(:sub_admins_table, css: 'div#subadminbox table')

    # Billing history
    element(:billing_information_icon, xpath: "//i[contains(@id,'bill-info-icon')]")
    element(:show_billing_history_link, css: 'a[onclick*=billing-history]')
    element(:billing_history_table, xpath: "//div[contains(@id,'partner-aria-txn-history-')]/div[1]/table")

    # Stash section
    element(:change_stash_link, {css: 'a[onclick*=change_stash]'}, true)
    element(:cancel_stash_link, {css: 'a[onclick*=cancel_change]'}, true)
    element(:stash_status_select, css: 'select[id^=partner-stash-status-]')
    element(:submit_stash_status_btn, css: 'input[onclick*=submit_stash_status]')
    element(:add_stash_to_all_users_link, css: 'a[onclick*=enable_stash_for_all_confirm]')

    #autogrow section
    element(:change_autogrow_status_link, css: 'a[onclick*=partner-display-overdraft-status]')
    element(:autogrow_status_select, css: 'select[id^=overdraft_status]')
    element(:submit_autogrow_status_btn, css: 'span[id^=partner-change-overdraft-status-] input[value=Submit]')

    # Co-branding section
    element(:change_cobranding_status_link, css: 'a[onclick*=partner-display-cobranding-status]')
    element(:cobranding_status_select, css: 'select[id^=cobranding_status]')
    element(:submit_cobranding_status_btn, css: 'span[id^=partner-change-cobranding-status-] input[value=Submit]')

    # Ingredient section
    element(:change_ingredient_status_link, css: 'a[onclick*=partner-display-ingredient-status]')
    element(:ingredient_status_select, css: 'select[id^=ingredient_status]')
    element(:submit_ingredient_status_btn, css: 'span[id^=partner-change-ingredient-status-] input[value=Submit]')


    # Subdomain
    element(:change_subdomain_link, xpath: "//a[text()='(learn more and set up)']")
    element(:h3_section, css: "h3")

    # security fiedld
    element(:secuirty_field, xpath: "//span[contains(@id,'partner-display-hipaa-compliance-status')]")

    element(:ldap_delete_confirm_btn, xpath: "//input[@value='Confirm']")

    # change partner name
    element(:partner_name_tb, id: 'name')
    element(:save_changes_partnername, xpath: ".//*[contains(@id,'partner-name-change')]/form/table/tbody/tr/td[2]/input")

    # Public: Partner Id
    #
    # Return string
    def partner_id
      general_info_hash['ID:']
    end

    def partner
      wait_until_bus_section_load
      { :id => general_info_hash['ID:'],
        :name => find(:xpath, "//div[starts-with(@id,'partner-show-')]/div[2]/div/h3").text }
    end

    def click_bill_info_link
      wait_until {billing_info_link.visible?}
      billing_info_link.click
    end

    # Public: General information hash
    #
    # @param [none]
    #
    # Example:
    #   partner_details_section.general_info_hash
    #   # => {"ID:"=>"325379", "External ID:"=>"(change)", "Aria ID:"=>"4475660", "Approved:"=>"04/02/13 12:04", "Status:"=>"Active (change)", "Root Admin:"=>"Ann Dunn (act as)", "Root Role:"=>"Enterprise (change)", "Parent:"=>"MozyEnterprise", "Marketing Referrals:"=>"qa1+automation+admin@mozy.com [X] (add referral)", "Subdomain:"=>"(learn more and set up)", "Enable Mobile Access:"=>"Yes (change)", "Enable Co-branding:"=>"No (change)", "Require Ingredient:"=>"No (change)", "Enable Autogrow:"=>"No (change)", "Enable Stash:"=>"No", "Account Type"=>"Trial (change)", "Sales Origin"=>"Sales", "Sales Channel"=>"Inside Sales (change)"}
    #
    # @return [Hash]
    def general_info_hash
      wait_until_bus_section_load
      output = general_info_dls[0,4].inject([]){ |sum, dls| sum + dls.dt_dd_elements_text}
      if has_stash_info_dl?
        stash = stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty? }.map{ |row| [row.first, row[1..-1].join(' ')] }
        output = output + stash
      end
      unless general_info_dls[3].nil?
        # v.2.4.3 account type details
        output += general_info_dls[3].dt_dd_elements_text
      end
      Hash[*output.flatten]
    end

    # Public: Account Details hash
    #
    # @param [none]
    #
    # Example:
    #   partner_details_section.account_details_hash
    #   # => {"Account Type"=>"Trial (change)", "Sales Origin"=>"Sales", "Sales Channel"=>"Inside Sales (change)"}
    #
    # @return [Hash]
    def account_details_hash
      wait_until_bus_section_load
      wait_until { !(general_info_dls.first.dt_dd_elements_text.first.first == '') }
      # v.2.4.3 account type details
      account_detail = general_info_dls[2].text.include?('Enable Sync') ? general_info_dls[3] : general_info_dls[2]
      output = account_detail.nil? ? [] : account_detail.dt_dd_elements_text
      Hash[*output.flatten]
    end

    def account_details_enable_server
      wait_until_bus_section_load
      expand(account_details_icon)
      wait_until_ajax_finished(partner_details_div)
      wait_until { !(contact_info_dls.first.dt_dd_elements_text.first.first == '') }
      account_details_attribute_edit.click
      account_details_attribute_server.click
      account_details_attribute_save.click
      wait_until_bus_section_load
    end

    # Public: Partner contact information hash
    #
    # Example:
    #   partner_details_section.contact_info_hash
    #   # => Hash table
    #   | Company Type: | Users: | Contact Address:  | Contact City: | Contact State: | Contact ZIP/Postal Code: | Contact Country: | Phone:         | Industry: | # of employees: | Contact Email: |
    #   | MozyPro       | 0      | 3401 Hillview Ave | Palo Alto     | CA             | 94304                    | United States    | 1-877-486-9273 |           |                 | test@mozy.com  |
    #
    # Returns hash table
    def contact_info_hash
      wait_until_bus_section_load
      expand(account_details_icon)
      wait_until_ajax_finished(partner_details_div)
      wait_until { !(contact_info_dls.first.dt_dd_elements_text.first.first == '') }
      outarray = contact_info_dls.map{ |el| el.dt_dd_elements_text.delete_if{ |pair| pair.first.empty?}}.delete_if{ |el| el.empty?}
      # for OEM partner, outarray will have ["(Invoiced)"], and above code can't handle this
      outarray.last.pop if outarray.last.last == ["(Invoiced)"]
      output = Hash[*outarray.flatten]
      output['Contact Address:'] = contact_address_tb.value
      output['Contact City:'] = contact_city_tb.value

      @state = ""
      case
        when contact_state_us_select.visible?
          @state = contact_state_us_select.first_selected_option.text
        when  contact_state_ca_select.visible?
          @state = contact_state_ca_select.first_selected_option.text
        else
          @state = contact_state_select.value
      end
      output['Contact State:'] = @state

      output['Contact ZIP/Postal Code:'] = contact_zip_tb.value
      if contact_country_select.visible?
        output['Contact Country:'] = contact_country_select.first_selected_option.text
      else
        output['Contact Country:'] = contact_country_text.text.gsub(' Change Contact Country','')
      end
      output['Phone:'] = contact_phone_tb.value
      output['Industry:'] = contact_industry_select.first_selected_option.text
      output['# of employees:'] = contact_employees_select.first_selected_option.text
      output['Contact Email:'] = contact_email_tb.value unless locate(:xpath, "//input[@id='contact_email']").nil?
      output['VAT Number:'] = contact_vat_tb.value unless locate(:id, 'vat_info_vat_number').nil?
      output
    end

    def expand_contact_info
      wait_until_bus_section_load
      expand(account_details_icon)
      wait_until_ajax_finished(partner_details_div)
      wait_until { !(contact_info_dls.first.dt_dd_elements_text.first.first == '') }
    end

    # Public: Partner Account attributes hash
    #
    # Example:
    #   partner_details_section.account_attributes_hashes
    #   # => "{"Backup Licenses" => "200"], "Backup License Soft Cap"=>"Enabled", "Server Enabled" => "Disabled", "Cloud Storage (GB)" => "10", "Stash Users:" =>  "", "Default Stash Storage:" =>  ""}"
    #
    # Returns hash
    def account_attributes_hashes
      # Remove hidden column inside table
      expand(account_details_icon)
      array = account_attributes_table.rows_text.map{ |row| row[0..1] }
      Hash[*array.flatten]
    end

    def pooled_resource_table_rows
      wait_until_bus_section_load
      expand(account_details_icon)
      pooled_resources_table.rows_text
    end

    # Public: Generic resources table headers text
    #
    # Example:
    #   # => "["", "Used", "Allocated", "Limit"]"
    #
    # Return array
    def generic_resources_table_headers
      expand(account_details_icon)
      generic_resources_table.headers_text
    end

    # Public: Generic resources table rows text
    #
    # Example:
    #   # => "[["Backup Licenses", "0", "10", "200"], ["Cloud Storage (GB)", "0", "10", "10"], ["Server Enabled", "Disabled", "", ""]]"
    #
    # Returns array
    def generic_resources_table_rows
      # Remove hidden column inside table
      expand(account_details_icon)
      output = generic_resources_table.rows_text.map{ |row| row[0..3] }
      output[2] = output[2] + ['','']
      output
    end

    # Public: License types table headers text
    #
    # Example:
    #   # => "["", "Licenses:", "Licenses Used:", "Quota:", "Quota Used:", "Resource Policy:"]"
    #
    # Returns array
    def license_types_table_headers
      expand(account_details_icon)
      license_types_table.headers_text
    end

    # Public: License types table rows text
    #
    # Example:
    #   # => "[["Desktop", "100", "0", "2500 GB", "0 bytes", "Enabled"], ["Server", "0", "0", "0 GB", "0 bytes", "Enabled"]]"
    #
    # Returns array
    def license_types_table_rows
      expand(account_details_icon)
      license_types_table.rows_text
    end

    # Public: Stash info table row text
    #
    # Returns array
    def stash_info_table_rows
      expand(account_details_icon)
      stash_info_table.rows_text
    end

    # Public: Internal billing table row text
    #
    # Example:
    #   # => "[["Account Type:", "Credit Card", "Current Period:", "Yearly"], ["Unpaid Balance:", "$0.00", "Collect On:", "N/A"], ["Renewal Date:", "11/19/13", "Renewal Period:", "Use Current Period"]]"
    #
    # Returns array
    def internal_billing_table_rows
      expand(billing_information_icon)
      wait_until_ajax_finished(internal_billing_div)
      internal_billing_table.rows_text
    end

    # Public: Sub admins text
    #
    # Return string
    def sub_admins_text
      expand(subadmins_icon)
      wait_until_ajax_finished(sub_admins_div)
      sub_admins_div.text
    end

    # Public: Sub admins table headers text
    #
    # Returns array
    def sub_admins_table_headers
      expand(subadmins_icon)
      wait_until_ajax_finished(sub_admins_div)
      sub_admins_table.headers_text
    end

    # Public: Sub admins table rows text
    #
    # Returns array
    def sub_admins_table_rows
      expand(subadmins_icon)
      wait_until_ajax_finished(sub_admins_div)
      sub_admins_table.rows_text
    end

    # Public: Billing history hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    #  @bus_admin_console_page.partner_details_section.billing_history_hashes
    #
    # Returns hash array
    def billing_history_hashes
      expand(billing_information_icon)
      show_billing_history_link.click
      wait_until { !billing_history_table.hashes.first.values.first.nil? }
      billing_history_table.hashes
    end

    def show_billing_history
      expand(billing_information_icon)
      show_billing_history_link.click
      wait_until_bus_section_load
    end

    def click_invoice_link
      show_billing_history unless locate(:xpath, "//div[contains(@id,'billing-history')]/h4/a").nil?
      wait_until { !billing_history_table.hashes.first.values.first.nil? }
      (billing_history_table.rows.first[0].find("a")).click
    end

    def view_in_aria
      view_in_aria_link.click
    end

    # Public: Click act as partner link
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.act_as_partner
    #
    # Returns nothing
    def act_as_partner
      act_as_link.click
      alert_accept if alert_present?
    end

    def act_as_partner_with_alert
      act_as_link.click
    end

    def click_admin_name admin_name
      find(:xpath, "//a[text()='#{admin_name}']").click

    end

    # Public: Delete the current partner
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.delete_partner("test1234")
    #
    # Returns nothing
    def delete_partner(password, expect_pass = true)
      wait_until_bus_section_load
      delete_partner_link.click

      password_tb = find(:css, 'form[id$=-delete_form] input[name=password]')
      submit_delete_btn = find(:css, 'div[class=popup-window-footer] input[value=Submit]')

      wait_until{ password_tb.visible? } # wait for load delete password div
      password_tb.type_text(password)
      submit_delete_btn.click
      if expect_pass
        wait_until{ has_no_link?("Delete Partner") } # wait for delete partner
      else
        return_text = alert_text
        alert_accept
        return_text
      end
    end

    def ldap_admin_delete_partner
      wait_until_bus_section_load
      delete_partner_link.click
      ldap_delete_confirm_btn.click
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_stash
    #
    # Returns nothing
    def enable_stash
      change_stash_link.click
      stash_status_select.select('Yes')
      submit_stash_status_btn.click
      wait_until_bus_section_load
    end

    # Public: Disable stash for a partner
    # Note: Still Need to click submit button on popup window
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_stash
    #
    # Returns nothing
    def disable_stash
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
      wait_until_bus_section_load
    end

    # Public: Enable autogrow for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_autogrow
    #
    # Returns nothing
    def enable_autogrow
      change_autogrow_status_link.click
      autogrow_status_select.select('Yes')
      submit_autogrow_status_btn.click
      wait_until{ !submit_autogrow_status_btn.visible? }
    end

    # Public: Disable autogrow for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_autogrow
    #
    # Returns nothing
    def disable_autogrow
      change_autogrow_status_link.click
      autogrow_status_select.select('No')
      submit_autogrow_status_btn.click
      wait_until{ success_messages == "Autogrow protection disabled." }
    end

    # Public: Add stash to all users
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.add_stash_to_all_users
    #
    # Returns nothing
    def add_stash_to_all_users
      add_stash_to_all_users_link.click
    end

    # Public: Enable co-branding for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_cobranding
    #
    # Returns nothing
    def enable_cobranding
      change_cobranding_status_link.click
      cobranding_status_select.select('Yes')
      submit_cobranding_status_btn.click
      wait_until{ !submit_cobranding_status_btn.visible? }
    end

    # Public: Disable co-branding for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_cobranding
    #
    # Returns nothing
    def disable_cobranding
      change_cobranding_status_link.click
      cobranding_status_select.select('No')
      submit_cobranding_status_btn.click
      wait_until{ !submit_cobranding_status_btn.visible? }
    end

    # Public: Enable require ingredient for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.enable_require_ingredient
    #
    # Returns nothing
    def enable_require_ingredient
      change_ingredient_status_link.click
      ingredient_status_select.select('Yes')
      submit_ingredient_status_btn.click
      wait_until{ !submit_ingredient_status_btn.visible? }
    end

    # Public: Disable require ingredient for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.disable_require_ingredient
    #
    # Returns nothing
    def disable_require_ingredient
      change_ingredient_status_link.click
      ingredient_status_select.select('No')
      submit_ingredient_status_btn.click
      wait_until{ !submit_ingredient_status_btn.visible? }
    end

    # Public: Change partner root role
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.change_root_role('Enterprise')
    #
    # Returns nothing
    def change_root_role(root_role)
      partner_root_role_change_link.click
      partner_root_role_type_select.select(root_role)
      partner_root_role_submit_btn.click
      wait_until_bus_section_load
    end

    # Public: Get partner root role
    #
    # Example:
    #   @bus_site.admin_console_page.partner_details_section.get_root_role
    #
    # Returns the text value of root role name
    def get_root_role
      partner_root_role_name.text.gsub(partner_root_role_name.first_child.text,'').strip
    end


    # Public: Create API Key
    # Skipped, ff API key existed
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.create_api_key
    #
    # Returns nothing
    def create_api_key
      wait_until_bus_section_load
      locator =  "//a[text()='(create)']"
      find_any = api_key_div.all(:xpath, locator)
      if find_any.size > 0
        api_key_div.find(:xpath, locator).click
        wait_until_bus_section_load
      end
    end

    # Public: Get API key
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.api_key
    #
    # Returns API key string
    def api_key
      api_key_div.text.gsub(/API Key:/,'').gsub(/\(create\)/,'').gsub(/\(delete\)/,'').strip
    end

    # Public: IP whitelist
    #
    def ip_whitelist
      if ip_whitelist_div.text.gsub(/API IP Whitelist:/,'').gsub(/\(change\)/,'').gsub(/\(cancel\)/,'').strip != ''
        ip_whitelist_div.text.gsub(/API IP Whitelist:/,'').gsub(/\(change\)/,'').gsub(/\(cancel\)/,'').strip
      else
        api_ip_whitelist_input.value
      end
    end

    def add_ip_whitelist(ip)
      refresh_bus_section
      change_api_ip_whitelist_a.click
      api_ip_whitelist_input.type_text(ip.to_s)
      submit_ip_whitelist_input.click
    end

    def add_ip_whitelist_none_api(ip)
      if (ip == 'local IP')
        ip_list = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
        ip = ip_list.ip_address
      end
      ip_whitelist_icon.click
      add_ip_whitelist_tab.click
      ip_address_range.type_text(ip.to_s)
      save_ip_whitelist.click
    end

    def remove_ip_whitelist_none_api(ip)
      ip_whitelist_icon.click
      ip_whitelist_div.find(:xpath, "//td[text()='" + ip + "']/following-sibling::td/a[text()='Delete']").click
      alert_accept
    end

    # Public: Close partner details frame
    #
    # @param [string] partner_id
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.close_partner_detail_section_by_id("317669")
    #
    # @return nothing
    def close_partner_detail_section_by_id(partner_id)
      find(:xpath, "//div[@id='partner-show-#{partner_id}']//a[@class='mod-button'][1]").click
    end

    # Public: Change Partner status from Active to Suspended
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.suspend_partner
    #
    # @return nothing
    def suspend_partner
      wait_until { change_status_link.visible? }
      change_status_link.click
      # wait for edit view
      wait_until { change_status_select.visible? }
      change_status_select.select('Suspended')
      submit_change_status_btn.click
      wait_until{ change_status_link.visible? }
    end

    # Public: Change Partner status from Suspended to Active
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.activate_partner
    #
    # @return nothing
    def activate_partner
      wait_until { change_status_link.visible? }
      change_status_link.click
      # wait for edit view
      wait_until { change_status_select.visible? }
      change_status_select.select('Active')
      submit_change_status_btn.click
      wait_until{ change_status_link.visible? }
    end

    # Public: Change Partner External ID
    #    #
    # Example pooled_resource_edit_link
    #  @bus_site.admin_console_page.partner_details_section.change_external_id('Test_EID_12345')
    #
    # Return nothing
    def change_external_id(id)
      change_external_id_link.click
      external_id_tb.type_text(id)
      submit_external_id_btn.click
      wait_until_bus_section_load
    end

    # Public: Change Partner Name
    #    #
    # Example pooled_resource_edit_link
    #  @bus_site.admin_console_page.partner_details_section.change_partner_name('Test_patnername_12345')
    #
    # Return nothing
    def change_partner_name(name)
      change_name_link.click
      partner_name_tb.type_text(name)
      save_changes_partnername.click
      wait_until_bus_section_load
    end

    # Public: Click the link to change the subdomain name
    #
    # @param none
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.change_subdomain
    #
    # @return nothing
    def change_subdomain
      change_subdomain_link.click
    end

    def subdomain
      find(:xpath, "//dt[text()='Subdomain:']/../dd[1]").text
    end

    # Public: Click the link to set product name
    #
    def set_product_name
      set_product_name_link.click
    end

    def set_account_type type
      account_type_change_link.click
      wait_until{ account_type_select.visible? }
      account_type_select.select type
      account_type_submit_btn.click
      wait_until_bus_section_load
    end

    def account_type
      account_type_span.text
    end

    def set_sales_channel sales_type
      sales_channel_change_link.click
      wait_until{ sales_channel_select.visible? }
      sales_channel_select.select sales_type
      sales_channel_submit_btn.click
      wait_until_bus_section_load
    end

    def get_sales_channel
      sales_channel_span.text
    end

    # Public: Change the contact email
    #
    # @param email
    #
    # Example
    #  @bus_site.admin_console_page.partner_details_section.set_contact_email email
    #
    # @return nothing
    def set_contact_email email
      contact_email_tb.type_text email
    end

    def set_contact_address address
      contact_address_tb.type_text address
    end

    def set_contact_city city
      contact_city_tb.type_text city
    end

    def set_contact_state state
      case
        when contact_state_us_select.visible?
          contact_state_us_select.select state
        when  contact_state_ca_select.visible?
          contact_state_ca_select.select state
        else
          contact_state_select.type_text state
      end
    end

    def set_contact_zip zip
      contact_zip_tb.type_text zip
    end

    def set_contact_country country
      contact_country_select.select country
      alert_accept if alert_present?
    end

    def set_phone phone
      contact_phone_tb.type_text phone
    end

    def set_contact_industry industry
      contact_industry_select.select industry
    end

    def set_contact_of_employees range
      contact_employees_select.select range
    end

    def set_vat_number vat
      contact_vat_tb.type_text vat
    end

    def clear_vat_number
      contact_vat_tb.type_text ""
    end

    def vat_number_visible?
      find(:xpath, "//input[@id='vat_info_vat_number']").visible?
    end

    def click_change_country_lnk
      chg_country_link_a.click
      wait_until_bus_section_load
    end

    def get_security_value
      secuirty_field.text
    end

    # Public: set country in change country section
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.set_country_for_partner_admin
    #
    # Returns nothing
    def set_country_for_partner_admin country
      contact_chg_country_select.select country
    end

    # Public: set vat number in change country section
    #
    # Example
    #   @bus_site.admin_console_page.partner_details_section.set_vat_for_partner_admin
    #
    # Returns nothing
    def set_vat_for_partner_admin vat
      contact_vat_number.type_text vat
    end

    def vat_of_chg_contact_country_visible?
      find(:xpath, "//input[@id='vat_num']").visible?
    end

    def submit_change(password = QA_ENV['bus_password'])
      submit_btn.click
      verify_password(password)
    end


    def save_changes(password = QA_ENV['bus_password'])
      save_changes_btn.click
      verify_password(password)
    end

    def verify_password(password)
      wait_until{ verify_passowrd_input.visible? } # wait for load delete password div
      verify_passowrd_input.type_text(password)
      submit_popup_btn.click
    end

    # Public: Success messages for partner details section
    #
    # Example
    #  @bus_admin_console_page.partner_details_section.success_messages
    #  # => "API IP whitelist has been updated"
    #
    # @return [String]
    def success_messages
      msg_div.text
    end

    def error_message
      wait_until{ error_msg_div.visible? }
      error_msg_div.text
    end

    # partner info verification - if specific values are present, section should be good
    # additional verification being done @ admin level in admin console
    def partner_info_verify(partner)
      h3_section.text.eql?(partner.company_info.name).present?
      expand(account_details_icon)
      pooled_resources_table.visible?
    end

    def close_settings
      close_settings_link.click
    end

    def add_settings(settings) 
      settings_link.click
      settings.each do |setting|
        unless has_setting?(setting)
          if has_setting_name?(setting['Name'])
            edit_setting(setting)
          else
            add_setting(setting)
          end
          alert_accept if alert_present?
        end
      end
    end

    def edit_setting(setting)
      row_el = find(:xpath, "//td[text()='#{setting['Name']}']/..")
      capability_id = /[\d]+/.match(row_el[:id]).to_s.to_i
      #Enable style.display forcelly
      page.driver.execute_script("document.querySelector('span[id^=settings_editor_for_#{capability_id}]').style.display=''")
      row_el.find(:css, 'span.settings_editor>a').click
      row_el.find(:id, 'pro_partner_setting_value').type_text(setting['Value'])
      locked_el = row_el.find(:id, 'pro_partner_setting_is_locked')
      case setting['Locked']
      when 'true'
        locked_el.check unless locked_el.checked?
      when 'false'
        locked_el.uncheck if locked_el.checked?
      else
        raise 'you can only input true or false for the Locked value'
      end
     row_el.find(:css, 'input[name=update_setting]').click 
    end

    def add_setting(setting)
      new_setting_btn.click
      setting_key_select.select(setting['Name'])
      setting_value_input.set(setting['Value'])
      setting_locked_checkbox.check if setting['Locked'] == 'true'
      setting_save_btn.click
    end

    def delete_settings(settings,exist = true)
      settings_link.click
      settings.each do |setting|
         xpath = "//td[text()='#{setting['Name']}']/.."
         if (!exist) && locate(:xpath,xpath).nil?
         else
          row_el = find(:xpath, xpath)
          capability_id = /[\d]+/.match(row_el[:id]).to_s.to_i
          page.driver.execute_script("document.querySelector('span[id^=settings_editor_for_#{capability_id}]').style.display=''")
          row_el.find(:css, 'span.delete_setting>a').click
          alert_accept
         end
      end
    end

    def show_partner_settings
      settings_link.click
    end

    def has_setting?(setting)
      wait_until { find(:css, 'table[id^=pro_partner_settings_table]').visible? }
      all(:xpath, "//td[text()=\'#{setting['Name']}\']").size >= 1 &&
        find(:xpath, "//td[text()=\'#{setting['Name']}\']/../td[2]").text == setting['Value'] &&
        find(:xpath, "//td[text()=\'#{setting['Name']}\']/../td[3]").text == setting['Locked']
    end

    def verify_settings(settings)
      settings_link.click
      settings.each do |setting|
        has_setting?(setting)
      end
    end

    def has_setting_name?(setting_name)
      all(:xpath, "//td[text()=\'#{setting_name}\']").size >= 1
    end

    def has_section?(section_name)
      size = all(:xpath, "//div[@class='show-details']//*[contains(text(),'#{section_name}')]").size
      (size > 0)? true: false
    end

    def expand_element(element_name)
      case element_name
        when 'account details'
          expand(account_details_icon)
        when 'billing information'
          expand(billing_information_icon)
      end
    end

    def collapse_element(element_name)
      case element_name
        when 'account details'
          collapse(account_details_icon)
        when 'billing information'
          collapse(billing_information_icon)
      end
    end

    def element_collapsed?(element_name)
      case element_name
        when 'account details'
          collapsed?(account_details_icon)
        when 'billing information'
          collapsed?(billing_information_icon)
      end
    end

    # this is for subpartner
    def subpartner
      SubPartner.new(root_element.next_sibling.next_sibling)
    end

    class SubPartner < self
      def initialize(root)
        @root_element = root
      end

      def pooled_resource_edit_link_visible?
        !(locate(:xpath, "//div[contains(@id,'partner_pooled_resources')]/h4/span/a[contains(text(),'Edit')]").nil?)
      end

      def edit_pooled_resource
        pooled_resource_edit_link.click
      end

      def pooled_resurce_inputs_visible?(type)
        items_visible = Hash.new
        if type.include? "Server"
          items_visible["server_quota_input"] = assign_quota_server_input.visible?
          items_visible["server_licenses_input"] = assigned_licenses_server_input.visible?
        end
        if type.include? "Desktop"
          items_visible["desktop_quota_input"] = assign_quota_desktop_input.visible?
          items_visible["desktop_licenses_input"] = assigned_licenses_desktop_input.visible?
        end
        if type.include? "Generic"
          items_visible["generic_quota_input"] = assigned_quota_generic_input.visible?
        end
        items_visible
      end

      def change_pooled_resource(pooled_resource, subpartner=false)
        wait_until_bus_section_load
        expand(account_details_icon)
        pooled_resource_edit_link.click
        pooled_resource.each do |k, v|
          if k.match(/(desktop|server|generic)_(storage|devices)/)
            find(:xpath, "//input[@name='assigned_#{$2}[#{$1.capitalize}]']".gsub('storage', 'quota').gsub('devices', 'licenses')).type_text(v)
          end
        end
        pooled_resource_submit_btn.click
        wait_until_bus_section_load
      end
    end

    def check_fields_visible(array)
      result = []
      array.each{|field|
        result << !(locate(:xpath, "//div[starts-with(@id,'partner-show')]//dl/dt[text()='#{field}']").nil?)
      }
      result
    end

    def check_account_type_change
      !(locate(:xpath, "//a[contains(@onclick,'-acct-type-')][contains(text(),'change')]").nil?)
    end

    def check_sales_channel_change
      !(locate(:xpath, "//a[contains(@onclick,'partner-display-sales-channel')][text()='(change)']").nil?)
    end

    def billing_history_visible?
      !locate(:xpath,"//a[contains(@onclick,'billing-history')]").nil?
    end

    def find_rollback_link
      page.has_xpath?("//*[text()='Rollback to pooled storage']")
    end

    def find_view_in_aria_link
      expand(billing_information_icon)
      page.has_xpath?("//a[text()='View in Aria']")
    end
    #===========================
    # Public : click <act as> link
    #===========================
    def click_act_as_link
      act_as_link.click
      sleep(10)
    end

    private
    def expanded?(element)
      element['class'] == 'icon-chevron-down'
    end

    def collapsed?(element)
      element['class'] == 'icon-chevron-right'
    end

    def expand(element)
      element.click if collapsed?(element)
      wait_until_bus_section_load
    end

    def collapse(element)
      element.click if expanded?(element)
    end

  end
end
