module Freyja

  class PreferencePage < SiteHelper::Page
    #start page
    element(:devices_radio, css: "#pref_start_backup")
    element(:synced_radio, css: "#pref_start_stash")

    #enable restore queue
    element(:enable_rq, css: "#pref_restore_queue_enable")
    element(:disable_rq, css: "#pref_restore_queue_disable")

    #save button
    element(:save_preference_btn, css: "#preferences_dialog > div.buttons.clearfix > div.inside > a.button.button-default > span.text")

    #check links
    element(:devices_verify, css: "a.selected_device_name")
    element(:rq_verify, css: "#act-addCollection > div.action-name")

    # Public: choose Devices or Synced radio
    #
    # Example
    #   @freyja_site.preference_page.chooseRadio
    #
    # Returns nothing
    def chooseRadio(device_type)
      case device_type
        when 'Devices'
          devices_radio.click
        when 'Synced'
          synced_radio.click
      end
    end

    def choose_RQ(rq_choice)
      case rq_choice
        when 'Yes'
          enable_rq.click
        when 'No'
          disable_rq.click
      end
    end

    def click_save_preference
      save_preference_btn.click
      sleep 1
    end

    def get_start_device
      sleep 10
      if page.find(:css, 'a.selected_device_name').visible?
        return "Devices"
      else
        return "Synced"
      end
    end

    def get_rq_status
      if page.has_css?("#act-addCollection > div.action-name")
        return "enable"
      else
        return "disable"
      end
    end

  end
end