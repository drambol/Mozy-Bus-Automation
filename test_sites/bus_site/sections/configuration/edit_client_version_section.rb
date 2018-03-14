module Bus
  # This class provides actions for edit client version section
  class EditClientVersionSection < SiteHelper::Section

    # Private elements
    #

    # elements for Partner without edit user group capability
    element(:no_eugc_rule, xpath: "//fieldset")
    element(:set_default_txt, xpath: "//p")
    element(:rule_updated_txt, css: "ul.flash.successes li")


    # elements for Partner with edit user group capability
    element(:version_rule_table, css: "table.table-view")
    element(:upgrade_to_select, id: "client_version_id")
    element(:current_version_select, id: "version_range")
    element(:version_min_input, id: "check_requesting_ver_min")
    element(:version_max_input, id: "check_requesting_ver_max")
    element(:user_group_select, id: "version_user_group_id")
    element(:os_min_select, id: "check_os_ver_min")
    element(:os_max_select, id: "check_os_ver_max")
    element(:required_cb, id: "install_required")
    element(:install_command_select, id: "install_command")
    element(:submit_button, xpath: "//input[@value='Submit']")

    # functions for Partner without edit user group capability
    #
    #

    # Public: check whether rule fieldset contains specific text
    #
    def fieldset_contain_rule?(keyword)
      no_eugc_rule.text.include?(keyword)
    end

    # Public: message note above rule fieldset
    #
    def set_default_message
      set_default_txt.text
    end

    # Public: check whether an arch can choose specific version in rule fieldset
    #
    def rule_has_option?(version,arch)
      find(:xpath, "//fieldset//select[@id='desired_client_version_#{arch}']").options_text.include?(version)
    end

    # Public: return rules hash (arch => version)
    #
    def upgrade_rules_hash
      rule_hash = {}
      rule_size = all(:xpath, "//fieldset//div").size
      number=1
      while number <= rule_size do
        key = find(:xpath, "//fieldset//div[#{number}]//label").text
        value = find(:xpath, "//fieldset//div[#{number}]//select").first_selected_option.text
        rule_hash[key] = value
        number = number + 1
      end

      rule_hash
    end

    # Public: update one rule by selecting a version of the arch
    #
    def update_rule(version, arch)
      find(:xpath, "//fieldset//select[@id='desired_client_version_#{arch}']").select(version)
    end

    # Public: message when rule fieldset is updated
    #
    def rule_updated_message
      rule_updated_txt.text
    end


    # functions for Partner with edit user group capability
    #
    #

    # Public: add a new rule in edit client version section
    # If selected upgrade to version is windows, then OS >=, OS <=, install command can be selected
    #
    def add_new_rule(rule)
      upgrade_to_select.select(rule['Update To']) if rule.has_key?('Update To')

      if rule.has_key?('Current Version >=') && rule.has_key?('Current Version <=')
        current_version_select.select('Between')
        version_min_input.type_text(rule['Current Version >='])
        version_max_input.type_text(rule['Current Version <='])
      elsif rule.has_key?('Current Version >=')
        current_version_select.select('>=')
        version_min_input.type_text(rule['Current Version >='])
      elsif rule.has_key?('Current Version <=')
        current_version_select.select('<=')
        version_max_input.type_text(rule['Current Version <='])
      end

      user_group_select.select(rule['User Group']) if rule.has_key?('User Group')
      os_min_select.select(rule['OS >=']) if rule.has_key?('OS >=')
      os_max_select.select(rule['OS <=']) if rule.has_key?('OS <=')
      required_cb.check if rule['Required'] == 'Yes'
      install_command_select.select(rule['Install Command']) if rule.has_key?('Install Command')
      submit_button.click

    end

    # Public: delete rule of the given version name
    #
    def delete_rule(version)
      rule_size = all(:xpath, "//table[@class='table-view']//tbody//tr").size
      row = rule_size
      while row >= 1 do
        if find(:xpath, "//table[@class='table-view']//tbody//tr[#{row}]//td[1]").text == version && locate(:xpath, "//table[@class='table-view']//tbody//tr[#{row}]//td[last()]//a[text()='Remove']")
          find(:xpath, "//table[@class='table-view']//tbody//tr[#{row}]//td[last()]//a[text()='Remove']").click
        end
        row = row - 1
      end
    end

    # Public: get the table hash of Client Version Rules
    #
    def client_version_rules_hash
      first_header = version_rule_table.headers_text
      second_header_and_body = version_rule_table.rows_text
      second_header_and_body[0].insert(0, first_header[0])
      second_header_and_body[0].insert(-1, first_header[-1])
      second_header_and_body.map { |row| Hash[*second_header_and_body[0].zip(row).flatten]}
    end

    # Public: check whether Client Version Rules contains a version
    #
    def rules_contain_version?(version)
      version_rule_table.text.include?(version)
    end

    # Public: check whether update to select can select a version
    #
    def upgrade_to_contain_version?(version)
      upgrade_to_select.text.include?(version)
    end

    # Public: select a version in update to selector
    #
    def select_version(version)
      upgrade_to_select.select(version)
    end

    # Public: get OS selector options
    #
    def os_options(type)
      if type == 'min' && os_min_select.visible?
        os_min_select.options_text
      elsif type == 'max' && os_max_select.visible?
        os_max_select.options_text
      end
    end

    # Public: get user group selector options
    #
    def user_group_options
      user_group_select.options_text
    end

  end

end

