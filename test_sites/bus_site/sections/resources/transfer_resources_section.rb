module Bus
  # This class provides actions for manage resource section
  class TransferResourcesSection < SiteHelper::Section

    # Private elements
    #
    element(:source_group_select, id: "source_group_id")
    element(:target_group_select, id: "target_group_id")
    element(:target_partner_select, id: "target_partner_id")
    element(:server_licenses_tb, id: "licenses_Server")
    element(:server_quota_tb, id: "quota_Server")
    element(:desktop_licenses_tb, id: "licenses_Desktop")
    element(:desktop_quota_tb, id: "quota_Desktop")
    element(:continue_btn, xpath: "//input[@value='Continue']")
    element(:message_div, xpath: "//div[@id='resource-transfer_resources-errors']/ul")

    # Public: Transfer resources from source user group to target user group
    #
    #
    def transfer_resources(source_group, target_partner, target_group, server_licenses, server_quota, desktop_licenses, desktop_quota)
      source_group_select.select(source_group)
      target_partner_select.select(target_partner) unless target_partner == 'the same partner'
      sleep 2
      target_group_select.select(target_group)
      server_licenses_tb.type_text(server_licenses)
      server_quota_tb.type_text(server_quota)
      desktop_licenses_tb.type_text(desktop_licenses)
      desktop_quota_tb.type_text(desktop_quota)
      continue_btn.click
    end

    # Public: Messages for manage resources actions
    #
    # Example
    #  @bus_admin_console_page.transfer_resources_section.messages
    #  # => "Resources transferred from the (default user group) user group to the Test Group user group."
    #
    # Returns success or error message text
    def messages
      message_div.text
    end

    def get_source_key_and_storage group_name
      find(:xpath, "//select[@id='source_group_id']/option[contains(text(),'#{group_name}')] ").text
    end

    def get_target_key_and_storage group_name
      find(:xpath, "//select[@id='target_group_id']/option[contains(text(),'#{group_name}')] ").text
    end

    def get_target_partner_key_and_storage group_name
      find(:xpath, "//select[@id='target_partner_id']/option[contains(text(),'#{group_name}')] ").text
    end

    def select_target_partner target_partner
      target_partner_select.select(target_partner)
      sleep 2
    end

  end
end
