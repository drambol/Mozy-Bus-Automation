module Bus
  module DataObj
    # This class contains attributes for client configuration
    class ClientConfig
      attr_accessor :name, :type, :throttle, :throttle_amount, :user_group

      def initialize
        @name = ""
        @type = ""
        @throttle = false
        @throttle_amount = 0
        @user_group = ""
      end
    end
  end
end
