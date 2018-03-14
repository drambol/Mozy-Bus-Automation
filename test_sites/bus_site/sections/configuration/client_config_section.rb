require_relative 'client_config_section_iframe'
module Bus
  # This class provides actions for add new partner page section
  class ClientConfigSection < SiteHelper::Section

    # Private elements
    #
    iframe(:cc_iframe, ClientConfigIframe, :css, 'iframe[name^=iframe_]')
  end
end
