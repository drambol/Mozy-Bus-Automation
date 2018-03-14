module Freyja

  class DetailPanelPage < SiteHelper::Page

    element(:backup_download_btn, xpath: "//*[@id='backup-layout']/div/table/tbody/tr/td/table/tbody/tr/td[2]/div/div[2]/div[1]/div/a[1]/span")
    element(:download_key_btn, xpath: "//*[@id='decrypt_utility_dialog']/div[4]/div/a/span")
    section(:restore_all_files_section, RestoreOptionsSection, xpath: "//*[contains(@id,'_tab')]")

    # Public: launch restore wizard
    #
    # Example
    #   @freyja_site.detail_panel_page.open_restore_all_files_wizard(section_id)
    #
    # Returns nothing
    def open_restore_all_files_wizard(section_id, use_quick_link = false)
      # Looking for link in navigation menu
      find(:xpath, section_id)
      # calling all method does not require to wait
      sections = all(:xpath, section_id)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
      end
    end

    def click_download
      backup_download_btn.click
      sleep 2
    end

    def click_download_non_default_key
      backup_download_btn.click
      sleep 2
      download_key_btn.click
      sleep 2
    end

  end
end