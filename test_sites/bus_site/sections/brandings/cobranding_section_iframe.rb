module Bus
  # This class provides actions for co-branding iframe in co-branding section
  class CoBrandIframe < SiteHelper::Iframe

    # Co-branding Active
    element(:change_cobranding_active_link, css: '#site_branding-display-cobranding-active>a')
    element(:cobranding_status_select, css: '#cobranding_status')
    element(:submit_cobranding_status_btn, css: '#site_branding-change-cobranding-active>input')

    # images tab
    element(:image_platform_select, css: '#co-branding-image-platform')
    element(:upload_image_btn, css: '#image')
    element(:delete_image_btn, css: '#site_branding-cobrand-tabs input[value=Delete]')
    element(:save_changes_btn, css: "#site_branding-cobrand-tabs input[value='Save Changes']")

    def activate_cobranding
      change_cobranding_active_link.click
      cobranding_status_select.select('Yes')
      submit_cobranding_status_btn.click
      wait_until{ !submit_cobranding_status_btn.visible? }
    end

    def deactivate_cobranding
      change_cobranding_active_link.click
      cobranding_status_select.select('No')
      submit_cobranding_status_btn.click
      wait_until{ !submit_cobranding_status_btn.visible? }
    end

    def select_image_platform(platform)
      image_platform_select.select(platform)
    end

    def click_save_changes
      save_changes_btn.click
      sleep 5
    end

    def attach_image_file(file = 'title.png')
      file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent.parent) + "/test_data/#{file}"
      file_path.gsub!('/', '\\') if OS.windows?
      attach_file('image', file_path)
    end

  end
end