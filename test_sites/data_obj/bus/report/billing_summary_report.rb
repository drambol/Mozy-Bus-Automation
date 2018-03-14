module Bus
  module DataObj
    # This class contains attributes for billing summary report
    class BillingSummaryReport < Report
      attr_accessor :frequency, :start_date, :is_active, :recipients, :type
      # Public: Initialize a BillingSummaryReport Object
      #
      def initialize
        @type = "Billing Summary"
        @frequency = "Daily"
        @start_date = Time.now.localtime("-06:00").strftime("%Y %B %-d")
        @is_active = true
      end
    end
  end
end