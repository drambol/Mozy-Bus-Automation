module Bus
  # This class provides actions for order a new data shuttle page section
  class ProcessOrderSection < SiteHelper::Section

    # Private elements
    #
    # Verify shipping address section
    element(:verify_shipping_address_table, css: "table.form-box2")

    element(:message_div, xpath: "//ul[@class='flash successes' or @class='flash errors']")
    element(:order_notification_p, css: "div.show-details > p")

    element(:name_tb, id: "seed_device_order_name")
    element(:address1_tb, id: "seed_device_order_address1")
    element(:address2_tb, id: "seed_device_order_address2")
    element(:city_tb, id: "seed_device_order_city")
    element(:state_tb, id: "seed_device_order_state")
    element(:country_select, id: "seed_device_order_country")
    element(:zip_tb, id: "seed_device_order_zip")
    element(:phone_tb, id: "seed_device_order_phone_number")
    element(:power_adapter_select, id: "seed_device_order_sku")
    elements(:next_btns, css: "div#wizard-buttons-right input[value=Next]")

    # [0] Order Keys table [1] Licence Key table [2] Order Summary table
    elements(:keys_tables, css: "ul.tab-panes > li > div > table")

    # filter key
    element(:filter_key_input, id: "mozy_pro_key_search")
    element(:filter_button, xpath: "//input[@value='Filter']")
    element(:add_first_key, xpath: "//table/tbody/tr[1]/td[8]/a[text()='Add']")

    # Create order section
    element(:available_keys_table, css: "div.box table.table-view")
    element(:add_new_key, xpath: "//a[text()='Add New Key']")
    element(:drive_type_select, id: 'data_shuttle_sku_type')
    element(:discount_input,xpath: "//input[contains(@id,'discount')]")
    element(:add_first_key,xpath: "//div[@class='box']//table//tr[1]//a[text()='Add']")
    element(:filter_key_input, id: "mozy_pro_key_search")
    element(:filter_button, xpath: "//input[@value='Filter']")
    element(:available_keys_search_results, css: 'div[id^=resource-create_new_seed-] table.table-view')
    element(:user_group_select, xpath: "//*[@id='user_group_id']")
    element(:license_type_select, xpath: "//*[@id='license_type_id']")
    element(:assign_to_input, xpath: "//*[@id='assigned_to']")
    element(:clear_link, xpath: "//a[text()='Clear']")
    element(:remove_link, xpath: "//a[text()='Remove']")

    # Summary section
    element(:num_win_drivers_tb, id: "seed_device_order_win_drive_num")
    element(:num_mac_drivers_tb, id: "seed_device_order_mac_drive_num")
    element(:is_ship_driver_cb, id: "seed_device_order_skip_order_fulfillment")
    element(:submit_order_btn, id: "seed_wizard_finish_button")
    element(:vat_fee_amount, id: "vat_amount")

    def address_desc_columns
      verify_shipping_address_table.rows_text.map{ |row| row[0] }
    end

    # Public: Shipping address text
    #
    def shipping_address
      [name_tb.value,address1_tb.value,address2_tb.value,city_tb.value,state_tb.value,country_select.first_selected_option.text,zip_tb.value,phone_tb.value,power_adapter_select.first_selected_option.text]
    end

    # Public: Process a data shuttle order
    #
    #  Example
    #    @bus_admin_console_page.process_order_section.create_order(order_object)
    #
    # Return nothing
    def create_order(order, save = true)
      wait_until_bus_section_load
      # fill shipping address section

      if order.name.nil?
        name_tb.type_text('')
      elsif order.name != 'keep the same'
        name_tb.type_text(order.name)
      end

      if order.address_1.nil?
        address1_tb.type_text('')
      elsif order.address_1 != 'keep the same'
        address1_tb.type_text(order.address_1)
      end

      address2_tb.type_text(order.address_2)

      if order.city.nil?
        city_tb.type_text('')
      elsif order.city != 'keep the same'
        city_tb.type_text(order.city)
      end

      if order.state.nil?
        state_tb.type_text('')
      elsif order.state != 'keep the same'
        state_tb.type_text(order.state)
      end

      country_select.select(order.country) unless order.country.nil?

      if order.zip.nil?
        zip_tb.type_text('')
      elsif order.zip != 'keep the same'
        zip_tb.type_text(order.zip)
      end

      if order.phone.nil?
        phone_tb.type_text('')
      elsif order.phone != 'keep the same'
        phone_tb.type_text(order.phone)
      end

      power_adapter_select.select(order.adapter_type) unless order.adapter_type.nil?

      next_btns[0].click # click next and goto
      #go_to_create_order_section
      wait_until_bus_section_load

      unless order.adapter_type.nil?
        # fill create order section
        if order.key_from == "available"
          # Add key from available keys
          add_available_key.click
        elsif !order.key_from.match(/[0-9A-Z]{20}/).nil?
          # add key for fixed data (product key)
          filter_key_input.type_text(order.key_from)
          filter_button.click
          wait_until_bus_section_load
          add_first_key.click
        elsif !(order.key_from.match(/^\d* available$/).nil?)
          # Add certain number keys on current page
          number = order.key_from.match(/\d+/)[0].to_i
          number.times {
            add_first_key.click
            wait_until_bus_section_load
          }
        elsif order.key_from == "new"
          add_new_key.click
        elsif !order.key_from.match(/[0-9A-Z]{20}/).nil?   # filter key
          filter_key_input.type_text(order.key_from)
          filter_button.click
          wait_until_bus_section_load
          add_first_key.click
        else
          raise "Please order key from either available keys or add a new key"
        end
        wait_until_bus_section_load

        os_tb.select(order.os) unless order.os.nil?
        # update quota for more than one key records
        if !order.quota.nil?
          quota_arr = order.quota.split("\;")
          quota_arr.each_with_index do |value, index|
            order_quota_tb(index).type_text(value)
          end
        end
        order.license_key = get_added_keys
        order_assign_to_tb.type_text(order.assign_to) unless order.assign_to.nil?
        drive_type_select.select(order.drive_type) unless order.drive_type.nil?

        wait_until_bus_section_load
        next_btns[1].click

        wait_until_bus_section_load

        #seperate from error/success message
        order.notification_msg = order_notification_p.text unless locate(:xpath, "//div[@class='show-details']/p").nil?

        # fill summary section
        if messages.empty?
          discount_tb.type_text(order.discount) unless order.discount.nil?
          # focus out of discount text box, make sure discount amount changes
          page.trigger_html_event(discount_tb.id, "change")
          num_win_drivers_tb.type_text(order.num_win_drivers) unless order.num_win_drivers.nil?
          num_mac_drivers_tb.type_text(order.num_mac_drivers) unless order.num_mac_drivers.nil?
          is_ship_driver_cb.check unless order.ship_driver.nil?
          if save
            submit_order_btn.click
          end
        end
        wait_until_bus_section_load
      end
    end

    def fill_in_shipping_address(order)

      wait_until_bus_section_load
      # fill shipping address section

      if order.name.nil?
        name_tb.type_text('')
      elsif order.name != 'keep the same'
        name_tb.type_text(order.name)
      end

      if order.address_1.nil?
        address1_tb.type_text('')
      elsif order.address_1 != 'keep the same'
        address1_tb.type_text(order.address_1)
      end

      address2_tb.type_text(order.address_2)

      if order.city.nil?
        city_tb.type_text('')
      elsif order.city != 'keep the same'
        city_tb.type_text(order.city)
      end

      if order.state.nil?
        state_tb.type_text('')
      elsif order.state != 'keep the same'
        state_tb.type_text(order.state)
      end

      country_select.select(order.country) unless order.country.nil?

      if order.zip.nil?
        zip_tb.type_text('')
      elsif order.zip != 'keep the same'
        zip_tb.type_text(order.zip)
      end

      if order.phone.nil?
        phone_tb.type_text('')
      elsif order.phone != 'keep the same'
        phone_tb.type_text(order.phone)
      end

      power_adapter_select.select(order.adapter_type) unless order.adapter_type.nil?

      next_btns[0].click # click next and goto
      #go_to_create_order_section
      wait_until_bus_section_load
    end

    def verify_all_field_options(user_group, license_type, key, assign_to)
      user_group_select.select(user_group) unless user_group.nil?
      license_type_select.select(license_type) unless license_type.nil?
      filter_key_input.type_text(key) unless key.nil?
      assign_to_input.type_text(assign_to) unless assign_to.nil?

      filter_button.click
      wait_until_bus_section_load
    end

    def add_keys(order)
      if !(order.key_from.match(/^\d* available$/).nil?)
        # Add certain number keys on current page
        number = order.key_from.match(/\d+/)[0].to_i
        number.times {
          add_first_key.click
          wait_until_bus_section_load
        }
      end
    end

    def proceed_to_next(position)
      next_btns[position].click # click next and goto
      wait_until_bus_section_load
    end

    def available_keys_rows
      available_keys_search_results.rows_text
    end

    def clear_all_field_options
      clear_link.click
      wait_until_bus_section_load
    end

    def add_available_key_to
      add_first_key.click
      wait_until_bus_section_load
    end

    def remove_available_key
      remove_link.click
      wait_until_bus_section_load
    end

    def input_discount(value)
      discount_input.native.clear
      discount_input.native.send_keys(value)
      discount_input.native.send_keys :tab
      # wait to re-calculate total price
      sleep 1
    end

    def finish_data_shuttle_order
      submit_order_btn.click
      wait_until_bus_section_load
    end

    # Public: Messages for process order actions
    #
    # Example
    #  @bus_admin_console_page.process_order_section.messages
    #  # => "Please select the power adapter type."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    # Public: Data shuttle order summary table rows text
    #
    # Example
    #   @bus_admin_console_page.add_new_partner_section.order_summary_table_rows
    #   # => [["Data Shuttle 1.8 TB","1","$137.50"],
    #         ["Total Price","","$137.50"]]
    #
    # Returns order summary table rows text
    def order_summary_table_rows
      wait_until_bus_section_load
      order_summary_table.rows_text
    end

    def num_win_driver_ordered
      num_win_drivers_tb.value
    end

    def num_mac_driver_ordered
      num_mac_drivers_tb.value
    end

    def get_vat_fee_amount
      vat_fee_amount.text
    end

    def get_vat_fee_field
      page.has_xpath?("//*[@id='vat_amount']")
    end

    private

    def order_keys_table
      keys_tables[0]
    end

    def licence_key_table
      keys_tables[1]
    end

    def order_summary_table
      keys_tables[2]
    end

    def add_available_key
      available_keys_table.rows.first.last.find("a")
    end

    def os_tb
      order_keys_table.rows.first[2].find("select")
    end

    def order_quota_tb(index = 0)
      (order_keys_table.rows)[index][4].find("input")
    end

    def get_added_keys
      keys_array = []
      order_keys_table.rows.each_with_index { |value,index |
        value[3].text
        keys_array << (order_keys_table.rows)[index][3].text
      }
      keys_array
    end

    def order_assign_to_tb
      order_keys_table.rows.first[5].find("input")
    end

    def discount_tb
      licence_key_table.rows.first.last.find("input")
    end

  end
end
