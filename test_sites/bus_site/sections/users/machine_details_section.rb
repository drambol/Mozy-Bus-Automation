module Bus

  class MachineDetailsSection < SiteHelper::Section

    element(:dso_table, xpath: "//th[text()='Order ID']/../../../../table")
    element(:machine_info_dls, css: 'div[id^=machine-show-] dl')
    # change external id
    element(:change_external_id_link, xpath: "//div[contains(@id, 'machine-show')]//span[@class='view']/a")
    element(:external_id_tb, xpath: "//div[contains(@id, 'machine-show')]//span[@class='edit']/input[@id='external_id']")
    element(:submit_external_id_btn, xpath: "//div[contains(@id, 'machine-show')]//span[@class='edit']/input[@value='Submit']")


    #Manifest section
    element(:manifest_view_lnk, xpath: "//div[contains(@id,'machine-show')]//a[text()='View']")
    element(:manifest_raw_lnk, xpath: "//div[contains(@id,'machine-show')]//a[text()='Raw']")

    elements(:machine_bar_actions_links, xpath: "//div[contains(@id,'machine-show')]//li/a")

    element(:replace_machine_lnk, xpath: "//a[text()='Replace Machine']")
    element(:replace_machine_li, xpath: "//a[text()='Replace Machine']/..")
    element(:delete_machine_lnk, xpath: "//a[text()='Delete Machine']")
    element(:undelete_machine_lnk, xpath: "//a[text()='Undelete Machine']")

    # backups restores section
    element(:backups_section_text, xpath: "//div[contains(@id,'machine-show-')]//h4[text()='Backups']/following-sibling::P")
    element(:restores_section_text, xpath: "//div[contains(@id,'machine-show-')]//h4[text()='Restores']/following-sibling::P")

    #Restores
    element(:download_restore, xpath: "//table[@class='table-view']//a[text()='Download Restore']")


    # Public: General information hash
    #
    # @param [none]
    #
    # Example:
    #   partner_details_section.general_info_hash
    #   # => {"ID:"=>"7741927", "External ID:"=>"(change)", "Owner:"=>"zoezjn+machine1@gmail.com", "Space Used:"=>"120.7MB", "Last Update:"=>"5 hours ago", "Encryption:"=>"Default", "Data Center:"=>"qa6"}
    #
    # @return [Hash]
    def machine_info_hash
      wait_until_bus_section_load
      output = machine_info_dls.dt_dd_elements_text
      Hash[*output.flatten]
    end

    def dso_hashes
      wait_until_bus_section_load
      dso_table.hashes
    end

    def click_view_manifest
      manifest_view_lnk.click
    end

    def click_raw_manifest
      manifest_raw_lnk.click
    end

    def wait_until_file_downloaded (file_name)
      wait_until { file_exists?(file_name) }
    end

    def click_replace_machine
      replace_machine_lnk.click
    end

    def delete_undelete_machine(action)
      if action == 'delete'
        delete_machine_lnk.click
      else
        undelete_machine_lnk.click
      end
      alert_accept
    end

    def data_shuttle_table_visible?
      !(locate(:xpath, "//th[text()='Order ID']/../../../../table").nil?)
     end

    def undelete_machine_link_exist
       !(locate(:xpath, "//a[text()='Undelete Machine']").nil?)
    end

    def get_machine_bar_actions
      machine_bar_actions_links.map{|ele|ele.text.strip}
    end

    def get_backup_section_text
      backups_section_text.text
    end

    def get_restores_section_text
      restores_section_text.text
    end

    def backup_table_empty
      !(locate(:xpath, "div[contains(@id,'machine-show-')]//tbody//td[text()='No results found.']").nil?)
    end

    def get_backup_restore_table(type)
      wait_until_bus_section_load
      find(:xpath, "//h4[text()='#{type}']/following-sibling::div[1]/table").raw_text.select{|row|row!=[""]}
    end

    def get_backup_restore_table_hashes(type)
      wait_until_bus_section_load
      find(:xpath, "//h4[text()='#{type}']/following-sibling::div[1]/table").hashes
    end


    def click_machine_link (match)
      find(:xpath, "//a[text()='#{match}']").click
    end

    def click_link(link_name)
       find_link(link_name).click
    end

    def change_machine_external_id(external_id)
      change_external_id_link.click
      external_id_tb.type_text(external_id)
      submit_external_id_btn.click
      wait_until_bus_section_load
    end

    def get_replace_machine_text
      replace_machine_li.text.strip
    end

    def click_machine_download_item(item)
      case item
        when "Download Restore"
          download_restore.click
      end
    end
  end
end
