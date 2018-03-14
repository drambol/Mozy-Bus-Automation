module Bus
  # This class provides actions for search list users section
  class SearchListItemizedUsersSection < SiteHelper::Section
    # Private elements
    #
    element(:search_user_tb, id: 'user_search')
    element(:search_user_btn, css: 'table#search_box input[value=Submit]')
    element(:user_filter_select, id: 'user_filter')
    element(:partner_filter_select, id: 'partner_filter')
    element(:search_results_table, css: 'table.table-view')
    element(:clear_search_link, xpath: "//a[text()='Clear search']")
    element(:export_csv_link, css: 'p.table-export-links a')

    # Public: Search user
    #
    # @keywords         [String]
    # @filter           [String]
    # @partner_filter   [String]
    #
    # Examples:
    #  @bus_admin_console_page.search_list_users_section.search_user("qa1+test@mozy.com")
    #
    # @return [] nothing
    def search_user(keywords, filter = 'None', partner_filter = '')
      search_user_tb.type_text(keywords)
      user_filter_select.select(filter)
      unless partner_filter.empty?
        partner_filter_select.select(partner_filter)
      end
      search_user_btn.click
      wait_until_bus_section_load
    end

    # Public: Search results hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.                                                                                               # Example
    #
    # Examples:
    #  @bus_admin_console_page.search_list_users_section.search_results_hashes
    #  # => ["User"=>"user@mozy.com", "Name"=>"Test User", "Machines"=>0, "Storage"=>"15 GB", “Storage Used"=>0, "Created"=>"08/15/12"", "Backed Up"=>"never"]
    #
    # @return [Hash<String>]
    def search_results_hashes
      search_results_table.hashes
    end

    # Public: Search results table header row text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_users_section.search_results_table_headers
    #  # => ["User", "Name", "Machines", "Storage", “Storage Used", "Created", "Backed Up"]
    #
    # Returns search results table rows text array
    def search_results_table_headers
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Examples:
    #  @bus_admin_console_page.search_list_users_section.search_results_table_rows
    #  # => ["", "qa1+new+user+test@mozy.com", "new user 1", "0", "0 bytes", "0", "none", "08/15/12", "never"]
    #
    # Return search results table body rows text array
    def search_results_table_rows
      search_results_table.rows_text
    end

    # Public: Click the user link to view user details
    #
    # Examples:
    #  @bus_admin_console_page.search_list_users_section.view_user_details('qa1+new+user+test@mozy.com')
    #
    #@return [] nothing
    def view_user_details(user)
      find_link(user).click
    end

    # Public: Click the export csv link to download the users table
    #
    # Examples:
    #  @bus_admin_console_page.search_list_users_section.export_users_csv
    #
    # @return [] nothing
    def export_csv
      export_csv_link.click
    end


    def sort_users_by(column_name)
      target = search_results_table.headers.select{ |col| col.text == column_name}
      target.first.find(:css, 'a').click
      wait_until_bus_section_load
    end
  end
end
