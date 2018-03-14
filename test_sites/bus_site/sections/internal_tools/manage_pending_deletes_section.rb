module Bus
  # This class provides actions for manage pending deletes section
  class ManagePendingDeletesSection < SiteHelper::Section

    #search input for the three table
    element(:search_partner_pending_delete_input, id: 'pro_partner_pending_delete_search')
    element(:search_partner_available_to_purge_input, id: 'pro_partner_available_to_purge_search')
    element(:search_partner_purged_input, id: 'pro_partner_purged_search')

    element(:full_search_cb, id: 'full_search')

    #change delete days setting
    element(:current_days_span, xpath: "//span[@id='pending_delete_setting_value']")
    element(:change_delete_setting_a, xpath: "//span[@id='modify_pending_delete_setting_read_group']//a")
    element(:change_delete_setting_input, xpath: "//span[@id='modify_pending_delete_setting_write_group']//input")
    element(:change_delete_setting_btn, xpath: "//span[@id='modify_pending_delete_setting_write_group']//button")
    element(:cancel_delete_setting_a, xpath: "//span[@id='modify_pending_delete_setting_write_group']//a")

    #undelete button in 'Partners in Pending-Delete (not yet available to Purge)'
    element(:undelete_btn, xpath: "//form[@id='pending_delete']//input")

    #checkbox of the first record in n 'Partners in Pending-Delete and available to Purge'
    element(:partners_to_undelete_or_purge_input, xpath: "//tr[1]/td[1]/input[@name='partners_to_undelete_or_purge']")

    #undelete, purge button in 'Partners in Pending-Delete and available to Purge'
    element(:undelete_available_to_purge_btn, id: 'undelete')
    element(:purge_btn, id: 'purge')
    element(:password_tb, xpath: "//div[@id='purge-password-confirm']//input")
    element(:submit_purge_btn, xpath: "//div[@class='popup-window-footer']//input[@value='Submit']")

    #search submit button on the three table
    element(:search_partner_pending_delete_btn, xpath: "//input[@id='pro_partner_pending_delete_search']//..//input[@value='Submit']")
    element(:search_partner_available_to_purge_btn, xpath: "//input[@id='pro_partner_available_to_purge_search']//..//input[@value='Submit']")
    element(:search_partner_purged_btn, xpath: "//input[@id='pro_partner_purged_search']//..//input[@value='Submit']")

    #not available to purge table, available to purge table, who has been purged table
    element(:search_results_pending_delete_table, xpath: "//h4[contains(text(),'not yet available to Purge')]//../div[2]/table")
    element(:search_results_available_to_purge_table, xpath: "//h4//b[contains(text(),'and')]//..//../div[5]/table")
    element(:search_results_purged_table, xpath: "//h4[contains(text(),'been Purged')]//../div[7]/table")

    # Public: Search partner on Manage Pending Delete
    #
    #
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.search_partners("pending-delete not available to purge","Babbleset Company 0728-1929-21")
    #
    # @return [] nothing
    def search_partners(match, search_key, full_search = false)
      wait_until_bus_section_load
      # By default, full search is not checked
      if full_search
        full_search_cb.check
      else
        full_search_cb.uncheck
      end
      case match
        when 'pending-delete not available to purge'
          search_partner_pending_delete_input.type_text(search_key)
          search_partner_pending_delete_btn.click
        when 'pending-delete available to purge'
          search_partner_available_to_purge_input.type_text(search_key)
          search_partner_available_to_purge_btn.click
        when 'who have been purged'
          search_partner_purged_input.type_text(search_key)
          search_partner_purged_btn.click
      end
      wait_until_bus_section_load
    end

    # Public: Search results hashes
    #         Converts results table into an Array of Hash where the keys of each Hash are the headers in the table.
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.search_results_hashes("pending-delete not available to purge")
    #
    # Returns hash array
    def search_results_hashes(match)
      case match
        when 'pending-delete not available to purge'
          search_results_pending_delete_table.rows_text.map{ |row| Hash[* search_results_pending_delete_table.headers_text.zip(row).flatten] } unless search_results_pending_delete_table.text.include?("No results found")
        when 'pending-delete available to purge'
          search_results_available_to_purge_table.rows_text.map{ |row| Hash[*search_results_available_to_purge_table.headers_text.zip(row).flatten] } unless search_results_available_to_purge_table.text.include?("No results found")
        when 'who have been purged'
          search_results_purged_table.rows_text.map{ |row| Hash[*search_results_purged_table.headers_text.zip(row).flatten] } unless search_results_purged_table.text.include?("No results found")
      end
    end

    # Public: change days to purge partner after delete
    #
    #
    # Example
    #   @bus_site.admin_console_page.manage_pending_deletes_section.change_days_setting("60")
    #
    # @return [] nothing
    def change_pending_deletes_setting(days)
      change_delete_setting_a.click
      change_delete_setting_input.type_text(days)
      change_delete_setting_btn.click
      wait_until_bus_section_load
    end

    # Public: make sure days to purge partner after delete if default value
    #
    #
    # Example
    #   @bus_site.admin_console_page.manage_pending_deletes_section.change_pending_deletes_setting_to_default("60")
    #
    # @return [] nothing
    def change_pending_deletes_setting_to_default(days)
      if current_days_span.text.strip != (days)
        change_delete_setting_a.click
        change_delete_setting_input.type_text(days)
        change_delete_setting_btn.click
        wait_until_bus_section_load
      end
    end

    # Public: get days to purge partner after delete
    #
    #
    # Example
    #   @bus_site.admin_console_page.manage_pending_deletes_section.get_pending_deletes_setting
    #
    # @return [] nothing
    def get_pending_deletes_setting
      current_days_span.text.strip
    end

    # Public: purge partner on 'Partners in Pending-Delete and available to Purge'
    #
    #
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.purge_partner("Naich4yei8", "Babbleset Company 0728-1929-21")
    #
    # @return [] nothing
    def purge_partner(password, partner_name)
      partners_to_undelete_or_purge_input.check
      purge_btn.click
      password_tb.type_text(password)
      submit_purge_btn.click
      wait_until_bus_section_load
    end


    # Public: undelete partner on 'Partners in Pending-Delete (not yet available to Purge)' and 'Partners in Pending-Delete and available to Purge'
    #
    #
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.undelete_partner("pending-delete not available to purge", "Babbleset Company 0728-1929-21")
    #
    # @return [] nothing
    def undelete_partner(where, partner_name)
      find(:xpath, "//a[text()='#{partner_name}']//..//../td[1]//input").check
      case where
        when 'pending-delete not available to purge'
          undelete_btn.click
        when 'pending-delete available to purge'
          undelete_available_to_purge_btn.click
      end
      wait_until { locate(:xpath, "//a[text()='#{partner_name}']//..//../td[1]//input").nil? }
      wait_until_bus_section_load
    end

    # Public: get 'No results found' text
    #
    #
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.pending_deletes_table_text("pending-delete available to purge")
    #
    # @return string
    def pending_deletes_table_text(table)
      case table
        when 'pending-delete not available to purge'
          search_results_pending_delete_table.text
        when 'pending-delete available to purge'
          search_results_available_to_purge_table.text
      end
    end

    # Public: get undelete button number on who has been purged table
    #
    #
    # Example
    #  @bus_site.admin_console_page.manage_pending_deletes_section.undelete_button_on_purged_table()
    #
    # @return string
    def undelete_button_on_purged_table
      all(:xpath, "//h4[contains(text(),'been Purged')]//../div[7]//*[@value='Undelete']").size
    end

  end
end
