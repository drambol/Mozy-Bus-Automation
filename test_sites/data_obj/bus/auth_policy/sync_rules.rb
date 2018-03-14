module Bus
  module DataObj
    class SyncRules
      #Class for synchronization rules
      attr_accessor :provision_rules, :deprovision_rules, :schedule, :suspend_user_after,
                    :delete_user_after

      def initialize(provision_rules, deprovision_rules, schedule, suspend_user_after, delete_user_after)
        @provision_rules = provision_rules
        @delete_user_after = delete_user_after
        @schedule = schedule
        @deprovision_rules = deprovision_rules
        @suspend_user_after = suspend_user_after
      end
    end
  end
end