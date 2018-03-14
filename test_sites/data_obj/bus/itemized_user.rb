module Bus
  module DataObj
    # This class contains attributes for user
    class ItemizedUser
      attr_accessor :name, :email, :user_group, :devices_server, :quota_server, :devices_desktop,
                    :quota_desktop, :enable_stash, :stash_quota, :send_invite

      def initialize
        @name = Forgery::Name.first_name
        @email = create_user_email
      end

    end
  end
end
