module Bus
  # This class provides actions for add new partner page section
  class UpgradeRulesIframe < SiteHelper::Iframe

    element(:create_new_rule_link, xpath: "//a[text()='Create New Rule']")
    element(:rule_save_btn, xpath: "//input[@value='Save Changes']")

    # element for the new added rule line
    element(:rule_version_select, xpath: "//select[@name='rn_version_id[]']")
    element(:version_min_input, xpath: "//input[@name='rn_check_requesting_ver_min[]']")
    element(:version_max_input, xpath: "//input[@name='rn_check_requesting_ver_max[]']")
    element(:version_required_select, xpath: "//select[@name='rn_install_required[]']")
    element(:os_min_input, xpath: "//input[@name='rn_check_os_ver_min[]']")
    element(:os_max_input, xpath: "//input[@name='rn_check_os_ver_max[]']")
    element(:arch_input, xpath: "//input[@name='rn_check_architecture[]']")
    element(:rule_enabled_select, xpath: "//select[@name='rn_is_enabled[]']")
    element(:install_command_input, xpath: "//input[@name='rn_install_command[]']")
    # element for confirm window when creating force rule
    element(:admin_password_input, xpath: "//div[@class='popup-window-content']//input[@name='password']")
    element(:admin_password_confirm_btn, xpath: "//div[@class='popup-window-footer']//input[@value='Submit']")

    # element for save upgrade rules website error in qa6
    element(:website_error_div, id: 'dashboard-e-content')

    # Public: input admin password to confirm creating force rule
    #
    def confirm_change_upgrade_rule
      if alert_present?
        alert_accept
        Log.debug "alert show up when add/change upgrade rules"
        admin_password_input.set(QA_ENV['bus_password'])
        admin_password_confirm_btn.click
      end
    end

    # Public: add a new rule in Upgrade Rules iframe
    #
    def add_new_rule(rule)
      create_new_rule_link.click
      rule_version_select.select(rule['version name'])
      version_min_input.type_text(rule['min version']) if rule.has_key?('min version')
      version_max_input.type_text(rule['max version']) if rule.has_key?('max version')
      os_min_input.type_text(rule['min os']) if rule.has_key?('min os')
      os_max_input.type_text(rule['max os']) if rule.has_key?('max os')
      arch_input.type_text(rule['Arch']) if rule.has_key?('Arch')
      install_command_input.type_text(rule['Install CMD']) if rule.has_key?('Install CMD')
      version_required_select.select(rule['Req?']) if rule.has_key?('Req?')
      rule_enabled_select.select(rule['On?']) if rule.has_key?('On?')
      rule_save_btn.click
      confirm_change_upgrade_rule
    end

    # Public: get first rule detail info of the given version_name in Upgrade Rules iframe
    #
    def get_rule(version_name)
      has_rule, rule_number = rule_exists?(version_name)

      rule_version_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'version_id')]"
      version_min_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'check_requesting_ver_min')]"
      version_max_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'check_requesting_ver_max')]"
      version_required_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'install_required')]"
      rule_enabled_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'is_enabled')]"
      install_command_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'install_command')]"

      rule = {}
      rule['version name'] = find(:xpath, rule_version_select).first_selected_option.text
      rule['min version'] = find(:xpath, version_min_input).value
      rule['max version'] = find(:xpath, version_max_input).value
      rule['Install CMD'] = find(:xpath, install_command_input).value
      rule['Req?'] = find(:xpath, version_required_select).first_selected_option.text
      rule['On?'] = find(:xpath, rule_enabled_select).first_selected_option.text
      rule
    end

    # Public: modify rule of the first given version_name in Upgrade Rules iframe
    #
    def edit_rule(version_name, rule)
      has_rule, rule_number = rule_exists?(version_name)

      rule_version_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'version_id')]"
      version_min_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'check_requesting_ver_min')]"
      version_max_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'check_requesting_ver_max')]"
      version_required_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'install_required')]"
      rule_enabled_select = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//select[contains(@name, 'is_enabled')]"
      install_command_input = "//tbody[@id='version_rules_tbody']//tr[#{rule_number[0]}]//input[contains(@name,'install_command')]"

      find(:xpath, rule_version_select).select(version_name) if rule.has_key?('version name')
      find(:xpath, version_min_input).type_text(rule['min version']) if rule.has_key?('min version')
      find(:xpath, version_max_input).type_text(rule['max version']) if rule.has_key?('max version')
      find(:xpath, install_command_input).type_text(rule['Install CMD']) if rule.has_key?('Install CMD')
      find(:xpath, version_required_select).select(rule['Req?']) if rule.has_key?('Req?')
      find(:xpath, rule_enabled_select).select(rule['On?']) if rule.has_key?('On?')
      rule_save_btn.click
      confirm_change_upgrade_rule
    end

    # Public: determine if a rule with specified version name exists in Upgrade Rules
    # If rule exists, return true and array of rule line numbers
    # If not, return false and empty array
    def rule_exists?(version_name)
      has_rule = false
      rule_number = []
      rule_size = all(:xpath, "//tbody[@id='version_rules_tbody']//tr").size
      row = 1
      while row <= rule_size do
        rule_version_name = find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{row}]//td[1]//select[1]").first_selected_option.text
        if rule_version_name == version_name
          has_rule = true
          rule_number << row
        end
        row = row + 1
      end

      return has_rule, rule_number
    end

    # Public: delete rule according to rule version name and rule lines in upgrade rule lists
    #
    def delete_rule(version_name, rule_lines)
      rule_lines.reverse!
      for line in rule_lines
        find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{line}]//td[last()]//b").click if version_name == find(:xpath, "//tbody[@id='version_rules_tbody']//tr[#{line}]//td[1]//select[1]").first_selected_option.text
      end
      rule_save_btn.click
    end

    # Public: check if upgrade rules can select given version_name as rule version
    #
    def upgrade_version_contain?(version_name)
      create_new_rule_link.click
      rule_version_select.text.include?(version_name)
    end

  end

end
