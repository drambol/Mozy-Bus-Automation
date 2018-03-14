module Bus

  class InventoryStatusSection < SiteHelper::Section

    # Private elements
    #
    element(:status_table, css: 'table.table-view')

    def inventory_table_headers
      status_table.headers_text
    end

  end
end
