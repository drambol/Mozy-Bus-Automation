# Testlink API
# API docs for testlink 1.9.3 can be found http://jetmore.org/john/misc/phpdoc-testlink193-api/TestlinkAPI/TestlinkXMLRPCServer.html

require 'xmlrpc/client'

module TestlinkHelper
  class TestlinkAPIClient
    #SERVER_URL = "http://10.5.96.38/testlink/lib/api/xmlrpc/v1/xmlrpc.php"
    SERVER_URL = "http://testlink.mozy.lab.emc.com/lib/api/xmlrpc/v1/xmlrpc.php"
    API_KEY = "1dd1566e684d80245d4843da916e8b47"   # dev key can be found in "My Settings" when you have logged in testlink
    def initialize(dev_key = API_KEY)
      @server = XMLRPC::Client.new2(SERVER_URL)
      @devKey = dev_key
    end

    def run_api(api, args)
      args['devKey'] ||= @devKey
      @server.call("tl.#{api}", args)
    end
  end
end

