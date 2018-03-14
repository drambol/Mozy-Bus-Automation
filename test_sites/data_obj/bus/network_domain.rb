module Bus
  module DataObj
    class NetworkDomain
      attr_accessor :nd_alias, :guid, :ou, :user_group, :key_type
      def initialize
        @nd_alias = ""
        @guid = "#{Time.now.strftime("%m%d%H%M")}-9ABC-DEF0-#{Time.now.strftime("%H%M")}-56789ABCDEF0"
        @ou = ""
        @user_group = ""
      end
    end
  end
end