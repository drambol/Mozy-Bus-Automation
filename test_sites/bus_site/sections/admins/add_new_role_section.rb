module Bus
  # This class provides actions for add new role section
  class AddNewRoleSection < SiteHelper::Section
    element(:role_select, id: "role_subpartner_role")
    element(:name_tb, id: "role_name")
    element(:role_parent_select, id: "role_parent_role_id")
    element(:message_div, css: 'div#roles-new-errors ul')

    element(:submit_btn, xpath: "//div[@id='roles-new-content']//input[contains(@value, 'Save Changes')]")
    element(:role_user_group_input, xpath: "//td[@id='preferred_parent_user_group_id_div']//input[@type='text']")
    elements(:role_user_group_search_value, xpath: "//div[contains(@id,'auto_complete')]//li")
    element(:role_user_group_search_button, xpath: "//td[@id='preferred_parent_user_group_id_div']/span")

    # Public: Add a new role with given role object information
    #
    # role_obj - role object with role information
    #
    # Example
    #   @bus_admin_console_page.add_new_role_section.add_new_role(role_obj)
    #
    # Returns nothing
    def add_new_role(role_obj,save = true)
      role_select.select(role_obj.type) unless role_obj.type.nil?
      name_tb.type_text(role_obj.name)
      role_parent_select.visible? && role_parent_select.select(role_obj.parent) unless role_obj.parent.nil?
      search_group_values = []
      if !role_obj.user_group.nil?
        role_user_group_input.type_text(role_obj.user_group)
        page.driver.execute_script("document.querySelector('img[alt=\"Search-button-icon\"]').click()")
        sleep 1
        search_group_values = role_user_group_search_value.map{|element|element.text}
        find(:xpath,"//li[text()='#{role_obj.user_group}']").click unless role_obj.user_group == ''
        sleep 1
      end
      create_new_role_start_time = Time.now.utc
      submit_btn.click if save
      wait_until_bus_section_load
      create_new_role_end_time = Time.now.utc
      log("KPI-Create_New_Role:start_time:#{create_new_role_start_time}/end_time:#{create_new_role_end_time}")
      search_group_values
    end

    def click_save_changes_button
      submit_btn.click
    end

    # Public: Append capabilities with given capability array
    #
    # capabilities - [["Partners: add"], ["Partners: list/view"]]
    #
    # Example
    #   @bus_admin_console_page.add_new_role_section.add_capabilities([["Partners: add"], ["Partners: list/view"]])
    #
    # Returns nothing
    #
    # NOTE - Only apply to new roles created
    def add_capabilities(capabilities)
      capabilities.each do | c |
        Log.debug("Processing #{c[0]}")
        if "#{c[0]}" == 'API Key: view'
          Log.debug('hello')
        end
        e = find(:xpath, "//label[contains(., '#{c[0]}')]")
        e.child[0].check
      end
      save_btn = all(:xpath, "//input[contains(@value, 'Save Changes')]")[-1]
      save_btn.click
    end

    def messages
      message_div.text
    end

    def check_editable_ug_field
      (role_user_group_input[:disabled] == 'disabled') & (role_user_group_search_button[:visibility] == 'hidden')
    end

  end
end