module CMS
  # This class provides actions for cms pages
  class ContentPages < SiteHelper::Page

    set_url("http://mozy.com")

    # download links of tenjin home page
    element(:backup_download_link, css: "a[href='/product/download/backup']")
    element(:sync_download_link, css: "a[href='/product/download/sync']")
    element(:mobile_download_link, css: "a[href='/product/download/mobile-apps']")

    #sync client download page
    element(:sync_win_download_link, css: "a[href$='/mozy-sync.exe']")
    element(:sync_mac_download_link, css: "a[href$='/mozy-sync.dmg']")

    #backup client download page
    element(:mozyhome_download_link, css: "a[href='/product/download/backup/mozyhome']")
    element(:mozypro_download_link, css: "a[href='/product/download/backup/mozypro']")

    #home backup client download page
    element(:mozyhome_win_download_link, css: "a[href$='/downloads/mozysetup.exe']")
    element(:mozyhome_mac_download_link, css: "a[href$='/downloads/mozysetup.dmg']")
    #pro backup client download page
    element(:mozypro_win_download_link, css: "a[href$='/downloads/mozyprosetup.exe']")
    element(:mozypro_mac_download_link, css: "a[href$='/downloads/mozyprosetup.dmg']")
    element(:mozypro_deb32_download_link, css: "a[href$='/downloads/mozypro-deb-32setup.deb']")
    element(:mozypro_deb64_download_link, css: "a[href$='/downloads/mozypro-deb-64setup.deb']")
    element(:mozypro_rpm32_download_link, css: "a[href$='/downloads/mozypro-rpm-32setup.rpm']")
    element(:mozypro_rpm64_download_link, css: "a[href$='/downloads/mozypro-rpm-64setup.rpm']")


    #---Steps to download home client
    def download_home_client()
      backup_download_link.click
      mozyhome_download_link.click
      client_downloaded?(mozyhome_win_download_link,'mozysetup.exe') &&
          client_downloaded?(mozyhome_mac_download_link,'mozysetup.dmg')
    end

    #---Steps to download sync client
    def download_sync_client()
      sync_download_link.click
      client_downloaded?(sync_win_download_link,'mozy-sync.exe') &&
          client_downloaded?(sync_mac_download_link,'mozy-sync.dmg')
    end

    #---Steps to download pro client
    def download_pro_client()
      backup_download_link.click
      mozypro_download_link.click
      client_downloaded?(mozypro_win_download_link,'mozyprosetup.exe') &&
          client_downloaded?(mozypro_mac_download_link,'mozyprosetup.dmg') &&
          client_downloaded?(mozypro_deb32_download_link,'mozypro-deb-32setup.deb') &&
          client_downloaded?(mozypro_deb64_download_link,'mozypro-deb-64setup.deb') &&
          client_downloaded?(mozypro_rpm32_download_link,'mozypro-rpm-32setup.rpm') &&
          client_downloaded?(mozypro_rpm64_download_link,'mozypro-rpm-64setup.rpm')
    end

    # check if client downloaded successfully
    def client_downloaded?(client_download_link, client_name)
      file_name =  "#{default_download_path}/#{client_name}"
      client_download_link.click
      i = 0
      30.times do
        break if ( File.size?(file_name).to_i + File.size?(file_name+'.part').to_i ) > 0
        sleep(1)
      end
      return (File.size?(file_name).to_i+File.size?(file_name+'.part').to_i) > 0
    end

    def download_check_verification
      backup_download_link.visible? && sync_download_link.visible? && mobile_download_link.visible?
    end
  end
end
