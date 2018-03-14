module Bus
  module DataObj
    # This class contains attributes for company information
    class CompanyInfo
      attr_accessor :name, :address, :city, :state_abbrev, :state, :country, :zip, :phone, :vat_num, :security

      # Public: Initialize a CompanyInfo Object
      #
      def initialize
        @name = "#{Forgery::Name.company_name} Company #{Time.now.strftime("%m%d-%H%M-%S")}"
        @address= Forgery::Address.street_address
        @city = Forgery::Address.city
        @state_abbrev = Forgery::Address.state_abbrev
        @state = Forgery::Address.state
        @country = "United States"
        @zip = Random.new.rand(10000..99999).to_s
        @phone = Forgery::Address.phone
        @vat_num = ""
        @security = 'Standard'
      end

      # Public: Output CompanyInfo object attributes
      #
      # Returns text
      def to_s
        %{company name: #@name
        address: #@address
        city: #@city
        state abbrev (for US & CA only): #@state_abbrev
        state: #@state
        country: #@country
        zip: #@zip
        phone: #@phone
        vat_num: #@vat_num
        secruity: #@security}
      end
    end
  end
end
