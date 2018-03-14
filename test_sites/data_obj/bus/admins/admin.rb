module Bus
  module DataObj
    # This class contains attributes for add new admin
    class Admin
      attr_accessor :name, :email, :parent, :user_groups, :roles, :num_desktop_licenses, :desktop_quota, :id

      def initialize(name, email, parent, user_groups, roles)
        first_name = Forgery::Name.first_name
        last_name = Forgery::Name.last_name
        @name = name || "#{first_name} #{last_name}"
        @email = email || create_admin_email(first_name,last_name)
        @parent = parent || 0
        @user_groups = user_groups || []
        @roles = roles || []
        @num_desktop_licenses = 0
        @desktop_quota = 0
        @id = ''
      end
    end
  end
end
