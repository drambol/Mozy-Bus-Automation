module Freyja

  class ActionPanelPage < SiteHelper::Page
    # Private elements
    element(:download_now, xpath: "//*[@id='act-download']/div[2]")
    element(:exclude_deleted_files_action, xpath: "//*[@title='Exclude Deleted Files']")
    element(:include_deleted_files_action, xpath: "//*[@title='Include Deleted Files']")
    element(:show_versions_action, xpath: "//*[@title='Show Versions...']")
    element(:file_versions_radio, xpath: "//span[@title='Select this Version']")
    element(:include_delete_file_link, xpath: "//div[@id='act-showDeleted']/div[2]")
    element(:add_restore_queue_link, xpath: "//div[@id='act-addCollection']/div[2]")
    element(:view_restore_queue_link, xpath: "//div[@id='act-showCollection']/div[2]")
    element(:remove_restore_queue_link, xpath: "//div[@id='act-subCollection']/div[2]")
    element(:change_date_link, xpath: "//div[@id='act-backInTime']/div[2]")


    # Sync element
    element(:delete_action, xpath: "//*[@title='Delete...']")
    element(:delete_confirm, xpath: "//*[@id='confirm_delete_dialog']//*[text()='Yes']")
    element(:sync_file_name, xpath: "//*[starts-with(@id,'4564:File:')][1]/td[2]/div/span[2]")
    element(:upload_action, xpath: "//*[@title='Upload Files...']")
    element(:upload_progress_bar, id: "static-upload-progressbar")
    element(:upload_success_msg, xpath: "//div[text()='Upload Success']")
    element(:notification_badge, id: "notifications-count")
    element(:upload_files_btn, xpath: "//span[text()='Upload Files']")

    # sections
    section(:large_download_options_section, RestoreOptionsSection, xpath: "//div[@id='act-moreDownload']/div[2]")
    section(:non_default_key_download_section, RestoreOptionsSection, xpath: "//div[@id='act-download']/div[2]")

    #frames
    iframe(:upload_iframe, UploadIframe, :id, 'uploadFrame')

    # Public: launch restore wizard
    #
    # Example
    #   @freyja_site.action_panel_page.open_restore_wizard(section_id)
    #
    # Returns nothing
    def open_restore_wizard(section_id, use_quick_link = false)
      # Looking for link in navigation menu
      find(:xpath, section_id)
      # calling all method does not require to wait
      sections = all(:xpath, section_id)
      el = use_quick_link ? sections.first : sections.last
      if sections.first.element_parent[:class].match(/active/).nil? && sections.last.element_parent[:class].match(/active/).nil?
        el.click
        sleep 5
      end
    end

    def click_download_now
      download_now.click
      sleep 10
    end

    def click_download_now_non_default_key
      download_now.click
      sleep 10
      download_key_btn.click
      sleep 10
    end

    # Public: Click Large Download Options from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.click_large_download_options
    #
    # Returns nothing
    def click_large_download_options
      large_download_options_action.click
    end

    # Public: Click Exclude Deleted Files from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.exclude_deleted_files
    #
    # Returns nothing
    def exclude_deleted_files
      exclude_deleted_files_action.click
    end

    # Public: Click Exclude Deleted Files from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.include_deleted_files
    #
    # Returns nothing
    def include_deleted_files
      include_deleted_files_action.click
    end

    # Public: Delete one file from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.delete_one_file
    #
    # Returns nothing
    def delete_one_file
      sleep 2
      delete_action.click
      sleep 2
      delete_confirm.click
      sleep 2
    end

    # Public: Check file is uploaded
    #
    # Example
    #   @freyja_site.action_panel_page.check_file_uploaded
    #
    # Returns nothing
    def check_one_file_uploaded (machine_id, file_name)
      #wait_until do
      #  upload_progress_bar.visible?
      #end
      #wait_until do
      #  upload_success_msg.visible?
      #end
      #wait_until do
      #  notification_badge.visible?
      #end
      wait_until do
        find(:xpath, "//tr[@id='#{machine_id}:File:/sync/1/#{file_name}']/td[2]/div").visible?
      end
      sleep 10
    end

    # Public: Click show versions from Actions pane
    #
    # Example
    #   @freyja_site.action_panel_page.show_versions
    #
    # Returns nothing
    def click_show_versions
      show_versions_action.click
    end

    # Public: Check file versions are displayed
    #
    # Example
    #   @freyja_site.action_panel_page.check_file_versions
    #
    # Returns true or false
    def check_file_versions
      file_versions_radio.visible?
    end

    def click_upload_file_from_Actions_panel
      upload_action.click
    end

    def click_upload_files_in_Upload_panel
      upload_files_btn.click
    end

    def click_include_exclude_deleted
      include_delete_file_link.click
      sleep 2
    end

    def add_restore_queue
      add_restore_queue_link.click
      sleep 1
    end

    def view_restore_queue
      view_restore_queue_link.click
    end

    def remove_restore_queue
      remove_restore_queue_link.click
    end

    def click_change_date
      change_date_link.click
    end

  end

end