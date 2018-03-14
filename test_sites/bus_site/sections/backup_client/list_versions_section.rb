module Bus
  # This class provides actions for list versions page section
  class ListVersionsSection < SiteHelper::Section

    # Private elements
    #
    # list version info
    element(:platform_select, id: 'platform_type')
    element(:show_disabled_check, id: 'show_disabled')
    element(:list_version_btn, xpath: "//input[@value='Update']")
    element(:version_list_table, css: "div#version-list-content table.table-view")


    # Public: list selected client version
    #
    def list_version(version_info)
      platform_select.select(version_info['platform']) unless version_info['platform'].nil?

      case version_info['show disabled']
        when 'true'
          show_disabled_check.check
        when 'false'
          show_disabled_check.uncheck
        else
          raise 'you can only input true or false for the Locked value'
      end

      list_version_btn.click
      wait_until_bus_section_load
    end

    # Public: get version list table hash
    #
    def version_list_table_hash
      version_list_table.hashes
    end

    # Public: click required version number link to view version details
    #
    def view_version(number)
      find(:xpath,"//a[text()='#{number}']").click
    end

    # Public: check if version exists in list versions section
    def version_listed?(number)
      !(locate(:xpath,"//a[text()='#{number}']").nil?)
    end





  end

end

