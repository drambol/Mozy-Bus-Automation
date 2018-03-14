module Aria
  # This class provides actions for aria admin console page
  class AdminToolsPage < SiteHelper::Page

    set_url("#{ARIA_ENV['host']}/AdminTools.php")

    # Public: Click link on aira account page top navigation menu
    #
    # Example
    #   @aria_admin_console_page.account_page.navigate_to_link("Account Overview")
    #
    # Returns nothin
    def navigate_to_link(link_name)
      find(:xpath, "//a[@title='#{link_name}']").click
    end

    # Public: Switch to iframe id work_frm
    #
    # Returns nothing
    def switch_to_work_frame
      sleep 5
      switch_to_iframe(%w( outerFrame mainFrame work_frm ))
    end

    # Public: Switch to iframe id inner_work_frm
    #
    # Returns nothing
    def switch_to_inner_work_frame
      sleep 5
      switch_to_iframe(%w( outerFrame mainFrame work_frm inner_work_frm ))
    end
  end
end