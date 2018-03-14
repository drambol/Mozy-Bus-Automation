module Bus
  # This class provides actions for change billing period section
  class ChangePeriodSection < SiteHelper::Section

    # Private elements
    #
    element(:continue_btn, xpath: "//input[@value='Continue']")
    element(:price_table, xpath: "//div[@id='billing_change_confirmation']/table")
    element(:message_div, xpath: "//div[@id='resource-change_billing_period-errors']/ul")
    elements(:confirmation_p, xpath: "//div[@id='billing_change_confirmation']/p")
    element(:change_billing_table, xpath: "//div[@id='billing_change']/table")

    # Public: Move with subscription period
    #
    # Example
    #   @bus_admin_console_page.change_period_section.change_subscription_to("MozyPro annual billing period")
    #
    # Returns nothing
    def change_subscription_to(link_text)
      find_link(link_text).click
      sleep 5 # force to wait due to slow internet connection
    end

    def continue_change_subscription
      continue_btn.click if continue_btn.visible?
      wait_until_bus_section_load
    end

    # Public: Change subscription period confirmation text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.confirmations
    #   # => "Are you sure that you want to change your subscription period from yearly to 3-year billing? ... ...
    #         If you choose to continue, your account ... ...
    #         Any resources you scheduled for return in your next subscription ...."
    #
    # Returns confirmation text array
    def confirmations
      confirmation_p.map{ |p| p.text.strip }
    end

    # Public: Messages for change subscription period actions
    #
    # Example
    #  @bus_admin_console_page.change_period_section.messages
    #  # => "Your account has been changed to yearly billing."
    #
    # Returns success or error message text
    def messages
      wait_until_bus_section_load
      message_div.text
    end

    # Public: Change subscription period price table header text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.price_table_header
    #   # => ["Description", "Amount"]
    #
    # Returns price table header text
    def price_table_headers
      price_table.all(:xpath, "./thead/tr/th").map { |cell| cell.text }
    end

    # Public: Change subscription period price table rows text
    #
    # Example
    #   @bus_admin_console_page.change_period_section.price_table_header
    #   # => [["Credit for remainder of monthly subscription", "$42.00"],
    #         ["Charge for new yearly subscription", "$420.00"]
    #         ["Total amount to be charged", "$420.00"]]
    #
    #
    # Returns price table rows text
    def price_table_rows
      rows = price_table.all(:xpath, "./tbody/tr").map{ |row| row.child }
      rows.map { |row| row.map { |cell| cell.text } }
    end

    # Public: Change billing period table rows
    #
    # Example
    #   @bus_admin_console_page.change_period_section.change_billing_table_rows
    #   # => [["Monthly Cost", "$94.99 *", "You are currently using this plan."],
    #         ["Annual Cost", "$729.89 *", "Switch to annual billing (includes 1 free month!)"]
    #         ["Biennial Cost", "$1,399.79 *", "Switch to biennial billing (includes 5 free months!)"]]
    #
    # Returns price table rows text
    def change_billing_table_rows
      wait_until { !locate(:xpath, "//div[@id='billing_change']/table").nil? }
      rows = change_billing_table.all(:xpath, "./tbody/tr").map{ |row| row.child }
      rows.map { |row| row.map { |cell| cell.text.strip } }
    end

  end
end
