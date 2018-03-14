module Freyja

  class SearchPage < SiteHelper::Page

      element(:search_input, xpath: "//*[@id='search-input']")           #        id: 'search-input'
      element(:conduct_search_btn, xpath: "//section[@id='application']/header/div[2]/div/div")
      element(:search_box, css: "div.search-box.search-box-container")

      # Public: type search keyword
      #
      # Example
      #   @freyja_site.search_page.input_search
      #
      # Returns nothing
      def input_search(search_string)
        sleep 5
        search_box.click
        sleep 5
        search_input.type_text(search_string)
        sleep 5
      end

      # Public: click search button to begin search
      #
      # Example
      #   @freyja_site.search_page.execute_search
      #
      # Returns nothing
      def execute_search
        conduct_search_btn.click
        sleep 5
      end

      def verify_search_result(search_string)
        sleep 1
        page.has_content?("Search Results for '"+search_string.to_s+"'")
        sleep 10
      end

  end
end