module Freyja

  class RestoreQueuePage < SiteHelper::Page

    element(:select_all_files_box, xpath: "//div[@id='dt-backuplist-restore-collection_wrapper']/div[2]/div/div/div/div/table/thead/tr/th/div/span")

    # Public: verify show restore queue
    #
    # Example
    #   @freyja_site.restore_queue_page.verify_show_restore_queue
    #
    # Returns true or false
    def verify_show_restore_queue
       page.has_link?("Restore Queue")
    end

    def select_all_files
      select_all_files_box.click
      sleep 10
    end

    def verify_no_files_restore_queue
      page.has_content?("You have not selected any items yet.")
    end

  end
end