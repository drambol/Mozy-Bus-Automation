module Bus
  # This class provides actions for list dialects section
  class DialectListSection < SiteHelper::Section

    # Private elements
    #
    element(:dialect_help_msg, css: '#dialect-list-content > p')


    # add dialect input
    element(:dialect_sequence_input, css: '#dialect_sort_sequence')
    element(:dialect_dialect_input, css: '#dialect_dialect')
    element(:dialect_enable_select, css: '#dialect_active')
    element(:dialect_show_select, css: '#dialect_show_to_admin')
    element(:dialect_submit_btn, css: "#dialect-list-content input[value='Submit']")

    # dialect info table
    element(:dialect_list_table, css: "#dialect-list-content table.table-view")

    # Public: return dialect help message
    #
    def dialect_help_message
      dialect_help_msg.text
    end

    # Public: click add dialect link. There are two links: copy all of your inherited dialects, start with the default
    #
    def click_add_dialect_link(link_name)
      find(:xpath, "//div[@id='dialect-list-content']//a[text()='#{link_name}']").click
    end

    # Public: click a dialect link to view this dialect details
    #
    def open_dialect_detail(dialect_name)
      find(:xpath, "//div[@id='dialect-list-content']//a[text()='#{dialect_name}']").click
    end

    def delete_dialect(dialect_name)
      open_dialect_detail(dialect_name)
      find(:xpath, "//div[contains(@id,'dialect-show-')]//a[text()='Delete #{dialect_name}']").click
      alert_accept if alert_present?
    end

    def add_dialect(dialect_info)
      dialect_sequence_input.type_text(dialect_info['Order'])
      dialect_dialect_input.type_text(dialect_info['Code'])
      dialect_enable_select.select(dialect_info['Enabled']) if dialect_info['Enabled']
      dialect_show_select.select(dialect_info['Type']) if dialect_info['Type']
      dialect_submit_btn.click
    end

    def dialect_list_table_hashes
      dialect_list_table.hashes
    end


  end

end

