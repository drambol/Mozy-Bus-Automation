#encoding:utf-8
module Freyja
  # This class provides actions for add new admin section
  class RestoreOptionsSection < SiteHelper::Section

    # Private elements
    #
    # Restore wizard
    element(:backup_download_btn, xpath: "//*[@id='backup_tab']//*[text()='Download']")
    element(:restore_all_files_btn, xpath: "//*[@id='backup_tab']//a[@title='Restore All Files...']")
    element(:restore_name_tb, xpath: "//*[@id='wizard_main']//*[@id='restore_name']")
    element(:next_btn, xpath: "//*[@id='wizard_buttons']//*[@id='button-next']//div[contains(@class,'content')]")
    element(:close_btn, xpath: "//*[@id='restore_complete_buttons']//*[@id='button-close']")
    element(:fryr_restore_option, xpath: "//span[@id='choose_delivery_method_download_manager']")
    element(:archive_rb, xpath: "//span[@id='choose_delivery_method_archive']")
    element(:media_rb, xpath: "//span[@id='choose_delivery_method_media']")
    element(:fryr_download_link, xpath: "//*[@id='install_download_manager']//*[@id='download_download_manager_link']")
    element(:fryr_download_link_sync, xpath: "//div[@id='install_download_manager']/table/tbody/tr/td[2]/a")
    #element(:begin_download_btn, xpath: "//div[text()='Begin Download']")
    element(:begin_download_btn, xpath: "(//div[@id='button-next']/div[2])[2]")
    element(:stop, xpath: "//div[29]/span")

    # Media restore shipping address info
    element(:order_name_tb, xpath: "//input[@id='dvd_order_name']")
    element(:order_address1_tb, xpath: "//input[@id='dvd_order_address1']")
    element(:order_city_tb, xpath: "//input[@id='dvd_order_city']")
    element(:order_state_tb, xpath: "//input[@id='dvd_order_state']")
    element(:order_zip_tb, xpath: "//input[@id='dvd_order_zip']")
    element(:order_country_select, xpath: "//select[@id='dvd_order_country']")
    element(:order_phonenumber_tb, xpath: "//input[@id='dvd_order_phonenumber']")

    # Media restore credit card info
    element(:cc_name_tb, xpath: "//input[@id='cc_name']")
    element(:cc_number_tb, xpath: "//input[@id='cc_number']")
    element(:cc_expired_date_tb, xpath: "//input[@id='cc_expired_date']")
    element(:cc_cvv2_tb, xpath: "//input[@id='cc_cvv2']")
    element(:agreement_checkbox, xpath: "//span[@id='agree_with_mozy_policy_check_box']")

    # restore status
    element(:restore_status_div, xpath: "//*[@id='dt_all_restores']/tbody/tr[1]/td[5]/div")

    def large_download_options_restore(restore, language)
      fill_restore_name(restore.restore_name)
      click_next
      case restore.restore_type
        when 'fryr'
          restore_manager_restore
        when 'archive'
          archive_restore
        when 'media'
          media_restore(restore, language)
      end
    end

    def restore_all_files(restore)
      fill_restore_name(restore.restore_name)
      click_next
      sleep 3
      click_next
      sleep 3
      unless restore.type == 'vms'
        click_next
        sleep 3
      end
      case restore.restore_type
        when 'fryr'
          restore_manager_restore
        when 'archive'
          archive_restore
        when 'media'
          media_restore(restore)
      end
    end

    def non_default_key_sync_Fryr_restore(restore)
      fill_restore_name(restore.restore_name)
      click_next
      #stop.click
      restore_manager_restore_sync
    end

    def fill_restore_name(restore_name)
      restore_name_tb.type_text(restore_name)
    end

    def click_next
      wait_until do
        next_btn.visible?
      end
      next_btn.click
    end

    def click_close
      wait_until do
        close_btn.visible?
      end
      close_btn.click
    end

    def restore_manager_restore
      if page.has_xpath?("//span[@id='choose_delivery_method_download_manager']") then
        fryr_restore_option.click
      end
      sleep 5
      click_next
      sleep 15
      if fryr_download_link.visible? then
        fryr_download_link.click
      end
      sleep 10
      begin_download_btn.click
      click_close
      sleep 1
    end

    def restore_manager_restore_sync
      #if page.has_xpath?("//span[@id='choose_delivery_method_download_manager']") then
      #  fryr_restore_option.click
      #end
      #sleep 5
      #click_next
      #sleep 15
      if fryr_download_link.visible? then
        fryr_download_link.click
      end
      sleep 10
      begin_download_btn.click
      click_close
      sleep 1
    end

    def archive_restore
      archive_rb.click
      sleep 2
      click_next
      sleep 2
      click_close
      sleep 2
    end

    def media_restore(restore, language = "English")
      unless restore.type == 'vms'
        media_rb.click
        sleep 1
        click_next
        sleep 1
      end
      fill_media_address(restore.address_info, language)
      click_next
      sleep 2
      click_next
      #fill_media_payment(restore.credit_card)
      #click_next
      #click_close
      #sleep 1
    end

    def fill_media_address(address_info, language)
      order_name_tb.type_text(address_info.name)
      order_address1_tb.type_text(address_info.address)
      order_city_tb.type_text(address_info.city)
      order_state_tb.type_text(address_info.state)
      order_zip_tb.type_text(address_info.zip)
      case language
        when "Deutsch"
          address_info.country = "Afghanistan"
        when "Español (castellano)"
          address_info.country = "Australia"
        when "Français"
          address_info.country = "Australie"
        when "Italiano"
          address_info.country = "Guyana"
        when "日本語"
          address_info.country = "中国"
        when "Nederlands"
          address_info.country = "Ghana"
        when "Português (Brasil)"
          address_info.country = "Catar"
      end
      order_country_select.select(address_info.country)
      order_phonenumber_tb.type_text(address_info.phone)
    end

    def fill_media_payment(credit_card)
      cc_name_tb.type_text(credit_card.full_name)
      cc_number_tb.type_text(credit_card.number)
      cc_expired_date_tb.type_text("#{credit_card.expire_month}/#{credit_card.expire_year}")
      cc_cvv2_tb.type_text(credit_card.cvv)
      agreement_checkbox.click
    end

  end
end
