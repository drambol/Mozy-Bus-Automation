module Bus
  # This class provides actions for managing on Account Attribute Key Details secion
  class AccountAttributeKeyDetailsSection < SiteHelper::Section

    element(:account_data_type, xpath: "//form[@id='internal-edit_attribute_form']/table/tbody/tr/th[contains(., 'Data Type')]/../td")
    element(:account_component, xpath: '//div[@id="internal-edit_attribute"]//input[@id="component"]')
    element(:account_aria_field, xpath: '//div[@id="internal-edit_attribute"]//input[@id="aria_field"]')
    element(:account_internal_true, xpath: '//div[@id="internal-edit_attribute"]////input[@name="internal" and @value="true"]')
    element(:account_internal_false, xpath: '//div[@id="internal-edit_attribute"]////input[@name="internal" and @value="false"]')
    element(:account_save_btn, xpath:'//div[@id="internal-edit_attribute"]//input[@value="Save" and @type="submit"]')

    #=====================
    # Public: update a account attribute key
    # params: in hash format -
    #  |key|data type|component|aria field|internal|
    # return: None
    #=====================
    def edit_account_attribute_key(hashes)

      Log.debug 'LogQA: update Component'
      unless hashes['component'].nil?
        Log.debug 'LogQA: [Component] is - ' + hashes['component']
        account_component.type_text(hashes['component'])
      end

      Log.debug 'LogQA: update Aria Field'
      unless hashes['aria field'].nil?
        Log.debug 'LogQA: [Aria Field] is ' + hashes['aria field']
        account_aria_field.type_text(hashes['aria field'])
      end

      Log.debug 'LogQA: update Internal'
      unless hashes['internal'].nil?
        if (hashes['internal'] == 'Yes')
          Log.debug 'LogQA: [Internal] is ' + hashes['internal']
          account_internal_true.click
        else
          Log.debug 'LogQA: [Internal] is ' + hashes['internal']
          account_internal_false.click
        end
      end

      Log.debug 'LogQA: click Save button'
      account_save_btn.click
    end

    def get_account_attribute_key_info_from_edit_section(name)
      wait_until_bus_section_load
      row_hash = Hash.new()
      @key_name = name
      row_hash["key"] = @key_name
      row_hash["data type"] = account_data_type.text()
      row_hash["component"] = account_component.value
      row_hash["aria field"] = account_aria_field.value
      Log.debug "LogQA: get row detail info"
      Log.debug "=============================="
      Log.debug row_hash
      Log.debug "=============================="
      return row_hash
    end

  end
end