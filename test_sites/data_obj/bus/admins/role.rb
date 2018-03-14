module Bus
  module DataObj
    # This class contains attributes for add new role
    class Role
      attr_accessor :type, :name, :parent, :user_group

      def initialize(type = nil, name = nil, parent = nil, user_group = nil)
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = name || "AA #{first_name} #{last_name}"
        @parent = parent
        @type = type
        @user_group = user_group
      end
    end
  end
end
