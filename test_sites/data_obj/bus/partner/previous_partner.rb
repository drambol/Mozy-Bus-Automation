module Bus
  module DataObj
    # This class contains attributes for previous created partner
    class PreviousPartner
      def initialize(partner)
        @@partner=partner if partner
      end
      def get_partner_info()
        return @@partner
      end
    end
  end
end