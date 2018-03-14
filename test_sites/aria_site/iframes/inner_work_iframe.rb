module Aria
  class InnerWorkIframe < SiteHelper::Iframe

    section(:account_overview_section, AccountOverviewSection, id: 'content-wrapper')
    section(:supplemental_plans_section, SupplementalPlansSection, xpath: '*')
    section(:change_plan_units_section, ChangePlanUnitsSection, xpath: '*')
    section(:save_plan_units_section, SavePlanUnitsSection, xpath: '*')
    section(:notification_method_section, NotificationMethodSection, xpath: '*')
    section(:account_groups_section, AccountGroupsSection, xpath: '*')
    section(:taxpayer_section, TaxpayerSection, xpath: '*')
    section(:account_status_section, AccountStatusSection, xpath: '*')
    section(:form_of_payment_section, FormOfPaymentSection, xpath: '*')

  end
end