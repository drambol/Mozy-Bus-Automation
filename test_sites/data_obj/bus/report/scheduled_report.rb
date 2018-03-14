module Bus
  module DataObj
    # This class contains attributes for common scheduled report
    class ScheduledReport < Report
      attr_accessor :frequency, :start_date, :is_active, :recipients, :type, :threshold
      # Public: Initialize a common scheduled report Object
      #
      def initialize
        @frequency = "Daily"
        @is_active = true
      end
    end
  end
end