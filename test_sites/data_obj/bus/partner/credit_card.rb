module Bus
  module DataObj
    # This class contains attributes for credit card information
    class CreditCard
      attr_accessor :first_name, :last_name, :full_name, :type, :number, :cvv, :cvv2, :expire_month, :expire_year, :last_four_digits

      # Public: Initialize a CreditCard Object
      #
      def initialize
        @first_name = Forgery::Name.first_name
        @last_name = Forgery(:basic).password(:at_least => 6, :at_most => 8)
        @full_name = "#@first_name #@last_name"
        @type = 'Visa'
        @number = Forgery::CreditCard.number(:type => 'Visa', :length => 16, :prefixes => %w"470758 473099 475034 474480 477462").to_s
        @cvv = Random.new.rand(100..999).to_s
        @cvv2 = ''
        @expire_month = Forgery::Date.month(:numerical => true).to_s
        @expire_year = Forgery::Date.year(:future => true, :past => false, :min_delta => 1, :max_delta => 5).to_s
        @last_four_digits = @number[12..-1]
      end

      # Public: Output CreditCard object attributes
      #
      # Returns text
      def to_s
        %{credit card name: #@full_name
        credit card type: #@type
        credit card number: #@number
        credit card cvv: #@cvv
        credit card expire month: #@expire_month
        credit card expire year: #@expire_year
        credit card last four digits: #@last_four_digits}
      end
    end
  end
end