module Bus
  module DataObj
    # This class contains attributes for mozy home account
    # 	rather than re-invent new object versions whereever possible we will be
    #	reusing partner objects, which alos will give us latitude in conversions, etc.
    class MozyHome < PartnerAccount
      attr_accessor :base_plan, :has_server_plan, :has_stash, :additional_computers, :additional_storage,
                    :plan_summary, :billing_summary, :curplan_payment_summary

      # Public: Initialize a MozyHome Object
      #
      def initialize
        super
        @base_plan = ""
        @has_server_plan = false
        @has_stash = false
        @additional_computers = ""
        @additional_storage = ""
        @plan_summary = {}
        @billing_summary = []
        @curplan_payment_summary = ""
      end

      # Public: output mozy home attributes
      #
      # Returns mozy home formatted attributes text
      def to_s
        %{#{super}
        base plan: #@base_plan
        has_server_plan: #@has_server_plan
        has_stash: #@has_stash
        additional_computers: #@additional_computers
        additional_storage:#@additional_storage
        curplan_payment_summary:#@curplan_payment_summary}
      end
    end
  end
end