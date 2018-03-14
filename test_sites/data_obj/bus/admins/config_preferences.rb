module Bus
  module DataObj
    # This class contains attributes for client configuration
    class ConfigPreferences
      attr_accessor :warning_days, :net_iftype, :ckey, :private_key, :default_key, :web_restores, :enforce_encryption_type, :all_settings, :all_cascades, :all_locks,
                    :kmip_key, :address, :kmip_service_port, :trust_ca, :nae_xml_service_port, :key_group_name
    end
  end
end
