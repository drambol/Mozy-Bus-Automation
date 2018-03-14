module Bus
  # This class manage all sections for bus admin console page
  class AdminConsolePage < SiteHelper::Page

    set_url("#{QA_ENV['bus_host']}/dashboard")

    # Partner section
    section(:search_list_partner_section, SearchListPartnerSection, id: "partner-list")
    section(:add_new_partner_section, AddNewPartnerSection, id: "partner-new")
    section(:add_itemized_partner_section, AddItemizedPartnerSection, id: "partner-new-content")

    section(:partner_details_section, PartnerDetailsSection, css: "div[id^=partner-show-]")
    section(:admin_details_section, AdminDetailsSection, css: "div[id^=admin-show-]")

    # Configuration section
    section(:account_details_section, AccountDetailsSection, id: "setting-edit_account_settings")
    section(:authentication_policy_section, AuthenticationPolicySection, id: 'authentication_policies-edit')
    section(:client_config_section, ClientConfigSection, id: 'setting-edit_client_config')
    section(:add_new_pro_plan_section, AddNewProPlanSection, id: 'plan-pro_new')
    section(:edit_password_policy_section, EditPasswordPolicySection, id: 'setting-edit_password_policy')
    section(:edit_client_version_section, EditClientVersionSection, id: 'setting-edit_client_version')
    section(:network_domain_section, NetworkDomainSection, id: 'setting-netdomains_list-content')
    section(:data_retention_section, DataRetentionSection, id: 'setting-adr_status')
    section(:data_retention_section_popup, DataRetentionSectionPopup, id: 'popup-body')
    section(:blocked_deprovision, BlockedDeprovision, id: 'authentication_policies-blocked_deprovisions')

    # Users section
    section(:search_list_users_section, SearchListUsersSection, id: 'user-list')
    section(:search_list_itemized_users_section, SearchListItemizedUsersSection, id: 'user-list-content')
    section(:search_list_machines_section, SearchListMachinesSection, id: 'machine-list')
    section(:user_group_list_section, UserGroupListSection, id: 'user_groups-list')
    section(:add_new_user_group_section, AddEditUserGroupSection, id: 'user_groups-new')
    section(:add_new_itemized_user_group_section, AddEditItemizedUserGroupSection, id: 'user_groups-new-content')
    section(:edit_user_group_section, AddEditUserGroupSection, css: 'div[id^=user_groups-edit_storage_pool_policy-]')
    section(:add_new_user_section, AddNewUserSection, id: 'user-new_users_in_batch')
    section(:add_new_itemized_user_section, AddNewItemizedUserSection, id: 'user-new-content')
    section(:machine_mapping_section, MachineMappingSection, id: 'machine-machine_migration')
    section(:user_group_details_section, UserGroupDetailsSection, css: 'div[id^=user_groups-show-]')
    section(:list_user_groups_section, ListUserGroupsSection, id: 'user_groups-list')
    section(:user_details_section, UserDetailsSection, css: 'div[id^=user-show]')
    section(:machine_details_section, MachineDetailsSection, css: 'div[id^=machine-show-]')
    section(:replace_machine_section, ReplaceMachineSection, id: 'inner-content')

    # Admin section
    section(:add_new_role_section, AddNewRoleSection, id: "roles-new")
    section(:edit_role_section, EditRoleSection, css: "div[id^=roles-show]")
    section(:add_new_admin_section, AddNewAdminSection, id: "admin-new")
    section(:search_admins_section, SearchAdminsSection, id: "admin-search")
    section(:list_admins_section, ListAdminsSection, id: 'admin-list')
    section(:role_details_section, RoleDetailsSection, css: "div[id^=roles-show-]")
    section(:list_roles_section, ListRolesSection, id: "roles-list")

    # Resources section
    section(:change_plan_section, ChangePlanSection, id: "resource-change_billing_plan")
    section(:change_payment_info_section, ChangePaymentInfoSection, id: "resource-change_credit_card")
    section(:billing_history_section, BillingHistorySection, id: "resource-all_charges")
    section(:billing_info_section, BillingInfoSection, css: "div[id^=resource-billing]")#id: "resource-billing"
    section(:change_period_section, ChangePeriodSection, id: "resource-change_billing_period")
    section(:manage_resources_section, ManageResourcesSection, id: "resource-available_key_list")
    section(:manage_user_group_resources_section, ManageUserGroupResourcesSection , css: "div[id^=resource-group_available_keys-]")
    section(:transfer_resources_section, TransferResourcesSection, id: "resource-transfer_resources")
    section(:purchase_resources_section, PurchaseResourcesSection, id: "resource-purchase_resources")
    section(:return_resources_section, ReturnResourcesSection, id: "resource-unpurchase_resources")
    section(:assign_keys_section, AssignKeysSection, id: "resource-available_key_list")
    section(:resource_summary_section, ResourceSummarySection, id: 'storage-summary')
    section(:download_client_section, DownloadClientSection, id: "resource-downloads")

    # assign keys group
    section(:assign_keys_group_section, AssignKeysGroupSection, css: "div[id^=resource-group_available_keys-]")

    # Data shuttle section
    section(:data_shuttle_status_section, DataShuttleStatusSection, id: 'resource-data_shuttle_status')
    section(:order_data_shuttle_section, OrderDataShuttleSection, id: 'resource-choose_pro_partner_for_new_seed')
    section(:process_order_section, ProcessOrderSection, css: 'div[id^=resource-create_new_seed-].start-closed')
    section(:view_data_shuttle_orders_section, ViewDataShuttleOrdersSection, id: 'resource-view_seed_device_orders')
    section(:order_details_section, OrderDetailsSection, css: 'div[id^=resource-show_data_shuttle_order-]')

    section(:device_status_section, DeviceStatusSection, css: 'div[id^=resource-show_data_shuttle_device_status-]')
    section(:device_stuck_section, DeviceStuckSection, css: 'div[id^=resource-show_data_shuttle_device_status-]')
    section(:inventory_status_section, InventoryStatusSection, css: 'div[id^=resource-show_drive_inventory_status-]')

    # reports section
    section(:report_builder_section, ReportBuilderSection, id: "jobs-report_builder")
    section(:add_report_section, AddReportSection, id: "jobs-new")
    section(:edit_report_section, EditReportSection, xpath: "//div[starts-with(@module_url,'/jobs/edit')]")
    section(:scheduled_reports_section, ScheduledReportsSection, id: "jobs-index")
    section(:quick_reports_section, QuickReportsSection, id: "jobs-quick_reports")
    section(:list_email_alerts_section, ListEmailAlertsSection, xpath: "//div[@id='alerts-list']")
    section(:new_email_alerts_section, NewEmailAlertsSection, xpath: "//div[@id='alerts-new']")
    section(:show_email_alerts_section, ShowEmailAlertsSection, xpath: "//div[starts-with(@id,'alerts-show')]")

    # backup client section
    section(:create_new_version_section, CreateNewVersionSection, id: "version-new")
    section(:list_versions_section, ListVersionsSection, id: "version-list")
    section(:version_show_section, VersionShowSection, css: 'div[id^=version-show-]')
    section(:upgrade_rules_section, UpgradeRulesSection, id: 'version-rules')


    # Branding
    section(:branding_section, BrandingSection, xpath: "//li[@id='nav-cat-site_branding']/ul/li[4]/a")
    #section(:footer_branding_section, BrandingSection, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[1]/li[3]")
    #iframe(:css_iframe, CSSIframe, :id, 'site_branding-webrestore_site-content')
    section(:dialect_section, DialectListSection, id: 'dialect-list')
    section(:smtp_settings_section, SMTPSettingsSection, id: 'email_template-smtp')

    # support section
    section(:contact_section, ContactSection, xpath: "//a[text()='Contact']")

    # internal tools
    section(:manage_vatfx_rates_section, ManageVATTXRatesSection, id: "internal-add_vat_rate")
    section(:manage_pending_deletes_section, ManagePendingDeletesSection, id: "internal-manage_pending_deletes")
    section(:manage_ldap_connectors_section, ManageLDAPConnectorsSection, id: "internal-manage_ldap_connectors")
    section(:add_new_version_section, AddNewVersionSection, id: "internal-create_ldap_connector")
    section(:transaction_summary_section, TransactionSummarySection, id: "internal-revenue")
    section(:add_new_promotion_section, AddNewPromotionSection, id: "promotion-new")
    section(:list_promotions_section, ListPromotionsSection, id: "promotion-list")
    section(:promotion_details_view_section, PromotionDetailsViewSection, css: 'div[id^=promotion-show-]')
    section(:add_account_attribute_key_section, AddAccountAttributeKeySection, id: 'internal-add_attribute')
    section(:list_account_attribute_keys_section, ListAccountAttributeKeysSection, id: 'internal-list_attributes')
    section(:account_attribute_key_details_section, AccountAttributeKeyDetailsSection, id: 'internal-edit_attribute')
    section(:partner_signups_report_section, PartnerSignupsReportSection, id: 'internal-partner_signups')
    section(:manage_internal_jobs_section, ManageInternalJobsSection, id: 'internal-manage_jobs')

    #news
    section(:news_section, NewsSection, id: "controller-news")


    # Private element
    element(:message_div, xpath: "//div[@class='dunning_msg'][@style='']")
    element(:current_admin_div, id: 'identify-me')
    element(:current_admin_name_link, xpath: "//div[@id='identify-me']/a[last()]")
    element(:stop_masquerading_link, xpath: "//a[text()='stop masquerading']")
    element(:quick_link_item, id: "nav-cat-quick")

    # Popup window
    element(:start_using_mozy_btn, id: "start_using_mozy")
    element(:chk_show_welcome_chkbox, id: "chk_show_welcome")
    element(:quick_start_guide, xpath:"//p[text()='Quick Start Guide']")
    #element(:download_mozy_software, xpath:"//p[text()='             Download Mozy Software           ']")
    element(:download_mozy_software, xpath:"//p[contains(text(), 'Download Mozy Software')]")
    element(:release_notes, xpath:"//p[text()='Release Notes']")
    element(:popup_content_div, css: "div.popup-window-content")
    element(:close_popup_link, css: "div.close_bar a")
    element(:close_btn, css: "div.popup-window-footer input[value=Close]")
    element(:continue_btn, css: "div.popup-window-footer input[value=Continue]")
    element(:cancel_btn, css: "div.popup-window-footer input[value=Cancel]")
    element(:submit_btn, css: "div.popup-window-footer input[value=Submit]")
    element(:buy_more_btn, css: "div.popup-window-footer input[value='Buy More']")
    element(:allocate_resources_btn, css: "div.popup-window-footer input[value=Allocate]")
    element(:ok_btn, css: "div.popup-window-footer input[value=Ok]")
    element(:yes_btn, css: "div.popup-window-footer input[value=Yes]")
    element(:no_btn, css: "div.popup-window-footer input[value=No]")
    element(:msg_popup_text, css: "div.popup-window-content")
    elements(:delete_popup_btns, css: "div.popup-window-footer input")
    element(:welcome_page_title, xpath: "//div[@class='headlinePositionDiv']")

    # Activate element
    element(:password_set_text, id: 'admin_password')
    element(:password_set_again_text, id: 'admin_password_confirmation')
    element(:continue_activate_btn, xpath: "//input[@name='commit']")
    element(:go_to_account_link, xpath: "//a[text()='Go To Account']")

    # global navigate links
    element(:dashboard_link, xpath: "//ul[@id='global-nav-links']//a[@href='/dashboard']")

    # partner name in the right top corner
    element(:partner_top_link, xpath: "//div[@id='identify-me']/a[1]")

    # partner co-branding image in left top corner
    element(:top_img, xpath: "//div[@id='top']//img")

    # list capabilities section
    element(:list_capabilities_table, xpath: "//div[@id='capabilities-list-content']//table")


    def get_partner_name_topcorner
      wait_until{partner_top_link.visible?}
      partner_top_link.text
    end

    def partner_id
      find(:xpath, "//div[@id='identify-me']/a[1]")[:href][/partner-show-(\d+)/, 1]
    end

    def dimiss_start_using_mozy
      start_using_mozy_btn.click if has_start_using_mozy_btn?
      alert_accept if alert_present?
    end

    def click_start_using_mozy
      wait_until { popup_content_div.visible? }
      start_using_mozy_btn.click if has_start_using_mozy_btn?
      alert_accept if alert_present?
    end

    def check_show_welcome_chkbox
      wait_until { chk_show_welcome_chkbox.visible? }
      chk_show_welcome_chkbox.check unless chk_show_welcome_chkbox.checked?
    end

    def poped_up_window
      found = false
      current = Time.now
      begin
        while Time.now < current + CONFIGS['global']['default_wait_time']
          found = popup_content_div.visible?
          if !found
            break
          end
          sleep 3
        end
      rescue => e
        puts e
        found = false
      end
    end

    def check_specific_element(type)
      wait_until { popup_content_div.visible? }
      case type
        when 'Admin Features'
          find(:xpath, "//a[contains(text(),'Admin Features')]")[:href] == 'http://support.mozy.com/AdminConsoleNewFeatures?type=Itemized'
          Log.debug 'check Admin Features'
        when 'File Sync'
          find(:xpath, "//a[contains(text(),'File Sync')]")[:href] == 'http://support.mozy.com/articles/en_US/New_Feature/MozyEnterprise-Sync'
          Log.debug 'check File Sync'
        when 'Quick Start Guide'
          all(:css, "p.firstRunFooterSpans")[0].element_parent[:href] == 'http://support.mozy.com/articles/en_US/documentation/admin-quickstart-a-en'
          Log.debug 'check Quick Start Guide'
        when 'Download Mozy Software'
          all(:css, "p.firstRunFooterSpans")[1].element_parent[:href] == '/resource?module=resource-downloads'
          Log.debug 'check Download Mozy Software'
        when 'Release Notes'
          all(:css, "p.firstRunFooterSpans")[2].element_parent[:href] == 'http://support.mozy.com/articles/en_US/documentation/admin-release-notes-current-admin-en'
          Log.debug 'check Release Notes'
      end
    end
    # Public: Navigate to menu item on admin console page
    # Note: if bus module is opened, menu will not be clicked
    #
    # @link_name          [String] link name
    # @use_quick_link     [Boolean] click link in Quick Links if link exists
    #
    # @return [nothing]
    def navigate_to_menu(link_name, use_quick_link = false)
      #log("Dimiss <Start User Mozy> dialog if exists.")
      dimiss_start_using_mozy
      # Looking for link in navigation menu
      find(:xpath, "//ul//a[text()='#{link_name}']")

      navigate_first_try_start_time = 0
      navigate_first_try_end_time = 0
      navigate_second_try_start_time = 0
      navigate_second_try_end_time = 0

      # calling all method does not require to wait
      navigate_first_try_start_time = Time.now.utc
      log("Navigate start, first try start time:#{navigate_first_try_start_time}")
      links = all(:xpath, "//ul//a[text()='#{link_name}']")
      el = use_quick_link ? links.first : links.last
      if links.first.element_parent[:class].match(/active/).nil? && links.last.element_parent[:class].match(/active/).nil?
        el.click
        alert_accept if alert_present?
      end
      begin
        wait_loading_complete
        navigate_first_try_end_time = Time.now.utc
        log("Navigate complete, start time:#{navigate_first_try_start_time}/end time:#{navigate_first_try_end_time}") if navigate_first_try_end_time != 0
      rescue Capybara::TimeoutError
        #workaround for navigate to menu loading timeout
        #if loading didn't complete within timeout, click 'DASHBOARD' to reload page then navigate again
        dashboard_link.click
        wait_loading_complete
        navigate_second_try_start_time = Time.now.utc
        log("First navigate timeout, second try start time:#{navigate_second_try_start_time}")
        links = all(:xpath, "//ul//a[text()='#{link_name}']")
        el = use_quick_link ? links.first : links.last
        if links.first.element_parent[:class].match(/active/).nil? && links.last.element_parent[:class].match(/active/).nil?
          el.click
          alert_accept if alert_present?
        end
        wait_loading_complete
        navigate_second_try_end_time = Time.now.utc
        log("Navigate complete, start time:#{navigate_second_try_start_time}/end time:#{navigate_second_try_end_time}") if navigate_second_try_end_time != 0
      end
    end


    def wait_loading_complete
      # Make sure the destination section loaded correctly for further use in following steps
      find(:css, 'h2 a[onclick^=toggle_module]')
      sections = all(:css, 'h2 a[onclick^=toggle_module]')
      sections.each do |s|
        unless s[:class].nil?
          wait_until{ s[:class].match(/loading/).nil? }
        end
      end
    end

    # Public: Stop Masquerading
    #
    # Returns nothing
    def stop_masquerading
      dimiss_start_using_mozy
      current_admin = current_admin_div.text
      stop_masquerading_link.click
      log("right top text before stop masquerading is:#{current_admin}")
      Log.debug("right top text before stop masquerading is:#{current_admin}")
      log("clicked stop masquerading")
      Log.debug("clicked stop masquerading")
      3.times do
        sleep 3
        if current_admin != current_admin_div.text
          log("right top text is: #{current_admin_div.text}")
          Log.debug("right top text is: #{current_admin_div.text}")
          sleep 2
          if current_admin != current_admin_div.text
            log("right top text is: #{current_admin_div.text}")
            Log.debug("right top text is: #{current_admin_div.text}")
            log('stop masquerading success')
            Log.debug('stop masquerading success')
            break
          else
            log('right top text did not keep same in 2 seconds, will retry in 3 seconds')
            Log.debug('right top text did not keep same in 2 seconds, will retry in 3 seconds')
          end
        else
          log('right top text has not changed, will retry in 3 seconds')
          Log.debug('right top text has not changed, will retry in 3 seconds')
        end
      end
    end

    # Public: Get partner id from top admin identification div
    #
    #
    def current_partner_id
      current_admin_div.find(:css, 'a:first-child')[:href].match(/partner-show-(\d+)&/)[1]
    end

    def has_navigation?(link)
      alert_accept if alert_present?
      !all('a', :text => link).empty?
    end

    def has_content?(content)
      alert_accept if alert_present?
      page.has_content?(content)
    end

    def close_stash_invitation_popup
      find_link("Don't Show This Again").click
    end

    def popup_window_content
      popup_content_div.text
    end

    def close_popup_window
      close_popup_link.click
    end

    def buy_more_resources
      buy_more_btn.click
    end

    def allocate_resources
      allocate_resources_btn.click
    end

    def click_close
      close_btn.click
    end

    def click_continue
      continue_btn.click
    end

    def click_cancel
      cancel_btn.click
    end

    def click_no
      no_btn.click
    end

    def click_submit
      submit_btn.click
    end

    def click_ok
      ok_btn.click
    end

    def click_yes
      yes_btn.click
    end

    def get_popup_msg
      msg_popup_text.text
    end

    def get_popup_buttons
      delete_popup_btns.map{|btn|btn[:value]}
    end

    # user/partner verification section
    # code here relates to
    # partner/user verification
    def open_partner_details_from_header(partner)
      partner_created(partner)
      go_to_partner_info(partner)
    end

    def open_account_details_from_header(admin_name = nil)
      dimiss_start_using_mozy
      if current_admin_name_link.text.strip =='stop masquerading'
        if admin_name.nil?
          # for act as admin
          link = find(:xpath, "//div[@id='identify-me']/a[2]")
        else
          link = find(:xpath, "//div[@id='identify-me']/a[text()='#{admin_name}']")
        end
      else
        # for act as admin, then click admin link
        link = current_admin_name_link
      end
      # for the  error: element is not clickable at point xxx
      begin
        link.click
      rescue
        alert_accept if alert_present?
      end
      alert_accept if alert_present?
    end

    # pro section
    # code here relates
    # to mozypro related items
    def partner_created(partner)
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      dimiss_start_using_mozy
      if defined?(partner.company_info)
        find_link(partner.company_info.name).present?
      else
        find_link(partner.company_name).present?
      end

    end

    def go_to_partner_info(partner)
      if defined?(partner.company_info)
        find_link(partner.company_info.name).click
      else
        find_link(partner.company_name).click
      end
    end

    def visit_skeletor_url
      url = find('div.dashboard-graphs img')[:src]
      visit url
      using_wait_time 2 do
        fail('Skeletor not working') if page.has_css?('div#dashboard-e-content')
      end
    end

    def get_top_image_url
      find('#top a img')[:src]
    end

    def download_top_image(download_file_name)
      page.execute_script(
          "(function(name){
               link=$$('#top a')[0];
               img=$$('#top a img')[0];
               link.writeAttribute('href', img.readAttribute('src'));
               link.writeAttribute('download',name);
               link.click();
            }
           )('"+download_file_name+"')"
      )
    end

    def download_backup_image(download_file_name)
      dimiss_start_using_mozy
      page.execute_script(
          "(function(name){
              var link=document.createElement('a');
              document.getElementsByClassName('pie-chart')[0].appendChild(link);
              img=$$('.pie-chart img')[0];
              link.writeAttribute('href', img.readAttribute('src'));
              link.writeAttribute('download',name);
              link.click();
            }
           )('"+download_file_name+"')"
      )
    end

    def open_admin_activate_page(admin_link)
      visit admin_link
    end

    def set_admin_password (password)
      password_set_text.type_text(password)
      password_set_again_text.type_text(password)
      sleep 3
      continue_activate_btn.click
    end

    def go_to_account
      go_to_account_link.click
      dimiss_start_using_mozy
    end

    def get_list_capabilities
      list_capabilities_table.raw_text
    end

    def check_capabilities_linkable
      (list_capabilities_table.all(:xpath, "//td[2]/a").size > 0)? true:false
    end

    def get_new_window_page_title()
      page.execute_multiline_script('return window.stop')
      page.driver.browser.title
    end

    # Public: Dunning Messages
    #
    # Example
    #   admin_console_page.messages
    #   # => "Your account is past due - Please update your billing information to avoid any interruption in service."
    #
    # Returns true
    def dunning_message(t, msg)
      if t.nil?
        wait_until {message_div.visible?}
        message_div.text.strip.match msg
      else
        all(:xpath, "//div[@class='dunning_msg'][@style='']").empty?
      end
    end

    #================================================
    # Public : click Download Mozy Software link when acting as a partner, should navigator to Mozy Software Download section automatically.
    #================================================
    def click_download_link_on_welcome_page
      Log.debug "LogQA : click Download Mozy Software link on welcome page"
      download_mozy_software.click
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      init = false
      i = 0
      while init == false && i < 3
        begin
          find(:id, "resource-downloads")
          init = true
          Log.debug "LogQA : =======find Mozy Download section"
        rescue
          Log.debug "LogQA : =======doesn't find Mozy Download section"
        end
        i = i + 1
        sleep(10)
      end
    end

    #=======================
    # Public : return the welcome page titile, which usual should be "What's New"
    # Others : in the current code, we use alert_accept as a workaround to close the pop-up window. Find method won't work since the element in cache
    #          has been locked before the pop-up window appears. Add the method.
    #=======================
    def get_welcome_page_title
      welcome_page_title.text
    end

    def click_dashboad_link
      dashboard_link.click
    end

    def get_dashboard_link_text
      dashboard_link.text
    end

  end
end
