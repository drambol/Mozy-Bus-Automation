module Bus
  module DataObj
    # This class contains attributes for Report object
    class Report
      attr_accessor :name, :recipients, :subject, :email_message
      # Public: Initialize a Report Object
      #
      def initialize
        @name = ""
        @recipients = ""
        @subject = ""
        @email_message = ""
      end
    end
  end
end