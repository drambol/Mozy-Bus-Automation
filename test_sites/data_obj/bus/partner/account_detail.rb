module Bus
  module DataObj
    # This class contains attributes for admin information
    class AccountDetail
      attr_accessor :account_type, :sales_origin, :sales_channel

      # Public: Initialize a AccountDetail Object
      #
      def initialize
        @account_type = "Internal Test"
        @sales_origin = "Sales"
        @sales_channel = "Inside Sales"
      end

      # Public: Output AdminInfo object attributes
      #
      # Returns text
      def to_s
        %{account_type: #@account_type
        sales origin: #@sales_origin
        sales channel: #@sales_channel}
      end
    end
  end
end
