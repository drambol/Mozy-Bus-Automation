module Freyja

  class MainPage < SiteHelper::Page

    element(:backupDevice, css: "a[onclick*=ACCESS_CONTROLLER_BACKUP]")
    element(:syncDevice, css: "a[onclick*=ACCESS_CONTROLLER_SYNC]")
    element(:vmDevice, css: "a[onclick*=ACCESS_CONTROLLER_VMBU]")
    element(:action_panel_toggle, css: 'div.panel-toggle.btn-panel-toggle')
    element(:options_menu, css: 'span.text.username')
    element(:latest_version_radio, css: 'span.radio.radio-off')

    element(:options_menu, xpath: "//div[@id='menu-user']")
    element(:latest_version_radio, css: 'span.radio.radio-off')

    # Activate user element
    element(:user_password_set_text, xpath: "//input[@id='password']")
    element(:user_password_set_again_text, xpath: "//input[@id='password_confirmation']")
    element(:user_continue_activate_btn, xpath: "//div[text()='Activate account']")
    element(:add_to_restore_queue, xpath: "//div[@id='context-menu']//li[@title='Add to Restore Queue']")
    element(:remove_from_restore_queue, xpath: "//div[@id='context-menu']//li[@title='Remove from Restore Queue']")
    element(:view_restore_queue, xpath: "//div[@id='context-menu']//li[@title='View Restore Queue']")
    element(:restores_vm_in_queue, xpath: "//div[@id='context-menu']//li[@title='Restore VMs in Queue...']")

    # Public: enter into one backup device
    #
    # Example
    #   @freyja_site.main_page.choose_one_backup_device(machineID)
    #
    # Returns nothing
    def choose_one_backup_device(machineID)
      if machineID == ''
        find(:xpath, "//*[contains(@id,':Folder:')][1]/td[1]/div/span").click
      else
        find(:xpath, "//*[starts-with(@id,'#{machineID}:Folder:')][1]/td[1]/div/span").click
      end
    end

    # Public: choose one device tab
    #
    # Example
    #   @freyja_site.main_page.chooseDevice(deviceTab)
    #
    # Returns nothing
    def chooseDevice(deviceTab)
      case deviceTab
        when 'Devices'
          wait_until do
            backupDevice.visible?
          end
          backupDevice.click
        when 'Synced'
          wait_until do
            syncDevice.visible?
          end
          syncDevice.click
        when 'vSphere VMs'
          wait_until do
            vmDevice.visible?
          end
          vmDevice.click
      end
    end

    # Public: choose one file in sync
    #
    # Exampl
    #   @freyja_site.main_page.Drillin_sync_file
    #
    # Returns nothing
    def Drillin_sync_file(machineID, filePath)
      pathArray = filePath.to_s.split('/')
      pathLength = 0
      folderPath = ""
      (pathArray.size-1).times do
        if pathLength == 0
          folderPath = folderPath + pathArray[pathLength]
        else
          folderPath = folderPath + '/' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPath}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:File:/sync/1/#{filePath}']/td[1]/div/span").click
      sleep 2
    end

    # Public: choose one folder in sync
    #
    # Example
    #   @freyja_site.main_page.Drillin_sync_folder
    #
    # Returns nothing
    def Drillin_sync_folder(machineID, folderPath)
      pathArray = folderPath.to_s.split('/')
      pathLength = 0
      folderPathList = ""
      (pathArray.size-1).times do
        if pathLength == 0
          folderPathList = folderPathList + pathArray[pathLength]
        else
          folderPathList = folderPathList + '/' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPathList}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:Folder:/sync/1/#{folderPath}']/td/div/span").click
      sleep 2
    end

    # Public: choose one file in backup
    #
    # Example
    #   @freyja_site.main_page.Drillin_win_backup_file
    #
    # Returns nothing
    def Drillin_win_backup_file(machineID, filePath)
      pathArray = filePath.to_s.split('\\')
      pathLength = 0
      folderPath = ""
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
      (pathArray.size-1).times do
        if  pathLength == 0
          folderPath = folderPath + pathArray[pathLength]
        else
          folderPath = folderPath + '\\' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPath}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:File:test_data/#{filePath}']/td/div/span").click
      sleep 2
    end

    # Public: choose one folder in backup
    #
    # Example
    #   @freyja_site.main_page.Drillin_win_backup_folder
    #
    # Returns nothing
    def Drillin_win_backup_folder(machineID, folderPath)
      pathArray = folderPath.to_s.split('\\')
      pathLength = 0
      folderPathList = ""
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
      (pathArray.size-1).times do
        if  pathLength == 0
          folderPathList = folderPathList + pathArray[pathLength]
        else
          folderPathList = folderPathList + '\\' + pathArray[pathLength]
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPathList}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPath}']/td/div/span").click
      sleep 2
    end

    def open_actions_panel
      action_panel_toggle.click
      sleep 1
    end

    def select_options_panel
      options_menu.click
      sleep 1
    end

    def select_uploaded_file(machine_id, file_name)
      find(:xpath, "//tr[@id='#{machine_id}:File:/sync/1/#{file_name}']/td/div/span").click
    end

    def select_latest_version
      latest_version_radio.click
    end

    def check_file_exist(machine_id, file_name)
      #find(:xpath, "//tr[@id='#{machine_id}:File:/sync/1/#{file_name}']/td/div/span").visible?
      #puts page.has_xpath?("//tr[@id='#{machine_id}:File:/sync/1/#{file_name}']/td/div/span")
      false
    end

    def select_backup_device(machineID)
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
    end

    def click_vm(vm)
      find(:xpath, "//span[text()='#{vm}']").click
    end

    def select_options_panel
      wait_until{options_menu.visible?}
      options_menu.click
    end

    def set_user_password (password)
      user_password_set_text.type_text(password)
      user_password_set_again_text.type_text(password)
      wait_until {user_continue_activate_btn.visible?}
      user_continue_activate_btn.click
    end

    def restore_vm(vm)
      el = find(:xpath, "//*[text()='#{vm}']")
      page.driver.browser.action.context_click(el.native).perform
      if all(:xpath, "//div[@id='context-menu']//li[@title='Remove from Restore Queue']").size == 1
        remove_from_restore_queue.click
        page.driver.browser.action.context_click(el.native).perform
        wait_until{add_to_restore_queue.visible?}
      end
      add_to_restore_queue.click
      page.driver.browser.action.context_click(el.native).perform
      wait_until{view_restore_queue.visible?}
      view_restore_queue.click
      el = find(:xpath, "//*[@title='#{vm}']")
      page.driver.browser.action.context_click(el.native).perform
      wait_until{restores_vm_in_queue.visible?}
      restores_vm_in_queue.click
    end

    # Public: choose one folder in backup (new)
    #
    # Example
    #   @freyja_site.main_page.Drillin_win_backup_folder
    #
    # Returns nothing
    def Drillin_win_backup_file_slash(machineID, filePath)
      puts 'split path by slash, not back slash'
      pathArray = filePath.to_s.split('/')
      pathLength = 0
      folderPath = ""
      find(:xpath, "//tr[@id='#{machineID}:Folder:']/td[2]/div/span[2]/span").click
      (pathArray.size-1).times do
        if pathLength == 0
          #======tell whether the root is "/" or a directory======
          if pathArray[pathLength] = ""
            folderPath = "/"
          else
            folderPath = folderPath + pathArray[pathLength]
          end
        else
          if folderPath == '/'
            folderPath = folderPath + pathArray[pathLength]
          else
            folderPath = folderPath + '/' + pathArray[pathLength]
          end
        end
        find(:xpath, "//tr[@id='#{machineID}:Folder:#{folderPath}']/td[2]/div/span[2]/span").click
        sleep 2
        pathLength += 1
      end
      find(:xpath, "//tr[@id='#{machineID}:File:#{filePath}']/td/div/span").click
      sleep 2
    end

  end
end
