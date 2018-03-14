module Bus
  # This class provides actions for add new user section
  class AddNewItemizedUserSection < SiteHelper::Section
    # Private elements
    #
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')

    element(:user_group_select, css: 'input[id^=model_auto_completer_tf_]')
    element(:nu_name_tb, id: 'user_name')
    element(:nu_email_tb, id: 'user_username')

    element(:nu_devices_server_tb , id: 'requested_licenses_Server')
    element(:nu_quota_server_tb , id: 'requested_quota_Server')
    element(:nu_devices_desktop_tb , id: 'requested_licenses_Desktop')
    element(:nu_quota_desktop_tb , id: 'requested_quota_Desktop')

    element(:nu_enable_stash_cb , id: 'user_enable_stash')
    element(:nu_send_stash_inv_cb , id: 'send_stash_invite')
    element(:nu_stash_quota_tb , id: 'requested_stash_quota')

    element(:nu_create_btn , id: 'create_user-submit')
    element(:loading_img, xpath: "//img[@alt='Suggestions loading...']")

    # Public: Add new users
    #
    # @users     [Object] users
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_users(user_object)
    #
    # @return [] nothing
    def add_new_itemized_users(users)
      user = users.first

      unless user.user_group.nil?
        user_group_select.type_text(user.user_group)
        page.driver.execute_script("document.querySelector('img[alt=\"Search-button-icon\"]').click()")
        wait_until { !loading_img.visible? }
        find(:xpath,"//li[text()='#{user.user_group}']").click unless user.user_group == ''
        wait_until {!(find(:xpath, "//li[text()='#{user.user_group}']").visible?) }
      end

      # name/email section
      nu_name_tb.type_text(user.name) unless user.name.nil?
      nu_email_tb.type_text(user.email) unless user.email.nil?
      # quota/device section
      nu_devices_server_tb.type_text(user.devices_server) unless user.devices_server.nil?
      nu_quota_server_tb.type_text(user.quota_server) unless user.quota_server.nil?
      nu_devices_desktop_tb.type_text(user.devices_desktop) unless user.devices_desktop.nil?
      nu_quota_desktop_tb.type_text(user.quota_desktop) unless user.quota_desktop.nil?

      unless user.enable_stash.nil?
        if user.enable_stash.downcase.eql?('yes')
          nu_enable_stash_cb.check
        else
          nu_enable_stash_cb.uncheck
        end
      end

      # default quota for stash?
      unless user.stash_quota.nil?
        if user.enable_stash.downcase.eql?('yes')
          if user.stash_quota.downcase.eql?('default')
            #its default
          else
            nu_stash_quota_tb.type_text(user.stash_quota) unless user.stash_quota.nil?
          end
        else
        end
      end

      # send stash invite emails?
      unless user.send_invite.nil?
        if user.send_invite.downcase.eql?('yes')
          nu_send_stash_inv_cb.check
        else
          nu_send_stash_inv_cb.uncheck
        end
      end

      # finishing up
      nu_create_btn.click
      #wait_until_bus_section_load
    end

    # Public: Success messages for add new user sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_section.success_messages
    #  # => "Created new user test@mozy.com"
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    def new_user_creation_success(users)
      #example: "Created new user qa1+weemicbcrffn@decho.com"
      user = users.first
      success_messages.should == "Created new user #{user.email}"
    end

    # Public: Error messages for add new user sections
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.error_messages
    #  # => "Failed to create (1) users"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

    # stash info
    #
    # to be used when stash is enabled and there are more than 1 user group
    def itemized_stash_data(users)
      user = users.first
      # enable stash for the user?
    end

    # Public: User group resource details
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.ug_resource_details_table_rows
    #  # => ["Desktop Storage (GB)","200"],["Server Storage (GB)","50"],["Desktop Devices","2"], ["Server Devices", "192"]
    #
    # @return
    def ug_resource_details_table_rows
      ug_resources_details_table.rows_text[1..-2]
    end

    def select_user_group(group_name)
      user_group_select.select(group_name)
      sleep 2 # wait for ajax call back
    end


    #==============================
    # Public : check the sync checkbox exist or not
    #
    # Example: @bus_site.admin_console_page.add_new_itemized_user_section.sync_checkbox_visible == true if visible == "visible"
    #
    # Return : ture if find the sync checkbox, otherwisem returns false
    #==============================
    def sync_checkbox_visible
      begin
        find(:id, 'user_enable_stash')
        puts "======find the sync checkbox======"
        return true
      rescue
        puts "======sync checkbox is not found======"
        return false
      end
    end

  end
end
