module Bus
  module DataObj
    # This class contains attributes for Email Alerts
    class EmailAlerts
      attr_accessor :subject_line, :frequency, :report_modules, :scope, :recipients, :percent_quota_used

      def initialize
        @subject_line = ""
        @frequency = "daily"
        @report_modules = []
        @percent_quota_used = ""
        @scope = "All User Groups and Subpartners"
        @recipients = []
      end

    end
  end
end