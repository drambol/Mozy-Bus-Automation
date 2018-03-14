module Bus
  # This class provides actions for manage group resource section
  class ManageUserGroupResourcesSection < SiteHelper::Section

    # Shared
    elements(:resources_details_tables, css: "table.matrix_table")
    elements(:general_info_spans, xpath: "//div[@class='show-details']/div/span[@class='label' or @class='value']")

    # Resource changed message
    element(:message_div, css: "div[id^=resource-group_available_keys-] ul")

    # Create / Delete Keys
    element(:create_new_keys_link, xpath: "//a[text()='Create New Keys']")
    element(:create_new_keys_div, css: "div[id^=unassigned_resources-create_keys_form_]")
    element(:delete_keys_link, xpath: "//a[text()='Delete Keys']")
    element(:delete_inactive_keys_radio, id: "cleanup_type_unactivated")
    element(:delete_unassigned_keys_radio, id: "cleanup_type_unassigned")
    element(:confirm_for_delete_keys_button, css: "input[name=cleanup_keys][type=submit]")

    # Batch key assignment
    element(:batch_key_assignment_link, xpath: "//a[text()='Perform batch key assignment']")
    element(:batch_key_assignment_div, css: "div[id^=resource-group_available_keys-batch_form-]")

    # Public: Get group id
    #
    # Return text
    def group_id
      el = find(:css, "div[id^=unassigned-resources-]")
      el.id.delete('unassigned-resources-')
    end

    # Public: User group general information
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.user_group_general_info_hash
    #
    # Returns hash
    def user_group_general_info_hash
      wait_until_bus_section_load
      array = general_info_spans.map{ |span| span.text }
      Hash[*array]
    end

    # Public: Resources storage details table headers text
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.storage_details_table_headers
    #
    # Returns string array
    def storage_details_table_headers
      resources_details_tables[0].headers_text
    end

    # Public: Resources storage details table rows text
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.storage_details_table_rows
    #
    # Returns string array
    def storage_details_table_rows
      resources_details_tables[0].rows_text
    end

    # Public: Resources license details table headers text
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.license_details_table_headers
    #
    # Returns string array
    def license_details_table_headers
      resources_details_tables[1].headers_text
    end

    # Public: Resources license details table rows text
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.license_details_table_rows
    #
    # Returns string array
    def license_details_table_rows
      resources_details_tables[1].rows_text
    end

    # Public: Allocate desktop resources for Reseller partner
    #
    # @param [string] desktop_quota
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.allocate_reseller_desktop_quota('10')
    #
    # Returns nothing
    def allocate_reseller_desktop_quota(desktop_quota)
      find(:css, "span#allocated_#{group_id}_13 a").click # Click Change link
      desktop_span = find(:id, "allocated_change_#{group_id}_13")
      desktop_span.find(:id, "quota").type_text(desktop_quota)
      desktop_span.find(:css, "input[value=Submit]").click
    end

    # Public: Allocate server resources for Reseller partner
    #
    # @param [string] server_quota
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.allocate_reseller_server_quota('10')
    #
    # Returns nothing
    def allocate_reseller_server_quota(server_quota)
      find(:css, "span#allocated_#{group_id}_14 a").click # Click Change link
      server_span = find(:id, "allocated_change_#{group_id}_14")
      server_span.find(:id, "quota").type_text(server_quota)
      server_span.find(:css, "input[value=Submit]").click
    end

    # Public: Batch Assign a MozyEnterprise or Reseller keys
    #
    # @params [string] email_quota, [string] license_type, [bool] send_email
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.batch_assign_keys('test_email@mozy.com,1','Desktop', true)
    #
    # @return nothing
    def batch_assign_keys(email_quota, license_type, send_email = false)
      batch_key_assignment_link.click
      batch_key_assignment_div.find(:id, "emails").type_text(email_quota)
      batch_key_assignment_div.find(:id, "license_type").select(license_type)
      batch_key_assignment_div.find(:id, "send_emails").check if send_email
      batch_key_assignment_div.find(:css, "input[name=batch_assignment]").click
      wait_until_bus_section_load
    end

    # Public: Create new keys
    #
    # @params [string] license_type, [string] num_keys
    #
    # Example
    #  @bus_site.admin_console_page.manage_resources_section.create_new_keys('Desktop', '5')
    #
    # @return nothing
    def create_new_keys(license_type, num_keys)
      create_new_keys_link.click
      wait_until{ create_new_keys_div.visible? }
      license_select = create_new_keys_div.find(:id, "create_keys_license_type")
      license_select.select(license_type) if license_select.visible?
      create_new_keys_div.find(:id, "num_keys").type_text(num_keys)
      create_new_keys_div.find(:css, "input[name=create_keys]").click
      wait_until_bus_section_load
    end

    # Public: Messages for manage resources actions
    #
    # Example
    #   @bus_site.admin_console_page.manage_user_group_resources_section.messages
    #   # => "1 key has been assigned."
    #
    # Returns text
    def messages
      message_div.text
    end

    # Public: delete keys
    #
    # @params [symbol] type
    #
    # Example
    #  @bus_site.admin_console_page.manage_user_group_resources_section.delete_keys :active
    #
    # @return nothing
    def delete_keys type
      delete_keys_link.click
      case type
      when :inactive
        choose delete_inactive_keys_radio.id
      when :unassigned
        choose delete_unassigned_keys_radio.id
      else
        raise ArgumentError.new 'unknown type'
      end
      confirm_for_delete_keys_button.click
      wait_until_bus_section_load
    end

    def delete_key_by_email email
      find(:xpath, "//td/span[contains(., '#{email}')]/a").click
      wait_until_bus_section_load
    end
  end

end
