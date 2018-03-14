module Bus
  module DataObj
    # This class contains attributes for admin information
    class AdminInfo
      attr_accessor :first_name, :last_name, :full_name, :email, :root_role

      # Public: Initialize a AdminInfo Object
      #
      def initialize
        @first_name = Forgery::Name.first_name
        @last_name = Forgery::Name.last_name
        @full_name = "#@first_name #@last_name"
        @email = create_admin_email(@first_name,@last_name)
        @root_role = ""
      end

      # Public: Output AdminInfo object attributes
      #
      # Returns text
      def to_s
        %{admin name: #@full_name
        admin email: #@email
        admin root role: #@root_role}
      end
    end
  end
end
