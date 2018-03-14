module Bus
  # This class provides actions for manage pending deletes section
  class ManageLDAPConnectorsSection < SiteHelper::Section

    #Add New Version Button
    element(:add_new_version_button, xpath: "//input[@value='Add New Version']")
    element(:version_table, xpath: "//div[@id='internal-manage_ldap_connectors-content']//table[@class='table-view']")
    elements(:delete_link, xpath: "//table[@class='table-view']//a[text()='Delete']")

    def click_add_new_version_button
      add_new_version_button.click
    end

    def get_client_info(version, type)
      version_info = version_table.hashes
      i = 0
      while i < delete_link.length
        if version == version_info[i]['Version']
          value = version_info[i][type]
          break
        end
        i = i + 1
      end
      return value
    end

    def delete_version(version)
      version_info = version_table.hashes
      i = 0
      while i < delete_link.length
        if version == version_info[i]['Version']
          delete_link[i].click
          alert_accept
          wait_until_bus_section_load
          break
        end
        i = i + 1
      end
    end

    def check_version_existence(version)
      version_info = version_table.hashes
      i = 0
      flag = false
      while i < delete_link.length
        if version == version_info[i]['Version']
          flag = true
          break
        end
        i = i + 1
      end
      return flag
    end

  end
end