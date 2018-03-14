module Bus
  # This class provides actions for add new role section
  class EditRoleSection < SiteHelper::Section
    # edit a role
    element(:edit_role_user_group_input, xpath: "//div[contains(@id,'roles-show')]//input[@name='user_group_name']")
    elements(:edit_role_user_group_search_value, xpath: "//div[contains(@id,'roles-show')]//div[contains(@id,'auto_complete')]//li")
    element(:edit_role_user_group_search_button, xpath: "//div[contains(@id,'roles-show')]//td[@id='preferred_parent_user_group_id_div']/span")
    element(:submit_btn_edit, xpath: "//div[contains(@id,'roles-show')]//input[contains(@value, 'Save Changes')]")
    element(:message_edit_div, xpath:"//div[starts-with(@id,'roles-show')]//div[contains(@id,'errors')]//ul/li")
    element(:edit_role_name_input, xpath: "//a[.='Delete Role']/../../../..//input[@id='role_name']")

    def get_user_group_value
      edit_role_user_group_input[:value]
    end

    def edit_role(role_name,user_group, save = true)
      search_group_values = []
      if !role_name.nil?
        edit_role_name_input.type_text(role_name)
      end
      if !user_group.nil?
        edit_role_user_group_input.type_text(user_group)
        page.driver.execute_script("document.querySelector('div[id^=\"roles-show\"] img[alt=\"Search-button-icon\"]').click()")
        sleep 1
        search_group_values = edit_role_user_group_search_value.map{|element|element.text}
        find(:xpath,"//li[text()='#{user_group}']").click unless user_group == ''
      end
      submit_btn_edit.click if save
      search_group_values
    end

    def messages_edit
      message_edit_div.text
    end
  end
end
