module Bus
  # This class provides actions for purchase resources section
  class PurchaseResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:user_group_search_img, css: "img[alt='Search-button-icon']")
    element(:desktop_keys_p, xpath: "//th[.='Current Resources:']/..//strong[.='Desktop Keys:']/..")
    element(:server_keys_p, xpath: "//th[.='Current Resources:']/..//strong[.='Server Keys:']/..")
    element(:desktop_storage_p, xpath: "//th[.='Current Resources:']/..//strong[.='Desktop Storage:']/..")
    element(:server_storage_p, xpath: "//th[.='Current Resources:']/..//strong[.='Server Storage:']/..")
    element(:server_license_tb, id: "licenses_Server")
    element(:server_quota_tb, id: "quota_Server")
    element(:desktop_license_tb, id: "licenses_Desktop")
    element(:desktop_quota_tb, id: "quota_Desktop")
    element(:generic_quota_tb, id: "quota_Generic")
    element(:continue_btn, css: "input[value=Submit]")
    element(:submit_purchase_btn, id: "btn-purchase_resource_submit")
    element(:message_span, css: "div#resource-purchase_resources-content div span")
    element(:error_message_p, xpath: "//div[@id='resource-purchase_resources-errors']/ul/li")
    element(:pay_error_message, xpath: "//div[@id='resource-purchase_resources_pay-errors']/ul/li")
    element(:submit_purchase_mozypro_btn, xpath: "//td[@class='form-box-submit']/input[@class='button']")

    # Public: Purchase resources
    #
    # Example
    #   @bus_admin_console_page.purchase_resources_section.purchase
    #
    # Returns nothing
    def purchase(user_group, desktop_license, desktop_quota, server_license, server_quota, generic_gb)
      unless user_group.nil?
        user_group_search_img.click
        sleep 2
        find(:xpath, "//li[contains(text(),'#{user_group}')]").click
      end
      server_license_tb.type_text(server_license) unless server_license.nil?
      server_quota_tb.type_text(server_quota) unless server_quota.nil?
      desktop_license_tb.type_text(desktop_license) unless desktop_license.nil?
      desktop_quota_tb.type_text(desktop_quota) unless desktop_quota.nil?
      generic_quota_tb.type_text(generic_gb.to_s) unless generic_gb.nil?
      continue_btn.click
      begin
        submit_purchase_btn.click
      rescue => e
        puts e
      end
      # Not necessary need to wait, work around for TC.19871, TC.19872
      wait_until_bus_section_load
    end

    # Public: Messages for purchase resources actions
    #
    # Example
    #  @bus_admin_console_page.purchase_resources_section.messages
    #  # => "Quota changed."
    #
    # Returns success or error message text
    def messages
      message_span.text
    end

    def error_message
      error_message_p.text
    end

    def pay_error_msg
      pay_error_message.text
    end
    # Public: Current purchased resources
    #
    # Example
    #  @bus_admin_console_page.purchase_resources_section.current_purchased_resources
    #  # => "server_plan => 1, server_quota => 2, desktop_license => 1, desktop_quota => 3"
    #
    # Returns resource object contains number of server license, server quota, desktop license and desktop quota
    def current_purchased_resources
      wait_until_bus_section_load
      resources = Struct.new(:server_license, :server_quota, :desktop_license, :desktop_quota)
      server_license = server_keys_p.text.match(/\d+/)[0].to_i
      server_quota = server_storage_p.text.match(/\d+/)[0].to_i
      desktop_license = desktop_keys_p.text.match(/\d+/)[0].to_i
      desktop_quota = desktop_storage_p.text.match(/\d+/)[0].to_i
      resources.new(server_license, server_quota, desktop_license, desktop_quota)
    end




  end
end
