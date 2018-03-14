module Bus

  class NewEmailAlertsSection < SiteHelper::Section


    #Add New Email Alerts
    element(:add_email_alert_a, xpath: "//a[text()='Add Email Alert']")
    element(:subject_line_input, id: "subject_line")
    element(:frequency_select, id: "frequency")
    element(:next_input, xpath: "//li[@class='selected']//input[@value='Next']")
    element(:unscoped_input, id: "unscoped")
    element(:finished_input, xpath: "//input[@value='Finish']")
    element(:nearing_quota_threshold_select, xpath: "//select[@name='nearing_quota_threshold']")

    #save message
    element(:alerts_message_li, xpath: "//div[@id='alerts-new-errors']/ul/li")


    def expand_add_email_alert
      add_email_alert_a.click
    end

    def add_new_email_alert(email_alerts)
      reports_hash = {
          "Backup summary" => "backup_summary",
          "Users without recent backups" =>"recent_backups",
          "Users/Machines nearing max" => "nearing_quota",
          "Storage pool summary" =>"storage",
          "Users with outdated clients" => "outdated_clients"
      }
      wait_until_bus_section_load
      subject_line_input.type_text(email_alerts.subject_line)
      frequency_select.select(email_alerts.frequency)
      next_input.click
      email_alerts.report_modules.each do |i|
        find(:id, "#{reports_hash[i]}").check
        if i == "Users/Machines nearing max"
          nearing_quota_threshold_select.select(email_alerts.percent_quota_used) unless email_alerts.percent_quota_used.nil?
        end
      end
      next_input.click
      if email_alerts.scope != ('All User Groups and Subpartners')
        unscoped_input.uncheck
        find(:xpath, "//tbody[starts-with(@id,'scope-enabled')]//td[text()='#{email_alerts.scope}']//..//td[1]").check
      end
      next_input.click
      email_alerts.recipients.each do |v|
        find(:xpath, "//div[@id='alerts-new-tabs']//td[text()='#{v}']/../td[1]/input").check
      end
      finished_input.click
    end

    def alerts_messages
      alerts_message_li.text
    end

  end

end
