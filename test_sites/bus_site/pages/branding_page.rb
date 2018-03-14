module Bus
  # This class provides actions for client branding page
  class BrandingPage < SiteHelper::Page


    # Private elements
    #
    element(:version_select, id: "version_list")
    element(:submit_btn, id: "language_submit")
    element(:language_select, id: "language_id")
    element(:save_basic_btn, xpath: "//input[@value='Save Progress']")
    element(:finish_basic_btn, xpath: "//input[@value='Finish > >']")
    element(:branding_apply_message, xpath: "//div[starts-with(@id,'branding-apply-')]//p[1]")
    element(:start_building_btn, xpath: "//input[@name='create']")
    element(:branding_done_div, css: 'div[id^=branding-done-]')
    element(:branding_executable_link, xpath: "//div[starts-with(@id,'branding-done-')]//a[contains(text(), '.exe')]")

    def select_version(version)
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
        version_select.select(version)
        submit_btn.click
      else
        raise 'You must use selenium'
      end
    end

    def select_language(language)
      language_select.select(language)
      submit_btn.click
    end

    def finish_settings
      finish_basic_btn.click
    end

    def setting_saved_message
      branding_apply_message.text
    end

    def start_build
      start_building_btn.click
    end

    def build_done_message
      branding_done_div.text
    end

    # Public: select file to replace original branding item
    #
    def change_branding_item(file, item)
      find(:xpath, "//th[text()='#{item}']//parent::tr//following-sibling::tr//a[text()='change']").click
      browse_btn = find(:xpath, "//th[text()='#{item}']//parent::tr//following-sibling::tr//input")
      upload_file(file, browse_btn.id)
    end

    # Public: set upload file path for a given element
    #
    def upload_file(executable, upload_button_id)
      file_path = File.dirname(Pathname.new(File.dirname(__FILE__)).parent.parent) + "/test_data/#{executable}"
      file_path.gsub!('/', '\\') if OS.windows?
      attach_file(upload_button_id, file_path)
    end

    def close_page
      if page.driver.is_a?(Capybara::Selenium::Driver)
        page.execute_script "window.close();"
        page.driver.browser.switch_to().window(page.driver.browser.window_handles.last)
      else
        raise 'You must use selenium'
      end
    end



  end
end