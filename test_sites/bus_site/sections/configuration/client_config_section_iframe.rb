module Bus
  # This class provides actions for add new partner page section
  class ClientConfigIframe < SiteHelper::Iframe

    elements(:existing_config_names, xpath: "//a[contains(@href, '/setting/edit_client_config')]")

    element(:config_name_tb, id: 'config_name')
    element(:config_license_type_id_select, id: 'config_license_type_id')
    element(:next_btn, css: 'div#blank-div>form input[value=Next]')
    element(:cancel_edit_config_btn, xpath:"//div[contains(@id,'edit_client_config')]/ul/li/p/input[@value='Cancel']")
    element(:client_config_save_changes_btn, css: "input[value='Save Changes']")
    element(:message_div, xpath: "//div[@id='setting-edit_client_config-errors']/ul/li")
    element(:warning_div, xpath:"//div/div[@class='warning']")

    # tabs when create config
    element(:preferences_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li")
    element(:scheduling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[2]")
    element(:bandwidth_throttling_tab, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[3]")
    element(:throttle_cb, id: 'throttle_checkbox')
    element(:throttle_amount_tb, id: 'throttle_kbps')
    element(:windows_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[4]")
    element(:mac_backup_sets, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[5]")
    element(:user_groups, xpath: "//div[@id='setting-edit_client_config-tabs']/ul/li[text()='User Groups']")
    element(:add_user_groups, xpath: "//div[@id='config-user-groups']/p[2]/a")
    element(:choose_user_groups, xpath: "//div[@id='config-user-groups']/table/tbody/tr[3]/td/label/input")

    #preferences
    element(:non_ckey_radio, id: "userinfo.allowed_encryption_key_sources.choice")
    element(:ckey_radio, id: 'userinfo.allowed_encryption_key_sources.adminurl')
    element(:ckey_input, id: 'userinfo.encryption_key_url')
    element(:default_key_input, id: "userinfo.allowed_encryption_key_sources.default")
    element(:random_key_input, id: "userinfo.allowed_encryption_key_sources.random")
    element(:private_key_input, id: "userinfo.allowed_encryption_key_sources.custom")
    element(:warning_days_input, id:"options.warning_days")
    element(:warning_days_cascade_input, id:"options.warning_days_cascade")
    element(:warning_days_lock_input, id:"options.warning_days_forced")
    element(:netiftype_input, id: 'options.net_iftype')
    element(:netiftype_onoff_input, id: 'options.net_iftype_onoff')
    element(:webrestores_setting_input, id: 'options.webrestores')
    element(:webrestores_cascade_input, id: 'options.webrestores_cascade')
    element(:enforce_encryption_type_input, id: 'options.enforce_encryption_type')
    element(:enforce_encryption_type_cascade_input, id: 'options.enforce_encryption_type_cascade')
    element(:kmip_radio, id: 'userinfo.allowed_encryption_key_sources.kmip')
    element(:address_input, id: 'userinfo.kmip_kms_address')
    element(:kmip_service_port_input, id: 'userinfo.kmip_kms_port')
    element(:trust_ca_input, id: 'userinfo.kmip_client_cert_issuer')
    element(:nae_xml_service_port_input, id: 'userinfo.kmip_kms_nae_port')
    element(:key_group_name_input, id: 'userinfo.kmip_group_names')
    element(:issuer_help_link, xpath: "//input[@id='userinfo.kmip_client_cert_issuer']/../a")
    element(:issuer_help, id: 'userinfo.kmip_client_cert_issuer_help')
    element(:nae_help_link, xpath: "//input[@id='userinfo.kmip_kms_nae_port']/../a")
    element(:nae_help, id: 'userinfo.kmip_kms_nae_port_help')
    element(:group_name_help_link, xpath: "//input[@id='userinfo.kmip_group_names']/../a")
    element(:group_name_help, id: 'userinfo.kmip_group_names_help')

    # scheduling
    element(:automatic_max_load_input, id: 'scheduling.automatic_max_load')
    element(:max_load_cascade_input, id: 'scheduling.automatic_max_load_cascade')
    element(:max_load_lock_input, id: 'scheduling.automatic_max_load_forced')
    element(:automatic_min_idle_input, id: 'scheduling.automatic_min_idle')
    element(:min_idle_cascade_input, id: 'scheduling.automatic_min_idle_cascade')
    element(:min_idle_lock_input, id: 'scheduling.automatic_min_idle_forced')
    element(:automatic_interval_input, id: 'scheduling.automatic_interval')
    element(:interval_lock_input, id: 'scheduling.automatic_interval_forced')
    element(:interval_cascade_input, id: 'scheduling.automatic_interval_cascade')

    #backup_set
    element(:create_backup_set_link, xpath: "//a[text()='Create Backup Set']")
    element(:backup_name_input, xpath: "//input[@value='New Backup Set']")
    element(:location_exclude_check, xpath: "//label/input[contains(@onclick,'update_linuxset_exclude')]")
    element(:add_search_location_link, xpath: "//a[text()='Add Search Location']")
    element(:done_link, xpath: "//a[text()='Done']")
    element(:cancel_linuxset_link, xpath: "//a[contains(@onclick,'cancel_editing_linuxset')]")
    element(:options_cb, xpath: "//div[@id='editlinuxbackupsetbox']//div//p//label//input")
    element(:linux_rules_name_includes_input, xpath: "//input[@id='filenames_linuxrule']")
    element(:linux_rules_name_excludes_input, xpath: "//input[@id='exclude_filenames_linuxrule']")
    element(:linux_rules_type_includes_input, xpath: "//input[@id='filetypes_linuxrule']")
    element(:linux_rules_type_excludes_input, xpath: "//input[@id='exclude_filetypes_linuxrule']")

    # mac back up set
    element(:mac_set_name_input, xpath: "//tr[8]/td/input[@value='New Backup Set']")

    # mobile rules
    element(:mobile_rule_name_input, xpath: "//tr[8]/td/input[@value='New Mobile Rule']")
    element(:mobile_lock_input, id: "locked_priority")
    element(:mobile_cascade_input, id: "cascade")

    element(:css_input, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[1]/textarea")
    element(:save_changes_btn, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[7]/p/input")

    # Public: Enter name
    #         Select license type
    #         Click next button             git a
    #         Select/deselect throttle
    #
    # @param [Object] client_config
    #
    # Example
    #    @bus_admin_console_page.client_config_section.create_client_config(@client_config,action)
    #
    # @return [nothing]
    def create_edit_client_config(client_config, action)
      if action == 'create a new'
        config_name_tb.type_text(client_config.name)
        config_license_type_id_select.select(client_config.type) unless client_config.type.nil?
        next_btn.click
      else
        wait_until{ find_link(client_config.name).visible? }
        find_link(client_config.name).click
      end

      if !client_config.user_group.nil?
        user_groups.click
        add_user_groups.click
        client_config.user_group.split(',').each_index do |n|
          group_path = "//div[@id='config-user-groups']//label[text()='#{client_config.user_group.split(',')[n]}']/input"
          find(:xpath, group_path).check
        end
      end

      find(:xpath, "//li[text()='Bandwidth Throttling']").click
      if client_config.throttle
        throttle_amount_tb.click unless throttle_cb.checked?
        throttle_amount_tb.type_text(client_config.throttle_amount)
      else
        throttle_cb.click if throttle_cb.checked?
      end
    end

    def edit_preferences_settings config_preferences
      find(:xpath, "//li[text()='Preferences']").click
      if !config_preferences.private_key.nil?
        non_ckey_radio.check
        if config_preferences.private_key == 'only private key'
          default_key_input.uncheck
          random_key_input.uncheck unless all(:id, "userinfo.allowed_encryption_key_sources.random").size == 0
        end
        private_key_input.check
      end

      if !config_preferences.ckey.nil?
        ckey_radio.click
        wait_until{ ckey_input[:disabled].nil? }
        ckey_input.native.clear
        ckey_input.native.send_keys(config_preferences.ckey)
        ckey_input.native.send_keys :enter
      end

      if !config_preferences.default_key.nil?
        non_ckey_radio.check
        if config_preferences.default_key == 'only default key'
          private_key_input.uncheck
          random_key_input.uncheck unless all(:id, "userinfo.allowed_encryption_key_sources.random").size == 0
        end
        default_key_input.check
      end

      if !config_preferences.enforce_encryption_type.nil?
        case config_preferences.enforce_encryption_type
          when "setting"
            enforce_encryption_type_cascade_input.uncheck unless all(:id, "options.enforce_encryption_type_cascade").size == 0
            enforce_encryption_type_input.check
          when "cascade"
            enforce_encryption_type_cascade_input.check
          when "all uncheck"
            enforce_encryption_type_cascade_input.uncheck unless all(:id, "options.enforce_encryption_type_cascade").size == 0
            enforce_encryption_type_input.uncheck
        end
      end

      if !config_preferences.warning_days.nil?
        warning_days_input.type_text(config_preferences.warning_days.split(":")[0])
        if config_preferences.warning_days.split(":").size > 1
          case config_preferences.warning_days.split(":")[1]
            when 'cascade'
              warning_days_cascade_input.check
            when 'lock'
              warning_days_cascade_input.uncheck unless all(:id, "options.warning_days_cascade").size == 0
              warning_days_lock_input.check
            when 'cascade uncheck'
              warning_days_cascade_input.uncheck
            when 'lock uncheck'
              warning_days_cascade_input.uncheck unless all(:id, "options.warning_days_cascade").size == 0
              warning_days_lock_input.uncheck
          end
        end
      end

      if !config_preferences.net_iftype.nil?
        netiftype_onoff_input.check
        wait_until{ netiftype_input.visible? }
        netiftype_input.type_text config_preferences.net_iftype
      end

      if !config_preferences.web_restores.nil?
        case config_preferences.web_restores
          when 'setting'
            webrestores_setting_input.check
            webrestores_cascade_input.uncheck if all(:id, 'options.webrestores_cascade').size > 0
          when 'cascade'
            webrestores_cascade_input.check
          when 'all uncheck'
            webrestores_setting_input.uncheck
            webrestores_cascade_input.uncheck if all(:id, 'options.webrestores_cascade').size > 0
        end
      end

      if !config_preferences.all_settings.nil?
        all(:xpath, "//tr/td[1]/input[contains(@id,'options')]").each do |obj|
          if !obj[:id].include?("warning_days") & obj["disabled"].nil? & obj.visible?
            if config_preferences.all_settings == 'check'
              obj.check
              if obj[:id] == 'options.net_iftype_onoff'
                wait_until { netiftype_input.visible? }
                net_iftype_value = config_preferences.net_iftype || "test net iftype"
                netiftype_input.type_text net_iftype_value
              end
            else
              obj.uncheck
            end
          end
        end
      end

      if !config_preferences.all_cascades.nil?
        all(:xpath, "//tr/td[2]/input[contains(@id,'cascade')]").each do |obj|
          if obj["disabled"].nil? & obj.visible?
            if config_preferences.all_cascades == 'check'
              obj.check
              if obj[:id] == 'options.net_iftype_cascade'
                netiftype_onoff_input.check
                wait_until { netiftype_input.visible? }
                net_iftype_value = config_preferences.net_iftype || "test net iftype"
                netiftype_input.type_text net_iftype_value
              end
            else
              obj.uncheck
            end
          end
        end
      end

      if !config_preferences.kmip_key.nil?
        kmip_radio.click
        wait_until{ address_input[:disabled].nil? }
        address_input.native.clear
        address_input.native.send_keys(config_preferences.address)
        address_input.native.send_keys :enter

        kmip_service_port_input.native.clear
        kmip_service_port_input.native.send_keys(config_preferences.kmip_service_port)
        kmip_service_port_input.native.send_keys :enter

        trust_ca_input.native.clear
        trust_ca_input.native.send_keys(config_preferences.trust_ca)
        trust_ca_input.native.send_keys :enter

        nae_xml_service_port_input.native.clear
        nae_xml_service_port_input.native.send_keys(config_preferences.nae_xml_service_port)
        nae_xml_service_port_input.native.send_keys :enter

        key_group_name_input.native.clear
        key_group_name_input.native.send_keys(config_preferences.key_group_name)
        key_group_name_input.native.send_keys :enter
      end
    end

    def is_existing_client_config(config_name)
      found_configs = existing_config_names
      found_configs.each do |found_config|
        if config_name == found_config.text
          return true
        end
      end
      false
    end

    def edit_scheduling_settings client_config
      find(:xpath, "//li[text()='Scheduling']").click
      if !client_config.automatic_max_load.nil?
        if client_config.automatic_max_load.include?(":")
          automatic_max_load_value = client_config.automatic_max_load.split(":")[0]
          automatic_max_load_check = client_config.automatic_max_load.split(":")[1]
          if automatic_max_load_check == 'lock'
            max_load_cascade_input.uncheck unless all(:id, "scheduling.automatic_max_load_cascade").size == 0
            max_load_lock_input.check
          elsif automatic_max_load_check == 'cascade'
            max_load_cascade_input.check
          elsif automatic_max_load_check == 'lock uncheck'
            max_load_cascade_input.uncheck unless all(:id, "scheduling.automatic_max_load_cascade").size == 0
            max_load_lock_input.uncheck
          elsif automatic_max_load_check == 'cascade uncheck'
            max_load_cascade_input.uncheck
          end
        else
          automatic_max_load_value = client_config.automatic_max_load
        end
        automatic_max_load_input.type_text automatic_max_load_value
      end

      if !client_config.automatic_min_idle.nil?
        if client_config.automatic_min_idle.include?(":")
          automatic_min_idle_value = client_config.automatic_min_idle.split(":")[0]
          automatic_min_idle_check = client_config.automatic_min_idle.split(":")[1]
          if automatic_min_idle_check == 'lock'
            min_idle_cascade_input.uncheck unless all(:id, 'scheduling.automatic_min_idle_cascade').size == 0
            min_idle_lock_input.check
          elsif automatic_min_idle_check == 'cascade'
            min_idle_cascade_input.check
          elsif automatic_min_idle_check == 'lock uncheck'
            min_idle_cascade_input.uncheck unless all(:id, 'scheduling.automatic_min_idle_cascade').size == 0
            min_idle_lock_input.uncheck
          elsif automatic_min_idle_check == 'cascade uncheck'
            min_idle_cascade_input.uncheck
          end
        else
          automatic_min_idle_value = client_config.automatic_min_idle
        end
        automatic_min_idle_input.type_text automatic_min_idle_value
      end

      if !client_config.automatic_interval.nil?
        automatic_interval_value = client_config.automatic_interval
        if client_config.automatic_interval.include?(":")
          automatic_interval_value = client_config.automatic_interval.split(":")[0]
          automatic_interval_check = client_config.automatic_interval.split(":")[1]
          if automatic_interval_check == 'lock'
            interval_cascade_input.uncheck unless all(:id, 'scheduling.automatic_interval_cascade').size == 0
            interval_lock_input.check
          elsif automatic_interval_check == 'cascade'
            interval_cascade_input.check
          elsif automatic_interval_check == 'lock uncheck'
            interval_cascade_input.uncheck unless all(:id, 'scheduling.automatic_interval_cascade').size == 0
            interval_lock_input.uncheck
          elsif automatic_interval_check == 'cascade uncheck'
            interval_cascade_input.uncheck
          end
        end
        # delete existing values from field.. does not use node.clear as this trigger onchange event..
        automatic_interval_input.native.send_keys("\b#{automatic_interval_value}")
      end
    end

    def remove_group_from_config(group_name)
      add_user_groups.click if add_user_groups.visible?
      user_group1_xpath = "//div[@id='config-user-groups']//label[text()='#{group_name}']/input"
      find(:xpath, user_group1_xpath).uncheck
    end

    def save_client_configs
      client_config_save_changes_btn.click
    end

    def open_link name
      wait_until{ find_link(name).visible? }
      find_link(name).click
    end

    def cancel_edit_client_config
      cancel_edit_config_btn.click
    end

    def copy_client_config (old_config_name,new_config_name)
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//a[text()='Copy']").click
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//input[@id='copy_name']").type_text(new_config_name)
      find(:xpath, "//td/a[text()='#{old_config_name}']/../../td//input[@value='Submit']").click
    end

    def get_client_config_group (config_name)
      find(:xpath, "//td/a[text()='#{config_name}']/../../td[3]").text
    end

    def click_tab(tab_name)
      find(:xpath, "//li[text()='#{tab_name}']").click
    end

    def create_backup_lnk_visible
      create_backup_set_link.visible?
    end

    def backup_set_name_visible(backup_name)
      all(:xpath, "//table//b[text()='#{backup_name}']").size
    end

    def set_linux_backup_name(name)
      create_backup_set_link.click
      backup_name_input.type_text(name)
    end

    def check_exclusionary(check)
      if check
        location_exclude_check.check
      else
        location_exclude_check.uncheck
      end
    end

    def get_exclusionary
     location_exclude_check.checked?
    end

    def click_edit_backup_set(backup_name)
      find(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='view/edit']").click
    end

    def edit_linux_backup_exsit(backup_name)
      all(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='view/edit']").size
    end

    def delete_linux_backup(backup_name)
      find(:xpath, "//label//b[text()='"+backup_name+"']//..//..//a[text()='Delete']").click
      alert_accept
    end

    def backup_name_visible(backup_name)
      find(:xpath,"//input[@value='#{backup_name}']").visible?
    end

    def add_locations(locations)
      locations.each_index do |n|
        find(:xpath, "//div[@id='linuxfsitems']//select["+(n+1).to_s+"]").select(locations[n]['location types'])
        find(:xpath, "//input[@id='linuxfsitem_"+n.to_s+"']").type_text(locations[n]['folder names'])
        if n<(locations.size-1)
          add_search_location_link.click if all(:xpath, "//div[@id='linuxfsitems']//select["+(n+2).to_s+"]").size == 0
        end
      end
    end

    def get_search_locations
      all_types_objs = all(:xpath, "//div[@id='linuxfsitems']//select")
      search_locations = []
      all_types_objs.each_index do |n|
        types_obj = find(:xpath, "//div[@id='linuxfsitems']//select["+(n+1).to_s+"]")
        locations_obj = find(:xpath, "//input[@id='linuxfsitem_"+n.to_s+"']")
        if types_obj.value == '1'
          search_locations << {'location types' => 'Include', 'folder names' => locations_obj.value}
        else
          search_locations << {'location types' => 'Exclude', 'folder names' => locations_obj.value}
        end
      end
      search_locations
    end

    def delete_location(location)
      index = find(:xpath, "//input[@value='#{location}']")[:id].split('_')[1]
      find(:xpath, "//a[contains(@onclick,'remove_linuxfsitem(#{index})')]").click
    end

    def add_linux_backup_rules(rules)
      linux_rules_name_includes_input.type_text(rules['name includes']) unless rules['name includes'].nil?
      linux_rules_name_excludes_input.type_text(rules['name excludes']) unless rules['name excludes'].nil?
      linux_rules_type_includes_input.type_text(rules['type includes']) unless rules['type includes'].nil?
      linux_rules_type_excludes_input.type_text(rules['type excludes']) unless rules['type excludes'].nil?
    end

    def get_linux_backup_rules()
      rules = {
          "name includes" => linux_rules_name_includes_input.value,
          "name excludes" => linux_rules_name_excludes_input.value,
          "type includes" => linux_rules_type_includes_input.value,
          "type excludes" => linux_rules_type_excludes_input.value
      }
      rules
    end

    def lock_cascade_setting_linux_backup(backup_hash)
      if backup_hash['action'] == 'check'
        find(:xpath, "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input").check
      else
        find(:xpath, "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input").uncheck
      end
    end

    def lock_cascade_setting_linux_backup_disabled?(backup_hash)
      wait_until{find(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input").visible?}
      find(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input")['disabled']
    end

    def lock_cascade_setting_linux_backup_checked?(backup_hash)
      if(all(:xpath, "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input").size >0)
        action_xpath = "//table//b[text()='#{backup_hash['backup name']}']/../../td[#{backup_hash['index']}]/input"
      else
        action_xpath = "//label/b[text()='#{backup_hash['backup name']}']/../../../td[#{backup_hash['index']}]/input"
      end
      find(:xpath, action_xpath).checked?
    end

    def click_done
      done_link.click
    end

    def cancel_edit_linuxset
      cancel_linuxset_link.click
    end

    def alert_accept
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.accept
      else
        raise("alert_accept method only works for Selenium Driver")
      end
    end

    # Public: Messages for client configuration section
    #
    # Example
    #  @bus_admin_console_page.client_configuration_section.messages
    #  # => "Your configuration was saved."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Select config
    #         Click delete config link
    #         Accept confirmation
    #
    # @param [String] client_config
    #
    # Example
    #    @bus_admin_console_page.client_config_section.delete_client_config("smoke_desktop_config")
    #
    # @return [nothing]
    def delete_client_config(client_config)
      page.find(:xpath, "//a[text()='#{client_config}']").click
      page.find(:xpath, "//a[text()='Delete Config']").click
      alert_accept
    end

    def css_header_color_hex
      color_hex_list = ["#FAEBD7", "#00FFFF", "#8A2BE2", "#FF1493"]
      color_hex = color_hex_list[rand(4)]
      puts color_hex
      header_hex = ".content-header{ background-color: " + color_hex +";}"
      footer_hex = ".footer{ background-color: " + color_hex +";}"
      css_input.type_text(header_hex)
      puts "---input----"
      css_input.type_text(footer_hex)
      sleep 3
    end

    def click_save_changes
      save_changes_btn.click
      sleep 5
    end

    def get_all_presetting_value
      setting_values = []
      all(:xpath, "//tr/td[1]/input[contains(@id,'options')]").each do |obj|
        if !obj[:id].include?("warning_days") & obj["disabled"].nil? & obj.visible?
          setting_values << obj.checked?
        end
      end
      setting_values
    end

    def get_all_precascade_value value_type
      cascade_values = []
      all(:xpath, "//tr/td[2]/input[contains(@id,'cascade')]").each do |obj|
        case value_type
          when 'checked'
            if obj.visible?
              cascade_values << obj.checked?
            end
          when 'unchecked'
            if obj.visible? & obj["disabled"].nil?
              cascade_values << obj.checked?
            end
        end
      end
      cascade_values
    end

    def get_all_prelock_value value_type
      lock_values = []
      all(:xpath, "//tr/td[3]/input[contains(@id,'forced')]").each do |obj|
        case value_type
          when 'checked'
            if obj.visible?
              lock_values << obj.checked?
            end
          when 'unchecked'
            if obj.visible? & obj["disabled"].nil?
              lock_values << obj.checked?
            end
        end
      end
      lock_values
    end

    def get_warning_days_settings
      warning_days_settings = {
          'warning days' => warning_days_input.value,
          'warning days disabled' => warning_days_input[:disabled] || false,
          'warning days lock' => warning_days_lock_input.checked?,
          'warning days lock disabled' => warning_days_lock_input[:disabled] || false
      }
      if all(:id, 'options.warning_days_cascade').size > 0
        warning_days_settings['warning days cascade'] = warning_days_cascade_input.checked?
        warning_days_settings['warning days cascade disabled'] = warning_days_cascade_input[:disabled] || false
      end
      warning_days_settings
    end

    def get_automatic_max_load_values
      automatic_max_load_values = {
          'max setting' => automatic_max_load_input.value,
          'max lock' => max_load_lock_input.checked?,
          'max setting disabled' => automatic_max_load_input[:disabled] || false,
          'max lock disabled' => max_load_lock_input[:disabled] || false
      }
      if all(:id, "scheduling.automatic_max_load_cascade").size > 0
        automatic_max_load_values['max cascade'] = max_load_cascade_input.checked?
        automatic_max_load_values['max cascade disabled'] = max_load_cascade_input[:disabled] || false
      end
      automatic_max_load_values
    end

    def get_automatic_min_idle_values
      automatic_min_idle_values = {
          'min setting' => automatic_min_idle_input.value,
          'min lock' => min_idle_lock_input.checked?,
          'min setting disabled' => automatic_min_idle_input[:disabled] || false,
          'min lock disabled' => min_idle_lock_input[:disabled] || false
      }
      if all(:id, "scheduling.automatic_min_idle_cascade").size > 0
        automatic_min_idle_values['min cascade'] = min_idle_cascade_input.checked?
        automatic_min_idle_values['min cascade disabled'] = min_idle_cascade_input[:disabled] || false
      end
      automatic_min_idle_values
    end

    def get_automatic_interval_values
      automatic_interval_values = {
          'interval setting' => automatic_interval_input.value,
          'interval lock' => interval_lock_input.checked?,
          'interval setting disabled' => automatic_interval_input[:disabled] || false,
          'interval lock disabled' => interval_lock_input[:disabled] || false
      }
      if all(:id, "scheduling.automatic_interval_cascade").size > 0
        automatic_interval_values['interval cascade'] = interval_cascade_input.checked?
        automatic_interval_values['interval cascade disabled'] = interval_cascade_input[:disabled] || false
      end
      automatic_interval_values
    end

    def get_warning
      warning_div.text
    end

    def create_mac_backup mac_backup_set
      find_link("Create Backup Set").click
      mac_set_name_input.type_text mac_backup_set['mac backup set name']
      find_link("Done").click
    end

    def create_mobile_rules mobile_rules
      find_link("Create new Mobile Rule").click
      mobile_rules_name = mobile_rules.mobile_rules_name || "New Mobile Rule"
      mobile_rule_name_input.type_text mobile_rules_name

      if !mobile_rules.locking.nil?
        case mobile_rules.locking
          when "lock"
            mobile_cascade_input.uncheck if all(:id, "cascade").size > 0
            mobile_lock_input.check
          when "cascade"
            mobile_cascade_input.check
          when "all uncheck"
            mobile_cascade_input.uncheck if all(:id, "cascade").size > 0
            mobile_lock_input.uncheck
        end
      end

      find_link("Done").click
    end

    def get_mobile_rules_locking
      rules_locking = { "mobile rules lock" => mobile_lock_input.checked? }
      rules_locking["mobile rules cascade"] = mobile_cascade_input.checked? if all(:id, "cascade").size > 0
      rules_locking
    end

    def encryption_key_cascade_visible?
      size = all(:xpath, "//input[@id='userinfo.allowed_encryption_key_sources_cascade']").size
      (size > 0)? true:false
    end

    def get_web_restores
      web_restores = { "web restores setting" => webrestores_setting_input.checked? }
      web_restores["web restores cascade"] = webrestores_cascade_input.checked? if all(:id, 'options.webrestores_cascade').size > 0
      web_restores
    end

    def enforce_encryption_type_visible?
      enforce_encryption_type_input.visible?
    end

    def get_ckey
      ckey = {
          "is ckey" => ckey_radio.checked?,
          "ckey url" => ckey_input.value
      }
      ckey
    end

    def get_non_ckey
      non_ckey = {
          "is default key" => default_key_input.checked?,
          "is private key" => private_key_input.checked?
      }
      non_ckey["is random key"] = random_key_input.checked? unless all(:id, "userinfo.allowed_encryption_key_sources.random").size == 0
      non_ckey
    end

    def get_enforce_encryption_type
      enforce_encryption_type = { "setting" => enforce_encryption_type_input.checked? }
      enforce_encryption_type["cascade"] = enforce_encryption_type_cascade_input.checked? unless all(:id, "options.enforce_encryption_type_cascade").size == 0
      enforce_encryption_type
    end

    def get_kmip
      kmip = {
          "is kmip" => kmip_radio.checked?,
          "address" => address_input.value,
          "KMIP service port" => kmip_service_port_input.value,
          "Trust CA" => trust_ca_input.value,
          "NAE-XML service port" => nae_xml_service_port_input.value,
          "Key group name" => key_group_name_input.value,
      }
      kmip
    end

    def issuer_help_icon_text
      issuer_help_link.text
    end

    def click_issuer_icon
      issuer_help_link.click
    end

    def issuer_help_messages
      issuer_help.text
    end

    def nae_help_icon_text
      nae_help_link.text
    end

    def click_nae_icon
      nae_help_link.click
    end

    def nae_help_messages
      nae_help.text
    end

    def group_name_help_icon_text
      group_name_help_link.text
    end

    def click_group_name_icon
      group_name_help_link.click
    end

    def group_name_help_messages
      group_name_help.text
    end
  end
end
