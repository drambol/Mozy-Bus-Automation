module Bus
  # This class provides actions for list user groups section
  class ListUserGroupsSection < SiteHelper::Section
    # Private elements
    #
    element(:filter_select, id: "user_group_filter")
    element(:user_groups_list_table, xpath: "//div[@id='user_groups-list-content']/div/table")
    element(:loading_link, xpath: "//a[contains(@onclick,'toggle_module')]")

    # Public: View user group detail by click user group's name
    #
    # Examples
    #
    #  @bus_admin_console_page.list_user_groups_section.view_user_group_detail("Lego Company Group")
    #
    # Returns nothing
    def view_user_group_detail(search_key)
      find_link(search_key).click
      wait_until_bus_section_load
    end

    # Public: User group list table header text
    #
    # Example:
    #   @bus_admin_console_page.list_user_groups_section.user_group_list_table_headers
    #
    # Returns array
    def user_group_list_table_headers
      user_groups_list_table.headers_text
    end

    # Public: User group list table rows text
    #
    # Example:
    #   @bus_admin_console_page.list_user_groups_section.user_group_list_table_rows
    #
    # Returns array
    def user_group_list_table_rows
      rows = user_groups_list_table.rows_text
      rows.slice!(0)
      rows
    end

    # Public: User group search results hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    # Example:
    #  @bus_admin_console_page.list_user_groups_section.user_group_list_hashes
    #
    # Returns hash array
    def user_group_list_hashes
      user_groups_list_table.rows_text.map{ |row| Hash[*user_groups_list_table.headers_text.zip(row).flatten] }
    end

    def set_user_group_filter(filter)
      filter_select.select(filter)
    end

  end
end
