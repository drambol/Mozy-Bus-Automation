module Bus
  # This class provides actions for managing on Add Account Attribute Key
  class AddAccountAttributeKeySection < SiteHelper::Section

    element(:account_attr_key, id: 'key')
    element(:account_data_type, id: 'data_type')
    element(:account_component, id: 'component')
    element(:account_aria_field, id: 'aria_field')
    element(:account_internal_true, xpath: '//input[@name="internal" and @value="true"]')
    element(:account_internal_false, xpath: '//input[@name="internal" and @value="false"]')
    element(:account_add_btn, xpath:'//input[@value="Add" and @type="submit"]')

    #=====================
    # Public: create a account attribute key
    # params: in hash format -
    #  |key|data type|component|aria field|internal|
    # return: None
    #=====================
    def add_account_attribute_key(hashes)

      Log.debug 'LogQA: set Key'
      unless hashes['key'].nil?
        Log.debug 'LogQA: [key] is - ' + hashes['key']
        account_attr_key.type_text(hashes['key'])
      end

      Log.debug 'LogQA: set Data Type'
      unless hashes['data type'].nil?
        Log.debug 'LogQA: [Data Type] is - ' + hashes['data type']
        account_data_type.select(hashes['data type'])
      end

      Log.debug 'LogQA: set Component'
      unless hashes['component'].nil?
        Log.debug 'LogQA: [Component] is - ' + hashes['component']
        account_component.type_text(hashes['component'])
      end

      Log.debug 'LogQA: set Aria Field'
      unless hashes['aria field'].nil?
        Log.debug 'LogQA: [Aria Field] is ' + hashes['aria field']
        account_aria_field.type_text(hashes['aria field'])
      end

      Log.debug 'LogQA: set Internal'
      unless hashes['internal'].nil?
        if (hashes['internal'] == 'Yes')
          Log.debug 'LogQA: [Internal] is ' + hashes['internal']
          account_internal_true.click
        else
          Log.debug 'LogQA: [Internal] is ' + hashes['internal']
          account_internal_false.click
        end
      end

      Log.debug 'LogQA: click Add button'
      account_add_btn.click
      wait_until_bus_section_load
    end

  end
end