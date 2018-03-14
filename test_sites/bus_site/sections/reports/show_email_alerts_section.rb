module Bus

  class ShowEmailAlertsSection < SiteHelper::Section

    # add email alert tab
    element(:add_email_alert_a, xpath:"//a[text()='Add Email Alert']")

    #3 tabs on edit page
    element(:edit_report_modules_li, xpath: "//div[starts-with(@id,'alerts-show')]//li[text()='Report Modules']")
    element(:edit_scope_li, xpath:  "//div[starts-with(@id,'alerts-show')]//li[text()='Scope']")
    element(:edit_recipients_li, xpath:  "//div[starts-with(@id,'alerts-show')]//li[text()='Recipients']")

    #change link
    element(:subject_line_a, xpath:"//dd[1]//a[text()='(change)']")
    element(:frequency_a, xpath: "//dd[2]//a[text()='(change)']")

    # subject line on edit page
    element(:subject_line_span, xpath:  "//dd[1]//span[1]/span")
    element(:edit_subject_line_input, xpath: "//span[@class='edit']//input[@id='subject_line']")
    element(:subject_save_changes_input, xpath: "//input[@id='subject_line']//..//input[2]")

    # frequency on edit page
    element(:frequency_span, xpath: "//div[2]/dl/dd[2]//span[1]/span")
    element(:frequency_save_changes_input, xpath: "//select[@id='frequency']//..//input")
    element(:edit_frequency_select, xpath: "//span[@class='edit']//select[@id='frequency']")

    # scope on edit page
    element(:edit_unscoped_input, xpath:  "//input[@id='unscoped']")

    element(:nearing_quota_threshold_select, xpath: "//select[@name='nearing_quota_threshold']")

    # checked recipients
    elements(:recipients_checked, xpath: "//div[starts-with(@id,'alerts-show')]//input[starts-with(@id,'recipients')][@checked='checked']")

    #delete button
    element(:delete_alert_a, xpath: "//a[text()='Delete Alert']")

    #send now button
    element(:send_now_a, xpath: "//a[text()='Send Now']")

    #updated message
    element(:updated_message_li, xpath: "//div[starts-with(@id,'alerts-show')]/ul[@class='flash successes']/li")

    def email_alerts_hashes
      email_alerts = {
          "subject line" => subject_line_span.text,
          "frequency" => frequency_span.text,
          "report modules" => "",
          "recipients"  => ""
      }
      edit_report_modules_li.click
      array_modules = all(:xpath, "//input[@checked='checked']//..//..//td[2]/label").map{|label|label.text}
      email_alerts['report modules'] = array_modules
      edit_recipients_li.click
      array_recipients = all(:xpath, "//div[starts-with(@id,'alerts-show')]//input[starts-with(@id,'recipients')][@checked='checked']//..//..//td[2]").map{|td|td.text}
      email_alerts['recipients'] = array_recipients
      email_alerts
    end

    def send_now
      wait_until{send_now_a.visible?}
      send_now_a.click
    end

    def modify_email_alert(email_alerts)
      reports_hash = {
          "Backup summary" => "backup_summary",
          "Users without recent backups" =>"recent_backups",
          "Users/Machines nearing max" => "nearing_quota",
          "Storage pool summary" =>"storage",
          "Users with outdated clients" => "outdated_clients"
      }
      subject_line_a.click
      edit_subject_line_input.type_text(email_alerts.subject_line) unless email_alerts.subject_line.nil?
      subject_save_changes_input.click
      frequency_a.click
      edit_frequency_select.select(email_alerts.frequency) unless email_alerts.frequency.nil?
      frequency_save_changes_input.click
      edit_report_modules_li.click
      reports_hash.each_key do |r|
        find(:id, "#{reports_hash[r]}").uncheck
      end
      email_alerts.report_modules.each do |i|
        find(:id, "#{reports_hash[i]}").check
        if i == "Users/Machines nearing max"
          nearing_quota_threshold_select.select(email_alerts.percent_quota_used) unless email_alerts.percent_quota_used.nil?
        end
      end
      edit_scope_li.click
      if email_alerts.scope != ('All User Groups and Subpartners')
        edit_unscoped_input.uncheck
        find(:xpath, "//tbody[starts-with(@id,'scope-enabled')]//td[text()='#{email_alerts.scope}']//..//td[1]/input").check
      end
      edit_recipients_li.click
      recipients_checked.each do|re|
        re.uncheck
      end
      email_alerts.recipients.each do |v|
        find(:xpath, "//div[starts-with(@id,'alerts-show')]//td[text()='#{v}']/../td[1]/input").check
      end
      find(:xpath, "//p/input[@value='Save Changes']").click
    end

    def delete_email_alert
      delete_alert_a.click
    end

    def updated_messages
      updated_message_li.text
    end

  end
end
