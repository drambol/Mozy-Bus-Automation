module Bus
  # This class provides user details
  class UserDetailsSection < SiteHelper::Section
    # Private elements
    #

    elements(:general_info_dls, css: 'div>dl')
    # top menus
    element(:delete_user_link, xpath: "//a[text()='Delete User']")
    element(:change_user_password_link, xpath: "//a[text()='Change User Password']")
    element(:allow_re_activation_a, xpath: "//a[text()='Allow Re-Activation']")

    elements(:user_details_dls, xpath: "//div[starts-with(@id,'user-show')]//div[3]/dl")
    element(:change_status_link, xpath: "//span[starts-with(@id,'user-display-status-')]//a")
    element(:status_selection, css: 'select#status')
    element(:submit_status_btn, css: 'span[id^=user-change-status-]>input')
    element(:change_user_group_link, xpath: "//span[starts-with(@id,'user-display-usergroup-')]//a[text()='(change)']")
    element(:change_user_group_submit_button, xpath: "//span[starts-with(@id,'user-change-usergroup-')]//input[@name='commit']")
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")
    element(:user_group_details_link, xpath: "//span[starts-with(@id,'user-display-usergroup-')]//a[starts-with(@href, '/user_groups/show/')]")
    element(:change_partner_link, xpath: "//span[starts-with(@id,'user-display-partner-')]//a[text()='(change)']")
    element(:partner_name_text, xpath: "//input[@name='partner_name']")
    element(:change_partner_submit_button, xpath: "//span[starts-with(@id,'user-change-partner-')]//input[@name='commit']")
    element(:view_product_keys_link, xpath: "//a[text()='(View Product Keys)']")
    element(:product_key_lbl, xpath: "//div[starts-with(@id, 'all-license-keys-')]//div/div/div[2]/table[2]/tbody/tr/td")

    elements(:product_keys_tables, css: 'div[id^=all-license-keys-] table.mini-table')

    element(:change_external_id_link, xpath: "//dt[text()='External ID:']/following-sibling::dd[1]//a[text()='(change)']")
    element(:external_id_tb, id: "external_id")
    element(:submit_external_id_btn, xpath: "//dt[text()='External ID:']/following-sibling::dd[1]//input[@value='Submit']")

    # Add Stash
    element(:add_stash_link, xpath: "//a[text()='(Add Sync)']")
    element(:stash_quota_tb, css: "form[id^=stash-form-] input#quota")
    element(:send_email_cb, css: "form[id^=stash-form-] input#send_email")
    element(:submit_stash_btn, css: "form[id^=stash-form-] input[value=Submit]")
    element(:cancel_stash_btn, xpath: "//form[starts-with(@id,'stash-form-')]//a[text()='(cancel)']")
    element(:send_invitation_link, xpath: "//a[text()='(Send Invitation Email)']")

    # Install Region Override
    element(:change_region_link, xpath: "//form[contains(@id,'install-region-override-form')]/span[1]/a")
    element(:change_region_select, xpath: "//div[@class='show-details']//select[@id='install_region_override']")
    element(:change_region_submit_btn, xpath: "//form[contains(@id,'install-region-override-form')]/span[2]/input")

    # Change Stash Quota
    element(:change_stash_quota_link, css: "a[id^=edit_quota_for_user_show]")
    element(:cancel_change_stash_quota_link, css: "a[id^=cancel_edit_quota_for_user_show_]")
    element(:change_stash_quota_tb, css: "input[id^=quota_in_gb_for_user_show_]")
    element(:change_stash_quota_btn, css: "div[id^=change_quota_for_user_show_] input[value='Save']")
    element(:change_quota_tooltips, css: "span[id^=tooltip_for_user_show_]")
    element(:delete_stash_link, css: "a[onclick^=show_delete_stash_popup]")

    # User Storage Device Info
    elements(:storage_device_labels, css: ".div_row .label")
    elements(:storage_device_text, css: ".div_row:nth-child(2)")

    # Change Device Quota
    elements(:device_edits, {css: "form[action^='/user/change_device_count/'] span[class=view] a"}, true)
    element(:device_count, {css: "input#device_count"}, true)
    elements(:device_counts, css: "input#device_count")
    element(:device_edit_submit, {css: "input#device_count + input.button"}, true)
    element(:device_edit_cancel, {css: "input#device_count + input.button + a"}, true)
    elements(:device_status, {css: "div.show-details>div>div:first-child>div:nth-child(2)>div>span.view:first-child"}, true)
    elements(:device_tooltips, {css: "span.storage_pool_quota_tooltip"}, true)
    element(:machine_max_tooltips, css: "span[id^=tooltip_for_machine]")

    # user backup information table
    element(:user_backup_details_table, xpath: "//div[starts-with(@id, 'user-show')]//div[2]/table")

    # User Storage Device Info
    elements(:storage_device_labels, css: ".div_row .label")
    elements(:storage_device_text, css: ".div_row:nth-child(2)")

    element(:verify_user_link, css: 'a[onclick*=consumer_verify]')
    element(:user_verified_msg, css: "ul[class='flash successes'] li")
    element(:login_as_user_link, css: 'a[href*=login_as_user]')

    element(:device_table, css: 'table.mini-table')

    element(:edit_device_a, xpath: "//span[@class='view']//a[text()='Edit']")
    element(:edit_device_input, id: "device_count")
    element(:edit_device_cancel_a, xpath: "//input[@id='device_count']/../a[text()='(cancel)']")



    #Sync details link
    element(:sync_details_link, xpath: "//table[@class='mini-table']//a[text()='Sync']")

    # device section
    element(:device_details_link, xpath: "//table[@class='mini-table']/tbody/tr[1]/td[1]/a")
    element(:device_details_td, xpath: "//table[@class='mini-table']/tbody/tr[1]/td[1]")
    elements(:device_info_hash, xpath: "//table[@class='mini-table']//a[text()='Sync']/../../td")
    element(:error_message, xpath: "//ul[@class='flash errors']/li")
    element(:no_computer_msg, xpath:  "//table[@class='mini-table']//tr/td")

    # Change User Password
    element(:new_password_tb, id: 'new_password')
    element(:new_password_confirm_tb, id: 'new_password_confirmation')
    element(:new_password_change_btn, css: "div[id^=user-pass-change] input[value='Save Changes']")
    element(:temporary_password_check, id: 'is_temporary')

    # License Keys
    element(:send_keys_btn, xpath: '//div[starts-with(@id, "all-license-keys")]/descendant::input[starts-with(@id, "send_key")]')

    #downgrade
    element(:expand_subscriptions_th, xpath: "//th[contains(@id,'sub-')]")
    element(:edit_plan_a, xpath: "//a[text()='Edit Plan (Downgrade Only)']")
    element(:mozyhome_user_quota_td, xpath: "//table[@class='mini-table'][2]/tbody/tr[1]/td[1]")
    element(:mozyhome_user_status_td, xpath: "//table[@class='mini-table'][2]/tbody/tr[1]/td[4]")

    #expires
    element(:expand_extend_a, xpath: "//a[.='(extend)']")
    element(:extend_input, xpath: "//input[@value='extend']")
    element(:expire_a, xpath: "//a[.='(extend)']/../../td[5]")

    # refund link
    element(:refund_a, xpath: "//a[text()='Refund now']")
    element(:refund_amount_input, id: "refund_amount")
    element(:refund_submit_input, xpath: "//span[starts-with(@id,'refund-transaction-')]/form/input[@value='Submit']")
    element(:refunded_amount_td, xpath: "//div[@class='show-details']//table[@class='table-view']//tr[1]//td[4]")

    elements(:all_billing_info, xpath: "//td[starts-with(text(),'Cybersource')]/../../tr")
    element(:user_billing_table, css: "table.table-view")

    #desktop storage limit
    element(:user_storage_limit_span, xpath: "//span[contains(text(),'User Storage Limit: ')]/../span[2]")
    element(:edit_user_storage_limit_a, xpath: "//a[contains(@id,'edit-user-storage-max')][text()='Edit']")
    element(:remove_user_storage_limit_a, xpath: "//a[contains(@id,'remove-user-storage-max')]")
    element(:input_user_storage_limit_input, xpath: "//input[contains(@id,'input-user-storage-max')]")
    element(:save_user_storage_limit_a, xpath: "//a[contains(@id,'save-user-storage-max')]")
    element(:cancel_user_storage_limit_a, xpath: "//a[contains(@id,'cancel-edit-user-storage-max')]")
    element(:user_storage_limit_set_a, xpath: "//a[contains(@id,'set-user-storage-max')]")
    element(:user_storage_limit_help_img, xpath: "//form[contains(@id,'form-set-max-pooled-storage')]/img[@class='tooltip']")

    #set machine storage
    element(:device_storage_limit_span, xpath: "//span[contains(text(),'User Storage Limit: ')]/../span[2]")

    #buy more link
    element(:buy_more_a, xpath: "//div[contains(@id,'user-show')]//a[text()='Buy More']")

    #delete sync container
    element(:delete_sync_i, xpath: "//i[@class='icon-trash icon-2x']")
    element(:delete_sync_yes, xpath: "//input[@value='Yes']")
    element(:delete_device_yes, xpath: "//div[@class='popup-window']//input[@value='Yes' and @type='button']")
    element(:delete_device_no, xpath: "//div[@class='popup-window']//input[@value='No' and @type='button']")
    element(:delete_device_dlg, xpath: "//div[@class='popup-window']")

    # Change Machine Quota under user details for OEM partners
    element(:change_machine_quota_link, css: "a[id^=edit_quota_for_user_show]")
    element(:change_machine_quota_tb, css: "input[id^=quota_in_gb_for_user_show_]")
    element(:change_machine_quota_btn, css: "div[id^=change_quota_for_user_show_] input[value='Save']")


    #elements(:sync_device_info_hash, xpath: "//a[text()='Sync']/../../td")
    #element(:error_message, xpath: "//ul[@class='flash errors']/li")
    #element(:delete_device_dlg, xpath: "//div[@class='popup-window']")
    #element(:delete_device_dlg_Yes, xpath: "//div[@class='popup-window']//input[@value='Yes' and @type='button']")
    #element(:delete_device_dlg_No, xpath: "//div[@class='popup-window']//input[@value='No' and @type='button']")


    # Public: User details storage, devices, storage limit hash
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.storage_device_info
    #
    # @return [Hash]
    # e.g. {"Storage" => "Desktop: 0 Used / 10 GB Available", "Devices" => "Desktop: 0 Used / 1 Available Edit", "Desktop User Storage Limit:" => "10 GB Edit Remove"}
    # NOTE: Only tested new partners, for migrated users with 2 types of storage may not work properly
    # TODO: Test users with 2 types of storage
    def storage_device_info
      table = {}
      storage_device_labels.each_with_index do | key, index |
        table[key.text] = storage_device_text[index].text
        Log.debug "current pair key #{key.text} and value #{table[key]}"
      end
      table
    end

    def device_status_hashes
      wait_until_bus_section_load
      r = []
      device_status.each do |status|
        status = status.text
        actual = {}
        actual['storage_type'] = status[/\b(\w*):/, 1]
        actual['used'] = status[/(\d+) Used/, 1]
        actual['available'] = status[/(\d+|Unlimited) Available/, 1]
        r << actual
      end
      r
    end

    def activated_keys_table_rows
      product_keys_tables.first.rows_text
    end

    def unactivated_keys_table_rows
      product_keys_tables.last.rows_text
    end

    def general_info_hash
      wait_until_bus_section_load
      output = general_info_dls[0].dt_dd_elements_text + general_info_dls[1].dt_dd_elements_text
      Hash[*output.flatten]
    end

    # Public: User details hash
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.user_details_hash
    #
    # @return [Hash]
    def user_details_hash
      wait_until_bus_section_load(:xpath => "//dt[text()='Name:']")
      output = user_details_dls.map{ |dl| dl.dt_dd_elements_text }.delete_if { |k| k.empty? }
      Hash[*output.flatten]
    end

    # Public: User id
    #
    # @param [] none
    #
    # Example:
    #   # => user_details_details_section.user_id
    #
    # @return [String]
    def user_id
      user_details_hash['ID:']
    end

    # Public: Enable stash for a user
    #
    # @params [bool] send_email
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.add_stash
    #
    # @return [] nothing
    def add_stash(send_email)
      add_stash_link.click
      send_email_cb.check if send_email
      submit_stash_btn.click
      wait_until_bus_section_load
    end

    # Public: Click add stash link then click cancel link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_add_stash
    #
    # @return [] nothing
    def cancel_add_stash
      add_stash_link.click
      cancel_stash_btn.click
    end

    # Public: Change stash quota for a user
    #
    # @params [string] quota
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.change_stash_quota('10')
    #
    # @return [] nothing
    def change_stash_quota(quota)
      handle_max('edit', 'machine', 'Sync')
      set_max_value('machine', 'Sync', quota)
      handle_max('save', 'machine', 'Sync')
    end

    def add_stash_quota(quota)
      handle_max('set', 'machine', 'Sync')
      set_max_value('machine', 'Sync', quota)
      handle_max('save', 'machine', 'Sync')
    end

    # Public: Click change stash link then click cancel link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.cancel_change_stash_quota
    #
    # @return [] nothing
    def cancel_change_stash_quota
      change_stash_quota_link.click
      cancel_change_stash_quota_link.click
    end

    # Public: Click change stash quota text box to trigger popup box
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_change_quota_tb
    #
    # @return [] nothing
    def click_change_quota_tb
      change_stash_quota_link.click
      change_stash_quota_tb.click
    end

    # Public: Find change stash quota popup box by tips text
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.find_change_quota_tooltips('Max: 100 GB')
    #
    # @return [] nothing
    def find_change_quota_tooltips(text)
      tooltips = find(:xpath, "//span[text()='#{text}']")
      # I cannot check tooltips.visible?, since change_stash_quota_tb element will out of focus immediately
      # I will always get false value
      # So as far as I can find tooltips by hover text, I consider tooltips works fine
      !tooltips.nil?
    end

    # Public: Click delete link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.click_delete_stash_link
    #
    # @return [] nothing
    def click_delete_stash_link
      delete_stash_link.click
    end

    # Public: Click send stash invitation email link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.send_stash_invitation_email
    #
    # @return [] nothing
    def send_stash_invitation_email
      send_invitation_link.click
      wait_until_bus_section_load
      sleep 5 # wait for email to send
    end

    # Public: Click delete link
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.click_delete_stash
    #
    # @return [] nothing
    def click_delete_stash
      delete_stash_link.click
    end

    def check_sync_exist
      !(locate(:xpath,"//table[@class='mini-table']//a[text()='Sync']").nil?)
    end

    # Public: Return user back up details table rows
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.user_backup_details_table_rows
    #
    # @return [String]
    def user_backup_details_table_rows
      user_backup_details_table.rows_text
    end

    # Public: Activate user 
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.active_user
    #
    # @return [] nothing
    def change_user_status(status)
      change_status_link.click
      if status.eql?('activate')
        status_selection.select('Active')
      else
        status_selection.select('Suspended')
      end

      submit_status_btn.click
    end

    # Public: Return error messages
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_section.messages
    #
    # @return [String]
    def messages
      message_div = find(:css, "div#user-show-#{user_id}-errors ul")
      message_div.text
    end

    def verify_user
      verify_user_link.click
    end

    def user_verified
      user_verified_msg.text
    end

    def login_as_user
      login_as_user_link.click
    end

    # Public: Click change link
    #    Select new user group
    #    Click submit button
    #    Refresh module
    #    Verify user group changed
    #
    # @param [Object] user
    # @param [String] new_user_group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.update_user_group(@user, "Test Group 1")
    #
    # @return [nothing]
    def update_user_group(user, new_user_group)
      change_user_group_link.click
      user_group_search_img.click
      sleep 2
      find(:xpath, "//li[text()='#{new_user_group}']").click
      move_user_start_time = Time.now.utc
      change_user_group_submit_button.click
      wait_until{ !change_user_group_submit_button.visible? }
      move_user_end_time = Time.now.utc
      log("KPI-Move_User:start_time:#{move_user_start_time}/end_time:#{move_user_end_time}")
      user.user_group = new_user_group unless user.user_group.nil? unless user.nil?
    end

    # Public: Returns user's user group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.users_user_group("User Group 1")
    #
    # @return [Boolean]
    def users_user_group(user_group)
      find(:xpath, "//a[text()='#{user_group}']")
    end

    # Public: Returns user's user name
    #
    # Example
    #    @bus_admin_console_page.user_details_section.users_user_name("User name 1")
    #
    # @return [String]
    def users_user_name
      find(:xpath, "//form[contains(@action, 'change_name')]/span[@class='view']").text
    end

    # Public: Click change link
    #    Select new user group
    #    Click submit button
    #    Refresh module
    #    Verify user group changed
    #
    # @param [Object] user
    # @param [String] new_user_group
    #
    # Example
    #    @bus_admin_console_page.user_details_section.update_user_group(@user, "Test Group 1")
    #
    # @return [nothing]
    def update_partner(new_partner)
      puts "new partner is #{new_partner}"
      change_partner_link.click
      user_group_search_img.click
      sleep 2
      if new_partner.size > 31
        display_end = new_partner[-9,9]
        new_partner_xpath = "//li[contains(text(),'#{display_end}')]"
      else
        new_partner_xpath = "//li[text()='#{new_partner}']"
      end
      find(:xpath, new_partner_xpath).click
      change_partner_submit_button.click
      wait_until{ !change_partner_submit_button.visible? }
    end

    def find_match_partners(key_input)
      change_partner_link.click
      partner_name_text.type_text(key_input)
      user_group_search_img.click
      sleep 2
      element_list = page.driver.browser.find_elements(:xpath, "//li[contains(text(), '#{key_input}')]")
      element_list.map{|element|element.text.strip}.size
    end

    # Public: Returns user's partner
    #
    # Example
    #    @bus_admin_console_page.user_details_section.user_partner("Enterprise Root")
    #
    # @return [Boolean]
    def user_partner(user_partner)
      find(:xpath, "//a[text()='#{user_partner}']")
    end

    # Public: Click Delete User
    #    Click confirmation
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.delete_user
    #
    # @return [nothing]
    def delete_user
      delete_user_link.click
      alert_accept
      wait_until{ has_no_link?("Delete User") }
    end

    def device_table_headers
      device_table.headers_text
    end

    def device_table_rows
      if device_stash_divide_row_index.nil?
        device_table.rows_text
      else
        device_table.rows_text[0..device_stash_divide_row_index-1]
      end
    end

    def device_table_hashes
      device_table_rows.map{ |row| Hash[*device_table_headers.zip(row).flatten] }
    end

    def stash_table_headers
      result = device_table.headers_text
      unless device_stash_divide_row_index.nil?
        result[0] = device_table.rows_text[device_stash_divide_row_index + 1].first
      end
      result
    end

    def stash_table_rows
      unless device_stash_divide_row_index.nil?
        device_table.rows_text.last
      end
    end

    def stash_table_hashes
      Hash[*stash_table_headers.zip(stash_table_rows).flatten]
    end

    # Delete a device. Accept multiple arguments to support following scenarios
    # To delete a device only by device name, don't care keeping data or not, provide one argument. e.g.,
    #   - delete_device("machine001")
    # To delete a device and require to keep data, or not keep data, provide two arguments. e.g,
    #   - keep data: delete_device("machine001", "with")
    #   - not keep data: delete_device("machine001", "without")
    def delete_device(*args)
      if args.size == 1
        msg = ''
        device_name = args[0]
        device_table.rows.each do |row|
          if row[0].text == device_name
            row[-1].find(:css, 'form[id^=machine-delete] a.action').click
            msg = alert_text
            alert_accept
            break;
          end
        end
        msg
      else
        device_name = args[0]
        data_keep = args[1]
        #click on the set input textbox
        find(:xpath, "//a[text()='#{device_name}']/../../td[5]//a[contains(@onclick, 'show_delete_stash_popup')]").click
        wait_until{ delete_device_dlg }
        puts "Find Delete dialog"
        delete_device_yes.click if data_keep == "with"
        delete_device_no.click if data_keep == "without"
      end
    end

    def delete_sync
      delete_sync_i.click
      delete_sync_yes.click
      wait_until{add_stash_link.visible?}
    end

    # when view the device which has been deleted,deleted will be shown next to the device name
    def view_device_details(device_name, deleted = false)
      device_name_row = (deleted ? device_name + ' (deleted)' : device_name)
      device_table.rows.each do |row|
        if row[0].text == device_name_row
          row[0].find(:xpath, "//a[text()='#{device_name}']").click
          wait_until{ find(:xpath, "//dt[text()='Owner:']").visible? }
          break
        end
      end
    end

    def device_exist(device_name)
      flag = false
      device_table.rows.each do |row|
        if row[0].text == device_name
          flag = true
          break
        end
      end
      flag
    end

    def click_view_product_keys_link
      view_product_keys_link.click
      wait_until{ send_keys_btn.visible? }
    end

    def product_key
      product_key_lbl.text
    end

    def user
      { :id => general_info_hash['ID:'],
        :email => find(:css, "div.header-bar > h3").text,
        :name => general_info_hash['Name:'][/^(.*)(change)$/, 1]}
    end

    def edit_password(password, is_temporary = false)
      if !new_password_tb.visible?
        change_user_password_link.click
        wait_until_bus_section_load
      end
      new_password_tb.type_text(password)
      new_password_confirm_tb.type_text(password)
      temporary_password_check.uncheck unless is_temporary
      update_user_pwd_start_time = Time.now.utc
      new_password_change_btn.click
      wait_until_bus_section_load
      update_user_pwd_end_time = Time.now.utc
      log("KPI-Update_User_PWD:start_time:#{update_user_pwd_start_time}/end_time:#{update_user_pwd_end_time}")
    end

    def edit_password_with_incorrect_pass(password)
      if !new_password_tb.visible?
        change_user_password_link.click
        wait_until_bus_section_load
      end
      new_password_tb.type_text(password)
      new_password_confirm_tb.type_text(password)
      new_password_change_btn.click
      wait_until { alert_present? }
      text = alert_text
      alert_accept
      text
    end

    def has_link(link)
      locate_link(link)
    end

    def change_device_quota(count, type=nil)
      wait_until_bus_section_load
      device_edits.each_index do |i|
        if type.nil? || device_edits[i].great_grandparent.text =~ Regexp.new(type.strip.capitalize)
          device_edits[i].click
          device_count.type_text(count)
          device_edit_submit.click
          wait_until_bus_section_load
        end
      end
    end

    def device_edit_and_cancel(count, type=nil)
      device_edits.each_index do |i|
        if type.nil? || device_edits[i].great_grandparent.text =~ Regexp.new(type.strip.capitalize)
          device_edits[i].click
          device_count.type_text(count)
          device_edit_cancel.click
        end
      end
    end

    def device_range(type=nil)
      tooltip = {}
      device_counts.each do |device_count|
        if type.nil? || device_count.great_grandparent.text =~ Regexp.new(type.strip.capitalize)
          tip_text = device_count[:onfocus][/'(Min: \d+, Max: \d+)'/, 1]
          tooltip['min'] = tip_text[/Min: (\d+)/, 1]
          tooltip['max'] = tip_text[/Max: (\d+)/, 1]
        end
      end
      tooltip
    end

    def get_machine_id(device)
      a = find(:xpath, "//table[@class='mini-table']//td[1]/a[text()='#{device}']")[:href]
      a[/\/admin\/view_restores\/(\d+)$/, 1].to_i
    end

    def view_sync_details
      sync_details_link.click
    end

    # Public: Click send user keys
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.click_send_user_keys
    #
    # @return [nothing]
    def click_send_user_keys
      send_keys_btn.click
    end

    def set_user_email(email)
      find_link("Change User Email").click
      find(:id, "username").type_text email
      e = find(:xpath, "//div[contains(@id, 'user-username-change-')]//input[@value='Save Changes']")
      e.click
      wait_until{ !e.visible? }
    end

    def set_user_name(name)
      find(:xpath, "//form[contains(@action, 'change_name')]//a[contains(text(),'(change)')]").click
      find(:id, "name").type_text name
      e = find(:xpath, "//div[contains(@id, 'user-show-')]//input[@name='commit']")
      e.click
      wait_until{ !e.visible? }
    end

    def set_user_status(status)
      case status
        when "cancelled"
          find(:xpath, "//div[contains(@id, 'user-show-')]//a[contains(text(),'(cancel)')]").click
          alert_accept
        when "active"
          find(:xpath, "//div[contains(@id, 'user-show-')]//a[contains(text(),'(uncancel)')]").click
      end
    end

    def handle_max(action, type, name, confirm=true)
      case type
        when 'machine'
          action = 'cancel-edit' if action == 'cancel'
          ctl = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, '#{action}-machine-storage-max')]")
          ctl.click
          if action == 'remove'
            confirm ? alert_accept : alert_dismiss
          end
        when 'user'
          case action
            when 'remove'
              find(:xpath, "//a[contains(@id,'remove-user-storage-max')]").click
              alert_accept
          end
      end

      if action == 'save' or action == 'remove'
        if alert_present?
          alert_msg = alert_text
          alert_accept
        end
        wait_until_bus_section_load
      end
      alert_msg
    end

    def set_max_value(type, name, quota)
      case type
        when 'machine'
          max_input = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, 'input-machine-storage-max')]")
          wait_until { max_input.visible? }
          max_input.click
          Log.debug machine_max_tooltips.text
          max_input.type_text(quota)
        when 'user'
          #TODO
      end
    end

    def machine_max_range(name)
      tooltip = {}
      max_input = find(:xpath, "//table[@class='mini-table']//a[text()='#{name}']/../../*[last()-2]//*[starts-with(@id, 'input-machine-storage-max')]")
      tip_text = max_input[:onfocus][/'(Min: \d+ GB, Max: \d+ GB)'/, 1]
      Log.debug tip_text
      tooltip['min'] = tip_text[/Min: (\d+)/, 1]
      tooltip['max'] = tip_text[/Max: (\d+)/, 1]
      tooltip
    end

    # jm: code for hashing user subscription info
    element(:bar_information, xpath: "//div[@class='show-details']/table[@class='mini-table'][2]")

    # returns a hash of user subscription data
    def mozyhome_user_details_hash
      user_details_hash = Hash.new
      bar_information.headers_text.each_with_index { |header,index| user_details_hash[header] = bar_information.rows_text[0][index] }
      Log.debug(user_details_hash)
      user_details_hash
    end

    # Public: Is "Send Keys" button disabled?
    #
    # @param [none]
    #
    # Example
    #    @bus_admin_console_page.user_details_section.send_keys_button_disabled?
    #
    # @return [nothing]
    def send_keys_button_disabled?
      send_keys_btn['disabled'] == 'true'
    end

    def click_user_group_details_link
      user_group_details_link.click
    end

    # Install Region Override
    def change_region(region)
      change_region_link.click
      change_region_select.select(region)
      change_region_submit_btn.click
    end

    def click_send_activation_email_again
      find(:xpath, "//a[text()='Send activation email again']").click
    end

    def expand_subscriptions
      expand_subscriptions_th.click
    end

    def click_edit_plan
      edit_plan_a.click
    end

    def downgrade_user(match)
      if match.eql?('50GB')
        find(:xpath, "//a[text()='Change to MozyHome 50 GB']").click
      else
        find(:xpath, "//a[text()='Revert to Free']").click
      end
      alert_accept
      wait_until_bus_section_load
    end

    def get_mozyhome_user_quota
      mozyhome_user_quota_td.text
    end

    def get_mozyhome_user_status
      mozyhome_user_status_td.text
    end

    def extend_mozyhome_user_exipre(n, units)
      expand_extend_a.click
      find(:xpath, "//div[contains(@id, 'extend')]/form/select[@id='n']/option[.='#{n}']").click
      find(:xpath, "//div[contains(@id, 'extend')]/form/select[@id='units']/option[.='#{units}']").click
      extend_input.click
      wait_until_bus_section_load
    end

    def get_mozyhome_user_expire_time
      expire_a.text.sub(/ \(extend\)/, '')
    end

    def refund_user(amount)
      refund_a.click
      before_amounts = refund_amount_input[:value]
      amount = before_amounts if amount.eql?('all')
      refund_amount_input.type_text(amount)
      refund_submit_input.click
      alert_accept
      amount
    end

    def get_device_name
      device_details_td.text
    end

    def get_refunded_amount
      refunded_amount_td.text
    end

    def get_user_billed_info
      all_billing_info.size
    end

    def click_allow_reactivation
      allow_re_activation_a.click
      alert_accept
    end

    def check_allow_reactivation_available
      allow_re_activation_a.visible?
    end

    def get_restore_vms_hints(type)
      locate(:xpath, "//a[@title='#{type}']")
    end

    def get_user_storage_limit
      user_storage_limit_span.text.strip
    end

    def edit_user_storage_limit(action,storage)
      edit_user_storage_limit_a.click
      input_user_storage_limit_input.type_text(storage)
      if action.eql?('edit')
        save_user_storage_limit_a.click
      else
        cancel_user_storage_limit_a.click
      end
    end

    def set_user_storage_limit(storage)
      user_storage_limit_set_a.click
      input_user_storage_limit_input.type_text(storage)
      save_user_storage_limit_a.click
    end

    def remove_user_storage_limit(action)
      remove_user_storage_limit_a.click
      if action.eql?('Yes')
        alert_accept
      else
        alert_dismiss
      end
    end

    def check_user_storage_limit_set_link
      user_storage_limit_set_a.visible?

    end

    def get_user_storage_limit_help_msg
      user_storage_limit_help_img['data-tooltip']
    end

    def set_device_storage_limit(action,device,storage)
      if action.eql?('set')
        find(:xpath, "//td/a[text()='#{device}']/../../td[3]//a[contains(@id,'set-machine-storage-max')]").click
      else
        find(:xpath, "//td/a[text()='#{device}']/../../td[3]//a[text()='Edit']").click
      end
      find(:xpath, "//td/a[text()='#{device}']/../../td[3]//input[contains(@id,'input-machine-storage-max')]").type_text(storage)
      find(:xpath, "//td/a[text()='#{device}']/../../td[3]//a[contains(@id,'save-machine-storage-max')]").click
    end

    def change_user_external_id(external_id)
      change_external_id_link.click
      external_id_tb.type_text(external_id)
      submit_external_id_btn.click
      wait_until_bus_section_load
    end

    def get_edit_device_tooltips
      edit_device_input['onfocus'].match(/Min: \d, Max: \d+/)[0]
    end

    # Public: Update machine quota under user details for OEM
    #
    # @params [] none
    #
    # Example:
    #   @bus_site.admin_console_page.user_details_details_section.change_machine_quota(quota)
    #
    # @return [] nothing
    def change_machine_quota(quota)
      change_machine_quota_link.click
      change_machine_quota_tb.type_text(quota)
      change_machine_quota_btn.click
      wait_until { !locate(:css, "div[id^=change_quota_for_user_show_]").nil? }
    end

    def click_restore_files(type, device)
      find(:xpath, "//a[text()='#{device}']/../..//a[@title='Restore #{type}']/i").click
    end

    def home_user_billing_hash
      user_billing_table.hashes
    end

    def click_device_link(device)
      find(:xpath, "//a[text()='#{device}']").click
    end

    #==============================
    #Public : Get the sync device detail storage info from user detail section and compare with the given table.
    #
    #@param : [] None
    #
    #Example:
    #       @bus_site.admin_console_page.search_list_machines_section.sync_device_storage_info_hash
    #
    #@return:
    #       [Hash] device storage detail info in hash format.
    #==============================
    def sync_device_storage_info_hash
      @device_details = {}
      i = 1
      device_info_hash.each do |td|
        puts "======" + i.to_s + "/" + td.text + "======"
        @device_details["Sync Container"] =  td.text if i == 1
        @device_details["Used/Available"] =  td.text if i == 2
        @device_details["Device Storage Limit"] =  td.text if i == 3
        @device_details["Last Update"] =  td.text if i == 4
        i = i + 1
      end
      puts @device_details
      return @device_details
    end


    #==============================
    #Public : Get the sync device detail storage info from user detail section and compare with the given table.
    #
    #@param : [] None
    #
    #Example:
    #       @bus_site.admin_console_page.search_list_machines_section.sync_device_storage_info_hash
    #
    #@Return:
    #       [Hash] device storage detail info in hash format -
    #         {"Computer"=>"Sync", "Encryption"=>"Default", "Storage Used"=>"0 / 2 GB (change)", "Last Update"=>"N/A"}
    #==============================
    def sync_device_itemized_storage_info_hash
      @device_details = {}
      i = 1
      device_info_hash.each do |td|
        puts "======" + i.to_s + "/" + td.text + "======"
        @device_details["Computer"] =  td.text if i == 1
        @device_details["Encryption"] =  td.text if i == 2
        @device_details["Storage Used"] =  td.text if i == 3
        @device_details["Last Update"] =  td.text if i == 4
        i = i + 1
      end
      puts @device_details
      return @device_details
    end


    #==============================
    #Public : Update <Device Storage Limit> on the specified device with the given vailid | invalid number
    #
    #@param : [String] device name
    #         [String] storage quota you would like to input
    #
    #Example:
    #       @bus_site.admin_console_page.search_list_machines_section.update_device_storage_limit("Sync", "10")
    #
    #@Return:
    #       None
    #==============================
    def update_device_storage_limit(device_name, amount)
      find(:xpath, "//a[text()='#{device_name}']/../../td[3]//a[@href='#' and text()='Set']").click
      wait_until {!(find(:xpath, "//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//input[@type='text']").nil?)}
      find(:xpath, "//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//input[@type='text']").type_text(amount)
      find(:xpath, "//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//a[text()='Save']").click
      sleep(5)
      #======In case user input a negative number, accept the alert dlg and click <Cancel> button
      alert_accept if amount.to_i < 0
      find(:xpath, "//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//a[text()='Cancel']").click if amount.to_i < 0
    end


    #==============================
    #Public : Get <Device Storage Limit> tooltip of the specified device.
    #
    #@param : [String] device name
    #
    #Example:
    #       @bus_site.admin_console_page.search_list_machines_section.get_device_Device_Storage_Limit_tooltip("Sync")
    #
    #@Return:
    #       [String] <Device Storage Limit> tooltip. e.g., "Min: 0 GB, Max: 1024 GB"
    #==============================
    def get_device_Device_Storage_Limit_tooltip(device_name)
      #Click the set to get the textbox object.
      find(:xpath, "//table[@class='mini-table']//a[text()='#{device_name}']/../../td[3]//a[@href='#' and text()='Set']").click
      #wait till the set textbox appear
      wait_until {!(find(:xpath, "//table[@class='mini-table']//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//input[@type='text']").nil?)}
      sleep(1)
      #click on the set input textbox
      find(:xpath, "//table[@class='mini-table']//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//input[@type='text']").click
      sleep(1)
      tooltip = find(:xpath, "//table[@class='mini-table']//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//span[@class='storage_pool_quota_tooltip']").text
      #click Cancel button
      find(:xpath, "//table[@class='mini-table']//a[text()='#{device_name}']/../../td[3]//div[@style='position:relative']//a[text()='Cancel']").click
      return tooltip
    end

    #==============================
    #Public : Get device returned error message
    #
    #@param : [] None
    #
    #Example:
    #
    #
    #Return : [String] Error message returned on the device detail section. e.g.,
    #           "The Sync Storage limit cannot be more than what is available for this user."
    #==============================
    def get_error_message
      puts error_message.text
      error_message.text
    end


    #==============================
    #Public : Delete device by the given device name with or without keeping data
    #
    #@param : [] None
    #
    #Example:
    #       @bus_site.admin_console_page.user_details_section.delete_device("Sync", false)
    #
    #Return : [] None
    #==============================
    #def delete_device(device_name, data_keep)
      #click on the set input textbox
      #find(:xpath, "//a[text()='#{device_name}']/../../td[5]//a[contains(@onclick, 'show_delete_stash_popup')]").click
      #wait_until{ delete_device_dlg }
      #puts "Find Delete dialog"
      #delete_device_yes.click if data_keep == "with"
      #delete_device_no.click if data_keep == "without"
      #wait_until{ !delete_device_dlg.nil? }
    #end

    #==============================
    #Public : Delete device by the given device name with or without keeping data
    #
    #@param : [] None
    #
    #Example:
    #       @bus_site.admin_console_page.user_details_section.delete_itemized_device("Sync", false)
    #
    #Return : [] None
    #==============================
    def delete_itemized_device(device_name, data_keep)
      #click on the set input textbox
      find(:xpath, "//a[text()='#{device_name}']/../../td[6]//a[contains(@onclick, 'show_delete_stash_popup')]").click
      wait_until{ delete_device_dlg }
      puts "Find Delete dialog"
      delete_device_yes.click if data_keep == "with"
      delete_device_no.click if data_keep == "without"
      #wait_until{ !delete_device_dlg.nil? }
    end

    def change_stash_quota_for_itemized_user(quota)
      change_stash_quota_tb.type_text(quota)
      change_stash_quota_btn.click
    end

    def get_sync_disabled_message
      no_computer_msg.text
    end

    def click_computer(computer)
      find(:xpath, "//table[@class='mini-table']//a[text()='#{computer}']").click
    end

    private
    def device_stash_divide_row_index
      device_table.rows_text.index{ |row| row.first == ''}
    end
  end
end
