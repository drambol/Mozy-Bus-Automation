When /^I navigate to the machine mapping page$/ do
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['search_list_machines'])
  @bus_site.admin_console_page.search_list_machines_section.navigate_to_machine_mapping
end

When /^I download the machine csv file$/ do
  FileHelper.delete_csv('machine_mapping')
  @bus_site.admin_console_page.machine_mapping_section.export_machine_csv
end

Then /^There should be export message to inform that it is exporting$/ do
  msg = @bus_site.admin_console_page.machine_mapping_section.exporting_msg
  msg.should == 'The CSV file is generating, please be patient...'
end

Then /^The exported csv file should be:$/ do |table|
  r = FileHelper.read_csv_file('machine_mapping')
  r.should == table.rows
end

Then /^The exported csv file should be like:\(header as below, row number is (\d+), order by current owner, no duplicated rows\)$/ do |num, table|
  header, mapping_num, order, unique, all = @bus_site.admin_console_page.machine_mapping_section.parse_download_csv
  header.should == table.rows[0]
  mapping_num.should == num.to_i
  order.should be_true
  unique.should be_true
  unless table.rows[1][0] == '@machine_name'
    all = all[1..-1].sort! {|x, y| x[0] <=> y[0]}.insert(0, all[0])
    table.rows[1..-1].each_with_index do |r, index|
      all[index+1][0].should == r[0]
      r[2].replace ERB.new(r[2]).result(binding)
      all[index+1][2].should == r[2]
    end
  end
end

#import machine related
Given /^I change the csv file by adding new owners to the machines$/ do
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import')
end

When /^I upload the machine csv file$/ do
  @bus_site.admin_console_page.machine_mapping_section.fill_in_import_file 'import.csv'
  @bus_site.admin_console_page.machine_mapping_section.import_machine_csv
end

Then /^There should be import message to inform that it is importing$/ do
  @bus_site.admin_console_page.machine_mapping_section.importing_msg.should == 'The csv file is importing, please wait...'
end

Then /^The import result should be like:$/ do |table|
  msg = @bus_site.admin_console_page.machine_mapping_section.result_msg
  msg.each_index do |index|
    if index < 5
      msg[index].should == (table.rows.first)[index]
    else
      msg[index].should include (table.rows.first)[index]
    end
  end
end

When /^I create an empty file$/ do
  write_csv_file('import', [])
end

When /^I upload the non-csv file$/ do
  @bus_site.admin_console_page.machine_mapping_section.fill_in_import_file('non_csv.png', default_test_data_path)
  @bus_site.admin_console_page.machine_mapping_section.import_machine_csv
end

When /^I make the (.*) absent$/ do |column|
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import', 'absent', column)
end

When /^I make the (.*) an unknown value$/ do |column|
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import', 'unknown', column)
end

When /^I make the (.*) an invalid value$/ do |column|
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import', 'invalid', column)
end

When /^I make the new owner column with a space$/ do
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import', 'empty', 'New Owner')
end

When /^I make a column with mismatched machine name and machine hash$/ do
  @bus_site.admin_console_page.machine_mapping_section.create_csv_file('machine_mapping', 'import', 'mismatch')
end

When /^I change the csv file by moving the machines to new users$/ do
  @bus_site.admin_console_page.machine_mapping_section.create_csv_another_way('machine_mapping', 'import')
end

When /^I rename the machine csv file$/ do
  rename('machine_mapping.csv', 'before.csv')
end

When /^I add a new user and machine mapping$/ do
  @bus_site.admin_console_page.machine_mapping_section.add_user_machine_mapping
end

When /^The exported csv file should be (\d+) rows more than the former one$/ do |num|
  after = FileHelper.read_csv_file('machine_mapping')
  before = FileHelper.read_csv_file('before')
  (after.length - before.length).should == num.to_i
end

When /^I refresh the machine mapping page$/ do
  @bus_site.admin_console_page.machine_mapping_section.refresh
end

When /^The exported csv file should be (\d+) rows less than the former one$/ do |num|
  after = FileHelper.read_csv_file('machine_mapping')
  before = FileHelper.read_csv_file('before')
  (before.length - after.length).should == num.to_i
end

When /^I delete a new user and machine mapping$/ do
  @bus_site.admin_console_page.machine_mapping_section.delete_user_machine_mapping
end

When /^I click the export machine csv button$/ do
  @bus_site.admin_console_page.machine_mapping_section.click_export_btn
end

When /^I wait until the file is downloaded$/ do
  @bus_site.admin_console_page.machine_mapping_section.wait_until_downloaded
end

When /^I add (\d+) new user and machine mapping by bifrost$/ do |num|
  num.to_i.times do
    BifrostHelper.add_user_machine_mapping_by_bifrost(@api_key)
  end
end

When /^I navigate to the partner_details page of (.+)$/ do |partner_name|
  @bus_site.admin_console_page.search_list_partner_section.search_partner partner_name
  page.find_link(partner_name).click
  @bus_site.admin_console_page.search_list_partner_section.clear_search
end


When /^I get the api_key$/ do
  @bus_site.admin_console_page.partner_details_section.create_api_key
  @api_key = @bus_site.admin_console_page.partner_details_section.api_key
  Log.debug("api_key is #{@api_key}")
end
When /^I get the current user machine mapping number$/ do
  @mappings_num = @bus_site.admin_console_page.machine_mapping_sectionget_mapping_num_by_bifrost(@api_key)
end

Then /^The exported csv file should be like:\(header as below, row number is correct, order by current owner, no duplicated rows\)$/ do |table|
  header, mapping_num, order, unique = @bus_site.admin_console_page.machine_mapping_section.parse_download_csv
  header.should == table.rows[0]
  mapping_num.should == @mappings_num
  order.should be_true
  unique.should be_true
end

When /^I rename the machine csv file as (.+)$/ do |new_name|
  FileHelper.rename('machine_mapping.csv', new_name)
end

When /^I delete (\d+) new user and machine mapping by bifrost$/ do |num|
  num.to_i.times { BifrostHelper.remove_user_machine_mapping_by_bifrost(@api_key)}
end

When /^I add a subpartner if not exist:$/ do |table|
  company_name = table.hashes.first['name']
  @bus_site.admin_console_page.search_list_partner_section.search_partner company_name
  if @bus_site.admin_console_page.search_list_partner_section.search_results_table_rows.first[1] !=company_name
    BifrostHelper.add_subpartner_by_bifrost(@api_key, 'partner_id'=>@partner_id, 'name'=>table.hashes.first['name'], 'username'=>table.hashes.first['username'])
  else
    page.find_link(company_name).click
  end
end

When /^I get the subpartner api_key$/ do
  @bus_site.admin_console_page.partner_details_section.create_api_key
  @subpartner_api_key = @bus_site.admin_console_page.partner_details_section.api_key
end

When /^I create (\d+) Machine user mappings for the subpartner$/ do |num|
  num.to_i.times { BifrostHelper.add_user_machine_mapping_by_bifrost(@subpartner_api_key) }
end

When /^I close the partner detail page$/ do
  partner_id = @bus_site.admin_console_page.partner_details_section.partner_id()
  @bus_site.admin_console_page.partner_details_section.close_partner_detail_section_by_id(partner_id)
end

When /^I create (\d+) machine user mappings$/ do |num|
  user = BifrostHelper::User.new(@api_key)
  res = user.get('deleted=false')
  number = 0
  @default_group_id = BifrostHelper.get_default_group_id(@api_key, @partner_id)
  res['items'].each do |item|
    if item['data']['user_group_id'] == @default_group_id
      number += 1
    end
  end
  @mappings_num = number
  num = num.to_i
  Log.debug("The machine mapping number is #{number}")
  if number < num
    (num - number).to_i.times do
      BifrostHelper.add_user_machine_mapping_by_bifrost(@api_key)
    end
  elsif number > num
    (number - num).to_i.times do
      BifrostHelper.remove_user_machine_mapping_by_bifrost(@api_key)
    end
  end
  @mappings_num = num
end

When /^I get the default group id by bifrost$/ do
  Log.debug(@api_key)
  Log.debug(@partner_id)
  @default_group_id = BifrostHelper.get_default_group_id(@api_key, @partner_id)
  Log.debug("The default group id is #{@default_group_id}")
end
When /^I change the csv file by adding new owners to the machines for (\d+) machines$/ do |arg|
  @bus_site.admin_console_page.machine_mapping_section.change_10000_machines('machine_mapping', 'import')
end

When /^I refresh the machine mapping section$/ do
  @bus_site.admin_console_page.machine_mapping_section.refresh_bus_section
  @bus_site.admin_console_page.machine_mapping_section.wait_until_bus_section_load
end
