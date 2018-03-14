module Bus
  # This class provides actions for version show page section
  class VersionShowSection < SiteHelper::Section

    # Private elements
    #
    # tabs of version details info
    element(:version_tab_titles, css: "ul.tab-titles")
    # General info of version details
    element(:version_status_select, id: "version_status")
    element(:version_name_input, id: "version_name")
    element(:version_dialect_select, id: "dialect")
    element(:version_note_input, css: "textarea")
    element(:version_platform_div, xpath: "//label[@for='version_platform']/parent::div")
    element(:linux_version_arch_select, css: "select[id^='version_architecture']")
    element(:version_arch_input, css: "input[id^='version_architecture']")
    element(:version_ver_input, id: "version_ver")
    element(:version_install_command_input, id: "version_install_command")
    element(:version_oem_input, id: "oem_db_file")
    element(:replace_db3_link, xpath: "//a[text()='replace']")
    element(:version_save_btn, css: "input[@value='Save Changes']")
    element(:rebuild_btn, css: "input[@name='rebrand_executables']")
    element(:version_oem_label, css: "label[for='oem_db_file']")
    element(:delete_version_link, xpath: "//a[text()='Delete Version']")
    element(:reset_building_link, xpath: "//fieldset[contains(@id,'version_general_fragment')]//a[contains(text(),'reset')]")
    element(:recreate_bds_exe_cb, id: 'brand_executables')
    # Brandings info table of version details
    element(:version_branding_table, css: "table.table-view")
    # version saved success message
    element(:save_success_txt, css: "ul.flash.successes li")


    # Public: click General tab or Brandings tab
    #
    def select_tab(tab_name)
      version_tab_titles.child.each do |c|
        c.click if c.text == tab_name
      end
    end

    # Public: get General info in version General tab
    #
    def version_general_info_hash
      version_general_info={}
      version_general_info['name'] = version_name_input.value
      version_general_info['status'] = version_status_select.value
      version_general_info['dialect'] = version_dialect_select.value
      version_general_info['platform'] = version_platform_div.text.gsub("Platform:\n",'')
      version_general_info['arch'] = linux_version_arch_select.visible?? linux_version_arch_select.value : version_arch_input.value
      version_general_info['version number'] = version_ver_input.value
      version_general_info['notes'] = version_note_input.value
      version_general_info['install command'] = version_install_command_input.value
      version_general_info
    end

    # Public: change version status
    #
    def change_status(status)
      version_status_select.select(status)
      version_save_btn.click
    end

    # Public: version save success info
    #
    # Return string
    def version_saved_success_message
      save_success_txt.text
    end

    # Public: delete version
    #
    def delete_version
      delete_version_link.click
      alert_accept if alert_present?
    end


    # Public: get partner branding info in version Brandings tab
    #
    def version_branding_table_text
      version_branding_table.raw_text
    end

    # Public: rebuild a windows executable for product partner
    #
    def rebuild_executable(partner)
      find(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[5]//input").check
      rebuild_btn.click
      alert_accept if alert_present?
    end

    # Public: check if executable build successfully
    #
    def executable_rebuild_success?(partner)
      Log.debug find(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]").text
      locate(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]//a[contains(text(), '.exe')]") && locate(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]//a[text()='build failed...']").nil?
    end


    # Public: upload a client for a partner in Brandings tab
    #
    def replace_executable(partner, executable)
      if partner == 'MozyPro'
        find(:xpath, "//td[text()='mozypro']//parent::tr//td[4]//a[text()='replace']").click
        browse_button = find(:xpath, "//td[text()='mozypro']//parent::tr//td[4]//input")
      else
        find(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]//a[text()='replace']").click
        browse_button = find(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]//input")
      end
      upload_file(executable, browse_button.id)
    end

    # Public: upload a db3 file for windows client
    #
    def upload_db3(file, rebuild_option = true)
      replace_db3_link.click unless version_oem_input.visible?
      upload_file(file, version_oem_input.id)
      rebuild_option ? recreate_bds_exe_cb.check : recreate_bds_exe_cb.uncheck
    end


    # Public: set upload file path for a given element
    #
    def upload_file(executable, upload_button_id)
      file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent.parent) + "/test_data/#{executable}"
      file_path.gsub!('/', '\\') if OS.windows?
      attach_file(upload_button_id, file_path)
    end

    # Public: click save changes button in version details section
    def save_changes
      version_save_btn.click
    end

    # Public: click (reset) link in version status area to stop building new client
    def reset_building
      reset_building_link.click if has_reset_building_link? && reset_building_link.visible?
    end


    # Public: check whether the download link for a partner exists in Brandings tab
    #
    def download_link_present?(partner)
      !(locate(:xpath, "//a[text()='#{partner}']//parent::td//parent::tr//td[4]//a[starts-with(@href,'/downloads/')]").nil?)
    end

  end

end

