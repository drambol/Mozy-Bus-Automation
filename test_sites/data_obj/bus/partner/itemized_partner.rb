module Bus
  module DataObj
    # This class contains attributes for mozy pro partner
    class MozyItemized < PartnerAccount
      attr_accessor :server_license_discount, :server_quota_discount, :desktop_license_discount, :desktop_quota_discount, :server_licenses, :server_quota, :desktop_licenses, :desktop_quota, :partner_id

      # Public: Initialize a MozyItemized Object
      #
      def initialize
        super
        @server_license_discount = ""
        @server_quota_discount = ""
        @desktop_license_discount = ""
        @desktop_quota_discount = ""
        @server_licenses = ""
        @server_quota = ""
        @desktop_licenses = ""
        @desktop_quota = ""
        @partner_id = ""
      end

      # Public: output mozy itemized partner attributes
      #
      # Returns mozy itemized formatted attributes text
      def to_s
        %{#{super}
        server_license_discount: #@server_license_discount
        server_quota_discount: #@server_quota_discount
        desktop_license_discount: #@desktop_license_discount
        desktop_quota_discount: #@desktop_quota_discount
        server_licenses: #@server_licenses
        server_quota: #@server_quota
        desktop_licenses: #@desktop_licenses
        desktop_quota: #@desktop_quota
        partner_id: #@partner_id}
      end
    end
  end
end