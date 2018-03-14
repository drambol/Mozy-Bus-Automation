When /^I add a VAT Rate:$/ do |vat_table|
  attributes = vat_table.hashes.first
  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['manage_vatfx_rates'])

  @vat_rate = Bus::DataObj::VATFXRate.new
  @vat_rate.vat_country = attributes['Country'] unless attributes['Country'].nil?
  @vat_rate.vat_rate = attributes['Rate'] unless attributes['Rate'].nil?
  date = attributes['Effective Date'] unless attributes['Effective Date'].nil?
  unless date.nil?
    date.replace(Chronic.parse(date).strftime("%Y/%m/%d")) unless date.include? '/'
  end
  @vat_rate.vat_effective_date = date
  @bus_site.admin_console_page.manage_vatfx_rates_section.add_vat_rates(@vat_rate)
end

Then /^New VAT Rate should be created$/ do
  vat_message = @bus_site.admin_console_page.manage_vatfx_rates_section.save_vat_error_message
  vat_message.should == "New vat rate created"
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(@vat_rate)
  row_index.should_not == 0
end

Then /^VAT Rate (.+) shouldn't be created$/ do  |vat_condition|
  vat_message = @bus_site.admin_console_page.manage_vatfx_rates_section.save_vat_error_message
  expected_message = nil
  case  vat_condition
    when 'without Vat Rate'
      expected_message = "Rate can't be blank"
    when 'with invalid Vat Rate'
      expected_message = 'Rate should be greater than 0'
    when 'with invalid format of Effective Date'
      expected_message = "Please specify a valid effective date"
    when 'without Country'
      expected_message = "Country can't be blank"
    when 'with a Vat Rate greater than 1'
      expected_message = "Rate can't be greater than 1"
    else
      expected_message = "Unable to add vat rate. There's already a vat rate for country '#{@vat_rate.vat_country}', effective at '#{@vat_rate.vat_effective_date}'."
  end
  vat_message.should == expected_message
end

Then /^I delete newly created VAT Rate successfully$/ do
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(@vat_rate)
  @bus_site.admin_console_page.manage_vatfx_rates_section.delete_vat_rates(row_index,true)
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(@vat_rate)
  row_index.should == 0
end

Then /^I delete newly created VAT Rate and cancel this operation$/ do
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(@vat_rate)
  @bus_site.admin_console_page.manage_vatfx_rates_section.delete_vat_rates(row_index,false)
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(@vat_rate)
  row_index.should_not == 0
end

Then /^Successfully delete VAT Rate\(s\):$/ do |vat_table|
  vat_rates = vat_table.hashes
  vat_rates.each_index do |index|
    attributes = vat_rates[index]
    vat_rate = Bus::DataObj::VATFXRate.new
    vat_rate.vat_country = attributes['Country'] unless attributes['Country'].nil?
    vat_rate.vat_rate = attributes['Rate'] unless attributes['Rate'].nil?
    date = attributes['Effective Date'] unless attributes['Effective Date'].nil?
    unless date.nil?
      date.replace(Chronic.parse(date).strftime("%Y/%m/%d")) unless date.include? '/'
    end
    vat_rate.vat_effective_date = date

    row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(vat_rate)
    if row_index != 0
      @bus_site.admin_console_page.manage_vatfx_rates_section.delete_vat_rates(row_index,true)
      row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_vat_rates(vat_rate)
    end
    row_index.should == 0
  end
end

When /^I add a FX Rate:$/ do |fx_table|
  attributes = fx_table.hashes.first

  attributes.each do |header,attribute| #can use variable inside <%= %>
    attribute.replace ERB.new(attribute).result(binding)
    attributes[header] = nil if attribute == ''
  end

  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['manage_vatfx_rates'])

  @fx_rate = Bus::DataObj::VATFXRate.new
  @fx_rate.fx_from_currency = attributes['From Currency'] unless attributes['From Currency'].nil?
  @fx_rate.fx_to_currency = attributes['To Currency'] unless attributes['To Currency'].nil?
  @fx_rate.fx_rate = attributes['Rate'] unless attributes['Rate'].nil?
  date = attributes['Effective Date'] unless attributes['Effective Date'].nil?
  unless date.nil?
    date.replace(Chronic.parse(date).strftime("%Y/%m/%d")) unless date.include? '/'
  end
  @fx_rate.fx_effective_date = date
  @bus_site.admin_console_page.manage_vatfx_rates_section.add_fx_rates(@fx_rate)
end

Then /^New FX Rate should be created$/ do
  fx_message = @bus_site.admin_console_page.manage_vatfx_rates_section.save_fx_error_message
  fx_message.should == "New foreign exchange rate created"
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(@fx_rate)
  row_index.should_not == 0
end

Then /^FX Rate (.+) shouldn't be created$/ do  |fx_condition|
  vat_message = @bus_site.admin_console_page.manage_vatfx_rates_section.save_fx_error_message
  expected_message = nil
  case  fx_condition
    when 'without From Currency'
      expected_message = "From Currency can't be blank"
    when 'without To Currency'
      expected_message = "To Currency can't be blank"
    when 'without FX Rate'
      expected_message = "Rate can't be blank"
    when 'with invalid format of Effective Date'
      expected_message = "Please specify a valid effective date"
    when 'with invalid FX Rate'
      expected_message = "Rate should be greater than 0"
    when 'with the same From Currency and To Currency'
      expected_message = "From Currency and To Currency can't be same"
    else
      expected_message = "Unable to add foreign exchange rate. There's already a foreign exchange rate from '#{@fx_rate.fx_from_currency}' to '#{@fx_rate.fx_to_currency}', effective at '#{@fx_rate.fx_effective_date}'."
  end
  vat_message.should == expected_message
end

Then /^I delete newly created FX Rate successfully$/ do
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(@fx_rate)
  @bus_site.admin_console_page.manage_vatfx_rates_section.delete_fx_rates(row_index, true)
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(@fx_rate)
  row_index.should == 0
end

Then /^I delete newly created FX Rate and cancel this operation$/ do
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(@fx_rate)
  @bus_site.admin_console_page.manage_vatfx_rates_section.delete_fx_rates(row_index, false)
  row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(@fx_rate)
  row_index.should_not == 0
end

Then /^Successfully delete FX Rate\(s\):$/ do |fx_table|
  fx_rates = fx_table.hashes
  fx_rates.each_index do |index|
    attributes = fx_rates[index]
    fx_rate = Bus::DataObj::VATFXRate.new
    fx_rate.fx_from_currency = attributes['From Currency'] unless attributes['From Currency'].nil?
    fx_rate.fx_to_currency = attributes['To Currency'] unless attributes['To Currency'].nil?
    fx_rate.fx_rate = attributes['Rate'] unless attributes['Rate'].nil?
    date = attributes['Effective Date'] unless attributes['Effective Date'].nil?
    unless date.nil?
      date.replace(Chronic.parse(date).strftime("%Y/%m/%d")) unless date.include? '/'
    end
    fx_rate.fx_effective_date = date

    row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(fx_rate)
    if row_index != 0
      @bus_site.admin_console_page.manage_vatfx_rates_section.delete_fx_rates(row_index,true)
      row_index = @bus_site.admin_console_page.manage_vatfx_rates_section.search_fx_rates(fx_rate)
    end
    row_index.should == 0
  end
end

Then /^Manage VAT\/FX Rates should be (.+)$/ do |display|
  case display
    when 'visible'
      @bus_site.admin_console_page.has_navigation?("Manage VAT/FX Rates").should be_true
    else
      @bus_site.admin_console_page.has_navigation?("Manage VAT/FX Rates").should be_false
  end
end

