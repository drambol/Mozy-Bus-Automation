module Bus
  # This class provides actions for contact section
  class ContactSection < SiteHelper::Section
    # Private elements
    #

    #elements on Document
    element(:search_input, xpath: "//form[@id='searchForm']//input[1]")
    element(:search_button_input, xpath: "//input[@value='Search']")
    element(:search_results_h, xpath: "//div[@class='search-content']//h3")


    # Public: Click Community
    #
    # Examples:
    #  @bus_site.admin_console_page.contact_section.click_community
    #
    # @return [] nothing
    def click_link_in_contact_section(link)
      find(:xpath, "//a[text()='#{link}']").click
    end

    # Public: Check Link is exists
    #
    # Examples:
    #  @bus_site.admin_console_page.contact_section.check_link
    #
    def check_link(link)
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      find(:xpath, "//a[text()='#{link}']").visible?
    end

    # Public: search something
    #
    # Examples:
    #  @bus_site.admin_console_page.contact_section.search_subject("test")
    #
    def search_subject(subject)
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      search_input.type_text(subject)
      search_button_input.click
    end

    # Public: get search results title
    #
    # Examples:
    #  @bus_site.admin_console_page.contact_section.get_search_results_title
    #
    def get_search_results_title
      page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      search_results_h.text
    end

  end
end
