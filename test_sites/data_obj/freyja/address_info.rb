module Freyja
  module DataObj
    # This class contains attributes for company information
    class AddressInfo
      attr_accessor :name, :address, :city, :state, :zip, :country, :phone

      # Public: Initialize a CompanyInfo Object
      #
      def initialize
        @name = Forgery::Name.full_name
        @address= Forgery::Address.street_address
        @city = Forgery::Address.city
        @state = Forgery::Address.state
        @zip = Random.new.rand(10000..99999).to_s
        @country = "Afghanistan"
        @phone = Forgery::Address.phone
      end

      # Public: Output CompanyInfo object attributes
      #
      # Returns text
      def to_s
        %{name: #@name
        address: #@address
        city: #@city
        state: #@state
        zip: #@zip
        country: #@country
        phone: #@phone}
      end
    end
  end
end
