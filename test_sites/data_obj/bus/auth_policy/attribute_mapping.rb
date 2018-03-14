module Bus
  module DataObj
    class AttributeMapping
      # Class for attribute mapping data structure
      attr_accessor :username, :name, :fixed_attr

      def initialize(username = 'email', name = 'cn', fixed_attr = nil)
        @username = username
        @name = name
        @fixed_attr = fixed_attr
      end
    end
  end
end