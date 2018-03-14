module Bus
  module DataObj
    # This class contains attributes for itemized user group
    class ItemizedUserGroup
      attr_accessor :name,
                    :desktop_storage_type, :desktop_assigned_quota, :desktop_limited_quota, :desktop_devices,
                    :server_storage_type, :server_assigned_quota, :server_limited_quota, :server_devices,
                    :enable_stash

      def initialize
        @name = "#{Forgery::Name.company_name} Group"
      end
    end
  end
end
