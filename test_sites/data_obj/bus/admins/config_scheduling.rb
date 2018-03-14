module Bus
  module DataObj
    # This class contains attributes for client configuration
    class ConfigScheduling
      attr_accessor :automatic_max_load, :automatic_min_idle, :automatic_interval
    end
  end
end