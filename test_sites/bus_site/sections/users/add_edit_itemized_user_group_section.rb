module Bus
  class AddEditItemizedUserGroupSection < SiteHelper::Section
    # Private elements
    #
    # Messages
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')
    # Common
    element(:group_name_tb, id: 'user_group_name')
    element(:storage_device_err_p, id: 'show_storage_device_warning_row')
    element(:group_billing_code_tb, id: 'user_group_billing_code')
    element(:server_assigned_tb, id: 'default_quota_Server')
    element(:desktop_assigned_tb, id: 'default_quota_Desktop')
    element(:default_stash_quota_tb, id: 'user_group_stash_default_quota')
    # Common
    element(:enable_stash_cb, id: 'stash')
    element(:save_ug_btn, css: 'input[name^=commit]')

    # Public: Add a new or edit itemized user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(user_group_object)
    #
    # @return [] nothing
    def add_itemized_partner_ug(ug)
      group_name_tb.type_text(ug.name) if group_name_tb[:disabled].nil?
      server_assigned_tb.type_text(ug.server_assigned_quota) unless ug.server_assigned_quota.nil?
      desktop_assigned_tb.type_text(ug.desktop_assigned_quota) unless ug.desktop_assigned_quota.nil?

      unless ug.enable_stash.nil?
        if ug.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end
      save_ug_btn.click
      #wait_until_bus_section_load
    end

    # Public: Add a new or edit itemized user group
    #
    # @ug [Object] user group object
    #
    # Example:
    #   @bus_admin_console_page.add_new_user_group_section.add_edit_itemized_user_group(user_group_object)
    #
    # @return [] nothing
    def edit_itemized_partner_ug(ug)
      group_name_tb.type_text(ug.name) if group_name_tb[:disabled].nil?

      desktop_assigned_tb.type_text(ug.desktop_assigned_quota) unless ug.desktop_assigned_quota.nil?
      server_assigned_tb.type_text(ug.server_assigned_quota) unless ug.server_assigned_quota.nil?

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
