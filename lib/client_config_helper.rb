require 'net/https'
require 'base64'

module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

module LinuxBackupSets

  def get_linux_backup_sets_clients (root_admin_id, username, password, machine_hash)
    userhash = Digest::SHA1.hexdigest(root_admin_id.to_s+" "+username.to_s)

    string = "/client/get_config?linux_backup_set=1&machineid=#{machine_hash}"

    uri = URI.parse("https://#{QA_ENV['client_host']}")
    Net::HTTP.start(uri.host, uri.port,
                    :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
      http.set_debug_output $stderr
      req = Net::HTTP::Get.new(string)
      req.basic_auth userhash, password
      response = http.request(req)
      pp response
      @backupsets_from_client = JSON.parse(response.body)['backupsets']
    end
  end
end
