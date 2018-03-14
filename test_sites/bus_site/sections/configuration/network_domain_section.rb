module Bus
  # This class provides actions for add edit network domain
  class NetworkDomainSection < SiteHelper::Section

    element(:alias_input, id: "newdomain_alias")
    element(:guid_input, id: "newdomain_sid")
    element(:ou_input, id: "newdomain_ou")
    element(:ug_input, xpath: "//input[@name='user_group_name']")
    element(:ug_search_btn, xpath: "//img[contains(@src,'searchBtn.png')]")
    element(:key_type_select, xpath: "//select[contains(@name,'newdomain')]")
    element(:create_button, xpath: "//input[@value='Create']")
    element(:edit_button, xpath: "//input[@value='Edit']")
    element(:remove_button, xpath: "//input[@value='Remove']")
    element(:update_button, xpath: "//input[@value='Update']")
    element(:network_domain_msg, xpath: "//div[contains(@id,'setting-netdomain')]//li")
    element(:record_table, xpath: "//div[@id='setting-netdomains_list-content']/table")
    element(:loading_img, xpath: "//img[@alt='Suggestions loading...']")

    #There are 1 second delay that the alias is visible but disabled, which causes the entire steps failed.
    #Add code to identify whether the alias_input has empty value or not, if not empty, which means the element is at editable status.
    #Update for TC.122224.
    def add_update_network_domain(network_domain, save, action)
      key_type_select.select(network_domain.key_type) unless network_domain.key_type.nil?
      wait_until{alias_input.visible?}
      wait_until{alias_input.value != ""} if action == "update"
      alias_input.type_text(network_domain.nd_alias)
      guid_input.type_text(network_domain.guid)
      ou_input.type_text(network_domain.ou)
      search_group_values = []
      if !network_domain.user_group.nil?
        ug_input.type_text(network_domain.user_group)
        page.driver.execute_script("document.querySelector('img[alt=\"Search-button-icon\"]').click()")
        wait_until { !loading_img.visible?}
        search_group_values = all(:xpath,"//div[contains(@id,'auto_complete')]//li").map{|element|element.text.strip}
        unless network_domain.user_group == ''
          find(:xpath,"//li[text()='#{network_domain.user_group}']").click
          wait_until {!find(:xpath,"//li[text()='#{network_domain.user_group}']").visible?}
        end
      end
      if action == "update"
        update_button.click
      else
        create_button.click if save
      end
      search_group_values
    end

    def click_create_button
      create_button.click
    end

    def network_domain_message
      wait_until{network_domain_msg.visible?}
      network_domain_msg.text
    end

    def click_edit
      edit_button.click
    end

    def network_domain_record
      record_table.hashes
    end

    def remove_network_domain
      remove_button.click
      alert_accept
    end


  end
end
