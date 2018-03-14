module Bus
  module DataObj
    # This class contains attributes for reseller partner
    class Reseller < PartnerAccount
      attr_accessor :reseller_type, :reseller_quota, :reseller_add_on_quota, :has_server_plan, :has_stash_grant_plan

      # Public: Initialize a Reseller Object
      #
      def initialize
        super
        @reseller_type = "Silver" # Silver, Gold, Platinum
        @reseller_quota = 0
        @reseller_add_on_quota = 0
        @has_server_plan = false
        @has_stash_grant_plan = false
      end

      # Public: output reseller partner attributes
      #
      # Returns reseller partner formatted attributes text
      def to_s
        %{#{super}
        reseller type: #@reseller_type
        reseller quota: #@reseller_quota
        reseller add-on quota: #@reseller_add_on_quota
        has server plan: #@has_server_plan
        has stash grant plan: #@has_stash_grant_plan}
      end
    end
  end
end