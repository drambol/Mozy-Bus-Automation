module Aria
  # This class provides actions for supplemental plans section
  class SupplementalPlansSection < SiteHelper::Section

    # Private elements
    #
    element(:plans_table, css: "table.data-table")
    element(:message_div, css: "div.error-box")

    # Public:
    #
    def active_plans_table_rows
      plans_table.rows_text.select{ |row| row[3].include?('Active') }
    end

    def view_plan_units_details(target_plan)
      target =  plans_table.rows.select{ |row| row[1].text.include?(target_plan) }.first
      # Click plan units link
      target[2].find(:css,"a").click
    end

    def messages
      message_div.text
    end

  end
end