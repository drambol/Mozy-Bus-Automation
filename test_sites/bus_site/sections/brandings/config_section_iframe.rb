module Bus
  # This class provides actions for add new partner page section
  class ConfigIframe < SiteHelper::Iframe

    element(:css_input, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[1]/textarea")
    element(:footer_input, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[3]/textarea")

    element(:save_changes_btn, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[2]/li[7]/p/input")

    element(:upload_image_btn, id: "image")

    #tab
    element(:footer_tab, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[1]/li[3]")
    element(:image_tab, xpath: "//*[@id='site_branding-webrestore_site-tabs']/ul[1]/li[2]")


    def css_header_color_hex
      color_hex_list = ["#FAEBD7", "#00FFFF", "#8A2BE2", "#FF1493", "#00BFFF", "#FF00FF", "#FFD700", "#E0FFFF", "#00FF00", "#BA55D3"]
      color_hex = color_hex_list[rand(10)]
      puts color_hex
      header_hex = ".content-header{ background-color: " + color_hex +";}"
      footer_hex = ".footer{ background-color: " + color_hex +";}"
      css_input.type_text(header_hex+"      "+footer_hex)
      sleep 3
    end

    def css_header_color_name
      color_name_list = ["AliceBlue", "Aqua", "BlanchedAlmond", "Chartreuse", "Coral", "Crimson", "DarkBlue", "DarkSalmon", "Fuchsia", "GreenYellow"]
      color_name = color_name_list[rand(10)]
      puts color_name
      header_name = ".content-header{ background-color: " + color_name +";}"
      footer_name = ".footer{ background-color: " + color_name +";}"
      css_input.type_text(header_name+"      "+footer_name)
      sleep 3
    end

    def remove_header_color
      css_input.type_text(" ")
    end

    def click_save_changes
      save_changes_btn.click
      sleep 5
    end

    def input_footer
      footer_input.type_text("<div align=center>
<a href='http://www.cnn.com/' target='_blank'>This link is setup on Freyja automation Partner, and directs the user to the automation homepage "+"#{Time.now.strftime("%Y%m%d-%H%M%S")}"+"</a>
</div>")
    end

    def choose_footer_tab
      footer_tab.click
    end

    def input_sub_footer
      footer_input.type_text("<div align=center>
<a href='http://www.cnn.com/' target='_blank'>SUB***Partner: This link is setup on Freyja automation Partner, and directs the user to the automation homepage "+"#{Time.now.strftime("%Y%m%d-%H%M%S")}"+"</a>
</div>")
    end

    def remove_footer
      footer_input.type_text("  ")
    end

    def choose_image_tab
      image_tab.click
    end

    def attach_image_file
      attach_file('image', "#{QA_ENV['local_logo_upload']}")
    end

    def click_upload_files
      upload_image_btn.click
    end

  end
end