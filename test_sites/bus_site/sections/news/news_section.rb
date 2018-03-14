module Bus
  # This class provides actions for news section
  class NewsSection < SiteHelper::Section

    # Public: check the div is visible
    #
    #
    # Example
    #   @bus_site.admin_console_page.news_section.find_div_is_visiable(id)
    #
    # @return [] nothing
    def find_div_is_visiable(id)
      find(:xpath, "//div[@id='#{id}']").visible?
    end

  end
end
