module Bus
  # This class provides actions for return resources section
  class ReturnResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:return_group_select, id: "source_id")
    element(:server_license_tb, id: "licenses_Server")
    element(:server_quota_tb, id: "quota_Server")
    element(:desktop_license_tb, id: "licenses_Desktop")
    element(:desktop_quota_tb, id: "quota_Desktop")
    element(:continue_btn, css: "input[value=Continue]")
    element(:submit_purchase_btn, id: "btn-purchase_resource_submit")
    element(:message_div, css: "div#resource-unpurchase_resources-errors ul")

    # Public: Purchase resources
    #
    # Example
    #   @bus_admin_console_page.purchase_resources_section.purchase
    #
    # Returns nothing
    def return_resources(user_group, desktop_license, desktop_quota, server_license, server_quota)
      wait_until_bus_section_load
      return_group_select.select(user_group) unless user_group.nil?
      wait_until_bus_section_load
      server_license_tb.type_text(server_license) unless server_license.nil?
      server_quota_tb.type_text(server_quota) unless server_quota.nil?
      desktop_license_tb.type_text(desktop_license) unless desktop_license.nil?
      desktop_quota_tb.type_text(desktop_quota) unless desktop_quota.nil?
      continue_btn.click
    end

    # Public: Messages for return resources actions
    #
    # Example
    #  @bus_admin_console_page.return_resources_section.messages
    #  # => "Quota changed."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

  end
end