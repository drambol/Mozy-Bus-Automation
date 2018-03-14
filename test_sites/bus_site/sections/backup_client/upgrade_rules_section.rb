require_relative 'upgrade_rules_section_iframe'

module Bus
  # This class provides actions for version upgrade rules section
  class UpgradeRulesSection < SiteHelper::Section

    # Private elements
    #
    iframe(:ur_iframe, UpgradeRulesIframe, :css, 'iframe[name^=iframe_]')


  end
end