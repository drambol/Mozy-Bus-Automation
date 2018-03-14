module Bus
  # This class provides actions for resource summary section
  class ResourceSummarySection < SiteHelper::Section

    # Private elements
    # The following elements are for reference, in the code, I may use the css or xpath directly
    # Itemized
    # Storage
    element(:desktop_storage_used_span, id: 'resource_storage_used_Desktop')
    element(:desktop_storage_total_span, id: 'resource_storage_total_Desktop')
    element(:server_storage_used_span, id: 'resource_storage_used_Server')
    element(:server_storage_total_span, id: 'resource_storage_total_Server')
    element(:storage_more_link, id: 'display_storage_details_of_other_license_types')
    element(:storage_hide_link, id: 'hide_storage_details_of_other_license_types')
    # Itemized and Bundled
    element(:storage_available_span, id: 'resource_summary_storage_available')
    element(:storage_used_span, id: 'resource_summary_storage_used')

    element(:storage_subpartner_all_span, id: 'resource_storage_subpartner_all')
    element(:storage_errors_div, xpath: "//div[@id='resource_summary_storage_errors']/div")
    element(:storage_buy_more_link, css: 'div.div_col:first-child span.buy_more>a')
    # Itemized
    element(:storage_subpartner_Desktop_span, id: 'resource_storage_subpartner_Desktop')
    element(:storage_subpartner_Server_span, id: 'resource_storage_subpartner_Server')

    #Device
    element(:desktop_device_used_span, id: 'resource_device_used_Desktop')

    element(:device_subpartner_all_span, id: 'resource_device_subpartner_all')

    element(:device_errors_div, css: 'div#resource_summary_device_errors div')

    element(:device_buy_more_link, css: 'div.div_col:last-child span.buy_more>a')

    element(:device_more_link, id: 'display_device_details_of_other_license_types')
    element(:device_hide_link, id: 'hide_device_details_of_other_license_types')

    # Bundled


    # Public: Purchase resources
    #
    # @partner_type [String] ['Itemized', 'Bundled']
    # @resource_type [String] ['storage' 'device']
    #
    # Example
    #   @bus_admin_console_page.resource_summary_section.resource_info('Itemized', 'storage')
    #
    # Returns [key value]
    def resource_info(partner_type, resource_type)
      wait_until_bus_section_load
      result = {}
      if partner_type == 'Itemized'
        ['Desktop', 'Server', 'Test1', 'Test2'].each do |type|
          ['used', 'total', 'subpartner'].each do |u_t_s|
            locator = "#{["resource", "#{resource_type}", "#{u_t_s}", "#{type}"].join('_')}"
            elements = all(:id, locator)
            result["#{["#{resource_type}", "#{type.downcase}", "#{u_t_s}"].join('_')}"] = elements.first.text if !elements.empty? && elements.first.visible?
          end
        end
      end
      ['used', 'available'].each do |u_or_a|
        result["#{resource_type}_#{u_or_a}"] = find(:id, "resource_summary_#{resource_type}_#{u_or_a}").text
      end
      elements = all(:id, "resource_#{resource_type}_subpartner_all")
      result["#{resource_type}_all_subpartner"] = elements.first.text unless elements.empty?
      result
    end

    def click_more_hide_link(action, type)
      action = 'display' if action == 'more'
      find(:id, "#{action}_#{type}_details_of_other_license_types").click
    end

    def get_storage_errors
      storage_errors_div.text
    end

    def storage_errors_visible?
      !locate(:xpath, "//div[@id='resource_summary_storage_errors']/div").nil?
    end
  end
end
