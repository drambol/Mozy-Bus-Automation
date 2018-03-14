module Bus
  module DataObj
    # This class contains attributes for partner account information
    class PartnerAccount
      attr_accessor :company_info, :partner_info, :admin_info, :billing_info, :account_detail, :use_company_info,
                    :subscription_period, :has_initial_purchase, :credit_card, :net_term_payment, :pre_sub_total,
                    :order_summary

      # Public: Initialize a PartnerAccount Object
      #
      def initialize
        @company_info = CompanyInfo.new
        @partner_info = PartnerInfo.new
        @billing_info = BillingInfo.new
        @admin_info = AdminInfo.new
        @account_detail = AccountDetail.new
        @use_company_info = true
        @subscription_period = 1
        @has_initial_purchase = true
        @credit_card = CreditCard.new
        @net_term_payment = false
        @pre_sub_total = ""
        @order_summary = []
      end

      # Public: Output partner account attributes
      #
      # Returns text
      def to_s
        %{
        #{@company_info.to_s}
        #{@partner_info.to_s}
        #{@admin_info.to_s}
        #{@acccount_detail.to_s}
        #{@credit_card.to_s}
        use company info: #@use_company_info
        subscription period: #@subscription_period
        has initial purchase: #@has_initial_purchase
        net term payment: #@net_term_payment}
      end

      # Public: deep clone the partner with its own copy of BillingInfo.billing info
      #
      # Return the new object copy
      def deep_clone
        copy = self.clone
        copy.company_info = self.company_info.clone
        copy.partner_info = self.partner_info.clone
        copy.admin_info = self.admin_info.clone
        copy.credit_card = self.credit_card.clone
        copy.account_detail = self.account_detail.clone
        copy.order_summary = self.order_summary.clone
        copy.billing_info = self.billing_info.clone
        copy.billing_info.billing = self.billing_info.billing.clone
        copy
      end
    end
  end
end
