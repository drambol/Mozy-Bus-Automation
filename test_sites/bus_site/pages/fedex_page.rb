module Bus

  class FedEXPage < SiteHelper::Page

    # Public: Return current url
    #
    # @param none
    #
    # Example
    #   @bus_site.fedex_page.current_url
    #
    # @return [String]
    def current_url
      page.current_url
    end

  end
end
