When /^I navigate to add report view for (.+)/ do |report_type|
  @bus_site.admin_console_page.report_builder_section.navigate_to_add_report_section(report_type)
end

# Build a new reports
#
# Available columns: type, name, frequency, start date, is active, recipients, subject, email message
#
When /^I build a new report:$/ do |report_table|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['report_builder'])
  attributes = report_table.hashes.first
  @bus_site.admin_console_page.report_builder_section.navigate_to_add_report_section(attributes["type"])
  case attributes["type"]
    when "Billing Summary"
      @report = Bus::DataObj::BillingSummaryReport.new
      @report.name = attributes["name"] || "billing summary test report"
      @report.frequency = attributes["frequency"] || "Daily"
      @report.start_date = attributes["start date"] unless attributes["start date"].nil?
      @report.is_active = (attributes["is active"] || "yes").eql?("yes")
    when "Billing Detail"
      @report = Bus::DataObj::BillingDetailReport.new
      @report.name = attributes["name"] || "billing detail test report"
      @report.frequency = attributes["frequency"] || "Daily"
      @report.start_date = attributes["start date"] unless attributes["start date"].nil?
      @report.is_active = (attributes["is active"] || "yes").eql?("yes")
    else
      @report = Bus::DataObj::ScheduledReport.new
      @report.type = attributes["type"]
      @report.name = attributes["name"] || "scheduled report"
      @report.frequency = attributes["frequency"] || "Daily"
      @report.start_date = attributes["start date"] unless attributes["start date"].nil?
      @report.is_active = (attributes["is active"] || "yes").eql?("yes")
      @report.threshold = attributes["threshold"]
  end
  if !attributes["recipients"].nil?
    @report.recipients = attributes["recipients"]
    @report.recipients.replace ERB.new(@report.recipients).result(binding)
  elsif !attributes["multiple recipients"].nil?
    # data should be like <%=create_user_email%>; <%=create_user_email%>
    @report.recipients = ""
    report_array = attributes["multiple recipients"].split("\;")
    report_array.each { |value|
      value = value.strip
      value.replace ERB.new(value).result(binding)
      @report.recipients = @report.recipients + value + ";"
    }
    @report.recipients = @report.recipients
  end
  @recipients_array = @report.recipients.split("\;") unless @report.recipients.nil?
  @report.subject = attributes["subject"] || ""
  @report.email_message = attributes["email message"] || ""
  @current_date = @bus_site.admin_console_page.add_report_section.build_report(@report)
  @current_date = Chronic.parse(@current_date).strftime('%m/%d/%Y')
end

When /^I add more recipients to report (.+)$/ do |report_name, recipients_table|
  attributes = recipients_table.hashes.first
  recipients_str = ""
  report_array = attributes["more recipients"].split("\;")
  report_array.each { |value|
    value = value.strip
    value.replace ERB.new(value).result(binding)
    recipients_str = recipients_str + value + ";"
  }
  recipients_str = recipients_str + @partner.admin_info.email
  @recipients_array = recipients_str.split("\;")
  Log.debug @recipients_array
  @report.recipients = recipients_str
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  @bus_site.admin_console_page.scheduled_reports_section.click_report(report_name)
  @bus_site.admin_console_page.edit_report_section.set_email_recipients(recipients_str, true)
end

And /^I run report (.+)$/ do |report_name|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  @bus_site.admin_console_page.scheduled_reports_section.run_report(report_name)
end

Then /^I should see available reports are:$/ do |link_desc_link|
  @bus_site.admin_console_page.report_builder_section.available_reports_table_rows.should == link_desc_link.rows
end

Then /^I should see report filters are:$/ do |link_desc_link|
  @bus_site.admin_console_page.scheduled_reports_section.report_filters.should == link_desc_link.rows.map{|row|row.first}
end

Then /^I should see quick reports are:$/ do |link_desc_table|
  link_desc_table.map_column!('description') do |value|
    value.gsub(/@today/,Time.now.localtime("-06:00").strftime("%Y-%m-%d"))
  end
  @bus_site.admin_console_page.quick_reports_section.link_desc_table_rows.should == link_desc_table.rows
end

Then /^Billing summary report should be created$/ do
  @bus_site.admin_console_page.add_report_section.messages.should == "Created Billing Summary Report."
end

Then /^Billing detail report should be created$/ do
  @bus_site.admin_console_page.add_report_section.messages.should == "Created Billing Detail Report."
end

Then /^Report created successful message should be (.+)$/ do |message|
  @bus_site.admin_console_page.add_report_section.messages.should == message
end

Then /^Report updated successful message should be (.+)$/ do |message|
  @bus_site.admin_console_page.edit_report_section.messages.should == message
end

When /^I delete (.+) scheduled report$/ do |report_name|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  @bus_site.admin_console_page.scheduled_reports_section.click_report(report_name)
  @bus_site.admin_console_page.edit_report_section.delete_report(report_name)
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
end

Then /^I should see (.+) in scheduled reports list$/ do |message|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  @bus_site.admin_console_page.scheduled_reports_section.reports_table_text.should include(message)
end

When /^I download (.+) scheduled report$/ do |report_name|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  @bus_site.admin_console_page.scheduled_reports_section.download_report(report_name)
end

When /^I download (.+) quick report$/ do |report_name|
  @bus_site.admin_console_page.navigate_to_menu(CONFIGS['bus']['menu']['quick_reports'])
  @bus_site.admin_console_page.quick_reports_section.download_report(report_name)
end

Then /^Scheduled (.+) report csv file( which attached to email)* details should be:$/ do |report_type, type, report_table|
  report_table.map_column!('Column A') do |value|
    value.replace ERB.new(value).result(binding)
    value.gsub!(/@name/,@partner.company_info.name) unless @partner.nil?
    value.gsub!(/@today/,DateTime.now.strftime("%m/%d/%Y")) if value == '@today'
    value
  end
  if OS.windows?
    report_table.rows.each do |row|
      row.map {|col| col.force_encoding('IBM437');}
    end
  end
  expected_report_row = report_table.rows.size
  expected_report_table_hashes =  []
  actual_report_table_hashes = []
  while expected_report_row > 1
    expected_report_table_hashes << Hash[report_table.rows[0].zip(report_table.rows[expected_report_row-1])]
    expected_report_row = expected_report_row - 1
  end
  if type.nil?
    actual_report_table = @bus_site.admin_console_page.scheduled_reports_section.read_scheduled_report(report_type)
  else
    wait_until{FileHelper.get_file_size(@mail_content) > 0}
    actual_report_table = FileHelper.read_csv_file(@mail_content)
  end
  begin
    @bus_site.admin_console_page.scheduled_reports_section.read_scheduled_report(report_type).should eql report_table.rows
    @bus_site.log "Rows are exactly identical."
  rescue
    @bus_site.log "Rows are not exactly identical. Ignore the column disorder issue and compare again."
    actual_report_row = actual_report_table.size
    while actual_report_row > 1
      actual_report_table_hashes << Hash[actual_report_table[0].zip(actual_report_table[actual_report_row-1])]
      actual_report_row = actual_report_row - 1
    end
    expected_report_table_hashes.map!{|h| Hash[h.sort_by{|key,value| key}]}
    actual_report_table_hashes.map!{|h| Hash[h.sort_by{|key,value| key}]}
    expected_report_table_hashes.each_index {|index| actual_report_table_hashes.include?(expected_report_table_hashes[index]).should be_true}
    @bus_site.log "Rows are exactly identical after ignoring the column disorder"
  end
 end

Then /^Quick report (.+) csv file details should be:$/ do |report_type, report_table|
  report_table.map_column!('Column A') do |value|
    value.gsub!(/@today/,DateTime.now.strftime("%m/%d/%y")) if value == '@today'
    value
  end

  report_table.map_column!('Column C') do |value|
    value.gsub!(/@XXXX/, @partner.credit_card.number[12..-1]) unless @partner.nil?
    value
  end
  actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report_type)
  actual.size.should == report_table.rows.size
  actual.each { |row| report_table.rows.should include row}
end

Then /^(Quick|Scheduled) report (.+) csv file details should include$/ do |type, report_type, report_table|
  if type == 'Scheduled'
    actual = @bus_site.admin_console_page.scheduled_reports_section.read_scheduled_report(report_type)
  else
    actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report_type)
  end

  Log.debug "actual: #{actual}"

  attributes = report_table.hashes
  attributes.each { |v|
    v.each{ |_,value|
      value.replace ERB.new(value).result(binding) unless value.match(/^<%=@.+%>$/).nil?
      if value == 'today'
          value.replace (Chronic.parse(value).strftime('%m/%d/%y'))
      elsif value == 'minute'
        value.replace actual[1][7]
      end
    }
  }

  Log.debug "report_table: #{report_table}"

  report_table.rows.each { |row|
    (actual.include?(row)).should == true
  }
end

Then /^(Quick|Scheduled) report (.+) csv file header should be:$/ do |type, report_type, report_table|
  if type == 'Quick'
    actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report_type)
  else
    actual = @bus_site.admin_console_page.scheduled_reports_section.read_scheduled_report(report_type)
  end
  report_table.rows[0].should == actual[0]
end

And /^Quick report (.+) csv file column (.+) value should (be|match) (.+)$/ do |report_type, column, type, value|
  expected_value = value
  expected_value = '' if value == 'empty'
  column_index = column.ord - 65
  actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report_type)
  actual.each_index { |index|
    if index > 0
      if type == 'be'
        actual[index][column_index].should == expected_value
      elsif type == 'match'
        if value == "Shared or Limited: xx"
          (actual[index][column_index] == "Shared" || (!actual[index][column_index].match(/^Limited: \d+$/).nil?)).should == true
        elsif value == "number"
          (actual[index][column_index].match(/^\d+\.*0*$/).nil?).should == false
        end
      end
    end
  }
end

# a report will return multiple lines of records, just need to check one record of specified columns
And /^I get record for column (.+) with value (.+) from Quick report (.+) csv file should be$/ do |_, value, report, table|
  expected = table.hashes[0]
  actual = @bus_site.admin_console_page.quick_reports_section.read_quick_report(report)
  record_index = 0
  # find the record index which we need to check among all records
  actual.each_with_index { | v,index |
    if v.include?(value)
      record_index = index
      break
    end
  }
  actual_record = {}
  # combine the report head and the actual record to a hash
  actual[0].each_with_index { |key, index| actual_record[key] = actual[record_index][index]}
  expected.keys.each{|key| actual_record[key].should == expected[key] }
end

When /^I search report by name (.+)$/ do |report_name|
  @report_row = @bus_site.admin_console_page.scheduled_reports_section.find_report(report_name)
end

Then /^Scheduled report list should be:$/ do |results_table|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  actual = @bus_site.admin_console_page.scheduled_reports_section.reports_table_hashes.first
  expected = results_table.hashes.first

  expected.each do |_, v|
    v.replace ERB.new(v).result(binding)
  end

  expected.keys.each{ |key| actual[key].should == expected[key]}
end

And /^I clear downloads folder (.+) file$/ do |file_name|
  FileHelper.clean_up_csv(file_name)
end

When /^I close add report section$/ do
  @bus_site.admin_console_page.add_report_section.close_bus_section
end

And /^(.+) scheduled report (Next Run|History) value should be (.+)$/ do |report_name, column, value|
  @bus_site.admin_console_page.scheduled_reports_section.wait_until_bus_section_load
  if column == 'Next Run'
    actual = @bus_site.admin_console_page.scheduled_reports_section.get_next_run(report_name)
  elsif  column == 'History'
    actual = @bus_site.admin_console_page.scheduled_reports_section.get_history(report_name)
  end
  if value == 'tomorrow'
    value = Chronic.parse(value).strftime('%a %b %d, %Y')
  end
  actual.should == value
end

When /^I inactive (.+) scheduled report$/ do |report_name|
  @bus_site.admin_console_page.scheduled_reports_section.click_report(report_name)
  @bus_site.admin_console_page.edit_report_section.inactive_report
end

And /^(.+) report is scheduled for this partner$/ do |num|
  delayed_job_count = DBHelper.get_count_delayed_job @partner_id
  if num == 'no'
    delayed_job_count.should == '0'
  else
    delayed_job_count.should == num
  end
end
