module Bus
  # This class provides actions for add new partner page section
  class AddNewPartnerSection < SiteHelper::Section

    # Private elements
    #
    elements(:flash_errors, xpath: "//div[@id='partner-new-errors']/ul/li")
    element(:cvv2_what_is_this, xpath: "//a[contains(@onclick, 'cvv2help')]")
    element(:cvv2_help, xpath: "//div[@id='cvv2help']/h3")
    element(:cvv2_close, xpath: "//a[text()='(click to close)']")

    # Company Info
    #
    element(:new_partner_name_tb, id: 'new_partner_name')
    element(:contact_country_select, id: 'partner_new_contact_country')
    element(:contact_country_selected, xpath: "//select[@id='partner_new_contact_country']/option[@selected='selected']")
    element(:contact_state_tb, id: 'partner_new_contact_state')
    element(:contact_state_us_select, id: 'partner_new_contact_state_us')
    element(:contact_state_ca_select, id: 'partner_new_contact_state_ca')
    element(:contact_city_tb, id: 'contact_city')
    element(:contact_address_tb, id: 'contact_address')
    element(:contact_zip_tb, id: 'contact_zip')
    element(:contact_phone_tb, id: 'contact_phone')
    element(:vat_number_tb, id: 'vat_info_vat_number')
    element(:security_select, id: 'security_requirement')
    elements(:security_select_options, xpath: "//select[@id='security_requirement']//option")
    element(:security_tooltip, xpath: "//select[@id='security_requirement']/../img[contains(@src,'tooltip')]")
    element(:subpartner_company_type_select, id: 'company_type')

    # Admin info
    #
    element(:new_admin_display_name_tb, id: 'new_admin_display_name')
    element(:new_admin_username_tb, id: 'new_admin_username')
    element(:root_role_td, id: 'root-role-options')
    element(:root_role_select, id: 'root_role_id')

    # Partner Info
    element(:parent_partner_select, id: 'parent_partner_id')
    element(:company_type_select, id: 'extended_company_type')
    element(:create_under_txt, id: 'parent_partner_options')
    element(:coupon_code_tb, id: 'coupon_code')
    element(:plan_loading_div, id: 'plan_loading')

    # Account Detail
    element(:account_type_select, id: 'acct_type')
    element(:sales_origin_select, id: 'sales_origin')
    element(:sales_channel_select, id: 'sales_channel')

    # Billing Info
    element(:use_company_info_cb, id: 'use_company_info')
    element(:cc_address_tb, id: 'cc_address')
    element(:cc_country_select, id: 'cc_country')
    element(:cc_state_tb, id: 'cc_state')
    element(:cc_state_us_select, id: 'cc_state_us')
    element(:cc_state_ca_select, id: 'cc_state_ca')
    element(:cc_city_tb, id: 'cc_city')
    element(:cc_email_tb, id: 'cc_email')
    element(:cc_phone_tb, id: 'cc_phone')
    element(:cc_zip_tb, id: 'cc_zip')

    elements(:period_radios, css: 'div#initial_purchase_options dt input')
    elements(:period_labels, css: 'div#initial_purchase_options dt label')
    element(:initial_purchase_options, id: 'initial_purchase_options')
    element(:include_initial_purchase_cb, id: 'include_initial_purchase')
    element(:pre_sub_total_label, id: 'init_sub_total')
    element(:next_btn, id: 'next-button')

    # Order summary
    element(:order_summary_table, css: 'div#order-summary table')

    # Credit Card Info
    #
    element(:cc_name_tb, id: 'cc_name')
    element(:cc_no_tb, id: 'cc_no')
    element(:cvv_tb, id: 'cvv')
    element(:cc_exp_mm_select, id: 'cc_exp_mm')
    element(:cc_exp_yyyy_select, id: 'cc_exp_yyyy')

    element(:cc_payment_input, id: 'formOfPaymentCC')
    element(:net_term_payment_input, id: 'formOfPaymentNT')

    element(:message_div, css: 'div#partner-new-errors ul')
    element(:aria_errors_div, css: 'ul.errorExplanation')
    element(:create_partner_btn, css: 'div#cc-details input#submit_button')
    element(:back_btn, id: 'back_button')

    # sub partner
    element(:create_sub_partner_btn, id: 'non_aria_billing_partner_create')
    element(:pricing_plan_select, id: 'pro_plan_id')

    # Public: Add a new partner account
    #
    # Example
    #   add_new_partner_section.add_new_account(partner_object)
    #
    # Returns nothing
    def add_new_account(partner)
      fill_company_info(partner.company_info)
      fill_partner_admin_info(partner.partner_info, partner.admin_info)
      fill_account_detail(partner.account_detail)
      fill_billing_info(partner)

      create_partner_start_time = 0
      create_partner_end_time = 0
      d = 0

      # define master plan subscription period
      fill_subscription_period(partner.subscription_period)

      if partner.has_initial_purchase
        fill_initial_purchase(partner)
        set_pre_sub_total(partner)
        next_btn.click
        if !flash_errors[0].nil?
          Log.info "Error when adding a new partner: " + flash_errors[0].text
          return
        end
        wait_time = CONFIGS['global']['max_wait_time']
        wait_until(wait_time) do
          back_btn.visible?  # wait for fill credit card info
        end
        if partner.net_term_payment
          net_term_payment_input.click
          if alert_present?
            partner.billing_info.alert = alert_text
            alert_accept
          end
        else
          cc_payment_input.click
          fill_credit_card_info(partner.credit_card)
        end
        set_order_summary(partner)
        if partner.credit_card.cvv2 == 'true'
          cvv2_what_is_this.click
          cvv2_help.text.should == 'What is the CVV2 code?'
          cvv2_close.click
        end

        wait_until { !locate(:css, "div#cc-details input#submit_button").nil? && create_partner_btn.visible? && create_partner_btn['disabled'] != 'true' }
        3.times do
          create_partner_start_time = Time.now.utc
          create_partner_btn.click
          sleep(2)
          if create_partner_btn['disabled'] == 'true'
            break
          end
        end
        wait_until { create_partner_btn['disabled'] == 'true' }
        wait_until { create_partner_btn['disabled'] != 'true' }
        create_partner_end_time = Time.now.utc
      else
        include_initial_purchase_cb.uncheck
        set_pre_sub_total(partner)
        create_partner_start_time = Time.now.utc
        next_btn.click
        create_partner_end_time = Time.now.utc
      end
      log("KPI-Create_New_Partner:start_time:#{create_partner_start_time}/end_time:#{create_partner_end_time}")
    end

    def select_company_type(company_type)
      company_type_select.select(company_type)
      wait_until_plans_loaded(company_type)
    end
    # Public: Messages for change account details actions
    #
    # Example
    #   add_new_partner_section.messages
    #   # => "New partner created."
    #
    # Returns success or error message text
    def messages
      wait_until { !locate(:css, "div#partner-new-errors ul").nil? }
      message_div.text
    end

    # Public: Messages for credit card payment errors
    #
    # Example
    #   add_new_partner_section.aria_errors
    #   # => "Could not validate payment information"
    #
    # Returns error message text
    def aria_errors
      aria_errors_div.text
    end

    # Public: Messages for adding new account errors
    #
    # Example
    #   add_new_partner_section.aria_errors
    #   # => "Could not validate payment information"
    #
    # Returns error message text
    def add_account_errors
      flash_errors[0].text
    end

    # Public: Order Summary Hashes
    #         Converts Order summary table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    # Example:
    #  @bus_admin_console_page.add_new_partner_section.order_summary_hashes
    #
    # Returns hash array
    def order_summary_hashes
      order_summary_table.rows_text.map{ |row| Hash[order_summary_table.headers_text.zip(row)] }
    end

    # Public: Add new partner subscription period labels text
    #
    # Example
    #   add_new_partner_section.available_periods("MozyPro")
    #   # => ["Monthly", "Yearly", "Biennially"]
    #
    # Returns period labels text
    def available_periods(type)
      company_type_select.select(type)
      wait_until_plans_loaded(type)
      period_labels.map{ |ele| ele.text}
    end

    # Returns security options
    def available_security_options
      security_select_options.collect { |option| option.text }
    end

    def get_security_default_value
      security_select.find("option[selected]").text
    end

    def get_security_tooltip
      security_tooltip[:'data-tooltip']
    end

    def get_vmbu_tooltip(partner)
      base_plan_id = ""
      case partner.partner_info.type
        when CONFIGS['bus']['company_type']['mozypro']
          base_plan_id = find_with_highlight(:id, "#{partner.subscription_period}_base_plan_select").value
        when CONFIGS['bus']['company_type']['mozyenterprise']
          base_plan_id = find(:id, "#{partner.subscription_period}_base_plan_id").value
        when CONFIGS['bus']['company_type']['reseller']
          inputs = all(:xpath, "//div[@id='base_plan_section_#{partner.subscription_period}']/div/div/input")
          case partner.reseller_type
            when CONFIGS['bus']['reseller_type']['silver']
              base_plan_id = inputs[0].value
            when CONFIGS['bus']['reseller_type']['gold']
              base_plan_id = inputs[2].value
            when CONFIGS['bus']['reseller_type']['platinum']
              base_plan_id = inputs[4].value
            else
              raise "Unable to find reseller type of #{partner.reseller_type}"
          end
        else
          raise "Unable to find partner type of #{partner.partner_info.type}"
      end
      find_with_highlight(:xpath, "//div[@id='add_on_plan_section_#{base_plan_id}']/div[2]/img")[:'data-tooltip']
    end

    def fill_company_type(partner_type)
      company_type_select.select(partner_type)
      wait_until_plans_loaded(partner_type)
    end

    def fill_subscription_period(period)
      el = find(:id, "billing_period_#{period}")
      wait_until { el.visible? && el.enabled? }
      el.click
    end

    def fill_initial_purchase(partner)
      case partner.partner_info.type
        when CONFIGS['bus']['company_type']['mozypro']
          fill_mozypro_purchase(partner)
        when CONFIGS['bus']['company_type']['mozyenterprise']
          raise('MozyEnterprise parent partner error') unless create_under_txt.text.eql?('(Creating under MozyEnterprise)')
          fill_mozyenterprise_purchase(partner)
        when CONFIGS['bus']['company_type']['mozyenterprise_dps']
          raise('MozyEnterprise DPS parent partner error') unless create_under_txt.text.eql?('(Creating under MozyEnterprise)')
          fill_mozyenterprise_dps_purchase(partner)
        when CONFIGS['bus']['company_type']['reseller']
          fill_reseller_purchase(partner)
        else
          raise "Unable to find partner type of #{partner.partner_info.type}"
      end
    end

    def check_mozyenterprise_dps_plan
      user_plan = !(locate(:xpath,"//label[contains(text(),'MozyEnterprise User')]").nil?)
      storage_plan = !(locate(:xpath,"//label[contains(text(),'TB - MozyEnterprise DPS')]").nil?)
      server_addon_plan = !(locate(:xpath,"//label[contains(text(),'250 GB Server Add-on')]").nil?)
      [user_plan,storage_plan,server_addon_plan]
    end

    def rate_schedule_present
      !(locate(:xpath, "//*[contains(text(),'Rate Schedule')]").nil?)
    end

    private

    def fill_company_info(company_info)
      new_partner_name_tb.type_text(company_info.name)

      if company_info.country.eql?('United States')
        contact_state_us_select.select(company_info.state_abbrev)
      else
        contact_country_select.select(company_info.country)
        contact_state_tb.type_text(company_info.state)
        vat_number_tb.type_text(company_info.vat_num) if company_info.vat_num != ""
      end
      contact_address_tb.type_text(company_info.address)
      contact_city_tb.type_text(company_info.city)
      contact_zip_tb.type_text(company_info.zip)
      security_select.select(company_info.security) if company_info.security != ""
      contact_phone_tb.type_text(company_info.phone)
    end

    def fill_partner_admin_info(partner_info, admin_info)
      company_type_select.select(partner_info.type)
      wait_until_plans_loaded(partner_info.type)
      # for script execute on windows
      unless RUBY_PLATFORM.include?('linux') then
        sleep 2
      end
      # MozyEnterprise is for US only
      unless [CONFIGS['bus']['company_type']['mozyenterprise'], CONFIGS['bus']['company_type']['mozyenterprise_dps']].include? partner_info.type
        parent_partner_select.select(partner_info.parent)
        # for script execute on windows
        unless RUBY_PLATFORM.include?('linux') then
          sleep 2
        end
      end

      wait_until_plans_loaded(partner_info.type)

      coupon_code_tb.type_text(partner_info.coupon_code) unless partner_info.coupon_code.nil?
      new_admin_display_name_tb.type_text(admin_info.full_name)
      new_admin_username_tb.type_text(admin_info.email)
      root_role_select.select(admin_info.root_role) if root_role_select.visible?
    end

    def fill_account_detail(account_detail)
      account_type_select.select(account_detail.account_type)
      sales_origin_select.select(account_detail.sales_origin)
      sales_channel_select.select(account_detail.sales_channel)
    end

    def fill_billing_info(partner)
      if partner.use_company_info
        use_company_info_cb.check
      else
        cc_address_tb.type_text(partner.billing_info.address)
        cc_city_tb.type_text(partner.billing_info.city)
        cc_country_select.select(partner.billing_info.country)
        if alert_present?
          partner.billing_info.alert = alert_text
          alert_accept
        end
        if partner.billing_info.country.eql?('United States')
          cc_state_us_select.select(partner.billing_info.state_abbrev)
        elsif partner.billing_info.country.eql?('Canada')
          cc_state_ca_select.select(partner.billing_info.state_abbrev)
        else
          cc_state_tb.type_text(partner.billing_info.state)
        end
        cc_zip_tb.type_text(partner.billing_info.zip)
        cc_email_tb.type_text(partner.billing_info.email)
        cc_phone_tb.type_text(partner.billing_info.phone)
      end

    end

    def fill_mozypro_purchase(partner)
      base_plan_select = find_with_highlight(:id, "#{partner.subscription_period}_base_plan_select")
      base_plan_select.select(partner.base_plan)
      base_plan_id = base_plan_select.value

      #{base plan id}_add_on_plan_check_box_1 is stash beta grant id
      if partner.has_stash_grant_plan
        stash_grant_id = find_with_highlight(:id, "#{base_plan_id}_add_on_plan_check_box_1").value
        find_with_highlight(:id, "#{base_plan_id}_add_on_plan_check_box_#{stash_grant_id}").check
      end

      #{base plan id}_add_on_plan_check_box_2 is serer plan id
      if partner.has_server_plan
        server_plan_id = find(:id, "#{base_plan_id}_add_on_plan_check_box_1").value
        find_with_highlight(:id, "#{base_plan_id}_add_on_plan_check_box_#{server_plan_id}").check
      end

      # storage add on option for base plan >= 1 TB
      if partner.storage_add_on.to_i != 0
        #add_on = find_with_highlight(:xpath, "//input[starts-with(@id,'#{base_plan_id}')][contains(@id,'add_on_plan_1035')]")
        # replace the code if running on staging
        add_on = find_with_highlight(:xpath, "//input[starts-with(@id,'#{base_plan_id}')][contains(@id,'add_on_plan_103')]")
        add_on.clear_value
        add_on.type_text(partner.storage_add_on)
      end

      # 50 GB storage add on option for base plan between 100 GB and 500 GB
      if partner.storage_add_on_50_gb.to_i != 0
        add_on = find_with_highlight(:xpath, "//input[starts-with(@id,'#{base_plan_id}')][contains(@id,'add_on_plan_11')]")
        add_on.clear_value
        add_on.type_text(partner.storage_add_on_50_gb)
      end
    end

    def fill_mozyenterprise_purchase(partner)
      # Find base plan id from hidden input
      base_plan_id = find(:id, "#{partner.subscription_period}_base_plan_id").value
      # Base plan number of users
      num_user = find_with_highlight(:id, "#{partner.subscription_period}_base_plan_#{base_plan_id}")
      num_user.clear_value
      num_user.type_text(partner.num_enterprise_users)

      # Server add ons select list
      find_with_highlight(:id, "#{base_plan_id}_add_on_plan_select").select(partner.server_plan)

      # Find server add on id from hidden input
      server_add_on_id = find(:id, "#{base_plan_id}_add_on_plan_1").value

      storage_add_on_input = find_with_highlight(:id, "#{base_plan_id}_add_on_plan_#{server_add_on_id}")
      storage_add_on_input.clear_value
      storage_add_on_input.type_text(partner.num_server_add_on)
    end

    def fill_mozyenterprise_dps_purchase(partner)
      base_plan_input = find(:css, "input[id^='#{partner.subscription_period}_base_plan'][type=text]")
      base_plan_input.clear_value
      base_plan_input.type_text(partner.base_plan)
    end

    def fill_reseller_purchase(partner)
      inputs = all(:css, "div#base_plan_section_#{partner.subscription_period} div div input")
      case partner.reseller_type
        when CONFIGS['bus']['reseller_type']['silver']
          inputs[0].click # Silver plan
          base_plan_id = inputs[0].value
          inputs[1].clear_value
          inputs[1].type_text(partner.reseller_quota) # Silver plan quota
        when CONFIGS['bus']['reseller_type']['gold']
          inputs[2].click # Gold plan
          base_plan_id = inputs[2].value
          inputs[3].clear_value
          inputs[3].type_text(partner.reseller_quota) # Gold plan quota
        when CONFIGS['bus']['reseller_type']['platinum']
          inputs[4].click # Platinum plan
          base_plan_id = inputs[4].value
          inputs[5].clear_value
          inputs[5].type_text(partner.reseller_quota) # Platinum plan quota
        else
          raise "Unable to find reseller type of #{partner.reseller_type}"
      end

      #{base plan id}_add_on_plan_check_box_1 is stash beta grant id
      if partner.has_stash_grant_plan
        stash_grant_id = find(:id, "#{base_plan_id}_add_on_plan_check_box_1").value
        find_with_highlight(:id, "#{base_plan_id}_add_on_plan_check_box_#{stash_grant_id}").check
      end

      #{base plan id}_add_on_plan_check_box_1 is serer plan id
      if partner.has_server_plan
        server_plan_id = find(:id, "#{base_plan_id}_add_on_plan_check_box_1").value
        find_with_highlight(:id, "#{base_plan_id}_add_on_plan_check_box_#{server_plan_id}").check
      end

      # Num of storage add ons
      if partner.reseller_add_on_quota.to_i > 0
        add_on = find_with_highlight(:xpath, "//div[@id='add_on_plan_text']/input[3]")
        add_on.clear_value
        add_on.type_text(partner.reseller_add_on_quota)
      end
    end

    def fill_credit_card_info(credit_card)
      cc_name_tb.type_text("#{credit_card.first_name} #{credit_card.last_name}")
      cc_no_tb.type_text(credit_card.number)
      cvv_tb.type_text(credit_card.cvv)
      cc_exp_mm_select.select(credit_card.expire_month)
      cc_exp_yyyy_select.select(credit_card.expire_year)
    end

    def set_pre_sub_total(partner)
      # Click initial purchase twice, force re-calculate the price, make sure price gets update
      if partner.has_initial_purchase
        include_initial_purchase_cb.click
        sleep 1
        include_initial_purchase_cb.click
        # When the next button is clicked before the panel is finished loading
        # it causes the cc auth to hang, when update is slow many test failures happen.
        wait_until{pre_sub_total_label.text!="0"}
      end
      # Since I don't know how long the ajax call will return, I set 2 seconds wait here
      # possible refactor here, remove sleep method
      sleep 2
      partner.pre_sub_total = pre_sub_total_label.text.strip
    end

    def set_order_summary(partner)
      partner.order_summary = order_summary_hashes
    end

    def wait_until_plans_loaded(type)
      case type
        when CONFIGS['bus']['company_type']['mozypro']
          role = CONFIGS['bus']['root_role']['mozypro']
        when CONFIGS['bus']['company_type']['mozyenterprise']
          role = CONFIGS['bus']['root_role']['mozyenterprise']
        when CONFIGS['bus']['company_type']['mozyenterprise_dps']
          role = CONFIGS['bus']['root_role']['mozyenterprise']
        when CONFIGS['bus']['company_type']['reseller']
          role = CONFIGS['bus']['root_role']['reseller']
        else
          raise 'Unknown company type'
      end
      wait_until{ !root_role_td.text.match(role).nil? }
      wait_until{ !plan_loading_div.visible? }
    end

    public
    def billing_country
      cc_country_select.value
    end

    def add_new_subpartner(partner)
      Log.debug "sub partner name #{partner.company_name}"
      new_partner_name_tb.type_text(partner.company_name)
      partner.instance_variable_defined?('@pricing_plan') && pricing_plan_select.select(partner.pricing_plan) unless pricing_plan_select['type'] == 'hidden'
      partner.instance_variable_defined?('@root_role') && root_role_select.select(partner.root_role) unless root_role_select['type'] == 'hidden'
      partner.security && security_select.select(partner.security) unless all(:id, 'security_requirement').empty?
      partner.company_type && subpartner_company_type_select.select(partner.company_type) unless all(:id, 'company_type').empty?
      new_admin_display_name_tb.type_text(partner.admin_name)
      new_admin_username_tb.type_text(partner.admin_email_address)
      create_sub_partner_btn.click
    end

    def verify_default_country
      contact_country_selected.text
    end
  end
end
