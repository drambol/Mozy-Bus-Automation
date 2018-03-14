module Bus
  # This class provides actions for add new user section
  class AddNewUserSection < SiteHelper::Section
    # Private elements
    #
    element(:succ_msg_div, css: 'ul.flash.successes')
    element(:err_msg_div, xpath: "//ul[@class='flash errors']/li")

    element(:user_group_select, {id: 'user_user_group_id'}, true)
    element(:user_group_select_invisible, {id: 'user_user_group_id'})
    element(:ug_resources_details_table, id: 'resource-details')
    element(:buy_more_link, css: 'span.buy_more>a[href*=change_billing_plan]')
    element(:add_group_link, css: 'a[href*=add_group]')
    element(:resource_warning_message_span, xpath: "//span[@id='no_resources_warning']")
    element(:storage_warning_message_span, xpath: "//span[@id='no_storage_warning']")

    element(:storage_type_select, {:id => 'user_storage_pool_policy'}, true)
    element(:storage_max_tb, {id: 'desired_user_storage'}, true)
    element(:device_tb, {id: 'device_count'}, true)
    element(:enable_stash_cb, {id: 'user_enable_stash'}, true)

    element(:name_tb, id: 'user1_name')
    element(:email_tb, id: 'user1_username')
    element(:add_user_btn, css: 'button[onclick*=add_new_user]')
    element(:delete_user_btn, css: 'button[onclick*=del_new_user]')

    element(:send_emails_cb, id: 'send_email_to_users')
    element(:submit_btn, id: 'new_users_in_batch_submit_btn')

    element(:desktop_devices_tb, id: 'Desktop_device')
    element(:server_devices_tb, id: 'Server_device')

    element(:tooltips_span, xpath: "//span[@id='tooltip_for_new_user_storage_max']")

    element(:user_group_help_img, xpath: "//select[@id='user_user_group_id']/following-sibling::img")
    element(:user_type_help_img, xpath: "//div[@class='div_row wrapper new_users_in_batch_step_2']//div[@class='div_col field_name section_title']/following-sibling::div/img")
    element(:enter_user_help_img, xpath: "//div[@class='div_row wrapper new_users_in_batch_step_3']//div[@class='div_col field_name section_title']/following-sibling::div/img")
    element(:send_email_help_img, xpath: "//div[@class='div_row wrapper new_users_in_batch_step_3']//div[@class='div_col field_name']/following-sibling::div/img")
    element(:region_override_help_img, xpath: "//select[@id='install_region_override']/following-sibling::img")

    element(:beside_email_message_span, xpath: "//table[@id='users_in_batch']/tbody/tr/td[3]/span")


    # Public: Add new users
    #
    # @users     [Object] users
    #
    # Example
    #   @bus_admin_console_page.add_new_user_section.add_new_users(user_object)
    #
    # @return [] nothing
    def add_new_users(users)

      create_new_user_start_time = 0
      create_new_user_end_time = 0
      d = 0

      user = users.first
      wait_until_bus_section_load
      user_group_select.select(user.user_group) unless user.user_group.nil?
      storage_type_select.select(user.storage_type) unless user.storage_type.nil?
      storage_max_tb.type_text(user.storage_limit) unless user.storage_limit.nil?
      device_tb.type_text(user.devices) unless user.devices.nil?

      unless user.enable_stash.nil?
        if user.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end

      users.each_index do |index|
        Log.debug "##########adding the #{index} user"
        find(:id, "user#{index+1}_name").type_text(users[index].name)
        find(:id, "user#{index+1}_username").type_text(users[index].email)
        add_user_btn.click if index != users.length-1
      end

      unless user.send_email.nil?
        if user.send_email.downcase.eql?('yes')
          send_emails_cb.check
        else
          send_emails_cb.uncheck
        end
      end

      create_new_user_start_time = Time.now.utc
      log("click add user button time: #{create_new_user_start_time}")
      submit_btn.click
      wait_until_bus_section_load
      create_new_user_end_time = Time.now.utc
      log("KPI-Create_New_User:start_time:#{create_new_user_start_time}/end_time:#{create_new_user_end_time}")
    end

    def add_new_users_unsuccessfully(users)
      user = users.first
      wait_until_bus_section_load
      user_group_select.select(user.user_group) unless user.user_group.nil?
      storage_type_select.select(user.storage_type) unless user.storage_type.nil?
      storage_max_tb.type_text(user.storage_limit) unless user.storage_limit.nil?
      device_tb.type_text(user.devices) unless user.devices.nil?

      unless user.enable_stash.nil?
        if user.enable_stash.downcase.eql?('yes')
          enable_stash_cb.check
        else
          enable_stash_cb.uncheck
        end
      end

      users.each_index do |index|
        Log.debug "##########adding the #{index} user"
        find(:id, "user#{index+1}_name").type_text(users[index].name)
        find(:id, "user#{index+1}_username").type_text(users[index].email)
        add_user_btn.click if index != users.length-1
      end

      unless user.send_email.nil?
        if user.send_email.downcase.eql?('yes')
          send_emails_cb.check
        else
          send_emails_cb.uncheck
        end
      end

      submit_btn.click
      #======Two scenarios: 1. alert dialog. 2. No alert dialog, but error message <ul class="flash errors">
      sleep(5)
      if alert_present?
        page.driver.browser.switch_to.alert.text
        alert = page.driver.browser.switch_to.alert
        msg =alert.text
        alert.accept
        puts "Get error message from alert dialog: " + msg
      else
        msg = error_messages
        puts "Get error message from new user detail section: " + msg.strip
      end
      msg
    end


    # Public: Success messages for add new user sections
    #
    # Example
    #  @bus_admin_console_page.add_new_user_section.success_messages
    #  # => "Created new user test@mozy.com"
    #
    # @return [String]
    def success_messages
      succ_msg_div.text
    end

    # Public: Error messages for add new user sections
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.error_messages
    #  # => "Failed to create (1) users"
    #
    # @return [String]
    def error_messages
      err_msg_div.text
    end

    # Public: User group resource details
    #
    # Examples:
    #  @bus_admin_console_page.add_new_user_section.ug_resource_details_table_rows
    #  # => ["Desktop Storage (GB)","200"],["Server Storage (GB)","50"],["Desktop Devices","2"], ["Server Devices", "192"]
    #
    # @return
    def ug_resource_details_table_rows
      ug_resources_details_table.rows_text[1..-2].delete_if{ |row| row.first.empty?}
    end

    def select_user_group(group_name)
      user_group_select.select(group_name)
    end

    def click_buy_more_link
      buy_more_link.click
    end

    def has_stash_option?
      # For newly created test partner, if there
      # xxx_invisible element wont wait element to be visible and enabled before returned
      user_group_select_invisible.select('(default user group)') if user_group_select_invisible.visible?
      storage_type_select.select('Desktop')
      find(:id, 'user_enable_stash').visible?
    end

    def desktop_device
      desktop_devices_tb.text
    end

    def server_device
      server_devices_tb.text
    end

    def get_tooltips(group,type)
      wait_until_bus_section_load
      user_group_select.select(group)
      storage_type_select.select(type)
      storage_max_tb.click
      wait_until{tooltips_span.visible?}
      tooltips_span.text
    end

    def get_help_msg(type)
      case type
        when 'user group'
          user_group_help_img['data-tooltip']
        when 'user type'
          user_type_help_img['data-tooltip']
        when 'enter user'
          enter_user_help_img['data-tooltip']
        when 'send email'
          send_email_help_img['data-tooltip']
        when 'region override'
          region_override_help_img['data-tooltip']
      end
    end

    def get_beside_email_message
      beside_email_message_span.text
    end

    def get_user_group_storage_warning_message(type)
      if type.eql?('resource')
        wait_until{resource_warning_message_span.visible?}
        resource_warning_message_span.text
      else
        wait_until{storage_warning_message_span.visible?}
        storage_warning_message_span.text
      end
    end

    #====================================
    # Public  : get default values when create a new user
    #
    # @params : [mozy_type]   MozyPro, MozyEnterprise (so far)
    #           [group_name]  user group name
    #
    # Example :
    #   @bus_site.admin_console_page.add_new_user_section.get_new_user_default_values("MozyPro", "(default user group)")
    #
    # @return : [hash] new user default values.
    #                  e.g., {"enable_stash_cb_checked"=>true, "enable_stash_cb_exist"=> true, "send_emails_cb_checked"=> false}
    #====================================
    def get_new_user_default_values(mozy_type, group_name)
      @new_user_default_values = {}
      if mozy_type == "MozyPro"
        user_group_select.select(group_name)
        #======<Enable Sync> exists or not======
        begin find(:id, "user_enable_stash")
        #======<Enable Sync> is checked or not======
          @new_user_default_values["enable_stash_cb_checked"] = enable_stash_cb.checked?
          @new_user_default_values["enable_stash_cb_exist"] = true
        rescue
          @new_user_default_values["enable_stash_cb_exist"] = false
        end
        #======<send emails invitation to user> chexked or not======
        @new_user_default_values["send_emails_cb_checked"] = send_emails_cb.checked?
      end
        puts @new_user_default_values
      #TODO
      return @new_user_default_values
    end

  end
end
