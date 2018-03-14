require 'net/https'
require 'base64'
include KeylessDeviceActivation

module ClientUserResources

  # get the user's device information
  # reslut like:
  # {"stash"=>{"active_devices"=>[]},
  #  "backup"=>{"active_devices"=>[],
  #   "total_devices"=>{"Server"=>0, "Desktop"=>3}}}

  def get_client_user_resources(user_email, user_password, partner_id, partner_name, access_token = nil)
    client_id = 'win'
    client_secret = 't28i56FCR3AkBneF'
    if access_token.nil?
      client = KeylessClient.new(user_email, user_password, partner_id, partner_name, '', '', client_id, client_secret)
      response_access_token = client.get_access_token
      access_token = response_access_token["access_token"]
    end

    uri = URI.parse("#{QA_ENV['bus_host']}")
      Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
        url =  "/client/user/resources"
        request = Net::HTTP::Get.new(url)
        request.add_field("Authorization", "Bearer #{Base64.strict_encode64(access_token)}")
        response = http.request request
        begin
          body = JSON.parse(response.body)
          Log.debug body
          return body
        rescue
          return response.body
        end
      end
   end
end
