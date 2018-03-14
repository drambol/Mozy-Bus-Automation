

Then /^Machine search results should be:$/ do |results_table|
  actual = @bus_site.admin_console_page.search_list_machines_section.search_results_hashes
  expected = results_table.hashes
  expected.each do |col|
    col.each do |k,v|
      case k
        when 'User'
          v.gsub!(/@new_user_email/, @new_users.first.email) unless @new_users.nil?
        when 'Created'
          v.replace(Chronic.parse(v).strftime('%m/%d/%y'))
        else
          # do nothing
      end
      v.replace ERB.new(v).result(binding)
    end
  end
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[index][key].should == expected[index][key]} }
end

# When search sync machine, only support machine name search, sometimes will search out multiple records
Then /^Machine search results for user (.+) should be:$/ do |user, results_table|
  actual = @bus_site.admin_console_page.search_list_machines_section.search_results_hashes
  expected = results_table.hashes
  # finde out the right record according to user email
  i = 0;
  actual.each_with_index { |value, index|
    if value['User'] == user
      i = index
      break
    end
  }
  expected.each_index{ |index| expected[index].keys.each{ |key| actual[i][key].should == expected[index][key]} }
end

When /^I export the machines csv$/ do
  @bus_site.admin_console_page.search_list_machines_section.export_csv
end

Then /^(.+) and (.+) are downloaded$/ do |user, machine|
  @bus_site.admin_console_page.search_list_machines_section.machine_user_csv_files(user, machine).should == [user, machine]
end

Then /^Search list machines section is opened$/ do
  @bus_site.admin_console_page.search_list_machines_section.search_list_machines_opened.should be_true
end