module Bus
  # This class provides actions for create new version page section
  class CreateNewVersionSection < SiteHelper::Section

    # Private elements
    #
    # version general info
    element(:version_name_input, id: 'version_name')
    element(:version_dialect_select, id: 'dialect')
    element(:version_note_input, id: 'client_version_notes-')
    element(:version_platform_select, id: 'version_platform-')
    element(:version_arch_input, id: 'version_architecture-')
    element(:linux_version_arch_select, id: 'version_architecture_for_linux-')
    element(:version_ver_input, id: 'version_ver')
    element(:version_install_command_input, id: 'version_install_command')
    element(:version_save_btn, xpath: "//input[@value='Save Changes']")
    # version created success message
    element(:save_success_txt, css: 'ul.flash.successes li')

    # Public: version save success info
    #
    # Return string
    def version_saved_success_message
      save_success_txt.text
    end

    # Public: add a new client version
    #
    def add_new_version(version_info)
      version_name_input.type_text(version_info['name']) unless version_info['name'].nil?
      version_dialect_select.select(version_info['dialect']) unless version_info['dialect'].nil?
      version_note_input.type_text(version_info['notes']) unless version_info['notes'].nil?
      version_platform_select.select(version_info['platform']) unless version_info['platform'].nil?

      unless version_info['arch'].nil?
        version_info['platform'] == 'linux'? linux_version_arch_select.select(version_info['arch']) : version_arch_input.type_text(version_info['arch'])
      end

      version_ver_input.type_text(version_info['version number']) unless version_info['version number'].nil?
      version_install_command_input.type_text(version_info['install command']) unless version_info['install command'].nil?
      version_save_btn.click
    end



  end

end

