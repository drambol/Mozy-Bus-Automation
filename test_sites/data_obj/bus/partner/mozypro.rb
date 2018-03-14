module Bus
  module DataObj
    # This class contains attributes for mozy pro partner
    class MozyPro < PartnerAccount
      attr_accessor :base_plan, :has_server_plan, :has_stash_grant_plan, :storage_add_on, :storage_add_on_50_gb

      # Public: Initialize a MozyPro Object
      #
      def initialize
        super
        @base_plan = ""
        @has_server_plan = false
        @has_stash_grant_plan = false
        @storage_add_on = 0
        @storage_add_on_50_gb = 0
      end

      # Public: output mozy pro partner attributes
      #
      # Returns mozy pro partner formatted attributes text
      def to_s
        %{#{super}
        base plan: #@base_plan
        has server plan: #@has_server_plan
        has stash grant plan: #@has_stash_grant_plan
        storage add on: #@storage_add_on
        storage add on 50 gb: #@storage_add_on_50_gb}
      end
    end
  end
end