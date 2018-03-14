module Bus
  # This class provides actions for manage vat rates, Fx rates section
  class ManageVATTXRatesSection < SiteHelper::Section
    # Private elements
    # for VAT Rates
    element(:vat_country_select, id: 'country_code')
    element(:vat_rate_input, id: 'vat_rate')
    element(:vat_effective_date_input, xpath: "//form[contains(@id,'vat')]//input[@id='effective_date']")
    element(:add_vat_btn, xpath: "//form[contains(@id,'vat')]//input[@value='Add']")
    element(:vat_rate_tbl, xpath: "//div[@id='internal-list_vat_rates-content']//table")


    # for FX Rates
    element(:fx_from_currency_select, xpath: "//select[@id='from_currency_id']")
    element(:fx_to_currency_select, xpath: "//select[@id='to_currency_id']")
    element(:fx_rate_input, xpath: "//input[@id='foreign_exchange_rate']")
    element(:fx_effective_date_input, xpath: "//form[contains(@id,'exchange')]//input[@id='effective_date']")
    element(:add_fx_btn, xpath: "//form[contains(@id,'exchange')]//input[@value='Add']")
    element(:vat_fx_tbl, xpath: "//div[@id='internal-list_foreign_exchange_rates-content']//table")

    element(:add_vat_rate_menu, xpath: "//a[text()='Add VAT Rate']")
    element(:list_vat_rates_menu, xpath: "//a[text()='List VAT Rates']")
    element(:add_foreign_exchange_rate_menu, xpath: "/a[text()='Add Foreign Exchange Rate'")
    element(:list_foreign_exchange_rate_menu, xpath: "//a[text()='List Foreign Exchange Rates']")

    element(:error_save_vat_div, xpath: "//div[@id='internal-add_vat_rate-errors']/ul")
    element(:error_save_fx_div, xpath: "//div[@id='internal-add_foreign_exchange_rate-errors']/ul")



    #def open section: Add VAT Rate,List VAT Rates, Add Foreign Exchange Rate , List Foreign Exchange Rate
    def open_sub_menu(menu_name)
      div_xpath = "//a[text()='#{menu_name}']/../.."
      menu_xpath = "//a[text()='#{menu_name}']"
      find(:xpath, menu_xpath).click if find(:xpath, div_xpath)[:class].include? "inactive"
      wait_until_bus_section_load
    end

    # Public: Add new vat rates
    #
    # @vat     [Object] vat
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.add_vat_rates(vat_object)
    #
    # @return [] nothing
    def add_vat_rates(vat)
      wait_until_bus_section_load
      vat_country_select.select(vat.vat_country) unless vat.vat_country.nil?
      vat_rate_input.type_text(vat.vat_rate) unless vat.vat_rate.nil?
      vat_effective_date_input.type_text(vat.vat_effective_date) unless vat.vat_effective_date.nil?
      #click add button
      add_vat_btn.click
      wait_until_bus_section_load
    end

    # Public: Add new fx rates
    #
    # @fx     [Object] fx
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.add_fx_rates(fx_object)
    #
    # @return [] nothing
    def add_fx_rates(fx)
      open_sub_menu('Add Foreign Exchange Rate')
      fx_from_currency_select.select(fx.fx_from_currency) unless fx.fx_from_currency.nil?
      fx_to_currency_select.select(fx.fx_to_currency) unless fx.fx_to_currency.nil?
      fx_rate_input.type_text(fx.fx_rate) unless fx.fx_rate.nil?
      fx_effective_date_input.type_text(fx.fx_effective_date) unless fx.fx_effective_date.nil?
      #click add button
      add_fx_btn.click
      wait_until_bus_section_load
    end

    # Public: Delete or cancel delete vat rate
    #
    # vat rates' table row index and,true(or false)
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.delete_vat_rates(1,true)
    #
    # @return [] nothing
    def delete_vat_rates(row_index,is_delete)
      open_sub_menu('List VAT Rates')
      tr_xpath = "//div[@id='internal-list_vat_rates-content']//tr[#{row_index}]/td[4]/a"
      find(:xpath, tr_xpath).click
      is_delete ? alert_accept: alert_dismiss
      wait_until_bus_section_load
    end

    # Public: Delete or cancel delete fx rate
    #
    # fx rates' table row index and,true(or false)
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.delete_fx_rates(1,true)
    #
    # @return [] nothing
    def delete_fx_rates(row_index,is_delete)
      open_sub_menu('List Foreign Exchange Rates')
      tr_xpath = "//div[@id='internal-list_foreign_exchange_rates-content']//tr[#{row_index}]/td[5]/a"
      find(:xpath, tr_xpath).click
      is_delete ? alert_accept: alert_dismiss
      wait_until_bus_section_load
    end

    # Public: Search vat rates
    #
    # @vat
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(vat_object)
    #
    # @return row_index
    def search_vat_rates(vat)
      open_sub_menu('List VAT Rates')
      vat.vat_rate = (vat.vat_rate.to_f*100).to_s + '%' unless vat.vat_rate.include? '%'
      search_vat_value = [vat.vat_country, vat.vat_rate, vat.vat_effective_date, "Delete"]
      multi_pages_xpath = "//div[@id='internal-list_vat_rates-content']//div[2]/p/a"
      page_size = all(:xpath, multi_pages_xpath).size
      i = 0
      begin
        all_vat_value = vat_rate_tbl.raw_text
        row_index = all_vat_value.index(search_vat_value)
        if row_index != nil
          break
        end
        if page_size >= i+1
          find(:xpath, multi_pages_xpath + "[#{i+1}]").click
          wait_until_bus_section_load
        end
        i = i + 1
      end while i <= page_size
      row_index == nil ? 0:row_index
    end

    # Public: Search fx rates
    #
    # @fx
    #
    # Example
    #   @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(fx_object)
    #
    # @return row_index
    def search_fx_rates(vat)
      open_sub_menu('List Foreign Exchange Rates')
      search_fx_value = [vat.fx_from_currency, vat.fx_to_currency, vat.fx_rate, vat.fx_effective_date,"Delete"]
      multi_pages_xpath = "//div[@id='internal-list_foreign_exchange_rates-content']//div[2]/p/a"
      page_size = all(:xpath, multi_pages_xpath).size
      i = 0
      begin
        all_vat_value = vat_fx_tbl.raw_text
        row_index = all_vat_value.index(search_fx_value)
        if row_index != nil
          break
        end
        if page_size >= i+1
          find(:xpath, multi_pages_xpath + "[#{i+1}]").click
          wait_until_bus_section_load
        end
        i = i + 1
      end while i <= page_size
      row_index == nil ? 0:row_index
    end

    # Public: Messages for add new vat rate sections
    #
    # Examples:
    #  @bus_site.admin_console_page.manage_vatfx_rates_section.save_vat_error_message
    #
    # @return [String]
    def save_vat_error_message
      error_save_vat_div.text
    end

    # Public: Messages for add new fx rate sections
    #
    # Examples:
    #  @bus_site.admin_console_page.manage_vatfx_rates_section.save_fx_error_message
    #
    # @return [String]
    def save_fx_error_message
      error_save_fx_div.text
    end
  end
end
