module Bus
  # This class provides actions for user group details section
  class UserGroupDetailsSection < SiteHelper::Section

    # Private elements
    #
    element(:change_name_link, xpath: "//a[text()='Change Name']")
    element(:change_name_input, xpath: "//input[@id='name']")
    element(:change_name_submit, xpath: "//div[starts-with(@id,'group-name-change')]//input[@value='Submit']")
    element(:delete_user_group_link, xpath: "//a[text()='Delete User Group']")
    elements(:group_details_dls, xpath: "//div/dl")
    element(:stash_info_dl, xpath: "//form[starts-with(@id,'user_groups-stash-form')]")
    elements(:user_group_tables, css: "table.table-view")

    #change status
    element(:change_status_link, xpath: "//dt[text()='Status:']/../dd[4]//a[text()='(change)']")
    element(:change_status_submit, xpath: "//dt[text()='Status:']/../dd[4]//input[@value='Submit']")
    element(:change_status_select, xpath: "//select[@id='status']")

    #change default storage
    element(:change_default_storage_link, xpath: "//div[@class='show-details']//dl[2]/dd[3]//span/a[text()='(change)']")
    element(:change_default_storage_input, xpath: "//input[@id='generic_storage_limit']")
    element(:change_default_storage_legacy_desktop_input, xpath: "//input[@id='quota_in_gb_7']")
    element(:change_default_storage_legacy_server_input, xpath: "//input[@id='quota_in_gb_8']")
    element(:change_default_storage_submit, xpath: "//div[@class='show-details']//dl[2]/dd[3]//input[@value='Submit']")


    # Stash section
    element(:change_stash_link, xpath: "//a[contains(@onclick,'change_stash')]")
    element(:cancel_stash_link, xpath: "//a[contains(@onclick,'cancel_change')]")
    element(:stash_status_select, xpath: "//select[starts-with(@id,'user_groups-stash-status-')]")
    element(:stash_default_quota_tb, id: "stash_default_quota")
    element(:submit_stash_status_btn, xpath: "//input[contains(@onclick,'submit_stash_status')]")
    element(:add_stash_to_all_users_link, xpath: "//a[contains(@onclick,'enable_stash_for_all_confirm')]")
    element(:add_stash_to_all_link, xpath: "//a[text()='Enable sync for all users']")

    # client configuration section
    element(:desktop_selected_option, xpath: "//div/label[text()='Desktop']/../select/option[@selected='selected']")
    element(:server_selected_option, xpath: "//div/label[text()='Server']/../select/option[@selected='selected']")
    element(:client_config_submit, xpath: "//fieldset/div/input[@value='Submit']")

    # Keys tab section
    elements(:data_shuttle_table, xpath: "//table/thead/tr/th[text()='Product Key']/../../..")
    element(:total_keys_p, xpath: "//div[starts-with(@id,'user_groups-show')]//li[2]//div[@class='table-metadata'][1]/p[1]")
    elements(:total_keys_page_a, xpath: "//p[text()='Pages: 1 ']/../p[3]/a")
    elements(:current_page_keys_td, xpath: "//div[starts-with(@id,'user_groups-show')]//li[2]//tbody//td[1]")

    #tab tables
    element(:users_table, xpath: "//th/a[text()='User']/../../../..")
    element(:keys_table, xpath: "//th[text()='Product Key']/../../..")
    element(:admins_table, xpath: "//div[starts-with(@id,'user_groups-show')]/ul[2]/li[3]/div/table")

    #confirmation_dialog
    element(:confirmation_dialog, xpath: "//div[@class='popup-window']")
    element(:confirmation_yes_bt, xpath: "//div[@class='popup-window-footer']/input[@value='Yes' and @type='button']")
    element(:confirmation_cancel_bt, xpath: "//div[@class='popup-window-footer']/input[@value='Cancel' and @type='button']")

    # Public: User group details information
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.group_details_hash
    #
    # Returns hash array
    def group_details_hash
      wait_until_bus_section_load
      output = group_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      if has_stash_info_dl?
        stash = stash_info_dl.dt_dd_elements_text.delete_if{ |pair| pair.first.empty? }.map{ |row| [row.first, row[1..-1].join(' ')] }
        output = output + stash
      end
      Hash[*output.flatten]
    end

    # Public: User list details table headers text
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.users_list_table_headers
    #
    # Returns array
    def users_list_table_headers
      user_group_tables[0].headers_text
    end

    # Public: User list details table rows text
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.users_list_table_rows
    #
    # Returns array
    def users_list_table_rows
      user_group_tables[0].rows_text
    end

    def delete_user_group
      wait_until_bus_section_load
      # if user group contains users
      if users_list_table_rows[0].to_s != "[\"\"]"
        delete_user_group_link.click
        alert_accept
      else
        delete_user_group_link.click
      end
    end

    # Public: Enable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.enable_stash
    #
    # Returns nothing
    def enable_stash
      change_stash_link.click
      stash_status_select.select('Yes')
      submit_stash_status_btn.click
      wait_until{ !submit_stash_status_btn.visible? }
    end

    # Public: Cancel Disable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.disable_stash(true)
    #
    # Returns nothing
    def cancel_disable_stash
      change_stash_link.click
      cancel_stash_link.click
    end

    # Public: Disable stash for a partner
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.disable_stash(true)
    #
    # Returns nothing
    def disable_stash
      change_stash_link.click
      stash_status_select.select('No')
      submit_stash_status_btn.click
    end

    # Public: add sync to all users belonging to the current group
    #
    # Example:
    #   @bus_site.admin_console_page.user_group_details_section.add_stash_to_all_user
    #
    # Returns nothing
    def add_stash_to_all_user
      add_stash_to_all_link.click
    #======sleep 5 seconds, if confirmation dialog appears, click Yes button. Otherwise, nothing happens.
      begin
        sleep(5)
        confirmation_yes_bt.click if find(:xpath, "//div[@class='popup-window']")
      rescue
        puts "No confirmation dialog found, testing move formard."
      end
    end

    def users_list_table_hashes
      wait_until_bus_section_load
      users_list_table_rows.map{ |row| Hash[*users_list_table_headers.zip(row).flatten] }
    end

    def click_tab(tab_name)
      find(:xpath, "//li[text()='#{tab_name}']").click
    end

    def desktop_config_value

      if all(:xpath, "//div/label[text()='Desktop']/../select/option[@selected='selected']").size > 0
        desktop_selected_option.text
      else
        "None (Inherited defaults from parent partner)"
      end
    end

    def server_config_value
      if all(:xpath, "//div/label[text()='Server']/../select/option[@selected='selected']").size > 0
        server_selected_option.text
      else
        "None (Inherited defaults from parent partner)"
      end
    end

    def select_client_config(type, client_config)
      case type
        when 'server'
          find(:xpath, "//label[.='Server']/../select/option[.='#{client_config}']").click
        when 'desktop'
          find(:xpath, "//label[.='Desktop']/../select/option[.='#{client_config}']").click
      end
      client_config_submit.click
    end

    def data_shuttle_keys_hashes
      data_shuttle_table[0].hashes
    end

    def search_table_details_hash(match)
      case match
        when 'Users'
          users_table.rows_text.map{ |row| Hash[* users_table.headers_text.zip(row).flatten] }
        when 'Keys'
          keys_table.rows_text.map{ |row| Hash[* keys_table.headers_text.zip(row).flatten] }
        when 'Admins'
          admins_table.rows_text.map{ |row| Hash[* admins_table.headers_text.zip(row).flatten] }
      end
    end

    def change_user_group_name(new_name)
      change_name_link.click
      change_name_input.type_text(new_name)
      change_name_submit.click
    end

    def change_user_group_status(status)
      change_status_link.click
      change_status_select.select(status)
      change_status_submit.click
    end

    def change_legacy_user_group_default_storage(type,storage)
      change_default_storage_link.click
      if type.eql?('desktop')
        change_default_storage_legacy_desktop_input.type_text(storage)
      else
        change_default_storage_legacy_server_input.type_text(storage)
      end
      change_default_storage_submit.click
    end

    def change_user_group_default_storage(storage)
      change_default_storage_link.click
      change_default_storage_input.type_text(storage)
      change_default_storage_submit.click
    end

    def get_total_keys
      total_keys_p.text.strip
    end

    def click_last_keys_page
      total_pages = total_keys_page_a.size
      find(:xpath, "//p[text()='Pages: 1 ']/../p[3]/a[#{total_pages}]").click
    end

    def get_current_page_keys
      current_page_keys_td.size.to_s
    end

    def data_shuttle_text_visible?
      !(locate(:xpath, "//div[contains(text(),'= Data Shuttle')]").nil?)
    end

    #==============================
    # Public  : click user link on the user group list section to access user details section
    #
    # @user_name  : user name
    #==============================
    def click_user(user_name)
      find(:xpath, "//td[text()='#{user_name}']/..//td[2]/a").click
    end

  end
end
