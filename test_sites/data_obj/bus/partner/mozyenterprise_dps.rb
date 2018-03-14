module Bus
  module DataObj
    # This class contains attributes for mozy enterprise partner
    class MozyEnterpriseDPS < PartnerAccount
      attr_accessor :base_plan

      # Public: Initialize a MozyEnterprise Object
      #
      def initialize
        super
        #partner_info.type = Bus::COMPANY_TYPE[:mozyenterprise]
        @base_plan = 0
      end

      # Public: output mozy enterprise partner attributes
      #
      # Returns mozy enterprise partner formatted attributes text
      def to_s
        %{#{super}
        server add-on: #@base_plan}
      end
    end
  end
end

