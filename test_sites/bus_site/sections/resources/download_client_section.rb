module Bus
  # This class provides actions for edit client version section
  class DownloadClientSection < SiteHelper::Section

    # Private elements
    #
    element(:version_details_div, xpath: "//div[@class='detail_blind' and contains(@style, 'visible')]")
    element(:md5_help_link, xpath: "//div[@class='detail_blind' and contains(@style, 'visible')]//a[text()='(what is this?)']")
    element(:md5_help_div, xpath: "//div[@class='detail_blind' and contains(@style, 'visible')]//div[@class='md5help']")
    element(:md5_help_close_link, xpath: "//div[@class='detail_blind' and contains(@style, 'visible')]//div[@class='md5help']//a[text()='(click to close)']")
    element(:release_note_link, xpath: "//div[@class='detail_blind' and contains(@style, 'visible')]//a[text()='Release Notes']")

    # Public: check whether the download link present for given link text in download * client section
    #
    def download_link_present?(link_name)
      !(locate(:xpath, "//a[contains(text(),'#{link_name}')]").nil?)
    end

    # Public: get client download info under Windows,Mac,Linux for given type (Backup/Sync Clients)
    #
    def client_download_info_hash(type)
      client_type_ele = all(:xpath,"//div[preceding-sibling::h3[1][text()='#{type}']]") 
      download_info_hashes = {}
      platform = ''
      client_type_ele.each { |ele|
        if ['Windows','Mac','Linux'].include?(ele.text)
          platform = ele.text
          download_info_hashes[platform] = ''
        else
          download_info_hashes[platform] += ele.text
        end
      }
      download_info_hashes
    end

    # Public: click download link which contains given string and returns client name of download item 
    #
    def click_link(link_name)
      if link_name.include?('Mac OS X 10.5 (Intel): ')
        download_link = find(:xpath, "//span[text()='Mac OS X 10.5 (Intel): ']").next_sibling
      else
        download_link = find(:xpath, "//a[contains(text(),'#{link_name}')]")
      end
      href = download_link.native.attribute 'href'
      download_link.click
      link_name.include?('vSphere')? href[/images\/.+$/].gsub('images/','') : href[/downloads\/.+$/].gsub('downloads/','')
    end

    # Public: click Details/Other Releases link of a given client
    #
    def open_view(link, client)
      find(:xpath, "//a[contains(text(),'#{client}')]//parent::div//a[text()='#{link}']").click
    end

    # check if client started downloading
    #
    def start_downloading?(client_name)
      file_name =  "#{default_download_path}/#{client_name}"
      i = 0
      15.times do
        break if ( File.size?(file_name).to_i + File.size?(file_name+'.part').to_i ) > 0
        sleep(1)
      end
      return (File.size?(file_name).to_i+File.size?(file_name+'.part').to_i) > 0
    end

    # Public: Get the version details info (Download, MD5, Date) of the opened version details link or other releases link
    #
    def details_info_hash(version_name)
      if version_name == ""
        details_parent_div = version_details_div
      else
        details_parent_div = find(:xpath, "//div[@class='other_blind' and contains(@style, 'visible')]//a[text()='#{version_name[1..-1]}']").great_grandparent
      end

      details_hash = {}
      1.upto(3) do |i|
        info_line = details_parent_div.first_child.child[i].text
        key = info_line[/(.+):/]
        value = info_line.include?('(') ? info_line[/: (.+) \(/][2..-3] : info_line[/: (.+)$/][2..-1]
        details_hash[key] = value
      end
      details_hash
    end

    # Public: open md5 help div
    #
    def view_md5_help
      md5_help_link.click
    end

    # Public: close md5 help div
    #
    def close_md5_help
      md5_help_close_link.click
    end

    # Public: get md5 help message
    #
    def md5_help_text
      md5_help_div.visible?? md5_help_div.text : nil
    end

    # Public: get all the release version name of Upcoming/Older releases in the opened other releases div
    #
    def other_releases_array(release_type)
      version_name_array = []
      releases_list = find(:xpath,"//div[@class='other_blind' and contains(@style, 'visible')]//h4[text()='#{release_type}']").next_sibling
      releases_list.child.each { |ele|
        version_name_array << ele.first_child.text }
      version_name_array
    end



  end

end

