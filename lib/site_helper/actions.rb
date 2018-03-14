module SiteHelper
  module Actions
    include Capybara::DSL

    # Public: Switch page content to iframe
    #
    # Example:
    #    switch_to_iframe(%w( outerFrame mainFrame work_frm inner_work_frm ))
    #    or
    #    switch_to_iframe('outerFrame')
    #
    # Returns nothing
    def switch_to_iframe(frame_ids)
      switch_to_default_frame
      case frame_ids
        when String
          sleep 5 # Force wait
          page.driver.browser.switch_to.frame(frame_ids)
        when Array
          frame_ids.each do |id |
            sleep 5 # Force wati
            page.driver.browser.switch_to.frame(id)
          end
        when Numeric
          #by frame index
          page.driver.browser.switch_to.frame(frame_ids)
        else
          raise "Unknown input value type"
      end
    end

    # Public: switch
    #
    # Returns nothing
    def switch_to_default_frame
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.default_content
      else
        raise("switch_to_default_frame method only works for Selenium Driver")
      end
    end

    # Public: alert_text
    #
    # Returns nothing
    def alert_text
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.text
      else
        raise("alert_text method only works for Selenium Driver")
      end
    end

    # Public: alert_accept
    #
    # Returns nothing
    def alert_accept
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.accept
      else
        raise("alert_accept method only works for Selenium Driver")
      end
    end

    # Public: alert_dismiss
    #
    # Returns nothing
    def alert_dismiss
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to.alert.dismiss
      else
        raise("alert_dismiss method only works for Selenium Driver")
      end
    end

    def alert_present?
      begin
        page.driver.browser.switch_to.alert
        $alert_text = alert_text
        #puts $alert_text
        #puts "Alert present!"
        return true
      rescue
        #puts "No alert present."
        return false
      end
    end

    # Public: Refresh bus admin console section
    #
    # Example:
    #   @bus_site.admin_console_page.refresh_bus_section
    #
    # Returns nothing
    def refresh_bus_section
      root_element.find(:css, 'h2>a[onclick^=refresh_module]').click
      loading = root_element.find(:css, 'h2>a[onclick^=toggle_module]')
      unless loading[:class].nil?
        wait_until{ loading[:class].match(/loading/).nil? }
      end
      # I found automation is still too faster, I need force to wait until table is loaded
      # Possible refactor here
      sleep 2
    end

    # Public: close bus admin console section
    #
    # Example:
    #   @bus_site.admin_console_page.close_bus_section
    #
    # Returns nothing
    def close_bus_section
      root_element.find(:css, "a[onclick^='delete_module']").click
    end

    def collapse_bus_section
      if root_element[:class] =~ /adminbox-active/
        root_element.find(:css, 'a.title').click
      end
    end

    def expand_bus_section
      if root_element[:class] =~ /adminbox-inactive/
        root_element.find(:css, 'a.title').click
      end
    end

    # Public: Wait until bus admin console section loaded
    #
    # Example:
    #   @bus_site.admin_console_page.search_list_partner_section.wait_until_bus_section_load
    #
    # Returns nothing
    def wait_until_bus_section_load(element_hash = {})
      loading = root_element.find(:css, 'h2 a[onclick^=toggle_module]')
      unless loading[:class].nil?
        begin
          wait_until{ loading[:class].match(/loading/).nil? }
        #Give the following step a chance to try even though the section does not finish loading.
        #Sometimes, timeout just means the "loading" css is not removed, but the content is actually loaded
        rescue Capybara::TimeoutError => ex
          Log.debug ex.to_s
        end
      end
      unless element_hash.empty?
        element_hash.each do | key, value |
          root_element.find(key, value)
        end
      end
      # I found automation is still too faster, I need force to wait until table is loaded
      # Possible refactor here
      # 2 seconds is still not enough: "search partner -> click on partner name", then no response to the click event
      sleep 5
    end

    def wait_until_ajax_finished(elements)
      elements = [elements] unless elements.is_a? Array
      elements.each do |el|
        wait_until{ el.text.match(/.*Loading.*/).nil? }
      end
    end

    # Public: Is section visible and active
    #
    # Example:
    #   @bus_site.admin_console_page.search_list_partner_section.section_visible?
    #
    # Returns bool
    def section_visible?
      root_element.visible?
    end

    # Public: Find element by args
    # Highlight element if found
    #
    # Return Element
    def find_with_highlight(*args)
      el = find(*args)
      el.highlight
      el
    end

    def view_partner_info
      find(:xpath, "//div[@id='identify-me']/a[1]").click
    end

    def log(text)
      $logFile.puts("======[Log]:#{text}======\n")
    end

  end
end
