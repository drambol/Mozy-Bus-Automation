module Bus
  # This class provides actions for manage pending deletes section
  class AddNewVersionSection < SiteHelper::Section

    #Add New Version
    element(:version_field, xpath: "//input[@id='ldap_version']")
    element(:platform_select, xpath: "//select[@id='ldap_os']")
    element(:os_architecture_select, xpath: "//select[@id='ldap_os_arch']")
    element(:status_select, xpath: "//select[@id='ldap_status']")
    element(:choose_file_button, xpath: "//input[@id='ldap_installation_file']")
    element(:save_change_button, xpath: "//input[@value='Save Changes']")
    element(:close_section, xpath: "//div[@id='internal-create_ldap_connector']//img[@alt='Close']")
    element(:edit_choose_file_button, xpath: "//div[contains(@id, 'internal-edit_ldap_connector')]//input[@type='file']")
    element(:edit_save_change_button, xpath: "//div[contains(@id, 'internal-edit_ldap_connector')]//input[@value='Save Changes']")
    element(:edit_status_select, xpath: "//div[contains(@id, 'internal-edit_ldap_connector')]//select[@name='ldap[status]']")

    def add_new_version(version, platform, os, status, file)
      wait_until_bus_section_load
      version_field.type_text(version)
      platform_select.select(platform)
      os_architecture_select.select(os)
      status_select.select(status)

      file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent.parent) + "/test_data/" + file
      file_path.gsub!('/', '\\') if OS.windows?
      attach_file(choose_file_button.id, file_path)

      save_change_button.click
    end

    def edit_client_version_by_installation_file(version, file)
      # close_section.click
      wait_until_bus_section_load
      find(:xpath, "//a[text()='" + version + "']").click
      file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent.parent) + "/test_data/" + file
      file_path.gsub!('/', '\\') if OS.windows?
      attach_file(edit_choose_file_button.id, file_path)

      edit_save_change_button.click
    end

    def edit_client_version_by_status(version, status)
      wait_until_bus_section_load
      find(:xpath, "//a[text()='" + version + "']").click
      edit_status_select.select(status)

      edit_save_change_button.click
    end

  end
end