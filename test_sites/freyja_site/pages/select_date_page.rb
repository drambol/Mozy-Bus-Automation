module Freyja

  class SelectDate < SiteHelper::Page

    element(:go_btn, xpath: "//div[@id='button-next']/div[2]")

    # Public: click Go to close change date panel
    #
    # Example
    #   @freyja_site.select_date_page.click_go
    #
    # Returns nothing
    def click_go
      go_btn.click
    end

  end
end