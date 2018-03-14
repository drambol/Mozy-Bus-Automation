module Bus
  # This class provides actions for blocked deprovision section
  class BlockedDeprovision < SiteHelper::Section

    def blocked_deprovision_rule_check(rule)
      log("check the blocked deprovision rule #{rule}")
      find(:xpath, "//td[contains(text(),'#{rule}')]/..//input[@type='checkbox']").check
    end

    def blocked_deprovision_rule_action(action)
      log("click Approve button for the checked Blocked Deprovision rule"); find(:xpath, "//input[@value='Approve']").click if action == "approve"
      log("click Ignore button for the checked Blocked Deprovision rule");find(:xpath, "//input[@value='Ignore']").click if action == "ignore"
      wait_until_bus_section_load
    end

  end
end
