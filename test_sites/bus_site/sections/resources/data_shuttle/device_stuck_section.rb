module Bus
  # This class provides actions for order data shuttle page section
  class DeviceStuckSection < SiteHelper::Section

    # Private elements
    #
    element(:stuck_table, css: 'table.table-view')

    def stuck_table_headers
      stuck_table.headers_text
    end

  end
end


