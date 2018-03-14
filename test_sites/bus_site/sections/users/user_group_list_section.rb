module Bus
  class UserGroupListSection < SiteHelper::Section
    # Private elements
    #
    element(:add_group_input, css: "input[value='Add Group']")

    # Messages
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, css: 'ul.flash.errors')

    def ug_table_header(name)
      case name
        when 'Device Used'
          ug_table.find(:css, "th[aria-label^='Used']:not([class*='raw_storage'])")
        when 'Storage Used', 'Desktop Storage Used'
          ug_table.find(:css, "th[aria-label^='Used'].raw_storage")
        when 'Server Storage Used'
          ug_table.find(:xpath, "//th[contains(text(), 'Used')][contains(@class, 'raw_storage')][2]")
        when 'Desktop Device Total'
          ug_table.find(:xpath, "//th[contains(text(), 'Total')][1]")
        when 'Server Device Total'
          ug_table.find(:xpath, "//th[contains(text(), 'Total')][2]")
        else
          ug_table.find(:css, "th[aria-label^='#{name}']")
      end
    end

    # Public: Successful messages for delete user group sections
    #
    # Example:
    #  @bus_site.admin_console_page.user_group_list_section.success_messages
    #  # => "User Group #{group_name} has been successfully created."
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    # Public: Error messages for delete user group sections
    #
    # Example:
    #  @bus_site.admin_console_page.user_group_list_section.error_messages
    #  # => "Can't delete last user group of a non-deleted partner"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

    # Public: Click Add Group button
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.view_add_group_section
    #
    # @return [] nothing
    def view_add_group_section
      add_group_input.click
    end

    # Public: Bundled user group list rows
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.bundled_ug_list_rows
    #   # => ["(default user group)", "false", "true", "", "0", "0"]
    #
    # @return [Array<String>]
    def bundled_ug_list_rows
      ug_table.rows_text[1..-1].each do |row|
        row[1] = row[1].eql?('-') ? 'false' : 'true'
        row[2] = row[2].eql?('-') ? 'false' : 'true'
        row.delete_at(-1) # Remove action column
      end
    end

    # Public: Itemized user group list rows
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.itemized_ug_list_rows
    #   # => ["(default user group)", "false", "Shared", "", "0", "0", "10", "Shared", "", "0", "0", "200"]
    #
    # @return [Array<String>]
    def itemized_ug_list_rows
      ug_table.rows_text[1..-1].each do |row|
        row[1] = row[1].eql?('-') ? 'false' : 'true'
        row.delete_at(-1) # Remove action column
      end
    end

    # Public: MozyPro Itemized user group list rows
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.mozypro_itemized_ug_list_rows
    #   # => ["(default user group)", "false", "Shared", "", "0", "0", "10", "Shared", "", "0", "0", "200"]
    #
    # @return [Array<String>]
    def mozypro_itemized_ug_list_rows
      old_ug_table.rows_text
    end

    # Public: View edit user group section
    #
    # @group_name [String] user group name
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.view_user_group('(default user group)')
    #
    # @return [] nothing
    def edit_user_group(group_name)
      ug_table.rows[1..-1].each do |row|
        if row[0].text == group_name
          row[-1].find(:css, 'a.action.edit_user_group').click
          break;
        end
      end
    end


    def view_user_group(group_name)
      find_link(group_name).click
    end

    # Public: Delete user group by group name
    #
    # @group_name [String] user group name
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.delete_user_group('Group A')
    #
    # @return [] nothing
    def delete_user_group(group_name)
      ug_table.rows[1..-1].each do |row|
        if row[0].text == group_name
          row[-1].find(:css, '.ug_delete').click
          alert_accept
          break
        end
      end
    end

    # Private: User Group Table
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.ug_table
    #
    # @return [element]
    def ug_table
      wait_until_bus_section_load
      find(:css, 'table.user_group_list.dataTable')
    end

    # Private: Old User Group Table
    #
    # Example
    #   @bus_admin_console_page.user_group_list_section.old_ug_table
    #
    # @return [element]
    def old_ug_table
      wait_until_bus_section_load
      find(:css, '#user_groups-list-content table.table-view tbody')
    end
  end
end