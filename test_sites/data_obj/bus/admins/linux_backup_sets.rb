module Bus
  module DataObj
    # This class contains attributes for client configuration
    class LinuxBackupSets
      attr_accessor :backup_name, :search_locations, :rules, :exclusionary
      def initialize
        @backup_name = ""
        @search_locations = []
        @rules = []
      end
    end
  end
end
