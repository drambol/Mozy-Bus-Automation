module Bus

  class ReplaceMachineSection < SiteHelper::Section

    # replace machine
    element(:replace_submit_btn, xpath: "//input[@value='Submit']")
    element(:replace_password_input, id: "passwd_check")
    elements(:replace_machine_list_td, xpath: "//form[@id='replace-machine-list']//table//tr/td[2]/a")
    element(:replace_back_btn, xpath:"//input[@value='Back']")
    element(:replace_machine_error_msg, xpath: "//ul[@class='flash errors']/li")

    #==========================================
    # Public  :   replace machine with specified machine. If replaced with a unqualified machine, click back to the previous machine list page.
    #
    # @machine_name : machine name seen on web
    ##==========================================
    def replace_machine(machine_name)
      password =  QA_ENV['bus_password']
      find(:xpath, "//a[text()='#{machine_name}']/../../td[1]/input").click
      replace_submit_btn.click
      begin
        replace_password_input.type_text(password)
        replace_submit_btn.click
      rescue
        find(:xpath, "//ul[@class='flash errors']")
        Log.debug "======relpace failed======"
        replace_back_btn.click
      end
    end

    def get_replace_machine_list
      replace_machine_list_td.map{|td|td.text}
    end

    def get_replace_machine_error_msg
      replace_machine_error_msg.text
    end

  end
end
