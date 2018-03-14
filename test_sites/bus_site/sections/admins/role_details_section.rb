module Bus
  # This class provides actions for add new role section
  class RoleDetailsSection < SiteHelper::Section
    element(:delete_role_lnk, xpath: "//a[text() = 'Delete Role']")

    # edit role
    element(:save_role_txt, xpath: "//div[contains(@id,'roles-show')]//div[contains(@id,'-errors')]//li")
    element(:add_remove_admins_edit_role_link, xpath: "//div[contains(@id,'roles-show')]//a[text()='Add/remove admins']")
    element(:save_changes_edit_role_button, xpath: "//div[contains(@id,'roles-show')]//td/input[@value='Save Changes']")
    elements(:admins_of_roles_link, xpath: "//div[@id='admins']/ul/li[@class='selected']//a")

    #TODO
    def update_name(role_name)

    end

    def delete_role(role_name)
      delete_role_lnk.click
      alert_accept
      wait_until { locate(:link, "Delete Role").nil? }
    end

    def add_all_available_capabilities
      wait_until_bus_section_load
      page.execute_script("jQuery('input[id^=capability_]').each(function() { if (!this.checked) {this.click()} })")
      find(:css, 'div[id^=roles-show] input[class=button]').click
      wait_until_bus_section_load
    end

    def uncheck_all_capabilities
      wait_until_bus_section_load
      page.execute_script("jQuery('input[id^=capability_]').each(function() { if (this.checked) {this.click()} })")
      find(:css, 'div[id^=roles-show] input[class=button]').click
      wait_until_bus_section_load
    end

    # save roles message after edit role
    def save_cap_msg
      save_role_txt.text
    end

    def open_role_sub_tab(tab_name)
      find(:xpath,"//div[contains(@id,'roles-show')]/ul/li[text()='#{tab_name}']").click
    end

    def add_remove_admins(action, admins_array)
      wait_until{add_remove_admins_edit_role_link.visible?}
      add_remove_admins_edit_role_link.click
      admins_array.each do | admin |
        xpath_str = "//a[text()='#{admin[0]}']/../input"
        if action == 'add'
          find(:xpath, xpath_str).check
        else
          find(:xpath, xpath_str).uncheck
        end
      end
      # click save changes
      save_changes_edit_role_button.click
    end

    # view a role, in members tab, will display admins that has been assigned the role
    def get_admins_of_role()
      element_array = admins_of_roles_link
      element_array.map{|element|element.text.strip}
    end

  end
end
