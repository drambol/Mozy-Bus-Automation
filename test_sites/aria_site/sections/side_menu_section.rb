module Aria
  # This class provides actions for search account page section
  class SideMenuSection < SiteHelper::Section

    # Private elements
    #
    element(:search_tb, css: "input[name='inSearchString']")
    element(:search_btn, css: "input[value='Search']")

    # Public: Search account by search text
    #
    # Examples
    #  @bus_admin_console_page.search_account_section.search_account("qa1+test@mozy.com")
    #
    # Returns Nothing
    def search_account(search_text)
      search_tb.type_text(search_text)
      search_btn.click
    end

    # Public: navigate to link by link title attribute
    #
    def navigate_to_link(link_name)
      find(:xpath, "//a[@title='#{link_name}']").click
    end
  end
end