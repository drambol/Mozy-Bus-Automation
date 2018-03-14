module Bus
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :name, :email, :user_group, :storage_type, :storage_limit, :devices, :enable_stash, :send_email

      def initialize
        @name = Forgery::Name.first_name
        @email = create_user_email
      end

    end
  end
end
