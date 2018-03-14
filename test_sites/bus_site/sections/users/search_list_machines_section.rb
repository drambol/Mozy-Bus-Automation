module Bus
  # This class provides actions for list user groups section
  class SearchListMachinesSection < SiteHelper::Section
    # Private elements
    #
    element(:search_machine_tb, id: "search_box")
    element(:search_machine_btn, xpath: "//div[@id='machine-list-content']/div/form//input[@value='Submit']")
    element(:machine_filter_select, id: "machine_filter")
    element(:search_results_table, xpath: "//div[@id='machine-list-content']/div/table")
    element(:clear_search_link, xpath: "//table[@id=('search_box')]//tr/td[1]/a")
    element(:machine_mapping_link, xpath: "//div[@id='machine-list-content']/p[2]/a")
    element(:export_csv_link, xpath: "//a[contains(@href, 'machine_extension=csv')]")

    #search machine
    element(:search_machine_input, id: "machine_search")
    element(:replace_message, xpath: "//div[@id='machine-list-errors']//li")

    def navigate_to_machine_mapping
      machine_mapping_link.click
    end

    def search_results_hashes
      search_results_table.hashes
    end

    # Public: Search results table header row text
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.search_results_table_headers
    #
    # Returns search results table rows text array
    def search_results_table_headers
      search_results_table.headers_text
    end

    # Public: Search results table body rows text
    #
    # Example
    #
    #  @bus_admin_console_page.search_list_machines_section.search_results_table_rows
    #  # => ["", "qa1+new+user+test@mozy.com", "new user 1", "0", "0 bytes", "0", "none", "08/15/12", "never"]
    #
    # Return search results table body rows text array
    def search_results_table_rows
      search_results_table.rows_text
    end

    # Public: Click to export the machine csv
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.export_csv
    #
    # Returns null
    def export_csv
      export_csv_link.click
    end

    # Public: Get the downloaded machines.csv and users.csv if exist
    #
    # Example
    #   @bus_admin_console_page.search_list_machines_section.machine_user_csv_file
    #
    # Returns ['machines.csv', 'users.csv']
    def machine_user_csv_files machine, user
      flag = 0
      CONFIGS['global']['default_wait_time'].times do
        if file_exists?("#{machine}") && file_exists?("#{user}")
          flag = 1
          break
        end
        sleep(2)
      end
      return [machine, user] if flag == 1
    end

    # Public: Open the machine details section
    #
    # @param [String] machine_name
    #
    # Example
    #   @bus_site.admin_console_page.search_list_machine_section.view_machine_details("AUTOTEST")
    #
    # @return [] nothing
    def view_machine_details(machine_or_user)
      #click machine name link with given user email
      if machine_or_user.include?('@')
        find(:xpath, "//a[text()='#{machine_or_user}']/../../td[2]/a").click
      else
        wait_until{ find_link(machine_or_user).visible? }
        find_link(machine_or_user).click
      end
    end

    def search_list_machines_opened
      search_machine_tb.visible?
    end

    def search_machine(keywords)
      search_machine_input.type_text(keywords)
      search_machine_btn.click
      wait_until_bus_section_load
    end

    def search_machine_empty
      !(locate(:xpath,"//td[contains(text(),'No results')]").nil?)
    end

    def get_replace_machine_message
      replace_message.text
    end

    def click_clear_search
      clear_search_link.click
    end

  end
end
