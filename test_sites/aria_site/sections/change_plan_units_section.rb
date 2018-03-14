module Aria
  # This class provides actions for Change supplemental plan units section
  class ChangePlanUnitsSection < SiteHelper::Section

    # Private elements
    #
    element(:num_plans_tb, css: 'input[name=inNumUnits]')
    element(:assignment_scope_select, css: 'select#inAssignOptionsIgnore')
    element(:save_plan_btn, css: "input[value='Save Changes']")

    # Public: Change supplemental plan units
    #
    def change_plan_units(new_units, assignment_scope='Assign Immediately')
      num_plans_tb.type_text(new_units)
      assignment_scope_select.select(assignment_scope)
      save_plan_btn.click
    end

  end
end