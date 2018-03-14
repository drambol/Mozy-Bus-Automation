module Bus

  class ListEmailAlertsSection < SiteHelper::Section

    def view_alert_details(subject)
      find(:xpath, "//a[text()='#{subject}']").click
      # if all(:xpath, "//a[text()='Send Now']").size==0
      #   find(:xpath, "//a[text()='#{subject}']").click
      # end
    end

    def find_email_alert(email_alert)
      all(:xpath, "//a[text()='#{email_alert}']").size
    end

  end
end
