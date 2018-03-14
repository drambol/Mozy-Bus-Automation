
module Migration
  # This class provides actions for bus login page
  class MigrationSite < SiteHelper::Page

    set_url("#{QA_ENV['migration_url']}")

    # Private elements
    #
    element(:starting_id_tb, id: "a_b_c")
    element(:ending_id_tb, id: "d_e_f")
    element(:submit_btn, css: "span.submit_button")

    # Public: Migrate a partner over to aria
    #
    # starting_id = starting partner id, in single cases:
    #   @partner.partner_id
    # ending_id = last id in series, in single cases - its empty
    #
    # Example
    #   @bus_site.login_page.login('username', 'password')
    #
    # Returns nothing
    def migrate_partner(partner)
      starting_id_tb.type_text(partner.partner_id)
      submit_btn.click
    end

    # function call to wait for output
    def migration_output
      #TODO - ADD CODE THAT CHECKS FOR OUTPUT IN SPECIFIC PANEL ON MIGRATION PAGE
    end

  end
end

