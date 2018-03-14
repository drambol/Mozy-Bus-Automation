module Bus
  module DataObj
    class ConnectionInfo
      # Class for connection information
      attr_accessor :server_host, :protocol, :ssl_cert, :port,
                    :base_dn, :bind_user, :bind_password, :org_name
      attr_reader :current_status, :last_sync, :next_sync

      def initialize
        #TODO
      end

    end
  end
end