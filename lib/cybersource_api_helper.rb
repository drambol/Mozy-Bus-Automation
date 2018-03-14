require "httparty"
require "savon"

module CybersourceApi

  #################################################################
  # get the user's device information
  # result like:
  # {"stash"=>{"active_devices"=>[]},
  #  "backup"=>{"active_devices"=>[],
  #   "total_devices"=>{"Server"=>0, "Desktop"=>3}}}

  def build_retrieve_request(config, options)
    xml = Builder::XmlMarkup.new :indent => 2
    xml.instruct!
    xml.tag! 's:Envelope', {'xmlns:s' => 'http://schemas.xmlsoap.org/soap/envelope/'} do
      xml.tag! 's:Header' do
        xml.tag! 'wsse:Security', {'s:mustUnderstand' => '1', 'xmlns:wsse' => 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd'} do
          xml.tag! 'wsse:UsernameToken' do
            xml.tag! 'wsse:Username', config["#{options[:country]}"]["login"]
            xml.tag! 'wsse:Password', config["#{options[:country]}"]["key"], 'Type' => 'http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText'
          end
        end
      end
      xml.tag! 's:Body', {'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance', 'xmlns:xsd' => 'http://www.w3.org/2001/XMLSchema'} do
        xml.tag! 'requestMessage', {'xmlns' => 'urn:schemas-cybersource-com:transaction-data-1.123'} do
          xml.tag! 'merchantID', config["#{options[:country]}"]["login"]
          xml.tag! 'merchantReferenceCode', options[:user_query_code]
          xml.tag! 'recurringSubscriptionInfo' do
            xml.tag! 'subscriptionID', options[:cybersource_id]
          end
          xml.tag! 'paySubscriptionRetrieveService', {'run' => 'true'}
        end
      end
    end

    # Log.debug xml.target!

    begin
      response = HTTParty::post("#{config["url"]}", :body=> xml.target!)
      # Log.debug response
      return response
    rescue
      return response
    end
  end
end