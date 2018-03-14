module Bus
  # This class provides actions for list roles section
  class ListRolesSection < SiteHelper::Section

    element(:export_roles_csv_btn, xpath: "//div[@id='roles-list-content']//a[contains(text(),'Export')]")

    def list_role(role_name)
      multi_page_link = "//div[@class='table-metadata']//p[3]//a"
      role_name_link = "//a[text()='#{role_name}']"
      index = 1
      while (all(:xpath, role_name_link).size == 0)
        find(:xpath, multi_page_link+"[#{index}]").click
        wait_until_bus_section_load
        index += 1
      end
      find(:xpath, role_name_link).click
    end

    def all_role_name_started_with(name)
      all(:xpath, "//a[starts-with(., \"#{name}\")]")
    end

    def find_role(role)
      !(locate(:xpath, "//div/div[1]/table//td[1]/a[text()='#{role}']").nil?)
    end

    def click_export_button
      wait_until{export_roles_csv_btn.visible?}
      export_roles_csv_btn.click
    end

    def export_roles_csv(file_name = "#{default_download_path}/roles.csv")
      i = 0
      CONFIGS['global']['default_wait_time'].times do
        if File.size?(file_name)
          size = File.size(file_name)
          sleep(1)
          if File.size(file_name) == size
            break
          end
        else
          sleep(1)
        end
      end
    end

    def read_roles_csv
      FileHelper.read_csv_file("roles")
    end

  end
end
