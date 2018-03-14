module Aria
  # This class provides actions for Change supplemental plan units section
  class SavePlanUnitsSection < SiteHelper::Section

    # Private elements
    #
    element(:save_plan_btn, css: "input[value='Save Changes']")

    # Public: Change supplemental plan units
    #
    def save_plan_units
      save_plan_btn.click
    end

  end
end