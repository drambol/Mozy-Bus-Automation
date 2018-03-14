module Bus
  # This class provides actions for order data shuttle page section
  class DeviceStatusSection < SiteHelper::Section

    # Private elements
    #
    element(:status_table, css: 'table.table-view')

    def status_table_headers
      status_table.headers_text
    end

  end
end
