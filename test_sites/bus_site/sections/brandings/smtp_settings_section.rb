module Bus
  # This class provides actions for smtp settings section
  class SMTPSettingsSection < SiteHelper::Section

    # Private elements
    #
    element(:smtp_setting_change_msg, css: 'ul.flash.successes')


    # add smtp setting input
    element(:server_address_input, id: 'server_address')
    element(:server_port_input, id: 'server_port')
    element(:server_encryption_select, id: 'server_encryption')
    element(:server_auth_type_select, id: 'server_auth_type')
    element(:server_username_input, id: 'server_username')
    element(:server_password_input, id: 'server_password')
    element(:save_smtp_setting_btn, css:"#email_template-smtp-content input[value='Save Changes']")
    element(:delete_smtp_setting_btn, css:"#email_template-smtp-content input[value='Delete Settings']")

    # dialect info table
    element(:dialect_list_table, css: "#dialect-list-content table.table-view")

    # Public: return smtp setting change message
    #
    def smtp_setting_change_message
      smtp_setting_change_msg.text
    end

    # Public: set up value for smtp settings
    #
    def input_new_smtp_setting(setting)
      server_address_input.type_text(setting['Address'])
      server_port_input.type_text(setting['Port']) if setting['Port']
      server_encryption_select.select(setting['Encryption']) if setting['Encryption']
      server_auth_type_select.select(setting['Authentication']) if setting['Authentication']
      server_username_input.type_text(setting['Username'])
      server_password_input.type_text(setting['Password'])
    end



    # Public: get all setting value in smtp settings section
    #
    # return setting hash
    def get_smtp_setting
      setting = {}
      setting['Address'] = server_address_input.value
      setting['Port'] = server_port_input.value
      setting['Encryption'] = server_encryption_select.selected_options.first.text
      setting['Authentication'] = server_auth_type_select.selected_options.first.text
      setting['Username'] = server_username_input.value
      setting['Password'] = server_password_input.value
      setting
    end

    # Public: delete current smtp setting
    # if force_click is true, click 'Delete Settings' button
    # if force_click is false, only click 'Delete Settings' button if the button exists
    #
    def delete_smtp_setting(force_click = 'true')
      delete_smtp_setting_btn.click if force_click || has_delete_smtp_setting_btn?
    end

    def save_smtp_setting
      save_smtp_setting_btn.click
    end

  end

end

