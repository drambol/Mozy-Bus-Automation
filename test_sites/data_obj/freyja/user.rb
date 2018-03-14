module Freyja
  module DataObj
    # This class contains attributes for user
    class User
      attr_accessor :partnerType, :keyType, :username,:password,:new_password, :deviceTab, :sync_machineID, :sync_file, :sync_folder, :backup_machineID, :backup_file, :backup_folder, :sync_file_versions, :backup_file_versions, :device_Radio_preference, :restore_queue, :search_file_keyword, :search_folder_keyword, :language

      def initialize
        super
        @partnerType = ""
        @keyType = ""
        @username = ""
        @password = ""
        @deviceTab = ""
        @sync_machineID = ""
        @sync_file = ""
        @sync_folder = ""
        @backup_machineID = ""
        @backup_file = ""
        @backup_folder = ""
        @new_password = ""
        @sync_file_versions = ""
        @backup_file_versions = ""
        @device_Radio_preference = ""
        @restore_queue = ""
        @search_file_keyword = ""
        @search_folder_keyword = ""
        @language = ""
      end

      def to_s
        %{#{super}
        partnerType: #@partnerType
        keyType: #@keyType
        username: #@username
        password: #@password
        deviceTab: #@deviceTab
        sync_machineID: #@sync_machineID
        sync_file: #@sync_file
        sync_folder: #@sync_folder
        new_password: #@new_password
        sync_file_versions: #@sync_file_versions
        backup_file_versions: #@backup_file_versions
        device_Radio_preference: #@device_Radio_preference
        restore_queue: #@restore_queue
        search_file_keyword: #@search_file_keyword
        search_folder_keyword: #@search_folder_keyword
        language: #@language
        }
      end

    end
  end
end
