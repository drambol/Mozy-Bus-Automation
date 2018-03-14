module Freyja
  module DataObj
    # This class contains attributes for data shuttle order
    class Restore
      attr_accessor :restore_name, :include_deleted, :restore_date, :restore_type, :num_files, :track_num, :partner_id, :machine_id, :restore_id, :use_company_info, :dvd_to_biz, :address_info, :credit_card, :type

      # Public: Initialize the Restore object
      #
      def initialize
        super
        @type = "files"
        @restore_name = "RestoreAutomation-#{Time.now.strftime("%Y%m%d-%H%M%S")}"
        @track_num = "#{Time.now.strftime("%YD%m%dR%H%M%SCC")}"
        @include_deleted = false
        @restore_date = "#{Time.now.strftime("%m/%d/%Y")}"
        @restore_type = ""
        @num_files = ""
        @partner_id = ""
        @machine_id = ""
        @restore_id = ""
        @use_company_info = true
        @dvd_to_biz = true
        @address_info = AddressInfo.new
        @credit_card = CreditCard.new
      end

      # Public: output mozy home attributes
      #
      # Returns mozy home formatted attributes text
      def to_s
        %{#{super}
        restore_name: #@restore_name
        track_num: #@track_num
        include_deleted: #@include_deleted
        restore_date: #@restore_date
        restore_type: #@restore_type
        num_files: #@num_files
        partner_id: #@partner_id
        machine_id: #@machine_id
        restore_id: #@restore_id
        use_company_info: #@use_company_info
        dvd_to_biz: #@dvd_to_biz
        #{@address_info.to_s}
        #{@credit_card.to_s}}
      end


    end
  end
end
