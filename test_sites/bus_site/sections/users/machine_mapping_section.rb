# first for qa5 environment change the mozybfst.yml
# # QA5 machine migration add delete test
# secret: 5NDOVgE2OpdpZc5IPBEA8ZuQ6t2Ch7094MGoHg8nElxK6geBlpCFSSRxAt028Qa5
# QA5 machine migration add delete test
# group_id: 129736
module Bus
  class MachineMappingSection < SiteHelper::Section
    element(:export_machine_csv_btn, id: "export_btn")
    element(:import_machine_csv_btn, id: "import_btn")
    element(:export_msg, id: "export_msg")
    element(:import_msg, {id: "import_msg"}, true)
    element(:browser_btn, id: "file")
    element(:msg_show, id: "msg_show")

    # Public: Click the export csv file button
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.click_export_btn
    #
    # Returns nothing
    def click_export_btn
      export_machine_csv_btn.click
    end

    # Public: Wait for the file to be downloaded
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.wait_until_downloaded
    #
    # Returns nothing
    def wait_until_downloaded
      CONFIGS['global']['default_wait_time'].times do
        return if file_exists?("machine_mapping.csv")
        sleep(1)
      end
    end

    # Public: Export the user machine mappings csv file
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.export_machine_csv
    #
    # Returns nothing
    def export_machine_csv(file_name = "#{default_download_path}/machine_mapping.csv")
      export_machine_csv_btn.click
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

    # Public: Click the import csv file button
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.import_machine_csv
    #
    # Returns nothing
    def import_machine_csv
      import_machine_csv_btn.click
    end

    # Public: The hint message wile exporting
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.exporting_msg
    #  # => 'The CSV file is generating, please be patient...'
    #
    # Returns text
    def exporting_msg
      export_msg.text
    end

    # Public: The hint message wile importing
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.importing_msg
    #  # => 'The csv file is importing, please wait...'
    #
    # Returns text
    def importing_msg
      Log.debug "##########get the import msg"
      import_msg.text
    end

    # Public: The result message showed after machine migration is finished
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.result_msg
    #
    # Returns 0 if succeed
    def result_msg
      Log.debug "#####wait for the mgs_show is visible"
      page.wait_until { page.find(:id, 'msg_show').visible? }
      Log.debug "#####wait for the import_msg is not visible"
      wait_until(CONFIGS['global']['max_wait_time']) do
        !find(:id, 'import_msg').visible?
      end
      switch_to_iframe(['msg_show'])
      Log.debug('switch to the iframe')
      msg = []
      msg << page.find(:xpath, "/html/body/dl/dt").text
      (1..3).each do |index|
        msg << page.find(:xpath, "/html/body/dl/dd[#{index}]").text
      end
      error_num = "/html/body/dl/dd[4]"
      error_value = "/html/body/dl/dd[5]/ul/li"
      # quite slow here
      if page.has_xpath?(error_num)
        msg << page.find(:xpath, error_num).text
      end
      if page.has_xpath?(error_value)
        msg << page.find(:xpath, error_value).text
      end
      msg
    end

    # Public: Refresh the page for anther export or import
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.refresh
    #
    # Returns 0 if succeed
    def refresh
      find(:xpath, "//a[@class='mod-button'][3]").click
    end

    # Public: Attach the file to be uploaded
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.fill_in_import_file('import.csv', default_download_path)
    #
    # Returns 0 if succeed
    def fill_in_import_file(file_name, file_path = default_download_path)
      file = File.join(file_path, file_name).gsub(File::SEPARATOR, File::ALT_SEPARATOR || File::SEPARATOR)
      page.attach_file('file', file) 
      Log.debug "###Attach file #{file}"
    end

    # Public: Create the new csv file to upload
    #
    # old_csv - The input csv file
    # new_csv - The csv file to be created
    # method  - add: add new owner
    #           absent : make one column to absent
    #           unknow : make one column with unknown values
    #           invalid: make one column with invalid values
    #           empty  : make one colum with ' ' values
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('old', 'new', absent, 'Current Owner')
    #
    # Returns nothing
    def create_csv_file(old_csv, new_csv, method = 'add', column = nil)
      r = FileHelper.read_csv_file(old_csv)
      index = -1
      if column
        index = r[0].index(column)
      end
      new_owner = []
      r.each do |row|
        new_owner << row[2]
      end
      first = new_owner.delete_at(1)
      new_owner << first
      new_owner[0] = 'New Owner'
      case method
        when 'add'
          r.each {|row| row[3] = new_owner.shift}
        when 'absent'
          r.each do |row|
            row[3] = new_owner.shift
            row.delete_at(index)
          end
          FileHelper.write_csv_file(new_csv, r)
          return
        when 'unknown'
          r.each do |row|
            row[3] = new_owner.shift
            if index < 2
              row[index] = "test"
            else
              row[index] = "test@test.com"
            end
          end
        when 'invalid'
          r.each do |row|
            row[3] = new_owner.shift
            row[index] = "test"
          end
        when 'empty'
          r.each { |row| row[3] = ' ' }
        when 'mismatch'
          machine_name = []
          r.each do |row|
            machine_name << row[0]
          end
          first_ = machine_name.delete_at(1)
          machine_name << first_
          # new csv data
          r.each do |row|
            row[3] = new_owner.shift
            row[0] = machine_name.shift
          end

      end
      r[0] = ['Machine Name', 'Machine Hash', 'Current Owner', 'New Owner']
      FileHelper.write_csv_file(new_csv, r)
    end

    # Public: Create new csv file for the scenario that one machine has many users, the partner has 4 machine-user now
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.create_csv_another_way('old', 'new')
    #
    # Returns nothing
    def create_csv_another_way(old_csv, new_csv)
      r = FileHelper.read_csv_file(old_csv)
      new_owner = []
      r.each do |row|
        new_owner << (row[2]).sub(/\d/) {|s| (s.to_i + 2) % 4}
      end
      first = new_owner.delete_at(1)
      new_owner << first
      new_owner[0] = "New Owner"
      r.each { |row| row[3] = new_owner.shift }
      r[0] = ['Machine Name', 'Machine Hash', 'Current Owner', 'New Owner']
      write_csv_file(new_csv, r)
    end

    # Public: Delete the user_machine by mozy bifrost command line tool
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.delete_user_machine_mapping
    #
    # Returns nothing
    def delete_user_machine_mapping
      output = IO.popen("mozybfstcli user show").readlines
      data = JSON.parse(output[1])
      data = data['items']
      data.each do |item|
        if (item['data']['deleted']).to_s == 'false'
          user = item['data']['username']
          system("mozybfstcli user remove -u #{user}")
          break
        end
      end
    end

    # Public: Add the user_machine by mozy bifrost command line tool
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.add_user_machine_mapping
    #
    # Returns nothing
    def add_user_machine_mapping
      index = Time.now.to_i
      system("mozybfstcli user add -v -u test#{index}@test.com -f test#{index}")
      system("mozybfstcli machine add -v -e test#{index}@test.com -a machine#{index}")
    end

    # Public: Parse the downloaded csv file
    #
    # Example
    #  @bus_site.admin_console_page.machine_mapping_section.parse_download_csv('machine_mapping')
    #
    # Returns nothing
    def parse_download_csv(file_name = 'machine_mapping')
      CONFIGS['global']['default_wait_time'].times do
        sleep(2)
        break if file_exists?("#{file_name}.csv")
      end
      r = FileHelper.read_csv_file(file_name)
      header = r[0]
      mapping_num = r.size - 1
      current_owner = []
      machine_user = []
      r.each do |row|
        current_owner << row[2]
        machine_user << row[1..2]
      end
      current_owner.delete_at(0)
      order = current_owner.sort == current_owner
      machine_user.delete_at(0)
      unique = machine_user.uniq == machine_user
      [header, mapping_num, order, unique, r]
    end

    def change_10000_machines(old_csv, new_csv)
      r = FileHelper.read_csv_file(old_csv)
      new_owner = r.collect { |row| (row[2]).sub(/\d/) {|s| (s.to_i + 1) % 2} }
      first = new_owner.delete_at(1)
      new_owner << first
      new_owner[0] = "New Owner"
      r.each { |row| row[3] = new_owner.shift }
      r[0] = ['Machine Name', 'Machine Hash', 'Current Owner', 'New Owner']
      write_csv_file(new_csv, r)
    end

  end
end
