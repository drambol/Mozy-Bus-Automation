module Bus
  module DataObj
    # This class contains attributes for data shuttle order
    class DataShuttleOrder
      attr_accessor :name, :address_1, :address_2, :city, :state, :country, :zip, :phone,  :adapter_type,
                    :os, :quota, :assign_to, :key_from, :notification_msg, :discount, :num_win_drivers, :num_mac_drivers, :ship_driver, :drive_type, :license_key
    end
  end
end
