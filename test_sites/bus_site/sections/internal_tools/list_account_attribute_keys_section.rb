module Bus
  # This class provides actions for managing on List Account Attribute Keys
  class ListAccountAttributeKeysSection < SiteHelper::Section

    #==============================
    # Public: search account attribute key
    # params: key name
    # return: None
    #==============================
    def search_account_attribute_key(name)
      @key_name = name
      Log.debug "LogQA: search account attribute key - #@key_name"
      wait_until_bus_section_load
      find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']").click
      wait_until_bus_section_load
    end

    def find_account_attribute_key(name)
      return all(:xpath, "//div[@id='internal-list_attributes']//a[text()='#{name}']")
    end

    #==============================
    # Public: get one account attribute key detail info
    # params: acctount attribute key name
    # return: rows detail in hash type. e.g.,  {"key"=>"TEST_ROR_SHOULD_DELETE", "data type"=>"string", "component"=>"comp_test", "aria field"=>"", "action"=>"Delete"}
    #==============================
    def get_account_attribute_key_info(name)
      wait_until_bus_section_load
      row_hash = Hash.new()
      @key_name = name
      row_hash["key"] = @key_name
      row_hash["data type"] = find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']/../../td[2]").text()
      row_hash["component"] = find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']/../../td[3]").text()
      row_hash["aria field"] = find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']/../../td[4]").text()
      row_hash["action"] = find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']/../../td[5]").text()
      Log.debug "LogQA: get row detail info"
      Log.debug "=============================="
      Log.debug row_hash
      Log.debug "=============================="
      return row_hash
    end

    #==============================
    # Public: delete a account attribute key
    # params: key name
    # return: None
    #==============================
    def delete_account_attribute_key(name)
      wait_until_bus_section_load
      @key_name = name
      Log.debug "LogQA: delete account attribute key #@key_name and wait for 10 seconds"
      find(:xpath, "//div[@id='internal-list_attributes']//a[text()='#@key_name']/../../td[5]/a").click
      sleep(10)
    end

  end
end