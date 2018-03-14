module Bus
  module DataObj
    # This class contains attributes for mozy pro partner
    class SubPartner
      attr_accessor :company_name, :pricing_plan, :admin_name, :admin_email_address, :root_role, :security, :company_type

      # Public: Initialize a MozyPro Object
      #
      def initialize(hash)
        default = {company_name:"#{Forgery::Name.company_name} Sub Partner #{Time.now.strftime("%m%d-%H%M-%S")}", admin_name:Forgery::Name.full_name, admin_email_address:create_user_email, security:'Standard'}
        default.merge(hash).each do |k, v|
          self.instance_variable_set "@#{k}", v
        end
      end
    end
  end
end
