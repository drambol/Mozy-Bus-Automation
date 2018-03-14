module Freyja

  class ProductDownloadPage < SiteHelper::Page

    element(:view_website_link, css: "div.device > a")
    element(:download_backup, xpath: "//*[@id='download-content']/div[1]/div[1]/a/span")
    element(:download_sync, xpath: "//*[@id='download-content']/div[1]/div[2]/a/span")
    element(:additional_download_mac, xpath: "//*[@id='all-clients']/li/div[2]/a")
    element(:additional_download_win, xpath: "//*[@id='all-clients']/li/div[2]/span/span/a")
    element(:all_software_button, xpath: "//*[@id='view-all']/button")
    # Public: click view website
    #
    # Example
    #   @freyja_site.product_download_page.click_view_website
    #
    # Returns nothing
    def click_view_website
      view_website_link.click
    end

    def click_backup_software
      download_backup.click
    end

    def click_backup_sync
      download_sync.click
    end

    def click_additional_download
      all_software_button.click
      additional_download_mac.click
      sleep(5)
      all_software_button.click
      additional_download_win.click
    end
  end
end