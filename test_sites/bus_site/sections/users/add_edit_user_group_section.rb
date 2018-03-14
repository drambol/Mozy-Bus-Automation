module Bus
  class AddEditUserGroupSection < SiteHelper::Section
    # Private elements
    #
    # Messages
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')
    # Common
    element(:group_name_tb, id: 'name')
    element(:storage_device_err_p, id: 'show_storage_device_warning_row')
    element(:install_region_override_select, id: 'install_region_override')
    # For bundled
    element(:generic_storage_type_select, css: 'select[id^=Generic_storage_pool_type_]')
    element(:generic_assigned_tb, id: 'Generic_storage_assigned')
    element(:generic_max_tb, id: 'Generic_storage_max')
    element(:generic_server_support_cb, id: 'server_support')
    # For itemized
    element(:server_storage_type_select, css: 'select[id^=Server_storage_pool_type_]')
    element(:server_assigned_tb, id: 'Server_storage_assigned')
    element(:server_max_tb, id: 'Server_storage_max')
    element(:server_devices_tb, id: 'Server_device_count')
    element(:desktop_storage_type_select, css: 'select[id^=Desktop_storage_pool_type_]')
    element(:desktop_assigned_tb, id: 'Desktop_storage_assigned')
    element(:desktop_max_tb, id: 'Desktop_storage_max')
    element(:desktop_devices_tb, id: 'Desktop_device_count')
    # Common
    element(:enable_stash_cb, id: 'stash')
    element(:save_ug_btn, css: 'button[onclick*=user_groups]')


    # Public: Add a new or edit bundled user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_bundled_user_group(user_group_object)
    #
    # @return [] nothing
    def add_edit_bundled_user_group(ug)
      group_name_tb.type_text(ug.name) if group_name_tb[:disabled].nil?
      generic_storage_type_select.select(ug.storage_type) unless ug.storage_type.nil?
      generic_max_tb.type_text(ug.limited_quota) unless ug.limited_quota.nil?
      generic_assigned_tb.type_text(ug.assigned_quota) unless ug.assigned_quota.nil?
      unless ug.server_support.nil?
        if ug.server_support.downcase.eql?('yes')
          generic_server_support_cb.check
        else
          generic_server_support_cb.uncheck
        end
      end
      unless ug.enable_stash.nil?
        if ug.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end
      unless ug.install_region_override.nil?
        install_region_override_select.select(ug.install_region_override)
      end
      click_add_user_group_time = Time.now.utc
      log("add user group click save time: #{click_add_user_group_time}")
      save_ug_btn.click
    end

    # Public: Add a new or edit itemized user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(user_group_object)
    #
    # @return [] nothing
    def add_edit_itemized_user_group(ug)
      group_name_tb.type_text(ug.name) if group_name_tb[:disabled].nil?

      desktop_storage_type_select.select(ug.desktop_storage_type) unless ug.desktop_storage_type.nil?
      desktop_assigned_tb.type_text(ug.desktop_assigned_quota) unless ug.desktop_assigned_quota.nil?
      desktop_max_tb.type_text(ug.desktop_limited_quota) unless ug.desktop_limited_quota.nil?
      desktop_devices_tb.type_text(ug.desktop_devices) unless ug.desktop_devices.nil?

      server_storage_type_select.select(ug.server_storage_type) unless ug.server_storage_type.nil?
      server_assigned_tb.type_text(ug.server_assigned_quota) unless ug.server_assigned_quota.nil?
      server_max_tb.type_text(ug.server_limited_quota) unless ug.server_limited_quota.nil?
      server_devices_tb.type_text(ug.server_devices) unless ug.server_devices.nil?

      unless ug.enable_stash.nil?
        if ug.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end
      save_ug_btn.click
      wait_until_bus_section_load
    end

    # Public: Successful messages for add new or edit user group sections
    #
    # Example:
    #  @bus_admin_console_page.add_new_user_group_section.success_messages
    #  # => "Created new user group test_group"
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    # Public: Error messages for add new or edit user group sections
    #
    # Example:
    #  @bus_admin_console_page.add_new_user_group_section.error_messages
    #  # => "Whole positive integer required for Desktop device count"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

    def verify_add_bundled_user_group_ui(storage_type, enable_stash, server_support)
      if group_name_tb.visible? && save_ug_btn.visible? && generic_storage_type_select.visible?
        generic_storage_type_select.select(storage_type)
        case storage_type
          when 'Shared'
            @result =
                !generic_max_tb.visible? &&
                !generic_assigned_tb.visible?
          when 'Limited'
            @result =
                generic_max_tb.visible? &&
                !generic_assigned_tb.visible?
          when 'Assigned'
            @result =
                generic_assigned_tb.visible? &&
                !generic_max_tb.visible?
          when 'None'
            @result =
                !generic_max_tb.visible? &&
                !generic_assigned_tb.visible? &&
                !has_enable_stash_cb? &&
                !has_generic_server_support_cb?
            return @result
          else
            # Skipped
        end
        @result = enable_stash ? @result && has_enable_stash_cb? : @result && !has_enable_stash_cb?
        @result = server_support ? @result && has_generic_server_support_cb? : @result && !has_generic_server_support_cb?
        return @result
      end
      false
    end

    def verify_add_itemized_user_group_ui(storage_type, enable_stash, server_support)
      if group_name_tb.visible? && save_ug_btn.visible?
        desktop_storage_type_select.select(storage_type)
        case storage_type
          when 'Shared'
            @result =
                !desktop_max_tb.visible? &&
                !desktop_assigned_tb.visible? &&
                desktop_devices_tb.visible?
          when 'Limited'
            @result =
                desktop_max_tb.visible? &&
                !desktop_assigned_tb.visible? &&
                desktop_devices_tb.visible?
          when 'Assigned'
            @result =
                desktop_assigned_tb.visible? &&
                !desktop_max_tb.visible? &&
                desktop_devices_tb.visible?
          when 'None'
            @result =
                !desktop_max_tb.visible? &&
                !desktop_assigned_tb.visible? &&
                !desktop_devices_tb.visible?
          else
            # Skipped
        end

        @result = enable_stash ? @result && has_enable_stash_cb? : @result && !has_enable_stash_cb?

        if server_support
          server_storage_type_select.select(storage_type)
          case storage_type
            when 'Shared'
              @result = @result &&
                  !server_max_tb.visible? &&
                  !server_assigned_tb.visible? &&
                  server_devices_tb.visible?
            when 'Shared with Max'
              @result = @result &&
                  server_max_tb.visible? &&
                  !server_assigned_tb.visible? &&
                  server_devices_tb.visible?
            when 'Assigned'
              @result = @result &&
                  server_assigned_tb.visible? &&
                  !server_max_tb.visible? &&
                  server_devices_tb.visible?
            when 'None'
              @result = @result &&
                  !server_max_tb.visible? &&
                  !server_assigned_tb.visible? &&
                  !server_devices_tb.visible?
            else
              # Skipped
          end
        else
          @result = @result &&
              !has_server_storage_type_select? &&
              !has_server_assigned_tb? &&
              !has_server_max_tb? &&
              !has_server_devices_tb?
        end
        return @result
      end
      false
    end
  end
end
